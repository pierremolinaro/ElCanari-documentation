//
//  AppDelegate.swift
//  essai-contraintes-2
//
//  Created by Pierre Molinaro on 16/10/2019.
//  Copyright © 2019 Pierre Molinaro. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  @IBOutlet weak var window: NSWindow!

  let myBaseView = MyView ()
  let myFirstButton = NSButton (frame: NSZeroRect)

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    myFirstButton.bezelStyle = .regularSquare
    myFirstButton.title = "Click Me"
    myFirstButton.translatesAutoresizingMaskIntoConstraints = false
    myBaseView.addSubview (myFirstButton)
    myFirstButton.setLeftFromSuperView (20.0)
    myFirstButton.setTopFromSuperView (-20.0)
    if let superview = self.myFirstButton.superview {
      let c = self.myFirstButton.rightAnchor.constraint (equalTo: superview.centerXAnchor, constant: -10.0)
      c.isActive = true
    }
    myFirstButton.setExactHeight (20.0)


    self.window.contentView?.addSubview (myBaseView)
    myBaseView.frame = self.window.contentView!.frame
    myBaseView.autoresizingMask = [.width, .height]
//    myBaseView.setTopFromSuperView (0)
//    myBaseView.setBottomFromSuperView (0)
//    myBaseView.setLeftFromSuperView (0)
//    myBaseView.setRightFromSuperView (0)

    Swift.print ("self.myBaseView.hasAmbiguousLayout \(self.myBaseView.hasAmbiguousLayout)")
    if self.myBaseView.hasAmbiguousLayout {
      Swift.print ("self.myBaseView. horizontal \(self.myBaseView.constraintsAffectingLayout (for: .horizontal))")
      Swift.print ("self.myBaseView. vertical \(self.myBaseView.constraintsAffectingLayout (for: .vertical))")
    }

    Swift.print ("self.myFirstButton.hasAmbiguousLayout \(self.myFirstButton.hasAmbiguousLayout)")
    if self.myFirstButton.hasAmbiguousLayout {
      Swift.print ("self.myFirstButton. horizontal \(self.myFirstButton.constraintsAffectingLayout (for: .horizontal))")
      Swift.print ("self.myFirstButton. vertical \(self.myFirstButton.constraintsAffectingLayout (for: .vertical))")
    }
  }


}

