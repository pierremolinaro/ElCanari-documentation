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
  gCurrentStack?.addSubview (h)
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
  }

  //····················································································································

  required init? (coder inCoder : NSCoder) {
    fatalError ("init(coder:) has not been implemented")
  }

  //····················································································································
  // SET FLEXIBLE WIDTH
  //····················································································································

  @discardableResult func fillEqualy () -> Self {
//    self.distribution = .fillEqually
    return self
  }

  //····················································································································

//  private var mConstraints = [NSLayoutConstraint] ()
//
//  override func updateConstraints () {
//    // Swift.print ("H STACK \(self)")
//    self.removeConstraints (self.mConstraints)
//    self.mConstraints.removeAll ()
//    var spaceViewArray = [ALFlexibleSpaceView] ()
//    for view in self.subviews {
//      if let spaceView = view as? ALFlexibleSpaceView {
//        spaceViewArray.append (spaceView)
//      }
//    }
//    if let oneSpaceView = spaceViewArray.popLast () {
//      for spaceView in spaceViewArray {
//        let c = NSLayoutConstraint (item: oneSpaceView, attribute: .width, relatedBy: .equal, toItem: spaceView, attribute: .width, multiplier: 1.0, constant: 0.0)
//        self.mConstraints.append (c)
//      }
//      self.addConstraints (self.mConstraints)
//    }
//    super.updateConstraints ()
//  }

  //····················································································································

}

//----------------------------------------------------------------------------------------------------------------------
