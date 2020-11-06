//
//  URLOpen.swift
//  FootballLeague
//
//  Created by Afnan on 11/5/20.
//

import UIKit

class URLOpen {
    
    static let instance = URLOpen()
    
    private init() {}
    
    func open(_ url: String) {
        guard let url = URL(string: url) else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
}
