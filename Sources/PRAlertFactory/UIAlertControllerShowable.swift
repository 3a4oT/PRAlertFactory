//
//  UIAlertControllerShowable.swift
//  
//
//  Created by Petro Rovenskyy on 14.02.2020.
//

import UIKit
import ObjectiveC.runtime

public protocol UIAlertControllerShowable {
    func show()
    func show(animated: Bool, completion: (() -> Void)?)
}

@objc extension UIAlertController: UIAlertControllerShowable {
    // MARK: - Method Swizzling
    private static var alertWindowAssociatedKey = "alertWindowAssociatedKey"
    private var alertWindow: UIWindow? {
        get {
            return objc_getAssociatedObject(self, &Self.alertWindowAssociatedKey) as? UIWindow
        }
        set {
            objc_setAssociatedObject(self,
                                     &Self.alertWindowAssociatedKey,
                                     newValue,
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    /// You should call this method on your AppDelegate
    open class func initShow() {
        guard self === UIAlertController.self else { return }
        let original: Selector = #selector(self.viewDidDisappear(_:))
        let swizzled: Selector = #selector(self.swizzleViewDidDisappear(animated:))
        guard let originalM: Method = class_getInstanceMethod(self, original),
            let swizzledM: Method = class_getInstanceMethod(self, swizzled) else {
                return
        }
        method_exchangeImplementations(originalM, swizzledM)
    }
    private func swizzleViewDidDisappear(animated: Bool) {
        // call original method first
        self.swizzleViewDidDisappear(animated: animated)
        self.alertWindow?.isHidden = true
        self.alertWindow = nil
    }
    // MARK: - Public API
    public func show(animated: Bool, completion: (() -> Void)? = nil) {
        self.alertWindow = UIWindow(frame: UIScreen.main.bounds)
        self.alertWindow?.rootViewController = UIViewController()
        let delegate: UIApplicationDelegate? = UIApplication.shared.delegate
        if delegate?.window != nil {
            self.alertWindow?.tintColor = delegate?.window!?.tintColor
        }
        let topWindow: UIWindow? = UIApplication.shared.windows.last
        self.alertWindow?.windowLevel = (topWindow?.windowLevel)! + 1
        self.alertWindow?.makeKeyAndVisible()
        self.alertWindow?.rootViewController?.present(self,
                                                      animated: animated,
                                                      completion: completion)
    }
    public func show() {
        self.show(animated: true)
    }
}
