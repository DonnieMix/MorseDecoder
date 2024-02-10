//
//  MorseCharacter.swift
//  MorseDecoder
//
//  Created by Kyrylo Derkach on 02.02.2024.
//

import Foundation

enum MorseCharacter: CustomStringConvertible {
    case short, long, pause
    
    var description: String {
        switch self {
        case .short: "."
        case .long: "-"
        case .pause: "_"
        }
    }
}
