//
//  AnyError.swift
//  FernwayerUtils
//
//  Created by Artyom Shaiter on 7/6/20.
//

open class AnyError: Error {
    public let underlying: Error?
    public let message: String?
    public let method: String

    public init(underlying: Error? = nil, message: String? = nil, method: String = #function) {
        self.underlying = underlying
        self.message = message
        self.method = method
    }
    
    public func selfOrUnderlying<ErrorType: AnyError>(of kind: ErrorType.Type) -> ErrorType? {
        if let error = self as? ErrorType {
            return error
        }
        if let underlying = underlying as? AnyError {
            return underlying.selfOrUnderlying(of: ErrorType.self)
        }
        return nil
    }

    public func underlyingErrors<ErrorType: AnyError>(of kind: ErrorType.Type) -> [ErrorType] {
        var anyError: AnyError? = self
        var foundErrors: [ErrorType] = []

        while anyError != nil {
            if let error = anyError as? ErrorType {
                foundErrors.append(error)
            }
            anyError = anyError?.underlying as? AnyError
        }

        return foundErrors
    }
    
    open var codeString: String {
        if let validUnderlying = underlying {
            return String(describing: validUnderlying)
        } else {
            return ""
        }
    }
    
    open var codeStringShort: String {
        return domainCode
    }

    open var firstMessage: String? {
        return message ?? (underlying as? AnyError)?.message ?? localizedDescription
    }
    
    /// Short 2-3 letters error code
    open var domainCode: String {
        let typeCode = Array(String(describing: type(of: self))).filter { ("A"..."Z").contains($0) }
        return String(typeCode)
    }
    
    public var recursiveCode: String {
        var code = ""
        var error: Error? = self
        while let validError = error {
            if let anyError = validError as? AnyError {
                code += (code.isEmpty ? "" : " | ") + anyError.codeString
                error = anyError.underlying
            } else {
                error = nil
            }
        }
        return code
    }
    
    public var recursiveCodeShort: String {
        var code = ""
        var error: Error? = self
        while let anyError = error as? AnyError {
            if !anyError.codeStringShort.isEmpty {
                code += (code.isEmpty ? "" : "-") + anyError.codeStringShort
            }
            error = anyError.underlying
        }
        return code
    }

    public var recursiveMethods: String {
        var methods = ""
        var error: Error? = self
        while let anyError = error as? AnyError {
            methods += (methods.isEmpty ? "" : " > ") + anyError.method
            error = anyError.underlying
        }
        return methods
    }
    
    open var fullStringInfo: String {
        var info = "\(self.codeString) - \(method)"
        if let message = message {
            info += " - \(message)"
        }
        return info
    }
    
    public var fullRecursiveInfo: String {
        var info = ""
        var error: Error? = self
        while let validError = error {
            info += info.isEmpty ? "" : "\n"

            if let anyError = validError as? AnyError {
                info += anyError.fullStringInfo
                error = anyError.underlying
            } else {
                info += "\(String(describing: validError)) - \(validError.localizedDescription)"
                error = nil
            }
        }
        return info
    }

    public var fullRecursiveLocalizedDescription: String {
        var info = ""
        var error: Error? = self
        while let validError = error {
            info += info.isEmpty ? "" : "\n"

            if let anyError = validError as? AnyError {
                error = anyError.underlying
            } else {
                info += validError.localizedDescription
                error = nil
            }
        }
        return info
    }

    public var localizedDescription: String {
        return fullRecursiveLocalizedDescription
    }
}

public typealias AnyErrorClosure = (AnyError) -> Void
