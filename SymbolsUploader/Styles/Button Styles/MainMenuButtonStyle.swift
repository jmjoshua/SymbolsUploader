//
//  MainMenuButtonStyle.swift
//  SymbolsUploader
//
//  Created by Joshua Moore on 5/24/20.
//  Copyright © 2020 Joshua Moore. All rights reserved.
//

import SwiftUI

struct MainMenuButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(configuration.isPressed ? Color.black
                : Constants.HexColors.mainFill)
            .cornerRadius(10)
            .shadow(color: Constants.HexColors.mainPosShadow, radius: 12, x: 6, y: 6)
            .shadow(color: Constants.HexColors.mainNegShadow.opacity(0.5), radius: 12, x: -5, y: -5)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Constants.HexColors.cardStroke, lineWidth: 1)
        )
    }
}
