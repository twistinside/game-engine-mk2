//
//  Debug Input Controller.swift
//  CrimsonGameEngine
//
//  Created by Karl Groff on 1/9/22.
//

import Foundation

class DebugInputController: InputController {
    var keysDown: Set<KeyboardControl> = []
    let backingInputController = StandardInputController()
    
    func processKeyEvent(_ key: KeyboardControl, state: InputState) {
        print("Key input received \(key)")
        print("Key is in \(state)")
        backingInputController.processKeyEvent(key, state: state)
    }
    
    
}
