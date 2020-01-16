//
//  CentrifugeBuilder.swift
//  CBHCards
//
//  Created by Deszip on 12.11.2019.
//  Copyright © 2019 Alty. All rights reserved.
//

import AltySwiftCentrifuge

public class CentrifugeBuilder {
    
    public func buildClient(endpoint: URL, token: String, clientSSLCert: ClientSSLCertInfo? = nil) -> CentrifugeClient {
        var config = CentrifugeClientConfig()
        clientSSLCert.flatMap {
            config.clientSSLCertificate = CentrifugePKCS12SSLCertInfo(URL: $0.url, password: $0.password)
        }
        let client = CentrifugeClient(url: endpoint.absoluteString, config: config)
        client.setToken(token)
        
        return client
    }
    
    public init() {}
}
