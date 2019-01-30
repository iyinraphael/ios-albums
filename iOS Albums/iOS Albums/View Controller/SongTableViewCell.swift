//
//  SongTableViewCell.swift
//  iOS Albums
//
//  Created by Iyin Raphael on 1/28/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    weak var delegate: SongTableViewCellDelegate?
    var song: Songs?
    
    func updateView(){
        if let song = song {
            titleTextfield.text = song.name
            durationTextField.text = song.duration
            button.alpha = 0.0
        }
    }
    
    override func prepareForReuse() {
        titleTextfield.text = " "
        durationTextField.text = " "
        button.alpha = 1.0
    }
    
    
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var titleTextfield: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    
    @IBAction func addSongButton(_ sender: Any) {
        guard let title = titleTextfield.text,
        let duration = durationTextField.text else {return}
        
        delegate?.addSong(with: title, duration: duration)
    }
}


protocol SongTableViewCellDelegate: class {
    
    func addSong(with title: String, duration: String)
    
}
