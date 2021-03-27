//
//  ScannerService.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/17/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class MenuService {
    
    lazy private var db = Firestore.firestore()
    
    func getMenu(docId: String, success: @escaping (Menu?) -> Void, fail: @escaping Network.StatusBlock) {
        let docRef = db.collection(Constants.menuiOS).document(docId)
//        loadData(id: docId)
        
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
            MenuItem(id: "3685f1cc", description: "გემრიელი, წვნიანი ღორის მწვადი", name: "მწვადი", price: 7, count: 0, type: MenuType(rawValue: "hotDishes")!),
            MenuItem(id: "b43d93bc", description: "ქალაქური ხინკალი, 1 ცალი 250 გრამი", name: "ხინკალი", price: 0.80, count: 0, type: MenuType(rawValue: "hotDishes")!),
            MenuItem(id: "56f1b78b", description: "შემწვარი სოკოო, კეცზე!", name: "სოკო", price: 14.5, count: 0, type: MenuType(rawValue: "hotDishes")!),
            MenuItem(id: "3386b23b", description: "კავკასიური ხაშლამა, გაკეთებულია ხბოს ხორცისგან", name: "ხაშლამა", price: 7.5, count: 0, type: MenuType(rawValue: "hotDishes")!)
        ], coldDishes: [
            MenuItem(id: "4b775297", description: "ინდაურის საცივი", name: "საცივი", price: 12, count: 0, type: MenuType(rawValue: "coldDishes")!),
            MenuItem(id: "4b0a3a3e", description: "ბოსტნეირულის, ჯანსაღი, სუფთა გემრიელი სალათა", name: "სალათა", price: 11, count: 0, type: MenuType(rawValue: "coldDishes")!),
        ], drinks: [
            MenuItem(id: "713316ea", description: "ქართული წარმოების კოკა-კოლა", name: "კოკა-კოლა", price: 2.5, count: 0, type: MenuType(rawValue: "drinks")!),
            MenuItem(id: "652be5fe", description: "ქართული წარმოების განტა", name: "ფანტა", price: 2.8, count: 0, type: MenuType(rawValue: "drinks")!),
            MenuItem(id: "642a73cd", description: "სპრაიტი ლიტრიანი", name: "სპრაიტი", price: 1.75, count: 0, type: MenuType(rawValue: "drinks")!),
            MenuItem(id: "c9cf4556", description: "ლიტრიანი ბოთლით ცივი ჩაი", name: "ცივი ჩაი", price: 3.8, count: 0, type: MenuType(rawValue: "drinks")!)
        ], sauce: [
            MenuItem(id: "e28e248c", description: "პომიდვრის კარგი სოუსი არისს", name: "პომიდვრის სოუსი", price: 0.8, count: 0, type: MenuType(rawValue: "sauces")!),
            MenuItem(id: "3c935f1b", description: "სოფლის ტყემალი", name: "წყემალი", price: 1.7, count: 0, type: MenuType(rawValue: "sauces")!),
            MenuItem(id: "d2a5bd8b", description: "მეგრული აჯიკა", name: "აჯიკა", price: 1.2, count: 0, type: MenuType(rawValue: "sauces")!)
        ], menuId: "menuId-\(id)")
        
        do {
            try db.collection(Constants.menuiOS).document(id).setData(from: menu)
        } catch let error {
            print("Error writing city to Firestore: \(error)")
        }
    }
}
