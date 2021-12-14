//: [Previous](@previous)

import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true



struct GetUrl
{
    static let registerUser = "https://api-dev-scus-demo.azurewebsites.net/api/User/RegisterUser"
    static let getUser = "https://api-dev-scus-demo.azurewebsites.net/api/User/GetUser"
}

struct UserRegistrationRequest: Encodable {
    let name, email, password: String

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case email = "Email"
        case password = "Password"
    }
}


struct UserRegistrationResponse: Decodable {
    let errorMessage: String
    let data: UserData
}


struct UserData: Decodable {
    let name, email, id, joining: String
}

struct User
{
    func registerUserWithEncodableProtocol()
    {
        var urlRequest = URLRequest(url: URL(string: GetUrl.registerUser)!)
        urlRequest.httpMethod = "post"

        let request = UserRegistrationRequest(name: "Ankitha", email: "kamathankitha@gmail.com", password: "1234")

        do {

            let requestBody = try JSONEncoder().encode(request)
            urlRequest.httpBody = requestBody
            urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")

        } catch let error {
            debugPrint(error.localizedDescription)
        }

        URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in

            if(data != nil && data?.count != 0)
            {
                do {
        
                    let response = try JSONDecoder().decode(UserRegistrationResponse.self, from: data!)
                    debugPrint(response.data.name)
                    print(response.data)
                }
                catch let decodingError {
                    debugPrint(decodingError)
                }
            }
        }.resume()
    }


    func GetUserFromServer()
    {
        var urlRequest = URLRequest(url: URL(string: GetUrl.getUser)!)
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
objUser.registerUserWithEncodableProtocol()
objUser.GetUserFromServer()
