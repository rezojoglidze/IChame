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
    
    func getMenu(docId: String, success: @escaping (Menu?) -> Void, fail: @escaping Network.StatusBlock) {
        let db = Firestore.firestore()
        let docRef = db.collection("menu").document(docId)
        
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
}
