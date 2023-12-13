//
//  URLSessionHttpEngine.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 04/12/2023.
//

import RxSwift
import Foundation

struct URLSessionHttpEngine: HttpEngine, AgentFoundation {
    
    // MARK: - Properties
    
    let errorHandler: ErrorHandlerEngine
    
    // MARK: - Initialization

    init(errorHandler: ErrorHandlerEngine = URLSessionErrorHandlerEngine.init()) {
        self.errorHandler = errorHandler
    }
    
}

// MARK: - Operations

extension URLSessionHttpEngine {
    
    func executeRequest(_ networkMessage: HttpNetworkMessage) -> Single<Data> {
        
        return Single<Data>.create { single in
            do {
                let urlRequest = try self.createURLRequest(networkMessage)
                
                Self.logger.log(event: .network, from: Self.self, printIn: .debug, data: "\(networkMessage.endpoint.scheme.rawValue) \(networkMessage.endpoint.requestMethod.rawValue) request started, direction: \(networkMessage.endpoint.host.rawValue)\(networkMessage.endpoint.path.rawValue)")

                let urlSessionTask = URLSession.init(configuration: .default).dataTask(with: urlRequest) { networkData, networkResponse, networkError in
                    
                    do {
                        
                        let networkBuffer = try errorHandler
                        .parseNetworkRequest(
                                networkError: networkError,
                                networkResponse: networkResponse,
                                networkData: networkData
                        )
                        single(.success(networkBuffer))

                    } catch {
                        single(.failure(error))
                    }
                    
                }
                
                urlSessionTask.resume()
                return Disposables.create {
                    urlSessionTask.cancel()
                }
                
            } catch {
                single(.failure(error))
            }
            return Disposables.create()
        }
        .observe(on: SerialDispatchQueueScheduler.init(qos: .userInitiated))
    }

    
}
