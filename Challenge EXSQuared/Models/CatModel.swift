//
//  CatModel.swift
//  Challenge EXSQuared
//
//  Created by Matias Nicolas Morales on 06/02/2025.
//

import Foundation

struct CatModel: Codable, Identifiable {
    let id: String
    let url: String
    let breeds: [Breed]
}

struct Breed: Codable {
    let id: String
    let name: String
    let temperament: String
    let origin: String
    let life_span: String
}
