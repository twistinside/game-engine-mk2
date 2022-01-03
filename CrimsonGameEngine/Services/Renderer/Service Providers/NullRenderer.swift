import MetalKit

class NullRenderer: NSObject, Renderer {
    // Empty
}

extension NullRenderer: MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        // Do nothing
    }
    
    func draw(in view: MTKView) {
        // Do nothing
    }
}
