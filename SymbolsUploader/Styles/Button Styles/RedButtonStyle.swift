//
//  RedButtonStyle.swift
//  SymbolsUploader
//
//  Created by Joshua Moore on 5/24/20.
//  Copyright © 2020 Joshua Moore. All rights reserved.
//

import SwiftUI

struct RedButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(configuration.isPressed ? Constants.HexColors.redButtonFill : Color.red)
            .cornerRadius(25)
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Constants.HexColors.redButtonStroke, lineWidth: 1)
        )
    }
}
