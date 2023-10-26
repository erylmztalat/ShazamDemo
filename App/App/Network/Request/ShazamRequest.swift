//
//  ShazamRequest.swift
//  App
//
//  Created by talate on 17.10.2023.
//

import Foundation
import NetworkService

struct ShazamRequest: NetworkRequest {
    
    typealias Response = ShazamResponse
    
    var endpoint: URL? = Endpoint.shazam.url
    
    var method: RequestMethod = .post
    
    var headers: [String : String]? = Configuration.shared.defaultHeaders()
    
    var parameters: [String : Any]?
    
    var rawBody: Data?
}
