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
    var nextVelocity = 0.0
    @IBOutlet weak var velocityIndicator: NSLevelIndicator!
    @IBOutlet weak var velocityTextField: NSTextField!
    
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
        bank.play(noteNumber: note, velocity: Int(nextVelocity))
        AudioKit.start()
    }
    
    func noteOff(note: MIDINoteNumber) {
        print("stop " + String(note))
        bank.stop(noteNumber: note)
        AudioKit.start()
    }
    
    @IBAction func acceleratorChanged(_ sender: NSButton) {
        if sender.doubleValue >= 1 {
            nextVelocity = (sender.doubleValue - 1.0) * 100.0
            velocityIndicator.integerValue = Int(nextVelocity)
            velocityTextField.stringValue = String(Int(nextVelocity))
        }
    }
}

