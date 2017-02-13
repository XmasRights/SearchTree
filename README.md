# SearchTreeKit
A simple Swift algorithm that can finds the steps necessary to a desired outcome given a start condition and an array of valid actions.

## SearchNode
A `SearchNode` is a `struct` that contains a `Generic` value which will be the start and end point of your search. It also contains a log (`String`) which your action functions can use to log the path the node has taken.

``` Swift
let startNode = SearchNode<Int>(4)
let startNode = SearchNode<String>("Start")

typealias WaterJug = SearchNode<Int>
let startNode = WaterJug(0)
```

## Actions
There isn't an explicit type in `SearchTreeKit`, but is an input argument to the main functions that start the search. They take the form `(SearchNode)->SearchNode?`. The `Optional` output is to ensure that actions can terminate if it is not valid for a particular start node. For example, trying to fill a water jug that is already full can lead to no output rather than a potential infinite loop.

It is also up to the action functions specified to append to the `SearchNode`'s log. By doing this, the final `SearchNode`  will contain a log of each step that was taken to get to the end.

## End Conditions
Like actions, the end condition is not an explicit type. The end of particular search is defined as `(SearchNode)->Result` where result is:
``` Swift
enum Result { case Pass, Fail, Continue }
```

Here you can define whether a given input node is the the desired output (`.Pass`), is worth continuing to search (`.Continue`), or is invalid or out of bounds (`.Fail`).

# Example
Let's say we have a bizarrely broken calculator that can only do two things:
1. Add 3
2. Multiply by 2

If we were to go about finding out how to get any number, starting from zero, we could do this:
```Swift
struct BrokenCalculator
{
    typealias Value = SearchNode<Int>

    let start = Value(0)

    private func actions() -> [(Value) -> Value?]
    {
        let addThree = { (v: Value) -> Value in

            let value = v.value + 3
            let log   = v.log.appending("Add 3, to get \(value)\n")

            return Value(value, log: log)
        }

        let multiplyTwo = { (v: Value) -> Value in

            let value = v.value * 2
            let log   = v.log.appending("Multiply by 2, to get \(value)\n")

            return Value(value, log: log)
        }

        return [addThree, multiplyTwo]
    }

    private func end(_ desiredResult: Int) -> (Value) -> SearchTreeKit.Result
    {
        return { (v: Value) in

            switch (v.value)
            {
            case _ where v.value == desiredResult: return .Pass
            case _ where v.value >  desiredResult: return .Fail
            default:                               return .Continue
            }
        }
    }
}
```

Running the program is then as simple as:
```Swift
let result = SearchTreeKit.breadthFirstSearch(start: start, actions: actions(), end: end(42))
```

The result is an optional `SearchNode` which will contain the answer and the result. In this case:
```
Add 3, to get 3
Add 3, to get 6
Add 3, to get 9
Multiply by 2, to get 18
Add 3, to get 21
Multiply by 2, to get 42
```
