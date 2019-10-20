//
//  AppDelegate.swift
//  essai-custom-stack-view
//
//  Created by Pierre Molinaro on 19/10/2019.
//  Copyright © 2019 Pierre Molinaro. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  @IBOutlet weak var window: NSWindow!
  @IBOutlet weak var mStackView : EBVerticalStackView? = nil
  @IBOutlet weak var mLeftLabel : NSTextField? = nil
  @IBOutlet weak var mLeftLabel2 : NSTextField? = nil


  @IBAction func buttonAction (_ inSender : Any?) {
    self.mLeftLabel?.stringValue += "Z"
    if let label2 = self.mLeftLabel2 {
      label2.isHidden = !label2.isHidden
    }
  }

  @IBOutlet weak var mNewWindow : NSWindow? = nil
  var mCachableLabel : EBLabelForAutoLayout? = nil

  func applicationDidFinishLaunching (_ aNotification: Notification) {
    let verticalStackView = EBVerticalStackView ()
    verticalStackView.frame = self.mNewWindow!.contentView!.frame.insetBy (dx: 8.0, dy: 8.0)
    verticalStackView.autoresizingMask = [.width, .height]
    verticalStackView._BackColor = .lightGray
    var widget = EBLabelForAutoLayout (title: "Label Haut")
    widget.mStackHorizontalAlignment = .left
    verticalStackView.appendTopView (widget)
    widget = EBLabelForAutoLayout (title: "Label Haut 2")
    widget.mStackHorizontalAlignment = .right
    verticalStackView.appendTopView (widget)
    widget = EBLabelForAutoLayout (title: "Label Haut 3")
    widget.mHasPreceedingSeparator = true
    widget.mStackHorizontalAlignment = .center
    verticalStackView.appendTopView (widget)
    widget = EBLabelForAutoLayout (title: "Label Haut 4")
    widget.mStackHorizontalAlignment = .spawn
    self.mCachableLabel = widget
    verticalStackView.appendTopView (widget)
    do{
      let horizontalStack = EBHorizontalStackView ()
      horizontalStack.mStackHorizontalAlignment = .left
      var widget = EBLabelForAutoLayout (title: "Label Gauche")
      horizontalStack.appendLeftView (widget)
      widget = EBLabelForAutoLayout (title: "Label Droit")
      widget.mHasPreceedingSeparator = true
      horizontalStack.appendLeftView (widget)
      verticalStackView.appendTopView (horizontalStack)
    }
    do{
      let widget = EBTextFieldForAutoLayout (title: "Text")
      widget.mStackHorizontalAlignment = .center
      verticalStackView.appendTopView (widget)
    }
    do{
      let widget = EBSwitchForAutoLayout (title: "Switch")
      widget.mStackHorizontalAlignment = .center
      widget.target = self
      widget.action = #selector (self.switchAction (_:))
      verticalStackView.appendTopView (widget)
    }
    self.mNewWindow?.contentView?.addSubview (verticalStackView)

    self.mNewWindow?.makeKeyAndOrderFront (nil)
  }

  @objc func switchAction (_ inSender : Any?) {
    if let v = self.mCachableLabel {
      v.isHidden = !v.isHidden
    }
  }
}

