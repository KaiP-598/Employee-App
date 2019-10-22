//
//  NetworkService.swift
//  Employee App
//
//  Created by Kaipeng Wu on 21/10/19.
//

import Foundation
import SwiftyJSON
import Alamofire
import ObjectMapper

enum NetworkError: Error {
    case failure
    case success
}

protocol NetworkServicing {
    func getEmployees(completionHandler: @escaping ([Employee]?, NetworkError) -> ())
    func getEmployeeDetailById(id: Int, completionHandler: @escaping (Employee?, NetworkError) -> ())
    
}
class NetworkService: NetworkServicing{

    let EMPLOYEES_END_POINT = "http://127.0.0.1:5000/employees"
    
    /// Get all employees' data from the endpoint
    ///
    /// - parameter completionHandler: handler containing employee array and network result.
    func getEmployees(completionHandler: @escaping ([Employee]?, NetworkError) -> ()) {
        
        Alamofire.request(EMPLOYEES_END_POINT).responseJSON { response in
            guard let data = response.data else {
                completionHandler(nil, .failure)
                return
            }
            
            let json = try? JSON(data: data)
            
            guard let jsonArray = json else {
                completionHandler(nil, .failure)
                return
            }

            //Map the returned JSON array to array of employees
            let employeeArray = Mapper<Employee>().mapArray(JSONObject: jsonArray.arrayObject)
            
            completionHandler(employeeArray, .success)
        }
    }
    
    /// Get a specific employee detail
    ///
    /// - parameter id: employee id
    /// - parameter completionHandler: handler containing employee object and network result.
    func getEmployeeDetailById(id: Int, completionHandler: @escaping (Employee?, NetworkError) -> ()) {
        
        Alamofire.request(EMPLOYEES_END_POINT + "/d" + String(id)).responseJSON { response in
            guard let data = response.data else {
                completionHandler(nil, .failure)
                return
            }
            
            let json = try? JSON(data: data)
            
            guard let jsonData = json else {
                completionHandler(nil, .failure)
                return
            }
            
            let employee = Employee.init(JSON: jsonData.dictionaryObject!)
            completionHandler(employee, .success)
        }
    }
}
