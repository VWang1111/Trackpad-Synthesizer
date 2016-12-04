//
//  ViewController.swift
//  Trackpad Synthesizer
//
//  Created by Victor Wang on 12/4/16.
//  Copyright © 2016 Victor Wang. All rights reserved.
//

import Cocoa
import AudioKit

class ViewController: NSViewController {
    
    @IBOutlet var trackpadControllerView: TrackpadController!
    
    @IBOutlet weak var pressureIndicator: NSLevelIndicator!
    @IBOutlet weak var frequencyDisplay: NSTextField!
    @IBOutlet weak var harmonicIndicator: NSLevelIndicator!
    
    
    
    
    var oscillator = AKOscillator()
    var mixer = AKMixer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mixer = AKMixer(oscillator)
        AudioKit.output = mixer
        AudioKit.start()
        oscillator.start()
        mixer.volume = 1.0
        mixer.start()
        
        //addSubview(AKOutputWaveformPlot.createView())
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @available(OSX 10.12.1, *)
    func touchesBegan(touches: NSSet!, withEvent event: NSEvent!) {
        
        var testLabelString = ""
        for touchEvent in touches {
            let touch = touchEvent as! NSTouch
            let touchLocation = touch.location(in: self.view)
            
            testLabelString.append(touchLocation.debugDescription)
        }
        
        
        //testLabel.stringValue = testLabelString
    }
    
    @IBAction func acceleratorChanged(_ sender: NSButton) {
        
        if sender.title == "Amplitude"{
            if sender.doubleValue >= 1 {
                pressureIndicator.integerValue = Int((sender.doubleValue - 1.0) * 1000.0)
                
                oscillator.amplitude = (sender.doubleValue - 1.0)
                
                AudioKit.start()
                oscillator.start()
                print(oscillator.amplitude)
                print(mixer.isStarted)
            }
            else {
                //pressureIndicator.integerValue = 0
                //AudioKit.stop()
                //oscillator.stop()
            }
        }
        
        if sender.title == "Frequency"{
            if sender.doubleValue >= 1 {
                frequencyDisplay.stringValue = String(Int((sender.doubleValue - 1.0) * 5000.0))
                
                oscillator.frequency = (sender.doubleValue - 1.0) * 5000.0
                
                AudioKit.start()
                oscillator.start()
                print(oscillator.frequency)
            }
            else {
                //frequencyDisplay.stringValue = String(0)
                //AudioKit.stop()
                //oscillator.stop()
            }
        }
        
        if sender.title == "Harmonics"{
            if sender.doubleValue >= 1 {
                harmonicIndicator.integerValue = Int((sender.doubleValue - 1.0) * 8)
                
                let frequencies = (1...5).map { $0 * 261.63 }
                
                AudioKit.start()
                oscillator.start()
                //mixer.start()
                print(oscillator.frequency)
            }
            else {
                //harmonicIndicator.integerValue = 0
                //AudioKit.stop()
                //oscillator.stop()
            }
        }
    }
    

}

