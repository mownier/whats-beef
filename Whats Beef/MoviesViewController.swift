//
//  MoviesViewController.swift
//  Whats Beef
//
//  Created by iOS applicant on 7/07/2015.
//  Copyright (c) 2015 iOS applicant. All rights reserved.
//

import UIKit

class MoviesViewController: UITableViewController {

    var pageCounter: Int = 1
    
    var items: [[MovieModel]] = [[MovieModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "My Movies"
        self.tableView.addInfiniteScrollingWithActionHandler { () -> Void in
            self.getMovies(self.pageCounter + 1)
        }
        self.getMovies(self.pageCounter)
    }
    
    func getMovies(page: Int) {
        let manager = APIManager.sharedManager
        let urlString = "wabz/guide.php"
        manager.GET(urlString, parameters: ["start": page], success: { (task, response) -> Void in
            if page == 1 {
                self.items.removeAll(keepCapacity: false)
            }
            let movies = self.parse(response)
            self.items.append(movies)
            self.reloadMovies()
            self.tableView.infiniteScrollingView.stopAnimating()
            self.pageCounter++
            }) { (task, error) -> Void in
            self.tableView.infiniteScrollingView.stopAnimating()
        }
    }
    
    private func reloadMovies() {
        self.tableView.reloadData()
    }
    
    private func parse(response: AnyObject!) -> [MovieModel] {
        var movies: [MovieModel] = [MovieModel]()
        if let object = response as? [String: AnyObject] {
            if let results = object["results"] as? [[String: AnyObject]] {
                for result in results {
                    var movie: MovieModel = MovieModel()
                    movie.channel = result["channel"] as! String
                    movie.endTime = result["end_time"] as! String
                    movie.name = result["name"] as! String
                    movie.rating = result["rating"] as! String
                    movie.startTime = result["start_time"] as! String
                    
                    movies.append(movie)
                }
            }
        }
        return movies
    }
    
    private func setCellMovieRating(cell: MovieTableViewCell, rating: String) {
        let image = UIImage(named: rating)
        cell.ratingImageView.image = image
    }
    
    private func setCellMovieChannel(cell: MovieTableViewCell, channel: String) {
        let image = UIImage(named: channel)
        cell.channelImageView.image = image
    }
    
    private func setCellMovieTime(cell: MovieTableViewCell, startTime: String, endTime: String) {
        let time = "\(startTime) - \(endTime)"
        cell.timeLabel.text = time
    }
    
    private func getShowingDate(section: Int) -> String {
        var showingDate: String = "TONIGHT";
        if section > 0 {
            let today = NSDate()
            let date = NSCalendar.currentCalendar().dateByAddingUnit(
                .CalendarUnitDay,
                value: section,
                toDate: today,
                options: NSCalendarOptions(0))
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd"
            showingDate = dateFormatter.stringFromDate(date!)
        }
        return showingDate
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.items.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items[section].count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: MovieTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! MovieTableViewCell
        let movie: MovieModel = self.items[indexPath.section][indexPath.row]
        cell.nameLabel.text = movie.name
        self.setCellMovieTime(cell, startTime: movie.startTime, endTime: movie.endTime)
        self.setCellMovieRating(cell, rating: movie.rating)
        self.setCellMovieChannel(cell, channel: movie.channel)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let vc: MovieDetailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MovieDetailViewController") as! MovieDetailViewController
        vc.movie = self.items[indexPath.section][indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: UIView = UIView(frame: CGRectMake(0, 0, self.tableView.frame.size.width, 40))
        header.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        let date: UILabel = UILabel(frame: CGRectMake(10, 10, 100, 20))
        date.font = UIFont.boldSystemFontOfSize(14)
        date.text = self.getShowingDate(section)
        header.addSubview(date)
        return header
    }
}
