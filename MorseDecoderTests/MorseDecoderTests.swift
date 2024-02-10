//
//  MorseDecoderTests.swift
//  MorseDecoderTests
//
//  Created by Kyrylo Derkach on 02.02.2024.
//

import XCTest
@testable import MorseDecoder

final class MorseDecoderTests: XCTestCase {
    
    var vm: ViewModel?

    override func setUpWithError() throws {
        vm = ViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func multipleInput(in viewModel: ViewModel, _ inputs: MorseCharacter...) {
        for morseCharacter in inputs {
            viewModel.addMorseCharacter(morseCharacter)
        }
    }
    
    func testVMDecoding() throws {
        guard let vm else { XCTFail(); return }

        multipleInput(in: vm,
                           .short, .short, .short, .pause)
        var decodedText = try vm.outputString.value()
        XCTAssertEqual(decodedText, "S")
        
        multipleInput(in: vm,
                           .long, .long, .pause)
        decodedText = try vm.outputString.value()
        XCTAssertEqual(decodedText, "SM")
        
        multipleInput(in: vm,
            .short, .short, .short, .pause)
        decodedText = try vm.outputString.value()
        XCTAssertEqual(decodedText, "SMS")
        
    }
    
    func testVMWrongInput() throws {
        guard let vm else { XCTFail(); return }
        
        multipleInput(in: vm, .short, .long, .short, .long, .short, .long, .pause)
        let decodedText = try vm.outputString.value()
        let alertText = try vm.alertText.value()
        XCTAssert(decodedText.isEmpty)
        XCTAssert(!alertText.isEmpty)
    }
    
    func testModelDecoding() throws {
        XCTAssertEqual(try Morse.decodeMorseString(code: "..._--_..._"), "SMS")
        XCTAssertNoThrow(try Morse.decodeMorseString(code: ".._"))
        
    }
    
    func testModelErrors() throws {
        XCTAssertThrowsError(try Morse.decodeMorseString(code: "Lorem ipsum"))
        XCTAssertThrowsError(try Morse.decodeMorseString(code: "..--...-_"))
        
        do { let _ = try Morse.decodeMorseString(code: "Lorem ipsum") }
        catch(let error) { XCTAssertTrue(error is InvalidStringError) }
        
        do { let _ = try Morse.decodeMorseString(code: "..--...-_") }
        catch(let error) { XCTAssertTrue(error is NonExistingCodeError) }
    }

}
