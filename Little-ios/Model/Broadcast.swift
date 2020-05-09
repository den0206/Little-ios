//
//  Broadcast.swift
//  Little-ios
//
//  Created by 酒井ゆうき on 2020/05/09.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import Foundation


// MARK: - Empty
struct Broadcast: Codable {
    let status: String
    let snippet: Snippet
    let imageURL: String
    var wawos, kawos: [String]

    enum CodingKeys: String, CodingKey {
        case status, snippet
        case imageURL = "image_url"
        case wawos, kawos
    }
}

// MARK: - Snippet
struct Snippet: Codable {
    let id, number: Int
    let date, title, guest, snippetDescription: String?
    let kasu, waka, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, number, date, title, guest, waka, kasu
        case snippetDescription = "description"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

