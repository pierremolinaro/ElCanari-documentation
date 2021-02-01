//
//  ALHorizontalStackView.swift
//  essai-custom-stack-view
//
//  Created by Pierre Molinaro on 19/10/2019.
//  Copyright © 2019 Pierre Molinaro. All rights reserved.
//
//----------------------------------------------------------------------------------------------------------------------

import Cocoa

//----------------------------------------------------------------------------------------------------------------------

@discardableResult func hStack (_ inContents : () -> Void) -> ALHorizontalStackView {
  let h = ALHorizontalStackView ()
  gCurrentStack?.addView (h, in: .leading)
  let savedCurrentStack = gCurrentStack
  gCurrentStack = h
  inContents ()
  gCurrentStack = savedCurrentStack
  return h
}

//----------------------------------------------------------------------------------------------------------------------

class ALHorizontalStackView : ALStackView {

  //····················································································································
  //   INIT
  //····················································································································

  init () {
    super.init (orientation: .horizontal)
//    self.autoresizingMask = [.width]
//    self.translatesAutoresizingMaskIntoConstraints = true
  }

  //····················································································································

  required init? (coder inCoder : NSCoder) {
    fatalError ("init(coder:) has not been implemented")
  }

  //····················································································································
  // SET FLEXIBLE WIDTH
  //····················································································································

  @discardableResult func setFlexibleWidth () -> Self {
//    self.distribution = .gravityAreas
    return self
  }

  //····················································································································

}

//----------------------------------------------------------------------------------------------------------------------
