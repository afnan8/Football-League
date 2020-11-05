//
//  ActivityIndicator.swift
//  FootballLeague
//
//  Created by Afnan on 11/3/20.
//

import UIKit
import SnapKit

class ActivityIndicator {
    
    
    static let instance = ActivityIndicator()
    
    private init() {
        
    }
    
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func show(_ view: UIView) {
        container.frame = view.frame
        container.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        container.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ActivityIndicator.instance.container)
        container.snp.makeConstraints() {
            make in
            make.center.equalTo(view.snp.center)
            make.width.equalTo(view.snp.width)
            make.height.equalTo(view.snp.height)
        }
        
        
        loadingView.frame = CGRect(x:0, y:0, width:80, height:80)
        loadingView.backgroundColor = UIColor.clear
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        container.addSubview(ActivityIndicator.instance.loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        
        loadingView.snp.makeConstraints() {
            make in
            make.center.equalTo(ActivityIndicator.instance.container.snp.center)
            make.width.height.equalTo(80)
        }
        
        activityIndicator.frame = CGRect(x:0.0, y:0.0, width:40.0, height:40.0);
        if #available(iOS 13.0, *) {
            activityIndicator.style = UIActivityIndicatorView.Style.large
        } else {
            activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        }
        activityIndicator.center = CGPoint(x:ActivityIndicator.instance.loadingView.frame.size.width / 2, y:ActivityIndicator.instance.loadingView.frame.size.height / 2);
        
        loadingView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    /*
     *Hide activity indicator
     *remove activity indicator from its super view
     */
    
    func hide() {
        activityIndicator.stopAnimating()
        container.removeFromSuperview()
    }
}
