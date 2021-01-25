//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by 이문정 on 2021/01/25.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
}
