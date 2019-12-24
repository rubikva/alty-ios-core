//
//  CentrifugeBuilder.swift
//  CBHCards
//
//  Created by Deszip on 12.11.2019.
//  Copyright © 2019 Alty. All rights reserved.
//

import SwiftCentrifuge

class CentrifugeBuilder {    
    func buildClient(endpoint: URL, token: String) -> CentrifugeClient {
        let config = CentrifugeClientConfig()
        let client = CentrifugeClient(url: endpoint.absoluteString, config: config)
        client.setToken(token)
        
        return client
    }
}
