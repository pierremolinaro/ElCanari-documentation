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
  let savedCurrentStack = gCurrentStack
  let h = ALHorizontalStackView ()
  savedCurrentStack?.addSubview (h)
  gCurrentStack = h
  inContents ()
  gCurrentStack = savedCurrentStack
  return h
}

//----------------------------------------------------------------------------------------------------------------------

class ALHorizontalStackView : ALAbstractStackView {

  //····················································································································
  //   INIT
  //····················································································································

  init () {
    super.init (frame: NSRect ())
    self.setContentCompressionResistancePriority (.required, for: .vertical)
    self.translatesAutoresizingMaskIntoConstraints = false
  }

  //····················································································································

  required init? (coder inCoder : NSCoder) {
    fatalError ("init(coder:) has not been implemented")
  }

  //····················································································································
  //   Properties
  //····················································································································

  private var mAllItemsHaveSameWidth = false

  //····················································································································

  @discardableResult func sameWidth (_ inFlag : Bool) -> Self {
    self.mAllItemsHaveSameWidth = inFlag
    return self
  }
  
  //····················································································································

  override func ebComputeViewConstraints () {
//  Swift.print ("computeViewConstraints, horizontal")
  //--- Remove all constraints, all separators
    super.ebComputeViewConstraints ()
  //--- Get array of visible views
    let visibleViews = self.visibleViews ()
  //--- Compute view constraints
    var optionalPreviousView : NSView? = nil
    var flexibleSpaces = [ALFlexibleSpaceView] ()
    for view in visibleViews {
      if let v = view as? ALAbstractStackView {
        v.ebComputeViewConstraints ()
      }
      if let previousView = optionalPreviousView {
        self.layout (view, .left, .equal, to: previousView, .right, plus: self.separator)
      }else{
        self.layout (view, .left, .equal, superview: .left, plus: self.leftMargin)
      }
      if let flexibleSpaceView = view as? ALFlexibleSpaceView {
        flexibleSpaces.append (flexibleSpaceView)
      }
      optionalPreviousView = view
    }
    if let rightView = optionalPreviousView {
      self.layout (rightView, .right, .equal, superview: .right, plus: -self.rightMargin)
    }
  //--- Flexible spaces
    if let firstFlexibleSpaceView = flexibleSpaces.popLast () {
      for flexibleSpaceView in flexibleSpaces {
        self.layout (flexibleSpaceView, .width, .equal, to: firstFlexibleSpaceView, .width)
      }
    }
  //--- Vertical alignment in stack view
    var referenceSubviewAlignedByBaseLine : (NSView, NSLayoutConstraint.Attribute)? = nil
    for view in visibleViews {
      switch view.verticalAlignment () {
      case .top :
         self.layout (view, .top, .equal, superview: .top, plus: self.topMargin)
         self.layout (view, .bottom, .lessThanOrEqual, superview: .bottom, plus: -self.bottomMargin)
      case .center :
        self.layout (view, .centerY, .equal, superview: .centerY)
        self.layout (view, .top, .greaterThanOrEqual, superview: .top, plus: self.topMargin)
        self.layout (view, .bottom, .lessThanOrEqual, superview: .bottom, plus: -self.bottomMargin)
      case .height :
        self.layout (view, .top, .equal, superview: .top, plus: self.topMargin)
        self.layout (view, .bottom, .equal, superview: .bottom, plus: -self.bottomMargin)
      case .firstBaseline :
        self.layout (view, .top, .greaterThanOrEqual, superview: .top, plus: self.topMargin)
        self.layout (view, .bottom, .lessThanOrEqual, superview: .bottom, plus: -self.bottomMargin)
        if let (refView, alignment) = referenceSubviewAlignedByBaseLine {
          self.layout (view, .firstBaseline, .equal, to: refView, alignment)
        }else{
          referenceSubviewAlignedByBaseLine = (view, .firstBaseline)
        }
      case .lastBaseline :
        self.layout (view, .top, .greaterThanOrEqual, superview: .top, plus: self.topMargin)
        self.layout (view, .bottom, .lessThanOrEqual, superview: .bottom, plus: -self.bottomMargin)
        if let (refView, alignment) = referenceSubviewAlignedByBaseLine {
          self.layout (view, .lastBaseline, .equal, to: refView, alignment)
        }else{
          referenceSubviewAlignedByBaseLine = (view, .lastBaseline)
        }
      case .bottom :
        self.layout (view, .top, .greaterThanOrEqual, superview: .top, plus: self.topMargin)
        self.layout (view, .bottom, .equal, superview: .bottom, plus: -self.bottomMargin)
      }
    }
  //--- Equal width constraint ?
    if mAllItemsHaveSameWidth {
      var allSubviews = visibleViews
      if let lastView = allSubviews.popLast () {
        for view in allSubviews {
          self.layout (view, .width, .equal, to: lastView, .width)
        }
      }
    }
  }

  //····················································································································
  //   METRICS
  //····················································································································

  override var intrinsicContentSize : NSSize {
    var w = self.leftMargin + self.rightMargin
    var heightUnderLastBaseLine : CGFloat = 0.0
    var heightOverFirstBaseLine : CGFloat = 0.0
    var heightBetweenFirstAndLastBaseLines : CGFloat = 0.0
    var visibleViewCount = 0
    for view in self.subviews {
      if !view.isHidden {
        let lastBaseLineOffset = view.lastBaselineOffsetFromBottom
        heightUnderLastBaseLine = max (lastBaseLineOffset, heightUnderLastBaseLine)
        let firstBaseLineOffset = view.firstBaselineOffsetFromTop
        let s = view.intrinsicContentSize
        // Swift.print ("\(String (describing:type (of: view))) \(s), \(firstBaseLineOffset) \(lastBaseLineOffset)")
        if s.width > 0.0 {
          w += s.width
        }
        heightUnderLastBaseLine = max (heightUnderLastBaseLine, lastBaseLineOffset)
        heightOverFirstBaseLine = max (heightOverFirstBaseLine, s.height - firstBaseLineOffset)
        heightBetweenFirstAndLastBaseLines = max (heightBetweenFirstAndLastBaseLines, s.height - firstBaseLineOffset - lastBaseLineOffset)
        visibleViewCount += 1
      }
    }
    if visibleViewCount > 1 {
      w += self.separator * CGFloat (visibleViewCount - 1)
    }
    let h = self.topMargin + heightUnderLastBaseLine + heightBetweenFirstAndLastBaseLines + heightUnderLastBaseLine + self.bottomMargin
    return NSSize (width: w, height: h)
  }

  //····················································································································

  override var lastBaselineOffsetFromBottom : CGFloat {
    var heightUnderBaseLine : CGFloat = 0.0
    for view in self.subviews {
      if !view.isHidden {
        let baseLineOffset = view.lastBaselineOffsetFromBottom
        heightUnderBaseLine = max (baseLineOffset, heightUnderBaseLine)
      }
    }
    return heightUnderBaseLine + self.bottomMargin
  }

  //····················································································································

  override var firstBaselineOffsetFromTop : CGFloat {
    var h : CGFloat = 0.0
    for view in self.subviews {
      if !view.isHidden {
        let baseLineOffset = view.firstBaselineOffsetFromTop
        h = max (baseLineOffset, h)
      }
    }
    return h + self.topMargin
  }

  //····················································································································

}

//----------------------------------------------------------------------------------------------------------------------
