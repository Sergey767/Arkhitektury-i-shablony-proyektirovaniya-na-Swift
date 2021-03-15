import UIKit

//func data(from file: String) -> Data {
//    let path1 = Bundle.main.path(forResource: file, ofType: "json")!
//    let url = URL(fileURLWithPath: path1)
//    let data = try! Data(contentsOf: url)
//    return data
//}

//let data1 = data(from: "1")
//let data2 = data(from: "2")
//let data3 = data(from: "3")

// JSONSerialization

struct Persone {
    
    var data: Data?
    var result: Result?
    
    var name = ""
    var age = 0
    let isDeveloper: Bool
    
    init(json: [String: Any]) {
        let age = json["age"] as! Int
        let isDeveloper = json["isDeveloper"] as! Bool
        self.init(age: age, isDeveloper: isDeveloper)
        self.name = json["name"] as! String
        
        let dataJson = json["data"] as! [String: Any]
        self.data = Data(json: dataJson)
        let resultJson = json["result"] as! [String: Any]
        self.result = Result(json: resultJson)
    }
    
    init(age: Int, isDeveloper: Bool) {
        self.age = age
        self.isDeveloper = isDeveloper
    }
    
    struct Data {
        var name = ""
        var age = 0
        let isDeveloper: Bool
        
        init(json: [String: Any]) {
            let age = json["age"] as! Int
            let isDeveloper = json["isDeveloper"] as! Bool
            self.init(age: age, isDeveloper: isDeveloper)
            self.name = json["name"] as! String
        }
        
        init(age: Int, isDeveloper: Bool) {
            self.age = age
            self.isDeveloper = isDeveloper
        }
    }
    
    struct Result {
        var name = ""
        var age = 0
        let isDeveloper: Bool
        
        init(json: [String: Any]) {
            let age = json["age"] as! Int
            let isDeveloper = json["isDeveloper"] as! Bool
            self.init(age: age, isDeveloper: isDeveloper)
            self.name = json["name"] as! String
        }
        
        init(age: Int, isDeveloper: Bool) {
            self.age = age
            self.isDeveloper = isDeveloper
        }
    }
}


protocol ParseHandler {
    var next: ParseHandler? { get set }
    
    func request(from file: String)
}

class ParsePersoneData: ParseHandler {
    var next: ParseHandler?
    
    func request(from file: String) {
        let path1 = Bundle.main.path(forResource: file, ofType: "json")!
        let url = URL(fileURLWithPath: path1)
                
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) else {
                    return
            }
            
            let array = json as! [[String: Any]]
            let personeModel = array.map { Persone.Data(json: $0) }
            
            self.next?.request(from: file)
            return
            
        }.resume()
    }
    
}

class ParsePersoneResult: ParseHandler {
    var next: ParseHandler?
    
    func request(from file: String) {
        let path1 = Bundle.main.path(forResource: file, ofType: "json")!
        let url = URL(fileURLWithPath: path1)
                
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) else {
                    return
            }
            
            let array = json as! [[String: Any]]
            let personeModel = array.map { Persone.Result(json: $0) }
            
            self.next?.request(from: file)
            return
            
        }.resume()
    }
}

let parsePersoneData = ParsePersoneData()
let parsePersoneResult = ParsePersoneResult()

let parseHandler: ParseHandler = parsePersoneData

parsePersoneData.next = parsePersoneResult
parsePersoneResult.next = nil

func request(from file: String) {
    let path1 = Bundle.main.path(forResource: file, ofType: "json")!
    let url = URL(fileURLWithPath: path1)
            
    URLSession.shared.dataTask(with: url) { data, response, error in
        
        guard let data = data,
            let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) else {
                return
        }
        
        let array = json as! [[String: Any]]
        let personeModel = array.map { Persone(json: $0) }
        parseHandler.request(from: file)
        
    }.resume()
}

let request1: () = request(from: "1")
let request2: () = request(from: "2")
let request3: () = request(from: "3")

