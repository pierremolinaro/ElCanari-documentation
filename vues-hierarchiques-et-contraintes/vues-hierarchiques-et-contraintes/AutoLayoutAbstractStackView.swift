//
//  AutoLayoutAbstractStackView.swift
//  vues-hierarchiques-et-contraintes
//
//  Created by Pierre Molinaro on 11/08/2024.
//
//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

import AppKit

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
// http://marginalfutility.net/2018/07/01/alignment-rects/
//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

class AutoLayoutAbstractStackView : AutoLayoutView {

  //--------------------------------------------------------------------------------------------------------------------

  let mHorizontalDisposition : PMHorizontalLayoutInVerticalCollectionView
  let mVerticalDisposition : PMVerticalLayoutInHorizontalCollectionView

  //--------------------------------------------------------------------------------------------------------------------

  init (horizontal inHorizontalDisposition : PMHorizontalLayoutInVerticalCollectionView,
        vertical inVerticalDisposition : PMVerticalLayoutInHorizontalCollectionView) {
    self.mHorizontalDisposition = inHorizontalDisposition
    self.mVerticalDisposition = inVerticalDisposition
    super.init ()
    self.pmConfigureForAutolayout (hStretchingResistance: .lowest, vStrechingResistance: .lowest)
  }

  //--------------------------------------------------------------------------------------------------------------------

  required init?(coder: NSCoder) {
    fatalError ("init(coder:) has not been implemented")
  }

  //--------------------------------------------------------------------------------------------------------------------

  override var intrinsicContentSize : NSSize { NSSize (width: 1, height: 1) }

  //--------------------------------------------------------------------------------------------------------------------

//  func appendView (_ inView : NSView) -> Self {
//    self.addSubview (inView)
//    return self
//  }

  //--------------------------------------------------------------------------------------------------------------------

//  func prependView (_ inView : NSView) -> Self {
//    self.addSubview (inView, positioned: .below, relativeTo: nil)
//    return self
//  }

  //--------------------------------------------------------------------------------------------------------------------

  final func appendFlexibleSpace () -> Self {
    self.addSubview (PMFlexibleSpace ())
    return self
  }

  //····················································································································
  //  MARGINS
  //····················································································································

  private(set) var mLeftMargin : CGFloat = 0.0
  private(set) var mRightMargin : CGFloat = 0.0
  private(set) var mTopMargin : CGFloat = 0.0
  private(set) var mBottomMargin : CGFloat = 0.0
  private(set) var mSpacing : CGFloat = 4.0

  //····················································································································

  final func set (spacing inValue : Int) -> Self {
    self.mSpacing = CGFloat (inValue)
    self.invalidateIntrinsicContentSize ()
    return self
  }

  //····················································································································

  final func set (margins inValue : PMMarginSize) -> Self {
    let v = CGFloat (inValue.rawValue)
    self.mLeftMargin   = v
    self.mBottomMargin = v
    self.mTopMargin    = v
    self.mRightMargin  = v
    self.invalidateIntrinsicContentSize ()
    return self
  }

  //····················································································································

  final func set (topMargin inValue : PMMarginSize) -> Self {
    self.mTopMargin = CGFloat (inValue.rawValue)
    self.invalidateIntrinsicContentSize ()
    return self
  }

  //····················································································································

  final func set (bottomMargin inValue : PMMarginSize) -> Self {
    self.mBottomMargin = CGFloat (inValue.rawValue)
    self.invalidateIntrinsicContentSize ()
    return self
  }

  //····················································································································

  final func set (leftMargin inValue : PMMarginSize) -> Self {
    self.mLeftMargin = CGFloat (inValue.rawValue)
    self.invalidateIntrinsicContentSize ()
    return self
  }

  //····················································································································

  final func set (rightMargin inValue : PMMarginSize) -> Self {
    self.mRightMargin = CGFloat (inValue.rawValue)
    self.invalidateIntrinsicContentSize ()
    return self
  }

  //--------------------------------------------------------------------------------------------------------------------
  // Draw
  //--------------------------------------------------------------------------------------------------------------------

//  override func draw (_ inDirtyRect : NSRect) {
//    var flag = true
//    var v : NSView? = self.superview
//    while let superview = v?.superview {
//      v = superview
//      flag.toggle ()
//    }
//    let color = flag ? NSColor.orange : NSColor.yellow
//    color.setFill ()
//    inDirtyRect.fill ()
//    super.draw (inDirtyRect)
//  }

  //--------------------------------------------------------------------------------------------------------------------

  final func isFlexibleSpace (_ inView : NSView) -> Bool {
    return inView is PMFlexibleSpace
  }

  //--------------------------------------------------------------------------------------------------------------------

  private class PMFlexibleSpace : NSView {

    // · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · ·

    init () {
      super.init (frame: .zero)
      self.pmConfigureForAutolayout (hStretchingResistance: .lowest, vStrechingResistance: .lowest)
    }

    // · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · ·

    required init? (coder: NSCoder) {
      fatalError ("init(coder:) has not been implemented")
    }

    // · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · ·

//    override var intrinsicContentSize : NSSize { NSSize () }
    
    // · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · ·

    private static let mFlexibleSpaceLayoutSettings = PMViewLayoutSettings (
      vLayoutInHorizontalContainer: .weakFill,
      hLayoutInVerticalContainer: .weakFill
    )

    // · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · ·

    override var pmLayoutSettings : PMViewLayoutSettings { Self.mFlexibleSpaceLayoutSettings }

    // · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · ·

    override func draw (_ inDirtyRect : NSRect) {
      super.draw (inDirtyRect)
      if !self.bounds.isEmpty {
        NSColor.orange.setFill ()
        self.bounds.fill ()
      }
    }

    // · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · ·

  }

  //--------------------------------------------------------------------------------------------------------------------

}

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
