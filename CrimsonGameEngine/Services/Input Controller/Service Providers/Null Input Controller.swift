//
//  NullKeyboard.swift
//  CrimsonGameEngine
//
//  Created by Karl Groff on 1/9/22.
//

class NullInputController: InputController {
    var keysDown: Set<KeyboardControl> = []
    
    func processKeyEvent(_ key: KeyboardControl, state: InputState) {
        // Do nothing
    }
}
