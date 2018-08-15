//
//  ViewController.swift
//  Cage
//
//  Created by Madsen, Andy on 8/11/18.
//  Copyright © 2018 Madsen, Andy. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var blueBG: UIImageView!
    @IBOutlet weak var onBtn: UIButton!
    @IBOutlet weak var cloudHolder: UIView!
    @IBOutlet weak var rocket: UIImageView!
    @IBOutlet weak var hustleLbl: UILabel!
    @IBOutlet weak var onLbl: UILabel!
    
    var player: AVAudioPlayer!
    var notes: [Movie] = []
    
    fileprivate func showAlert(_ title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "hustle-on", ofType: "wav")!
        let url = URL(fileURLWithPath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            
        } catch let error as NSError {
            print(error.description)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        NetworkManager.getNewMovies(page: 1, completion: { movies in
            // self.notes = movies
            for movie in movies {
                self.notes.append(movie)
            }
            
            self.tableView.reloadData()
            self.showAlert("Movie Fetch", message: "DONE!!")
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func powerButtonPressed(_ sender: Any) {
        cloudHolder.isHidden = false
        blueBG.isHidden = true
        onBtn.isHidden = true
        
        player.play()
        
        UIView.animate(withDuration: 2.3, animations: {
            self.rocket.frame = CGRect(x: 0, y: 260, width: 378, height: 202)
        }) { (finished) in
            self.hustleLbl.isHidden = false
            self.onLbl.isHidden = false
        }
    }
}

extension ViewController: NoteCellDelegate {
    
    func didViewMore(title: String) {
        self.showAlert("Movie Click", message: title)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = notes[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell" ) as! NoteCell
        
        cell.setNote(note: note)
        cell.delegate = self
        
        return cell
    }
}
