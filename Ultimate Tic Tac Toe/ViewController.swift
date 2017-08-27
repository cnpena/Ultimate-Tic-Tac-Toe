//
//  ViewController.swift
//  Ultimate Tic Tac Toe
//
//  Created by Celine Pena on 8/26/17.
//  Copyright © 2017 Celine Pena. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var board: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.board.dataSource = self
        self.board.delegate = self
        board.allowsMultipleSelection = true
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 81
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "board", for: indexPath) as! boardCell
        return cell
    }
    
    //UI: Collection View function that determines the size of the user cards
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        let cellWidth = view.bounds.size.width/9
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! boardCell
        cell.marker.image = #imageLiteral(resourceName: "x")
    }


}

