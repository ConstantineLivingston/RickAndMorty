//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Konstantin Bratchenko on 14.09.2022.
//

import Foundation

final class NetworkManager {
    static func log(request: URLRequest) {
      print("\n - - - - - - - - - - OUTGOING - - - - - - - - - - \n")
      defer { print("\n - - - - - - - - - - END - - - - - - - - - - \n") }
      let urlAsString = request.url?.absoluteString ?? ""
      let urlComponents = URLComponents(string: urlAsString)
      let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""
      let path = "\(urlComponents?.path ?? "")"
      let query = "\(urlComponents?.query ?? "")"
      let host = "\(urlComponents?.host ?? "")"
      var output = """
     \(urlAsString) \n\n
     \(method) \(path)?\(query) HTTP/1.1 \n
     HOST: \(host)\n
     """
      for (key,value) in request.allHTTPHeaderFields ?? [:] {
        output += "\(key): \(value) \n"
      }
      if let body = request.httpBody {
        output += "\n \(String(data: body, encoding: .utf8) ?? "")"
      }
      print(output)
    }
    
    static func log(response: HTTPURLResponse?, data: Data?, error: Error?) {
      print("\n - - - - - - - - - - INCOMING - - - - - - - - - - \n")
      defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
      let urlString = response?.url?.absoluteString
      let components = NSURLComponents(string: urlString ?? "")
      let path = "\(components?.path ?? "")"
      let query = "\(components?.query ?? "")"
      var output = ""
      if let urlString = urlString {
        output += "\(urlString)"
        output += "\n\n"
      }
      if let statusCode =  response?.statusCode {
        output += "HTTP \(statusCode) \(path)?\(query)\n"
      }
      if let host = components?.host {
        output += "Host: \(host)\n"
      }
      for (key, value) in response?.allHeaderFields ?? [:] {
        output += "\(key): \(value)\n"
      }
      if let body = data {
        output += "\n\(String(data: body, encoding: .utf8) ?? "")\n"
      }
      if error != nil {
        output += "\nError: \(error!.localizedDescription)\n"
      }
      print(output)
    }
}

extension NetworkManager {
    static func fetchCharactersFrom(urlString: String, withCompletion completion: @escaping (CharactersResponse) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let urlRequest = URLRequest(url: url)

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                print("URL Session Task Failed: %@", error!.localizedDescription)
                return
            }
            guard let data = data else { return }

            if let decodedData = try? JSONDecoder().decode(CharactersResponse.self, from: data) {
                DispatchQueue.main.async {
                    completion(decodedData)
                }
            }
//            log(response: response as? HTTPURLResponse, data: data, error: error)
        }.resume()
    }
}
