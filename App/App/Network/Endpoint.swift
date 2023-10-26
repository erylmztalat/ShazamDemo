//
//  Endpoint.swift
//  App
//
//  Created by talate on 17.10.2023.
//

import Foundation

enum Endpoint {
    case shazam
    
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "shazam.p.rapidapi.com"
        switch self {
        case .shazam:
            components.path = "/songs/detect"
        }
        return components.url!
    }
}
