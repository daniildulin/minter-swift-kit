//
//  MinterGateAPI.swift
//
//
//  Created by Daniil Dulin on 25.11.2021.
//

import Foundation

public class MinterGateAPI{
    public var host:URLComponents
    private var session = URLSession.shared
    
    public enum MinterGateError: Error {
        case failed
    }
    
    public init (host: String){
        self.host = URLComponents(string: host)!
    }
    
    public func getMinGas(completion: @escaping (Result<Int, Error>) -> ()) {
        var link = host
        link.path = "/api/v2/min_gas_price"
        
        session.dataTask(with: link.url!) { (jsonData, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                      do{
                          let response = try JSONDecoder().decode(MinterGateErrorResponse.self, from: jsonData!)
                          DispatchQueue.global(qos: .userInteractive).async {
                              completion(.failure(GateError.badResponce(response.error.message)))
                          }
                      }catch {
                          completion(.failure(error))
                      }
                      return
                  }
            do{
                let response = try JSONDecoder().decode(MinterGateMinGasResponse.self, from: jsonData!)
                DispatchQueue.main.async {
                    let result = Int(response.minGasPrice) ?? 0
                    completion(.success(result))
                }
            }catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    public func getNonce(address: String, completion: @escaping (Result<Int, Error>) -> ()) {
        var link = host
        link.path = "/api/v1/nonce/\(address)"
        
        session.dataTask(with: link.url!) { (jsonData, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                      do{
                          let response = try JSONDecoder().decode(MinterGateErrorResponse.self, from: jsonData!)
                          DispatchQueue.global(qos: .userInteractive).async {
                              completion(.failure(GateError.badResponce(response.error.message)))
                          }
                      }catch {
                          completion(.failure(error))
                      }
                      return
                  }
            do{
                let response = try JSONDecoder().decode(MinterGateNonceResponse.self, from: jsonData!)
                DispatchQueue.global(qos: .userInteractive).async {
                    let result = Int(response.data.nonce) ?? 0
                    completion(.success(result+1))
                }
            }catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    public func sendTransaction(tx: String, completionHandler: @escaping (Result<MinterGateSendTxResponse, Error>) -> Void) {
        var link = host
        link.path = "/api/v2/send_transaction"
        
        var request = URLRequest(url: link.url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(["tx":tx])
        
        let task = URLSession.shared.dataTask(with: request) { jsonData, resp, error in
            guard let data = jsonData else {
                completionHandler(.failure(error!))
                return
            }
            
            guard let httpResponse = resp as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                      do{
                          let response = try JSONDecoder().decode(MinterGateErrorResponse.self, from: data)
                          DispatchQueue.global(qos: .userInteractive).async {
                              completionHandler(.failure(GateError.badResponce(response.error.message)))
                          }
                      }catch {
                          completionHandler(.failure(error))
                      }
                      return
                  }
            
            do{
                let response = try JSONDecoder().decode(MinterGateSendTxResponse.self, from: data)
                DispatchQueue.global(qos: .userInteractive).async {
                    completionHandler(.success(response))
                }
            }catch {
                completionHandler(.failure(error))
            }
            
        }
        task.resume()
    }
}
