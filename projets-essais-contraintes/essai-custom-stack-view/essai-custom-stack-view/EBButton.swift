//
//  EBButton.swift
//  essai-custom-stack-view
//
//  Created by Pierre Molinaro on 19/10/2019.
//  Copyright © 2019 Pierre Molinaro. All rights reserved.
//

import Cocoa

class EBButton : NSButton {

  @IBInspectable var _HasPreceedingSeparator : Bool = false

  override var hasPreceedingSeparator : Bool { return _HasPreceedingSeparator }

}
