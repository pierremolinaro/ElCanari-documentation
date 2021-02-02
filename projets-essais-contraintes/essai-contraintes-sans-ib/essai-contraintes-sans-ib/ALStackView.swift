//
//  ALStackView.swift
//  essai-contraintes-sans-ib
//
//  Created by Pierre Molinaro on 01/02/2021.
//
//----------------------------------------------------------------------------------------------------------------------

import Cocoa

//----------------------------------------------------------------------------------------------------------------------

var gCurrentStack : ALStackView? = nil

//----------------------------------------------------------------------------------------------------------------------

class ALStackView : NSStackView {

  //····················································································································
  //   INIT
  //····················································································································

  init (orientation inOrientation : NSUserInterfaceLayoutOrientation) {
    super.init (frame: NSRect ())
    self.orientation = inOrientation
  }

  //····················································································································

  required init? (coder: NSCoder) {
    fatalError ("init(coder:) has not been implemented")
  }

  //····················································································································
  //  MARGINS
  //····················································································································

  @discardableResult func noMargin () -> Self {
    self.edgeInsets.left   = 0.0
    self.edgeInsets.top    = 0.0
    self.edgeInsets.right  = 0.0
    self.edgeInsets.bottom = 0.0
    return self
  }

  //····················································································································

  @discardableResult func setMargins (_ inValue : CGFloat) -> Self {
    self.edgeInsets.left   = inValue
    self.edgeInsets.top    = inValue
    self.edgeInsets.right  = inValue
    self.edgeInsets.bottom = inValue
    return self
  }

  //····················································································································

  @discardableResult func setTopMargin (_ inValue : CGFloat) -> Self {
    self.edgeInsets.top = inValue
    return self
  }

  //····················································································································

  @discardableResult func setBottomMargin (_ inValue : CGFloat) -> Self {
    self.edgeInsets.bottom = inValue
    return self
  }

  //····················································································································

  @discardableResult func setLeftMargin (_ inValue : CGFloat) -> Self {
    self.edgeInsets.left = inValue
    return self
  }

  //····················································································································

  @discardableResult func setRightMargin (_ inValue : CGFloat) -> Self {
    self.edgeInsets.right = inValue
    return self
  }

  //····················································································································

  @discardableResult func setSpacing (_ inValue : CGFloat) -> Self {
    self.spacing = inValue
    return self
  }

  //····················································································································

}

//----------------------------------------------------------------------------------------------------------------------
