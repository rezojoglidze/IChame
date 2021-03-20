//
//  ScannerService.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/17/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class MenuService {
    
    lazy private var db = Firestore.firestore()
    
    func getMenu(docId: String, success: @escaping (Menu?) -> Void, fail: @escaping Network.StatusBlock) {
        let docRef = db.collection(Constants.menu).document(docId)
        loadData(id: docId)
        
        docRef.getDocument {(document, error) in
            let result = Result {
                try document?.data(as: Menu.self)
            }
            switch result {
            case .success(let menu):
                success(menu)
            case .failure(let error):
                fail(error)
            }
        }
    }
    
    func loadData(id: String) {
        
        let menu = Menu(hotDishes: [
            MenuItem(description: "mwvadii nice", name: "mwvadii", price: 32, type: MenuType(rawValue: "hotDishes")!)
        ], coldDishes: [
            MenuItem(description: "kababai decc", name: "kababai", price: 22, type: MenuType(rawValue: "coldDishes")!),
            MenuItem(description: "xinakla desc", name: "xinakla", price: 112, type: MenuType(rawValue: "coldDishes")!),
        ], drinks: [
            MenuItem(description: "colaa descc", name: "colaa", price: 12, type: MenuType(rawValue: "drinks")!)
        ], sauce: [
            MenuItem(description: "sauceee descc", name: "sauceee", price: 42, type: MenuType(rawValue: "sauce")!)
        ], menuId: "dsada")
        
        
        do {
            try db.collection("menu_iOS").document(id).setData(from: menu)
        } catch let error {
            print("Error writing city to Firestore: \(error)")
        }
    }
}
