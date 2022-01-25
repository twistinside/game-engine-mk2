import MetalKit
import simd

class StandardRenderer: NSObject, Renderer {    
    let device: MTLDevice
    let commandQueue: MTLCommandQueue
    
    var library: RenderLibrary
    var uniforms: Uniforms = Uniforms()
    var meshes: [MTKMesh] = []
        
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
        
        let cube = Cube()
        
        renderCommandEncoder.setVertexBytes(&uniforms, length: MemoryLayout<Uniforms>.stride, index: 0)
        cube.render(renderCommandEncoder: renderCommandEncoder)
        renderCommandEncoder.endEncoding()
        
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
}
