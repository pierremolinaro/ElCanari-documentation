//
//  AppDelegate.swift
//  essai-NSStackView
//
//  Created by Pierre Molinaro on 18/10/2019.
//  Copyright © 2019 Pierre Molinaro. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  @IBOutlet weak var window: NSWindow!

  let mLabel1 = EBLabel (title: "Label1")
  let mButton = EBButton (title: "Show / Hide Label 3")
  let mLabel2 = EBLabel (title: "Label2")
  let mLabel3 = EBLabel (title: "Label3")
  let mLabel4 = EBLabel (title: "Label4")

  let mStackView = NSStackView ()

  let mLabel5 = EBLabel (title: "Label5")
  let mLabel6 = EBLabel (title: "Label6")
  let mView56 = NSStackView ()


  func applicationDidFinishLaunching (_ inNotification : Notification) {
    self.mView56.translatesAutoresizingMaskIntoConstraints = false
    self.mView56.orientation = .horizontal
    self.mView56.distribution = .equalCentering
    self.mView56.addView (self.mLabel5, in: .top)
    self.mView56.addView (self.mLabel6, in: .bottom)

    self.mButton.target = self
    self.mButton.action = #selector (self.buttonAction (_:))
    self.mStackView.translatesAutoresizingMaskIntoConstraints = false
    self.mStackView.orientation = .vertical
    self.window.contentView?.addSubview (self.mStackView)
    self.mStackView.layout (.left, .equal, superview: .left, plus: 8.0)
    self.mStackView.layout (.top, .equal, superview: .top, plus: 8.0)

    self.mLabel4.layout (.width, .equal, 200.0)

    self.mStackView.addView (self.mLabel1, in: .bottom)
    self.mStackView.addView (self.mButton, in: .bottom)
    self.mStackView.addView (self.mLabel2, in: .bottom)
    self.mStackView.addView (self.mLabel3, in: .bottom)
    self.mStackView.addView (self.mView56, in: .bottom)
    self.mStackView.addView (self.mLabel4, in: .bottom)
  }


  @objc func buttonAction (_ inSender : Any?) {
    self.mLabel3.isHidden = !self.mLabel3.isHidden
  }


}

