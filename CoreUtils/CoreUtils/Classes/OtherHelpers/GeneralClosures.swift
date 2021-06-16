//
//  GeneralClosures.swift
//  AppUtils
//
//  Created by Artyom Shaiter on 7/6/20.
//

import UIKit

public typealias VoidClosure = () -> Void
public typealias AnyClosure = (Any) -> Void
public typealias BoolClosure = (Bool) -> Void
public typealias DataClosure = (Data) -> Void
public typealias StringClosure = (String) -> Void
public typealias IntClosure = (Int) -> Void
public typealias DoubleClosure = (Double) -> Void
public typealias ErrorClosure = (Error) -> Void
public typealias UUIDClosure = (UUID) -> Void
public typealias URLClosure = (URL) -> Void
public typealias UIImageClosure = (UIImage) -> Void
public typealias ResultClosure<Res, Err: Error> = (Result<Res, Err>) -> Void
