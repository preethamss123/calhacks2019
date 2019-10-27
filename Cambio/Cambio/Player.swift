//
//  Actual Game.swift
//  Cambio
//
//  Created by Preetham S on 10/26/19.
//  Copyright © 2019 Preetham S. All rights reserved.
//

import UIKit

class Player: UIViewController, UITextFieldDelegate {
    var buttonNum = 0
    var buttonValues = Array<UIButton>()
    var firstTurn = true
    var playedButtons = Array<UIButton>()
    var cardSuits = ["H", "D", "S", "C"]
    var playerCards = Array<Int>()
    var turn = 0
    var firstfirst = true
    var beforeFirst = true
    var textInput: String = ""
    
    override func viewDidLoad(){
        super.viewDidLoad()
        GameViewController.createPlayers(num: cardInfo.numCards)
        if beforeFirst {
            createTextField()
        }
        createView(num: GameViewController.nextTurn())
    }
    
    func createTextField() {
            let textField =  UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
            textField.placeholder = "Enter text here"
            textField.font = UIFont.systemFont(ofSize: 15)
            textField.borderStyle = UITextField.BorderStyle.roundedRect
            textField.autocorrectionType = UITextAutocorrectionType.no
            textField.returnKeyType = UIReturnKeyType.done
            textField.keyboardType = .numberPad
            textField.clearButtonMode = UITextField.ViewMode.whileEditing
            textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
            textField.delegate = self
            self.view.addSubview(textField)
    }
    
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        print("pressed")
        textField.removeFromSuperview()
        return true
    }
    
    
    
    func getCardNumber(thisButton: UIButton) -> Int{
        var count = 0
        while count < buttonValues.count {
            if buttonValues[count] == thisButton {
                return count
            }
            count += 1
        }
        return 0
    }
    
    func getPlayedNumber(thisButton: UIButton) -> Int{
        var count = 0
        while count < playedButtons.count {
            if playedButtons[count] == thisButton {
                return count
            }
            count += 1
        }
        return 0
    }
    
    @objc func buttonAction(me: UIButton!)
    {
        printCards()
        if firstTurn {
            firstTurn = false
        }
        else {
            firstTurn = true
            removeCard(thisButton: me)
            removeAllCards()
            createView(num: GameViewController.nextTurn())
        }
    }
    
    func removeAllCards(){
        var count = buttonValues.count - 1
        while count >= 0 {
            buttonValues.remove(at: count).removeFromSuperview()
            count = count - 1
        }
    }
    
    func removeCard(thisButton: UIButton) {
        let cardNumber = getCardNumber(thisButton: thisButton)
        cardInfo.cardsPlayed.append(playerCards[cardNumber])
        buttonValues.remove(at: cardNumber).removeFromSuperview()
        GameViewController.players[turn].remove(at: cardNumber)
        }
    
    func printCards() {
        var count = 0
        while count < buttonValues.count {
            let cardNumber = playerCards[getCardNumber(thisButton: buttonValues[count])]
            buttonValues[count].setBackgroundImage(UIImage(named: (String(cardNumber % 13 + 1) + cardSuits[cardNumber % 4])), for: .normal)
            buttonValues[count].setTitle("", for: UIControl.State.normal)
            count += 1
        }
        count = playedButtons.count - 1
        while count >= 0 {
            playedButtons.remove(at: count).removeFromSuperview()
            count = count - 1
        }
        printPlayed()
    }
    
    func printPlayed() {
        var i = Double(cardInfo.cardsPlayed.count - 1)
        while Int(i) >= 0 {
            let button = UIButton(type: UIButton.ButtonType.system) as UIButton
            let width = Int(i.truncatingRemainder(dividingBy: 2))
            let height = Int(i / 2)
            let xPostion:CGFloat = 50 + CGFloat(width) * 225
            let yPostion:CGFloat = 50 + CGFloat(height) * 200
            let buttonWidth:CGFloat = 75
            let buttonHeight:CGFloat = 150
            button.frame = CGRect(x:xPostion, y:yPostion, width:buttonWidth, height:buttonHeight)
            let cardNumber = cardInfo.cardsPlayed[Int(i)]
            button.setBackgroundImage(UIImage(named: (String(cardNumber % 13 + 1) + cardSuits[cardNumber % 4])), for: .normal)
            self.view.addSubview(button)
            playedButtons.append(button)
            i = i - 1.0
    }
    }

    
    func createView(num: Int) {
        if !firstfirst {
            printCards()
        }
        else {
            firstfirst = false
        }
        turn = num
        var i = 0.0
        playerCards = GameViewController.players[num]
        while i < Double(playerCards.count) {
            let button = UIButton(type: UIButton.ButtonType.system) as UIButton
            let width = Int(i.truncatingRemainder(dividingBy: 2))
            let height = Int(i / 2)
            let xPostion:CGFloat = 50 + CGFloat(width) * 225
            let yPostion:CGFloat = 400 + CGFloat(height) * 200
            let buttonWidth:CGFloat = 75
            let buttonHeight:CGFloat = 150
            button.frame = CGRect(x:xPostion, y:yPostion, width:buttonWidth, height:buttonHeight)
            button.setTitle("Tap me", for: UIControl.State.normal)
            button.addTarget(self, action: #selector(buttonAction(me: )), for: .touchUpInside)
            self.view.addSubview(button)
            buttonValues.append(button)
            i = i + 1.0
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

