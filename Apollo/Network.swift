//
//  Network.swift
//  MyApolloTest
//
//  Created by Vina Melody on 14/6/21.
//

import Foundation
import Apollo
import ApolloWebSocket

class NetworkManager {
    static let shared = NetworkManager()
    let httpsEndpoint = "https://iosconfsg.herokuapp.com/v1/graphql"
    let wsEndpoint = "ws://iosconfsg.herokuapp.com/v1/graphql"
    private(set) var client: ApolloClient?
    
    private init() {
        setApolloClient()
    }
    
    func setApolloClient() {
        self.client = {
            guard let wsEndpoint = URL(string: wsEndpoint) else { return nil }
            
            guard let httpsEndpoint = URL(string: httpsEndpoint) else { return nil }
            
            let request = URLRequest(url: wsEndpoint)
            let websocket = WebSocketTransport(request: request)
            
            let store = ApolloStore(cache: InMemoryNormalizedCache())
            let provider = LegacyInterceptorProvider(store: store)
            let httpNetworkTransport = RequestChainNetworkTransport(interceptorProvider: provider, endpointURL: httpsEndpoint)
            let splitNetworkTransport = SplitNetworkTransport(uploadingNetworkTransport: httpNetworkTransport, webSocketNetworkTransport: websocket)
            
            return ApolloClient(networkTransport: splitNetworkTransport, store: store)
        }()
    }
}
