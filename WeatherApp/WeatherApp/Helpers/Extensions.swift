//
//  Extensions.swift
//  WeatherApp
//
//  Created by Arun Amuri on 24/05/2020.
//  Copyright © 2020 Arun Amuri. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    static var viewIdentifier: String { return "\(self)" }
    
    private class func instantiate<T: UIViewController>(with storyboardID: String, identifier: String? = nil, type: T.Type) -> T? {
        let storybaord = UIStoryboard(name: storyboardID, bundle: .main)
        guard let name = identifier ?? type.description().components(separatedBy: ".").last else {
            return nil
        }
        return storybaord.instantiateViewController(withIdentifier: name) as? T
    }
    
    class func instantiate(with storyboardID: String, identifier: String? = nil) -> Self? {
        return instantiate(with: storyboardID, identifier: identifier, type: self)
    }
}

extension UITableViewCell {
    static var reusableIdentifier: String { return "\(self)" }
}
