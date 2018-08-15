//
//  NoteCell.swift
//  Cage
//
//  Created by Andy Madsen on 8/15/18.
//  Copyright © 2018 Madsen, Andy. All rights reserved.
//

import UIKit

protocol NoteCellDelegate {
    func didViewMore(title: String)
}

class NoteCell: UITableViewCell {
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var noteButton: UIButton!
    
    var noteItem: Movie!
    var delegate: NoteCellDelegate?
    
    func setNote(note: Movie) {
        self.noteItem = note
        noteLabel.text = note.title
    }
    
    @IBAction func viewMoreTouched(_ sender: Any) {
        delegate?.didViewMore(title: noteItem.title)
    }
    
}
