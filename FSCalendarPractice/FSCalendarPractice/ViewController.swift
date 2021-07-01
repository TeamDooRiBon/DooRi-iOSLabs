//
//  ViewController.swift
//  FSCalendarPractice
//
//  Created by 한상진 on 2021/07/01.
//

import UIKit
import FSCalendar

class ViewController: UIViewController {
    
    //MARK:- IBOutlet
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var selectButton: UIButton!
    
    //MARK:- Variable
    
    private var firstDate: Date?
    private var lastDate: Date?
    private var datesRange: [Date]?
    fileprivate let gregorian = Calendar(identifier: .gregorian)
    
    var startString = ""
    var endString = ""
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self
        calendar.dataSource = self
        topLabel.numberOfLines = 2
        topLabel.text = "번들님 여행 날짜는\n언제인가요?"
        calendar.today = nil
        calendar.allowsMultipleSelection = true
        calendar.scrollDirection = .vertical
        calendar.swipeToChooseGesture.isEnabled = true
        
        calendar.appearance.weekdayTextColor = .systemGray2
        calendar.appearance.headerTitleColor = .blue
        calendar.appearance.headerDateFormat = "YYYY년 M월"
        calendar.appearance.headerTitleFont = UIFont.systemFont(ofSize: 24)
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.calendarWeekdayView.weekdayLabels[0].textColor = .red
        calendar.calendarWeekdayView.weekdayLabels[6].textColor = .red
        
        calendar.register(DIYCalendarCell.self, forCellReuseIdentifier: "cell")
    }
}

//MARK:- Extension

extension ViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position)
        return cell
    }
    
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
        self.configure(cell: cell, for: date, at: position)
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition)   -> Bool {
        return monthPosition == .current
    }
    
    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return monthPosition == .current
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//        let correctDate = Calendar.current.date(byAdding: .day, value: 1, to: date)
        /// nothing selected:
        if firstDate == nil {
//            firstDate = Calendar.current.date(byAdding: .day, value: 1, to: date)
            firstDate = date
            datesRange = [firstDate!]
            print("출발일 선택됨")
            let startYear = Calendar.current.dateComponents([.year], from: date)
            let startMonth = Calendar.current.dateComponents([.month], from: date)
            let startDay = Calendar.current.dateComponents([.day], from: date)
            if startMonth.month! >= 10 && startDay.day! >= 10{
                startString = "\(startYear.year!).\(startMonth.month!).\(startDay.day!)"
                self.selectButton.setTitle(startString, for: .normal)
            } else if startMonth.month! < 10 && startDay.day! >= 10 {
                startString = "\(startYear.year!).0\(startMonth.month!).\(startDay.day!)"
                self.selectButton.setTitle(startString, for: .normal)
            } else if startMonth.month! < 10 && startDay.day! < 10 {
                startString = "\(startYear.year!).0\(startMonth.month!).0\(startDay.day!)"
                self.selectButton.setTitle(startString, for: .normal)
            } else if startMonth.month! >= 10 && startDay.day! < 10 {
                startString = "\(startYear.year!).\(startMonth.month!).0\(startDay.day!)"
                self.selectButton.setTitle(startString, for: .normal)
            }
            self.configureVisibleCells()
            return
        }

        /// only first date is selected:
        if firstDate != nil && lastDate == nil {
            // handle the case of if the last date is less than the first date:
//            if correctDate! <= firstDate! {
            if date <= firstDate! {
                calendar.deselect(firstDate!)
//                firstDate = correctDate!
                firstDate = date
                datesRange = [firstDate!]

                print("출발일 다시 선택됨")
                let startYear = Calendar.current.dateComponents([.year], from: date)
                let startMonth = Calendar.current.dateComponents([.month], from: date)
                let startDay = Calendar.current.dateComponents([.day], from: date)
                
                if startMonth.month! >= 10 && startDay.day! >= 10{
                    startString = "\(startYear.year!).\(startMonth.month!).\(startDay.day!)"
                    self.selectButton.setTitle(startString, for: .normal)
                } else if startMonth.month! < 10 && startDay.day! >= 10 {
                    startString = "\(startYear.year!).0\(startMonth.month!).\(startDay.day!)"
                    self.selectButton.setTitle(startString, for: .normal)
                } else if startMonth.month! < 10 && startDay.day! < 10 {
                    startString = "\(startYear.year!).0\(startMonth.month!).0\(startDay.day!)"
                    self.selectButton.setTitle(startString, for: .normal)
                } else if startMonth.month! >= 10 && startDay.day! < 10 {
                    startString = "\(startYear.year!).\(startMonth.month!).0\(startDay.day!)"
                    self.selectButton.setTitle(startString, for: .normal)
                }
                self.configureVisibleCells()
                return
            }

            let range = datesRange(from: firstDate!, to: date)
            lastDate = range.last
            for d in range {
                calendar.select(d)
            }
            datesRange = range
            print("종료일 선택됨")
            let endYear = Calendar.current.dateComponents([.year], from: date)
            let endMonth = Calendar.current.dateComponents([.month], from: date)
            let endDay = Calendar.current.dateComponents([.day], from: date)
            
            if endMonth.month! >= 10 && endDay.day! >= 10{
                endString = "\(endYear.year!).\(endMonth.month!).\(endDay.day!)"
                self.selectButton.setTitle("\(startString) - \(endString) 등록하기", for: .normal)
            } else if endMonth.month! < 10 && endDay.day! >= 10 {
                endString = "\(endYear.year!).0\(endMonth.month!).\(endDay.day!)"
                self.selectButton.setTitle("\(startString) - \(endString) 등록하기", for: .normal)
            } else if endMonth.month! < 10 && endDay.day! < 10 {
                endString = "\(endYear.year!).0\(endMonth.month!).0\(endDay.day!)"
                self.selectButton.setTitle("\(startString) - \(endString) 등록하기", for: .normal)
            } else if endMonth.month! >= 10 && endDay.day! < 10 {
                endString = "\(endYear.year!).\(endMonth.month!).0\(endDay.day!)"
                self.selectButton.setTitle("\(startString) - \(endString) 등록하기", for: .normal)
            }
            self.configureVisibleCells()
            
            return
        }

        // both are selected:
        if firstDate != nil && lastDate != nil {
            for d in calendar.selectedDates {
                calendar.deselect(d)
            }
            lastDate = nil
            firstDate = nil
            datesRange = []
            self.configureVisibleCells()
        }
    }

    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // both are selected:

        // NOTE: the is a REDUANDENT CODE:
        if firstDate != nil && lastDate != nil {
            for d in calendar.selectedDates {
                calendar.deselect(d)
            }
            lastDate = nil
            firstDate = nil
            datesRange = []
            print("datesRange contains: \(datesRange!)")
        }
    }

    func datesRange(from: Date, to: Date) -> [Date] {
        if from > to { return [Date]() }
        var tempDate = from
        var array = [tempDate]
        while tempDate < to {
            tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
            array.append(tempDate)
        }
        return array
    }
    
    private func configureVisibleCells() {
        calendar.visibleCells().forEach { (cell) in
            let date = calendar.date(for: cell)
            let position = calendar.monthPosition(for: cell)
            self.configure(cell: cell, for: date!, at: position)
        }
    }
    
    private func configure(cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
        
        let diyCell = (cell as! DIYCalendarCell)
        if position == .current {
            var selectionType = SelectionType.none
            if calendar.selectedDates.contains(date) {
                let previousDate = self.gregorian.date(byAdding: .day, value: -1, to: date)!
                let nextDate = self.gregorian.date(byAdding: .day, value: 1, to: date)!
                if calendar.selectedDates.contains(date) {
                    if calendar.selectedDates.contains(previousDate) && calendar.selectedDates.contains(nextDate) {
                        selectionType = .middle
                    }
                    else if calendar.selectedDates.contains(previousDate) && calendar.selectedDates.contains(date) {
                        selectionType = .rightBorder
                    }
                    else if calendar.selectedDates.contains(nextDate) {
                        selectionType = .leftBorder
                    }
                    else {
                        selectionType = .single
                    }
                }
            }
            else {
                selectionType = .none
            }
            if selectionType == .none {
                diyCell.selectionLayer.isHidden = true
                return
            }
            diyCell.selectionLayer.isHidden = false
            diyCell.selectionType = selectionType
            
        } else {
            diyCell.selectionLayer.isHidden = true
        }
    }
}
