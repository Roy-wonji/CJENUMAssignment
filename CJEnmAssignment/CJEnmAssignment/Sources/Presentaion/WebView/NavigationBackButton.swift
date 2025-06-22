//
//  NavigationBackButton.swift
//  CJEnmAssignment
//
//  Created by Wonji Suh  on 6/23/25.
//

import SwiftUI

struct NavigationBackButton: View {
  var buttonAction: () -> Void = { }

  init(
    buttonAction: @escaping () -> Void
  ) {
    self.buttonAction = buttonAction
  }

  public var body: some View {
    HStack {
      Image(systemName: "chevron.left")
        .resizable()
        .scaledToFit()
        .frame(width: 10, height: 20)
        .foregroundStyle(.gray)
        .onTapGesture {
          buttonAction()
        }

      Spacer()

    }
    .padding(.horizontal, 20)
  }
}

