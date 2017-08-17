//
//  Loadable.swift
//  GithubIssueTracker
//
//  Created by Eduardo Pinto on 17/08/17.
//  Copyright © 2017 Eduardo Pinto. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa

class LoadingView: UIView {
    convenience init(at superView: UIView) {
        self.init()
        self.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        addSubview(activityIndicator)
        superView.addSubview(self)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(self.snp.center)
        }
        self.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.isHidden = true
        superView.bringSubview(toFront: self)
        activityIndicator.startAnimating()
    }
}

protocol Loadable {
    var loadingView: UIView! {get}
    
    func startLoading()
    func stopLoading()
}

extension Loadable where Self: UIViewController {
    func startLoading() {
        if loadingView.isHidden {
            loadingView.isHidden = false
        }
    }
    
    func stopLoading() {
        if !loadingView.isHidden {
            loadingView.isHidden = true
        }
    }
}
