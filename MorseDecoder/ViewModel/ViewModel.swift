//
//  ViewModel.swift
//  MorseDecoder
//
//  Created by Kyrylo Derkach on 02.02.2024.
//

import Foundation
import RxSwift

class ViewModel {
    
    let outputString = BehaviorSubject<String>(value: "")
    private var morseCode = ""
    
    let alertText = BehaviorSubject<String>(value: "")
    
    func addMorseCharacter(_ character: MorseCharacter) {
        morseCode.append(character.description)
        
        if character == .pause {
            do {
                let newOutputChar = try Morse.decodeMorseString(code: morseCode)
                guard var currentOutput = try? outputString.value() else { return }
                
                currentOutput.append(newOutputChar)
                outputString.onNext(currentOutput)
            }
            
            catch(let err) {
                if err is InvalidStringError {
                    alertText.onNext("Wow... You just somehow gave illegal input")
                }
                else if let err = err as? NonExistingCodeError {
                    alertText.onNext("The symbol is unknown for code: \(err.charCode)")
                }
            }
            
            morseCode = ""
        }
    }
    
    func resetOutput() {
        morseCode = ""
        outputString.onNext("")
    }
    
}
