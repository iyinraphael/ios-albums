//
//  AlbumController.swift
//  iOS Albums
//
//  Created by Iyin Raphael on 1/29/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import Foundation

class AlbumController{
    
    
    func testDecodingExample() {
        let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
        let dataURl  = try! Data(contentsOf: url)
        let album = try! JSONDecoder().decode(Album.self, from: dataURl)
        let encodeAlbum = try! JSONEncoder().encode(album)
        print("\(encodeAlbum)")
        
    }
    
    let baseURL = URL(string: "https://journal-coredata-3d3fc.firebaseio.com/")!
    var albums: [Album] = []
    
    typealias CompletionHandler = (Error?) -> Void
    
    func getAlbum(complettion: @escaping CompletionHandler = {_ in }){
        
        let url = baseURL.appendingPathExtension("json")
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            
            guard let data = data else {
                NSLog("Data could not be fetched from firbase\(String(describing: error))")
                complettion(error)
                return
            }
            
            if let error = error {
                NSLog("Error occured when trying to get data\(String(describing: error))")
                complettion(error)
            }
            do {
                let albumArray = try JSONDecoder().decode([String : Album].self, from: data).values.map {$0}
                self.albums = albumArray
                complettion(nil)
            }catch{
                NSLog("Error occured when trying to get decode\(String(describing: error))")
                complettion(error)
                return
            }
            
        }.resume()
        
    }
    
    
    func put(album: Album, completion: @escaping CompletionHandler = {_ in }){
        
        let url = baseURL.appendingPathExtension("json")
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PUT"
        
        do {
            urlRequest.httpBody = try JSONEncoder().encode(album)
        }catch{
            NSLog("Error encoding movie data to JSON: \(error)")
            completion(nil)
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (_, _, error) in
            if let error = error {
                NSLog("Error Sending album to Firebase\(error)")
            }
            completion(nil)
        }.resume()
    }
    
}

extension AlbumController {
    
    
}
