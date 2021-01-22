//
//  MemoryGame.swift
//  Memorize
//
//  Created by 이문정 on 2021/01/04.
//


// Model 구성


import Foundation

struct MemoryGame<CardContent> { // generic type 선언
    var cards: [Card]
   
    // 값 타입(구조체)의 속성은 인스턴스 매서드 내에서 변경할 수 없다.
    // 구조체의 매서드가 구조체 내부에서 데이터 수정 할 때 Mutating키워드를 선언 해주면 self 프로퍼티에 새로운 인스턴스를 할당할 수 있다.
    // 카드가 뒤집어져 있는 상태로 만드는 함수
    mutating func choose(card: Card) {
        print("card chosen: \(card)")
        let chosenIndex: Int = self.index(of: card)
        self.cards[chosenIndex].isFaceUP = !self.cards[chosenIndex].isFaceUP
    }
    
    func index(of card: Card) -> Int {
        for index in 0 ..< self.cards.count {
            if self.cards[index].id == card.id {
                return index
            }
        }
        return 0 // TODO: bogus!
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
    }
    
    struct Card : Identifiable {
        var isFaceUP: Bool = true
        var isMatched: Bool = false
        var content: CardContent // 어떤 타입이든 상관 없을 때
        var id: Int
        
    }
}
