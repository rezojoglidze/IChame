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
            MenuItem(description: "გემრიელი, წვნიანი ღორის მწვადი", name: "მწვადი", price: 7, type: MenuType(rawValue: "hotDishes")!),
            MenuItem(description: "ქალაქური ხინკალი, 1 ცალი 250 გრამი", name: "ხინკალი", price: 0.80, type: MenuType(rawValue: "hotDishes")!),
            MenuItem(description: "შემწვარი სოკოო, კეცზე!", name: "სოკო", price: 14.5, type: MenuType(rawValue: "hotDishes")!),
            MenuItem(description: "კავკასიური ხაშლამა, გაკეთებულია ხბოს ხორცისგან", name: "ხაშლამა", price: 7.5, type: MenuType(rawValue: "hotDishes")!)
        ], coldDishes: [
            MenuItem(description: "ინდაურის საცივი", name: "საცივი", price: 12, type: MenuType(rawValue: "coldDishes")!),
            MenuItem(description: "ბოსტნეირულის, ჯანსაღი, სუფთა გემრიელი სალათა", name: "სალათა", price: 11, type: MenuType(rawValue: "coldDishes")!),
        ], drinks: [
            MenuItem(description: "ქართული წარმოების კოკა-კოლა", name: "კოკა-კოლა", price: 2.5, type: MenuType(rawValue: "drinks")!),
            MenuItem(description: "ქართული წარმოების განტა", name: "ფანტა", price: 2.8, type: MenuType(rawValue: "drinks")!),
            MenuItem(description: "სპრაიტი ლიტრიანი", name: "სპრაიტი", price: 1.75, type: MenuType(rawValue: "drinks")!),
            MenuItem(description: "ლიტრიანი ბოთლით ცივი ჩაი", name: "ცივი ჩაი", price: 3.8, type: MenuType(rawValue: "drinks")!)
        ], sauce: [
            MenuItem(description: "პომიდვრის კარგი სოუსი არისს", name: "პომიდვრის სოუსი", price: 0.8, type: MenuType(rawValue: "sauce")!),
            MenuItem(description: "სოფლის ტყემალი", name: "წყემალი", price: 1.7, type: MenuType(rawValue: "sauce")!),
            MenuItem(description: "მეგრული აჯიკა", name: "აჯიკა", price: 1.2, type: MenuType(rawValue: "sauce")!)
        ], menuId: "menuId-\(id)")
        
        do {
            try db.collection(Constants.menuiOS).document(id).setData(from: menu)
        } catch let error {
            print("Error writing city to Firestore: \(error)")
        }
    }
}
