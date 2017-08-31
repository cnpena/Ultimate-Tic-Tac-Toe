//
//  ViewController.swift
//  Ultimate Tic Tac Toe
//
//  Created by Celine Pena on 8/26/17.
//  Copyright © 2017 Celine Pena. All rights reserved.
//

import UIKit

class gameVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var displayWinnerLabel: UILabel!
    @IBOutlet weak var board: UICollectionView!
    @IBOutlet weak var playAgainButton: UIButton!
    var activePlayer = 1 //player 1 = x, player 2 = o (initially x)
    var gameIsActive = true //true while game is playing, false when player wins or draws
    var gameState = [[Int]](repeating: [Int](repeating: 0, count: 9), count: 9)
    var overallBoard = [0,0,0,0,0,0,0,0,0]
    var activeBoard = -1
    
    let winningBoards = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.board.dataSource = self
        self.board.delegate = self
        board.allowsMultipleSelection = true
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
    
    //called when the player taps any of the 81 squares on the screen
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! boardCell
        
        let square = indexPath.row
        let col = square%3
        let row = (square/9)%3
        let index = row*3+col
        let board = findBoard(square: square)
    
        //before placing a piece, check if the square is empty, the game is still active and this is the allowed board to work on (or this is the first turn)
        if(gameState[board][index] == 0 && gameIsActive && (board == activeBoard || activeBoard == -1)){
            gameState[board][index] = activePlayer //update gameState w/ 1 or 2 to indicate who placed their piece
            
            if let smallGame = self.view.viewWithTag(activeBoard+1) as? UIImageView { //clear the previous active board so it's no longer highlighted
                smallGame.backgroundColor = UIColor.clear
            }
            
            activeBoard = index //the new active board is the index selected in the smaller board
            
            if let smallGame = self.view.viewWithTag(activeBoard+1) as? UIImageView { //highlight the new active board
                    smallGame.backgroundColor = UIColor.yellow.withAlphaComponent(0.3)
            }
            
            if(activePlayer == 1){
                cell.marker.image = #imageLiteral(resourceName: "x") //place x in the square picked
                activePlayer = 2 //switch active player to player 2
            }else{
                cell.marker.image = #imageLiteral(resourceName: "o") //place o in the square picked
                activePlayer = 1 //switch active player to player 1
            }
        }
        
        for i in winningBoards{ //checks current board against winning combinations (in smaller board)
            if (gameState[board][i[0]] != 0 && gameState[board][i[0]] == gameState[board][i[1]] && gameState[board][i[1]] == gameState[board][i[2]]){ //someone has won smaller game
                
                overallBoard[board] = gameState[board][i[0]] //update overallBoard w/ 1 or 2 to indicate who won smaller board
                activeBoard = -1 //set active board to -1 so the player can choose any board
                
                if let smallGame = self.view.viewWithTag(board+1) as? UIImageView { //instead of smalller board, shows an X or O to show who won
                    if (overallBoard[board] == 1){
                        smallGame.image = #imageLiteral(resourceName: "x")
                    }else{
                        smallGame.image = #imageLiteral(resourceName: "o")
                    }
                }
                
                //check to see if anyone has won overall game (only needs to be called when someone wins a smaller game
                for x in winningBoards{ //checks current board against winning combinations (overall board)
                    if (overallBoard[x[0]] != 0 && overallBoard[x[0]] == overallBoard[x[1]] && overallBoard[x[1]] == overallBoard[x[2]]){ //someone has won overall game
                        
                        if(overallBoard[0] == 1){
                            displayWinnerLabel.text = "Player 1 wins!"
                        }else{
                            displayWinnerLabel.text = "Player 2 wins!"
                        }
                    
                        //someone has won, so show button to play again, game is no longer active
                        playAgainButton.isHidden = false
                        gameIsActive = false
                        return
                    }
                } //end for x in winningBoards()
            }
        } //end for i in winningBoards()
    }
    
    @IBAction func playAgain(_ sender: UIButton) {
        gameIsActive = true
        gameState = [[Int]](repeating: [Int](repeating: 0, count: 9), count: 9) //resets game Board
        playAgainButton.isHidden = true
        
        
        displayWinnerLabel.text = " "
        for i in 1 ... 9 {
            if let smallGame = self.view.viewWithTag(i) as? UIImageView { //instead of smalller board, shows an X or O to show who won
                
                    smallGame.image = #imageLiteral(resourceName: "board")
            }
        
        }
        overallBoard = [0,0,0,0,0,0,0,0,0]
            activePlayer = 1    // TODO: to loser goes first later
    }
    
    func findBoard(square: Int) -> Int{
        if(square < 27){
            if(square%9 < 3){
                return 0
            }else if(square%9 < 6){
                return 1
            }else{
                return 2
            }
        }else if(square < 54){
            if(square%9 < 3){
                return 3
            }else if(square%9 < 6){
                return 4
            }else{
                return 5
            }
        }else{
            if(square%9 < 3){
                return 6
            }else if(square%9 < 6){
                return 7
            }else{
                return 8
            }
        }
    }

}
