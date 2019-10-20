//
//  EBHorizontalStackView.swift
//  essai-custom-stack-view
//
//  Created by Pierre Molinaro on 19/10/2019.
//  Copyright © 2019 Pierre Molinaro. All rights reserved.
//
//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

import Cocoa

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

let HORIZONTAL_STACK_SPACING : CGFloat = 8.0
let SEPARATOR_WIDTH : CGFloat = 5.0

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

@IBDesignable class EBHorizontalStackView : EBAbstractStackView {

  //····················································································································
  //   INIT
  //····················································································································

  init () {
    super.init (frame: NSRect ())
    self.customInit ()
  }

  //····················································································································

  override init (frame inFrame : NSRect) {
    super.init (frame: inFrame)
    self.customInit ()
  }

  //····················································································································

  required init? (coder inCoder : NSCoder) {
    super.init (coder: inCoder)
    self.customInit ()
  }

  //····················································································································

  private func customInit () {
    self.setContentCompressionResistancePriority (.required, for: .vertical)
  }

  //····················································································································

  private var mLeftViews = [NSView] ()
  @IBOutlet var mLeftView0 : NSView? = nil
  @IBOutlet var mLeftView1 : NSView? = nil
  @IBOutlet var mLeftView2 : NSView? = nil
  @IBOutlet var mLeftView3 : NSView? = nil
  @IBOutlet var mLeftView4 : NSView? = nil

  //····················································································································

  private var mRightViews = [NSView] ()
  @IBOutlet var mRightView0 : NSView? = nil
  @IBOutlet var mRightView1 : NSView? = nil
  @IBOutlet var mRightView2 : NSView? = nil
  @IBOutlet var mRightView3 : NSView? = nil

  //····················································································································

  func appendLeftView (_ inView : NSView?) {
    if let v = inView {
//      Swift.print ("appendLeftView \(v)")
      v.translatesAutoresizingMaskIntoConstraints = false
      self.mLeftViews.append (v)
      self.addStackedSubview (v)
    }
  }

  //····················································································································

  func appendRightView (_ inView : NSView?) {
    if let v = inView {
//      Swift.print ("appendRightView \(v)")
      v.translatesAutoresizingMaskIntoConstraints = false
      self.mRightViews.append (v)
      self.addStackedSubview (v)
    }
  }

  //····················································································································

  override func awakeFromNib () {
    super.awakeFromNib ()
    self.appendLeftView (self.mLeftView0)
    self.appendLeftView (self.mLeftView1)
    self.appendLeftView (self.mLeftView2)
    self.appendLeftView (self.mLeftView3)
    self.appendLeftView (self.mLeftView4)
    self.appendRightView (self.mRightView0)
    self.appendRightView (self.mRightView1)
    self.appendRightView (self.mRightView2)
    self.appendRightView (self.mRightView3)
  }

  //····················································································································

  override func computeViewConstraints () {
//  Swift.print ("computeViewConstraints, horizontal")
  //--- Remove all constraints, all separators
    super.computeViewConstraints ()
  //--- Left views
    var optionalPreviousLeftView : NSView? = nil
    for view in self.mLeftViews {
      if !view.isHidden {
        if let previousView = optionalPreviousLeftView {
          if view.hasPreceedingSeparator {
            let separator = self.newSeparator ()
            self.layout (separator, .left, .equal, to: previousView, .right, plus: HORIZONTAL_STACK_SPACING)
            self.layout (separator, .top, .equal, superview: .top)
            self.layout (separator, .bottom, .equal, superview: .bottom)
            self.layout (separator, .width, .equal, SEPARATOR_WIDTH)
            self.layout (view, .left, .equal, to: separator, .right, plus: HORIZONTAL_STACK_SPACING)
          }else{
            self.layout (view, .left, .equal, to: previousView, .right, plus: HORIZONTAL_STACK_SPACING)
          }
        }else{
          self.layout (view, .left, .equal, superview: .left)
        }
        optionalPreviousLeftView = view
        self.createVerticalAlignmentConstraints (for: view)
      }
    }
  //--- Right views
    var optionalPreviousRightView : NSView? = nil
    for view in self.mRightViews {
      if !view.isHidden {
        if let previousView = optionalPreviousRightView {
          if view.hasPreceedingSeparator {
            let separator = self.newSeparator ()
            self.layout (separator, .right, .equal, to: previousView, .left, plus: -HORIZONTAL_STACK_SPACING)
            self.layout (separator, .top, .equal, superview: .top)
            self.layout (separator, .bottom, .equal, superview: .bottom)
            self.layout (separator, .width, .equal, SEPARATOR_WIDTH)
            self.layout (view, .right, .equal, to: separator, .left, plus: -HORIZONTAL_STACK_SPACING)
          }else{
            self.layout (view, .right, .equal, to: previousView, .left, plus: -HORIZONTAL_STACK_SPACING)
          }
        }else{
          self.layout (view, .right, .equal, superview: .right)
        }
        optionalPreviousRightView = view
        self.createVerticalAlignmentConstraints (for: view)
      }
    }
  }

  //····················································································································

  override var intrinsicContentSize : NSSize {
    var w : CGFloat = 0.0
    var h : CGFloat = 0.0
    var optionalPreviousLeftView : NSView? = nil
    for view in self.mLeftViews {
      if !view.isHidden {
        if optionalPreviousLeftView != nil {
          w += HORIZONTAL_STACK_SPACING
          if view.hasPreceedingSeparator {
            w += SEPARATOR_WIDTH + HORIZONTAL_STACK_SPACING
          }
        }
        let s = view.intrinsicContentSize
        w += s.width
        h = max (h, s.height)
        optionalPreviousLeftView = view
      }
    }
    var optionalPreviousRightView : NSView? = nil
    for view in self.mRightViews {
      if !view.isHidden {
        if optionalPreviousRightView != nil {
          w += HORIZONTAL_STACK_SPACING
          if view.hasPreceedingSeparator {
            w += SEPARATOR_WIDTH + HORIZONTAL_STACK_SPACING
          }
        }
        let s = view.intrinsicContentSize
        w += s.width
        h = max (h, s.height)
        optionalPreviousRightView = view
      }
    }
//    Swift.print ("intrinsicContentSize, horizontal stack \(w), \(h)")
    return NSSize (width: w, height: h)
  }

  //····················································································································

  override var fittingSize : NSSize {
    var w : CGFloat = 0.0
    var h : CGFloat = 0.0
    var optionalPreviousLeftView : NSView? = nil
    for view in self.mLeftViews {
      if !view.isHidden {
        if optionalPreviousLeftView != nil {
          w += HORIZONTAL_STACK_SPACING
          if view.hasPreceedingSeparator {
            w += SEPARATOR_WIDTH + HORIZONTAL_STACK_SPACING
          }
        }
        let s = view.fittingSize
        w += s.width
        h = max (h, s.height)
        optionalPreviousLeftView = view
      }
    }
    var optionalPreviousRightView : NSView? = nil
    for view in self.mRightViews {
      if !view.isHidden {
        if optionalPreviousRightView != nil {
          w += HORIZONTAL_STACK_SPACING
          if view.hasPreceedingSeparator {
            w += SEPARATOR_WIDTH + HORIZONTAL_STACK_SPACING
          }
        }
        let s = view.fittingSize
        w += s.width
        h = max (h, s.height)
        optionalPreviousRightView = view
      }
    }
    Swift.print ("fittingSize \(w), \(h)")
    return NSSize (width: w, height: h)
  }

  //····················································································································
  // HORIZONTAL ALIGNMENT
  //····················································································································

  var mStackHorizontalAlignment : StackHorizontalAlignment = .spawn

  override var horizontalAlignment : StackHorizontalAlignment { return self.mStackHorizontalAlignment }

  @IBInspectable var _VerticalAlignment : Int {
    get { return self.mStackHorizontalAlignment.rawValue }
    set {
      if let value = StackHorizontalAlignment (rawValue: newValue) {
        self.mStackHorizontalAlignment = value
      }
    }
  }   //convenience var, enum not inspectable

  //····················································································································

}

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
