//
//  EBButton.swift
//  essai-custom-stack-view
//
//  Created by Pierre Molinaro on 19/10/2019.
//  Copyright © 2019 Pierre Molinaro. All rights reserved.
//
//----------------------------------------------------------------------------------------------------------------------

import Cocoa

//----------------------------------------------------------------------------------------------------------------------

class EBButton : NSButton {

  //····················································································································

  init (_ inTitle : String) {
    super.init (frame: NSRect ())
    self.title = inTitle
    self.font = NSFont.systemFont (ofSize: NSFont.systemFontSize)
    self.bezelStyle = .roundRect
  }

  //····················································································································

  required init? (coder inCoder : NSCoder) {
    super.init (coder: inCoder)
  }

  //····················································································································
  // VERTICAL ALIGNMENT
  //····················································································································

  fileprivate var mVerticalAlignment = VerticalAlignment.lastBaseline

  //····················································································································

  @discardableResult func setVerticalAlignment (_ inAlignment : VerticalAlignment) -> Self {
    self.mVerticalAlignment = inAlignment
    return self
  }

  //····················································································································

  override func verticalAlignment () -> VerticalAlignment { return self.mVerticalAlignment }

  //····················································································································

}

//----------------------------------------------------------------------------------------------------------------------
