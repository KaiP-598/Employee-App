//
//  MockNetworkService.swift
//  Employee AppTests
//
//  Created by Kaipeng Wu on 21/10/19.
//

import XCTest
@testable import Employee_App

class MockNetworkService: NetworkServicing{
    
    var getEmployeesResult: ([Employee]?, NetworkError)?
    var getEmployeeDetailResult: (Employee?, NetworkError)?
    
    func getEmployees(completionHandler: @escaping ([Employee]?, NetworkError) -> ()) {
        guard let result = getEmployeesResult else {
            completionHandler(nil, .failure)
            return
        }
        
        completionHandler(result.0, result.1)
    }
    
    func getEmployeeDetailById(id: Int, completionHandler: @escaping (Employee?, NetworkError) -> ()) {
        
        guard let result = getEmployeeDetailResult else {
            completionHandler(nil, .failure)
            return
        }
        
        completionHandler(result.0, result.1)
    }
    
    
}

