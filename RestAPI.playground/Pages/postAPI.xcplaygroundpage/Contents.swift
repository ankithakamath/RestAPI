//: [Previous](@previous)

import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

struct Endpoint
{
    static let registerUser = "https://api-dev-scus-demo.azurewebsites.net/api/User/RegisterUser"
    static let getUser = "https://api-dev-scus-demo.azurewebsites.net/api/User/GetUser"
}

struct User
{
    func registerUser()
        {
            //code to register user
            var urlRequest = URLRequest(url: URL(string: Endpoint.registerUser)!)
            urlRequest.httpMethod = "post"
            let dataDictionary = ["name":"codecat15", "email":"codecat15@gmail.com","password":"1234"]
    
            do {
                let requestBody = try JSONSerialization.data(withJSONObject: dataDictionary, options: .prettyPrinted)
    
                urlRequest.httpBody = requestBody
                urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
    
            } catch let error {
                debugPrint(error.localizedDescription)
            }
    
            URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in
    
                if(data != nil && data?.count != 0)
                {
                    let response = String(data: data!, encoding: .utf8)
                    debugPrint(response!)
                }
            }.resume()
        }
    
func getUserFromServer()
{
    var urlRequest = URLRequest(url: URL(string: Endpoint.getUser)!)
    urlRequest.httpMethod = "get"

    URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in
        if(data != nil && data?.count != 0)
        {
            let response = String(data: data!, encoding: .utf8)
            debugPrint(response!)
        }
    }.resume()
}
}

let objUser = User()
objUser.getUserFromServer()
