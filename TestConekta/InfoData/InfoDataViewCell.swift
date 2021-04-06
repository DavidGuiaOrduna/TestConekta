//
//  InfoDataViewCell.swift
//  TestConekta
//
//  Created by David Guia on 05/04/21.
//

import UIKit
import Foundation
import RxCocoa
import RxSwift

final class InfoDataViewCell: UITableViewCell {
    
    @IBOutlet  weak var iDLabel: UILabel! {
        didSet {
            iDLabel.textColor = UIColor.blue
        }
    }
    
    @IBOutlet  weak var infoLabel: UILabel! {
        didSet {
            infoLabel.textColor = UIColor.darkGray
            infoLabel.numberOfLines = 5
            infoLabel.adjustsFontSizeToFitWidth = true
        }
    }
}
