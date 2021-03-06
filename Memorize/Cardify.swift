//
//  Cardify.swift
//  Memorize
//
//  Created by 이문정 on 2021/02/04.
//

import SwiftUI

// 카드의 앞뒷면을 변수로 설정한 재사용 가능한 코드 작성 (카드의 형태)
struct Cardify: ViewModifier {
    
    var isFaceUp: Bool

    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                content // content로 modifier를 호출한 ZStack 의 뷰를 불러옴
            } else {
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
            }
        }
    }
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
}

// extension 사용해 간단하게 결합
extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}

