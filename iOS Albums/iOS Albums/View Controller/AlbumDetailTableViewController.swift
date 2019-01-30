//
//  AlbumDetailTableViewController.swift
//  iOS Albums
//
//  Created by Iyin Raphael on 1/28/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController, SongTableViewCellDelegate {
   
    func addSong(with title: String, duration: String) {
        let song = Songs(name: title, duration: duration)
        tempSongs.append(song)
        tableView.reloadData()
        
        tableView.scrollToRow(at: IndexPath.init(row: tempSongs.count, section: 0), at: .bottom, animated: true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    func updateView(){
        guard isViewLoaded else {return}
        if let album = album {
            albumTextField.text = album.album
            artistTextField.text = album.artist
            genreTextField.text = album.genres.joined(separator: ",")
            URLTextField.text = album.coverArt.joined(separator: ",")
            self.title = album.album
        }else{
            self.title = "New Album"
        }
        tempSongs = album?.songs ?? []
    }
    
    var tempSongs: [Songs] = []
    var albumController: AlbumController?
    var album: Album?{
        didSet{
            updateView()
        }
    }
    
    @IBOutlet weak var albumTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    @IBOutlet weak var URLTextField: UITextField!
    
    @IBAction func save(_ sender: Any) {
        guard let name = albumTextField.text,
        let artist = artistTextField.text,
        let genre = genreTextField.text,
            let coverURl = URLTextField.text else {return}
        
        if let album = album{
            albumController?.update(albumNew: album, artist: artist, album: name, genres: [genre], coverArt: [coverURl], songs: tempSongs)
        } else {
            albumController?.createAlbum(artist: artist, album: name, genres: [genre], coverArt: [coverURl], songs: tempSongs)
        }
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempSongs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! SongTableViewCell
        cell.delegate = self
        let song = tempSongs[indexPath.row]
        cell.song = song
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == tempSongs.count - 1 {
            return 140
        }
        return 100
    }

}
