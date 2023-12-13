//
//  Stack.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 27/11/2023.
//

struct Stack<Element> {
    
    // MARK: - Properties
    
    private lazy var stackStorage: [Element] = {
        var baseStack: [Element] = .init()
        baseStack.reserveCapacity(8)
        return baseStack
    }()
    
}


// MARK: - Operations

extension Stack {

    mutating func isEmpty() -> Bool {
        return self.peek() == nil
    }
    
    mutating func push(_ element: Element) {
        stackStorage.append(element)
    }
    
    @discardableResult
    mutating func pop() -> Element? {
        return stackStorage.popLast()
    }
    
    mutating func peek() -> Element? {
        return stackStorage.last
    }


}
