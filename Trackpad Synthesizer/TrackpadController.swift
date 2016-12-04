//
//  TrackpadController.swift
//  Trackpad Synthesizer
//
//  Created by Victor Wang on 12/4/16.
//  Copyright © 2016 Victor Wang. All rights reserved.
//

import Foundation
import Cocoa

class TrackpadController: NSView {
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect);
        self.acceptsTouchEvents = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
