//
//  EBLabel.swift
//  essai-custom-stack-view
//
//  Created by Pierre Molinaro on 19/10/2019.
//  Copyright © 2019 Pierre Molinaro. All rights reserved.
//
//----------------------------------------------------------------------------------------------------------------------

import Cocoa

//----------------------------------------------------------------------------------------------------------------------

class EBLabel : NSTextField {

  //····················································································································
  // INIT
  //····················································································································

  init (_ inTitle : String, bold inBold : Bool = false) {
    super.init (frame: NSRect ())
    self.stringValue = inTitle
    self.isBezeled = false
    self.isBordered = false
    self.backgroundColor = debugBackgroundColor ()
    self.drawsBackground = self.backgroundColor != nil
    self.textColor = .black
    self.isEnabled = true
    self.isEditable = false
    self.font = inBold ? NSFont.boldSystemFont (ofSize: NSFont.systemFontSize) : NSFont.systemFont (ofSize: NSFont.systemFontSize)
  }

  //····················································································································

  required init? (coder: NSCoder) {
    fatalError ("init(coder:) has not been implemented")
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
  // SET TEXT color
  //····················································································································

  @discardableResult func setTextColor (_ inTextColor : NSColor) -> Self {
    self.textColor = inTextColor
    return self
  }

  //····················································································································
  // SET TITLE ALIGNMENT
  //····················································································································

  @discardableResult func setTitleAlignment (_ inAlignment : NSTextAlignment) -> Self {
    self.alignment = inAlignment
    return self
  }

  //····················································································································

}

//----------------------------------------------------------------------------------------------------------------------
