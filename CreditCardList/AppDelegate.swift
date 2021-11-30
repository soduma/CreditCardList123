//
//  AppDelegate.swift
//  CreditCardList
//
//  Created by 장기화 on 2021/11/29.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        let db = Firestore.firestore()
        db.collection("creditCardList").getDocuments { snapshot, _ in
            guard snapshot?.isEmpty == true else { return }
            let batch = db.batch()
            
            let card0ref = db.collection("creditCardList").document("card0")
            let card1ref = db.collection("creditCardList").document("card1")
            let card2ref = db.collection("creditCardList").document("card2")
            let card3ref = db.collection("creditCardList").document("card3")
            let card4ref = db.collection("creditCardList").document("card4")
            let card5ref = db.collection("creditCardList").document("card5")
            let card6ref = db.collection("creditCardList").document("card6")
            let card7ref = db.collection("creditCardList").document("card7")
            let card8ref = db.collection("creditCardList").document("card8")
            let card9ref = db.collection("creditCardList").document("card9")
            
            do {
                try batch.setData(from: CreditCardDummy.card0, forDocument: card0ref)
                try batch.setData(from: CreditCardDummy.card1, forDocument: card1ref)
                try batch.setData(from: CreditCardDummy.card2, forDocument: card2ref)
                try batch.setData(from: CreditCardDummy.card3, forDocument: card3ref)
                try batch.setData(from: CreditCardDummy.card4, forDocument: card4ref)
                try batch.setData(from: CreditCardDummy.card5, forDocument: card5ref)
                try batch.setData(from: CreditCardDummy.card6, forDocument: card6ref)
                try batch.setData(from: CreditCardDummy.card7, forDocument: card7ref)
                try batch.setData(from: CreditCardDummy.card8, forDocument: card8ref)
                try batch.setData(from: CreditCardDummy.card9, forDocument: card9ref)

            } catch let error {
                print("firestore error! \(error.localizedDescription)")
            }
            batch.commit()
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

