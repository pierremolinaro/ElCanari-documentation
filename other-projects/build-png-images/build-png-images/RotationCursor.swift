//
//  RotationCursor.swift
//  build-png-images
//
//  Created by Pierre Molinaro on 23/08/2020.
//  Copyright © 2020 Pierre Molinaro. All rights reserved.
//
//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

import Cocoa

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

class RotationCursor : NSView {

  //····················································································································

  override var isFlipped: Bool { return false }

  //····················································································································
  //  Draw
  //····················································································································

  override func draw (_ inDirtyRect : NSRect) {
//    NSColor.yellow.setFill ()
//    __NSRectFill (inDirtyRect)
  //---
    NSColor.black.setStroke ()
    let bp = NSBezierPath ()
    bp.lineWidth = 1.0
    bp.lineCapStyle = .round
  //--- Horizontal lines
    bp.move (to: NSPoint (x: 2.0, y: 8.0))
    bp.curve (
      to: NSPoint (x: 14.0, y: 8.0),
      controlPoint1: NSPoint (x:  2.0, y: 16.0),
      controlPoint2: NSPoint (x: 14.0, y: 16.0)
  )
  //--- Arrows
    bp.move (to: NSPoint (x: 2.0, y: 8.0))
    bp.line (to: NSPoint (x: 0.0, y: 10.0))
    bp.move (to: NSPoint (x: 2.0, y: 8.0))
    bp.line (to: NSPoint (x: 4.0, y: 10.0))
    bp.move (to: NSPoint (x: 14.0, y: 8.0))
    bp.line (to: NSPoint (x: 12.0, y: 10.0))
    bp.move (to: NSPoint (x: 14.0, y: 8.0))
    bp.line (to: NSPoint (x: 16.0, y: 10.0))
//  //--- Vertical lines
//    bp.move (to: NSPoint (x: 8.0, y: 0.0))
//    bp.line (to: NSPoint (x: 8.0, y: 16.0))
//    bp.move (to: NSPoint (x: 7.0, y: 1.0))
//    bp.line (to: NSPoint (x: 7.0, y: 15.0))
//    bp.move (to: NSPoint (x: 9.0, y: 1.0))
//    bp.line (to: NSPoint (x: 9.0, y: 15.0))
//  //--- Vertical arrows
//    bp.move (to: NSPoint (x: 8.0, y: 0.0))
//    bp.line (to: NSPoint (x: 5.0, y: 3.0))
//    bp.move (to: NSPoint (x: 8.0, y: 0.0))
//    bp.line (to: NSPoint (x: 11.0, y: 3.0))
//    bp.move (to: NSPoint (x: 8.0, y: 16.0))
//    bp.line (to: NSPoint (x: 5.0, y: 13.0))
//    bp.move (to: NSPoint (x: 8.0, y: 16.0))
//    bp.line (to: NSPoint (x: 11.0, y: 13.0))

  //---
    bp.stroke ()
  }

  //····················································································································

}

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
