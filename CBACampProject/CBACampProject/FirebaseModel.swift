//
//  FirebaseModel.swift
//  practice2
//
//  Created by 우아테크캠프_4 on 2018. 7. 28..
//  Copyright © 2018년 CBA. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class FirebaseModel {
    static var messages = [Message]()
    func getMessages() {
        var ref: DatabaseReference!
        print("trying to get messages....")
        
        ref = Database.database().reference().child("messages")
//        ref.queryOrderedByKey().observe(DataEventType.value) { (snapshot) in
//            print(snapshot.children.allObjects)
//        }
        ref.queryOrderedByKey().observe(DataEventType.value, with: { (snapshot) in
            if let result = snapshot.children.allObjects as? [DataSnapshot]{
                FirebaseModel.messages = []
                for child in result {
                    let snapshotValue = child.value as! [String: AnyObject]
                    let message = snapshotValue["message"] as? String ?? ""
                    let time = snapshotValue["time"] as? String ?? ""
                    print(message)
                    FirebaseModel.messages.append(Message(text: message, time: time))
                }
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "got messages"), object: self)
            }
        })
    }
}
