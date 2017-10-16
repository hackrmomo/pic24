//
//  FireVars.swift
//  pic24
//
//  Created by Mohammad Al-Ahdal on 2017-10-09.
//  Copyright © 2017 Mohammad Al-Ahdal. All rights reserved.
//

import Firebase

var currentUser:User = Auth.auth().currentUser!

var fs = Firestore.firestore()
var fsUsersCollection = fs.collection("users")
var fsCurrentUser = fsUsersCollection.document(currentUser.uid)

class FSUser {
    var uid:String
    var name: String
    var dateOfBirth: Date?
    var joinDate: Date?
    var username: String
    var theme: Int
    var score: Int
    var postsCollection: [String:FSPost]
    
    init(user: User) {
        self.uid = user.uid
        self.name = fsUsersCollection.document(user.uid).value(forKey: "name") as! String
        self.username = fsUsersCollection.document(user.uid).value(forKey: "username") as! String
        self.theme = 0x01
        self.score = 0xFF
        self.postsCollection = ["shite":FSPost(), "moom":FSPost()]
        if fsUsersCollection.document(user.uid).value(forKey: "joinDate") != nil {
            self.joinDate = fsUsersCollection.document(user.uid).value(forKey: "joinDate") as? Date
        }
        if fsUsersCollection.document(user.uid).value(forKey: "dateOfBirth") != nil {
            self.dateOfBirth = fsUsersCollection.document(user.uid).value(forKey: "dateOfBirth") as? Date
        }
    }
}

class FSPost {
    var pid: String
    var url: String
    var mediaType: String
    var timeOut: Int
    var dateOfPost: Date
    var commentsCollection: [String:FSComment]
    var reactionsCollection: [String:FSReaction]
    
    init() {
        self.pid = ""
        self.url = ""
        self.mediaType = "photo"
        self.timeOut = 1
        self.dateOfPost = Date.init()
        self.commentsCollection = ["":FSComment()]
        self.reactionsCollection = ["":FSReaction()]
    }
}

class FSReaction {
    var rid: String
    var uid: String
    var dateOfReaction: Date
    var reactionType: Int
    init() {
        self.rid = ""
        self.uid = ""
        self.dateOfReaction = Date.init()
        self.reactionType = 1
    }
}

class FSComment {
    var cid: String
    var uid: String
    var dateOfComment: Date
    var commentText: String
    var commentReactions: [String:FSCommentReaction]
    
    init() {
        self.cid = ""
        self.uid = ""
        self.dateOfComment = Date.init()
        self.commentText = "OHHHHHHHHHH"
        self.commentReactions = ["" : FSCommentReaction(CRID: "")]
    }
}

class FSCommentReaction {
    var crid: String
    var uid: String
    var dateOfCommentReaction: Date
    var reactionType: Int
    
    init(CRID: String) {
        self.crid = ""
        self.uid = ""
        self.dateOfCommentReaction = Date.init()
        self.reactionType = 1
    }
}
