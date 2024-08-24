//
//  AppDelegate.swift
//  essai-gridview
//
//  Created by Pierre Molinaro on 28/10/2023.
//
//——————————————————————————————————————————————————————————————————————————————————————————————————

import Cocoa

//——————————————————————————————————————————————————————————————————————————————————————————————————

@MainActor @main class AppDelegate : NSObject, NSApplicationDelegate {

  //------------------------------------------------------------------------------------------------

  func applicationDidFinishLaunching (_ aNotification: Notification) {
    DispatchQueue.main.async {
      self.createVerticalStackView (title: "Vertical Stack View")
      self.createHorizontalStackView (title: "Horizontal Stack View")
      self.createGridView2 (title: "Grid View")
      self.createHorizontalTableViews (title: "Table Views")
      self.createTextView (title: "Text View")
    }
  }

  //------------------------------------------------------------------------------------------------

  private var mWindowsEx = [NSWindow] ()
  private var mWindows = [AutoLayoutWindow] ()

  //------------------------------------------------------------------------------------------------

  func createTextView (title inTitle : String) {
    let window = AutoLayoutWindow (
      contentRect: NSRect (x: 0, y: 0, width: 200, height: 200),
      styleMask: [.titled, .resizable]
    )
    _ = window.setFrameAutosaveName (inTitle)
    window.title = inTitle

    let stack = PMVerticalStackView (horizontal: .fill, vertical: .fill)
      .set (margins: .regular)
      .appendView (PMTextView ())
    window.set (contentView: stack)
    window.makeKeyAndOrderFront (nil)
    self.mWindows.append (window)
  }

  //------------------------------------------------------------------------------------------------

  func createVerticalStackView (title inTitle : String) {
    let window = NSWindow (
      contentRect: NSRect (x: 0, y: 0, width: 200, height: 200),
      styleMask: [.titled, .resizable],
      backing: .buffered,
      defer: false
    )
    window.setFrameAutosaveName (inTitle)
    window.title = inTitle
    window.isReleasedWhenClosed = false

    let stack = PMVerticalStackView (horizontal: .fill, vertical: .fill)
      .set (margins: .regular)
      .appendFlexibleSpace ()
      .appendView (PMButton (title: "Button 0", size: .small))
      .appendFlexibleSpace ()
      .appendHorizontalDivider (drawFrame: true, canResizeWindow: false)
      .appendView (PMButton (title: "Button 1", size: .regular))
      .appendFlexibleSpace ()
      .appendView (PMHorizontalStackView (horizontal: .fill, vertical: .lastBaseline).appendView (PMButton (title: "Button 2", size: .large)))
      .appendHorizontalDivider (drawFrame: true, canResizeWindow: true)
      .appendFlexibleSpace ()
      .appendFlexibleSpace ()
      .appendView (PMButton (title: "Button 3", size: .mini))
    window.contentView = stack
    window.makeKeyAndOrderFront (nil)
    self.mWindowsEx.append (window)
  }

  //------------------------------------------------------------------------------------------------

  func createHorizontalStackView (title inTitle : String) {
    let window = NSWindow (
      contentRect: NSRect (x: 0, y: 0, width: 200, height: 200),
      styleMask: [.titled, .resizable],
      backing: .buffered,
      defer: true
    )
    window.setFrameAutosaveName (inTitle)
    window.title = inTitle
    window.isReleasedWhenClosed = false

    let stack = PMHorizontalStackView (horizontal: .fill, vertical: .fill)
      .set (margins: .regular)
      .appendFlexibleSpace ()
      .appendView (PMButton (title: "Button 0", size: .small))
      .appendView (PMVerticalStackView (horizontal: .fill, vertical: .lastBaseline).appendView (PMButton (title: "Button 0", size: .small)).appendFlexibleSpace ())
      .appendFlexibleSpace ()
      .appendVerticalDivider (drawFrame: true, canResizeWindow: false)
      .appendView (PMButton (title: "Button 1", size: .regular))
      .appendVerticalSeparator ()
      .appendFlexibleSpace ()
      .appendView (PMButton (title: "Button 2", size: .large))
      .appendView (PMHorizontalStackView (horizontal: .fill, vertical: .lastBaseline).appendView (PMButton (title: "Button 2", size: .large)))
      .appendView (PMButton (title: "Button 2", size: .large))
      .appendFlexibleSpace ()
      .appendVerticalDivider (drawFrame: true, canResizeWindow: true)
      .appendFlexibleSpace ()
      .appendFlexibleSpace ()
      .appendView (PMButton (title: "Button 3", size: .mini))
      .prependVerticalSeparator ()
    window.contentView = stack
    window.makeKeyAndOrderFront (nil)
    self.mWindowsEx.append (window)
  }

  //------------------------------------------------------------------------------------------------

  func createGridView2 (title inTitle : String) {
    let window = NSWindow (
      contentRect: NSRect (x: 0, y: 0, width: 200, height: 200),
      styleMask: [.titled, .resizable],
      backing: .buffered,
      defer: true
    )
    window.setFrameAutosaveName (inTitle)
    window.title = inTitle
    window.isReleasedWhenClosed = false

    let stack = PMVerticalGridView2 (horizontal: .fill, vertical: .fill)
      .set (margins: .regular)
      .set (horizontalSpacing: 12)
      .append (left: PMButton (title: "Button 0", size: .regular), right: PMButton (title: "Button 1", size: .regular))
      .appendVerticalSeparator (ignoreHorizontalMargins: true)
      .append (left: PMButton (title: "Large Button 2", size: .large), right: PMButton (title: "Button 3", size: .small))

    window.contentView = stack
    window.makeKeyAndOrderFront (nil)
    self.mWindowsEx.append (window)
  }

  //------------------------------------------------------------------------------------------------

  func createHorizontalTableViews (title inTitle : String) {
    let window = NSWindow (
      contentRect: NSRect (x: 0, y: 0, width: 200, height: 200),
      styleMask: [.titled, .resizable],
      backing: .buffered,
      defer: true
    )
    window.setFrameAutosaveName (inTitle)
    window.title = inTitle
    window.isReleasedWhenClosed = false

    let stack = PMHorizontalStackView (horizontal: .fill, vertical: .fill)
      .set (margins: .regular)
      .appendView (PMTableView (size: .regular))
      .appendVerticalDivider (drawFrame: true, canResizeWindow: true)
      .appendView (PMTableView (size: .regular))

    window.contentView = stack
    window.makeKeyAndOrderFront (nil)
    self.mWindowsEx.append (window)
  }

  //------------------------------------------------------------------------------------------------

}

//——————————————————————————————————————————————————————————————————————————————————————————————————
