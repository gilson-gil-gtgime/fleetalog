//
//  CompletionType.swift
//  Fleetalog
//
//  Created by Gilson Gil on 05/10/17.
//  Copyright © 2017 Gilson Gil. All rights reserved.
//

import Foundation

typealias CompletionHandlerType<T> = (() throws -> T) -> Void
