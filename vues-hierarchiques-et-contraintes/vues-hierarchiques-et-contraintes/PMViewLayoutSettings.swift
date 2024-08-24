//
//  PMViewLayoutSettings.swift
//  essai-gridview
//
//  Created by Pierre Molinaro on 01/11/2023.
//
//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

import AppKit

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

class PMViewLayoutSettings : NSObject {

  //--------------------------------------------------------------------------------------------------------------------

  let hLayoutInVerticalContainer : PMHorizontalLayoutInVerticalCollectionView
  let vLayoutInHorizontalContainer : PMVerticalLayoutInHorizontalCollectionView

  //--------------------------------------------------------------------------------------------------------------------

  init (vLayoutInHorizontalContainer inVerticalDisposition : PMVerticalLayoutInHorizontalCollectionView,
        hLayoutInVerticalContainer inHorizontalDisposition : PMHorizontalLayoutInVerticalCollectionView) {
    self.hLayoutInVerticalContainer = inHorizontalDisposition
    self.vLayoutInHorizontalContainer = inVerticalDisposition
  }

  //--------------------------------------------------------------------------------------------------------------------

}

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
