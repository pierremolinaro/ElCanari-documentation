//
//  PMVerticalStackView.swift
//  essai-gridview
//
//  Created by Pierre Molinaro on 30/10/2023.
//
//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

import AppKit

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

class PMVerticalStackView : PMAbstractStackView {

  //--------------------------------------------------------------------------------------------------------------------

  override var pmLayoutSettings : PMViewLayoutSettings {
    return PMViewLayoutSettings (
      vLayoutInHorizontalContainer: self.mVerticalDisposition,
      hLayoutInVerticalContainer: self.mHorizontalDisposition
    )
  }

  //····················································································································
  // Flipped
  // https://stackoverflow.com/questions/4697583/setting-nsscrollview-contents-to-top-left-instead-of-bottom-left-when-document-s
  //····················································································································

  final override var isFlipped : Bool { true }

  //--------------------------------------------------------------------------------------------------------------------
  //  Last Baseline representative view
  //--------------------------------------------------------------------------------------------------------------------

  private var mLastBaselineRepresentativeView : NSView? = nil

  //--------------------------------------------------------------------------------------------------------------------

  override var pmLastBaselineRepresentativeView : NSView? { self.mLastBaselineRepresentativeView }

  //--------------------------------------------------------------------------------------------------------------------
  //  Constraints
  //--------------------------------------------------------------------------------------------------------------------

  private var mConstraints = [NSLayoutConstraint] ()

  //--------------------------------------------------------------------------------------------------------------------

  override func updateConstraints () {
  //--- Remove all constraints
    self.removeConstraints (self.mConstraints)
    self.mConstraints.removeAll (keepingCapacity: true)
  //--- Build constraints
    self.mLastBaselineRepresentativeView = nil
    var optionalLastView : NSView? = nil
    var optionalLastFlexibleSpace : NSView? = nil
    for view in self.subviews {
      if !view.isHidden {
      //--- Horizontal constraints
        switch view.pmLayoutSettings.hLayoutInVerticalContainer {
        case .center :
          self.mConstraints.add (requiresCenterXOf: view, equalToCenterXOf: self)
        case .fill, .weakFill :
          self.mConstraints.add (requiresLeftOf: view, equalToLeftOf: self, plus: self.mLeftMargin)
          self.mConstraints.add (requiresRightOf: self, equalToRightOf: view, plus: self.mRightMargin)
        case .weakFillIgnoringMargins :
          self.mConstraints.add (requiresLeftOf: view, equalToLeftOf: self)
          self.mConstraints.add (requiresRightOf: self, equalToRightOf: view)
        case .left :
          self.mConstraints.add (requiresLeftOf: view, equalToLeftOf: self, plus: self.mLeftMargin)
        case .right :
          self.mConstraints.add (requiresRightOf: self, equalToRightOf: view, plus: self.mRightMargin)
        }
      //--- Vertical constraints
        if let lastView = optionalLastView {
          let spacing = self.isFlexibleSpace (view) ? 0.0 : self.mSpacing
          self.mConstraints.add (requiresBottomOf: lastView, equalToTopOf: view, plus: spacing)
        }else{
          self.mConstraints.add (requiresTopOf: self, equalToTopOf: view, plus: self.mTopMargin)
        }
        if let viewLastBaselineRepresentativeView = view.pmLastBaselineRepresentativeView {
          self.mLastBaselineRepresentativeView = viewLastBaselineRepresentativeView
        }
      //--- Handle height constraint for views with lower hugging priority
        if self.isFlexibleSpace (view) {
          if let refView = optionalLastFlexibleSpace {
            self.mConstraints.add (requiresHeightOf: refView, equalToHeightOf: view)
          }
          optionalLastFlexibleSpace = view
        }
        if self.isHorizontalDivider (view) {
          optionalLastFlexibleSpace = nil
        }
      //---
        optionalLastView = view
      }
    }
  //--- Add right constraint for last view
    if let lastView = optionalLastView {
      self.mConstraints.add (requiresBottomOf: lastView, equalToBottomOf: self, plus: self.mBottomMargin)
    }
  //--- Apply constaints
    self.addConstraints (self.mConstraints)
  //--- This should the last instruction: call super method
    super.updateConstraints ()
  }

  //--------------------------------------------------------------------------------------------------------------------
  // Draw
  //--------------------------------------------------------------------------------------------------------------------

//  override func draw (_ inDirtyRect : NSRect) {
//    let r = NSRect (
//      x: self.mLeftMargin,
//      y: self.mBottomMargin,
//      width: self.bounds.size.width - self.mLeftMargin - self.mRightMargin,
//      height: self.bounds.size.height - self.mBottomMargin - self.mTopMargin
//    )
//    NSColor.yellow.setFill ()
//    r.fill ()
////    NSColor.lightGray.setFill ()
////    var x : CGFloat = self.subviews.first?.frame.origin.x ?? 0.0
////    for view in self.subviews {
////      let f = view.frame
////      if f.origin.x > x {
////        NSRect (x: x, y: self.mBottomMargin, width: f.origin.x - x, height: self.bounds.size.height - self.mBottomMargin - self.mTopMargin).fill ()
////      }
////      x = NSMaxX (f)
////    }
//    super.draw (inDirtyRect)
////    NSColor.black.setStroke ()
////    NSBezierPath.stroke (self.bounds.insetBy (dx: 0.5, dy: 0.5))
//  }

  //--------------------------------------------------------------------------------------------------------------------

}

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————