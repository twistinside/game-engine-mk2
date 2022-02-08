import MetalKit
import simd

class StandardRenderer: NSObject, Renderer {    
    let device: MTLDevice
    let commandQueue: MTLCommandQueue
    
    var uniforms: Uniforms = Uniforms()
    var camera: Camera?
    var cube: Cube?
        
    override init() {
        guard let device = MTLCreateSystemDefaultDevice(),
              let commandQueue = device.makeCommandQueue() else {
                  fatalError("Could not initialize default device.")
              }
        self.device = device
        self.commandQueue = commandQueue
        uniforms.projectionMatrix = matrix_identity_float4x4
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
        
        if let unwrapped = camera {
            unwrapped.update(deltaTime: 1/Float(view.preferredFramesPerSecond))
            uniforms.viewMatrix = unwrapped.viewMatrix
        } else {
            camera = Camera()
            camera!.update(deltaTime: 1/Float(view.preferredFramesPerSecond))
            uniforms.viewMatrix = camera!.viewMatrix
        }
        
        renderCommandEncoder.setVertexBytes(&uniforms, length: MemoryLayout<Uniforms>.stride, index: 0)
        
        if let unwrapped = cube {
            unwrapped.update(deltaTime: 1/Float(view.preferredFramesPerSecond))
            unwrapped.render(renderCommandEncoder: renderCommandEncoder)
        } else {
            cube = Cube()
            cube!.update(deltaTime: 1/Float(view.preferredFramesPerSecond))
            cube!.render(renderCommandEncoder: renderCommandEncoder)
        }
        
        renderCommandEncoder.endEncoding()
        
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
}
