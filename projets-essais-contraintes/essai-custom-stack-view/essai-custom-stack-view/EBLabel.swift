//
//  EBLabel.swift
//  essai-custom-stack-view
//
//  Created by Pierre Molinaro on 19/10/2019.
//  Copyright © 2019 Pierre Molinaro. All rights reserved.
//
//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

import Cocoa

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

class EBTextField : NSTextField {

  //····················································································································
  // HAS PRECEEDING SEPARATOR
  //····················································································································

  @IBInspectable var _HasPreceedingSeparator : Bool = false

  override var hasPreceedingSeparator : Bool { return _HasPreceedingSeparator }

  //····················································································································
  // VERTICAL ALIGNMENT
  //····················································································································

  var mStackVerticalAlignment : StackVerticalAlignment = .center

  override var verticalAlignment : StackVerticalAlignment { return self.mStackVerticalAlignment }

  @IBInspectable var _VerticalAlignment : Int {
    get { return self.mStackVerticalAlignment.rawValue }
    set {
      if let value = StackVerticalAlignment (rawValue: newValue) {
        self.mStackVerticalAlignment = value
      }
    }
  }   //convenience var, enum not inspectable

  //····················································································································

}

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

