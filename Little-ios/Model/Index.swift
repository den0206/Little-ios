//
//  Index.swift
//  Little-ios
//
//  Created by 酒井ゆうき on 2020/05/10.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import Foundation

// MARK: - Empty
import Foundation

// MARK: - Empty
struct Index: Codable {
    let allCount: Int
    let broadcasts: [Broadcast]
    let pagenation: Pagenation
}

// MARK: - Broadcast
struct Broadcast: Codable {
    let id, number: Int
    let date, title, guest, broadcastDescription: String?
    let kasu,waka, createdAt, updatedAt: String
    let image: String
    
    //    let date, title, guest, snippetDescription: String?
    //    let kasu, waka, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, number, date, title, guest, waka, kasu
        case broadcastDescription = "description"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case image
    }
}

// MARK: - Pagenation
struct Pagenation: Codable {
    let pagenation: PagenationPagenation
}

// MARK: - PagenationPagenation
struct PagenationPagenation: Codable {
    
    let previous, next: Int?
    let pages, count,limitValue,current: Int

    enum CodingKeys: String, CodingKey {
        case current, previous, next
        case limitValue = "limit_value"
        case pages, count
    }
}

struct Words: Codable {
    let wawos, kawos: [String]
}


//import Foundation
//
//import Foundation
//
//// MARK: - Empty
//struct Index: Codable {
//    let status: String
//    let allCount: Int
//    let broadcats: [Snippet]
//    let pagenation: Pagenation
//
//}
//
//
//
//// MARK: - Pagenation
//struct Pagenation: Codable {
//    let pagenation: PagenationPagenation
//}
//
//// MARK: - PagenationPagenation
//struct PagenationPagenation: Codable {
//    let current: Int
//    let previous: Int?
//    let next, limitValue, pages, count: Int
//
//    enum CodingKeys: String, CodingKey {
//        case current, previous, next
//        case limitValue = "limit_value"
//        case pages, count
//    }
//}
//
