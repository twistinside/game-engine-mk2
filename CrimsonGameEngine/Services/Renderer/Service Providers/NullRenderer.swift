import MetalKit

class NullRenderer: NSObject, Renderer {
    let device: MTLDevice
    let uniforms: Uniforms = Uniforms()
    
    override init() {
        guard let device = MTLCreateSystemDefaultDevice() else {
                  fatalError("Could not initialize default device.")
              }
        self.device = device
    }
}

extension NullRenderer: MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        // Do nothing
    }
    
    func draw(in view: MTKView) {
        // Do nothing
    }
}
