//
//  EvaCollectionView.swift
//  EvaStore
//
//  Created by Sergio Daniel on 12/6/24.
//

import AppKit

protocol EvaCollectionViewDelegate: AnyObject {
    func collectionView(_ collectionView:NSCollectionView, menu:NSMenu?, at indexPath: IndexPath?) -> NSMenu?
}

class EvaCollectionView: NSCollectionView {
    
    weak var evaDelegate: EvaCollectionViewDelegate?
    
    override func menu(for event: NSEvent) -> NSMenu? {
        var menu = super.menu(for: event)
        
        let point = convert(event.locationInWindow, from: nil)
        let selectedIndexPath = indexPathForItem(at: point)
        
        guard let selectedIndexPath else { return nil }
        
        if let evaDelegate {
            menu = evaDelegate
                .collectionView(self, menu: menu, at: selectedIndexPath)
        }
        
        return menu
    }
    
}
