//
//  TrackerProtocols.swift
//  FernwayerUtils
//
//  Created by Artyom Shaiter on 7/6/20.
//

public protocol ErrorsTrackerProtocol: class {
    func track(error: Error)
}

public extension ErrorsTrackerProtocol {
    var trackClosure: (Error) -> Void {
        return { [weak self] error in
            self?.track(error: error)
        }
    }
}
