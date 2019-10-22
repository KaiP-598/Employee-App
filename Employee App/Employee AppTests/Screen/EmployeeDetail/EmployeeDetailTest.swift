//
//  EmployeeDetailTest.swift
//  Employee AppTests
//
//  Created by Kaipeng Wu on 21/10/19.
//

import XCTest
import RxSwift
@testable import Employee_App

class EmployeeDetailTest: XCTestCase {
    
    var viewModel: EmployeeDetailViewModeling?
    
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
        let mockEmployee = Employee()
        let result: (Employee?, NetworkError) = (mockEmployee, NetworkError.success)
        networkService.getEmployeeDetailResult = result
        viewModel = EmployeeDetailViewModel.init(employeeId: 0, networkService: networkService)
        
        let expectEmployeeDetailFetched = expectation(description:"Fetched result contains employee detail data")

        viewModel?.getEmployeeDetail()
            .subscribe(onNext: { (employee) in
                expectEmployeeDetailFetched.fulfill()
            })
            .disposed(by: disposeBag)
        
        wait(for: [expectEmployeeDetailFetched], timeout:0.1)
    }
    
    func testFailToGetEmployees(){
        let disposeBag = DisposeBag()
        let networkService = MockNetworkService()
        let mockEmployee = Employee()
        let result: (Employee?, NetworkError) = (mockEmployee, NetworkError.failure)
        networkService.getEmployeeDetailResult = result
        viewModel = EmployeeDetailViewModel.init(employeeId: 0, networkService: networkService)
        
        let expectEmployeeDetailFetched = expectation(description:"Failed to fetch employee detail data")
        
        viewModel?.getEmployeeDetail()
            .subscribe(onNext: { (employee) in
                
            }, onError: { (error) in
                expectEmployeeDetailFetched.fulfill()
            })
            .disposed(by: disposeBag)
        
        wait(for: [expectEmployeeDetailFetched], timeout:0.1)
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


