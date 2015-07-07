//
//  MovieTableViewCell.swift
//  Whats Beef
//
//  Created by iOS applicant on 7/07/2015.
//  Copyright (c) 2015 iOS applicant. All rights reserved.
//

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var channelImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.channelImageView.layer.borderWidth = 0
        self.channelImageView.layer.borderColor = UIColor.grayColor().CGColor
        self.channelImageView.backgroundColor = UIColor.lightGrayColor()
        self.channelImageView.layer.cornerRadius = self.channelImageView.frame.size.width / 2
    }
}
