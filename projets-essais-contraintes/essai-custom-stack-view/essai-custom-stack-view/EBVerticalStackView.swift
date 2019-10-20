//
//  EBVerticalStackView.swift
//  essai-custom-stack-view
//
//  Created by Pierre Molinaro on 19/10/2019.
//  Copyright © 2019 Pierre Molinaro. All rights reserved.
//
//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

import Cocoa

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

let VERTICAL_STACK_SPACING : CGFloat = 8.0

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

@IBDesignable class EBVerticalStackView : EBAbstractStackView {

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
    self.setContentCompressionResistancePriority (.required, for: .horizontal)
  }

  //····················································································································

  private var mTopViews = [NSView] ()
  @IBOutlet var mTopView0 : NSView? = nil
  @IBOutlet var mTopView1 : NSView? = nil
  @IBOutlet var mTopView2 : NSView? = nil
  @IBOutlet var mTopView3 : NSView? = nil
  @IBOutlet var mTopView4 : NSView? = nil

  //····················································································································

  private var mBottomViews = [NSView] ()
  @IBOutlet var mBottomView0 : NSView? = nil
  @IBOutlet var mBottomView1 : NSView? = nil
  @IBOutlet var mBottomView2 : NSView? = nil
  @IBOutlet var mBottomView3 : NSView? = nil

  //····················································································································

  func appendTopView (_ inView : NSView?) {
    if let v = inView {
//      Swift.print ("appendTopView \(v)")
      v.translatesAutoresizingMaskIntoConstraints = false
      self.mTopViews.append (v)
      self.addStackedSubview (v)
    }
  }

  //····················································································································

  func appendBottomView (_ inView : NSView?) {
    if let v = inView {
//      Swift.print ("appendBottomView \(v)")
      v.translatesAutoresizingMaskIntoConstraints = false
      self.mBottomViews.append (v)
      self.addStackedSubview (v)
    }
  }

  //····················································································································

  override func awakeFromNib () {
    super.awakeFromNib ()
    self.appendTopView (self.mTopView0)
    self.appendTopView (self.mTopView1)
    self.appendTopView (self.mTopView2)
    self.appendTopView (self.mTopView3)
    self.appendTopView (self.mTopView4)
    self.appendBottomView (self.mBottomView0)
    self.appendBottomView (self.mBottomView1)
    self.appendBottomView (self.mBottomView2)
    self.appendBottomView (self.mBottomView3)
  }

  //····················································································································

  override func computeViewConstraints () {
//    Swift.print ("computeViewConstraints, vertical")
  //--- Remove all constraints, all separators
    super.computeViewConstraints ()
  //--- Top views
    var optionalPreviousTopView : NSView? = nil
    for view in self.mTopViews {
      if !view.isHidden {
        if let previousView = optionalPreviousTopView {
          if view.hasPreceedingSeparator {
            let separator = self.newSeparator ()
            self.layout (separator, .top, .equal, to: previousView, .bottom, plus: VERTICAL_STACK_SPACING)
            self.layout (separator, .left, .equal, superview: .left)
            self.layout (separator, .right, .equal, superview: .right)
            self.layout (separator, .height, .equal, 5.0)
            self.layout (view, .top, .equal, to: separator, .bottom, plus: VERTICAL_STACK_SPACING)
          }else{
            self.layout (view, .top, .equal, to: previousView, .bottom, plus: VERTICAL_STACK_SPACING)
          }
        }else{
          self.layout (view, .top, .equal, superview: .top)
        }
        self.createHorizontalAlignmentConstraints (for: view)
        optionalPreviousTopView = view
      }
    }
  //--- Bottom views
    var optionalPreviousBottomView : NSView? = nil
    for view in self.mBottomViews {
      if !view.isHidden {
        if let previousView = optionalPreviousBottomView {
          if view.hasPreceedingSeparator {
            let separator = self.newSeparator ()
            self.layout (separator, .bottom, .equal, to: previousView, .top, plus: -VERTICAL_STACK_SPACING)
            self.layout (separator, .left, .equal, superview: .left)
            self.layout (separator, .right, .equal, superview: .right)
            self.layout (separator, .height, .equal, 5.0)
            self.layout (view, .bottom, .equal, to: separator, .top, plus: -VERTICAL_STACK_SPACING)
          }else{
            self.layout (view, .bottom, .equal, to: previousView, .bottom, plus: -VERTICAL_STACK_SPACING)
          }
        }else{
          self.layout (view, .bottom, .equal, superview: .bottom)
        }
        self.createHorizontalAlignmentConstraints (for: view)
        optionalPreviousBottomView = view
      }
    }
  }

   //····················································································································

   override var intrinsicContentSize : NSSize {
     var w : CGFloat = 0.0
     var h : CGFloat = 0.0
     var optionalPreviousLeftView : NSView? = nil
     for view in self.mTopViews {
       if !view.isHidden {
         if optionalPreviousLeftView != nil {
           w += VERTICAL_STACK_SPACING
           if view.hasPreceedingSeparator {
             w += SEPARATOR_WIDTH + VERTICAL_STACK_SPACING
           }
         }
         let s = view.intrinsicContentSize
         w += s.width
         h = max (h, s.height)
         optionalPreviousLeftView = view
       }
     }
     var optionalPreviousRightView : NSView? = nil
     for view in self.mBottomViews {
       if !view.isHidden {
         if optionalPreviousRightView != nil {
           w += VERTICAL_STACK_SPACING
           if view.hasPreceedingSeparator {
             w += SEPARATOR_WIDTH + VERTICAL_STACK_SPACING
           }
         }
         let s = view.intrinsicContentSize
         w += s.width
         h = max (h, s.height)
         optionalPreviousRightView = view
       }
     }
//     Swift.print ("intrinsicContentSize, vertical stack \(w), \(h)")
     return NSSize (width: w, height: h)
   }

  //····················································································································

}

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
