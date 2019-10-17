//
//  AppDelegate.swift
//  essai-contraintes
//
//  Created by Pierre Molinaro on 11/10/2019.
//  Copyright © 2019 Pierre Molinaro. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  @IBOutlet weak var window: NSWindow!

  var myView = MyView (color: .lightGray)
  var vueCachable = MyView (color: .purple)
  let button = EBButton (title: "Press!")
  let autreButton = EBButton (title: "Toggle")
  let textField = NSTextField ()
  let label = EBLabel (title: "Hello")
  let autreLabel = EBLabel (title: "Un autre label")
  let troisièmeLabel = EBLabel (title: "Troisième label")

  func applicationDidFinishLaunching (_ aNotification : Notification) {
    let contentView = window.contentView!
    var displayDictionary = [ObjectIdentifier : String] ()
    displayDictionary [ObjectIdentifier (contentView)] = "ContentView"
    displayDictionary [ObjectIdentifier (self.myView)] = "myView"
    displayDictionary [ObjectIdentifier (self.button)] = "Button"
    displayDictionary [ObjectIdentifier (self.textField)] = "textField"
    displayDictionary [ObjectIdentifier (self.label)] = "label"

    myView.addSubview (self.vueCachable)
    self.vueCachable.layout (.top, .equal, superview: .top)
    self.vueCachable.layout (.left, .equal, superview: .left)
    self.vueCachable.layout (.right, .equal, superview: .centerX)
    self.vueCachable.layout (.height, .equal, 50.0)

    myView.addSubview (self.autreButton)
    self.autreButton.layout (.top, .equal, superview: .top)
    self.autreButton.layout (.left, .equal, superview: .left)
    self.autreButton.target = self
    self.autreButton.action = #selector (self.autreButtonAction (_:))

    myView.addSubview (self.autreLabel)
    self.autreLabel.layout (.top, .equal, to: vueCachable, .bottom, plus: 8.0)
    self.autreLabel.layout (.left, .equal, superview: .left)

    myView.addSubview (self.troisièmeLabel)
    self.troisièmeLabel.layout (.top, .equal, to: autreLabel, .bottom, plus: 8.0)
    self.troisièmeLabel.layout (.left, .equal, superview: .left)

    myView.addSubview (self.button)
    self.button.layout (.centerX, .equal, superview: .centerX)
    self.button.layout (.centerY, .equal, superview: .centerY)
    self.button.layout (.width, .equal, 100.0)
    self.button.layout (.height, .equal, 20.0)
    self.button.target = self
    self.button.action = #selector (self.buttonAction (_:))

    self.textField.translatesAutoresizingMaskIntoConstraints = false
    myView.addSubview (self.textField)
    self.textField.layout (.centerX, .equal, superview: .centerX)
    self.textField.layout (.top, .equal, to: self.button, .bottom, plus: 8.0)
    self.textField.layout (.width, .greaterThanOrEqual, 100.0)
    self.textField.layout (.height, .greaterThanOrEqual, 20.0)

    myView.addSubview (self.label)
    self.label.layout (.centerX, .equal, superview: .centerX)
    self.label.layout (.top, .equal, to: self.textField, .bottom, plus: 8.0)
    self.label.layout (.width, .equal, 100.0)
 //   self.label.layout (.height, .equal, 20.0)

//    self.myView.displayConstraints(displayDictionary)
//    self.button.displayConstraints(displayDictionary)
//    self.textField.displayConstraints(displayDictionary)
//
//   Swift.print ("************************")

    contentView.addSubview (self.myView)
    self.myView.layout (.right, .equal, superview: .right, plus: -20.0)
    self.myView.layout (.left, .equal, superview: .left, plus: 20.0)
    self.myView.layout (.top, .equal, superview: .top, plus: 20.0)
    self.myView.layout (.bottom, .equal, superview: .bottom, plus: -20.0)
//    self.myView.layout (.width, .greaterThanOrEqual, 200.0)
//    self.myView.layout (.height, .greaterThanOrEqual, 200.0)


//    contentView.superview?.displayConstraints(displayDictionary)
//    contentView.displayConstraints(displayDictionary)
//    self.myView.displayConstraints(displayDictionary)
//    self.button.displayConstraints(displayDictionary)


 //   self.window.visualizeConstraints (self.window.contentView!.constraintsAffectingLayout (for: .horizontal))
  }


  @objc func buttonAction (_ inSender : Any?) {
    self.label.stringValue += "Z"
  }

  @objc func autreButtonAction (_ inSender : Any?) {
    self.vueCachable.isHidden = !self.vueCachable.isHidden
    for c in self.autreLabel.constraints {
      if c.firstAttribute == .top {
        self.autreLabel.removeConstraint (c)
        if self.vueCachable.isHidden {
          self.autreLabel.layout (.top, .equal, to: self.autreButton, .bottom, plus: 8.0)
        }else{
          self.autreLabel.layout (.top, .equal, to: self.vueCachable, .bottom, plus: 8.0)
        }
      }

    }
    for c in self.vueCachable.constraints {
      if c.firstAttribute == .height {
        c.constant = self.vueCachable.isHidden ? self.autreButton.frame.size.height : 50.0
      }
    }
  }


}

