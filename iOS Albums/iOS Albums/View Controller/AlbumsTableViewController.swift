//
//  AlbumsTableViewController.swift
//  iOS Albums
//
//  Created by Iyin Raphael on 1/28/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)


        return cell
    }

   
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    }

}
