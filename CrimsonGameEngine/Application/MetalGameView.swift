import MetalKit

class MetalGameView: MTKView {
    var renderer: Renderer?
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        self.device = MTLCreateSystemDefaultDevice()
        self.clearColor = MTLClearColor(red: 0.73, green: 0.23, blue: 0.35, alpha: 1.0)
        self.colorPixelFormat = .bgra8Unorm
        self.renderer = StandardRenderer(self)
        self.delegate = renderer
    }
}
