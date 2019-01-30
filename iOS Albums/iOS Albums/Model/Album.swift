//
//  Album.swift
//  iOS Albums
//
//  Created by Iyin Raphael on 1/28/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import Foundation

struct Album: Codable {
    
    enum CodingKeys: String, CodingKey {
        case artist
        case name
        case genres
        case coverArt
        case songs
        
        enum coverURl: String, CodingKey {
            case url
        }
        
    }
    
    var artist: String
    var album: String
    var genres: [String]
    var coverArt: [URL]
    var songs: [Songs]
    
    init(artist: String, album: String, genres: [String], coverArt: [URL], songs: [Songs]){
        self.artist = artist
        self.album = album
        self.genres = genres
        self.coverArt = coverArt
        self.songs = songs
    }
    
    init(from decoder: Decoder) throws {
      
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        artist = try container.decode(String.self, forKey: .artist)
        album = try container.decode(String.self, forKey: .name)
        genres = try container.decode([String].self, forKey: .genres)
        
        var coverContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        var cover: [URL] = []
        
        while coverContainer.isAtEnd == false {
            let urlCover = try coverContainer.nestedContainer(keyedBy: CodingKeys.coverURl.self)
            let coverString = try urlCover.decode(String.self, forKey: .url)
            if let coverURl = URL(string: coverString){
                cover.append(coverURl)
            }
        }
         coverArt = cover
        
        var songContainer = try container.nestedUnkeyedContainer(forKey: .songs)
        var songs: [Songs] = []
        while songContainer.isAtEnd == false {
            let song = try songContainer.decode(Songs.self)
            songs.append(song)
        }
        self.songs = songs
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(artist, forKey: .artist)
        try container.encode(album, forKey: .name)
        try container.encode(genres, forKey: .genres)
        try container.encode(coverArt, forKey: .coverArt)
        
        var songContainer = container.nestedUnkeyedContainer(forKey: .songs)
        for song in songs{
            try songContainer.encode(song.name)
            try songContainer.encode(song.duration)
        }
    }
}

struct Songs: Decodable {
    
        enum SongDuration: String, CodingKey {
            case duration
            case name
            
            enum NextDuration: String, CodingKey {
                case duration
            }
            enum NewName: String, CodingKey {
                case title
            }
        }
    
    let duration: String
    let name: String
    
    init(name: String, duration: String){
        self.name = name
        self.duration = duration
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongDuration.self )
        
        let nextDurationContainer = try container.nestedContainer(keyedBy: SongDuration.NextDuration.self, forKey: .duration)
        let duration =  try nextDurationContainer.decode(String.self, forKey: .duration)
        self.duration = duration
        
        let nameContainer = try container.nestedContainer(keyedBy: SongDuration.NewName.self, forKey: .name)
        let title = try nameContainer.decode(String.self, forKey: .title)
        self.name = title
        
    }
    
    
    
    
    
}
