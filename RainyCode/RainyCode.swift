//
//  RainyCode.swift
//
//  Created by binaryboy on 3/16/16.
//  Copyright © 2016 AhmedHamdy. All rights reserved.
//

import AppKit
import AVFoundation


var sharedPlugin: RainyCode?
enum RainyModeRun: Int{
    case OFF
    case ON

}
class RainyCode: NSObject {
    
    var bundle: NSBundle
    lazy var center = NSNotificationCenter.defaultCenter()
    var urlPath:String?
    var url:NSURL?
    var sound:NSSound?
    var actionMenuItem:NSMenuItem?
    var optionState:Int {
        
        get {
            
            let stateValue:Int =  NSUserDefaults.standardUserDefaults().integerForKey ("xc_spacing")
            print(stateValue)
            return stateValue
        }
        
        set (optionState) {
            
            if optionState == RainyModeRun.ON.rawValue{
                
                actionMenuItem?.title = "RainyCode ON"
                self.sound!.play()
            }else{
                actionMenuItem?.title = "RainyCode OFF"
                self.sound!.stop()
                
            }
            NSUserDefaults.standardUserDefaults().setObject(optionState, forKey: "xc_spacing")
            NSUserDefaults.standardUserDefaults().synchronize()
            
        }
    }
    
    
    
    
    init(bundle: NSBundle) {
        self.bundle = bundle
        
        super.init()
        center.addObserver(self, selector: #selector(RainyCode.createMenuItems), name: NSApplicationDidFinishLaunchingNotification, object: nil)
        
        urlPath = self.bundle.pathForResource("rainymood", ofType: "m4a")!
        
        
        url =  NSURL(fileURLWithPath: urlPath!)
        
        
        sound = NSSound(contentsOfURL: url!, byReference: false)!
        
        
    }
    
    deinit {
        removeObserver()
    }
    
    func removeObserver() {
        center.removeObserver(self)
    }
    
    func createMenuItems() {
        removeObserver()
        
        let menuItem:NSMenuItem? = NSApp.mainMenu!.itemWithTitle("Edit")
        
        if menuItem != nil {
            menuItem!.submenu!.addItem(NSMenuItem.separatorItem())
            
            
            actionMenuItem = NSMenuItem(title: "RainyCode OFF", action: #selector(RainyCode.doOptionAction(_:))
                , keyEquivalent: "r")
            
            actionMenuItem!.state = 0
            
            actionMenuItem!.target = self
            
            
            actionMenuItem!.keyEquivalentModifierMask = Int(NSEventModifierFlags.CommandKeyMask.rawValue|NSEventModifierFlags.AlternateKeyMask.rawValue|NSEventModifierFlags.ControlKeyMask.rawValue)
            
            
            menuItem?.submenu?.addItem(actionMenuItem!)
            
            
            
            
        }
        
    }
    
    func doOptionAction(optionMenuItem:NSMenuItem){
        
        if optionMenuItem.state == 1{
            optionMenuItem.state = 0
            
        }else{
            optionMenuItem.state = 1
            
        }        
        self.optionState = optionMenuItem.state
    }
    
}