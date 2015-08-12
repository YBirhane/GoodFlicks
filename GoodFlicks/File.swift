//
//  File.swift
//  GoodFlicks
//
//  Created by Yeabtsega Birhane on 8/9/15.
//  Copyright (c) 2015 Yeabtsega Birhane. All rights reserved.
//


import Foundation

// Thanks to Janos: http://stackoverflow.com/questions/24938948/array-extension-to-remove-object-by-value
public func removeObject<T : Equatable>(object: T, inout fromArray array: [T])
{
    var index = find(array, object)
    array.removeAtIndex(index!)
}