//
//  PMButton.swift
//  essai-gridview
//
//  Created by Pierre Molinaro on 03/11/2023.
//
//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

import AppKit

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

class PMButton : NSButton {

  //------------------------------------------------------------------------------------------------

  init (title inTitle : String, size inSize : NSControl.ControlSize) {
    super.init (frame: .zero)
    self.pmConfigureForAutolayout (hStretchingResistance: .high, vStrechingResistance: .high)

    self.controlSize = inSize
    self.font = NSFont.systemFont (ofSize: NSFont.systemFontSize (for: self.controlSize))
    self.bezelStyle = .rounded
    self.title = inTitle
  }

  //--------------------------------------------------------------------------------------------------------------------

  required init? (coder: NSCoder) {
    fatalError ("init(coder:) has not been implemented")
  }

  //------------------------------------------------------------------------------------------------

}

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
