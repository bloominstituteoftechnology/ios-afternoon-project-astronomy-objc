//
//  SolDescription.swift
//  Astronomy
//
//  Created by Lambda_School_Loaner_241 on 9/30/20.
//


import Foundation

struct SolDescription: Codable {
    let sol: Int
    let totalPhotos: Int
    let cameras: [String]
}
