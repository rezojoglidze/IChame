//
//  More.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/27/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation

struct Field {
    var icon: String
    var title: String
    var type: FieldType
}

enum FieldType {
    case logout
}

class More {
    var fields: [Field] = []
    
    init() {
        self.fields.append(Field(icon: "logout_icon", title: "გასვლა", type: .logout))
    }
}
