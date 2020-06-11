//
//  UUIDView.swift
//  SymbolsUploader
//
//  Created by Joshua Moore on 5/25/20.
//  Copyright © 2020 Joshua Moore. All rights reserved.
//

import SwiftUI
import SwiftShell

struct UUIDView: View {
    @State private var uuidDsymPath: String = SavedPathsManager.fetchUUIDDirectory()
    @Binding var consoleTitle: String
    @Binding var consoleOutput: String
    @Binding var isWaitingForDrop: Bool
    
    var body: some View {
        
        ZStack(alignment: .center) {
            // MARK: Card Stroke and Shadow
            RoundedRectangle(cornerRadius: 17.0)
                .stroke(Constants.HexColors.cardStroke, lineWidth: 3)
                .shadow(color: Constants.HexColors.mainPosShadow, radius: 12, x: 6, y: 6)
                .shadow(color: Constants.HexColors.mainNegShadow.opacity(0.5), radius: 12, x: -5, y: -5)
            .frame(width: 566, height: 220, alignment: .center)
            
            // MARK: Card Background
            RoundedRectangle(cornerRadius: 17.0)
                .fill(
                    isWaitingForDrop
                        ? Constants.HexColors.cardDragAndDropFill
                        : Constants.HexColors.mainFill
            )
                .frame(width: 566, height: 220, alignment: .center)
            
            // MARK: Card Content
            VStack(alignment: .leading, spacing: 12) {
                VStack(alignment: .leading, spacing: 8.0) {
                    Text("UUID Check")
                        .foregroundColor(Constants.HexColors.cardTitleColor)
                        .fontWeight(.bold)
                    Spacer()
                    Text("Path to dSYM file")
                        .foregroundColor(.white)
                        .fontWeight(.regular)
                    HStack(alignment: .center, spacing: 10) {
                        Button(action: {
                            self.chooseDirectory(for: .uuidDsym)
                        }) {
                            Text(Constants.ButtonTitles.browseButtonTitle)
                        }
                        TextField(Constants.Placeholders.textFieldDsymPlaceholder, text: $uuidDsymPath)
                        Button(action: {
                            self.clearField(for: .uuidDsym)
                        }) {
                            Text("X")
                        }
                    }
                }
                .padding(.vertical, 8.0)
                .frame(maxWidth: .infinity, alignment: .leading)
                .edgesIgnoringSafeArea(.all)
                
                Spacer()
                
                // Upload Symbols Button
                HStack {
                    Spacer()
                    Button(action: {
                        self.checkUUIDs()
                    }) {
                        Text(Constants.ButtonTitles.findUUIDsTitle)
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
    
    func clearField(for type: DirectoryType) {
        uuidDsymPath = ""
    }
    
    func chooseDirectory(for type: DirectoryType) {
        let dialog = NSOpenPanel();
        
        dialog.title                   = "Choose the directory of your repository";
        dialog.showsResizeIndicator    = true;
        dialog.showsHiddenFiles        = false;
        dialog.canChooseFiles = true;
        dialog.canChooseDirectories = false;
        
        if (dialog.runModal() ==  NSApplication.ModalResponse.OK) {
            let result = dialog.url
            
            if (result != nil) {
                let path: String = result!.path
                
                // Apply path name to text field in question
                uuidDsymPath = path
                
                // Save value for next launch
                SavedPathsManager.save(directory: path, type: type)
            }
        } else {
            // User clicked on "Cancel"
            return
        }
        
        return
    }
    
    func checkUUIDs() {
        // Clear console and update title
        consoleTitle = "Console - Checking UUIDs"
        consoleOutput = ""
        
        // Run script
        let scriptName = Constants.Scripts.uuidCheckScriptName
        
        let command = runAsync(scriptName, "-u", uuidDsymPath).onCompletion { command in
            // be notified when the command is finished.
        }
        command.stdout.onOutput {stdout in
            // be notified when the command produces output (only on macOS).
            self.consoleOutput += stdout.readSome() ?? ""
        }
        
        // Fire the command and do something when it's done
        command.onCompletion { (command) in
            self.consoleTitle = "Console - UUID check complete!"
            debugPrint("All done checking UUID!")
        }
    }
}

extension UUIDView: DropDelegate {
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
            
            if urlPath.contains(".dSYM") {
                // Set relavant path
                self.uuidDsymPath = urlPath
                // Save value for next launch
                SavedPathsManager.save(directory: urlPath, type: .uuidDsym)
            }
            else {
                self.consoleOutput = "Please drop a dSYM file. Folders are not allowed for UUID check."
            }
        }

        return true
    }
}

struct UUIDView_Previews: PreviewProvider {
    static var previews: some View {
        UUIDView(consoleTitle: .constant("Console"), consoleOutput: .constant("Drag and drop a file or folder into the section above..."), isWaitingForDrop: .constant(true))
    }
}
