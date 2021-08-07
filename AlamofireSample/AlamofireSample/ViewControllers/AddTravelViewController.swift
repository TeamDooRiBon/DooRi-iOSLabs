//
//  AddTravelViewController.swift
//  AlamofireSample
//
//  Created by taehy.k on 2021/07/22.
//

import UIKit

class AddTravelViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var travelNameTextField: UITextField!
    @IBOutlet weak var destinationTextField: UITextField!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var addTravelButton: UIButton!
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInit()
    }
    
    // MARK: - Actions
    @IBAction func addTravelButtonTapped(_ sender: Any) {
        // 이미지 인덱스를 제외하고 텍스트 필드에 있는 값들을 파라미터 값으로 전달
        if let travelName = travelNameTextField.text,
           let destination = destinationTextField.text,
           let startDate = startDateTextField.text,
           let endDate = endDateTextField.text {
            
            addTravel(travelName: travelName,
                      destination: destination,
                      startDate: startDate,
                      endDate: endDate,
                      imgIndex: 1)
        }
    }
}

// MARK: - Custom Functions
extension AddTravelViewController {
    private func setInit() {
        travelNameTextField.becomeFirstResponder()
    }
    
    private func addTravel(travelName: String, destination: String,
                           startDate: String, endDate: String, imgIndex: Int) {
        
        APIClient.request(AddTravelResponse.self, router: APIRouter.addTravel(travelName: travelName,
                                                                                     destination: destination,
                                                                                     startDate: startDate,
                                                                                     endDate: endDate,
                                                                                     imageIndex: imgIndex)) { models in
            print(models.data?.inviteCode as Any)
        } failure: { error in
            print(error.localizedDescription)
        }
    }
}
