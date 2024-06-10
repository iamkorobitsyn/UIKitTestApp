//
//  UIView+Extensions.swift
//  UIKitTestApp
//
//  Created by Александр Коробицын on 10.06.2024.
//

import Foundation
import UIKit

extension UIView {
    var disableAutoresizing: Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}
