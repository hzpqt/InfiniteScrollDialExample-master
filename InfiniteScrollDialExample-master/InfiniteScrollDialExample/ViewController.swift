//
//  ViewController.swift
//  InfiniteScrollDialExample
//
//  Created by sugar on 23/7/15.
//  Copyright (c) 2015 Konstantinos Hondros. All rights reserved.
///

import Cocoa

class ViewController: NSViewController, InfiniteScrollDialDelegate {
    
    
    // MARK: - Properties
    
    @IBOutlet weak var scrollDialView: InfiniteScrollDial!
    
    @IBOutlet weak var scrollDialValue: NSTextField!
    
    @IBOutlet weak var newValueToSet: NSTextField!
    
    @IBOutlet weak var newMinValue: NSTextField!
    
    @IBOutlet weak var newMaxValue: NSTextField!
    
    
    // MARK: - Actions
    
    @IBAction func buttonSetDidpress(sender: AnyObject) {
        self.scrollDialView.setDialValue(value: self.newValueToSet.floatValue)
    }
    
    @IBAction func setMinValueDidPress(sender: AnyObject) {
        self.scrollDialView.setMinValue(value: self.newMinValue.integerValue)
    }
    
    @IBAction func setMaxValueDidPress(sender: AnyObject) {
        self.scrollDialView.setMaxValue(value: self.newMaxValue.integerValue)
    }
    
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.wantsLayer = true
        self.scrollDialView!.delegate = self
        
    }
    
    // Method from INScrollDialViewDelegate
    
    func dialValueDidChange(value newValue: Float) {
        self.scrollDialValue.stringValue = NSString(format: "%.2f", newValue) as String
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }

}

