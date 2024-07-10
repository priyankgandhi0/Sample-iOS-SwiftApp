//
//  AILoader.swift
//
//  Created by iMac on 09/07/24.
//


import UIKit
import IHProgressHUD

//MARK: - ShowLoader

public func SHOW_CUSTOM_LOADER() {
    DispatchQueue.main.async {
        IHProgressHUD.show()
        IHProgressHUD.set(font: UIFont.systemFont(ofSize: 16.0))
        IHProgressHUD.set(defaultStyle: .dark)
        IHProgressHUD.set(defaultAnimationType: .native)
    }
}

public func ShowLoaderWithMessage(message:String) {
    DispatchQueue.main.async {
        IHProgressHUD.show(withStatus: message)
        IHProgressHUD.set(font: UIFont.systemFont(ofSize: 16.0))
        IHProgressHUD.set(defaultStyle: .dark)
        IHProgressHUD.set(defaultAnimationType: .native)
    }
}

//MARK: - Hide Loader

public func HIDE_CUSTOM_LOADER() {
    DispatchQueue.main.async {
        IHProgressHUD.dismiss()
    }
}


