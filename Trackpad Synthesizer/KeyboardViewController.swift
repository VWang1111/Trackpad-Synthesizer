//
//  KeyboardViewController.swift
//  Trackpad Synthesizer
//
//  Created by Victor Wang on 12/4/16.
//  Copyright © 2016 Victor Wang. All rights reserved.
//

import Cocoa
import AudioKit

class KeyboardViewController: NSViewController, AKKeyboardDelegate {
    
    let bank = AKOscillatorBank()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AudioKit.stop()
        
        let keyboard = AKKeyboardView(width: 440, height: 100)
        keyboard.delegate = self
        view.addSubview(keyboard)
        
        keyboard.polyphonicMode = true
        
        AudioKit.output = bank
        AudioKit.start()
    }
    
    func noteOn(note: MIDINoteNumber) {
        print("start "+String(note))
        bank.play(noteNumber: note, velocity: 80)
        AudioKit.start()
    }
    
    func noteOff(note: MIDINoteNumber) {
        print("stop " + String(note))
        bank.stop(noteNumber: note)
        AudioKit.start()
    }
    
}

