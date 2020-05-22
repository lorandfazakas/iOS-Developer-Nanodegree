//
//  SentMemesTableViewController.swift
//  MemeV1
//
//  Created by Fazakas Loránd on 2020. 04. 10..
//  Copyright © 2020. Lorand Fazakas. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController {
    
    var memes: [Meme]! {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableCell")!
        cell.imageView!.image = memes[indexPath.row].memedImage
        cell.textLabel!.text = memes[indexPath.row].topText + " " + memes[indexPath.row].bottomText
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128.0
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailViewController.memeImage = memes[indexPath.row].memedImage
        self.navigationController!.pushViewController(detailViewController, animated: true)
    }

}
