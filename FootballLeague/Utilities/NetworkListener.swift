//
//  NetworkListener.swift
//  FootballLeague
//
//  Created by Afnan on 11/6/20.
//

import Reachability

protocol NetworkStatusDelegate: AnyObject {
    func isNetworkConnected(_ isConnected: Bool)
}

class NetworkListener {
    
    static let instance = NetworkListener()
    
    private let reachability = try? Reachability()
    
    weak var delegate: NetworkStatusDelegate!
    
    private init() {
        
    }
    
    func observeReachability(){
        NotificationCenter.default.addObserver(self, selector:#selector(self.reachabilityChanged), name: NSNotification.Name.reachabilityChanged, object: nil)
        do {
            if let _ = self.reachability {
                try self.reachability?.startNotifier()
            }
        }
        catch(let error) {
            print("Error occured while starting reachability notifications : \(error.localizedDescription)")
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        switch reachability.connection {
        case .cellular:
            if let _ = delegate {
                delegate.isNetworkConnected(true)
            }
            break
        case .wifi:
            if let _ = delegate {
                delegate.isNetworkConnected(true)
            }
            break
        case .none:
            if let _ = delegate {
                delegate.isNetworkConnected(false)
            }
            break
        case .unavailable:
            if let _ = delegate {
                delegate.isNetworkConnected(false)
            }
            break
        }
    }
}
