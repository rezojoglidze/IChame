//
//  BucketService.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/21/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class BucketService {
    lazy private var db = Firestore.firestore()
    
    func addDish(_ menuId: String, with menuItem: MenuItem, userId: String, index: Int,
                 success: @escaping (Bool) -> Void,
                 fail: @escaping Network.StatusBlock) {
        
        let item = ["\(menuItem.type.engTitle)" : ["\(index)" : menuItem]]
        
        do {
            try db.collection(Constants.bucketiOS).document(("\(menuId)_\(userId)")).setData(from: item, merge: true)
            success(true)
        } catch let error {
            fail(error)
        }
    }
    
    func removeDish(_ menuId: String, with menuItem: MenuItem, userId: String, index: Int,
                    success: @escaping (Bool) -> Void,
                    fail: @escaping Network.StatusBlock) {
        db.collection(Constants.bucketiOS).document(("\(menuId)_\(userId)")).updateData(
            ["\(menuItem.type.engTitle).\(index)" : FieldValue.delete()]
        ) { err in
            if let err = err {
                fail(err)
            } else {
                success(true)
            }
        }
    }
    
    func loadBucket(_ menuId: String, userId: String, success: @escaping (Bucket?) -> Void,fail: @escaping Network.StatusBlock) {
        db.collection(Constants.bucketiOS).document("\(menuId)_\(userId)")
            .addSnapshotListener { documentSnapshot, error in
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    fail(error)
                    return
                }
                
                let result = Result {
                    try document.data(as: Bucket.self)
                }
                switch result {
                case .success(let bucket):
                    success(bucket)
                case .failure(let error):
                    fail(error)
                }
            }
    }
}
