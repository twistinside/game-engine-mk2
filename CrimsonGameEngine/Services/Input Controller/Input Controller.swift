protocol InputController {
    var keysDown: Set<KeyboardControl> { get }
    
    func processKeyEvent(_ key: KeyboardControl, state: InputState)
}
