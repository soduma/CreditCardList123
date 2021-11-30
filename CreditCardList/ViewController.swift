//
//  ViewController.swift
//  CreditCardList
//
//  Created by 장기화 on 2021/11/29.
//

import UIKit
import Kingfisher
import Firebase

class ViewController: UITableViewController {

    var creditCardList: [CreditCard] = []
//    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nibName = UINib(nibName: "CardListCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "CardListCell")
        
//        ref = Database.database().reference()
//        ref.observe(.value) { snapshot in
//            guard let value = snapshot.value as? [String: [String: Any]] else { return }
//
//            do {
//                let jsonData = try JSONSerialization.data(withJSONObject: value)
//                let cardData = try JSONDecoder().decode([String: CreditCard].self, from: jsonData)
//                let cardList = Array(cardData.values)
//                self.creditCardList = cardList.sorted { $0.rank < $1.rank }
//
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//
//            } catch let error {
//                print("error: \(error.localizedDescription)")
//            }
//        }
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let CardDetailViewController = storyboard?.instantiateViewController(withIdentifier: "CardDeatilViewController") as? CardDeatilViewController else { return }
        CardDetailViewController.promotionDetail = creditCardList[indexPath.row].promotionDetail
        show(CardDetailViewController, sender: nil)
        
        //isSelected
//        let cardID = creditCardList[indexPath.row].id
        //option1
//        ref.child("Item\(cardID)/isSelected").setValue(true)
        
        //option2
//        ref.queryOrdered(byChild: "id").queryEqual(toValue: cardID).observe(.value) { [weak self] snapshot in
//            guard let self = self,
//                  let value = snapshot.value as? [String: [String: Any]],
//                  let key = value.keys.first else { return }
//            print(value.keys)
//            print(value.keys.first)
//            self.ref.child("\(key)/isSelected").setValue(true)
//        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //option1
//            let cardID = creditCardList[indexPath.row].id
//            ref.child("Item\(cardID)").removeValue()
            
            //option2
//            ref.queryOrdered(byChild: "id").queryEqual(toValue: cardID).observe(.value) { [weak self] snapshot in
//                guard let self = self,
//                      let value = snapshot.value as? [String: [String: Any]],
//                      let key = value.keys.first else { return }
//
//                self.ref.child(key).removeValue()
//            }
        }
    }
}

