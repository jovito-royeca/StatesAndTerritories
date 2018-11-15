//
//  StateTableViewCell.swift
//  JEStatesCell
//
//  Created by Jovito Royeca on 14/11/2018.
//  Copyright © 2018 Jovito Royeca. All rights reserved.
//

import UIKit

public class StateTableViewCell: UITableViewCell {
    public static let reuseIdentifier = "StateCell"
    public static let cellHeight = CGFloat(88)
    
    // MARK: Setters
    public func set(name text: String?) {
        nameLabel.text = text
    }
    public func set(abbreviation text: String?) {
        abbreviationLabel.text = text
    }
    public func set(capital text: String?) {
        capitalLabel.text = text
    }
    public func set(largestCity text: String?) {
        largestCityLabel.text = text
    }
    public func set(area text: String?) {
        areaLabel.text = text
    }
    
    // MARK: Outlets
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var abbreviationLabel: UILabel!
    @IBOutlet private weak var capitalLabel: UILabel!
    @IBOutlet private weak var largestCityLabel: UILabel!
    @IBOutlet private weak var areaLabel: UILabel!
    
    // MARK: Overrides
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
