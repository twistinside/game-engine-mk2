import MetalKit

class MetalGameView: MTKView {
    
    var commandQueue: MTLCommandQueue?
    var renderPipelineState: MTLRenderPipelineState?
    
    let vertices: [float3] = [
        float3( 0, 1, 0), // Top middle
        float3(-1,-1, 0), // Bottom left
        float3( 1,-1, 0)  // Bottom right
    ]
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        self.device = MTLCreateSystemDefaultDevice()
        self.clearColor = MTLClearColor(red: 0.73, green: 0.23, blue: 0.35, alpha: 1.0)
        self.colorPixelFormat = .bgra8Unorm
        self.commandQueue = device?.makeCommandQueue()
        
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
    }
    
    override func draw(_ dirtyRect: NSRect) {
        guard let drawable = self.currentDrawable,
              let renderPassDescriptor = self.currentRenderPassDescriptor,
              let commandBuffer = commandQueue!.makeCommandBuffer(),
              let renderCommandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        else {
            return
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
