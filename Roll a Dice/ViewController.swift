//
//  ViewController.swift
//  Roll a Dice
//
//  Created by Andrej Lotski on 23/7/20.
//  Copyright © 2020 Andrej Lotski. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet var diceOne: UIButton!
    @IBOutlet var diceTwo: UIButton!
    @IBOutlet var diceThree: UIButton!
    @IBOutlet var diceFour: UIButton!
    @IBOutlet var diceFive: UIButton!
    @IBOutlet var diceSix: UIButton!
    @IBOutlet var rollButton: UIButton!
    @IBOutlet var extra2Button: UIButton!
    @IBOutlet var rollsLeft: UILabel!
    @IBOutlet var resetButton: UIButton!
    let diceArray = [#imageLiteral(resourceName: "dice1"), #imageLiteral(resourceName: "dice2"), #imageLiteral(resourceName: "dice3"), #imageLiteral(resourceName: "dice4"), #imageLiteral(resourceName: "dice5"), #imageLiteral(resourceName: "dice6")]
    
    var diceOneFlag = false
    var diceTwoFlag = false
    var diceThreeFlag = false
    var diceFourFlag = false
    var diceFiveFlag = false
    var diceSixFlag = false
    
    var numRolls = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        diceOne.setImage(#imageLiteral(resourceName: "clearCube"), for: .normal)
        diceTwo.setImage(#imageLiteral(resourceName: "clearCube"), for: .normal)
        diceThree.setImage(#imageLiteral(resourceName: "clearCube"), for: .normal)
        diceFour.setImage(#imageLiteral(resourceName: "clearCube"), for: .normal)
        diceFive.setImage(#imageLiteral(resourceName: "clearCube"), for: .normal)
        diceSix.setImage(#imageLiteral(resourceName: "clearCube"), for: .normal)
        
        diceOneFlag = false
        diceTwoFlag = false
        diceThreeFlag = false
        diceFourFlag = false
        diceFiveFlag = false
        diceSixFlag = false
        
        resetDice(number: diceOne)
        resetDice(number: diceTwo)
        resetDice(number: diceThree)
        resetDice(number: diceFour)
        resetDice(number: diceFive)
        resetDice(number: diceSix)
        
        disableButtons()
        
        rollsLeft.text = "\(3 - numRolls) rolls left"
    }
    
    func disableButtons() {
        diceOne.isEnabled = false
        diceOne.adjustsImageWhenDisabled = false
        diceTwo.isEnabled = false
        diceTwo.adjustsImageWhenDisabled = false
        diceThree.isEnabled = false
        diceThree.adjustsImageWhenDisabled = false
        diceFour.isEnabled = false
        diceFour.adjustsImageWhenDisabled = false
        diceFive.isEnabled = false
        diceFive.adjustsImageWhenDisabled = false
        diceSix.isEnabled = false
        diceSix.adjustsImageWhenDisabled = false
    }
    
    func enableButtons() {
        diceOne.isEnabled = true
        diceTwo.isEnabled = true
        diceThree.isEnabled = true
        diceFour.isEnabled = true
        diceFive.isEnabled = true
        diceSix.isEnabled = true
    }
    
    func resetDice(number: UIButton) {
        number.layer.cornerRadius = 0
        number.layer.borderWidth = 0
        number.layer.borderColor = UIColor.clear.cgColor
    }
    
    func updateDice(number: UIButton) {
        number.layer.cornerRadius = 15
        number.layer.borderWidth = 5
        number.layer.borderColor = UIColor.systemYellow.cgColor
    }
    
    @IBAction func extra2Pressed(_ sender: UIButton) {
        numRolls = numRolls - 2
        rollsLeft.text = "\(3 - numRolls) rolls left"
        extra2Button.isEnabled = false
    }
    
    @IBAction func resetPressed(_ sender: UIButton) {
        rollButton.isEnabled = true
        extra2Button.isEnabled = true
        numRolls = 0
        viewDidLoad()
    }
    
    func checkAll() {
        if diceOneFlag && diceTwoFlag && diceThreeFlag && diceFourFlag && diceFiveFlag && diceSixFlag == true {
            rollButton.isEnabled = false
        } else if numRolls < 3 {
            rollButton.isEnabled = true
        }
    }
    
    @IBAction func diceOnePressed(_ sender: UIButton) {
        if diceOneFlag == true {
            resetDice(number: diceOne)
            diceOneFlag = false
        } else {
            diceOneFlag = true
            updateDice(number: diceOne)
        }
        
        checkAll()
    }
    
    @IBAction func diceTwoPressed(_ sender: UIButton) {
        if diceTwoFlag == true {
            resetDice(number: diceTwo)
            diceTwoFlag = false
        } else {
            diceTwoFlag = true
            updateDice(number: diceTwo)
        }
        
        checkAll()
    }
    
    @IBAction func diceThreePressed(_ sender: UIButton) {
        if diceThreeFlag == true {
            resetDice(number: diceThree)
            diceThreeFlag = false
        } else {
            diceThreeFlag = true
            updateDice(number: diceThree)
        }
        
        checkAll()
    }
    
    @IBAction func diceFourPressed(_ sender: UIButton) {
        if diceFourFlag == true {
            resetDice(number: diceFour)
            diceFourFlag = false
        } else {
            diceFourFlag = true
            updateDice(number: diceFour)
        }
        
        checkAll()
    }
    
    @IBAction func diceFivePressed(_ sender: UIButton) {
        if diceFiveFlag == true {
            resetDice(number: diceFive)
            diceFiveFlag = false
        } else {
            diceFiveFlag = true
            updateDice(number: diceFive)
        }
        
        checkAll()
    }
    
    @IBAction func diceSixPressed(_ sender: UIButton) {
        if diceSixFlag == true {
            resetDice(number: diceSix)
            diceSixFlag = false
        } else {
            diceSixFlag = true
            updateDice(number: diceSix)
        }
        
        checkAll()
    }
    
    var audioPlayer: AVAudioPlayer?
    let path = Bundle.main.path(forResource: "diceSound", ofType: "mp3")
    
    @IBAction func rollPressed(_ sender: UIButton) {
        
        disableButtons()
        rollButton.isEnabled = false
        resetButton.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.enableButtons()
            self.resetButton.isEnabled = true
            if self.numRolls != 3 {
                self.rollButton.isEnabled = true
            }
        }
        
        if diceOneFlag, diceTwoFlag, diceThreeFlag, diceFourFlag, diceFiveFlag, diceSixFlag == true {}
        else {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path!))
                audioPlayer?.play()
                
            } catch {
                print(error)
            }
            
            numRolls += 1
            extra2Button.isEnabled = false
            rollsLeft.text = "\(3 - numRolls) rolls left"
            if numRolls == 3 {
                rollButton.isEnabled = false
                rollsLeft.text = ""
            }
            
            if diceOneFlag == false {
                diceOne.setImage(diceArray[Int.random(in: 0...5)], for: .normal)
                diceOne.shake()
            }
            if diceTwoFlag == false {
                diceTwo.setImage(diceArray[Int.random(in: 0...5)], for: .normal)
                diceTwo.shake()
            }
            if diceThreeFlag == false {
                diceThree.setImage(diceArray[Int.random(in: 0...5)], for: .normal)
                diceThree.shake()
            }
            if diceFourFlag == false {
                diceFour.setImage(diceArray[Int.random(in: 0...5)], for: .normal)
                diceFour.shake()
            }
            if diceFiveFlag == false {
                diceFive.setImage(diceArray[Int.random(in: 0...5)], for: .normal)
                diceFive.shake()
            }
            if diceSixFlag == false {
                diceSix.setImage(diceArray[Int.random(in: 0...5)], for: .normal)
                diceSix.shake()
            }
        }
    }
}

extension UIView {
    func shake() {
        let translation = CAKeyframeAnimation(keyPath: "transform.translation.x");
        translation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        translation.values = [-5, 5, -5, 5, -3, 3, -2, 2, 0]
        
        let rotation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotation.values = [-5, 5, -5, 5, -3, 3, -2, 2, 0].map {
            (degrees: Double) -> Double in
            let radians: Double = (Double.pi * degrees)
            return radians
        }
        
        let translationY = CAKeyframeAnimation(keyPath: "transform.translation.y");
        translationY.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        translationY.values = [-10, 10, -10, 10, -5, 5, -2, 2, 0]
        
        let shakeGroup: CAAnimationGroup = CAAnimationGroup()
        shakeGroup.animations = [translation, rotation, translationY, rotation]
        shakeGroup.duration = 1
        self.layer.add(shakeGroup, forKey: "shakeIt")
    }
}
