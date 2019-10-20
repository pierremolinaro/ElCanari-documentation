//
//  EBAbstractStackView.swift
//  essai-custom-stack-view
//
//  Created by Pierre Molinaro on 19/10/2019.
//  Copyright © 2019 Pierre Molinaro. All rights reserved.
//
//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

import Cocoa

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

@IBDesignable class EBAbstractStackView : NSView {

  //····················································································································
  //   BACK COLOR
  //····················································································································

  @IBInspectable var _BackColor : NSColor? = nil

  //····················································································································

  override func draw (_ inDirtyRect : NSRect) {
    if let backColor = self._BackColor {
      backColor.setFill ()
      NSBezierPath.fill (inDirtyRect)
    }
    super.draw (inDirtyRect)
  }

  //····················································································································
  //   CONSTRAINTS
  //····················································································································

  private var mConstraints = [NSLayoutConstraint] ()

  //····················································································································

  func layout (_ inView : NSView,
               _ inViewAttribute : NSLayoutConstraint.Attribute,
               _ inRelation : NSLayoutConstraint.Relation,
               to inOtherView : NSView,
               _ inOtherAttribute : NSLayoutConstraint.Attribute,
               plus inDistance : CGFloat = 0.0,
               priority inPrority : Int = 1000) {
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
    self.mConstraints.append (c)
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
    self.mConstraints.append (c)
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
    self.mConstraints.append (c)
  }

  //····················································································································

  final func removeEBConstraints () {
    self.removeConstraints (self.mConstraints)
    self.mConstraints.removeAll ()
  }

  //····················································································································
  //   SEPARATORS
  //····················································································································

  private var mSeparators = [NSBox] ()

  //····················································································································

  func newSeparator () -> NSView {
    let separator = NSBox ()
    separator.boxType = .separator
    separator.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview (separator)
    self.mSeparators.append (separator)
    return separator
  }

  //····················································································································

  final func removeAllEBSeparators () {
    for separator in self.mSeparators {
      separator.removeFromSuperview ()
    }
    self.mSeparators.removeAll ()
  }

  //····················································································································

  override final func invalidateIntrinsicContentSize () {
    super.invalidateIntrinsicContentSize ()
    self.computeViewConstraints ()
    if let superview = self.superview as? EBAbstractStackView {
      superview.invalidateIntrinsicContentSize ()
    }
  }

  //····················································································································

  func computeViewConstraints () {
    self.removeEBConstraints ()
    self.removeAllEBSeparators ()
  }

  //····················································································································

  private var mStackedSubViews = Set <NSView> ()

  //····················································································································

  final func addStackedSubview (_ inView : NSView) {
    super.addSubview (inView)
    inView.addObserver (self, forKeyPath: "hidden", options: .new, context: nil)
    self.mStackedSubViews.insert (inView)
    self.invalidateIntrinsicContentSize ()
  }

  //····················································································································

  override func willRemoveSubview (_ inSubview : NSView) {
    super.willRemoveSubview (inSubview)
    if self.mStackedSubViews.contains (inSubview) {
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

  final func createVerticalAlignmentConstraints (for inView : NSView) {
    switch inView.verticalAlignment {
    case .spawn :
      self.layout (inView, .top, .equal, superview: .top)
      self.layout (inView, .bottom, .equal, superview: .bottom)
    case .top :
      self.layout (inView, .top, .equal, superview: .top)
    case .center :
      self.layout (inView, .centerY, .equal, superview: .centerY)
    case .baseline :
      self.layout (inView, .firstBaseline, .equal, superview: .centerY)
    case .bottom :
      self.layout (inView, .bottom, .equal, superview: .bottom)
    }
  }

  //····················································································································

  final func createHorizontalAlignmentConstraints (for inView : NSView) {
    switch inView.horizontalAlignment {
    case .left :
      self.layout (inView, .left, .equal, superview: .left)
      self.layout (inView, .right, .lessThanOrEqual, superview: .right)
    case .center :
      self.layout (inView, .centerX, .equal, superview: .centerX)
      self.layout (inView, .left, .greaterThanOrEqual, superview: .left)
      self.layout (inView, .right, .lessThanOrEqual, superview: .right)
    case .spawn :
      self.layout (inView, .left, .equal, superview: .left)
      self.layout (inView, .right, .equal, superview: .right)
    case .right :
      self.layout (inView, .left, .greaterThanOrEqual, superview: .left)
      self.layout (inView, .right, .equal, superview: .right)
    }
  }

  //····················································································································

}

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

