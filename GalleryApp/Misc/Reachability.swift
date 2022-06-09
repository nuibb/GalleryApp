//
//  Reachability.swift
//  GalleryApp
//
//  Created by ReliSource Technologies Ltd. on 6/8/22.
//

import Foundation
import Network

class NetworkReachability {
    
    static let shared = NetworkReachability()
    
    var pathMonitor: NWPathMonitor!
    var path: NWPath?
    lazy var pathUpdateHandler: ((NWPath) -> Void) = { path in
        self.path = path
        if path.status == NWPath.Status.satisfied {
            print("Connected")
        } else if path.status == NWPath.Status.unsatisfied {
            print("Network connection unsatisfied")
        } else if path.status == NWPath.Status.requiresConnection {
            print("Requires Connection")
        }
    }
    
    let backgroudQueue = DispatchQueue.global(qos: .background)
    
    init() {
        pathMonitor = NWPathMonitor()
        pathMonitor.pathUpdateHandler = self.pathUpdateHandler
        pathMonitor.start(queue: backgroudQueue)
    }
    
    func isNetworkAvailable() -> Bool {
        if let path = self.path {
            if path.status == NWPath.Status.satisfied {
                return true
            }
        }
        return false
    }
}
