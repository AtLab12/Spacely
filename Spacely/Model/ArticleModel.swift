//
//  ArticleModel.swift
//  Spacely
//
//  Created by Mikolaj Zawada on 17/10/2021.
//

import Foundation
import SwiftUI
import Kingfisher
import AVFoundation

struct ArticleModel: Hashable {
    let id: Int
    let title: String
    let sourceURL: String
    let imageURL: String
    let newsSite: String
    let summary: String
}
