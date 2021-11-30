//
//  ViewController.swift
//  CreditCardList
//
//  Created by 장기화 on 2021/11/29.
//

import UIKit
import Kingfisher
import Firebase
import FirebaseFirestore

class ViewController: UITableViewController {

    var creditCardList: [CreditCard] = []
//    var ref: DatabaseReference!
    var db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nibName = UINib(nibName: "CardListCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "CardListCell")
        
        //realtime
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
        
        //firestore
        db.collection("creditCardList").addSnapshotListener { snapshot, error in
            guard let document = snapshot?.documents else {
                print("error firestore fetch document: \(String(describing: error))")
                return
            }
            
            self.creditCardList = document.compactMap { doc -> CreditCard? in
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: doc.data(), options: [])
                    let creditCard = try JSONDecoder().decode(CreditCard.self, from: jsonData)
                    return creditCard
                    
                } catch let error {
                    print("error json parsing: \(error.localizedDescription)")
                    return nil
                }
            }.sorted { $0.rank < $1.rank }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
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
        
        //realtime 쓰기
//        let cardID = creditCardList[indexPath.row].id
        //option1 경로를 알 때
//        ref.child("Item\(cardID)/isSelected").setValue(true)
        
        //option2 경로를 모를 때
//        ref.queryOrdered(byChild: "id").queryEqual(toValue: cardID).observe(.value) { [weak self] snapshot in
//            guard let self = self,
//                  let value = snapshot.value as? [String: [String: Any]],
//                  let key = value.keys.first else { return }
//            print(value.keys)
//            print(value.keys.first)
//            self.ref.child("\(key)/isSelected").setValue(true)
//        }
        
        //firestore 쓰기
        //option1
//        let cardID = creditCardList[indexPath.row].id
//        db.collection("creditCardList").document("card\(cardID)").updateData(["isSelected": true])
        
        //option2
        let cardID = creditCardList[indexPath.row].id
        db.collection("creditCardList").whereField("id", isEqualTo: cardID).getDocuments { snapshot, _ in
            guard let document = snapshot?.documents.first else {
                print("error fetch firestore document")
                return
            }
            document.reference.updateData(["isSelected": true])
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //realtime 삭제
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
            
            //firestore 삭제
            //option1
            let cardID = creditCardList[indexPath.row].id
            db.collection("creditCardList").document("card\(cardID)").delete()
            
            //option2
            db.collection("creditCardList").whereField("id", isEqualTo: cardID).getDocuments { snapshot, _ in
                guard let document = snapshot?.documents.first else {
                    print("error")
                    return
                }
                
                document.reference.delete()
            }
        }
    }
}

