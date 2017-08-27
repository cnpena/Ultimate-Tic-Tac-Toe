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
    var activePlayer = 1 //player 1 = x, player 2 = o (initially x)
    var gameIsActive = true //true while game is playing, false when player wins or draws
    //var gameState = [[Int]](repeating: [Int](repeating: 0, count: 9), count: 9)
    var gameState = [Int](repeating: 0, count: 81)
    let winningBoards = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    
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
        let square = indexPath.row
        var board = Int()
        
        if(square < 27){
            if(square%9 < 3){
                board = 1
            }else if(square%9 < 6){
                board = 2
            }else{
                board = 3
            }
        }else if(square < 54){
            if(square%9 < 3){
                board = 4
            }else if(square%9 < 6){
                board = 5
            }else{
                board = 6
            }
        }else{
            if(square%9 < 3){
                board = 7
            }else if(square%9 < 6){
                board = 8
            }else{
                board = 9
            }
        }
        
        if(gameState[square] == 0 && gameIsActive){
            gameState[square] = activePlayer
            
            if(activePlayer == 1){
                cell.marker.image = #imageLiteral(resourceName: "x") //set image inside square based on game design the user chose initially
                activePlayer = 2 //switch active player to player 2
            }else{
                cell.marker.image = #imageLiteral(resourceName: "o") //set image inside square based on game design the user chose initially
                activePlayer = 1 //switch active player to player 1
            }
        }
    }

}

