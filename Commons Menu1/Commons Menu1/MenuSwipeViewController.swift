//
//  MenuSwipeViewController.swift
//  Commons Menu1
//
//  Created by Bjorn Ordoubadian on 18/6/15.
//  Copyright (c) 2015 Davidson College Mobile App Team. All rights reserved.
//

import UIKit

class MenuSwipeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TableViewCellDelegate {

    @IBOutlet weak var tableView: UITableView!
   
    var menu = [Dish]()
    var preferenceList = [Dish]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var bunduru = Bunduru().allRestaurants
        var meal = bunduru["Commons"]
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(TableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.blackColor()
        tableView.rowHeight = 100;
        
        if menu.count > 0 {
            return
        }
        for var i = 0; i < meal!.count; i++ {
            menu.append(meal![i])
        }
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell

            let item = menu[indexPath.row]
            cell.selectionStyle = .None
        

            cell.delegate = self
            cell.dish = item
            
            var sloth = UIImage(named: "sloth")
            cell.imageView?.image = sloth
            
            cell.imageView?.frame = CGRect(x: 0, y: 0, width: 35.0, height: 35.0)
            
            // cell.textLabel?.text = item.text
            // cell.textLabel?.backgroundColor = UIColor.clearColor()
            // var image : UIImage = UIImage(named: "osx_design_view_messages")

            return cell
    }
    
    
    func toDoItemDeleted(dish: Dish) {
        // could use this to get index when Swift Array indexOfObject works
        // let index = toDoItems.indexOfObject(toDoItem)
        // in the meantime, scan the array to find index of item to delete
        var index = 0
        for i in 0..<menu.count {
            if menu[i] === dish {  // note: === not ==
                index = i
                break
            }
        }
        // could removeAtIndex in the loop but keep it here for when indexOfObject works
        menu.removeAtIndex(index)
        
        // use the UITableView to animate the removal of this row
        tableView.beginUpdates()
        let indexPathForRow = NSIndexPath(forRow: index, inSection: 0)
        tableView.deleteRowsAtIndexPaths([indexPathForRow], withRowAnimation: .Fade)
        tableView.endUpdates()
    }
    
    func viewDishInfo(selectedDish: Dish) {
        println("  delegate function was called")
        performSegueWithIdentifier("mealInfoSegue", sender: selectedDish)
    }
    
    // MARK: - Table view delegate
    
    func colorForIndex(index: Int) -> UIColor {
        let itemCount = menu.count - 1
        let val = (CGFloat(index) / CGFloat(itemCount)) * 0.6
        return UIColor(red: 1.0, green: val, blue: 0.0, alpha: 1.0)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell,
        forRowAtIndexPath indexPath: NSIndexPath) {
            cell.backgroundColor = colorForIndex(indexPath.row)
    }
    
    // support for versions of iOS prior to iOS 8
    func tableView(tableView: UITableView, heightForRowAtIndexPath
        indexPath: NSIndexPath) -> CGFloat {
            return tableView.rowHeight;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "mealInfoSegue" {
            println("    Entered the prepare for segue method")
            let mealInfoViewController = segue.destinationViewController as! MealInfoViewController
            let selectedMeal = sender! as! Dish
            if let index = find(menu, selectedMeal) {
                mealInfoViewController.dish = menu[index]
                println("The item passed is: \(selectedMeal.name)")
            }
            else {
                println("item was not found")
            }
        }
        if segue.identifier  == "menuToPreferenceSegue" {
            let preferencelistViewController = segue.destinationViewController as! PreferenceListViewController
            updatePreferenceList()
            preferencelistViewController.preferences = preferenceList
        }
    }
    
    
    //Updates the preferenceList  %anwu
    func updatePreferenceList(){
        for dish: Dish in menu {
        println(dish.like)
        if dish.like && !contains(preferenceList, dish){
            preferenceList.append(dish)
        }
        }
        preferenceList = preferenceList.filter{contains(self.menu, $0) && $0.like}
    }
    
}
