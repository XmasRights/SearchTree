//
//  SearchTreeKit.swift
//  SearchTreeKit
//
//  Created by Christopher Fonseka on 02/01/2017.
//  Copyright © 2017 ChristopherFonseka. All rights reserved.
//

import Foundation

public class SearchTreeKit
{
    public static func breadthFirstSearch<T: Equatable> (start: SearchNode<T>, actions: [(SearchNode<T>)->SearchNode<T>?], end isEnd: (SearchNode<T>) -> Bool) -> SearchNode<T>?
    {
        var visted: Set  <SearchNode<T>> = [start]
        var queue:  Array<SearchNode<T>> = [start]

        repeat
        {
            let node = queue.remove(at: 0)

            if isEnd(node)
            {
                return node
            }
            else
            {
                let nextNodes = apply(actions: actions, toNode: node)

                for next in nextNodes
                {
                    if (!visted.contains(next))
                    {
                        visted.insert(next)
                        queue.append(next)
                    }
                }
            }
        } while (queue.count > 0)
        return nil
    }

    public static func depthFirstSearch<T: Equatable> (start: SearchNode<T>, actions: [(SearchNode<T>)->SearchNode<T>?], end isEnd: (SearchNode<T>) -> Bool) -> SearchNode<T>?
    {
        let nextNodes = apply(actions: actions, toNode: start)

        for next in nextNodes
        {
            if isEnd (next)
            {
                return next
            }
            else
            {
                if let result = depthFirstSearch(start: next, actions: actions, end: isEnd) { return result }
            }
        }
        return nil
    }

    private static func apply<T: Equatable> (actions: [(SearchNode<T>)->SearchNode<T>?], toNode node: SearchNode<T>) -> [SearchNode<T>]
    {
        var output = [SearchNode<T>]()

        for action in actions
        {
            if let result = action(node)
            {
                output.append(result)
            }
        }
        return output
    }
}
