//
//  ALFlexibleSpaceView.swift
//  essai-contraintes-sans-ib
//
//  Created by Pierre Molinaro on 28/11/2020.
//
//----------------------------------------------------------------------------------------------------------------------

import Cocoa

//----------------------------------------------------------------------------------------------------------------------

func space () {
  gCurrentStack?.addView (ALFlexibleSpaceView (), in: .leading)
}

//----------------------------------------------------------------------------------------------------------------------
//   ALFlexibleSpaceView
//----------------------------------------------------------------------------------------------------------------------

class ALFlexibleSpaceView : NSView {

  //····················································································································

  init () {
    super.init (frame: NSRect ())
    self.translatesAutoresizingMaskIntoConstraints = false
    self.setContentHuggingPriority (.init (rawValue: 1.0), for: .horizontal)
    self.setContentHuggingPriority (.init (rawValue: 1.0), for: .vertical)
  }

  //····················································································································

  required init? (coder: NSCoder) {
    fatalError ("init(coder:) has not been implemented")
  }

  //····················································································································

  override func draw (_ inDirtyRect : NSRect) {
    if let color = debugBackgroundColor () {
      color.setFill ()
      NSBezierPath.fill (inDirtyRect)
    }
  }

  //····················································································································

}

//----------------------------------------------------------------------------------------------------------------------
