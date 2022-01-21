import MetalKit
import simd

class StandardRenderer: NSObject, Renderer {    
    var device: MTLDevice
    var commandQueue: MTLCommandQueue
    var library: RenderLibrary
    var uniforms: Uniforms = Uniforms()
    
    let triangle = Triangle()
    
    override init() {
        guard let device = MTLCreateSystemDefaultDevice(),
              let commandQueue = device.makeCommandQueue() else {
                  fatalError("Could not initialize default device.")
              }
        self.device = device
        self.commandQueue = commandQueue
        self.library = RenderLibrary(device: device)
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
              let commandBuffer = commandQueue.makeCommandBuffer(),
              let renderCommandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor) else {
            fatalError()
        }
        
        let vertexBuffer = device.makeBuffer(bytes: triangle.vertices, length: MemoryLayout<float3>.stride * triangle.vertices.count, options: [])
        
        renderCommandEncoder.setRenderPipelineState(library.getRenderPipelineState(for: .basic))
        renderCommandEncoder.setVertexBytes(&uniforms, length: MemoryLayout<Uniforms>.stride, index: 0)
        renderCommandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 1)
        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: triangle.vertices.count)
        renderCommandEncoder.endEncoding()
        
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
}
