//
//  EBTextFieldForAutoLayout.swift
//  essai-custom-stack-view
//
//  Created by Pierre Molinaro on 20/10/2019.
//  Copyright © 2019 Pierre Molinaro. All rights reserved.
//
// https://stackoverflow.com/questions/14643180/nstextfield-width-and-autolayout
// https://stackoverflow.com/questions/1992950/nsstring-sizewithattributes-content-rect/1993376#1993376
// https://stackoverflow.com/questions/35356225/nstextfieldcells-cellsizeforbounds-doesnt-match-wrapping-behavior
//
//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

import Cocoa

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

class EBTextFieldForAutoLayout : NSTextField, NSTextFieldDelegate {

  //····················································································································

  init (title inTitle : String) {
    super.init (frame: NSRect ())
    self.delegate = self
    self.translatesAutoresizingMaskIntoConstraints = false
    self.stringValue = inTitle
    self.usesSingleLineMode =  false
    self.lineBreakMode = .byCharWrapping
    self.cell?.wraps = true
    self.cell?.isScrollable = false
    self.maximumNumberOfLines = 10
    self.preferredMaxLayoutWidth = 155.0
  }

  //····················································································································

  required init? (coder : NSCoder) {
    fatalError ("init(coder:) has not been implemented")
  }

  //····················································································································
  // HAS PRECEEDING SEPARATOR
  //····················································································································

  var mHasPreceedingSeparator : Bool = false

  override var hasPreceedingSeparator : Bool { return mHasPreceedingSeparator }

  //····················································································································
  // HORIZONTAL ALIGNMENT
  //····················································································································

  var mStackHorizontalAlignment : StackHorizontalAlignment = .center

  override var horizontalAlignment : StackHorizontalAlignment { return self.mStackHorizontalAlignment }

  //····················································································································
  // VERTICAL ALIGNMENT
  //····················································································································

  var mStackVerticalAlignment : StackVerticalAlignment = .center

  override var verticalAlignment : StackVerticalAlignment { return self.mStackVerticalAlignment }

  //····················································································································
  // MINIMUM WIDTH
  //····················································································································

  var mMinimumWidth : CGFloat = 100.0

  //····················································································································
  // MAXIMUM WIDTH
  //····················································································································

  var mMaximumWidth : CGFloat {
    get { return self.preferredMaxLayoutWidth }
    set { self.preferredMaxLayoutWidth = newValue }
  }

  //····················································································································
  // INTRINSIC CONTENT SIZE
  //····················································································································

   override var intrinsicContentSize : NSSize {
   //--- Forces updating from the field editor
     self.validateEditing ()
   //--- Compute size that fits
     let preferredSize = NSSize (width: self.preferredMaxLayoutWidth - 5.0, height: 10_000.0)
     var s = self.sizeThatFits (preferredSize)
     // Swift.print ("s \(s.width), \(s.height)")
   //--- Apply minimum, maximum width
     s.width = max (s.width, self.mMinimumWidth)
     s.width = min (s.width, self.preferredMaxLayoutWidth)
     // Swift.print ("intrinsicContentSize \(s.width), \(s.height)")
   //---
     return s
   }

  //····················································································································

  func controlTextDidChange (_ inNotification : Notification) {
    // Swift.print ("controlTextDidChange")
    self.invalidateIntrinsicContentSize ()
  }

}

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

