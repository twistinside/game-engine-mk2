// This class is based on reading done at https://gameprogrammingpatterns.com/service-locator.html

class ServiceLocator {
    static let shared = ServiceLocator()
    
    private(set) var renderer: Renderer
    private(set) var library: Library
    private(set) var inputController: InputController
    
    private init() {
        self.renderer = StandardRenderer()
        self.library = Library(device: renderer.device)
        self.inputController = StandardInputController()
    }
}
