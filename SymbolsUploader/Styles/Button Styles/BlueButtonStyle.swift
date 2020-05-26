//
//  BlueButtonStyle.swift
//  SymbolsUploader
//
//  Created by Joshua Moore on 5/24/20.
//  Copyright © 2020 Joshua Moore. All rights reserved.
//

import SwiftUI

struct BlueButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(configuration.isPressed
                ? Constants.HexColors.blueButtonFill
                : Color.blue)
            .cornerRadius(25)
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Constants.HexColors.blueButtonStroke, lineWidth: 1)
                    .shadow(color: Constants.HexColors.blueButtonNegShadow.opacity(0.5), radius: 10, x: -6, y: -6)
                    .shadow(color: Constants.HexColors.blueButtonPosShadow.opacity(0.5), radius: 10, x: 6, y: 6)
        )
    }
}
