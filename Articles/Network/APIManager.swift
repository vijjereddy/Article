//
//  APIManager.swift
//  Articles
//
//  Created by VijayaLakshmi Tatiparthi on 29/04/24.
//

import Foundation

typealias Success = Any
typealias Failure = Any

final class APIManager: API {

    func fetchArticleData(pageNo: Int, completionHandler: @escaping ([ArticleModel]?, ArticleError?) -> Void) {

        guard let url = self.url(pageNo: pageNo) else {
            completionHandler(nil, ArticleError.invalidUrl)
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let strongSelf = self else { return }
            do {
                let result = try strongSelf.jsonParsing(type: [ArticleModel].self, data: data, error: error)
                completionHandler(result, nil)
            } catch let error {
                completionHandler(nil, error as? ArticleError)
            }
        }.resume()
    }
    
    func url(pageNo: Int) -> URL? {
        let url = BASEURL + "\(pageNo)/photos"

        guard let baseURL = URL(string: url) else {
            return nil
        }
        return baseURL
    }
}

extension APIManager {
    
    ///  helps to convert json object to model
    /// - Parameters:
    ///   - type: descripe the model type
    ///   - data:  response data
    ///   - error:  response error
    /// - Returns: returns the value or else through the exceptions
    func jsonParsing<T: Decodable>(type: T.Type,
                                        data: Data?,
                                        error: Error?) throws -> T {
        guard let data = data else {
            if let error = error {
                throw error.getError
            } else {
                throw ArticleError.invalidUrl
            }
        }
        do {
            let model = try JSONDecoder().decode(type.self, from: data)
            return model
        } catch _ {
            throw ArticleError.dataParsingError
        }
    }
}

extension Error {
    var getError: Error {
        let error = self as NSError
        switch error.code {
        case NSURLErrorNotConnectedToInternet, NSURLErrorNetworkConnectionLost, NSURLErrorCannotConnectToHost:
            return ArticleError.networkError
        case NSURLErrorTimedOut:
            return ArticleError.timeoutError
        default:
            if error.domain == NSURLErrorDomain {
                return ArticleError.domainError
            }
            return ArticleError.invalidUrl
        }
    }
}


