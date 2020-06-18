//
//  AppDelegate.swift
//  autoclicker
//
//  Created by Dominik Sánchez Meckenstock on 16/06/2020.
//  Copyright © 2020 Dominik Sánchez Meckenstock. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {


    @IBOutlet weak var positionLabelX: NSTextField!
    @IBOutlet weak var positionLabelY: NSTextField!
    @IBOutlet weak var intervalLabel: NSTextField!
    @IBOutlet weak var intervalSlider: NSSlider!
    @IBOutlet weak var progressBar: NSProgressIndicator!
    @IBOutlet weak var startStopButton: NSButton!
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var colorDemo1: NSColorWell!
    @IBOutlet weak var colorDemo2: NSColorWell!
    
    var timerRunning = false
    
    var theTimer : Timer?
    var theColor : NSColor?
    
    @objc func timerTick() {
        let tmpHeight = NSScreen.main?.frame.height
        var tmpPosition = NSEvent.mouseLocation
        tmpPosition.y = tmpHeight! - tmpPosition.y
        progressBar.doubleValue = progressBar.doubleValue - 0.1
        if (progressBar.doubleValue == 0.0) {
            progressBar.doubleValue = progressBar.maxValue
            // CHECK COLOR
            print(self.theColor.debugDescription)
            colorDemo1.color = getColorUnderCursor()
            if self.theColor != nil {
                colorDemo2.color = self.theColor!
                if getColorUnderCursor() == self.theColor {
                    // CLICK!!!
                    let mouseDNEvent = CGEvent(mouseEventSource: nil, mouseType: .leftMouseDown, mouseCursorPosition: tmpPosition, mouseButton: .left)
                    let mouseUPEvent = CGEvent(mouseEventSource: nil, mouseType: .leftMouseUp, mouseCursorPosition: tmpPosition, mouseButton: .left)
                    mouseDNEvent?.post(tap: .cghidEventTap)
                    usleep(100000)
                    mouseUPEvent?.post(tap: .cghidEventTap)
                }
            } else {
                self.theColor = getColorUnderCursor()
            }
        } else {
            positionLabelX.floatValue = Float( tmpPosition.x )
            positionLabelY.floatValue = Float( tmpPosition.y )
        }
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        self.window.level = .floating
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @IBAction func intervalSliderChanged(_ sender: Any) {
        progressBar.maxValue = Double( intervalSlider.intValue )
        progressBar.doubleValue = Double( intervalSlider.intValue )
        intervalLabel.stringValue = String( intervalSlider.intValue )
    }
    
    @IBAction func startStopButtonPressed(_ sender: Any) {
        
        if ( timerRunning ) {
            self.theTimer!.invalidate()
            startStopButton.title = "Start"
        } else {
            self.theTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timerTick), userInfo: nil, repeats: true)
            startStopButton.title = "Stop"
        }
        
        timerRunning = !timerRunning
        
        progressBar.isHidden = !timerRunning
    }

    func getColorUnderCursor()->NSColor {
        let screenHeight = NSScreen.main?.frame.height
        var cursorPosition = NSEvent.mouseLocation
        cursorPosition.y = screenHeight! - cursorPosition.y
        let tmpImage = CGDisplayCreateImage( CGMainDisplayID(), rect: CGRect.init( x: cursorPosition.x, y: cursorPosition.y, width: 1, height: 1 ) )
        return NSBitmapImageRep.init(cgImage: tmpImage!).colorAt(x: 1, y: 1)!
    }
    
}

