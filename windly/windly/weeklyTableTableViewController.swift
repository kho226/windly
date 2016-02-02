//
//  weeklyTableTableViewController.swift
//  stormy
//
//  Created by Kyle Ong on 1/28/16.
//  Copyright © 2016 Kyle Ong. All rights reserved.
//

import UIKit

class weeklyTableTableViewController: UITableViewController {

    
    @IBOutlet weak var currentTempRange: UILabel!
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    @IBOutlet weak var currentTempLabel: UILabel!
    
    @IBOutlet weak var currentPrecipitationLabel: UILabel!
    private let forecastAPIKey = "02e95d977a5dd67687d31e9e2f5928fc"
    
    let coordinates: (lat: Double, lon: Double) = (40.7127,74.0059)
    
    var weeklyWeather: [DailyWeather] = []
    //added an array of type DailyWeather for the weekly forecast 01/28/2016
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveWeatherForecast()
        configureView()//01/28/2016
        //
        //tableView.backgroundView = backgroundView()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //01/28/2016 - modify the contents of the navbar
    func configureView() {
        //set table view's background view property
        tableView.backgroundView = backgroundView()
        
        //change the font and size of nav bar text
        if let navbarFont = UIFont(name: "HelveticaNeue-Thin", size:20.0 ){
            let navbarAttritubtesDictionary: [String: AnyObject]? = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: navbarFont
            ]
            navigationController?.navigationBar.titleTextAttributes = navbarAttritubtesDictionary
        }
        tableView.rowHeight = 64
        //position refresh control above background view
        //z position refers to depth in coordinate space
        refreshControl?.layer.zPosition = tableView.backgroundView!.layer.zPosition + 1
        refreshControl?.tintColor = UIColor.whiteColor()
        
        
    }
    @IBAction func refreshWeather() {
        retrieveWeatherForecast()
        refreshControl!.endRefreshing()
    }
    
    //MARK: - Navigation
    //01/29/2016
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDaily" {
            if let indexPath = tableView.indexPathForSelectedRow{
                let dailyWeather = weeklyWeather[indexPath.row]
                (segue.destinationViewController as! ViewController).dailyWeather = dailyWeather
            }
        }
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    //01/29/2016 - deleted the separators of each cell under the attributes inspector of the TableView
    //01/29/2016 - added a title to the tableView Section, every tableView has a section and rows belong to a particular section
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Forecast"
    }
    

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return weeklyWeather.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("weatherCell") as! dailyWeatherTableViewCell//without identifier, will crash -> unexpected nil
        let dailyWeather = weeklyWeather[indexPath.row]//use the indexPath to get the data from the data model and populate the cell 01/28/2016
        if let maxTemp = dailyWeather.maxTemp{
            cell.temperatureLabel.text = "\(maxTemp)º"
        }
        cell.weatherIcon.image = dailyWeather.icon
        cell.dayLabel.text = dailyWeather.day
        return cell
    }
    
    //Mark: Delegate Methods
    //01/29/2016 - change the highlight when clicking on a cell
    override func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        let highlightView = UIView()
        highlightView.backgroundColor = UIColor(red: 0.274, green: 0.509, blue: 0.705, alpha: 1.000)
        cell?.selectedBackgroundView = highlightView
        if let header = view as? UITableViewHeaderFooterView{
            header.textLabel!.font = UIFont(name:"HelveticaNeue-Thin", size: 4.0)
            header.textLabel!.textColor = UIColor.whiteColor()
        }
    }
    //01/29/2016 - change the color, font, and text-color of the titleForHeader in Section
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor(red: 0.274, green: 0.509, blue: 0.705, alpha: 1.000)
        if let header = view as? UITableViewHeaderFooterView{
            header.textLabel!.font = UIFont(name:"HelveticaNeue-Thin",size:14.0)
            header.textLabel!.textColor = UIColor.whiteColor()
        }
    }
    
    // MARK: - Weather Forecasting
    
    
    func retrieveWeatherForecast() {
        let forecastService = ForecastService(APIkey:forecastAPIKey)
        forecastService.getWeather(coordinates.lat, lon: coordinates.lon){
            (let forecast) in
            if let weatherForecast = forecast,
                let currentWeather = weatherForecast.currentWeather{
                dispatch_async(dispatch_get_main_queue()){
                    //execute closure
                    if let temperature = currentWeather.temperature{
                        self.currentTempLabel?.text = "\(temperature)º"
                    }
                   // if let humidity = currentWeather.humidity{
                   //     self.currentHumidityLabel?.text="\(humidity)%"
                    }
                    if let precipitation = currentWeather.precipChance{
                        self.currentPrecipitationLabel?.text = "Rain: \(precipitation)%"
                    }
                    if let icon = currentWeather.icon{
                        self.currentWeatherIcon?.image = icon
                    }
                    self.weeklyWeather = weatherForecast.weekly
                    
                    if let highTemp = self.weeklyWeather.first?.maxTemp, let lowTemp = self.weeklyWeather.first?.minTemp{
                        self.currentTempRange?.text = "↑\(highTemp)º↓\(lowTemp)º"
                    }
                    //if let summary = currentWeather.summary{
                    //    self.currentWeatherSummary?.text = summary
                    }
                    //self.toggleRefreshAnimation(false)
                self.tableView.reloadData() //the tableView queries for 0 data since retreiveWeather() has yet to be called 01/28/2016
                }
            }
        }


    
    

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


