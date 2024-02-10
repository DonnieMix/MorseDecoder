//
//  NonExistingCodeError.swift
//  MorseDecoder
//
//  Created by Kyrylo Derkach on 02.02.2024.
//

import Foundation

struct NonExistingCodeError: Error {
    let charCode: String
    
    init(_ charCode: String) {
        self.charCode = charCode
    }
}
