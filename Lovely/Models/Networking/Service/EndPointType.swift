//
//  EndPointType.swift
//  Lovely
//
//  Created by MacOS on 8/28/20.
//  Copyright © 2020 Tran Viet. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String: String]

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public enum HTTPTask {
    case request
    case requestParameters(bodyParameters: Parameters?, bodyEndcoding: ParameterEncoding, urlParameters: Parameters?)
    case requestParametersAndHeaders(bodyParameters: Parameters?, bodyEndcoding: ParameterEncoding, urlParameters: Parameters?, additionHeaders: HTTPHeaders)
    // case download, upload,...
}

protocol EndPointType {
    var baseURL: URL {get}
    var path: String {get}
    var httpMethod: HTTPMethod {get}
    var task: HTTPTask {get}
    var headers: HTTPHeaders? {get}
}
