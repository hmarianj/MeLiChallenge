import Foundation

// HTTP implementation
// Use to call backend endpoints.
final class HTTPClient {
    static let shared = HTTPClient()
    var jsonDecoder: JSONDecoder = JSONDecoder()
    
    init() {
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        jsonDecoder.dateDecodingStrategy = .iso8601
    }
    
    /// Executes a request asynchronously and returns a response, or throws an error.
    func execute<Response: Decodable>(
        urlString: String,
        method: HttpMethod,
        headers: [String: String] = [:],
        responseType: Response.Type
    ) async throws -> Response {
        let request = urlRequest(urlString: urlString, method: method, headers: headers)
        print("""
        ===> Network Request started:
        URL: \(request.url?.absoluteString ?? "")
        """)
        let (data, response) = try await URLSession.shared.data(
            for: request,
            delegate: nil
        )
        
        guard let response = response as? HTTPURLResponse else {
            throw Errors.noResponse
        }
        print("""
        <=== Network Response received:
        Code: \(response.statusCode)
        URL: \(request.url?.absoluteString ?? "")
        JSON: \(data.prettyPrintedJSONString)
        """)
        
        switch response.statusCode {
        case 200...299:
            let decodedResponse = try jsonDecoder.decode(
                responseType,
                from: data
            )
            
            return decodedResponse
            
        case 401:
            throw Errors.unauthorized
        default:
            throw Errors.unexpectedStatusCode
        }
    }
    
    private func urlRequest(
        urlString: String,
        method: HttpMethod,
        headers: [String: String] = [:]
    ) -> URLRequest {
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }
        var request = URLRequest(url: url)
        
        switch method {
        case .post(let data), .put(let data):
            request.httpBody = data
        case let .get(queryItems):
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            components?.queryItems = queryItems
            guard let url = components?.url else {
                preconditionFailure("Couldn't create a url from components...")
            }
            request = URLRequest(url: url)
        default:
            break
        }
        
        request.allHTTPHeaderFields = headers
        request.httpMethod = method.name
        return request
    }
    
    enum Errors: Error {
        case unauthorized
        case unexpectedStatusCode
        case noResponse
    }
}

enum HttpMethod: Equatable {
    case get([URLQueryItem]?)
    case put(Data?)
    case post(Data?)
    case patch
    
    var name: String {
        switch self {
        case .get: return "GET"
        case .put: return "PUT"
        case .post: return "POST"
        case .patch: return "PATCH"
        }
    }
}
