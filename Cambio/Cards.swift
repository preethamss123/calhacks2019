//
//  Cards.swift
//  Cambio
//
//  Created by Preetham S on 10/26/19.
//  Copyright © 2019 Preetham S. All rights reserved.
//

import UIKit

class Card: NSObject {
    var card = Array<Int>()
    var i = 1
    func createCards(){
        while i <= 54 {
            card.append(i)
            i = i + 1
        }
    }
    func getCard()-> Array<Int>{
        var playerCards = Array<Int>()
        i = 4
        while i > 0 {
            let randomElementIndex = Int.random(in: 0..<card.count)
            playerCards.append(card[randomElementIndex])
            i = i - 1
        }
        return playerCards
    }
}


