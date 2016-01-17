//
//  ViewController.swift
//  WrodHunter
//
//  Created by Maksa on 1/16/16.
//  Copyright © 2016 Manta Ray. All rights reserved.
//

import UIKit

enum Entry {
    case WordEntryLetter(WordEntry, Int)
    case SomeLetter(String)
}

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet var wordsDelegate: WordsDataSourceAndDelegate!

    var wordSet : WordSet = WordSet()
    
    var matrixSize : (rows: Int, columns: Int) = ( 0, 0 )
    var matrix : [ [Entry] ]?
//    var wordEntries : [ WordEntry ] = [ WordEntry ]()
    
    var selectedCells : [ NSIndexPath ] = [ NSIndexPath ]()
    
    @IBOutlet weak var wordsCollectionView: UICollectionView!
    @IBOutlet weak var lettersCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lettersCollectionView.allowsMultipleSelection = true
    }
    
    func randomLetterGenerator() -> String {
        return Alphabet().randomLetter
    }
    

    func indexPathSetsIntersect( first: [ NSIndexPath ], second: [ NSIndexPath ] ) -> Bool {
        let v1 : Set<NSIndexPath> = Set<NSIndexPath>(first)
        let v2 : Set<NSIndexPath> = Set<NSIndexPath>(second)
        return v1.intersect(v2).count > 0
    }
    
    func setupGame() {
        let x = 15
        let cellSize = self.lettersCollectionView.frame.size.width/15
        let y : Int = Int(floor(self.lettersCollectionView.frame.size.height)/cellSize)
        matrixSize = ( x, y )
        
        // columns
        self.matrix = Array<Array<Entry>>()
        
        for _ in 0..<matrixSize.columns {
            var rowContent = Array<Entry>()
            for _ in 0..<matrixSize.rows {
                rowContent.append( Entry.SomeLetter(randomLetterGenerator()))
            }
            self.matrix!.append(rowContent)
        }
        
        let textovi = Texts()
        
        let words = textovi.randomWords(6)
        wordSet.wordEntries.removeAll()
        wordSet.generatePositionsForWords( words, matrix: matrixSize )
        
        self.wordsDelegate.myWords = wordSet.wordEntries
        
        for wordentry in wordSet.wordEntries {
            for (index, indexPath) in wordentry.positions.enumerate() {
                self.matrix![indexPath.section][indexPath.row] = Entry.WordEntryLetter(wordentry, index)
            }
        }
        
        self.lettersCollectionView.reloadData()
        self.wordsCollectionView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        setupGame()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return matrixSize.0
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return matrixSize.1
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell : LetterCell = collectionView.dequeueReusableCellWithReuseIdentifier("lettercell", forIndexPath: indexPath) as! LetterCell
        
        let entry = self.matrix![indexPath.section][indexPath.row]
        
        switch entry {
            case .WordEntryLetter( let (occupiedentry, index) ):
            let slovo = occupiedentry.word[occupiedentry.word.startIndex.advancedBy(index)]
            cell.letterLabel.text = String( slovo )
            if ( occupiedentry.status == .Solved ) {
                cell.letterLabel.textColor = UIColor.blueColor()
            } else {
//                cell.letterLabel.textColor = UIColor.orangeColor()
                cell.letterLabel.textColor = UIColor.blackColor()
            }
            
            case .SomeLetter( let slovo ):
                cell.letterLabel.text = slovo
                cell.letterLabel.textColor = UIColor.blackColor()
        }

        if ( selectedCells.contains( { $0.row == indexPath.row && $0.section == indexPath.section} )) {
            cell.letterLabel.backgroundColor = UIColor.lightGrayColor()
        } else {
            cell.letterLabel.backgroundColor = UIColor.whiteColor()
        }
        return cell
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width/CGFloat(matrixSize.0), height: collectionView.bounds.size.width/(CGFloat(matrixSize.0)))
    }

    func checkIndexPathsAgainstEntries( indexPaths: [ NSIndexPath ] ) -> WordEntry? {
        for entry in wordSet.wordEntries {
            let s1 = Set<NSIndexPath>(entry.positions)
            let s2 = Set<NSIndexPath>( selectedCells )
            if ( s1 == s2  ) {
                return entry
            }
        }
        return nil
    }
    
    func comboHit( entry: WordEntry ) {
        SoundPlayer().applause()
        self.wordsCollectionView.reloadData()
        for indexPath in entry.positions {
            let letterCell = self.lettersCollectionView.cellForItemAtIndexPath(indexPath) as! LetterCell
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                letterCell.backgroundColor = UIColor.redColor()
                }, completion: { (kraj) -> Void in
//                letterCell.letterLabel.backgroundColor = UIColor.whiteColor()
            })
        }
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.lettersCollectionView.reloadItemsAtIndexPaths(entry.positions)
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let index =
        selectedCells.indexOf { (ip) -> Bool in
            return ip.row == indexPath.row && ip.section == indexPath.section
        }
        if let selectedIndex = index {
            selectedCells.removeAtIndex( selectedIndex )
            NSLog("deselektovalo \(indexPath)")
        } else {
            selectedCells.append( indexPath )
        }
        
        if let winningCombo = checkIndexPathsAgainstEntries( selectedCells ) {
            winningCombo.status = .Solved
            self.selectedCells.removeAll()
            comboHit( winningCombo )
        } else {
            self.lettersCollectionView.reloadItemsAtIndexPaths( [ indexPath ])
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let index =
        selectedCells.indexOf { (ip) -> Bool in
            return ip.row == indexPath.row && ip.section == indexPath.section
        }
        if let selectedIndex = index {
            selectedCells.removeAtIndex( selectedIndex )
            NSLog("deselektovalo \(indexPath)")
        }

        if let winningCombo = checkIndexPathsAgainstEntries( selectedCells ) {
            winningCombo.status = .Solved
            self.selectedCells.removeAll()
            comboHit(winningCombo)
        } else {
            self.lettersCollectionView.reloadItemsAtIndexPaths( [ indexPath ])
        }
    }
    
    @IBAction func onOpet(sender: UIButton) {
        setupGame()
    }
    
}

