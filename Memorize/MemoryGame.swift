//
//  MemoryGame.swift
//  Memorize
//
//  Created by 이문정 on 2021/01/04.
//


// Model 구성


import Foundation

//Equatable: 프로토콜을 준수하는 타입으로, 등호 연산자 == 또는 같지않음 연산자 != 를 사용하여 동등성을 비교할 수 있다.
struct MemoryGame<CardContent> where CardContent: Equatable { // generic type 선언
    private(set) var cards: Array<Card>
   
    // 카드의 상태가 어떨지 알 수 없으므로 옵셔널변수로 해줌.
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        //index in cards = cards[$0]
        get { cards.indices.filter { cards[$0].isFaceUP }.only }
//            for index in cards.indices {
//                if cards[index].isFaceUP {
//                    faceUpCardIndices.append(index)
//                }
//            }
//            if faceUpCardIndices.count == 1 {
//                return faceUpCardIndices.first
//            } else {
//                return nil
//            }
        set {
            for index in cards.indices {
                cards[index].isFaceUP = index == newValue
//                if index == newValue {
//                cards[index].isFaceUP = true
//                } else {
//                cards[index].isFaceUP = false
//                }
            }
        }
    }
    
    // 값 타입(구조체)의 속성은 인스턴스 매서드 내에서 변경할 수 없다.
    // 구조체의 매서드가 구조체 내부에서 데이터 수정 할 때 Mutating키워드를 선언 해주면 self 프로퍼티에 새로운 인스턴스를 할당할 수 있다.
    // 카드가 뒤집어져 있는 상태로 만드는 함수
    mutating func choose(card: Card) {
        if let chosenIndex = cards.firstIndex(matching: card),
                             !cards[chosenIndex].isFaceUP,
                             !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
            if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                cards[chosenIndex].isMatched = true
                cards[potentialMatchIndex].isMatched = true
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUP = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        self.cards[chosenIndex].isFaceUP = true
        }
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
        var isFaceUP: Bool = false
        var isMatched: Bool = false
        var content: CardContent // 어떤 타입이든 상관 없을 때
        var id: Int
        
    }
}
