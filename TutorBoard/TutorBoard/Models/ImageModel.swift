//
//  ImageModel.swift
//  TutorBoard
//
//  Created by Adrian on 3/30/18.
//  Copyright © 2018 Mei. All rights reserved.
//

import UIKit

class ImageModel {
    
    
    /*
     Asynchronously
     Create a method with a completion handler to get the image data from your url
     Create a method to download the image (start the task)
     */
    func downloadImage(_ uri : String, inView: UIImageView){
        
        let url = URL(string: uri)
        
        if url != nil {
            let task = URLSession.shared.dataTask(with: url!) {responseData,response,error in
                if error == nil{
                    if let data = responseData {
                        
                        DispatchQueue.main.async {
                            inView.image = UIImage(data: data)
                        }
                    }else {
                        print("no data")
                    }
                }else{
                    print(error!)
                }
            }
            task.resume()
        } else {
            print("Error: URL is nil")
        }
    }
    
    
    func fetchImage(_ uri : String, completion: @escaping (UIImage)->()) {
        let url = URL(string: uri)
        if url != nil {
            let task = URLSession.shared.dataTask(with: url!) {responseData,response,error in
                if error == nil{
                    if let data = responseData {
                        DispatchQueue.main.sync {
                            completion(UIImage(data: data)!)
                        }
                    }else {
                        print("no data")
                    }
                }else{
                    print(error!)
                }
            }
            task.resume()
        } else {
            print("Error: URL is nil")
        }
    }
    
}
