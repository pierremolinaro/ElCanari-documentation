//
//  Document.swift
//  essai-contraintes-sans-ib
//
//  Created by Pierre Molinaro on 27/11/2020.
//
//----------------------------------------------------------------------------------------------------------------------

import Cocoa

//----------------------------------------------------------------------------------------------------------------------

class Document: NSDocument {

  //····················································································································

  override init() {
    super.init()
    // Add your subclass-specific initialization here.
  }

  //····················································································································

  override class var autosavesInPlace: Bool {
    return false
  }

  //····················································································································

  override func makeWindowControllers () {
  //--- Create the window and set the content view.
    let window = NSWindow (
      contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
      styleMask: [.titled, .closable, .miniaturizable, .resizable],
      backing: .buffered,
      defer: false
    )
    window.isReleasedWhenClosed = false
    window.center ()
  //---
    let windowController = NSWindowController (window: window)
    self.addWindowController (windowController)
  //--- Build user interface
    let view = self.buildUserInterface ()
    window.contentView = view
  }

  //····················································································································

  override func data (ofType typeName: String) throws -> Data {
    // Insert code here to write your document to data of the specified type, throwing an error in case of failure.
    // Alternatively, you could remove this method and override fileWrapper(ofType:), write(to:ofType:), or write(to:ofType:for:originalContentsURL:) instead.
    throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
  }

  //····················································································································

  override func read (from data: Data, ofType typeName: String) throws {
    // Insert code here to read your document from the given data of the specified type, throwing an error in case of failure.
    // Alternatively, you could remove this method and override read(from:ofType:) instead.
    // If you do, you should also override isEntireFileLoaded to return false if the contents are lazily loaded.
    throw NSError (domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
  }

  //····················································································································

  func buildUserInterface () -> NSView {
  //  showDebugBackground ()
    return vStack {
      space ()
      labelledSeparator ("Réglage").setTextColor (.darkGray)
      labelledTextField ("titre", 100.0)
      labelledTextField ("titre long", 100.0)
      space ()
       button ("bouton 4")
     hStack {
        button ("bn1")
        button ("bouton2g")
        vStack {
          button ("v bt1")
          button ("v bt2")
        }
        button ("bouton long 3")
        label ("Hello")
        space ()
      } // .sameWidth (true)
      space ()
    }.setMargins (5.0)
  }

  //····················································································································

}

//----------------------------------------------------------------------------------------------------------------------

var gCurrentStack : EBAbstractStackView? = nil

//----------------------------------------------------------------------------------------------------------------------

@discardableResult func hStack (_ inContents : () -> Void) -> EBHorizontalStackView {
  let savedCurrentStack = gCurrentStack
  let h = EBHorizontalStackView ()
  savedCurrentStack?.addSubview (h)
  gCurrentStack = h
  inContents ()
  gCurrentStack = savedCurrentStack
  return h
}

//----------------------------------------------------------------------------------------------------------------------

@discardableResult func vStack (_ inContents : () -> Void) -> EBVerticalStackView {
  let savedCurrentStack = gCurrentStack
  let v = EBVerticalStackView ()
  savedCurrentStack?.addSubview (v)
  gCurrentStack = v
  inContents ()
  gCurrentStack = savedCurrentStack
  return v
}

//----------------------------------------------------------------------------------------------------------------------

@discardableResult func button (_ title : String) -> EBButton {
  let b = EBButton (title)
  gCurrentStack?.addSubview (b)
  return b
}

//----------------------------------------------------------------------------------------------------------------------

func space () {
  gCurrentStack?.addSubview (EBFlexibleSpaceView ())
}

//----------------------------------------------------------------------------------------------------------------------

@discardableResult func label (_ title : String, bold inBold : Bool = false) -> EBLabel {
  let b = EBLabel (title, bold: inBold)
  gCurrentStack?.addSubview (b)
  return b
}

//----------------------------------------------------------------------------------------------------------------------

@discardableResult func labelledSeparator (_ title : String) -> EBLabelledSeparator {
  let b = EBLabelledSeparator (title)
  gCurrentStack?.addSubview (b)
  return b
}

//----------------------------------------------------------------------------------------------------------------------

@discardableResult func labelledTextField (_ inTitle : String, _ inTextFieldWidth : CGFloat) -> EBLabelledTextField {
  let b = EBLabelledTextField (inTitle, inTextFieldWidth)
  gCurrentStack?.addSubview (b)
  return b
}

//----------------------------------------------------------------------------------------------------------------------
