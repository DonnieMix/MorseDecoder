//
//  ViewController.swift
//  MorseDecoder
//
//  Created by Kyrylo Derkach on 02.02.2024.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    let vm = ViewModel()
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var dotButton: UIButton!
    @IBOutlet weak var dashButton: UIButton!
    @IBOutlet weak var spaceButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vm.outputString
            .subscribe(
                onNext: { [weak self] output in
                    self?.outputLabel.text = output
                }
            )
            .disposed(by: disposeBag)
        
        vm.alertText
            .subscribe(
                onNext: { [weak self] alertMessage in
                    guard !alertMessage.isEmpty else { return }
                    let alert = UIAlertController(title: "Oops...", message: alertMessage, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default)
                    alert.addAction(okAction)
                    self?.present(alert, animated: true)
                }
            )
            .disposed(by: disposeBag)
        
    }
    
    @IBAction func onDotTap(_ sender: UIButton) {
        vm.addMorseCharacter(.short)
    }
    @IBAction func onDashTap(_ sender: UIButton) {
        vm.addMorseCharacter(.long)
    }
    @IBAction func onSpaceTap(_ sender: UIButton) {
        vm.addMorseCharacter(.pause)
    }
    @IBAction func onResetTap(_ sender: UIButton) {
        vm.resetOutput()
    }
    
}

