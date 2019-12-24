//
//  CentrifugeService.swift
//  CBHCards
//
//  Created by Deszip on 12.11.2019.
//  Copyright © 2019 Alty. All rights reserved.
//

import SwiftCentrifuge

struct APIBackConnectionRequest {
    let endpoint: URL
    let token: String
    let channel: String
}

protocol APIBackChannel {
    var dataCallback: ((Data?) -> Void)? { get set }
    func connect(_ request: APIBackConnectionRequest)
    func disconnect()
}

class CentrifugeService: APIBackChannel {
    
    private var clientBuilder: CentrifugeBuilder
    private var client: CentrifugeClient?
    private var channelSubscription: CentrifugeSubscription?
    
    var dataCallback: ((Data?) -> Void)?
    
    init(clientBuilder: CentrifugeBuilder) {
        self.clientBuilder = clientBuilder
    }
    
    func connect(_ request: APIBackConnectionRequest) {
        Logger.log(Logger.centrifuge, "Connecting: %@ : %@", request.token, request.channel)
        
        disconnect()
        client = clientBuilder.buildClient(endpoint: request.endpoint, token: request.token)
        client?.delegate = self
        client?.connect()
        
        do {
            let sub = try self.client?.newSubscription(channel: request.channel, delegate: self)
            sub?.subscribe()
        } catch {
            return
        }
    }
    
    func disconnect() {
        client.flatMap { $0.disconnect() }
    }
    
}

extension CentrifugeService: CentrifugeClientDelegate {
    func onConnect(_ c: CentrifugeClient, _ e: CentrifugeConnectEvent) {
        Logger.log(Logger.centrifuge, "Connected")
    }
    
    func onDisconnect(_ c: CentrifugeClient, _ e: CentrifugeDisconnectEvent) {
        Logger.log(Logger.centrifuge, "Disconnected")
    }
}

extension CentrifugeService: CentrifugeSubscriptionDelegate {
    
    func onSubscribeError(_ s: CentrifugeSubscription, _ e: CentrifugeSubscribeErrorEvent) {
        Logger.log(Logger.centrifuge, "Subscription failed: %s: %d", e.message, e.code)
    }
    
    func onPublish(_ s: CentrifugeSubscription, _ e: CentrifugePublishEvent) {
        Logger.log(Logger.centrifuge, "Got data: %@", e.data.debugDescription)
        dataCallback?(e.data)
    }
    
}
