//
//  ContentView.swift
//  SymbolsUploader
//
//  Created by Joshua Moore on 5/14/20.
//  Copyright © 2020 Joshua Moore. All rights reserved.
//

import SwiftUI

enum DirectoryType: String {
    case plist = "plistPath"
    case dsym = "dsymPath"
}

struct ContentView: View {
    @State var consoleOutput: String
    @State var isWaitingForDrop: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(hex: "121220"))
            VStack(alignment: .center, spacing: 16) {
                
                UploadSymbolsView(consoleOutput: $consoleOutput, isWaitingForDrop: $isWaitingForDrop)
                ConsoleView(consoleText: $consoleOutput)
                Spacer()
                // Quit button
                Button(action: quitApp) {
                    Text("Quit App")
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

// MARK: Buttons

struct settingsButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(configuration.isPressed ? Color.black
                : Color(hex: "151423"))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(hex: "26243F"), lineWidth: 1)
        )
    }
}

struct MainMenuButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(configuration.isPressed ? Color.black
                : Color(hex: "151423"))
            .cornerRadius(10)
            .shadow(color: Color(hex: "121120"), radius: 12, x: 6, y: 6)
            .shadow(color: Color(hex: "232239").opacity(0.5), radius: 12, x: -5, y: -5)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(hex: "26243F"), lineWidth: 1)
        )
    }
}

struct BlueButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(configuration.isPressed ? Color(hex: "00A4FA") : Color.blue)
            .cornerRadius(25)
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color(hex: "26A6EE"), lineWidth: 1)
                    .shadow(color: Color(hex: "383E46").opacity(0.5), radius: 10, x: -6, y: -6)
                    .shadow(color: Color(hex: "161617").opacity(0.5), radius: 10, x: 6, y: 6)
        )
    }
}

struct RedButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(configuration.isPressed ? Color(hex: "FA7D74") : Color.red)
            .cornerRadius(25)
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color(hex: "FDA8A3"), lineWidth: 1)
        )
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(consoleOutput: "", isWaitingForDrop: false)
    }
}

extension ContentView: DropDelegate {
    func dropEntered(info: DropInfo) {
        self.isWaitingForDrop = true
    }
    
    func dropExited(info: DropInfo) {
        self.isWaitingForDrop = false
    }
    
    func performDrop(info: DropInfo) -> Bool {
        false
    }
}
