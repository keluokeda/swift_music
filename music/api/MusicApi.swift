//
//  MusicApi.swift
//  music
//
//  Created by 余艳辉 on 2023/3/31.
//

import Foundation
import Moya

public enum MusicApi {
    case getQRKey
    case createQR(String)
    case checkLogin(String)
}

extension MusicApi: TargetType {
    public var path: String {
        switch self {
        case .getQRKey:
            return "login/qr/key"
        case .createQR:
            return "login/qr/create"
        case .checkLogin:
            return "login/qr/check"
        }
    }
    
    public var task: Moya.Task {
        var params: [String: Any] = [:]
        params["timestamp"] = Date().timeIntervalSince1970
        
        switch self {
        case .createQR(let key):
            params["key"] = key
            
        case .checkLogin(let key):
            params["key"] = key
        
        default: do {}
        }
        
        return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
    }
    
    public var headers: [String: String]? {
        return nil
    }
    
    public var baseURL: URL {
        return URL(string: "https://music.cpolar.top/")!
    }
    
    public var method: Moya.Method {
        return Moya.Method.get
    }
}
