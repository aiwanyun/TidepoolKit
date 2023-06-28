//
//  TError.swift
//  TidepoolKit
//
//  Created by Darin Krauss on 2/17/20.
//  Copyright © 2020 Tidepool Project. All rights reserved.
//

import Foundation

/// All errors reported by TidepoolKit.
public enum TError: Error {

    /// A general network error not covered by another more specific error. May include a more detailed OS-level error.
    case network(Error?)

    /// The session is missing.
    case sessionMissing

    /// The login was canceled.
    case loginCanceled

    /// Missing refresh token
    case refreshTokenMissing

    /// Missing authentication issuer.
    case missingAuthenticationIssuer

    /// Missing authentication configuration.
    case missingAuthenticationConfiguration

    /// Missing authentication code.
    case missingAuthenticationCode

    /// Missing authentication token.
    case missingAuthenticationToken

    /// Missing authentication state.
    case missingAuthenticationState

    /// Missing authentication state.
    case authenticationError(String)

    /// The request was invalid and not sent.
    case requestInvalid

    /// URLComponents are invalid for forming a URL
    case invalidURL(URLComponents)

    /// The server responded that the request was bad or malformed. Equivalent to HTTP status code 400.
    case requestMalformed(HTTPURLResponse, Data?)

    /// The server responded that the request was bad or malformed with details. Equivalent to HTTP status code 400.
    case requestMalformedJSON(HTTPURLResponse, Data, [Detail])

    /// The server responded that the request was not authenticated. Equivalent to HTTP status code 401.
    case requestNotAuthenticated

    /// The server responded that the request was authenticated, but not authorized. Equivalent to HTTP status code 403.
    case requestNotAuthorized(HTTPURLResponse, Data?)

    /// The server responded that the email for the authenticated user is not verified.
    case requestEmailNotVerified(HTTPURLResponse, Data?)

    /// The server responded that the Terms of Service for the authenticated user are not accepted.
    case requestTermsOfServiceNotAccepted(HTTPURLResponse, Data?)

    /// The server responded that the requested resource was not found. Equivalent to HTTP status code 404.
    case requestResourceNotFound(HTTPURLResponse, Data?)

    /// The server response was unexpected (not HTTP).
    case responseUnexpected(URLResponse?, Data?)

    /// The server response included an unexpected HTTP status code, namely anything other than those specified above and 200-299 (success).
    case responseUnexpectedStatusCode(HTTPURLResponse, Data?)

    /// The server response did not include required authentication. Specifically, the X-Tidepool-Session-Token header was missing.
    case responseNotAuthenticated(HTTPURLResponse, Data?)

    /// The server response did not include JSON in the body.
    case responseMissingJSON(HTTPURLResponse)

    /// The server response did not include valid JSON in the body.
    case responseMalformedJSON(HTTPURLResponse, Data, Error)

    /// The server response included valid, but unexpected, JSON in the body.
    case responseUnexpectedJSON(HTTPURLResponse, Data)

    /// The server response included malformed data.
    case responseMalformed(TAPI.MalformedResult)

    /// The api returned a reason for the failure.
    case errorResponse(String)


    public struct Detail: Codable, Equatable {
        public var code: String
        public var title: String
        public var detail: String
        public var status: Int?
        public var source: Source?
        public var meta: TDictionary?

        public struct Source: Codable, Equatable {
            public var parameter: String?
            public var pointer: String?
        }
    }
}

extension TError: LocalizedError {

    public var recoverySuggestion: String? {
        switch self {
        case .sessionMissing:
            return LocalizedString("请登录。", comment: "The recoverySuggestion of the session missing error")
        default:
            return nil
        }
    }

    public var errorDescription: String? {
        switch self {
        case .network:
            return LocalizedString("发生网络错误。", comment: "The default localized description of the network error")
        case .sessionMissing:
            return LocalizedString("会话丢失。", comment: "The default localized description of the session missing error")
        case .loginCanceled:
            return LocalizedString("登录被取消。", comment: "Localized description for TError.loginCanceled")
        case .refreshTokenMissing:
            return LocalizedString("令人振奋的是缺少。", comment: "The default localized description of the refresh token missing error")
        case .missingAuthenticationIssuer:
            return LocalizedString("缺少身份验证发行者。", comment: "The default localized description of the missingAuthenticationIssuer error")
        case .missingAuthenticationConfiguration:
            return LocalizedString("缺少身份验证配置。", comment: "The default localized description of the missingAuthenticationConfiguration error")
        case .missingAuthenticationCode:
            return LocalizedString("缺少身份验证挑战响应代码。", comment: "The default localized description of the missingAuthenticationCode error")
        case .missingAuthenticationToken:
            return LocalizedString("缺少身份验证令牌。", comment: "The default localized description of the missingAuthenticationToken error")
        case .missingAuthenticationState:
            return LocalizedString("缺少身份验证状态。", comment: "The default localized description of the missingAuthenticationState error")
        case .authenticationError(let message):
            return String(format: LocalizedString("Authentication error: %1$@", comment: "The format string for an authentication error with a message. (1: the error message describing why authentication errored"), message)
        case .requestInvalid:
            return LocalizedString("该请求无效。", comment: "The default localized description of the request invalid error")
        case .invalidURL(let components):
            return String(format: LocalizedString("Failure creating request URL: %1$@", comment: "Error description for invalidURL (1: url components)"), String(describing: components))
        case .requestMalformed:
            return LocalizedString("该请求无效。", comment: "The default localized description of the request malformed error")
        case .requestMalformedJSON:
            return LocalizedString("该请求无效。", comment: "The default localized description of the request malformed JSON error")
        case .requestNotAuthenticated:
            return LocalizedString("该请求未经认证。", comment: "The default localized description of the request not authenticated error")
        case .requestNotAuthorized:
            return LocalizedString("该请求未经授权。", comment: "The default localized description of the request not authorized error")
        case .requestEmailNotVerified:
            return LocalizedString("该电子邮件未经验证。", comment: "The default localized description of the request email not verified error")
        case .requestTermsOfServiceNotAccepted:
            return LocalizedString("服务条款不接受。", comment: "The default localized description of the request terms of service not accepted error")
        case .requestResourceNotFound:
            return LocalizedString("找不到要求的资源。", comment: "The default localized description of the request resource not found error")
        case .responseUnexpected:
            return LocalizedString("该请求返回了意外的响应。", comment: "The default localized description of the response unexpected error")
        case .responseUnexpectedStatusCode(let response, _):
            return String(format: LocalizedString("The request returned an unexpected response status code: %1$@", comment: "The format string for localized description of the response unexpected status code error (1: status code)"), String(describing: response.statusCode))
        case .responseNotAuthenticated:
            return LocalizedString("该请求返回了未经身分的响应。", comment: "The default localized description of the response not authenticated error")
        case .responseMissingJSON:
            return LocalizedString("该请求返回了空的JSON响应。", comment: "The default localized description of the response missing JSON error")
        case .responseMalformedJSON:
            return LocalizedString("该请求返回了无效的JSON响应。", comment: "The default localized description of the response malformed JSON error")
        case .responseUnexpectedJSON:
            return LocalizedString("该请求返回了意外的JSON响应。", comment: "The default localized description of the response unexpected JSON error")
        case .responseMalformed:
            return LocalizedString("该请求返回了无效的响应。", comment: "The default localized description of the response malformed data error")
        case .errorResponse(let reason):
            return reason
        }
    }
}
