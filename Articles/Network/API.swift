//
//  API.swift
//  Articles
//
//  Created by VijayaLakshmi Tatiparthi on 29/04/24.
//

import Foundation

/// A simple API that executes async network requests.
/// An instance of this API must have a clear lifecycle and any ongoing network request must be cancelled upon deallocation.
protocol API {
    
    /// Fetch Article data
    /// - Parameters:
    ///   - completionHandler: Returns the success and failure response
    func fetchArticleData(pageNo: Int, completionHandler: @escaping (_ result: [ArticleModel]?, _ error: ArticleError?) -> Void)
}

/// An error indicating failure to create/initialize an `API` object.
enum ArticleError: Error {
    /// The remote is unrecognized (invalid). A typical reason for this error can be backend migration to a different base URL.
    /// **Handling: Exit (terminate) the application.**
    ///     *You may choose to show an alert with a message to "Update the application" to the users before termination.*
    ///
    case invalidUrl
    
    /// Use Different error case like Network error, dataparsing error, domain error, timeout error
    case dataParsingError
    
    case networkError
    
    case domainError
    
    case timeoutError
    
    case frontEndError(message: String)
}

enum Endpoint: String {
    
    case articleData
    
}
