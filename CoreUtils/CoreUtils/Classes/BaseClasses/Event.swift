//
//  Event.swift
//  CoreAchievements
//
//  Created by Artyom Shaiter on 6/28/20.
//

import Foundation

public class Event<Observable> {
    private struct ObserverContainer {
        weak var observer: AnyObject?
        let callback: (Observable) -> Void
    }
    private var containers: [ObserverContainer] = []

    public var isEmptyObservers: Bool {
        return containers.isEmpty
    }

    public init() {
        // Does nothing
    }
    
    public func observe(_ observer: AnyObject, _ callback: @escaping (Observable) -> Void) {
        containers.append(ObserverContainer(observer: observer, callback: callback))
    }

    public func remove(observer: AnyObject) {
        containers.removeAll { $0.observer === observer || $0.observer == nil }
    }

    public func removeAll() {
        containers.removeAll()
    }

    public func cleanup() {
        containers.removeAll { $0.observer == nil }
    }

    public func notify(_ observable: Observable) {
        var numberOfInvalidContainers = 0
        for container in containers {
            if container.observer != nil {
                container.callback(observable)
            } else {
                numberOfInvalidContainers += 1
            }
        }

        if numberOfInvalidContainers > containers.count / 2 {
            cleanup()
        }
    }
}

public class ContentEvent<Type>: Event<Type> {
    private(set) public var content: Type
    public init(content: Type) {
        self.content = content
    }

    override public func observe(_ observer: AnyObject, _ callback: @escaping (Type) -> Void) {
        super.observe(observer, callback)

        callback(content)
    }
    
    override public func notify(_ observable: Type) {
        self.content = observable
        
        super.notify(observable)
    }
}
