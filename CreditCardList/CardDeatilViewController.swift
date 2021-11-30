//
//  CardDeatilViewController.swift
//  CreditCardList
//
//  Created by 장기화 on 2021/11/29.
//

import UIKit
import Lottie

class CardDeatilViewController: UIViewController {

    var promotionDetail: PromotionDetail?
    
    @IBOutlet weak var lottieView: LottieView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var benefitConditionLabel: UILabel!
    @IBOutlet weak var benefitDetailLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let animationView = AnimationView(name: "money")
        lottieView.contentMode = .scaleAspectFit
        lottieView.addSubview(animationView)
        animationView.frame = lottieView.bounds
        animationView.loopMode = .loop
        animationView.play(completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let promotionDetail = promotionDetail else { return }
        titleLabel.text = """
        \(promotionDetail.companyName)카드 쓰면
        \(promotionDetail.amount)만원 드려요.
        """
        
        periodLabel.text = promotionDetail.period
        conditionLabel.text = promotionDetail.condition
        benefitConditionLabel.text = promotionDetail.benefitCondition
        benefitDetailLabel.text = promotionDetail.benefitDetail
        dateLabel.text = promotionDetail.benefitDate
    }

}
