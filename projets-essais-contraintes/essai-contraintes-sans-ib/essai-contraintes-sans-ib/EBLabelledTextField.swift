//
//  EBLabelledTextField.swift
//  essai-contraintes-sans-ib
//
//  Created by Pierre Molinaro on 29/11/2020.
//
//----------------------------------------------------------------------------------------------------------------------

import Cocoa

//----------------------------------------------------------------------------------------------------------------------

class EBLabelledTextField : EBHorizontalStackView {

  //····················································································································

  init (_ inTitle : String, _ inTextfieldWidth : CGFloat) {
    super.init ()
    let label = EBLabel (inTitle).setTitleAlignment (.right)
    self.addSubview (label)
    let textfield = EBTextField (inTextfieldWidth)
    self.addSubview (textfield)
  }

  //····················································································································

  required init?(coder inCoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //····················································································································
  // SET TEXT color
  //····················································································································

  @discardableResult func setTextColor (_ inTextColor : NSColor) -> Self {
    if self.subviews.count > 0, let textfield = self.subviews [0] as? EBTextField {
      textfield.textColor = inTextColor
    }
    return self
  }

  //····················································································································

}

//----------------------------------------------------------------------------------------------------------------------
