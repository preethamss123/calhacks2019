//
//  Actual Game.swift
//  Cambio
//
//  Created by Preetham S on 10/26/19.
//  Copyright © 2019 Preetham S. All rights reserved.
//

import UIKit

class Player: UIViewController {
    var buttonNum = 0
    var buttonValues = Array<UIButton>()
    var firstTurn = true
    var playedButtons = Array<UIButton>()
    var cardSuits = ["H", "D", "S", "C"]
    override func viewDidLoad(){
        super.viewDidLoad()
        createView()
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
        let cardNumber = getCardNumber(thisButton: me)
        me.setBackgroundImage(UIImage(named: (String(cardNumber % 13 + 1) + cardSuits[cardNumber % 4])), for: .normal)
        if firstTurn {
            firstTurn = false
        }
        else {
            removeCard(thisButton: me)
        }
        printCards()
    }
    
    func removeCard(thisButton: UIButton) {
        let cardNumber = getCardNumber(thisButton: thisButton)
        cardInfo.cardsPlayed.append(playerCards[cardNumber])
        buttonValues.remove(at: cardNumber).removeFromSuperview()
        playerCards.remove(at: cardNumber)
        }
    
    var playerCards = cardInfo.cards.getCard(num: 4)
    
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

    
    func createView() {
        var i = 0.0
        while i < 4.0 {
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

