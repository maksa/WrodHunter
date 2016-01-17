//
//  WordCell.swift
//  WrodHunter
//
//  Created by Maksa on 1/16/16.
//  Copyright © 2016 Manta Ray. All rights reserved.
//

import UIKit

class WordCell: UICollectionViewCell {
    @IBOutlet weak var wordLabel: UILabel!
    override func preferredLayoutAttributesFittingAttributes(layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        var copy = layoutAttributes.copy() as! UICollectionViewLayoutAttributes
        wordLabel.sizeToFit()
        copy.frame = CGRect( x: copy.frame.origin.x, y: copy.frame.origin.y, width: wordLabel.frame.size.width, height: wordLabel.frame.size.height )
        return copy
    }
}
