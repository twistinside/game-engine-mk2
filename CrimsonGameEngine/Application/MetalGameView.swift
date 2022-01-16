import MetalKit

class MetalGameView: MTKView {
    let serviceLocator = ServiceLocator.shared
    required init(coder: NSCoder) {
        super.init(coder: coder)
        self.clearColor = MTLClearColor(red: 0.73, green: 0.23, blue: 0.35, alpha: 1.0)
        self.colorPixelFormat = .bgra8Unorm
        self.delegate = serviceLocator.renderer
        self.device = serviceLocator.renderer.device
    }
}

// MARK: - Keyboard handling
extension MetalGameView {
    override var acceptsFirstResponder: Bool {
        return true
    }
    
    override func keyDown(with event: NSEvent) {
        guard let key = KeyboardControl(rawValue: event.keyCode) else {
            return
        }
        let state: InputState = event.isARepeat ? .continued : .began
        serviceLocator.inputController.processKeyEvent(key, state: state)
    }
    
    override func keyUp(with event: NSEvent) {
        guard let key = KeyboardControl(rawValue: event.keyCode) else {
            return
        }
        serviceLocator.inputController.processKeyEvent(key, state: .ended)
    }
}
