//
//  AlbumsTableViewController.swift
//  iOS Albums
//
//  Created by Iyin Raphael on 1/28/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
    
    var albumController: AlbumController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        albumController?.getAlbum()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumController?.albums.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: " cell", for: indexPath)
        let album = albumController?.albums[indexPath.row]
        cell.textLabel?.text = album?.album
        cell.detailTextLabel?.text = album?.artist
        return cell
    }

   
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addDetail"{
            let detailVC = segue.destination as! AlbumDetailTableViewController
            detailVC.albumController = albumController
        }else if segue.identifier == "showDetal"{
            let detailVC = segue.destination as! AlbumDetailTableViewController
            guard let index = tableView.indexPathForSelectedRow else {return}
            let album = albumController?.albums[index.row]
            detailVC.album = album
        }
    }

}
