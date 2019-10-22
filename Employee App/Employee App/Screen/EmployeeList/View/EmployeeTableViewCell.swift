//
//  EmployeeTableViewCell.swift
//  Employee App
//
//  Created by Kaipeng Wu on 21/10/19.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {

    @IBOutlet weak var employeeNameLabel: UILabel!
    @IBOutlet weak var employeeGenderLabel: UILabel!
    @IBOutlet weak var employeeBirthDateLabel: UILabel!
    @IBOutlet weak var employeePhotoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(employee: Employee){
        employeeNameLabel.text = (employee.last_name ?? "") + ", " + (employee.first_name ?? "")
        employeeGenderLabel.text = employee.gender
        employeeBirthDateLabel.text = employee.birth_date
        if let data = Data(base64Encoded: employee.thumbImage ?? "", options: .ignoreUnknownCharacters){
            employeePhotoImageView.image = UIImage(data: data)
        }
    }
}
