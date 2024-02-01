//
//  LoadingIndicatorView.swift
//  GithubSearchRepositories
//
//  Created by Dániel Novák on 29/01/2024.
//

import SwiftUI

struct LoadingIndicatorView: View {
    private enum Constants {
        static let circleCount = 4
        static let circleInitialOpacity = 0.5
        static let animationDuration = 3.0
    }
    
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            ForEach(0..<Constants.circleCount, id: \.self) { index in
                Circle()
                    .fill(.primary.opacity(Constants.circleInitialOpacity))
                    .opacity(isAnimating ? 0 : 1)
                    .scaleEffect(isAnimating ? 1 : 0)
                    .animation(
                        .easeOut(duration: Constants.animationDuration)
                        .repeatForever(autoreverses: false)
                        .delay(Double(index) * Constants.animationDuration / Double(Constants.circleCount)),
                        value: isAnimating
                    )
            }
        }
        .frame(width: 50, height: 50)
        .onAppear {
            isAnimating.toggle()
        }
    }
}

#Preview {
    LoadingIndicatorView().preferredColorScheme(.light)
}

