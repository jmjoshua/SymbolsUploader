//
//  ConsoleView.swift
//  SymbolsUploader
//
//  Created by Joshua Moore on 5/14/20.
//  Copyright © 2020 Joshua Moore. All rights reserved.
//

import SwiftUI
//import lott

struct ConsoleView: View {
    @Binding var consoleTitleText: String
    @Binding var consoleText: String
    
    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 17)
                .stroke(Constants.HexColors.cardStroke, lineWidth: 2)
                .frame(width: 566, height: 200, alignment: .center)
                .foregroundColor(Constants.HexColors.mainFill)
                .shadow(color: Constants.HexColors.mainPosShadow, radius: 12, x: 6, y: 6)
                .shadow(color: Constants.HexColors.mainNegShadow.opacity(0.5), radius: 12, x: -5, y: -5)
            VStack(alignment: .leading, spacing: 12) {
                Text(consoleTitleText)
                    .foregroundColor(Constants.HexColors.cardTitleColor)
                    .fontWeight(.bold)
                    .font(.headline)
                Spacer()
                GroupBox() {
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
            .frame(width: 566, height: 200, alignment: .center)
        }
        .padding([.top, .leading, .trailing], 16.0)
    }
}

struct ConsoleView_Previews: PreviewProvider {
    static var previews: some View {
        ConsoleView(consoleTitleText: .constant("Console"), consoleText: .constant("2020-05-25 23:15:03.900068-0600 SymbolsUploader[12893:496372] Metal API Validation Enabled\n2020-05-25 23:15:03.940011-0600 SymbolsUploader[12893:496407] flock failed to lock maps file: errno = 35\n2020-05-25 23:15:03.940931-0600 SymbolsUploader[12893:496407] flock failed to lock maps file: errno = 35"))
    }
}
