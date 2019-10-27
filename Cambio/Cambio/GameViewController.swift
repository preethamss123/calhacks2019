//
//  GameViewController.swift
//  Cambio
//
//  Created by Preetham S on 10/26/19.
//  Copyright © 2019 Preetham S. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    @IBOutlet weak var numCards: UISlider!
    @IBOutlet weak var displayCards: UILabel!
    @IBOutlet weak var numPlayers: UISlider!
    @IBOutlet weak var displayPlayers: UILabel!
    static var players = Array<Array<Int>>()
    static var turn = -1
    static var roundTurns = -1
    static var trump = "H"
    static var roundTrump = "D"
    static var cardSuits = ["H", "D", "S", "C"]
    static var roundBets = [Int]()
    static var roundPoints = [Int()]
    static var totalPoints = [Int()]
    static var card = Array<Int>()
    static var numZero = 0
    
    @IBAction func onClick(_ sender: Any) {
        performSegue(withIdentifier: "Changer", sender: self)
    }
    
    @IBAction func changePlayers(_ sender: Any) {
        displayPlayers.text = String(Int(numPlayers.value))
        cardInfo.numPlayers = Int(numPlayers.value)
    }
    
    @IBAction func changeSlider(_ sender: Any) {
        displayCards.text = String(Int(numCards.value))
        cardInfo.numCards = Int(numCards.value)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numCards.minimumValue = 2
        numCards.maximumValue = 8
        numPlayers.minimumValue = 2
        numPlayers.maximumValue = 4
        displayCards.text = String(Int(numCards.value))
        displayPlayers.text = String(Int(numPlayers.value))
    }
    
    static func createCards(){
        var i = 1
        while i <= 52 {
            card.append(i)
            i += 1
        }
    }
    
    static func nextTurn() -> Int{
        turn += 1
        roundTurns += 1
        if roundTurns == cardInfo.numPlayers{
            roundTurns = 0
            determineWinner()
            cardInfo.cardsPlayed = Array<Int>()
            if players[turn % cardInfo.numPlayers].count == 0 {
                resetRound()
            }
        }
        return turn % cardInfo.numPlayers
    }
    
    static func resetRound() {
        roundBets = Array<Int>()
        card = Array<Int>()
        players = Array<Array<Int>>()
        createPlayers(num: cardInfo.numCards)
    }
    
    static func createPlayers(num: Int){
        for _ in 0..<cardInfo.numPlayers {
            var i = num
            if card.count == 0 {
                createCards()
        }
            var playerCards = Array<Int>()
            for _ in 0..<num {
                let randomElementIndex = Int.random(in: 0..<card.count)
                playerCards.append(card[randomElementIndex])
                card.remove(at: randomElementIndex)
                i = i - 1
            }
            players.append(playerCards)
        }
    }
    
    static func determineWinner(){
        var pointValues = [Int]()
        for i in 0...cardInfo.cardsPlayed.count - 1{
            let cardNumber = cardInfo.cardsPlayed[i] % 13 + 1
            let cardSuit = cardSuits[cardInfo.cardsPlayed[i] % 4]
            if cardSuit == trump {
                pointValues.append(100 + cardNumber)
            }
            else if cardSuit == roundTrump {
                pointValues.append(20 + cardNumber)
            }
            else {
                pointValues.append(cardNumber)
            }
        }
        var maxPlayer = pointValues.max()
        for i in 0..<pointValues.count{
            if pointValues[i] == maxPlayer{
                maxPlayer = i
            }
        }
        print(String(maxPlayer!))
    }
}

struct cardInfo {
    static var numCards = 4
    static var numPlayers = 4
    static var cardsPlayed = Array<Int>()
}
