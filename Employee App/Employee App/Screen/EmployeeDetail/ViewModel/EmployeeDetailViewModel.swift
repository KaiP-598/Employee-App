//
//  EmployeeDetailViewModel.swift
//  Employee App
//
//  Created by Kaipeng Wu on 22/10/19.
//

import Foundation
import RxSwift

protocol EmployeeDetailViewModeling {
    
     func getEmployeeDetail() -> Observable<Employee>
    
}

class EmployeeDetailViewModel: EmployeeDetailViewModeling{
    
    let networkService: NetworkServicing
    let employeeId: Int
    
    private let disposeBag = DisposeBag()
    
    init(employeeId: Int, networkService: NetworkServicing){
        self.employeeId = employeeId
        self.networkService = networkService
        
    }
    
    func getEmployeeDetail() -> Observable<Employee>{
        return Observable.create { [weak self] observer in
            
            self?.networkService.getEmployeeDetailById(id: self?.employeeId ?? Int(), completionHandler: { (employee, result) in
                switch result{
                case .failure:
                    //if service fails to fetch, send error to stream
                    debugPrint("There is an error when getting employee detail")
                    observer.onError(result)
                case .success:
                    observer.onNext(employee ?? Employee())
                }
            })
            
            return Disposables.create {
            }
        }
    }
    
    
    
    
}
