import MetalKit

class NullRenderer: NSObject, Renderer {
    let device: MTLDevice? = nil
    let uniforms: Uniforms = Uniforms()
}

extension NullRenderer: MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        // Do nothing
    }
    
    func draw(in view: MTKView) {
        // Do nothing
    }
}
