//
//  Helper.swift
//  JPM
//
//  Created by Tatsuya Moriguchi on 11/2/21.
//  Copyright © 2021 Tatsuya Moriguchi. All rights reserved.
//

import Foundation

class Helper {
    func removeAfter(char: String, word: String) -> String {
        var string: String = ""
        if let index = word.range(of: char)?.lowerBound {
            let substring = word[..<index]
            string = String(substring)
        }
        return string
    }
    

}

extension String {
    func toDouble() -> Double {
        let nsString = self as NSString
        return nsString.doubleValue
    }

}
