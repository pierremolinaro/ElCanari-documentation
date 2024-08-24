//
//  AutoLayoutView.swift
//  vues-hierarchiques-et-contraintes
//
//  Created by Pierre Molinaro on 11/08/2024.
//
//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

import AppKit

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

class AutoLayoutView {

  //------------------------------------------------------------------------------------------------

  private var mCocoaView : NSView
  var cocoaView : NSView {self.mCocoaView }

  //------------------------------------------------------------------------------------------------

  init () {
    self.mCocoaView = NSView ()
  }

  //------------------------------------------------------------------------------------------------
  //  View hierarchy
  //------------------------------------------------------------------------------------------------

  private weak var mSuperView : AutoLayoutView? = nil
  private var mSubViews = [AutoLayoutView] ()

  //------------------------------------------------------------------------------------------------

  final func removeFromSuperView () {
    if let superView = self.mSuperView {
      self.mCocoaView.removeFromSuperview ()
      superView.mSubViews.removeAll (where: { $0 === self } )
      self.mSuperView = nil
    }
  }

  //------------------------------------------------------------------------------------------------

  final func append (_ inView : AutoLayoutView) -> Self {
    inView.removeFromSuperView ()
    self.mSubViews.append (inView)
    inView.mSuperView = self
    self.mCocoaView.addSubview (inView.mCocoaView)
    return self
  }

  //--------------------------------------------------------------------------------------------------------------------

  func prependView (_ inView : AutoLayoutView) -> Self {
     inView.removeFromSuperView ()
    self.mSubViews.insert (inView, at: 0)
    inView.mSuperView = self
    self.mCocoaView.addSubview (inView.mCocoaView, positioned: .below, relativeTo: nil)
    return self
  }

  //------------------------------------------------------------------------------------------------

}

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
