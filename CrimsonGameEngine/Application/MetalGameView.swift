import MetalKit

class MetalGameView: MTKView {    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        self.clearColor = MTLClearColor(red: 0.73, green: 0.23, blue: 0.35, alpha: 1.0)
        self.colorPixelFormat = .bgra8Unorm
        
        let serviceLocator = ServiceLocator.shared
        serviceLocator.provide(renderer: StandardRenderer(self))
        self.delegate = serviceLocator.getRenderer()
    }
}
