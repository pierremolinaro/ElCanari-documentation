//
//  Document.swift
//  essai-contraintes-sans-ib
//
//  Created by Pierre Molinaro on 27/11/2020.
//
//----------------------------------------------------------------------------------------------------------------------

import Cocoa

//----------------------------------------------------------------------------------------------------------------------

class Document : NSDocument {

  //····················································································································

  override init() {
    super.init()
    // Add your subclass-specific initialization here.
  }

  //····················································································································

  override class var autosavesInPlace : Bool {
    return false
  }

  //····················································································································

  override func read (from data: Data, ofType typeName: String) throws {
    // Insert code here to read your document from the given data of the specified type, throwing an error in case of failure.
    // Alternatively, you could remove this method and override read(from:ofType:) instead.
    // If you do, you should also override isEntireFileLoaded to return false if the contents are lazily loaded.
    throw NSError (domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
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
//    let deadline = DispatchTime.now () + DispatchTimeInterval.seconds (3)
//    DispatchQueue.main.asyncAfter (deadline: deadline) {
//      let view = self.buildUserInterface ()
//      window.contentView = view
//    }
    DispatchQueue.main.async {
      let view = self.buildUserInterface ()
      window.contentView = view
    }
    let progressIndicator = NSProgressIndicator (frame: NSRect ())
    progressIndicator.isIndeterminate = true
    progressIndicator.style = .spinning
    progressIndicator.usesThreadedAnimation = true
    progressIndicator.startAnimation (nil)
    let view = ALVerticalStackView ()
    view.setLeftMargin ((window.frame.size.width - 32.0) / 2.0)
    view.setRightMargin ((window.frame.size.width - 32.0) / 2.0)
    view.setTopMargin ((window.frame.size.height - 32.0) / 2.0)
    view.setBottomMargin ((window.frame.size.height - 32.0) / 2.0)
    view.addView (progressIndicator, in: .leading)
    window.contentView = view
  }

  //····················································································································

  override func data (ofType typeName: String) throws -> Data {
    // Insert code here to write your document to data of the specified type, throwing an error in case of failure.
    // Alternatively, you could remove this method and override fileWrapper(ofType:), write(to:ofType:), or write(to:ofType:for:originalContentsURL:) instead.
    throw NSError (domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
  }

  //····················································································································

  func buildUserInterface () -> NSView {
  //  showDebugBackground ()
    return ALPageView { ALButton.make ("Avant") ; ALButton.make ("Droite") }
      .addPage ("First") {
         ALLabelledTextField.make ("First page", 100.0, spaceBefore: true)
         space ()
         ALLabelledTextField.make ("Below", 100.0, spaceBefore: true)
         space ()
         ALLabelledTextField.make ("Bottom", 100.0, spaceBefore: true)
      }
      .addPage ("Second") {
        self.buildSecondPage ()
      }
      .setMargins (5.0)
  }

  //····················································································································

  func buildSecondPage () {
    ALLabelledSeparator.make ("Un Point").setTextColor (.darkGray)
    hStack {
      ALLabel.make ("P") ; space () ; vStack { ALLabelledTextField.make ("X", 100.0, spaceBefore: false) ; ALLabelledTextField.make ("Y", 100.0, spaceBefore: false)}
    }
    ALLabelledSeparator.make ("Autre réglage").setTextColor (.darkGray)
    ALLabelledTextField.make ("Titre", 100.0, spaceBefore: true)
    ALLabelledTextField.make ("Titre long", 100.0, spaceBefore: true)
    ALLabelledTextField.make ("Autre titre", 100.0, spaceBefore: true)
    ALLabelledTextField.make ("Autre titre long", 100.0, spaceBefore: true)
//    space ()
    ALButton.make ("bouton 4").setFlexibleWidth ()
    hStack {
      vStack {
        ALButton.make ("v bt1")
        ALButton.make ("v bt2")
      }
  //    space ()
      ALLabel.make ("Hello left")
      ALButton.make ("bouton long 3").setFlexibleWidth ()
 //     space ()
      ALLabel.make ("Hello")
    }.setFlexibleWidth ()
    space ()
  }

  //····················································································································

  func buildUserInterfaceEx () -> NSView {
  //  showDebugBackground ()
    return vStack {
      space ()
      ALLabelledSeparator.make ("Réglage").setTextColor (.darkGray)
      ALLabelledTextField.make ("Titre", 100.0, spaceBefore: true)
      ALLabelledTextField.make ("Titre long", 100.0, spaceBefore: true)
      ALLabelledSeparator.make ("Autre réglage").setTextColor (.darkGray)
      ALLabelledTextField.make ("Autre titre", 100.0, spaceBefore: true)
      ALLabelledTextField.make ("Autre titre long", 100.0, spaceBefore: true)
      space ()
      ALButton.make ("bouton 4")
      hStack {
        vStack {
          ALButton.make ("v bt1")
          ALButton.make ("v bt2")
        }
        ALButton.make ("bouton long 3")
        ALLabel.make ("Hello")
        space ()
      } // .sameWidth (true)
      space ()
    }// .setMargins (5.0)
  }

  //····················································································································

}

//----------------------------------------------------------------------------------------------------------------------
