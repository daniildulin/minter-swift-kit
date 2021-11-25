//
//  MinterExplorerAPI.swift
//
//
//  Created by Daniil Dulin on 15.11.2021.
//

import Foundation

public class MinterExplorerAPI{
    public var host:URLComponents
    
    private var session = URLSession.shared
    
    public enum MinterExplorerError: Error {
        case failed
    }
    
    public init (host: String){
        self.host = URLComponents(string: host)!
    }
        
    func getBalance(address: String, completion: @escaping (Result<MinterExplorerAddressData, Error> ) -> ()) {
        var addressHost = host
        addressHost.path = "/api/v2/addresses/\(address)"
        addressHost.queryItems = [
            URLQueryItem(name: "with_sum", value: "true")
        ]
        
        session.dataTask(with: addressHost.url!) { (jsonData, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                      do{
                          let response = try JSONDecoder().decode(MinterAPIErrorResponse.self, from: jsonData!)
                          DispatchQueue.main.async {
                              completion(.failure(MinterApiError.badResponce(response.error.message)))
                          }
                      }catch {
                          completion(.failure(error))
                      }
                      return
                  }
            do{
                let response = try JSONDecoder().decode(MinterExplorerAddressResponse.self, from: jsonData!)
                DispatchQueue.main.async {
                    completion(.success(response.data))
                }
            }catch {
                print("JSON error: \(error.localizedDescription)")
            }
        }.resume()
    }
}
