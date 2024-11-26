//
//  BookCell.swift
//  EvaStore
//
//  Created by Sergio Daniel on 11/25/24.
//

import Cocoa

class BookCell: NSCollectionViewItem {
    
    var book: Book
    
    var imageCover: NSImage {
        .gameOfThronesCover
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
