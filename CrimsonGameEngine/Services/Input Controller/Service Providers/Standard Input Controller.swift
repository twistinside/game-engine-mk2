//
//  Standard Keyboard.swift
//  CrimsonGameEngine
//
//  Created by Karl Groff on 1/9/22.
//

import Foundation

class StandardInputController: InputController {
    var keysDown: Set<KeyboardControl> = []
    
    func processKeyEvent(_ key: KeyboardControl, state: InputState) {
        if state == .began {
            keysDown.insert(key)
        }
        if state == .ended {
            keysDown.remove(key)
        }
    }
}
