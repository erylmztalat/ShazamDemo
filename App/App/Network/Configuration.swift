//
//  Configuration.swift
//  App
//
//  Created by talate on 17.10.2023.
//

import Foundation

class Configuration {
    static let shared = Configuration()

    var rapidAPIKey: String {
        // Retrieve this from a secure store or your app's configuration settings
        "90d30b06cdmshfc1bc5ae8705d82p113b7ejsn38de69882a1f"
    }

    var rapidAPIHost: String {
        "shazam.p.rapidapi.com"
    }
    
    func defaultHeaders() -> [String: String] {
        [
            "X-RapidAPI-Key": rapidAPIKey,
            "X-RapidAPI-Host": rapidAPIHost,
            "Content-Type": "text/plain",
            "Accept": "application/json"
        ]
    }
}
