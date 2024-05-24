//
//  Helper.swift
//  store
//
//  Created by Evelina on 06.07.2023.
//

import Foundation

class Helper {
    static func getStringRating(rating: Double) -> [String] {
        let fullStar = "★ "
        var fullStarString = ""
        var emptyStarString = ""
        for counter in 1...5 {
            if rating - Double(counter) > 0.01 {
                fullStarString += fullStar
            } else {
                emptyStarString += fullStar
            }
        }
        return [fullStarString, emptyStarString]
    }
}
