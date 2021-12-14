//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true


//https://jsonplaceholder.typicode.com/todos/1


func getData(){
    let session = URLSession.shared
  let serviceURL = URL(string: "https://jsonplaceholder.typicode.com/todos/1")
    
    let task = session.dataTask(with: serviceURL!) { (
    serviceData, serviceResponse, error) in
        
    if error == nil {
       let httpResponse = serviceResponse as! HTTPURLResponse
        if(httpResponse.statusCode == 200){
            //data parse
            
            let jsonData = try? JSONSerialization.jsonObject(with: serviceData!, options: .mutableContainers)
            
            let result = jsonData as! Dictionary<String,Any>
            print("id = \(result["id"]!)")
        }
    }
}
    task.resume()
}
getData()
