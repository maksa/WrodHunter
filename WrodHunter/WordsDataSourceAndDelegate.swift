//
//  WordsDataSourceAndDelegate.swift
//  WrodHunter
//
//  Created by Maksa on 1/16/16.
//  Copyright © 2016 Manta Ray. All rights reserved.
//

import UIKit

class WordsDataSourceAndDelegate: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    var myCollectionView : UICollectionView?
    var _words : [ WordEntry ] = [ WordEntry ]()
    var myWords : [ WordEntry ] {
        set {
            _words = newValue
            self.myCollectionView?.reloadData()
        }
        get {
            return _words
        }
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        myCollectionView = collectionView
        return myWords.count
    }
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        return CGSize(width: 50, height: 40)
//    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        myCollectionView = collectionView
        
        if( myWords.count == 0 ) {
            return 0
        } else {
            return 1
        }
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let wordCell : WordCell
        = collectionView.dequeueReusableCellWithReuseIdentifier("wordcell", forIndexPath: indexPath) as! WordCell
        wordCell.wordLabel.text = self.myWords[indexPath.row].word
        if( self.myWords[indexPath.row].status == EntryStatus.Solved ) {
            wordCell.wordLabel.textColor = UIColor.lightGrayColor()
        } else {
            wordCell.wordLabel.textColor = UIColor.blueColor()
        }
        return wordCell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize( width:self.myCollectionView!.frame.width/CGFloat(myWords.count), height: myCollectionView!.frame.height )
    }
}
