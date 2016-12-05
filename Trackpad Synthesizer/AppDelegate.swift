//
//  AppDelegate.swift
//  Trackpad Synthesizer
//
//  Created by Victor Wang on 12/4/16.
//  Copyright © 2016 Victor Wang. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        NSApplication.shared().windows[0].styleMask.update(with: NSWindowStyleMask.resizable)
        
        let frame = NSApplication.shared().windows[0]
        frame.setContentSize(NSSize(width: 440, height: 210))
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}

