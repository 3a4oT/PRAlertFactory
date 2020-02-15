//
//  PRAlertFactory.swift
//
//  Created by Petro Rovenskyy on 14.02.2020.
//

import UIKit

@objc public final class PRAlertFactory: NSObject {
    @objc public class func infoAlert(title: String,
                                      msg: String,
                                      handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title,
                                      message: msg,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: "OK"),
                                     style: .default,
                                     handler: handler)
        alert.addAction(okAction)
        return alert
    }
    @objc public class func alert(error: Error) -> UIAlertController {
        return infoAlert(title: NSLocalizedString("Error", comment: "Error"),
                         msg: error.localizedDescription)
    }
    @objc public class func alert(title: String, error: Error) -> UIAlertController {
        return infoAlert(title: title,
                         msg: error.localizedDescription)
    }
}
