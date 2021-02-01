//
//  ALLabelledSeparator.swift
//  essai-contraintes-sans-ib
//
//  Created by Pierre Molinaro on 29/11/2020.
//
//----------------------------------------------------------------------------------------------------------------------

import Cocoa

//----------------------------------------------------------------------------------------------------------------------

class ALLabelledSeparator : ALHorizontalStackView {

  //····················································································································

  init (_ inTitle : String) {
    super.init ()
    self.translatesAutoresizingMaskIntoConstraints = false
    let label = ALLabel (inTitle, bold: true)
    self.addSubview (label)
    let box = NSBox (frame: NSRect ())
    box.translatesAutoresizingMaskIntoConstraints = false
    box.boxType = .separator
    self.addSubview (box)
  }

  //····················································································································

  required init?(coder inCoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //····················································································································

  @discardableResult static func make (_ title : String) -> ALLabelledSeparator {
    let b = ALLabelledSeparator (title)
    gCurrentStack?.addSubview (b)
    return b
  }

  //····················································································································
  // SET TEXT color
  //····················································································································

  @discardableResult func setTextColor (_ inTextColor : NSColor) -> Self {
    if self.subviews.count > 0, let textfield = self.subviews [0] as? ALLabel {
      textfield.textColor = inTextColor
    }
    return self
  }

  //····················································································································

}

//----------------------------------------------------------------------------------------------------------------------
