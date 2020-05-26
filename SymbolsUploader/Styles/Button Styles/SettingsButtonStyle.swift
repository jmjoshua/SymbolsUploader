//
//  SettingsButtonStyle.swift
//  SymbolsUploader
//
//  Created by Joshua Moore on 5/24/20.
//  Copyright © 2020 Joshua Moore. All rights reserved.
//

import SwiftUI

struct SettingsButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(configuration.isPressed ? Color.black
                : Constants.HexColors.mainFill)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Constants.HexColors.cardStroke, lineWidth: 1)
        )
    }
}
