//
//  EmployeesViewModel.swift
//  Employee App
//
//  Created by Kaipeng Wu on 21/10/19.
//

import Foundation
import RxSwift

protocol EmployeesViewModeling {
    
    func getEmployees() -> Observable<[Employee]>
    
}

class EmployeesViewModel: EmployeesViewModeling{
    
    let networkService: NetworkServicing
    
    private let disposeBag = DisposeBag()
    
    init(networkService: NetworkServicing){
        
        self.networkService = networkService

    }
    
    func getEmployees() -> Observable<[Employee]>{
        //Create an observable of employee array here
        return Observable.create { [weak self] observer in
            self?.networkService.getEmployees(completionHandler: { (employeeArray, result) in
                switch result{
                case .failure:
                    debugPrint("There is an error when getting employee data")
                    observer.onNext([Employee]())
                case .success:
                    if let employees = employeeArray {
                        //sort employee array by lastname in ascending order
                        //Send sorted array to stream
                        observer.onNext(employees.sorted(by: { ($0.last_name ?? "") < ($1.last_name ?? "") }))
                    } else {
                        observer.onNext([Employee]())
                    }
                }
            })
            
            return Disposables.create {
            }
        }
    }
    
    
    
    
}

