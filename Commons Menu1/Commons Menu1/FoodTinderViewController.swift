//
//  FoodTinderViewController.swift
//  Foodscape
//
//  Created by Bjorn Ordoubadian on 29/6/15.
//  Copyright (c) 2015 Davidson College Mobile App Team. All rights reserved.
//

import UIKit
import Parse


// A protocol that the TableViewCell uses to inform its delegate of state change
protocol FoodTinderViewCellDelegate {
    
    //indicates that the given item has been deleted
    func toDoItemDeleted(dish: Dish)
    
    func uploadPreference(dish: Dish)
    
    func uploadDislike(dish: Dish)
    
    func showLabelInfo(sender: AnyObject)
}

class FoodTinderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FoodTinderViewCellDelegate, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var foodTinderTableView: UITableView!
    @IBOutlet var foodTinderView: UIView!
    
    var dishes: Dishes!
    private var menu = [Dish]()
    private let screenSize: CGRect = UIScreen.mainScreen().bounds
    //private let savingAlert = UIAlertController(title: "Saving...", message: "", preferredStyle: UIAlertControllerStyle.Alert)
    private let completeAlert = UIAlertController(title: "You have swiped all the dishes! Bravo!", message: "", preferredStyle: UIAlertControllerStyle.Alert)
    private var ecoLabelsArray: [String]!
    private let refreshControl = UIRefreshControl()
    private let instructionImageView = UIImageView()
    private let instructionView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodTinderTableView.dataSource = self
        foodTinderTableView.delegate = self
        foodTinderTableView.registerClass(FoodTinderTableViewCell.self, forCellReuseIdentifier: "tinderCell")
        foodTinderTableView.separatorStyle = .SingleLine
        foodTinderTableView.rowHeight = screenSize.height;
        foodTinderTableView.backgroundColor = UIColor.clearColor()
        setBackground("DishLevelPagebackground")
        foodTinderTableView.layer.cornerRadius = 5
        refreshControl.addTarget(self, action: "refresh:", forControlEvents: .ValueChanged)
        foodTinderTableView.addSubview(refreshControl)
        
        let logButton = UIBarButtonItem(title: "My Favorites", style: UIBarButtonItemStyle.Plain, target: self, action: "viewPreferences:")
        self.navigationItem.rightBarButtonItem = logButton
        
        if !dishes.learned["tinder"]! {
            instructionView.frame = CGRectMake(0.03 * view.bounds.width, 0.88 * view.bounds.height, 0.94 * view.bounds.width, 0.12 * view.bounds.height)
            instructionView.layer.cornerRadius = 5
            instructionImageView.frame = CGRect(x: 0.21 * instructionView.frame.width, y: 0.1 * instructionView.frame.height, width: 0.58 * instructionView.frame.width, height: 0.8 * instructionView.frame.height)
            instructionImageView.image = UIImage(named: "tinderInstruction")
            instructionView.backgroundColor = UIColor.lightGrayColor()
            instructionImageView.contentMode = .ScaleToFill
            instructionView.addSubview(instructionImageView)
            view.addSubview(instructionView)
        }
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(NSEC_PER_SEC) * 0.5))
        dispatch_after(delayTime, dispatch_get_main_queue()){
            self.refreshControl.sendActionsForControlEvents(.ValueChanged)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    func viewPreferences(button: UIBarButtonItem?){
        performSegueWithIdentifier("tinderToAllPreferencesSegue", sender: button)
    }

    
    internal func refresh(refreshControl: UIRefreshControl) {
        if Reachability.isConnectedToNetwork() {
            if dishes.dealtWith.count < dishes.numberOfDishes{
                self.fetchRandomDishes(self.dishes.numberOfDishes)
            } else {
                presentViewController(completeAlert, animated: true, completion: nil)
                let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC * 2))
                dispatch_after(delayTime, dispatch_get_main_queue()){
                    self.completeAlert.dismissViewControllerAnimated(true, completion: { () -> Void in
                    })
                }
            }
        } else{
            noInternetAlert("Unable to Get Any Food for Thought")
            refreshControl.endRefreshing()
        }
    }
    
    
    // MARK: - Table view data source
    /**
    Returns the number of sections in the table
    */
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //Fisher-Yates function to get random dishes into the tinder swiper
    //From http://stackoverflow.com/questions/24026510/how-do-i-shuffle-an-array-in-swift
    func shuffle<C: MutableCollectionType where C.Index == Int>(var list: C) -> C {
        let c = (list.count)
        if c < 2 { return list }
        for i in 0..<(c - 1) {
            let j = Int(arc4random_uniform(UInt32(c - i))) + i
            swap(&list[i], &list[j])
        }
        return list
    }
    
    /**
    Returns the number of rows in the table
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    /**
    Generates cells and adds items to the table
    */
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            //initiates the cell
            let cell = tableView.dequeueReusableCellWithIdentifier("tinderCell", forIndexPath: indexPath) as! FoodTinderTableViewCell
            
            //
            cell.delegate = self
            cell.selectionStyle = .None
            
            //passes a dish to each cell
            let dish = menu[indexPath.row]
            cell.imageView?.image = dish.image
            cell.dish = dish
            
            //sets the image
            //cell.imageView?.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))
            cell.imageView?.contentMode = UIViewContentMode.ScaleAspectFill
            
            return cell
    }
    
    //MARK: - Table view cell delegate
    /**
    Delegate function that finds and deletes the dish that is swiped
    */
    func toDoItemDeleted(dish: Dish) {
        //Finds index of swiped dish and removes it from the array
        if !dishes.learned["tinder"]! {
            instructionView.hidden = true
             dishes.learned["tinder"] = true
        }
        // use the UITableView to animate the removal of this row
        let index = self.menu.indexOf(dish)!
        self.dishes.addToDealtWith(dish.index)
        self.foodTinderTableView.beginUpdates()
        self.menu.removeAtIndex(index)
        let indexPathForRow = NSIndexPath(forRow: index, inSection: 0)
        self.foodTinderTableView.deleteRowsAtIndexPaths([indexPathForRow], withRowAnimation: .Fade)
        let delay =  0.1 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            self.refreshControl.sendActionsForControlEvents(.ValueChanged)
        }
        foodTinderTableView.endUpdates()
    }
    
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell,
        forRowAtIndexPath indexPath: NSIndexPath) {
            cell.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.92, alpha: 0.7)//colorForIndex(indexPath.row)
    }
    
    
    // support for versions of iOS prior to iOS 8
    func tableView(tableView: UITableView, heightForRowAtIndexPath
        indexPath: NSIndexPath) -> CGFloat {
            return tableView.rowHeight;
    }
    
    private func fetchRandomDishes(numberOfDishes: Int){
        var randomIndex = Int(arc4random_uniform(UInt32(numberOfDishes)))
        //if the dish has been dealt with
        while dealtWith(randomIndex){
            randomIndex = Int(arc4random_uniform(UInt32(numberOfDishes)))
        }
        // if the dish has been pulled, find the dish in dishes
        if let dish = dishes.pulled[randomIndex] {
            if let imageFile = dish.imageFile {
            dish.imageFile.getDataInBackgroundWithBlock {
                (imageData: NSData?, error: NSError?) ->Void in
                if error == nil {
                    if let data = imageData{
                        if let image = UIImage(data: data){
                            dish.image = image
                            self.menu.append(dish)
                            UIView.transitionWithView(self.foodTinderTableView, duration:0.5, options:.TransitionFlipFromTop,animations: { () -> Void in
                                    self.foodTinderTableView.reloadData()
                                    self.foodTinderTableView.endUpdates()
                                }, completion: { (finished: Bool) -> () in
                                    if finished {
                                        self.foodTinderTableView.endUpdates()
                                    }
                            })
                        }
                    }
                }
            }
        } else {
            dish.image = UIImage(named: "sloth")
            self.menu.append(dish)
            UIView.transitionWithView(self.foodTinderTableView, duration:0.5, options:.TransitionFlipFromTop,animations: { () -> Void in
                self.foodTinderTableView.reloadData()
                self.foodTinderTableView.endUpdates()
                }, completion: { (finished: Bool) -> () in
                    if finished {
                        self.foodTinderTableView.endUpdates()
                    }
            })
            }
        } else {
        let query = PFQuery(className:"dishInfo")
        query.whereKey("index", equalTo: randomIndex)
        query.getFirstObjectInBackgroundWithBlock({ (object: PFObject?, error: NSError?) -> Void in
            if error == nil {
            if let object = object {
                if !self.hasBeenAdded(object["name"]! as! String, location: object["location"] as! String){
                    let dish = object as! Dish
                        dish.getDishData(object)
                        self.dishes.addDish(dish.location, dish: dish)
                        self.dishes.addPulled(dish)
                        if let date = object["displayDate"] as? String {
                            dish.date = date
                        }
                        if let imageFile = dish.imageFile {
                        dish.imageFile.getDataInBackgroundWithBlock {
                            (imageData: NSData?, error: NSError?) ->Void in
                            if error == nil {
                                if let data = imageData{
                                    if let image = UIImage(data: data){
                                        dish.image = image
                                        self.menu.append(dish)
                                        UIView.transitionWithView(self.foodTinderTableView, duration:0.5, options:.TransitionFlipFromTop,animations: { () -> Void in
                                            self.foodTinderTableView.reloadData()
                                            }, completion: { (finished: Bool) -> () in
                                                if finished {
                                                    self.foodTinderTableView.endUpdates()
                                                }
                                        })
                                    }
                                }
                            }
                            }
                        }else {
                                dish.image = UIImage(named: "sloth")
                                self.menu.append(dish)
                                UIView.transitionWithView(self.foodTinderTableView, duration:0.5, options:.TransitionFlipFromTop,animations: { () -> Void in
                                    self.foodTinderTableView.reloadData()
                                    }, completion: { (finished: Bool) -> () in
                                        if finished {
                                            self.foodTinderTableView.endUpdates()
                                        }
                                })
                                }
                        }
                    }
            } else {
                self.foodTinderTableView.endUpdates()
            }
        })
        }
    }
    
    private func dealtWith(index: Int) -> Bool {
        return dishes.dealtWith.contains(index)
    }
    
    private func hasBeenAdded(name : String, location: String)-> Bool {
        for restaurant in dishes.dishes.keys{
            if restaurant.name == location{
                for dish: Dish in dishes.dishes[restaurant]!{
                    if dish.name == name {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    
    /**
    Uploads the preference list
    */
    func uploadPreference(dish: Dish){
        if let user = PFUser.currentUser(){
            let newPreference = PFObject(className:"Preference")
            newPreference["createdBy"] = PFUser.currentUser()
            newPreference["dishName"] = dish.name
            newPreference["location"] = dish.location
            newPreference.saveInBackgroundWithBlock({
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    // The object has been saved.
                    user["tinderViewed"] = true
                    user.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
                        
                    })
                } else {
                    // There was a problem, check error.description
                }
            })
        }
    }
    
    
    /**
    Uploads the preference list
    */
    func uploadDislike(dish: Dish){
        if let user = PFUser.currentUser(){
            let newPreference = PFObject(className:"Disliked")
            newPreference["createdBy"] = PFUser.currentUser()
            newPreference["dishName"] = dish.name
            newPreference["location"] = dish.location
            newPreference.saveInBackgroundWithBlock({
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    // The object has been saved.
                } else {
                    // There was a problem, check error.description
                }
            })
        }
    }
    
    
    /**
    Prepares for segue
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Segues to single dish info
        if segue.identifier == "foodTinderSegue" {
            let mealInfoViewController = segue.destinationViewController as! MealInfoViewController
            let selectedMeal = sender! as! Dish
            if let index = menu.indexOf(selectedMeal) {
                // Sets the dish info in the new view to selected cell's dish
                mealInfoViewController.dish = menu[index]
            }
        }
        if segue.identifier == "tinderToAllPreferencesSegue"{
            let allPreferenceListViewController = segue.destinationViewController as! AllPreferenceListViewController
            allPreferenceListViewController.dishes = dishes
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBarHidden = false
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    @IBAction func learnMoreLink(sender: UIButton) {
        let urls = IconDescription().urls
        let button = sender as! LinkButton
        if let url = NSURL(string: urls[button.name]!) {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    func showLabelInfo(sender: AnyObject) {
        let vc = UIViewController()
        let button = sender as! IconButton
        
        vc.preferredContentSize = CGSizeMake(self.view.frame.width * 0.4, self.view.frame.height * 0.3)
        vc.modalPresentationStyle = .Popover
        
        if let pres = vc.popoverPresentationController {
            pres.delegate = self
        }
        
        let description = UITextView(frame: CGRectMake(0, 0, vc.view.frame.width/2 , vc.view.frame.height))
        description.backgroundColor = UIColor.clearColor()
        description.textContainerInset = UIEdgeInsetsMake(5, 10, 0, 10)
        description.textAlignment = NSTextAlignment.Left
        description.userInteractionEnabled = false
        description.font = UIFont(name: "HelveticaNeue-Light", size: 14)
        description.text = button.descriptionText
        description.sizeToFit()

        
        let frame = CGRectMake(0, description.frame.height, description.frame.width, screenSize.height*0.05)
        let linkButton = LinkButton(name: button.name, frame: frame)
        linkButton.setTitle("Learn More", forState: UIControlState.Normal)
        linkButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        linkButton.addTarget(self, action: "learnMoreLink:", forControlEvents: UIControlEvents.TouchUpInside)
        
        let popScroll = UIScrollView()
        if description.frame.height + linkButton.frame.height < vc.view.frame.height/2 {
            popScroll.frame = CGRectMake(0, 10, description.frame.width, description.frame.height+linkButton.frame.height+10)
        }
        else {
            popScroll.frame = CGRectMake(0, 0, vc.view.frame.width/2, vc.view.frame.height/2)
        }
        
        popScroll.contentSize = CGSizeMake(description.frame.width, description.frame.height+linkButton.frame.height)
        popScroll.addSubview(description)
        popScroll.addSubview(linkButton)
        vc.view.addSubview(popScroll)
        
        vc.preferredContentSize = CGSizeMake(popScroll.frame.width, popScroll.frame.height)
        vc.modalPresentationStyle = .Popover
        
        self.presentViewController(vc, animated: true, completion: nil)
        
        
        if let pop = vc.popoverPresentationController {
            pop.sourceView = (sender as! UIView)
            pop.sourceRect = (sender as! UIView).bounds
        }
    }
}

extension FoodTinderViewController {
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
}