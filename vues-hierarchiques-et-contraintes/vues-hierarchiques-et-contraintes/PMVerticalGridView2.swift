//
//  PMVerticalGridView2.swift
//  essai-gridview
//
//  Created by Pierre Molinaro on 01/11/2023.
//
//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

import AppKit

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

class PMVerticalGridView2 : PMVerticalStackView {

  //····················································································································

  private var mRows = [(NSView, NSView)] () // left, right

  //····················································································································

  final func append (left inLeftView : NSView, right inRightView : NSView) -> Self {
    let hStack = PMHorizontalStackView (horizontal: .fill, vertical: .fill)
      .set (spacing: self.mHorizontalSpacing)
      .appendView (inLeftView)
      .appendView (inRightView)
    self.mRows.append ((inLeftView, inRightView))
    self.addSubview (hStack)
    return self
  }

  //--------------------------------------------------------------------------------------------------------------------

  private var mHorizontalSpacing : Int = 12

  //--------------------------------------------------------------------------------------------------------------------

  final func set (horizontalSpacing inSpacing : Int) -> Self {
    self.mHorizontalSpacing = inSpacing
    self.invalidateIntrinsicContentSize ()
    return self
  }

  //--------------------------------------------------------------------------------------------------------------------
  //  Constraints
  //--------------------------------------------------------------------------------------------------------------------

  private var mConstraints = [NSLayoutConstraint] ()

  //--------------------------------------------------------------------------------------------------------------------

  override func updateConstraints () {
  //--- Remove all constraints
    self.removeConstraints (self.mConstraints)
    self.mConstraints.removeAll (keepingCapacity: true)
  //--- Constraints for colum alignment
    var optionalLastRow : (NSView, NSView)? = nil
    for row in self.mRows {
      if let lastRow = optionalLastRow {
        self.mConstraints.add (requiresWidthOf: lastRow.0, equalToWidthOf: row.0)
        self.mConstraints.add (requiresWidthOf: lastRow.1, equalToWidthOf: row.1)
      }
      optionalLastRow = row
    }
  //--- Apply constaints
    self.addConstraints (self.mConstraints)
  //--- This should the last instruction: call super method
    super.updateConstraints ()
  }

  //--------------------------------------------------------------------------------------------------------------------

}

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
