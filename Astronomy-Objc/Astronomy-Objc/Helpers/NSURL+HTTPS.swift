//
//  NSURL+HTTPS.swift
//  Astronomy-Objc
//
//  Created by Michael on 3/23/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import Foundation

extension URL {
    var usingHTTPS: URL? {
        guard var components = URLComponents(url: self as URL, resolvingAgainstBaseURL: true) else { return nil }
        components.scheme = "https"
        return components.url
    }
}
