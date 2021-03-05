//
//  URL + Secure.swift
//  Astronomy - ObjC
//
//  Created by James McDougall on 3/5/21.
//

import Foundation

import Foundation

extension URL {
    
    var usingHTTPS: URL? {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: true) else { return nil }
        components.scheme = "https"
        return components.url
    }
    
}
