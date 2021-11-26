//
//  essai.swift
//  ElCanari
//
//  Created by Pierre Molinaro on 22/11/2021.
//
//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

import Foundation

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

final class MyEntity : EBManagedObject {

  final let y1_property : EBStoredProperty_Int
  final let y2_property : EBStoredProperty_Int
  final let b_property : EBStoredProperty_Bool

  required init (_ ebUndoManager : EBUndoManager?) {
    self.y1_property = EBStoredProperty_Int (defaultValue: 0, undoManager: ebUndoManager)
    self.y2_property = EBStoredProperty_Int (defaultValue: 0, undoManager: ebUndoManager)
    self.b_property = EBStoredProperty_Bool (defaultValue: true, undoManager: ebUndoManager)
    super.init (ebUndoManager)
  }

}

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

class ToMany <T> where T : EBManagedObject {
  var mArray = [T] ()

  var mArrayObservers = [(PartialKeyPath <T>, EBEvent)] ()

  func addObserver <P> (keyPath inKeyPath : KeyPath <T, P>, _ inObserver : EBEvent) where P : EBAbstractProperty {
    self.mArrayObservers.append ((inKeyPath, inObserver))
    for object in self.mArray {
      object [keyPath: inKeyPath].addEBObserver (inObserver)
    }
  }

  func append (_ inObject : T) {
    self.mArray.append (inObject)
    for (partialKeyPath, observer) in self.mArrayObservers {
      if let keyPath = partialKeyPath as? KeyPath <T, EBAbstractProperty> {
        inObject [keyPath: keyPath].addEBObserver (observer)
      }
    }
  }
}

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

func essaiTemporaire () {
  let a = ToMany <MyEntity> ()
  let obs = EBEvent ()
  a.addObserver (keyPath: \MyEntity.y1_property, obs)
  a.addObserver (keyPath: \MyEntity.b_property, obs)
}

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

