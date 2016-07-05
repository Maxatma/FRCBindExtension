//
//  TTRangeSLider.swift
//  RKTests
//
//  Created by Alexander Zaporozhchenko on 7/4/16.
//  Copyright © 2016 Alexander Zaporozhchenko. All rights reserved.
//

import Foundation
import UIKit
import TTRangeSlider
import ReactiveKit

extension TTRangeSlider {
    public var zBackgroundColor : Property<UIColor?> {
        return rAssociatedPropertyForValueForKey("backgroundColor")
    }
}