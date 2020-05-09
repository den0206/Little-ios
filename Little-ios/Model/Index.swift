//
//  Index.swift
//  Little-ios
//
//  Created by 酒井ゆうき on 2020/05/10.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import Foundation

import Foundation

// MARK: - Empty
struct Index: Codable {
    let status: String
    let allCount: Int
    let broadcats: [Snippet]
    let pagenation: Pagenation
    
}



// MARK: - Pagenation
struct Pagenation: Codable {
    let pagenation: PagenationPagenation
}

// MARK: - PagenationPagenation
struct PagenationPagenation: Codable {
    let current: Int
    let previous: Int?
    let next, limitValue, pages, count: Int

    enum CodingKeys: String, CodingKey {
        case current, previous, next
        case limitValue = "limit_value"
        case pages, count
    }
}

