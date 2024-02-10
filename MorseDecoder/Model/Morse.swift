//
//  Morze.swift
//  MorseDecoder
//
//  Created by Kyrylo Derkach on 02.02.2024.
//

import Foundation

struct Morse {
    private static let morseDictionary: [String: String] = [
        ".-": "A",
        "-...": "B",
        "-.-.": "C",
        "-..": "D",
        ".": "E",
        "..-.": "F",
        "--.": "G",
        "....": "H",
        "..": "I",
        ".---": "J",
        "-.-": "K",
        ".-..": "L",
        "--": "M",
        "-.": "N",
        "---": "O",
        ".--.": "P",
        "--.-": "Q",
        ".-.": "R",
        "...": "S",
        "-": "T",
        "..-": "U",
        "...-": "V",
        ".--": "W",
        "-..-": "X",
        "-.--": "Y", 
        "--..": "Z"
    ]
    private static let validChars: [Character] = [".", "-", "_"]
    
    private static func isValidString(_ string: String) -> Bool {
        string.last == "_" && string.allSatisfy({ validChars.contains($0) })
    }
    
    static func decodeMorseString(code: String) throws -> String {
        if code == "_" {
            return " "
        }
        guard isValidString(code) else {
            throw InvalidStringError()
        }
        
        let codeArr = code.split(separator: "_")
        
        var decodedStr = ""
        for charCode in codeArr {
            guard let decodedChar = morseDictionary[String(charCode)] else {
                throw NonExistingCodeError(String(charCode))
            }
            decodedStr.append(decodedChar)
        }
        return decodedStr
    }
}
