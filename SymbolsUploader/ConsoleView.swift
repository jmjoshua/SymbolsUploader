//
//  ConsoleView.swift
//  SymbolsUploader
//
//  Created by Joshua Moore on 5/14/20.
//  Copyright © 2020 Joshua Moore. All rights reserved.
//

import SwiftUI

struct ConsoleView: View {
    @Binding var consoleText: String
    
    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 17)
                .stroke(Color(hex: "26243F"), lineWidth: 1)
                .frame(width: 566, height: 200, alignment: .center)
                .foregroundColor(Color(hex: "151423"))
                .shadow(color: Color(hex: "121120"), radius: 12, x: 6, y: 6)
                .shadow(color: Color(hex: "232239").opacity(0.5), radius: 12, x: -5, y: -5)
            VStack(alignment: .leading, spacing: 12) {
                GroupBox(label: Text("Console")) {
                    ScrollView {
                        Text(consoleText)
                            .font(Font.system(size: 10))
                            .fontWeight(.regular)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(width: 500.0)
                            .rotationEffect(.radians(.pi))
                            .scaleEffect(x: -1, y: 1, anchor: .center)
                    }
                    .rotationEffect(.radians(.pi))
                    .scaleEffect(x: -1, y: 1, anchor: .center)
                }
            }
            .padding(.all, 16.0)
            .frame(width: 566, height: 200, alignment: .leading)
        }
        .padding([.top, .leading, .trailing], 16.0)
    }
}
