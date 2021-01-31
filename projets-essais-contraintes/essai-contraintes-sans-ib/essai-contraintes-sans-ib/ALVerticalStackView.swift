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

class ALVerticalStackView : ALAbstractStackView {

  //····················································································································
  //   INIT
  //····················································································································

  init () {
    super.init (frame: NSRect ())
    self.setContentCompressionResistancePriority (.required, for: .horizontal)
  }

  //····················································································································

  required init? (coder inCoder : NSCoder) {
    fatalError ("init(coder:) has not been implemented")
  }

  //····················································································································

  override func computeViewConstraints () {
//    Swift.print ("computeViewConstraints, vertical")
  //--- Remove all constraints, all separators
    super.computeViewConstraints ()
  //--- Build constraints
    var flexibleSpaces = [ALFlexibleSpaceView] ()
    var optionalPreviousView : NSView? = nil
    for view in self.subviews {
      if !view.isHidden {
        if let v = view as? ALAbstractStackView {
          v.computeViewConstraints ()
        }
        if let previousView = optionalPreviousView {
          self.layout (view, .top, .equal, to: previousView, .bottom, plus: self.separator)
        }else{
          self.layout (view, .top, .equal, superview: .top, plus: self.topMargin)
        }
        self.layout (view, .left, .equal, superview: .left, plus: self.leftMargin)
        self.layout (view, .right, .equal, superview: .right, plus: -self.rightMargin)
        if let flexibleSpaceView = view as? ALFlexibleSpaceView {
          flexibleSpaces.append (flexibleSpaceView)
        }
        optionalPreviousView = view
      }
    }
  //--- Last view is bottom view
    if let bottomView = optionalPreviousView {
      self.layout (bottomView, .bottom, .equal, superview: .bottom, plus: -self.bottomMargin)
    }
  //--- Flexible spaces
    if let firstFlexibleSpaceView = flexibleSpaces.popLast () {
      for flexibleSpaceView in flexibleSpaces {
        self.layout (flexibleSpaceView, .height, .equal, to: firstFlexibleSpaceView, .height)
      }
    }
  }

  //····················································································································

  override var intrinsicContentSize : NSSize {
    var w : CGFloat = 0.0
    var h : CGFloat = self.topMargin + self.bottomMargin
    var visibleViewCount = 0
    for view in self.subviews {
      if !view.isHidden {
        let s = view.intrinsicContentSize
        h += s.height
        w = max (w, s.width)
        visibleViewCount += 1
      }
    }
    if visibleViewCount > 1 {
      h += self.separator * CGFloat (visibleViewCount - 1)
    }
    w += self.leftMargin + self.rightMargin
    return NSSize (width: w, height: h)
  }

  //····················································································································

  override var lastBaselineOffsetFromBottom : CGFloat {
    for view in self.subviews.reversed () {
      if !view.isHidden {
        return view.lastBaselineOffsetFromBottom
      }
    }
    return 0.0
  }

  //····················································································································

  override var firstBaselineOffsetFromTop : CGFloat {
    for view in self.subviews {
      if !view.isHidden {
        return view.firstBaselineOffsetFromTop
      }
    }
    return 0.0
  }

  //····················································································································
  // VERTICAL ALIGNMENT
  //····················································································································

  fileprivate var mVerticalAlignment = VerticalAlignment.lastBaseline

  //····················································································································

  @discardableResult func setVerticalAlignment (_ inAlignment : VerticalAlignment) -> Self {
    self.mVerticalAlignment = inAlignment
    return self
  }

  //····················································································································

  override func verticalAlignment () -> VerticalAlignment { return self.mVerticalAlignment }

  //····················································································································

}

//----------------------------------------------------------------------------------------------------------------------
