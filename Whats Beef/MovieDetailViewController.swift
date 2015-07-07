//
//  MovieDetailViewController.swift
//  Whats Beef
//
//  Created by iOS applicant on 7/07/2015.
//  Copyright (c) 2015 iOS applicant. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    var movie: MovieModel?
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var blurImageView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var summaryTextView: UITextView!
    
    
    override func loadView() {
        super.loadView()
        self.setupNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.nameLabel.text = self.movie?.name
        self.setTime(self.movie!.startTime, end: self.movie!.endTime)
        self.setRating(self.movie!.rating)
    }
    
    private func setupNavigationBar() {
        self.title = self.movie?.name
        let back: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow-back"), style: .Plain, target: self, action: "back")
        
        let negativeSpacer: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: nil, action: nil)
        negativeSpacer.width = -15
        
        self.navigationItem.leftBarButtonItems = [negativeSpacer, back]
    }
    
    func back() {
        self.navigationController?.popViewControllerAnimated(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setTime(start: String, end: String) {
        self.timeLabel.text = "\(start) - \(end)"
    }
    
    private func setRating(rating: String) {
        var image: UIImage? = nil
        if rating == "NR" || rating == "" {
            image = UIImage(named: "NR")
        } else {
            image = UIImage(named: rating)
        }
        self.ratingImageView.image = image
    }
}
