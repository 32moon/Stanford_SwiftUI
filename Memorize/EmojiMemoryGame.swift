//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by 이문정 on 2021/01/04.
//


// ViewModel 구성

// ViewModel은 본질적으로 UI이다.
// 화면에서 어떻게 그려질 지 알기 때문이다.

import SwiftUI

class EmojiMemoryGame: ObservableObject { // - ObservableObject 프로토콜 : 데이터 모델과 뷰를 바인딩 하는법
    // ObservableObjec를 사용하기 위해 @Published 를 사용: 변수의 값이 추가되거나 삭제 되었다는 것을 View가 알 수 있게 해준다.
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["👻", "🎃", "🕷"]
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - intent(s) 사용자 접근
    
    func choose(card: MemoryGame<String>.Card) {
        objectWillChange.send() // 뷰의 변화를 감지하여 ObservableObject에 send
        model.choose(card: card)
    }
    
}

