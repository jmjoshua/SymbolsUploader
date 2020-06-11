//
//  ContentView.swift
//  SymbolsUploader
//
//  Created by Joshua Moore on 5/14/20.
//  Copyright © 2020 Joshua Moore. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var currentTab = 0
    @State var consoleTitleText: String
    @State var uuidConsoleTitleText: String
    @State var consoleOutput: String
    @State var uuidConsoleOutput: String
    @State var isWaitingForDrop: Bool
    
    let titles = Constants.ButtonTitles.segmentedControlTitles
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Constants.HexColors.mainAppBackground)
            VStack(alignment: .center, spacing: 16) {
                Spacer()
                Picker(selection: $currentTab, label: Text("")) {
                    Text(titles.symbolsUpload).tag(0)
                    Text(titles.uuidCheck).tag(1)
                }.pickerStyle(SegmentedPickerStyle())
                    .frame(width: 300)
                if currentTab == 0 {
                    UploadSymbolsView(consoleTitleText: $consoleTitleText,
                                      consoleOutput: $consoleOutput,
                                      isWaitingForDrop: $isWaitingForDrop)
                    ConsoleView(consoleTitleText: $consoleTitleText,
                                consoleText: $consoleOutput)
                }
                else if currentTab == 1 {
                    UUIDView(consoleTitle: $uuidConsoleTitleText, consoleOutput: $uuidConsoleOutput, isWaitingForDrop: $isWaitingForDrop)
                    ConsoleView(consoleTitleText: $uuidConsoleTitleText,
                                consoleText: $uuidConsoleOutput)
                }
                Spacer()
                // Quit button
                Button(action: quitApp) {
                    Text(Constants.ButtonTitles.quitButtonTitle)
                        .fontWeight(.medium)
                        .font(Font.system(size: 10))
                        .foregroundColor(.white)
                        .frame(width: 143, height: 18, alignment: .center)
                }
                .buttonStyle(RedButtonStyle())
                .padding()
            }
        }
        .frame(width: 600)
        .onDrop(of: [(kUTTypeFileURL as String)], delegate: self)
    }
    
    func quitApp() {
        NSApplication.shared.terminate(self)
    }
}

extension ContentView: DropDelegate {
    func dropEntered(info: DropInfo) {
        isWaitingForDrop = true
    }
    
    func dropExited(info: DropInfo) {
        isWaitingForDrop = false
    }
    
    func performDrop(info: DropInfo) -> Bool {
        false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(consoleTitleText: "Console", uuidConsoleTitleText: "Console", consoleOutput: "", uuidConsoleOutput: "", isWaitingForDrop: false)
    }
}
