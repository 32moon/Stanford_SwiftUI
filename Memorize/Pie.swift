//
//  Pie.swift
//  Memorize
//
//  Created by 이문정 on 2021/02/03.
//

import SwiftUI

struct Pie: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool = false // 시계 반대방향은 false, 시계방향은 true
   
    // 호의 경로를 제시하는 함수 설정, Path는 호가 그려지는 가장자리 경로이다.
    func path(in rect: CGRect) -> Path {
        // 주어진 공간의 중앙
        let center = CGPoint(x: rect.midX, y: rect.midY)
        // 원의 반지름을 카드를 기준으로 x, y축의 /2 로 설정
        let radius = min(rect.width, rect.height) / 2
        // 원이 그려지는 시작 지점 설정
        let start = CGPoint(
            x: center.x + radius * cos(CGFloat(startAngle.radians)),
            y: center.y + radius * sin(CGFloat(startAngle.radians))
        )
        
        // 경로를 반환하는 변수, Path 함수 호출
        var p = Path()
        p.move(to: center)
        p.addLine(to: start)  // 호가 그려지는 시작점
        p.addArc(center: center,           // 원의 중심
                 radius: radius,           // 반지름
                 startAngle: startAngle,   // 원을 그리는 시작 지점
                 endAngle: endAngle,       // 원을 그리는 종료 지점
                 clockwise: clockwise      // 원이 움직이는 방향
        )
        p.addLine(to: center)  // 원이 다 그려지고 다시 중앙으로 돌아가는 라인
        
        return p
    }
}
