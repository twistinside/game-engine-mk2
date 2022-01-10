// This class is based on reading done at https://gameprogrammingpatterns.com/service-locator.html

class ServiceLocator {
    static let shared = ServiceLocator()
    
    private init() {
        // Do nothing
    }
    
    private var renderer: Renderer = NullRenderer()
    private var inputController: InputController = NullInputController()
    
    func getRenderer() -> Renderer {
        return renderer
    }
    
    func provide(renderer: Renderer) {
        self.renderer = renderer
    }
    
    func getInputControllet() -> InputController {
        return inputController
    }
    
    func provide(inputController: InputController) {
        self.inputController = inputController
    }
}
