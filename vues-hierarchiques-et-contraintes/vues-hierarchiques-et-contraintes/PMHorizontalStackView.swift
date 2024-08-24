//
//  PMHorizontalStackView.swift
//  essai-gridview
//
//  Created by Pierre Molinaro on 28/10/2023.
//
//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

import AppKit

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

class PMHorizontalStackView : PMAbstractStackView {

  //--------------------------------------------------------------------------------------------------------------------

  override var pmLayoutSettings : PMViewLayoutSettings {
    return PMViewLayoutSettings (
      vLayoutInHorizontalContainer: self.mVerticalDisposition,
      hLayoutInVerticalContainer: self.mHorizontalDisposition
    )
  }

  //--------------------------------------------------------------------------------------------------------------------
  //  Last Baseline representative view
  //--------------------------------------------------------------------------------------------------------------------

  private var mLastBaselineRepresentativeView : NSView? = nil

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
      //--- Vertical constraints
        switch view.pmLayoutSettings.vLayoutInHorizontalContainer {
        case .center :
          self.mConstraints.add (requiresTopOf: self, greaterThanOrEqualToTopOf: view, plus: self.mTopMargin)
          self.mConstraints.add (requiresBottomOf: view, greaterThanOrEqualToBottomOf: self, plus: self.mTopMargin)
          self.mConstraints.add (requiresCenterYOf: view, equalToCenterYOf: self)
        case .fill, .weakFill :
          self.mConstraints.add (requiresTopOf: self, equalToTopOf: view, plus: self.mTopMargin)
          self.mConstraints.add (requiresBottomOf: view, equalToBottomOf: self, plus: self.mBottomMargin)
        case .weakFillIgnoringMargins :
          self.mConstraints.add (requiresTopOf: self, equalToTopOf: view)
          self.mConstraints.add (requiresBottomOf: view, equalToBottomOf: self)
        case .bottom :
          self.mConstraints.add (requiresTopOf: self, greaterThanOrEqualToTopOf: view, plus: self.mTopMargin)
          self.mConstraints.add (requiresBottomOf: view, equalToBottomOf: self, plus: self.mBottomMargin)
        case .top :
          self.mConstraints.add (requiresTopOf: self, equalToTopOf: view, plus: self.mTopMargin)
          self.mConstraints.add (requiresBottomOf: view, greaterThanOrEqualToBottomOf: self, plus: self.mTopMargin)
        case .lastBaseline :
          if let viewLastBaselineRepresentativeView = view.pmLastBaselineRepresentativeView {
            self.mConstraints.add (requiresTopOf: self, greaterThanOrEqualToTopOf: view, plus: self.mTopMargin)
            self.mConstraints.add (requiresBottomOf: view, greaterThanOrEqualToBottomOf: self, plus: self.mTopMargin)
            self.mConstraints.add (requiresTopOf: self, equalToTopOf: view, plus: self.mTopMargin, withCompressionResistancePriorityOf: .secondView)
            self.mConstraints.add (requiresBottomOf: view, equalToBottomOf: self, plus: self.mTopMargin, withCompressionResistancePriorityOf: .firstView)
            if let lastBaselineRepresentativeView = self.mLastBaselineRepresentativeView {
              self.mConstraints.add (requiresLastBaselineOf: viewLastBaselineRepresentativeView, equalToLastBaselineOf: lastBaselineRepresentativeView)
            }else{
              self.mLastBaselineRepresentativeView = view
            }
          }else{
            self.mConstraints.add (requiresTopOf: self, equalToTopOf: view, plus: self.mTopMargin)
            self.mConstraints.add (requiresBottomOf: view, equalToBottomOf: self, plus: self.mBottomMargin)
          }
        }
      //--- Horizontal constraints
        if let lastView = optionalLastView {
          let spacing = self.isFlexibleSpace (view) ? 0.0 : self.mSpacing
          self.mConstraints.add (requiresLeftOf: view, equalToRightOf: lastView, plus: spacing)
        }else{
          self.mConstraints.add (requiresLeftOf: view, equalToLeftOf: self, plus: self.mLeftMargin)
        }
      //--- Handle width constraint for views with lower hugging priority
        if self.isFlexibleSpace (view) {
          if let refView = optionalLastFlexibleSpace {
            self.mConstraints.add (requiresWidthOf: refView, equalToWidthOf: view)
          }
          optionalLastFlexibleSpace = view
        }
        if self.isVerticalDivider (view) {
          optionalLastFlexibleSpace = nil
        }
      //---
        optionalLastView = view
      }
    }
  //--- Add right constraint for last view
    if let lastView = optionalLastView {
      self.mConstraints.add (requiresRightOf: self, equalToRightOf: lastView, plus: self.mRightMargin)
    }
  //--- Apply constaints
    self.addConstraints (self.mConstraints)
  //--- This should the last instruction: call super method
    super.updateConstraints ()
  }

  //--------------------------------------------------------------------------------------------------------------------

//  override func draw (_ inDirtyRect : NSRect) {
//    super.draw (inDirtyRect)
//    let r = self.bounds.insetBy (dx: 0.5, dy: 0.5)
//    if !r.isEmpty {
//      let bp = NSBezierPath (rect: r)
//      bp.lineWidth = 1.0
//      NSColor.black.setStroke ()
//      bp.stroke ()
//    }
//  }

  //--------------------------------------------------------------------------------------------------------------------

}

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
