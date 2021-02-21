//
//  ALSpinningProgressIndicator.swift
//  essai-contraintes-sans-ib
//
//  Created by Pierre Molinaro on 03/02/2021.
//
//----------------------------------------------------------------------------------------------------------------------

import Cocoa

//----------------------------------------------------------------------------------------------------------------------

class ALSpinningProgressIndicator : NSProgressIndicator {

  //····················································································································

  init () {
    super.init (frame: NSRect ())
    self.isIndeterminate = true
    self.style = .spinning
    self.usesThreadedAnimation = true
    self.startAnimation (nil)
  }

  //····················································································································

  required init? (coder : NSCoder) {
    fatalError ("init(coder:) has not been implemented")
  }

  //----------------------------------------------------------------------------------------------------------------------

  @discardableResult static func make () -> ALSpinningProgressIndicator {
    let b = ALSpinningProgressIndicator ()
    gCurrentStack?.addSubview (b)
    return b
  }

  //····················································································································

}


//----------------------------------------------------------------------------------------------------------------------
