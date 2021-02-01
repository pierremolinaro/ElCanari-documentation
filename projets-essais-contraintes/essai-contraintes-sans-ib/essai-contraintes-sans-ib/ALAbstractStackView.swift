//
//  EBAbstractStackView.swift
//  essai-custom-stack-view
//
//  Created by Pierre Molinaro on 19/10/2019.
//  Copyright © 2019 Pierre Molinaro. All rights reserved.
//
//----------------------------------------------------------------------------------------------------------------------

import Cocoa

//----------------------------------------------------------------------------------------------------------------------

var gCurrentStack : ALAbstractStackView? = nil

//----------------------------------------------------------------------------------------------------------------------

func space () {
  gCurrentStack?.addSubview (ALFlexibleSpaceView ())
}

//----------------------------------------------------------------------------------------------------------------------

class ALAbstractStackView : NSView {

  //····················································································································
  //   DRAW BACKGROUND
  //····················································································································

  override func draw (_ inDirtyRect : NSRect) {
    if let backColor = debugBackgroundColor () {
      if let windowContentView = self.window?.contentView, windowContentView === self {
        NSColor.white.setFill ()
      }else{
        backColor.setFill ()
      }
      NSBezierPath.fill (inDirtyRect)
    }
    super.draw (inDirtyRect)
  }

  //····················································································································
  //   CONSTRAINTS
  //····················································································································

  func layout (_ inView : NSView,
               _ inViewAttribute : NSLayoutConstraint.Attribute,
               _ inRelation : NSLayoutConstraint.Relation,
               to inOtherView : NSView,
               _ inOtherAttribute : NSLayoutConstraint.Attribute,
               plus inDistance : CGFloat = 0.0) {
    let c = NSLayoutConstraint (
      item: inView,
      attribute: inViewAttribute,
      relatedBy: inRelation,
      toItem: inOtherView,
      attribute: inOtherAttribute,
      multiplier: 1.0,
      constant: inDistance
    )
    self.addConstraint (c)
  }

  //····················································································································

  func layout (_ inView : NSView,
               _ inViewAttribute : NSLayoutConstraint.Attribute,
               _ inRelation : NSLayoutConstraint.Relation,
               superview inSuperviewAttribute : NSLayoutConstraint.Attribute,
               plus inDistance : CGFloat = 0.0) {
    let c = NSLayoutConstraint (
      item: inView,
      attribute: inViewAttribute,
      relatedBy: inRelation,
      toItem: self,
      attribute: inSuperviewAttribute,
      multiplier: 1.0,
      constant: inDistance
    )
    self.addConstraint (c)
  }

  //····················································································································

  func layout (_ inView : NSView,
               _ inViewAttribute : NSLayoutConstraint.Attribute,
               _ inRelation : NSLayoutConstraint.Relation,
               _ inDistance : CGFloat) {
    let c = NSLayoutConstraint (
      item: inView,
      attribute: inViewAttribute,
      relatedBy: inRelation,
      toItem: nil,
      attribute: .notAnAttribute,
      multiplier: 0.0,
      constant: inDistance
    )
    self.addConstraint (c)
  }

  //····················································································································

  override final func invalidateIntrinsicContentSize () {
    super.invalidateIntrinsicContentSize ()
    self.ebComputeViewConstraints ()
    if let superview = self.superview as? ALAbstractStackView {
      superview.invalidateIntrinsicContentSize ()
    }
  }

  //····················································································································

  func ebComputeViewConstraints () {
    self.removeConstraints (self.constraints)
  }

  //····················································································································

  override func addSubview (_ inView : NSView) {
//    Swift.print ("addSubview \(inView)")
//    if inView is ALFlexibleSpaceView {
//     inView.autoresizingMask = [.width]
//     inView.translatesAutoresizingMaskIntoConstraints = true
//    }else{
//     inView.translatesAutoresizingMaskIntoConstraints = false
//    }
    inView.translatesAutoresizingMaskIntoConstraints = false
    super.addSubview (inView)
    inView.addObserver (self, forKeyPath: "hidden", options: .new, context: nil)
    self.invalidateIntrinsicContentSize ()
  }

  //····················································································································

  override func willRemoveSubview (_ inSubview : NSView) {
//    Swift.print ("willRemoveSubview \(inSubview)")
    super.willRemoveSubview (inSubview)
    if self.subviews.contains (inSubview) {
      inSubview.removeObserver (self, forKeyPath: "hidden")
      self.invalidateIntrinsicContentSize ()
    }
  }

  //····················································································································

  override func observeValue (forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    if "hidden" == keyPath {
      self.invalidateIntrinsicContentSize ()
    }else{
      super.observeValue (forKeyPath: keyPath, of: object, change: change, context: context)
    }
  }

  //····················································································································
  //  VISIBLE (NOT HIDDEN) VIEWS
  //····················································································································

  final func visibleViews () -> [NSView] {
    var visibleViews = [NSView] ()
    for view in self.subviews {
      if !view.isHidden {
        visibleViews.append (view)
      }
    }
    return visibleViews
  }

  //····················································································································
  //  MARGINS
  //····················································································································

  private var mLeftMargin   : CGFloat = 0.0
  private var mTopMargin    : CGFloat = 0.0
  private var mRightMargin  : CGFloat = 0.0
  private var mBottomMargin : CGFloat = 0.0

  //····················································································································

  var leftMargin   : CGFloat { self.mLeftMargin }
  var topMargin    : CGFloat { self.mTopMargin }
  var rightMargin  : CGFloat { self.mRightMargin }
  var bottomMargin : CGFloat { self.mBottomMargin }

  //····················································································································

  @discardableResult func noMargin () -> Self {
    self.mLeftMargin   = 0.0
    self.mTopMargin    = 0.0
    self.mRightMargin  = 0.0
    self.mBottomMargin = 0.0
    return self
  }

  //····················································································································

  @discardableResult func setMargins (_ inValue : CGFloat) -> Self {
    self.mLeftMargin   = inValue
    self.mTopMargin    = inValue
    self.mRightMargin  = inValue
    self.mBottomMargin = inValue
    return self
  }

  //····················································································································

  @discardableResult func setTopMargin (_ inValue : CGFloat) -> Self {
    self.mTopMargin    = inValue
    return self
  }

  //····················································································································

  @discardableResult func setBottomMargin (_ inValue : CGFloat) -> Self {
    self.mBottomMargin = inValue
    return self
  }

  //····················································································································

  @discardableResult func setLeftMargin (_ inValue : CGFloat) -> Self {
    self.mLeftMargin   = inValue
    return self
  }

  //····················································································································

  @discardableResult func setRightMargin (_ inValue : CGFloat) -> Self {
    self.mRightMargin  = inValue
    return self
  }

  //····················································································································
  //  ITEM SEPARATORS
  //····················································································································

  private var mSeparator : CGFloat = 5.0

  //····················································································································

  var separator : CGFloat { self.mSeparator }

  //····················································································································
  //  METRICS
  //····················································································································

  final override var baselineOffsetFromBottom : CGFloat { return self.lastBaselineOffsetFromBottom }

  //····················································································································

}

//----------------------------------------------------------------------------------------------------------------------

