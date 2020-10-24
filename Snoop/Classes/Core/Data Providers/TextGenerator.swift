//
//  TextGenerator.swift
//  Snoop
//
//  Created by Sergey Kim on 19.10.2020.
//

import Foundation

final class TextGenerator {

    func randomString(maxLength: Int) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        var result: String = ""

        for _ in 0..<Int.random(in: 1..<maxLength) {
            let index = base.index(base.startIndex, offsetBy: Int.random(in: 0..<base.count))
            result += String(base[index])
        }

        return result
    }
}
