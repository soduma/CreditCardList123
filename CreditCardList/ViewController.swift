//
//  ViewController.swift
//  CreditCardList
//
//  Created by 장기화 on 2021/11/29.
//

import UIKit
import Kingfisher

class ViewController: UITableViewController {

    var creditCardList: [CreditCard] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nibName = UINib(nibName: "CardListCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "CardListCell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creditCardList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CardListCell", for: indexPath) as? CardListCell else { return UITableViewCell() }
        cell.rankLabel.text = "\(creditCardList[indexPath.row].rank)위"
        cell.promotionLabel.text = "\(creditCardList[indexPath.row].promotionDetail.amount)만원 증정"
        cell.cardNameLabel.text = "\(creditCardList[indexPath.row].name)"
        
        let url = URL(string: (creditCardList[indexPath.row].cardImageURL))
        cell.cardImageView.kf.setImage(with: url)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let CardDetailViewController = storyboard?.instantiateViewController(withIdentifier: "CardDeatilViewController") as? CardDeatilViewController else { return }
        CardDetailViewController.promotionDetail = creditCardList[indexPath.row].promotionDetail
        show(CardDetailViewController, sender: nil)
    }
}

