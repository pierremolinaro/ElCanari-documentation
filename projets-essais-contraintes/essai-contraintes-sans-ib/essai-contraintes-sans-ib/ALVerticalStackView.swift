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
  savedCurrentStack?.addSubview (v)
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
  }

  //····················································································································

  required init? (coder inCoder : NSCoder) {
    fatalError ("init(coder:) has not been implemented")
  }

  //····················································································································

//  private var mConstraints = [NSLayoutConstraint] ()
//
//  override func updateConstraints () {
////    Swift.print ("V STACK \(self)")
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
//        let c = NSLayoutConstraint (item: oneSpaceView, attribute: .height, relatedBy: .equal, toItem: spaceView, attribute: .height, multiplier: 1.0, constant: 0.0)
//        self.mConstraints.append (c)
//      }
//      self.addConstraints (self.mConstraints)
//    }
//    super.updateConstraints ()
//  }

  //····················································································································

}

//----------------------------------------------------------------------------------------------------------------------
