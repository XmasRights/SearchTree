//
//  SearchNode.swift
//  SearchTreeKit
//
//  Created by Christopher Fonseka on 02/01/2017.
//  Copyright © 2017 ChristopherFonseka. All rights reserved.
//

import Foundation

public struct SearchNode<T: Equatable>
{
    public let value: T
    public let log:   String;

    public init(_ value: T)
    {
        self.value = value;
        self.log   = String()
    }

    public init(_ value: T, log: String)
    {
        self.value = value
        self.log   = log
    }
}

extension SearchNode: Equatable
{
    public static func ==<T>(lhs: SearchNode<T>, rhs: SearchNode<T>) -> Bool
    {
        return lhs.value == rhs.value
    }
}

extension SearchNode: Hashable
{
    public var hashValue: Int
        {
        get {
            return "\(value):\(log)".hashValue
        }
    }
}
