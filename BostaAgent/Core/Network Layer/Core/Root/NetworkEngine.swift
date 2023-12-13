//
//  NetworkEngine.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 04/12/2023.
//

import RxSwift

protocol NetworkEngineService {
    /// Execute Http Request In a serial queue
    /// - Parameter networkMessage: the required message
    /// - Returns: Single In Main thread
    func get<T: Codable>(from networkMessage: HttpNetworkMessage) -> Single<T>

}

struct NetworkEngine: AgentFoundation, NetworkEngineService {
    
    // MARK: - Properties
    
    private let httpEngine: HttpEngine
    
    private let jsonEngine: JsonEngine
    
    // MARK: - Initialization
    
    init(httpEngine: HttpEngine = URLSessionHttpEngine.init(), jsonEngine: JsonEngine = JsonDecoderEngine.init()) {
        self.httpEngine = httpEngine
        self.jsonEngine = jsonEngine
    }
    
}

// MARK: - Operations

extension NetworkEngine {
    
    func get<T: Codable>(from networkMessage: HttpNetworkMessage) -> Single<T> {

        return self.httpEngine.executeRequest(networkMessage)
            .observe(on: SerialDispatchQueueScheduler.init(qos: .userInitiated))
            .map({ networkData in
                
                Self.logger.log(event: .network, from: Self.self, data: "Data received from network, Size in B: \(networkData.count)")

                let jsonParse = try jsonEngine.parse(
                    from: networkData, as: T.self
                )
                return jsonParse
                
            })
            .do(onError: { networkError in
                Self.logger.log(event: .network, from: Self.self, data: "A Network error pop up, description: \(networkError.localizedDescription)")

            })
            .observe(on: MainScheduler.instance)
        
    }

}
