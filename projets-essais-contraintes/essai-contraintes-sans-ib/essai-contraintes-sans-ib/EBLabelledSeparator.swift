//
//  EBLabelledSeparator.swift
//  essai-contraintes-sans-ib
//
//  Created by Pierre Molinaro on 29/11/2020.
//
//----------------------------------------------------------------------------------------------------------------------

import Cocoa

//----------------------------------------------------------------------------------------------------------------------

class EBLabelledSeparator : EBHorizontalStackView {

  //····················································································································

  init (_ inTitle : String) {
    super.init ()
    let label = EBLabel (inTitle, bold: true)
    self.addSubview (label)
    let box = NSBox (frame: NSRect ())
    box.boxType = .separator
    self.addSubview (box)
  }

  //····················································································································

  required init?(coder inCoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //····················································································································
  // SET TEXT color
  //····················································································································

  @discardableResult func setTextColor (_ inTextColor : NSColor) -> Self {
    if self.subviews.count > 0, let textfield = self.subviews [0] as? EBLabel {
      textfield.textColor = inTextColor
    }
    return self
  }

  //····················································································································

}

//----------------------------------------------------------------------------------------------------------------------