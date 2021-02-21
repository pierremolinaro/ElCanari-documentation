//
//  EBButton.swift
//  essai-custom-stack-view
//
//  Created by Pierre Molinaro on 19/10/2019.
//  Copyright © 2019 Pierre Molinaro. All rights reserved.
//
//----------------------------------------------------------------------------------------------------------------------

import Cocoa

//----------------------------------------------------------------------------------------------------------------------

class ALButton : NSButton {

  //····················································································································

  init (_ inTitle : String) {
    super.init (frame: NSRect ())
//    self.font = NSFont.systemFont (ofSize: NSFont.systemFontSize)
    self.bezelStyle = .regularSquare
    self.isBordered = true
    Swift.print ("BUTTON, lineBreakMode \(self.lineBreakMode.rawValue)")
    self.lineBreakMode = .byCharWrapping
    self.title = inTitle
//    self.invalidateIntrinsicContentSize ()
    Swift.print ("BUTTON, fittingSize \(self.fittingSize)")
    Swift.print ("  BUTTON, intrinsicContentSize \(self.intrinsicContentSize)")
    Swift.print ("  BUTTON, alignment rect \(self.alignmentRect (forFrame: NSRect (origin: NSPoint (), size: self.fittingSize)))")
    Swift.print ("  BUTTON, frame \(self.frame (forAlignmentRect: NSRect (origin: NSPoint (), size: self.fittingSize)))")
    Swift.print ("  BUTTON, sizeThatFits \(self.sizeThatFits (NSSize ()))")
//    Swift.print ("  BUTTON, safeAreaRect \(self.safeAreaRect)")
//    Swift.print ("  BUTTON, safeAreaInsets \(self.safeAreaInsets)")
//    Swift.print ("  BUTTON, additionalSafeAreaInsets \(self.additionalSafeAreaInsets)")
    Swift.print ("  BUTTON, minimumSize \(self.minimumSize (withPrioritizedCompressionOptions: []))")
//    self.invalidateIntrinsicContentSize ()
 //   self.invalidateIntrinsicContentSize (for: self.cell!)
  }

  //····················································································································

  required init? (coder inCoder : NSCoder) {
    fatalError ("init(coder:) has not been implemented")
  }

  //····················································································································

  @discardableResult static func make (_ title : String) -> ALButton {
    let b = ALButton (title)
    gCurrentStack?.addSubview (b)
    return b
  }

  override func ebFittingSize () -> NSSize {
//    self.calcSize ()
//    self.sizeToFit ()
    return self.sizeThatFits (NSSize ())
  }

  //····················································································································
  // SET FLEXIBLE WIDTH
  //····················································································································

  @discardableResult func setFlexibleWidth () -> Self {
    // Swift.print ("\(self.contentHuggingPriority (for: .horizontal))")
//    self.setContentHuggingPriority (.init (rawValue: 1.0), for: .horizontal)
//    self.needsUpdateConstraints = true
    return self
  }

  //····················································································································

}

//----------------------------------------------------------------------------------------------------------------------
