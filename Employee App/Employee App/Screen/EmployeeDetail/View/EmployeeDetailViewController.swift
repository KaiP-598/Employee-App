//
//  EmployeeDetailViewController.swift
//  Employee App
//
//  Created by Kaipeng Wu on 22/10/19.
//

import UIKit
import RxCocoa
import RxSwift

class EmployeeDetailViewController: UIViewController {

    @IBOutlet weak var employeePhotoImageView: UIImageView!
    
    var viewModel: EmployeeDetailViewModeling?
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupBinding()
    }
    
    func setupView(){
        super.title = "Person Details"
    }
    
    func setupBinding(){
        
        //Subscribe to employee detail observable and listen to stream changes
        viewModel?.getEmployeeDetail()
            .subscribe(onNext: { [weak self] (employee) in
                if let data = Data(base64Encoded: employee.image ?? "", options: .ignoreUnknownCharacters){
                    self?.employeePhotoImageView.image = UIImage(data: data)
                }
            }, onError: { (error) in
                debugPrint(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
}
