//
//  UIView+Extension.swift
//  FootballLeague
//
//  Created by Afnan on 11/5/20.
//

import UIKit

extension UIView {
    
    enum LINE_POSITION {
        case bottom
    }
    
    func addLineToView(position : LINE_POSITION, color: UIColor) {
        let lineView: UIView = {
            let view = UIView()
            view.tag = 222
            view.backgroundColor = color
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        self.addSubview(lineView)
        
        switch position {
        case .bottom:
            lineView.snp.makeConstraints() {
                make in
                make.width.equalTo(self.snp.width)
                make.height.equalTo(1)
                make.centerX.equalTo(self.snp.centerX)
                make.bottom.equalTo(self.snp.bottom)
            }
            break
        }
    }
    
    func removeLineView() {
        _ = self.subviews.map {
            if $0.tag == 222 {
                $0.removeFromSuperview()
            }
        }
    }
    
}
