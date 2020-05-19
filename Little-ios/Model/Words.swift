//
//  Words.swift
//  Little-ios
//
//  Created by 酒井ゆうき on 2020/05/19.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import Foundation

// MARK: - Empty
struct Word: Codable {
    let wawos: [Wawo]?
    let kawos: [Kawo]?
    let pagenation: Pagenation
}



// MARK: - Wawo
struct Wawo: Codable {
    let id: Int?
    let broadcastID: Int
    let body: String

    enum CodingKeys: String, CodingKey {
        case id
        case broadcastID = "broadcast_id"
        case body
    }
}

// MARK: - Kawo
struct Kawo: Codable {
    let id: Int?
    let broadcastID: Int
    let body: String

    enum CodingKeys: String, CodingKey {
        case id
        case broadcastID = "broadcast_id"
        case body
    }
}
