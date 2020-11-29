//
//  EBSwitchForAutoLayout.swift
//  essai-custom-stack-view
//
//  Created by Pierre Molinaro on 20/10/2019.
//  Copyright © 2019 Pierre Molinaro. All rights reserved.
//
//----------------------------------------------------------------------------------------------------------------------

import Cocoa

//----------------------------------------------------------------------------------------------------------------------

class EBSwitchForAutoLayout : NSButton {

  //····················································································································

  init (title inTitle : String) {
    super.init (frame: NSRect ())
    self.translatesAutoresizingMaskIntoConstraints = false
    self.title = inTitle
    self.setButtonType (.switch)
  }

  //····················································································································

  required init? (coder : NSCoder) {
    fatalError ("init(coder:) has not been implemented")
  }

  //····················································································································
  // HAS PRECEEDING SEPARATOR
  //····················································································································

//  var mHasPreceedingSeparator : Bool = false
//
//  override var hasPreceedingSeparator : Bool { return mHasPreceedingSeparator }

  //····················································································································
  // HORIZONTAL ALIGNMENT
  //····················································································································

//  var mStackHorizontalAlignment : StackHorizontalAlignment = .center
//
//  override var horizontalAlignment : StackHorizontalAlignment { return self.mStackHorizontalAlignment }

  //····················································································································
  // VERTICAL ALIGNMENT
  //····················································································································

//  var mStackVerticalAlignment : StackVerticalAlignment = .center
//
//  override var verticalAlignment : StackVerticalAlignment { return self.mStackVerticalAlignment }

  //····················································································································

}

//----------------------------------------------------------------------------------------------------------------------

