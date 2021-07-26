//
//  OnboardingCollectionViewCell.swift
//  OnboardingSample
//
//  Created by taehy.k on 2021/07/26.
//

import UIKit

import SnapKit
import Lottie

class OnboardingCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    static let cellId = String(describing: OnboardingCollectionViewCell.self)
    
    private lazy var animationView = AnimationView()
    private var lottieName: String = ""

    // MARK: - IBOutlets
    @IBOutlet private weak var onboardingView: UIView!
    @IBOutlet private weak var onboardingTitleLabel: UILabel!
    @IBOutlet private weak var onboardingDescriptionLabel: UILabel!
    
    // MARK: - Life Cycles
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        // 해당 처리를 해준 이유가 계속 로티 이미지가 겹쳐서 생성되는 문제가 있었기 때문
        lottieName = ""
        animationView.stop()
    }

    // MARK: - Custom Functions
    func setOnboardingSlides(_ slides: OnboardingDataModel) {
        setAnimationView(slides.lottieName)
        onboardingTitleLabel.text = slides.title
        onboardingDescriptionLabel.text = slides.description
    }
    
    private func setAnimationView(_ lottieName: String) {
        animationView = AnimationView()
        animationView.frame = onboardingView.bounds
        animationView.animation = Animation.named(lottieName)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        onboardingView.addSubview(animationView)
    }
}
