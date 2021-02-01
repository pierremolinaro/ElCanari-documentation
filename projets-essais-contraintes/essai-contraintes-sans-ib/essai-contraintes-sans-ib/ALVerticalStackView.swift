//
//  ALVerticalStackView.swift
//  essai-custom-stack-view
//
//  Created by Pierre Molinaro on 19/10/2019.
//  Copyright © 2019 Pierre Molinaro. All rights reserved.
//
//----------------------------------------------------------------------------------------------------------------------

import Cocoa

//----------------------------------------------------------------------------------------------------------------------

@discardableResult func vStack (_ inContents : () -> Void) -> ALVerticalStackView {
  let savedCurrentStack = gCurrentStack
  let v = ALVerticalStackView ()
  savedCurrentStack?.addView (v, in: .leading)
  gCurrentStack = v
  inContents ()
  gCurrentStack = savedCurrentStack
  return v
}

//----------------------------------------------------------------------------------------------------------------------

class ALVerticalStackView : ALStackView {

  //····················································································································
  //   INIT
  //····················································································································

  init () {
    super.init (orientation: .vertical)
//    self.setContentCompressionResistancePriority (.required, for: .horizontal)
//    self.translatesAutoresizingMaskIntoConstraints = false
  }

  //····················································································································

  required init? (coder inCoder : NSCoder) {
    fatalError ("init(coder:) has not been implemented")
  }

  //····················································································································

}

//----------------------------------------------------------------------------------------------------------------------
