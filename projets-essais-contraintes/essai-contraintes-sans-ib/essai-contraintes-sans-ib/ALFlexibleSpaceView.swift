//
//  ALFlexibleSpaceView.swift
//  essai-contraintes-sans-ib
//
//  Created by Pierre Molinaro on 28/11/2020.
//
//----------------------------------------------------------------------------------------------------------------------

import Cocoa

//----------------------------------------------------------------------------------------------------------------------
//   ALFlexibleSpaceView
//----------------------------------------------------------------------------------------------------------------------

class ALFlexibleSpaceView : NSView {

  //····················································································································

  init () {
    super.init (frame: NSRect ())
    self.translatesAutoresizingMaskIntoConstraints = false
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

  @objc override func verticalAlignment () -> VerticalAlignment { return .height }

  //····················································································································

//  override var intrinsicContentSize : NSSize {
//    let s = super.intrinsicContentSize
//    Swift.print ("intrinsicContentSize \(s), NSViewNoIntrinsicMetric \(NSView.noIntrinsicMetric)")
//    return s
//  }

  //····················································································································

}

//----------------------------------------------------------------------------------------------------------------------