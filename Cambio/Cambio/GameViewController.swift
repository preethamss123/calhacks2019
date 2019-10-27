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
    
    var card = Array<Int>()
    func createCards(){
        var i = 1
        while i <= 52 {
            card.append(i)
            i += 1
        }
    }
    
    func getCard(num: Int)-> Array<Int>{
        var i = num
        if card.count == 0 {
            createCards()
        }
        var playerCards = Array<Int>()
        while i > 0 {
            let randomElementIndex = Int.random(in: 0..<card.count)
            playerCards.append(card[randomElementIndex])
            card.remove(at: randomElementIndex)
            i = i - 1
        }
        return playerCards
    }
}

struct cardInfo {
    static var cards = GameViewController()
    static var numCards = 4
    static var numPlayers = 2
    static var cardsPlayed = Array<Int>()
}
