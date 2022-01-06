import MetalKit

class StandardRenderer: NSObject, Renderer {
    var device: MTLDevice?
    var commandQueue: MTLCommandQueue?
    var renderPipelineState: MTLRenderPipelineState?
    
    let vertices: [float3] = [
        float3( 0, 1, 0), // Top middle
        float3(-1,-1, 0), // Bottom left
        float3( 1,-1, 0)  // Bottom right
    ]
    
    init(_ view: MTKView) {
        self.device = MTLCreateSystemDefaultDevice()
        view.device = self.device
        self.commandQueue = device?.makeCommandQueue()
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
        
        let vertexBuffer = device?.makeBuffer(bytes: vertices, length: MemoryLayout<float3>.stride * vertices.count, options: [])
        
        renderCommandEncoder.setRenderPipelineState(renderPipelineState!)
        renderCommandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count)
        renderCommandEncoder.endEncoding()
        
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
}
