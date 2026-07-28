//
//  CharaterResponse.swift
//  SwiftExamplesUIKit
//
//  Created by Rahul Acharya on 22/07/26.
//  Copyright © 2026 Swift Examples. All rights reserved.
//

import Foundation

class CharaterResponse: Codable {
    var info: InfoResponse?
//    var results: String?
    
    enum CodingKeys: String, CodingKey {
        case info = "info"
//        case results = "results"
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.info = try? container?.decodeIfPresent(InfoResponse.self, forKey: .info)
//        self.results = try container.decode(String.self, forKey: .results)
    }
}

class InfoResponse: Codable {
    var count: Int?
    var pages: Bool?
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case pages = "pages"
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.count = try? container?.decodeIfPresent(Int.self, forKey: .count)
        self.pages = try? container?.decodeIfPresent(Bool.self, forKey: .pages)
    }
}

/*
 Codable Notes

 There are a few common ways to decode JSON:

 1. Non-optional property + decode()
    Example:
        let count: Int
        count = try container.decode(Int.self, forKey: .count)

    - Key must exist.
    - Value cannot be null.
    - Value must be the expected type.
    - Otherwise decoding throws an error.

 2. Optional property + decode()
    Example:
        let count: Int?
        count = try container.decode(Int.self, forKey: .count)

    - Property is optional, but decode() still expects the key to exist.
    - If the key is missing, null, or the type is wrong, decoding throws an error.
    - Simply making the property optional does NOT prevent decoding errors.

 3. CodingKeys
    Example:
        enum CodingKeys: String, CodingKey {
            case totalCount = "count"
        }

    - Used to map JSON keys to different property names.
    - Helpful when JSON naming and Swift naming are different.
    - Not required if both names are the same.

 4. decodeIfPresent()
    Example:
        count = try container.decodeIfPresent(Int.self, forKey: .count)

    - Returns nil if:
        • key is missing
        • value is null
    - Still throws an error if the value exists but has the wrong type.

 5. try? + decodeIfPresent()
    Example:
        count = try? container.decodeIfPresent(Int.self, forKey: .count)

    - Safest option.
    - Returns nil if:
        • key is missing
        • value is null
        • value has the wrong type
        • any decoding error occurs
    - Only that property becomes nil; decoding continues for the remaining properties.

 Summary

 decode()
    → Key must exist, value must not be null, and type must match.

 decodeIfPresent()
    → Missing key or null becomes nil, but type mismatch still throws.

 try? decodeIfPresent()
    → Missing key, null, or type mismatch all result in nil without crashing.
 */
