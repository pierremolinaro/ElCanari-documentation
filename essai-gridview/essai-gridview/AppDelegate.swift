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

  private var mWindows = [NSWindow] ()

  //------------------------------------------------------------------------------------------------

  func createTextView (title inTitle : String) {
    let window = NSWindow (
      contentRect: NSRect (x: 0, y: 0, width: 200, height: 200),
      styleMask: [.titled, .resizable],
      backing: .buffered,
      defer: false
    )
    window.setFrameAutosaveName (inTitle)
    window.title = inTitle
    window.isReleasedWhenClosed = false

    let stack = AutoLayoutVerticalStackView (horizontal: .fill, vertical: .fill)
      .set (margins: .regular)
      .appendView (PMTextView ())
    window.contentView = stack
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

    let stack = AutoLayoutVerticalStackView (horizontal: .fill, vertical: .fill)
      .set (margins: .regular)
      .appendFlexibleSpace ()
      .appendView (ALB_NSButton (title: "Button 0", size: .small))
      .appendFlexibleSpace ()
      .appendHorizontalDivider (drawFrame: true, canResizeWindow: false)
      .appendView (ALB_NSButton (title: "Button 1", size: .regular))
      .appendFlexibleSpace ()
      .appendView (AutoLayoutHorizontalStackView (horizontal: .fill, vertical: .lastBaseline).appendView (ALB_NSButton (title: "Button 2", size: .large)))
      .appendHorizontalDivider (drawFrame: true, canResizeWindow: true)
      .appendFlexibleSpace ()
      .appendFlexibleSpace ()
      .appendView (ALB_NSButton (title: "Button 3", size: .mini))
    window.contentView = stack
    window.makeKeyAndOrderFront (nil)
    self.mWindows.append (window)
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

    let stack = AutoLayoutHorizontalStackView (horizontal: .fill, vertical: .fill)
      .set (margins: .regular)
      .appendFlexibleSpace ()
      .appendView (ALB_NSButton (title: "Button 0", size: .small))
      .appendView (AutoLayoutVerticalStackView (horizontal: .fill, vertical: .lastBaseline).appendView (ALB_NSButton (title: "Button 0", size: .small)).appendFlexibleSpace ())
      .appendFlexibleSpace ()
      .appendVerticalDivider (drawFrame: true, canResizeWindow: false)
      .appendView (ALB_NSButton (title: "Button 1", size: .regular))
      .appendVerticalSeparator ()
      .appendFlexibleSpace ()
      .appendView (ALB_NSButton (title: "Button 2", size: .large))
      .appendView (AutoLayoutHorizontalStackView (horizontal: .fill, vertical: .lastBaseline).appendView (ALB_NSButton (title: "Button 2", size: .large)))
      .appendView (ALB_NSButton (title: "Button 2", size: .large))
      .appendFlexibleSpace ()
      .appendVerticalDivider (drawFrame: true, canResizeWindow: true)
      .appendFlexibleSpace ()
      .appendFlexibleSpace ()
      .appendView (ALB_NSButton (title: "Button 3", size: .mini))
      .prependVerticalSeparator ()
    window.contentView = stack
    window.makeKeyAndOrderFront (nil)
    self.mWindows.append (window)
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

    let stack = AutoLayoutGridView2 (horizontal: .fill, vertical: .fill)
      .set (margins: .regular)
      .set (horizontalSpacing: 12)
      .append (left: ALB_NSButton (title: "Button 0", size: .regular), right: ALB_NSButton (title: "Button 1", size: .regular))
//      .appendVerticalSeparator (ignoreHorizontalMargins: true)
      .append (left: ALB_NSButton (title: "Large Button 2", size: .large), right: ALB_NSButton (title: "Button 3", size: .small))

    window.contentView = stack
    window.makeKeyAndOrderFront (nil)
    self.mWindows.append (window)
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

    let stack = AutoLayoutHorizontalStackView (horizontal: .fill, vertical: .fill)
      .set (margins: .regular)
      .appendView (PMTableView (size: .regular))
      .appendVerticalDivider (drawFrame: true, canResizeWindow: true)
      .appendView (PMTableView (size: .regular))

    window.contentView = stack
    window.makeKeyAndOrderFront (nil)
    self.mWindows.append (window)
  }

  //------------------------------------------------------------------------------------------------

}

//——————————————————————————————————————————————————————————————————————————————————————————————————
