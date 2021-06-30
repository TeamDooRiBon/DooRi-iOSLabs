//
//  CalendarTableViewCell.swift
//  testtest
//
//  Created by 한상진 on 2021/06/29.
//

import UIKit

class CalendarTableViewCell: UITableViewCell {

    //MARK: - IBOutlet
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Variable
    
    var yearAndMonth = ""
    var days: [String] = []
    var weeks: [String] = ["일", "월", "화", "수", "목", "금", "토"]
    /// 날짜가 선택됐는지 판별해줄 변수
    var selectCheck = false
    /// 여행 시작 날짜, 끝 날짜
    var start = -1
    var end = -1
    
    //MARK: - override func
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionViewSet()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Function
    func collectionViewSet() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register((UINib(nibName: "CalendarCollectionViewCell", bundle: nil)), forCellWithReuseIdentifier: "calendarCell")
    }
}

//MARK: - Extension

extension CalendarTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 7
        default:
            return self.days.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath) as! CalendarCollectionViewCell
        
        /// 토요일, 일요일은 날짜를 빨간색으로 표시, 이외 검정색
        if indexPath.row % 7 == 0{
            cell.dateLabel.textColor = .red
        } else if indexPath.row % 7 == 6{
            cell.dateLabel.textColor = .red
        } else {
            cell.dateLabel.textColor = .black
        }
        
        switch indexPath.section {
        case 0:
            cell.dateLabel.textColor = .black
            cell.dateLabel.text = yearAndMonth
            
        case 1:
            cell.dateLabel.textColor = .black
            cell.dateLabel.text = weeks[indexPath.row]
            
        default:
            cell.dateLabel.text = days[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 2:
            if days[indexPath.row] != "" {
                /// 아직 여행 시작 날짜가 선택 안되었으면
                if !selectCheck {
                    start = Int(days[indexPath.row])!
                    selectCheck = true
                
                } else {
                    /// 여행 시작 날짜가 선택되었으면
                    end = Int(days[indexPath.row])!
                    /// 여행 시작일이 종료일보다 뒤에 있으면 ex) 시작일: 21일, 종료일: 3일
                    if end < start {
                        start = end
                        end = -1
                        selectCheck = true
                    } else {
                        selectCheck = false
                        print("시작: \(start), 끝: \(end)")
                    }
                }
            }
            
        default:
            return
        }
    }
}

extension CalendarTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let myBoundSize: CGFloat = UIScreen.main.bounds.size.width
        
        switch indexPath.section {
        case 0:
            let cellSize: CGFloat = myBoundSize
            return CGSize(width: cellSize, height: cellSize/9)
        default:
            let cellSize: CGFloat = myBoundSize/9
            return CGSize(width: cellSize, height: cellSize)
        }
        
    }
}
