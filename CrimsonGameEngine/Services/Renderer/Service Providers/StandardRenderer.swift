import MetalKit
import simd

class StandardRenderer: NSObject, Renderer {
    var device: MTLDevice? = MTLCreateSystemDefaultDevice()
    var commandQueue: MTLCommandQueue?
    var renderPipelineState: MTLRenderPipelineState?
    var uniforms: Uniforms = Uniforms()
    
    let triangle = Triangle()
    
    override init() {
        self.commandQueue = device?.makeCommandQueue()
        uniforms.viewMatrix = matrix_identity_float4x4
        super.init()
    }
}

extension StandardRenderer: MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        // TODO: Respond to window resize
    }
    
    func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable,
              let renderPassDescriptor = view.currentRenderPassDescriptor,
              let commandBuffer = commandQueue!.makeCommandBuffer(),
              let renderCommandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        else {
            return
        }
        
        let library = device?.makeDefaultLibrary()
        let vertexFunction = library?.makeFunction(name: "basicVertexShader")
        let fragmentFunction = library?.makeFunction(name: "basicFragmentShader")
        
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        renderPipelineDescriptor.vertexFunction = vertexFunction
        renderPipelineDescriptor.fragmentFunction = fragmentFunction
        
        do {
            renderPipelineState = try device?.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
        } catch let error {
            fatalError(error.localizedDescription)
        }
        
        let vertexBuffer = device?.makeBuffer(bytes: triangle.vertices, length: MemoryLayout<float3>.stride * triangle.vertices.count, options: [])
        
        renderCommandEncoder.setRenderPipelineState(renderPipelineState!)
        renderCommandEncoder.setVertexBytes(&uniforms, length: MemoryLayout<Uniforms>.stride, index: 0)
        renderCommandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 1)
        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: triangle.vertices.count)
        renderCommandEncoder.endEncoding()
        
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
}
