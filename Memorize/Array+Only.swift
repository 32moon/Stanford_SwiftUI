//
//  Array+Only.swift
//  Memorize
//
//  Created by 이문정 on 2021/01/26.
//

import Foundation

// 모든 배열을 확장
extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
