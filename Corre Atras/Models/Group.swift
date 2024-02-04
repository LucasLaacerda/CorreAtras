//
//  Group.swift
//  Corre Atras
//
//  Created by Lucas Lacerda on 03/02/24.
//

import Foundation
import CloudKit


struct Group {
    var recordID: CKRecord.ID?
    var name: String
    var members: [User]
    var leader: User?
}
