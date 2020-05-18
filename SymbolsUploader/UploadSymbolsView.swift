//
//  UploadSymbolsView.swift
//  SymbolsUploader
//
//  Created by Joshua Moore on 5/14/20.
//  Copyright © 2020 Joshua Moore. All rights reserved.
//

import SwiftUI
import SwiftShell

struct UploadSymbolsView: View {
    @State private var plistPath: String = SavedPathsManager.fetchSavedDirectories().plist
    @State private var dsymPath: String = SavedPathsManager.fetchSavedDirectories().dsym
    @State private var currentDropDestination: DirectoryType?
    @Binding var consoleOutput: String
    @Binding var isWaitingForDrop: Bool
    
    var body: some View {
        
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 17)
                .stroke(Color(hex: "26243F"), lineWidth: 1)
                .frame(width: 566, height: 220, alignment: .center)
                .foregroundColor(Color(hex: isWaitingForDrop ? "3b3861" : "151423"))
                .shadow(color: Color(hex: "121120"), radius: 12, x: 6, y: 6)
                .shadow(color: Color(hex: "232239").opacity(0.5), radius: 12, x: -5, y: -5)
            VStack(alignment: .leading, spacing: 12) {
                VStack(alignment: .leading, spacing: 8.0) {
                    Text("Symbols Uploader")
                        .foregroundColor(Color(hex: "BDDAFF"))
                        .fontWeight(.bold)
                    Spacer()
                    Text("Path to GoogleService-Info.plist")
                        .foregroundColor(.white)
                        .fontWeight(.regular)
                    HStack(alignment: .center, spacing: 10) {
                        Button(action: {
                            self.chooseDirectory(for: .plist)
                        }) {
                            Text("browse...")
                        }
                        TextField("~/.", text: $plistPath)
                    }
                    Spacer()
                    Text("Path to dSYM files")
                        .foregroundColor(.white)
                        .fontWeight(.regular)
                    HStack(alignment: .center, spacing: 10) {
                        Button(action: {
                            self.chooseDirectory(for: .dsym)
                        }) {
                            Text("browse...")
                        }
                        TextField("~/.", text: $dsymPath)
                        
                    }
                }
                .padding(.vertical, 8.0)
                .frame(maxWidth: .infinity, alignment: .leading)
                .edgesIgnoringSafeArea(.all)
                
                // Upload Symbols Button
                HStack {
                    Spacer()
                    Button(action: {
                        self.uploadSymbols()
                    }) {
                        Text("Upload Symbols")
                            .fontWeight(.medium)
                            .font(.system(size: 10))
                            .foregroundColor(.white)
                            .frame(width: 143, height: 25, alignment: .center)
                    }
                    .buttonStyle(BlueButtonStyle())
                    Spacer()
                }
                .padding(.bottom, 10.0)
                
            }
            .padding(.all, 16.0)
            .frame(width: 566, height: 200, alignment: .leading)
        }
        .padding([.top, .leading, .trailing], 16.0)
        .onDrop(of: [(kUTTypeFileURL as String)], delegate: self)
    }
    
    func chooseDirectory(for type: DirectoryType) {
        let dialog = NSOpenPanel();
        
        dialog.title                   = "Choose the directory of your repository";
        dialog.showsResizeIndicator    = true;
        dialog.showsHiddenFiles        = false;
        dialog.canChooseFiles = true;
        dialog.canChooseDirectories = true;
        
        if (dialog.runModal() ==  NSApplication.ModalResponse.OK) {
            let result = dialog.url
            
            if (result != nil) {
                let path: String = result!.path
                
                // Apply path name to text field in question
                switch type {
                case .plist:
                    plistPath = path
                case .dsym:
                    dsymPath = path
                }
                
                // Save value for next launch
                SavedPathsManager.save(directory: path, type: type)
            }
        } else {
            // User clicked on "Cancel"
            return
        }
        
        return
    }
    
    func uploadSymbols() {
        // Clear console
        consoleOutput = ""
        
        // Run script
        let scriptFileName = "upload-symbols"
        if let scriptPath = Bundle.main.url(forResource: scriptFileName, withExtension: "") {
            //            consoleOutput = run(scriptPath.relativePath, "-gsp", plistPath, "-p", "ios", dsymPath).stdout
            let command = runAsync(scriptPath.relativePath, "-gsp", plistPath, "-p", "ios", dsymPath).onCompletion { command in
                // be notified when the command is finished.
            }
            command.stdout.onOutput {stdout in
                // be notified when the command produces output (only on macOS).
                self.consoleOutput += stdout.readSome() ?? ""
            }
            
            // do something with ‘command’ while it is still running.
            
            do {
                try command.finish() // wait for it to finish.
            } catch {
                print("still running...")
            }
        }
    }
}

extension UploadSymbolsView: DropDelegate {
    func dropEntered(info: DropInfo) {
        isWaitingForDrop = true
    }
    
    func dropExited(info: DropInfo) {
        isWaitingForDrop = false
    }
    
    func performDrop(info: DropInfo) -> Bool {
        guard
            let itemProvider = info.itemProviders(for: [(kUTTypeFileURL as String)]).first
        else { return false }

        itemProvider.loadItem(forTypeIdentifier: (kUTTypeFileURL as String), options: nil) { item, error in
            guard
                let data = item as? Data,
                let url = URL(dataRepresentation: data, relativeTo: nil)
            else { return }
            
            // Check what kind of path this is
            let urlPath = url.relativePath
            if urlPath.contains(".plist") {
                // Set relavant path
                self.plistPath = urlPath
                
                // Save value for next launch
                SavedPathsManager.save(directory: urlPath, type: .plist)
            }
            else {
                // Set relavant path
                self.dsymPath = urlPath
                
                // Save value for next launch
                SavedPathsManager.save(directory: urlPath, type: .dsym)
            }
        }

        return true
    }
}
