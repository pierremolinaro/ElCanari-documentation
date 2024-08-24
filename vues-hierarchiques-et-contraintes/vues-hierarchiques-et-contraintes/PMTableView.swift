//
//  PMTableView.swift
//  essai-gridview
//
//  Created by Pierre Molinaro on 02/11/2023.
//
//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

import AppKit

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

class PMTableView : NSTableView {

  //--------------------------------------------------------------------------------------------------------------------

  init (size inSize : NSControl.ControlSize) {
    super.init (frame: .zero)
    self.pmConfigureForAutolayout (hStretchingResistance: .low, vStrechingResistance: .low)
    self.controlSize = inSize
    self.font = NSFont.systemFont (ofSize: NSFont.systemFontSize (for: self.controlSize))

    self.addTableColumn (NSTableColumn ())
    self.addTableColumn (NSTableColumn ())
  }

  //--------------------------------------------------------------------------------------------------------------------

  required init? (coder inCoder : NSCoder) {
    fatalError ("init(coder:) has not been implemented")
  }

  //--------------------------------------------------------------------------------------------------------------------

  override var intrinsicContentSize : NSSize { NSSize (width: 100, height: 100) }

  //--------------------------------------------------------------------------------------------------------------------

  private let mDefaultControlLayoutSettings = PMViewLayoutSettings (
    vLayoutInHorizontalContainer: .lastBaseline,
    hLayoutInVerticalContainer: .fill
  )

  //--------------------------------------------------------------------------------------------------------------------

  override var pmLayoutSettings : PMViewLayoutSettings { self.mDefaultControlLayoutSettings }

  //--------------------------------------------------------------------------------------------------------------------

}

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
