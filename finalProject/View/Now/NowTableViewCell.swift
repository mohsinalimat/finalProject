//
//  NowTableViewCell.swift
//  finalProject
//
//  Created by Andrew Jenson on 3/9/18.
//  Copyright © 2018 Andrew Jenson. All rights reserved.
//

import UIKit

protocol NowTableViewCellDelegate {
    // Implement these functions in the NowViewController
    func goToSourceURL(url: String)
}

class NowTableViewCell: UITableViewCell {

    // For protocol, create a delegate variable here (the Boss) so we can set NowViewController as our delegate (the intern)
    var delegate: NowTableViewCellDelegate?


    @IBOutlet weak var boarderColorView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!

    // Plan to use in next version release:
//    @IBOutlet weak var sponsorLabel: UILabel!
//    @IBOutlet weak var sponsorButton: RoundButton!

    var tipItem: Tip!

    func configureCell(tip: Tip) {
        // Display summarized text in
        tipItem = tip
        titleLabel.text = tip.title
        bodyLabel.text = tip.body
        sourceLabel.text = tip.sourceName
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // Plan to use in next version release:
    @IBAction func sponsorButtonTapped(_ sender: Any) {

        print("Sponsor Button Tapped, tell intern, NowViewController, to execute goToSourceURL() and tell it the url to open up")
        delegate?.goToSourceURL(url: tipItem.sponsorURL!)
    }
}


