//
//  Models.swift
//  UIKitTestApp
//
//  Created by Александр Коробицын on 06.06.2024.
//

import Foundation

struct Product: Decodable {
    let title: String
    let price: Int
    let description: String
    let images: [String]
}


