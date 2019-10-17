//
//  extension-NSView-layout.swift
//  essai-contraintes
//
//  Created by Pierre Molinaro on 16/10/2019.
//  Copyright © 2019 Pierre Molinaro. All rights reserved.
//

import Cocoa

extension NSView {

  func setLeftFromSuperView (_ inDistance : CGFloat) {
    if let superview = self.superview {
      let c = self.leftAnchor.constraint (equalTo: superview.leftAnchor, constant: inDistance)
      c.isActive = true
    }
  }

  func setRightFromSuperView (_ inDistance : CGFloat) {
    if let superview = self.superview {
      let c = self.rightAnchor.constraint (equalTo: superview.rightAnchor, constant: inDistance)
      c.isActive = true
    }
  }

  func setTopFromSuperView (_ inDistance : CGFloat) {
    if let superview = self.superview {
      let c = self.topAnchor.constraint (equalTo: superview.topAnchor, constant: -inDistance)
      c.isActive = true
    }
  }

  func setBottomFromSuperView (_ inDistance : CGFloat) {
    if let superview = self.superview {
      let c = self.bottomAnchor.constraint (equalTo: superview.bottomAnchor, constant: -inDistance)
      c.isActive = true
    }
  }

  func setMinimumWidth (_ inDistance : CGFloat) {
    let c = self.widthAnchor.constraint (greaterThanOrEqualToConstant: inDistance)
    c.isActive = true
  }

  func setMinimumHeight (_ inDistance : CGFloat) {
    let c = self.heightAnchor.constraint (greaterThanOrEqualToConstant: inDistance)
    c.isActive = true
  }

  func setExactWidth (_ inDistance : CGFloat) {
    let c = self.widthAnchor.constraint (equalToConstant: inDistance)
    c.isActive = true
  }

  func setExactHeight (_ inDistance : CGFloat) {
    let c = self.heightAnchor.constraint (equalToConstant: inDistance)
     c.isActive = true
  }

//  func setLeftFromSuperView (_ inDistance : CGFloat) {
//    if let superview = self.superview {
//      let c = NSLayoutConstraint (item: self, attribute: .left, relatedBy: .equal, toItem: superview, attribute: .left, multiplier: 1.0, constant: inDistance)
//      c.priority = .required
//      superview.addConstraint (c)
//    }
//  }
//
//  func setRightFromSuperView (_ inDistance : CGFloat) {
//    if let superview = self.superview {
//      let c = NSLayoutConstraint (item: self, attribute: .right, relatedBy: .equal, toItem: superview, attribute: .right, multiplier: 1.0, constant: inDistance)
//      c.priority = .required
//      superview.addConstraint (c)
//    }
//  }
//
//  func setTopFromSuperView (_ inDistance : CGFloat) {
//    if let superview = self.superview {
//      let c = NSLayoutConstraint (item: self, attribute: .top, relatedBy: .equal, toItem: superview, attribute: .top, multiplier: 1.0, constant: -inDistance)
//      c.priority = .required
//      superview.addConstraint (c)
//    }
//  }
//
//  func setBottomFromSuperView (_ inDistance : CGFloat) {
//    if let superview = self.superview {
//      let c = NSLayoutConstraint (item: self, attribute: .bottom, relatedBy: .equal, toItem: superview, attribute: .bottom, multiplier: 1.0, constant: -inDistance)
//      c.priority = .required
//      superview.addConstraint (c)
//    }
//  }
//
//  func setMinimumWidth (_ inDistance : CGFloat) {
//    let c = NSLayoutConstraint (item: self, attribute: .width, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: inDistance)
//    c.priority = .fittingSizeCompression
//    self.addConstraint (c)
//  }
//
//  func setMinimumHeight (_ inDistance : CGFloat) {
//    let c = NSLayoutConstraint (item: self, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: inDistance)
//    c.priority = .fittingSizeCompression
//    self.addConstraint (c)
//  }
//
//  func setExactWidth (_ inDistance : CGFloat) {
//    let c = NSLayoutConstraint (item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: inDistance)
//    c.priority = .required
//    self.addConstraint (c)
//  }
//
//  func setExactHeight (_ inDistance : CGFloat) {
//    let c = NSLayoutConstraint (item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: inDistance)
//    c.priority = .required
//    self.addConstraint (c)
//  }
}

