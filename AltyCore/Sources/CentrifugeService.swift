//
//  CentrifugeService.swift
//  CBHCards
//
//  Created by Deszip on 12.11.2019.
//  Copyright © 2019 Alty. All rights reserved.
//

import SwiftCentrifuge

public struct APIBackConnectionRequest {
    let endpoint: URL
    let token: String
    let channel: String
    
    public init(endpoint: URL, token: String, channel: String) {
        self.endpoint = endpoint
        self.token = token
        self.channel = channel
    }
}

public protocol APIBackChannel {
    var dataCallback: ((Data?) -> Void)? { get set }
    func connect(_ request: APIBackConnectionRequest)
    func disconnect()
}

public class CentrifugeService: APIBackChannel {
    
    private var clientBuilder: CentrifugeBuilder
    private var client: CentrifugeClient?
    private var channelSubscription: CentrifugeSubscription?
    
    public var dataCallback: ((Data?) -> Void)?
    
    public init(clientBuilder: CentrifugeBuilder) {
        self.clientBuilder = clientBuilder
    }
    
    public func connect(_ request: APIBackConnectionRequest) {
//        Logger.log(Logger.centrifuge, "Connecting: %@ : %@", request.token, request.channel)
        print("Centrifuge connecting: %@ : %@", request.token, request.channel)
        
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
    
    public func disconnect() {
        client.flatMap { $0.disconnect() }
    }
    
}

extension CentrifugeService: CentrifugeClientDelegate {
    public func onConnect(_ c: CentrifugeClient, _ e: CentrifugeConnectEvent) {
        //Logger.log(Logger.centrifuge, "Connected")
        print("Centrifuge connected")
    }
    
    public func onDisconnect(_ c: CentrifugeClient, _ e: CentrifugeDisconnectEvent) {
        //Logger.log(Logger.centrifuge, "Disconnected")
        print("Centrifuge disconnected")
    }
}

extension CentrifugeService: CentrifugeSubscriptionDelegate {
    
    public func onSubscribeError(_ s: CentrifugeSubscription, _ e: CentrifugeSubscribeErrorEvent) {
        //Logger.log(Logger.centrifuge, "Subscription failed: %s: %d", e.message, e.code)
        print("Centrifuge subscription failed: %s: %d", e.message, e.code)
    }
    
    public func onPublish(_ s: CentrifugeSubscription, _ e: CentrifugePublishEvent) {
        //Logger.log(Logger.centrifuge, "Got data: %@", e.data.debugDescription)
        print("Centrifuge got data: %@", e.data.debugDescription)
        dataCallback?(e.data)
    }
    
}
