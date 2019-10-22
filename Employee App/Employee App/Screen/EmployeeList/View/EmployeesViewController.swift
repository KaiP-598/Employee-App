//
//  ViewController.swift
//  Employee App
//
//  Created by Kaipeng Wu on 20/10/19.
//

import UIKit
import RxSwift
import RxCocoa

class EmployeesViewController: UIViewController {
    
    @IBOutlet weak var employeeTableView: UITableView!
    
    var viewModel: EmployeesViewModeling?
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupBinding()
    }
    
    func setupView(){
        super.title = "People DB"
        
        employeeTableView.register(UINib(nibName: "EmployeeTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "EmployeeTableViewCell")

        employeeTableView.delegate = self
    }
    
    func setupBinding(){
        viewModel = EmployeesViewModel.init(networkService: NetworkService())
        
        //Bind employees array observable to tableview
        viewModel?.getEmployees().bind(to: employeeTableView.rx.items(cellIdentifier: "EmployeeTableViewCell", cellType: EmployeeTableViewCell.self)) { row, employee, cell in
                cell.configureCell(employee: employee)
            }.disposed(by: disposeBag)

        //Trigger action when cell is tapped
        employeeTableView.rx.modelSelected(Employee.self)
            .subscribe(onNext: { [weak self] employee in
                if let id = employee.id{
                    self?.showEmployeeDetail(employeeId: id)
                }
            }).disposed(by: disposeBag)
    }
    
    func showEmployeeDetail(employeeId: Int){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier :"EmployeeDetailViewController") as! EmployeeDetailViewController
        let employeeDetailViewModel = EmployeeDetailViewModel.init(employeeId: employeeId, networkService: NetworkService())
        viewController.viewModel = employeeDetailViewModel
        navigationController?.pushViewController(viewController, animated: true)
    }


}

extension EmployeesViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
