//
//  File.swift
//  
//
//  Created by Marco Del Giudice on 15/02/22.
//

/// Type alias for HTTP header dictionary
public typealias HTTPHeaders = [Header: String]

/// Common HTTP headers.
public enum Header: Hashable {
    /// Use when the header value you want is not in the list.
    case custom(String)
    /// Accept
    case accept
    /// Accept-Charset
    case acceptCharset
    /// Accept-Encoding
    case acceptEncoding
    /// Accept-Language
    case acceptLanguage
    /// Accept-Ranges
    case acceptRanges
    /// Access-Control-Allow-Origin
    case accessControlAllowOrigin
    /// Age
    case age
    /// Allow
    case allow
    /// x-ms-version
    case apiVersion
    /// Authorization
    case authorization
    /// Cache-Control
    case cacheControl
    /// x-ms-client-request-id
    case clientRequestId
    /// Connection
    case connection
    /// Content-Disposition
    case contentDisposition
    /// Content-Encoding
    case contentEncoding
    /// Content-Language
    case contentLanguage
    /// Content-Length
    case contentLength
    /// Content-Location
    case contentLocation
    /// Content-MD5
    case contentMD5
    /// Content-Range
    case contentRange
    /// Content-Type
    case contentType
    /// Date
    case date
    /// x-ms-date
    case xmsDate
    /// Etag
    case etag
    /// Expect
    case expect
    /// Expires
    case expires
    /// From
    case from
    /// Host
    case host
    /// If-Match
    case ifMatch
    /// If-Modified-Since
    case ifModifiedSince
    /// If-None-Match
    case ifNoneMatch
    /// If-Unmodified-Since
    case ifUnmodifiedSince
    /// Last-Modified
    case lastModified
    /// Location
    case location
    /// Pragma
    case pragma
    /// Range
    case range
    /// Referer
    case referer
    /// Request-Id
    case requestId
    /// Retry-After
    case retryAfter
    /// x-ms-return-client-request-id
    case returnClientRequestId
    /// Server
    case server
    /// Slug
    case slug
    /// traceparent
    case traceparent
    /// Trailer
    case trailer
    /// Transfer-Encoding
    case transferEncoding
    /// User-Agent
    case userAgent
    /// Vary
    case vary
    /// Via
    case via
    /// Warning
    case warning
    /// WWW-Authenticate
    case wwwAuthenticate
    
    public var stringValue: String {
        switch self {
        case let .custom(val):
            return val
        case .accept:
            return "Accept"
        case .acceptCharset:
            return "Accept-Charset"
        case .acceptEncoding:
            return "Accept-Encoding"
        case .acceptLanguage:
            return "Accept-Language"
        case .acceptRanges:
            return "Accept-Ranges"
        case .accessControlAllowOrigin:
            return "Access-Control-Allow-Origin"
        case .age:
            return "Age"
        case .allow:
            return "Allow"
        case .apiVersion:
            return "x-ms-version"
        case .authorization:
            return "Authorization"
        case .cacheControl:
            return "Cache-Control"
        case .clientRequestId:
            return "x-ms-client-request-id"
        case .connection:
            return "Connection"
        case .contentDisposition:
            return "Content-Disposition"
        case .contentEncoding:
            return "Content-Encoding"
        case .contentLanguage:
            return "Content-Language"
        case .contentLength:
            return "Content-Length"
        case .contentLocation:
            return "Content-Location"
        case .contentMD5:
            return "Content-MD5"
        case .contentRange:
            return "Content-Range"
        case .contentType:
            return "Content-Type"
        case .date:
            return "Date"
        case .xmsDate:
            return "x-ms-date"
        case .etag:
            return "Etag"
        case .expect:
            return "Expect"
        case .expires:
            return "Expires"
        case .from:
            return "From"
        case .host:
            return "Host"
        case .ifMatch:
            return "If-Match"
        case .ifModifiedSince:
            return "If-Modified-Since"
        case .ifNoneMatch:
            return "If-None-Match"
        case .ifUnmodifiedSince:
            return "If-Unmodified-Since"
        case .lastModified:
            return "Last-Modified"
        case .location:
            return "Location"
        case .pragma:
            return "Pragma"
        case .range:
            return "Range"
        case .referer:
            return "Referer"
        case .requestId:
            return "Request-Id"
        case .retryAfter:
            return "Retry-After"
        case .returnClientRequestId:
            return "x-ms-return-client-request-id"
        case .server:
            return "Server"
        case .slug:
            return "Slug"
        case .traceparent:
            return "traceparent"
        case .trailer:
            return "Trailer"
        case .transferEncoding:
            return "Transfer-Encoding"
        case .userAgent:
            return "User-Agent"
        case .vary:
            return "Vary"
        case .via:
            return "Via"
        case .warning:
            return "Warning"
        case .wwwAuthenticate:
            return "WWW-Authenticate"
        }
    }
}

public extension HTTPHeaders {
    func getHTTPHeaders() -> [String: String] {
        var dictionary: [String: String] = [:]
        self.forEach{dictionary[$0.key.stringValue] = $0.value}
        return dictionary
    }
}
