//
//  BaseError.swift
//  FernwayerUtils
//
//  Created by Artyom Shaiter on 7/6/20.
//

public protocol BaseErrorCode: RawRepresentable where RawValue == Int {
}

open class BaseError<Code: BaseErrorCode>: AnyError {
    public let code: Code
    
    public required init(code: Code, underlying: Error? = nil, message: String? = nil, method: String = #function) {
        self.code = code
        
        super.init(underlying: underlying, message: message, method: method)
    }
    
    open override var codeString: String {
        return String(describing: type(of: self)) + "." + String(describing: code)
    }
    
    open override var codeStringShort: String {
        return super.codeStringShort + "\(code.rawValue)"
    }
}
