//
// Created by Serhii Horielov on 29.11.2019.
// Copyright (c) 2019 Alty. All rights reserved.
//

import Alamofire

public protocol ConnectivityStatusListener: class {
    func statusChanged(_ isReachable: Bool)
}

public class ConnectivityService {
    
	private let manager: NetworkReachabilityManager
	
    public weak var listener: ConnectivityStatusListener?

	public init(hostName: String) {
        manager = NetworkReachabilityManager(host: hostName)!
	}

	public func startListening() {
		manager.listener = { status in
			let isReachable = (status != .unknown) && (status != .notReachable)
			self.listener?.statusChanged(isReachable)
		}

		manager.startListening()
	}

	public func stopListening() {
		manager.stopListening()
	}
}
