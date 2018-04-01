//
//  ChatViewController.swift
//  TutorBoard
//
//  Created by Adrian on 3/25/18.
//  Copyright © 2018 Mei. All rights reserved.
//

import UIKit
import CoreData
import JSQMessagesViewController

class ChatViewController: JSQMessagesViewController {
    
    //sender and receiver's ID initialization
    var receiver: String!
    var sender = FirebaseManager().userID()
    //profile info
    var senderInfo: Tutor!
    var receiverInfo: Tutor!
    //conversation id initialization
    var conversationID = ""

    // TODO all messages here, use coredata later
    var messages = [JSQMessage]()
    
    var isSenderDataReady = false
    var isReceiverDataReady = false
}

extension ChatViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hide the tabbar for full screen
        self.tabBarController?.tabBar.isHidden = true
        
        //nav title
        setup()
        
        self.messages = getMessages()
    }
    
    //display the tab bar
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func setup() {
        // tell JSQMessagesViewController who is the current user
        //fetch detial about sender and receiver
        self.senderId = sender
        
        //sender's Info
        senderInfo = CoreDataManager().fetchSingleUser(userid: sender, completion: {(isFinished) in
            if isFinished == true {                
                self.isSenderDataReady = true
            }
        })
        
        //receiver's Info
        receiverInfo = CoreDataManager().fetchSingleUser(userid: receiver, completion: {(isFinished) in
            if isFinished == true {
                self.isReceiverDataReady = true
            }
        })
        
        if isSenderDataReady == true {
            self.senderDisplayName = self.senderInfo.firstname!
        }
        
        if isReceiverDataReady == true {
            //setup the title of the view
            self.title = self.receiverInfo.firstname
        }
        
        //create a conversation at the very beginning
        createConversation()
    }
    
    // important
    //create a conversation (later will save all messages into this conversation)
    func createConversation() {
        if(sender > receiver) {
            conversationID = sender + receiver
        } else {
            conversationID = receiver + sender
        }
        CoreDataManager().setupConversation(conversationID: conversationID, userid: sender)
    }
    
    
}


extension ChatViewController {
    // Important
    //load all of the conversation messages from core data to display on UI
    func getMessages() -> [JSQMessage] {
        var messages = [JSQMessage]()
        
        //download messages from database
        FirebaseManager().fetchMessages(conversationID: conversationID, completion: {(snapshot_dict) -> () in
            
            
            //yee
            //save each new message in CoreData for UI display
            CoreDataManager().saveMessage(messageData: snapshot_dict as NSDictionary, conversationID: self.conversationID)
        })
        
        
        //fetch entire conveersation
        let conversation = CoreDataManager().fetchSingleConversation(conversationID: conversationID)
        //parse result to Array
        let messageArray = conversation.message!.array as! [Message] //ordered
        //let messageArray = conversation.message!.allObjects as! [Message] //NSSet
        
        //append all messages for display later
        for msg in messageArray {
            let message = MessageModel().CoreDatatoJSQMessage(data: msg)
            messages.append(message)
            print(message)
        }
        return messages
    }
}





//Important
// MARK: - Configure JSQMessagesCollectionView
extension ChatViewController {
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {

        let message = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text)
        
        //okay to append directly to messages[]
        messages.append(message!)
        
        //save each new message in CoreData for UI display
        CoreDataManager().saveMessage(messageData: MessageModel().JSQMessageToDictionary(JSQmsg: message!) as NSDictionary, conversationID: conversationID)

        //upload messages to firebase so peer client can download the same message
        FirebaseManager().UploadChatMessage(conversationID: conversationID, message: MessageModel().JSQMessageToDictionary(JSQmsg: message!))
        
        finishSendingMessage()
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString! {
        let message = messages[indexPath.row]
        let messageUsername = message.senderDisplayName
        
        return NSAttributedString(string: messageUsername!)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat {
        return 15
    }
    
    //TODO
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let bubbleFactory = JSQMessagesBubbleImageFactory()
        
        let message = messages[indexPath.row]
        
        if sender == message.senderId {
            return bubbleFactory?.outgoingMessagesBubbleImage(with: .green)
        } else {
            return bubbleFactory?.incomingMessagesBubbleImage(with: .blue)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.row]
    }
}


