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
        print(album)
        
    }
    
    
    
}
