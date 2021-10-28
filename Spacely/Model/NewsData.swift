//
//  NewsData.swift
//  Spacely
//
//  Created by Mikolaj Zawada on 17/10/2021.
//

import Foundation

struct NewsData: Decodable {
    let id: Int
    let title: String
    let url: String
    let imageUrl: String
    let newsSite: String
    let summary: String
    let publishedAt: String
}


