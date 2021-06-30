//
//  ViewController.swift
//  testtest
//
//  Created by 한상진 on 2021/06/29.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateSelectButton: UIButton!
    
    //MARK: - Variable
    
    let dateFormatter = DateFormatter()
    var components = DateComponents()
    var daysCountInMonth = 0
    var weekdayAdding = 0
    var dayList: [CalendarModel] = []
    
    //MARK: - Life Cycle    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelSet()
        tableViewSet()
        dateSet()
        
        /// 임시적으로 1년치만 넣었습니다. 향후 기디분들과 회의 후 변경할 예정
        dayListSet(index: 12)
    }

    //MARK: - Function
    
    func labelSet() {
        mainLabel.numberOfLines = 2
        mainLabel.text = "여행은 언제부터\n언제까지 하세요?"
    }
    
    func tableViewSet() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 400
    }
    
    /// 초기 날짜 설정 (달력 시작 날짜)
    func dateSet() {
        dateFormatter.dateFormat = "yyyy년 M월"
        components.year = Calendar.current.component(.year, from: Date())
        components.month = Calendar.current.component(.month, from: Date())
        components.day = 1
    }
    
    /// 월 별 달력 값들을 계산하여 리스트에 추가
    func dayListSet(index: Int) {
        var month = Int(components.month!) - 1
        
        for _ in 0...index {
            var addYear = 0
            month += 1
            
            if month % 13 == 0 {
                month = 1
                addYear += 1
            }
            
            components.year! += addYear
            components.month! = month
            
            let firstDayOfMonth = Calendar.current.date(from: components)
            
            /// 무슨 요일부터 달력이 시작되는지 계산하는 과정
            let firstWeekday = Calendar.current.component(.weekday, from: firstDayOfMonth!)
            daysCountInMonth = Calendar.current.range(of: .day, in: .month, for: firstDayOfMonth!)!.count
            weekdayAdding = 2-firstWeekday
            
            /// 위에서 계산한 결과에 따라 달력에 알맞게 날짜들을 넣어주는 과정
            var temp: [String] = []
            for day in weekdayAdding...daysCountInMonth {
                if day < 1 {
                    temp.append("")
                } else {
                    temp.append(String(day))
                }
            }

            dayList.append(contentsOf: [
                CalendarModel(yearAndMonth: dateFormatter.string(from: firstDayOfMonth!), days: temp)
            ])
        }
    }
}

//MARK: - Extension

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "calendarTableCell", for: indexPath) as? CalendarTableViewCell else { return UITableViewCell()}
        cell.days = dayList[indexPath.row].days
        cell.yearAndMonth = dayList[indexPath.row].yearAndMonth
        cell.collectionView.reloadData()
        return cell
    }
}
