//
//  DecodableParser.swift
//  MovieGrid
//
//  Created by Oleg Poliukhovych on 3/15/20.
//  Copyright © 2020 Oleg Poliukhovych. All rights reserved.
//

import Foundation

enum DecodableParser {

    static func parse<T: Decodable>(data: Data, to type: T.Type) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-DD"
        decoder.dateDecodingStrategy = .formatted(formatter)
        do {
            return try decoder.decode(type, from: data)
        } catch {
            debugPrint("file: \(#file)\n line: \(#line)\n", error)
            throw error
        }
    }
}
