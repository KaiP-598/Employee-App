//
//  EmployeesTest.swift
//  Employee AppTests
//
//  Created by Kaipeng Wu on 21/10/19.
//

import XCTest
import RxSwift
@testable import Employee_App

class EmployeesTest: XCTestCase {
    
    var viewModel: EmployeesViewModeling?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }
    
    func testSuccessfulGetEmployees(){
        let disposeBag = DisposeBag()
        let networkService = MockNetworkService()
        let mockEmployeeArray = [Employee(),Employee()]
        let result: ([Employee]?, NetworkError) = (mockEmployeeArray, NetworkError.success)
        networkService.getEmployeesResult = result
        viewModel = EmployeesViewModel.init(networkService: networkService)
        
        let expectEmployeesFetched = expectation(description:"Fetched result contains employees data")
        viewModel?.getEmployees()
            .subscribe(onNext: { (employees) in
                let employeeDataFetched: Bool
                if employees.isEmpty{
                    employeeDataFetched = false
                } else {
                    employeeDataFetched = true
                }
                
                XCTAssertTrue(employeeDataFetched)
                expectEmployeesFetched.fulfill()
            })
            .disposed(by: disposeBag)
        
        wait(for: [expectEmployeesFetched], timeout:0.1)
    }
    
    func testFailToGetEmployees(){
        let disposeBag = DisposeBag()
        let networkService = MockNetworkService()
        let mockEmployeeArray = [Employee]()
        let result: ([Employee]?, NetworkError) = (mockEmployeeArray, NetworkError.failure)
        networkService.getEmployeesResult = result
        viewModel = EmployeesViewModel.init(networkService: networkService)
        
        let expectEmployeesFailToFetch = expectation(description:"Fetched result does not contains employees data")
        viewModel?.getEmployees()
            .subscribe(onNext: { (employees) in
                let employeeDataFetched: Bool
                if employees.isEmpty{
                    employeeDataFetched = true
                } else {
                    employeeDataFetched = false
                }
                
                XCTAssertTrue(employeeDataFetched)
                expectEmployeesFailToFetch.fulfill()
            })
            .disposed(by: disposeBag)
        
        wait(for: [expectEmployeesFailToFetch], timeout:0.1)
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

