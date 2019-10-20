//
//  MyView.swift
//  essai-contraintes
//
//  Created by Pierre Molinaro on 16/10/2019.
//  Copyright © 2019 Pierre Molinaro. All rights reserved.
//
//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

import Cocoa

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

class MyView : NSView {

  let mBackColor : NSColor

  //····················································································································

  init (color inBackColor : NSColor) {
    mBackColor = inBackColor
    super.init (frame: NSZeroRect)
    self.translatesAutoresizingMaskIntoConstraints = false
  }

  //····················································································································

  required init? (coder : NSCoder) {
    mBackColor = .red
    super.init (coder: coder)
    self.translatesAutoresizingMaskIntoConstraints = false
  }

  //····················································································································

  override func draw (_ dirtyRect: NSRect) {
    self.mBackColor.setFill ()
    NSBezierPath.fill (dirtyRect)
    super.draw (dirtyRect)
  }

  //····················································································································

}

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

class EBLabel : NSTextField {


  //····················································································································

  init (title inTitle : String) {
    super.init (frame: NSZeroRect)
    self.translatesAutoresizingMaskIntoConstraints = false
    self.stringValue = inTitle
    self.isEditable = false
    self.isBordered = false
    self.alignment = .center
  }

  //····················································································································

  required init? (coder : NSCoder) {
    super.init (coder: coder)
    self.translatesAutoresizingMaskIntoConstraints = false
  }

  //····················································································································

}

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

class EBButton : NSButton {


  //····················································································································

  init (title inTitle : String) {
    super.init (frame: NSZeroRect)
    self.translatesAutoresizingMaskIntoConstraints = false
    self.title = inTitle
    self.isBordered = true
    self.bezelStyle = .regularSquare
    self.font = NSFont.systemFont (ofSize: NSFont.systemFontSize)
  }

  //····················································································································

  required init? (coder : NSCoder) {
    super.init (coder: coder)
    self.translatesAutoresizingMaskIntoConstraints = false
  }

  //····················································································································

}

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
