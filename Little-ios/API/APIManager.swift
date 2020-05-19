//
//  APIManager.swift
//  Little-ios
//
//  Created by 酒井ゆうき on 2020/05/09.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import Foundation


struct APIManager {
    
    static let shared = APIManager()
    
    //MARK: - fetch all broadcasts pagenation
    
    func allCastsRequest(page : Int = 1,completion : @escaping(Index?, Error?) -> Void) {
        
        let requestUrl = kALLCASTS_URL + "\(page)"
        guard let url = URL(string: requestUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else {return}
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
                completion(nil,error)
                return
            }
            
            do {
                guard let safedata = data else {return}
                let  decorder = JSONDecoder()
                let index = try decorder.decode(Index.self, from: safedata)
                completion(index,nil)
            }
            catch(let error) {
                print(error.localizedDescription)
            }
        }
        task.resume()
        
        
    }
    
//    MARK: - fetch One Broadcast
       
       func oneCastRequest(number : Int, completion : @escaping(Words?, Error?) -> Void) {

           let requestUrl = kONECAST_URL + "\(number)"

           guard let url = URL(string: requestUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else {return}

           let session = URLSession(configuration: .default)
           let task = session.dataTask(with: url) { (data, response, error) in

               if error != nil {
                   print(error!.localizedDescription)
                   completion(nil,error)
                   return
               }

               do {
                guard let safedata = data else {return}
                let  decorder = JSONDecoder()
                let words = try decorder.decode(Words.self, from: safedata)

                completion(words,nil)

               }
               catch(let error) {
                   print(error.localizedDescription)
               }

           }

           task.resume()
       }
    
    func getWords(number : Int = 1, wordType : WordType, completion :  @escaping(Word?, Error?) -> Void) {
        
        var requestUrl : String
        switch wordType {
        case .waka:
            requestUrl = kWAKA_WORDSURL + "\(number)"
        case .kasu :
            requestUrl = kKASU_WORDSURL + "\(number)"

        }
        
        guard let url = URL(string: requestUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else {return}
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print(error!.localizedDescription)
                completion(nil,error)
                return
            }
            
            do {
                guard let safedata = data else {return}
                let  decorder = JSONDecoder()
                let words = try decorder.decode(Word.self, from: safedata)
                
                completion(words,nil)
                
            }
            catch(let error) {
                print(error.localizedDescription)
            }
            
        }
        
        task.resume()
        
        
    }
    
    
    
}

//MARK: - Example
