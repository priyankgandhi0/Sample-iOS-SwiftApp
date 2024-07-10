//
//  Extension+Array.swift
//  SampleiOSSwiftApp
//
//  Created by iMac on 10/07/24.
//

import Foundation
import UIKit

extension Array where Element: Hashable {

    func removingDuplicates<T: Hashable>(byKey key: (Element) -> T)  -> [Element] {
         var result = [Element]()
         var seen = Set<T>()
         for value in self {
             if seen.insert(key(value)).inserted {
                 result.append(value)
             }
         }
         return result
     }

}

public extension Array where Element == Double {
    static func generateRandom(size: Double) -> [Double] {
        guard size > 0 else {
            return [Double]()
        }
        let result = Array(repeating: 0, count: Int(size))
        return result.map{_ in Double.random(in: 0..<size)}
    }
}
