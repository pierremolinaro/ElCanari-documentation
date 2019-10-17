//
//  MyView.swift
//  essai-contraintes
//
//  Created by Pierre Molinaro on 16/10/2019.
//  Copyright © 2019 Pierre Molinaro. All rights reserved.
//

import Cocoa

class MyView : NSView {


  override func draw (_ dirtyRect: NSRect) {
    NSColor.yellow.setFill ()
    NSBezierPath.fill (dirtyRect)
    super.draw (dirtyRect)
  }
}

