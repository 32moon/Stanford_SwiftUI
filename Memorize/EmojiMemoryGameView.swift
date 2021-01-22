//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by 이문정 on 2021/01/04.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    var viewModel: EmojiMemoryGame
    
    var body: some View {
        // 원하는 설정을 스택처럼 쌓아서 작성할 수 있음(?)
        // 함수의 호출 범위를 지정하여 수식을 변경할 수 있다.---> 수식어 적용 순서에 따라 달라짐
        // 수식어는 이전의 뷰를 감싼 새로운 뷰를 만들어 내고, 그다음 수식어는 다시 그 뷰를 감싼다.
        // 뷰 사이의 간격, 패딩은 표준으로 설정되어 있다.
        // return을 생략할 수 있다.
        // 중괄호를 생략할 수 있다, content 생략 가능
        // ZStack: 뷰 계층을 겹겹이 쌓아올리는 배열
        // HStack: 수평배열
        // VStack: 수직배열
        // swift의 변수는 항상 초기값을 가져야 한다.
        HStack {
            ForEach(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    viewModel.choose(card: card)
                }
            }
        }
        .padding()
        .foregroundColor(Color.orange)
        .font(Font.largeTitle)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            if card.isFaceUP {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.orange)
            }
        }
    }
}


























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
