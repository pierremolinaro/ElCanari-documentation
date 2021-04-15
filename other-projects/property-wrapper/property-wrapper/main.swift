//
//  main.swift
//  property-wrapper
//
//  Created by Pierre Molinaro on 01/03/2021.
//
//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

import Foundation

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

enum EBSelection <T> : Equatable where T : Equatable {

  //····················································································································

  case empty
  case multiple
  case single (T)

  //····················································································································

}

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

protocol EventProtocol : AnyObject {
  func postEvent ()
}

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

class ReadFaçade <T> : EventProtocol where T : Equatable {

  private final var mEvents = [EventProtocol] ()
  private final var mEventHasBeenSent = false

  final func addObserver (_ inObserver : EventProtocol) {
    self.mEvents.append (inObserver)
    inObserver.postEvent ()
  }

  final func removeObserver (_ inObserver : EventProtocol) {
    var idx = 0
    while idx < self.mEvents.count {
      if self.mEvents [idx] === inObserver {
        self.mEvents.remove (at: idx)
        idx = self.mEvents.count // For exiting loop
      }else{
        idx += 1
      }
    }
  }

  final func postEvent () {
    if !mEventHasBeenSent {
      self.mEventHasBeenSent = true
      for event in self.mEvents {
        event.postEvent ()
      }
    }
  }

  init (getter inGetter : @escaping () -> EBSelection <T>) {
   self.mGetter = inGetter
  }

  final let mGetter : () -> EBSelection <T>

  final var selection : EBSelection <T> {
    self.mEventHasBeenSent = false
    return self.mGetter ()
  }

  private final var mOutletCallBacks = [ () -> Void]  ()

  final func registerCallBack (_ inCallBack : @escaping () -> Void) {
    self.mOutletCallBacks.append (inCallBack)
  }

  final func apply () {
    for callBack in self.mOutletCallBacks {
      callBack ()
    }
  }
}

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

class ReadWriteFaçade <T> : ReadFaçade <T> where T : Equatable {

  private final let mSetter : (T) -> Void

  final func setProperty (_ inValue : T) {
    self.mSetter (inValue)
  }

  init (getter inGetter : @escaping () -> EBSelection <T>, setter inSetter : @escaping (T) -> Void) {
   self.mSetter = inSetter
   super.init (getter: inGetter)
  }
}

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

@propertyWrapper final class StoredProperty <T> where T : Equatable {

  //····················································································································

  private var mInternalValue : T
  private weak var mEBUndoManager : UndoManager? = nil // SOULD BE WEAK

  //····················································································································

  init (wrappedValue inValue : T, _ inUndoManager : UndoManager?) {
    self.mInternalValue = inValue
    self.mEBUndoManager = inUndoManager
  }

  var wrappedValue : T {
    get {
      Swift.print ("Read \(self.mInternalValue)")
      return self.mInternalValue
    }
    set {
      if self.mInternalValue != newValue {
        Swift.print ("Write \(newValue)")
        let oldValue = self.mInternalValue
        self.mEBUndoManager?.registerUndo (withTarget: self) { $0.mInternalValue = oldValue }
        self.mInternalValue = newValue
        self.mFaçade.postEvent ()
      }
    }
  }

  private lazy var mFaçade = ReadWriteFaçade <T> (
    getter: { [weak self] in
      if let unwrappedSelf = self {
        return .single (unwrappedSelf.mInternalValue)
      }else{
        return .empty
      }
    },
    setter: { [weak self] in self?.mInternalValue = $0 }
  )

  var projectedValue : ReadWriteFaçade <T> { self.mFaçade }
}

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

@propertyWrapper final class TransientProperty <T> where T : Equatable {

  //····················································································································

  init (wrappedValue inValue : EBSelection <T>, readModel inReadModelFunction : @escaping () -> EBSelection <T>) {
    self.mReadModelFunction = inReadModelFunction
  }

  //····················································································································

  private let mReadModelFunction : () -> EBSelection <T>
  private var mValueCache : EBSelection <T>? = nil

  //····················································································································

  var wrappedValue : EBSelection <T> {
    get {
      if self.mValueCache == nil {
        self.mValueCache = self.mReadModelFunction ()
        if self.mValueCache == nil {
          self.mValueCache = .empty
        }
      }
      Swift.print ("Read \(self.mValueCache!)")
      return self.mValueCache!
    }
  }

  private lazy var mFaçade = ReadFaçade <T> (
    getter: { [weak self] in return self?.wrappedValue ?? .empty }
  )

  var projectedValue : ReadFaçade <T> { self.mFaçade }
}

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

class Toto {
  @StoredProperty (UndoManager ()) final var toto : Int = 8
  @StoredProperty (UndoManager ()) final var array : [Int] = []
  @TransientProperty<Int> (readModel: { return .empty }) final var mTransient = .empty

  func xyz () {
    self.toto += 67
    let y : ReadWriteFaçade <Int> = self.$toto
    self.$toto.addObserver (self.$mTransient)
    self.array = [1, 2]
    self.array.append (3)
    //self.transient = 9 // REFUSÉ
    Swift.print ("transient \(self.mTransient)")
    let x : ReadFaçade <Int> = self.$mTransient
  }
}

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

var t = Toto ()
t.xyz ()

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
