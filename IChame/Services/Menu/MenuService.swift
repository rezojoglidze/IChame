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
        let docRef = db.collection(Constants.menuiOS).document(docId)
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
            MenuItem(description: "გემრიელი, ღორის მწვადი", name: "მწვადი", price: 7, type: MenuType(rawValue: "hotDishes")!),
            MenuItem(description: "ქალაქური ხინკალი", name: "ხინკალი", price: 0.80, type: MenuType(rawValue: "hotDishes")!),
            MenuItem(description: "შემწვარი სოკოო", name: "სოკო", price: 14, type: MenuType(rawValue: "hotDishes")!),
        ], coldDishes: [
            MenuItem(description: "ინდაურის საცივი", name: "საცივი", price: 12, type: MenuType(rawValue: "coldDishes")!),
            MenuItem(description: "ბოსტნეირული გემრიელი სალათა", name: "სალათა", price: 11, type: MenuType(rawValue: "coldDishes")!),
        ], drinks: [
            MenuItem(description: "ქართული წარმოების კოკა-კოლა", name: "კოკა-კოლა", price: 2.5, type: MenuType(rawValue: "drinks")!),
            MenuItem(description: "ქართული წარმოების განტა", name: "ფანტა", price: 2.8, type: MenuType(rawValue: "drinks")!)
        ], sauce: [
            MenuItem(description: "პომიდვრის კარგი სოისი არისს", name: "პომიდვრის სოუსი", price: 3.4, type: MenuType(rawValue: "sauce")!)
        ], menuId: "dsada")
        
        do {
            try db.collection(Constants.menuiOS).document(id).setData(from: menu)
        } catch let error {
            print("Error writing city to Firestore: \(error)")
        }
    }
}
