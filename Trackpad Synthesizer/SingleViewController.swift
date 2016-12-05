//
//  ViewController.swift
//  Trackpad Synthesizer
//
//  Created by Victor Wang on 12/4/16.
//  Copyright © 2016 Victor Wang. All rights reserved.
//

import Cocoa
import AudioKit

class SingleViewController: NSViewController {
    
    @IBOutlet weak var pressureIndicator: NSLevelIndicator!
    @IBOutlet weak var frequencyDisplay: NSTextField!
    @IBOutlet weak var harmonicIndicator: NSLevelIndicator!
    
    var oscillator = AKOscillator()
    var mixer = AKMixer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AudioKit.stop()
        
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
    
    @IBAction func acceleratorChanged(_ sender: NSButton) {
        print(sender)
        
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
                print(harmonicIndicator.integerValue)
                
                mixer = AKMixer()
                let frequencies = (1...Int((sender.doubleValue) * 7)).map { $0 * oscillator.frequency }
                let amplitudes = [1.0, 0.3, 0.177, 0.114, 0.092, 0.06, 0.04, 0.02, 0.011]
                print(frequencies)
                
                for i in 0..<harmonicIndicator.integerValue {
                    mixer.connect(createAndStartOscillator(frequency: frequencies[i], amplitude: amplitudes[i]))
                }
                
                AudioKit.start()
                oscillator.start()
                mixer.start()
                print(oscillator.frequency)
            }
            else {
                //harmonicIndicator.integerValue = 0
                //AudioKit.stop()
                //oscillator.stop()
            }
        }
    }
    
    
    func createAndStartOscillator(frequency: Double, amplitude: Double) -> AKOscillator {
        let oscillator = AKOscillator()
        oscillator.frequency = frequency
        oscillator.amplitude = amplitude
        oscillator.start()
        
        print(oscillator.frequency)
        print(oscillator.amplitude)
        
        return oscillator
    }
    
}

