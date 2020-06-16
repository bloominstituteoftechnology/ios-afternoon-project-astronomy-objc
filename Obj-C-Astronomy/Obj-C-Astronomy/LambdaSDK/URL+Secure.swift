//
//  URL+Secure.swift
//  Astronomy
//
//  Created by Andrew R Madsen on 9/5/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

extension URL {
    static func getSecureURL(forURL: URL) -> URL? {
        guard var components = URLComponents(url: forURL, resolvingAgainstBaseURL: true) else { return nil }
        components.scheme = "https"
        return components.url
    }
}
