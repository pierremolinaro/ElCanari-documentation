//
//  Document.swift
//  essai-ui
//
//  Created by Pierre Molinaro on 30/09/2020.
//

import Cocoa
import SwiftUI

class Document: NSDocument, ObservableObject {
  @Published var mMonChoix = false {
    didSet {
      self.undoManager?.registerUndo (withTarget: self, handler: { $0.mMonChoix = oldValue })
    }
  }

  func toggle () {
    self.mMonChoix.toggle ()
  }

  override init() {
    super.init()
  }

  override class var autosavesInPlace: Bool {
    return true
  }


  override func makeWindowControllers() {
    // Create the SwiftUI view that provides the window contents.
    let contentView = MyContentView (mDocument: self)

    // Create the window and set the content view.
    let window = NSWindow(
        contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
        styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
        backing: .buffered, defer: false)
    window.isReleasedWhenClosed = false
    window.center()
    window.contentView = NSHostingView(rootView: contentView)
    let windowController = NSWindowController(window: window)
    self.addWindowController(windowController)
  }

  override func data(ofType typeName: String) throws -> Data {
    var data = Data ()
    data.append(self.mMonChoix ? 1 : 0)
    return data
  }

  override func read(from data: Data, ofType typeName: String) throws {
    if data.count == 1 {
      if data [0] == 0 {
        self.mMonChoix = false
        return
      }else if data [0] == 1 {
        self.mMonChoix = true
        return
      }
    }
    throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
  }


}

