//
//  SplashView.swift
//  Home
//
//  Created by Luthfi Asmara on 31/07/25.
//

import SwiftUI
import CommonUI

struct SplashView: WrappedView {
  var holder: WrapperHolder
  var navigator: SplashNavigator
  
  @State var timeRemaining: Int = 3
  
  var body: some View {
    VStack {
      Spacer()
      
      Image(.imgSplash)
        .resizable()
        .scaledToFit()
        .frame(width: 250)
      
      Spacer()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.black.ignoresSafeArea())
    .onAppear {
        startTimer()
    }
  }
  
  private func startTimer() {
    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
      if timeRemaining > 0 {
        timeRemaining -= 1
      } else {
        guard let viewController = holder.viewController else { return }
        navigator.navigateToHome(from: viewController)
      }
    }
  }
}
