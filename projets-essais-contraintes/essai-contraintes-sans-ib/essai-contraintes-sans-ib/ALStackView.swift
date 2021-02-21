//
//  ALStackView.swift
//  essai-contraintes-sans-ib
//
//  Created by Pierre Molinaro on 01/02/2021.
//
//----------------------------------------------------------------------------------------------------------------------

import Cocoa

//----------------------------------------------------------------------------------------------------------------------

var gCurrentStack : ALStackView? = nil

//----------------------------------------------------------------------------------------------------------------------

enum ALOrientation {
  case horizontal
  case vertical
}

//----------------------------------------------------------------------------------------------------------------------

class ALStackView : NSView {

  private let mOrientation : ALOrientation
  private var edgeInsets = NSEdgeInsets ()
  private var mSpacing : CGFloat = 8.0

  //····················································································································
  //   INIT
  //····················································································································

  init (orientation inOrientation : ALOrientation) {
    self.mOrientation = inOrientation
    super.init (frame: NSRect ())
  }

  //····················································································································

  required init? (coder: NSCoder) {
    fatalError ("init(coder:) has not been implemented")
  }

  //····················································································································

  override func viewDidMoveToWindow () {
    super.viewDidMoveToWindow ()
    if self.window != nil {
      if let superView = self.superview {
        self.bounds = NSRect (origin: NSPoint (), size: superView.bounds.size)
      }
      self.ebUpdateLayout ()
    }
  }

  //····················································································································

  func ebUpdateLayout () {
    let xy = self.intrinsicContentSize
    if self.superview != nil, xy.width > 0.0 , xy.height > 0.0 {
      Swift.print ("self.frame \(self.frame)")
      for view in self.subviews {
        view.autoresizingMask = []
        Swift.print ("  view \(view) view.intrinsicContentSize \(view.intrinsicContentSize) view.fittingSize \(view.fittingSize)")
      }
      switch self.mOrientation {
      case .horizontal :
        var totalWidth : CGFloat = 0.0
        var spaceCount = 0
        for view in self.subviews {
          let s = view.ebFittingSize ()
          if s.width > 0.0 {
            totalWidth += s.width
          }else if s.width < 0.0 {
            spaceCount += 1
          }
        }
        let flexibleSpaceWidth : CGFloat = (spaceCount > 0)
           ? (self.bounds.size.width - totalWidth) / CGFloat (spaceCount)
           : 0.0
        Swift.print ("flexibleSpaceWidth \(flexibleSpaceWidth), spaceCount \(spaceCount)")
        var origin = self.bounds.origin // NSPoint (x: self.bounds.midX, y: self.bounds.midY)
        for view in self.subviews {
          let s = view.ebFittingSize ()
          if s.width > 0.0, s.height > 0.0 {
            view.frame = NSRect (origin: origin, size: NSSize (width: s.width, height: self.bounds.size.height))
            Swift.print ("  H view.frame \(view.frame) \(view.intrinsicContentSize)")
            origin.x += s.width
            if let stack = view as? ALStackView {
              stack.ebUpdateLayout ()
            }
          }else if s.width < 0.0 {
            origin.x += flexibleSpaceWidth
          }
        }
      case .vertical :
        var totalHeight : CGFloat = 0.0
        var spaceCount = 0
        for view in self.subviews {
          let s = view.ebFittingSize ()
          if s.height > 0.0 {
            totalHeight += s.height
          }else if s.height < 0.0 {
            spaceCount += 1
          }
        }
        let flexibleSpaceHeight : CGFloat = (spaceCount > 0)
           ? (self.bounds.size.height - totalHeight) / CGFloat (spaceCount)
           : 0.0
        var origin = NSPoint (x: self.bounds.minX, y: self.bounds.maxY)
        for view in self.subviews {
          let s = view.ebFittingSize ()
          if s.width > 0.0, s.height > 0.0 {
            origin.y -= s.height
            view.frame = NSRect (origin: origin, size: NSSize (width: self.bounds.size.width, height: s.height))
            Swift.print ("  V view.frame \(view.frame) \(view.intrinsicContentSize)")
            if let stack = view as? ALStackView {
              stack.ebUpdateLayout ()
            }
          }else if s.height < 0.0 {
            origin.y -= flexibleSpaceHeight
          }
        }
      }
    }
  }

  //····················································································································

  override var intrinsicContentSize : NSSize {
    var width : CGFloat = 0.0
    var height : CGFloat = 0.0
    switch self.mOrientation {
    case .horizontal :
      for view in self.subviews {
        let s = view.intrinsicContentSize
        if s.width > 0.0 {
          width += s.width
        }
        height = max (height, s.height)
      }
    case .vertical :
      for view in self.subviews {
//        Swift.print ("  view.frame \(view.frame) \(view.intrinsicContentSize)")
        let s = view.intrinsicContentSize
        if s.height > 0.0 {
          height += s.height
        }
        width = max (width, s.width)
      }
    }
    return NSSize (width: width, height: height)
  }

  //····················································································································
  //  MARGINS
  //····················································································································

  @discardableResult func noMargin () -> Self {
    self.edgeInsets.left   = 0.0
    self.edgeInsets.top    = 0.0
    self.edgeInsets.right  = 0.0
    self.edgeInsets.bottom = 0.0
    return self
  }

  //····················································································································

  @discardableResult func setMargins (_ inValue : CGFloat) -> Self {
    self.edgeInsets.left   = inValue
    self.edgeInsets.top    = inValue
    self.edgeInsets.right  = inValue
    self.edgeInsets.bottom = inValue
    return self
  }

  //····················································································································

  @discardableResult func setTopMargin (_ inValue : CGFloat) -> Self {
    self.edgeInsets.top = inValue
    return self
  }

  //····················································································································

  @discardableResult func setBottomMargin (_ inValue : CGFloat) -> Self {
    self.edgeInsets.bottom = inValue
    return self
  }

  //····················································································································

  @discardableResult func setLeftMargin (_ inValue : CGFloat) -> Self {
    self.edgeInsets.left = inValue
    return self
  }

  //····················································································································

  @discardableResult func setRightMargin (_ inValue : CGFloat) -> Self {
    self.edgeInsets.right = inValue
    return self
  }

  //····················································································································

  @discardableResult func setSpacing (_ inValue : CGFloat) -> Self {
    self.mSpacing = inValue
    return self
  }

  //····················································································································

}

//----------------------------------------------------------------------------------------------------------------------

extension NSView {

  @objc func ebFittingSize () -> NSSize {
    return self.intrinsicContentSize
  }

//  @objc func sizeToFit () {
//  }
}
