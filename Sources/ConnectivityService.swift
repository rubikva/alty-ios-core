//
// Created by Serhii Horielov on 29.11.2019.
// Copyright (c) 2019 Alty. All rights reserved.
//

import Alamofire

protocol ConnectivityStatusListener: class {
    func statusChanged(_ isReachable: Bool)
}

class ConnectivityService {
    
	private let manager: NetworkReachabilityManager
	
    weak var listener: ConnectivityStatusListener?

	init(hostName: String) {
        manager = NetworkReachabilityManager(host: hostName)!
	}

	func startListening() {
		manager.listener = { status in
			let isReachable = (status != .unknown) && (status != .notReachable)
			self.listener?.statusChanged(isReachable)
		}

		manager.startListening()
	}

	func stopListening() {
		manager.stopListening()
	}
}
