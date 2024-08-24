//
//  AutoLayoutWindow.swift
//  vues-hierarchiques-et-contraintes
//
//  Created by Pierre Molinaro on 11/08/2024.
//
//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

import AppKit

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

class AutoLayoutWindow {

  //------------------------------------------------------------------------------------------------

  private var mCocoaVindow : NSWindow
  private var mRootView : AutoLayoutView? = nil

  //------------------------------------------------------------------------------------------------

  init (contentRect inContentRect : NSRect,
        styleMask inStyle : NSWindow.StyleMask) {
    self.mCocoaVindow = NSWindow (
      contentRect: inContentRect,
      styleMask: inStyle, // [.titled, .resizable],
      backing: .buffered,
      defer: false
    )
    self.mCocoaVindow.isReleasedWhenClosed = false
  }

  //------------------------------------------------------------------------------------------------
  //  View hierarchy
  //------------------------------------------------------------------------------------------------

  final func set (contentView inRootView : AutoLayoutView) {
    self.mRootView = inRootView
    self.mCocoaVindow.contentView = inRootView.cocoaView
  }

  //------------------------------------------------------------------------------------------------

  final func setFrameAutosaveName (_ inName : NSWindow.FrameAutosaveName) -> Bool {
    return self.mCocoaVindow.setFrameAutosaveName (inName)
  }

  //------------------------------------------------------------------------------------------------

  final var title : String {
    get { self.mCocoaVindow.title }
    set { self.mCocoaVindow.title = newValue }
  }

  //------------------------------------------------------------------------------------------------

  final func makeKeyAndOrderFront (_ inUnusedArg : Any?) {
    self.mCocoaVindow.makeKeyAndOrderFront (inUnusedArg)
  }

  //------------------------------------------------------------------------------------------------

}

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
