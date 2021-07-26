//
//  OnboardingViewController.swift
//  OnboardingSample
//
//  Created by taehy.k on 2021/07/26.
//

import UIKit

class OnboardingViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var onboardingCollectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK: - Properties
    var onboardingData: [OnboardingDataModel] = []
    var currentPage: Int = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == onboardingData.count - 1 {
                nextButton.setTitle("Start", for: .normal)
            } else {
                nextButton.setTitle("Next", for: .normal)
            }
        }
    }

    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setCollectionView()
        setOnboardingData()
    }
    
    // MARK: - Actions
    @IBAction private func nextButtonTapped(_ sender: Any) {
        if currentPage == onboardingData.count - 1 {
            print("go to main")
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            onboardingCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

// MARK: - Custom Functions
extension OnboardingViewController {
    private func setUI() {
        nextButton.layer.cornerRadius = 10
        pageControl.isUserInteractionEnabled = false
    }
    
    private func setCollectionView() {
        onboardingCollectionView.delegate = self
        onboardingCollectionView.dataSource = self
        
        let onboardingNib = UINib(nibName: OnboardingCollectionViewCell.cellId, bundle: nil)
        onboardingCollectionView.register(onboardingNib, forCellWithReuseIdentifier: OnboardingCollectionViewCell.cellId)
    }
    
    private func setOnboardingData() {
        onboardingData.append(contentsOf: [
            OnboardingDataModel(lottieName: "onboarding1_img",
                                title: "여행을 떠나볼까요?",
                                description: "여행을 생성하거나 참여 코드를 입력하여\n새로운 여행을 시작하세요"),
            OnboardingDataModel(lottieName: "onboarding2_img",
                                title: "우리다운 여행을 만들어요",
                                description: "유형 테스트로 여행 스타일을 파악하고,\n보드에서 소통하며 서로를 알아갈 수 있어요"),
            OnboardingDataModel(lottieName: "onboarding3_img",
                                title: "함께 여행을 만들어요",
                                description: "여행 정보를 입력하고 실시간으로 공유하여\n일정을 체계적으로 관리할 수 있어요")
        ])
    }
}

// MARK: - CollectionView Delegate, DataSource
extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onboardingData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = onboardingCollectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.cellId, for: indexPath) as? OnboardingCollectionViewCell else { return UICollectionViewCell() }
        cell.setOnboardingSlides(onboardingData[indexPath.row])
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}

// MARK: - CollectionView Delegate Flow Layout
extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
