//
//  PMButton.swift
//  essai-gridview
//
//  Created by Pierre Molinaro on 03/11/2023.
//
//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

import AppKit

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

class ALB_NSButton : NSButton {

  //------------------------------------------------------------------------------------------------

  init (title inTitle : String, size inSize : NSControl.ControlSize) {
    super.init (frame: .zero)
    self.pmConfigureForAutolayout (hStretchingResistance: .high, vStrechingResistance: .high)

    self.controlSize = inSize
    self.font = NSFont.systemFont (ofSize: NSFont.systemFontSize (for: self.controlSize))
    self.bezelStyle = .rounded
    self.title = inTitle
    self.lineBreakMode = .byTruncatingTail
  }

  //--------------------------------------------------------------------------------------------------------------------

  required init? (coder: NSCoder) {
    fatalError ("init(coder:) has not been implemented")
  }

  //································································································
  //  Closure action
  //································································································

  final private var mClosureAction : Optional < () -> Void > = nil

  //································································································

  final func setClosureAction (_ inClosureAction : @escaping () -> Void) {
    self.mClosureAction = inClosureAction
    self.target = self
    self.action = #selector (Self.runClosureAction (_:))
  }

  //································································································

   @objc private final func runClosureAction (_ _ : Any?) {
     self.mClosureAction? ()
  }

  //------------------------------------------------------------------------------------------------

}

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
