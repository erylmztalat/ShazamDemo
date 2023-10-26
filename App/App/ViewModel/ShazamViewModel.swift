//
//  ShazamViewModel.swift
//  App
//
//  Created by talate on 19.10.2023.
//

import Foundation
import NetworkService
import Combine

class ShazamViewModel {
    
    var shazamResponseData: ShazamResponse?
    
    var cancellables: Set<AnyCancellable> = []
    
    var networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetch(base64AudioData:String, completion: @escaping (Result<ShazamResponse, Error>) -> Void) {
        var shazamRequest = ShazamRequest()
        shazamRequest.rawBody = base64AudioData.data(using: .utf8)
        networkService.perform(shazamRequest)
            .sink(
                receiveCompletion: { completionResult in
                    print("Completion Result \(completionResult)")
                    switch completionResult {
                    case .failure(let error):
                        completion(.failure(error))
                    case .finished:
                        break
                    }
                }, receiveValue: { [weak self] (response: ShazamResponse) in
                    self?.shazamResponseData = response 
                    completion(.success(response))
                }
            )
            .store(in: &cancellables)
    }
}
