//
//  ConversionError.swift
//  FernwayerUtils
//
//  Created by Artyom Shaiter on 7/6/20.
//

public enum ConversionErrorCode: Int, BaseErrorCode {
    case unexpected
    
    case generalCast
    case incorrectParams
}

public final class ConversionError: BaseError<ConversionErrorCode> {
    
}

public typealias ConversionErrorClosure = (ConversionError) -> Void
