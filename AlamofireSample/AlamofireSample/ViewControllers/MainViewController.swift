//
//  MainViewController.swift
//  AlamofireSample
//
//  Created by taehy.k on 2021/07/22.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    var schedules: [Schedule]? {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - Life Cylces
    override func viewDidLoad() {
        super.viewDidLoad()

        setTableView()
        getSchedules(groupId: "60f1df0e47b392202ccdc0c7",
                     date: "2021-10-05")
    }
    
    // MARK: - Actions
    @IBAction func pushAddTravelViewControllerTapped(_ sender: Any) {
        guard let vc = UIStoryboard(name: "AddTravelStoryboard", bundle: nil)
                .instantiateViewController(identifier: "AddTravelViewController") as? AddTravelViewController else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Configure
extension MainViewController {
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        
        registerNibs()
    }
    
    private func registerNibs() {
        let scheduleNib = UINib(nibName: "ScheduleTableViewCell", bundle: nil)
        tableView.register(scheduleNib, forCellReuseIdentifier: ScheduleTableViewCell.cellId)
    }
}

// MARK: - Custom Functions
extension MainViewController {
    // - Network
    private func getSchedules(groupId: String, date: String) {
        APIClient.request(ScheduleResponse.self,
                                 router: APIRouter.getSchedules(groupId: groupId,
                                                                date: date)) { [weak self] (models) in
            self?.setScheduleResult(models)
        } failure: { error in
            print(error.localizedDescription)
        }
    }
    
    // Schedule Data Setting을 함수로 분리
    private func setScheduleResult(_ scheduleResult: ScheduleResponse) {
        schedules = scheduleResult.data?.schedules
        tableView.reloadData()
    }
}

// MARK: - TableView Delegate
extension MainViewController: UITableViewDelegate {
    
}

// MARK: - TableView DataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedules?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleTableViewCell.cellId, for: indexPath) as? ScheduleTableViewCell else { return UITableViewCell() }
        let schedules = self.schedules?[indexPath.row]
        cell.configureCell(title: schedules?.title ?? "", memo: schedules?.memo ?? "")
        return cell
    }
}
