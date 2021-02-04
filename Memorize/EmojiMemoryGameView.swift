//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by 이문정 on 2021/01/04.
//

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

import SwiftUI

struct EmojiMemoryGameView: View {
    // @ObservedObject 데이터 모델과 바인딩된 변경값을 받아 뷰를 다시 그림
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        
        Grid(viewModel.cards) { card in
            CardView(card: card).onTapGesture {
                viewModel.choose(card: card)
            }
            .padding(5)
        }
        .padding()
        .foregroundColor(Color.orange)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        // GeometryReader:View가 포함된 부모뷰(컨테이너)의 크기를 기준으로 View의 frame 조절하는 방법
        GeometryReader{ geometry in
            self.body(for: geometry.size)
        }
    }
    // ViewBuilder를 뷰의 목록으로 해석하게 되어 조건에 부합하지 않으면 뷰가 없는걸로 판단! EmptyView를 출력한다.
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUP || !card.isMatched {
            ZStack {
                // iOS에서는 0도가 오른쪽 이다. 따라서 -90을 해줘야 정 중앙에서 호가 그려지기 시작한다.
                // 드로잉 좌표 x, y 축이 반대로 되어있기 때문에 시계 반대방향을 원한다면 시계방향으로 설정해 주어야 한다.
                Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(110-90), clockwise: true).padding(5).opacity(0.4)
                Text(self.card.content)
                    // 카드 자체가 폰트를 설정하도록 함.
                    .font(Font.system(size: fontSize(for: size)))
            }
            // .modifier(Cardify(isFaceUp: card.isFaceUP))
            .cardify(isFaceUp: card.isFaceUP) 
        }
    }
    
    // MARK: - Drawing Constants
    // 여러 객체들을 구조체로 정리해 두는것이 좋음
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
}


























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
