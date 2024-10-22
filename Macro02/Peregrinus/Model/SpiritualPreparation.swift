//
//  PreparatoryPrayerModel.swift
//  Macro02
//
//  Created by Giovanni Favorin de Melo on 23/09/24.
//

import Foundation

struct ExaminationQuestion {
    let question: String
    var isAnswered: Bool = false
}

class SpiritualPreparation {
    let preparatoryPrayer: Prayer
    let actOfContrition: Prayer
    var examinationQuestions: [ExaminationQuestion]

    init(preparatoryPrayer: Prayer, actOfContrition: Prayer, examinationQuestions: [ExaminationQuestion]) {
        self.preparatoryPrayer = preparatoryPrayer
        self.actOfContrition = actOfContrition
        self.examinationQuestions = examinationQuestions
    }
    
    func answerQuestion(at index: Int) {
        guard index >= 0 && index < examinationQuestions.count else { return }
        examinationQuestions[index].isAnswered = true
    }
}
