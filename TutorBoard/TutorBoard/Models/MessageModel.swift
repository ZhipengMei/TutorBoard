//
//  Message.swift
//  TutorBoard
//
//  Created by Adrian on 3/26/18.
//  Copyright © 2018 Mei. All rights reserved.
//

import Foundation
import JSQMessagesViewController

//Important class, parse JSQMessage back and forth to make life easier and code cleaner
class MessageModel {
    
    //parse JSQMessage to dictionary
    func JSQMessageToDictionary(JSQmsg: JSQMessage) -> Dictionary<String, Any>  {
        //TODO, warning: time conversion might affect the accuracy of the time, fix later
        
        //convert current time to NSNumber because Firebase doesnt not accept Date() 
        let timeStamp = NSNumber(value: Int(NSDate().timeIntervalSince1970))
        
        let dict_data = ["senderId": JSQmsg.senderId,
                         "senderDisplayName": JSQmsg.senderDisplayName,
                         "date": timeStamp,
                         "isMediaMessage": JSQmsg.isMediaMessage,
                         "uniqueid": "\(timeStamp)" + JSQmsg.senderId, //for avoid duplicate coredata check
                         "text": JSQmsg.text] as [String : Any]
                         //"media": JSQmsg.media] as [String : Any]  //TODO, add media later
        return dict_data
    }
    
    func CoreDatatoJSQMessage(data: Message) -> JSQMessage {
        //convert NSNumber to NSDate
        let msg_date = NSDate(timeIntervalSinceReferenceDate: Double(data.date)) as Date

        let message = JSQMessage(senderId: data.senderId, senderDisplayName: data.senderDisplayName, date: msg_date, text: data.text!)
        return message!
    }
    
    //convert NSDictionary to JSQMessage
    func NSDictionaryToJSQMessage(data: NSDictionary) -> JSQMessage {
        let msg_date = NSDate(timeIntervalSinceReferenceDate: Double(data["date"] as! Double)) as Date
        let message = JSQMessage(senderId: data["senderId"] as! String,
                                 senderDisplayName: data["senderDisplayName"] as! String,
                                 date: msg_date,
                                 text: data["text"] as! String)
        return message!
    }
    
}
