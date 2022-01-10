//
//  AppDelegate.swift
//  CrimsonGameEngine
//
//  Created by Karl Groff on 1/2/22.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        let serviceLocator = ServiceLocator.shared
        serviceLocator.provide(inputController: DebugInputController())
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }


}

