//
//  ContentView.swift
//  essai-ui
//
//  Created by Pierre Molinaro on 30/09/2020.
//

import SwiftUI

struct MyContentView : View {
   @ObservedObject var mDocument : Document

    var body: some View {
      HStack {
        Spacer ()
        VStack {
          Spacer ()
          Toggle ("Mon Choix", isOn: self.$mDocument.mMonChoix)
          Spacer ()
          Button ("Toggle", action: self.mDocument.toggle)
          Spacer ()
          Text("State: \(self.mDocument.mMonChoix ? "T" : "F")")
          Spacer ()
        }
        Spacer ()
      }
    }
}

#if DEBUG
struct MyContentView_Previews: PreviewProvider {
    static var previews: some View {
        MyContentView(mDocument : Document ())
    }
}
#endif
