//
//  MainMenuViewController.swift
//  Commons Menu1
//
//  Created by Bjorn Ordoubadian on 16/6/15.
//  Copyright (c) 2015 Davidson College Mobile App Team. All rights reserved.
//

import UIKit
import Parse

/**
Welcome page view controller and search type for user
*/

protocol updatePreferenceListDelegate{
    func updatePreference(preferenceList: [String: [Dish]])
}

protocol updateFoodTinderPreferenceListDelegate{
    func updatePreferences(preferenceList: [Dish])
}

class MainMenuViewController: UIViewController, updatePreferenceListDelegate, updateFoodTinderPreferenceListDelegate {
    
    var menuPFObjects = [PFObject]()
    var menu = [Dish]()
    var restaurants = [String: [Dish]]()
    var preferenceListLoad = [String: [String]]()
    var preferenceList = [String: [Dish]]()
    

    @IBAction func showRestaurants(sender: AnyObject) {
        performSegueWithIdentifier("mainToRestaurantsSegue", sender: sender)
    }
    
    @IBAction func foodTinderAction(sender: AnyObject) {
        performSegueWithIdentifier("foodTinderSegue", sender: sender)
    }
    
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var sustainabilityInfoButton: UIButton!
    @IBAction func signOut(sender: AnyObject) {
        PFUser.logOut()
    }
    
    let styles = Styles()
    
    override func viewDidLoad() {
        super.viewDidLoad()
               
        menuButton.backgroundColor = styles.buttonBackgoundColor
        menuButton.layer.cornerRadius = styles.buttonCornerRadius
        menuButton.layer.borderWidth = 1
        self.getData("test")
        self.fetchPreferenceData()
    }
    
    
    func addKeysToPreferenceList(keys: [String]){
        for key in keys{
            preferenceList[key] = []
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "foodTinderSegue"{
            let foodTinderViewController = segue.destinationViewController as! FoodTinderViewController
            menu.sort({$0.name<$1.name})
            foodTinderViewController.menuLoad = menu
            foodTinderViewController.foodTinderDelegate = self
        }
        if segue.identifier == "mainToRestaurantsSegue" {
            let restMenuViewController = segue.destinationViewController as! RestMenuViewController
            menu.sort({$0.name<$1.name})
            restMenuViewController.menu = menu
            restMenuViewController.restaurants = restaurants
            restMenuViewController.delegate = self
            restMenuViewController.preferenceListLoad = preferenceList
        }
        if segue.identifier == "mainToAllPreferencesSegue"{
            let allPreferenceListViewController = segue.destinationViewController as! AllPreferenceListViewController
            println(preferenceList)
            allPreferenceListViewController.preferenceListLoad = preferenceList
        }
    }
    
    
    func updatePreferences(preferenceListLoad:[Dish]){
    
        for dish: Dish in preferenceListLoad {
            if !contains(preferenceList.keys, dish.location!) {
                preferenceList[dish.location!] = []
            }
            
            preferenceList[dish.location!]?.append(dish)
        }
    }
    
    func getData(name: String) {
        var query = PFQuery(className:"dishInfo")
        query.findObjectsInBackgroundWithBlock{
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil && objects != nil{
                if let objectsArray = objects{
                    for object: AnyObject in objectsArray{
                        self.menuPFObjects.append(object as! PFObject)
                        if let name = object["name"] as? String {
                            if let userImageFile = object["image"] as? PFFile{
                                userImageFile.getDataInBackgroundWithBlock {
                                    (imageData: NSData?, error: NSError?) ->Void in
                                    if error == nil {                               if let data = imageData{                                                if let image = UIImage(data: data){
                                        if let location = object["location"] as? String{
                                            let dish = Dish(name: name, image: image, location: location)
                                            self.menu.append(dish)
                                            self.addToRestaurant(location, dish: dish)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func addToRestaurant(location: String, dish: Dish){
        if !contains(self.restaurants.keys, location){
            restaurants[location] = [Dish]()
        }
        restaurants[location]?.append(dish)
    }
    
    
    /**
    delegate function that pass the preferencelist back from restaurant menu view controller
    */
    func updatePreference(preferenceList: [String: [Dish]]){
        self.preferenceList = preferenceList
    }
    
    func fetchPreferenceData(){
    if let currentUser = PFUser.currentUser(){
        var user = PFObject(withoutDataWithClassName: "_User", objectId: currentUser.objectId)
            var query = PFQuery(className:"Preference")
            query.whereKey("createdBy", equalTo: user)
            query.findObjectsInBackgroundWithBlock{
                (objects: [AnyObject]?, error: NSError?) -> Void in
                if error == nil && objects != nil{
                    if let objectsArray = objects{
                        for object: AnyObject in objectsArray{
                            if let pFObject: PFObject = object as? PFObject{
                                if let restaurant = pFObject["location"] as?String{
                                    if let dish = pFObject["String"] as? String{
                                        self.addToPreferenceListLoad(restaurant, dish: dish)
                                        self.updateMenu()
                                        self.updatePreferenceList()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    /**
    Update the preference list with data pulled in parse
    */
    func addToPreferenceListLoad(restaurant: String, dish: String){
        if !contains(self.preferenceListLoad.keys, restaurant) {
            preferenceListLoad[restaurant] = []
        }
        preferenceListLoad[restaurant]?.append(dish)
    }
    
    
    func updateMenu(){
        
    }
    
    
    func updatePreferenceList(){
        
    }
    
    
}

