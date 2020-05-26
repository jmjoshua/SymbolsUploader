//
//  Constants.swift
//  SymbolsUploader
//
//  Created by Joshua Moore on 5/25/20.
//  Copyright © 2020 Joshua Moore. All rights reserved.
//

import SwiftUI

class Constants {
    struct Scripts {
        static let uploadScriptFileName = "upload-symbols"
        static let uuidCheckScriptName = "dwarfdump"
    }
    
    struct HexColors {
        // General
        static let mainAppBackground = Color(hex: "121220")
        static let mainFill = Color(hex: "151423")
        static let mainPosShadow = Color(hex: "121120")
        static let mainNegShadow = Color(hex: "232239")
        
        // Cards
        static let cardDragAndDropFill = Color(hex: "3b3861")
        static let cardTitleColor = Color(hex: "BDDAFF")
        static let cardStroke = Color(hex: "26243F")
        
        // Buttons
        static let blueButtonFill = Color(hex: "00A4FA")
        static let blueButtonStroke = Color(hex: "26A6EE")
        static let blueButtonPosShadow = Color(hex: "161617")
        static let blueButtonNegShadow = Color(hex: "383E46")
        static let redButtonFill = Color(hex: "FA7D74")
        static let redButtonStroke = Color(hex: "FDA8A3")
    }
    
    struct ButtonTitles {
        static let browseButtonTitle = "browse..."
        static let uploadButtonTitle = "Upload Symbols"
        static let findUUIDsTitle = "Find UUIDs"
        static let quitButtonTitle = "Quit App"
        
        static let segmentedControlTitles = (symbolsUpload: "Symbols Uploader", uuidCheck: "UUID Check")
    }
    
    struct Placeholders {
        static let textFieldPlaceholder = "Drag and drop a file or folder..."
        static let textFieldDsymPlaceholder = "Drag and drop a dSYM file..."
    }

}
