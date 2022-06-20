//
//  Content.swift
//  RomanGushchik_Homework17
//
//  Created by admin on 1.06.22.
//

import Foundation
import UIKit

struct Content {
    var type: ContentType
    var myContent: [URL]
}

enum ContentType: String {
    case folder = "Folders"
    case image = "Images"
}

enum EditState {
    case navigation
    case selection
}
enum KeyValues: String {
    case keyPassword = "SavePassword"
}
