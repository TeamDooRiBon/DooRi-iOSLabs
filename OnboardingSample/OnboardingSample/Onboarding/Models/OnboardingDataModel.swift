//
//  OnboardingDataModel.swift
//  OnboardingSample
//
//  Created by taehy.k on 2021/07/26.
//

import Foundation

struct OnboardingDataModel {
    var lottieName: String
    var title: String
    var description: String
    
    init(lottieName: String, title: String, description: String) {
        self.lottieName = lottieName
        self.title = title
        self.description = description
    }
}
