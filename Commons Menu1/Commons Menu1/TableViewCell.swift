//
//  TableViewCell.swift
//  Commons Menu1
//
//  Created by Bjorn Ordoubadian on 18/6/15.
//  Copyright (c) 2015 Davidson College Mobile App Team. All rights reserved.
//

import UIKit
import QuartzCore

// A protocol that the TableViewCell uses to inform its delegate of state change
protocol TableViewCellDelegate {
    // indicates that the given item has been deleted
    func toDoItemDeleted(dish: Dish)
    
    // indicates which item has been selected and provide appropriate information for a segue to dish info
    // #spchadinha
    func viewDishInfo(dish: Dish)
}

class TableViewCell: UITableViewCell {
    
    var imgUser = UIImageView()
    
    let gradientLayer = CAGradientLayer()
    var originalCenter = CGPoint()
    var deleteOnDragRelease = false, likeOnDragRelease = false
    var tickLabel: UILabel, crossLabel: UILabel
    let label: StrikeThroughText
    var itemLikeLayer = CALayer()
    // The object that acts as delegate for this cell.
    var delegate: TableViewCellDelegate?
    // The item that this cell renders.
    var dish: Dish? {
        didSet {
            label.text = dish!.name
            label.strikeThrough = dish!.like
            itemLikeLayer.hidden = !label.strikeThrough
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        // create a label that renders the to-do item text
        label = StrikeThroughText(frame: CGRect.nullRect)
        label.textColor = UIColor.whiteColor()
        label.font = UIFont.boldSystemFontOfSize(16)
        label.backgroundColor = UIColor.clearColor()
        
        // utility method for creating the contextual cues
        func createCueLabel() -> UILabel {
            let label = UILabel(frame: CGRect.nullRect)
            label.textColor = UIColor.whiteColor()
            label.font = UIFont.boldSystemFontOfSize(32.0)
            label.backgroundColor = UIColor.clearColor()
            return label
        }
        
        // tick and cross labels for context cues
        tickLabel = createCueLabel()
        tickLabel.text = "\u{2713}"
        tickLabel.textAlignment = .Right
        crossLabel = createCueLabel()
        crossLabel.text = "\u{2717}"
        crossLabel.textAlignment = .Left
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(label)
        addSubview(tickLabel)
        addSubview(crossLabel)
        // remove the default blue highlight for selected cells
        selectionStyle = .None
        
        // gradient layer for cell
        gradientLayer.frame = bounds
        let color1 = UIColor(white: 1.0, alpha: 0.2).CGColor as CGColorRef
        let color2 = UIColor(white: 1.0, alpha: 0.1).CGColor as CGColorRef
        let color3 = UIColor.clearColor().CGColor as CGColorRef
        let color4 = UIColor(white: 0.0, alpha: 0.1).CGColor as CGColorRef
        gradientLayer.colors = [color1, color2, color3, color4]
        gradientLayer.locations = [0.0, 0.01, 0.95, 1.0]
        layer.insertSublayer(gradientLayer, atIndex: 0)
        
        // add a layer that renders a green background when a user like the dish %anwu
        itemLikeLayer = CALayer(layer: layer)
        itemLikeLayer.backgroundColor = UIColor(red: 0.0, green: 0.6, blue: 0.0, alpha: 1.0).CGColor
        itemLikeLayer.hidden = true
        layer.insertSublayer(itemLikeLayer, atIndex: 0)
        
        // add a pan recognizer
        var recognizer = UIPanGestureRecognizer(target: self, action: "handlePan:")
        recognizer.delegate = self
        addGestureRecognizer(recognizer)
        
        var tapRecognizer = UITapGestureRecognizer(target: self, action: "handleTap")
        tapRecognizer.delegate = self
        addGestureRecognizer(tapRecognizer)
    }
    
    let kLabelLeftMargin: CGFloat = 150.0
    let kUICuesMargin: CGFloat = 10.0, kUICuesWidth: CGFloat = 50.0
    override func layoutSubviews() {
        super.layoutSubviews()
        // ensure the gradient layer occupies the full bounds
        gradientLayer.frame = bounds
        itemLikeLayer.frame = bounds
        label.frame = CGRect(x: kLabelLeftMargin, y: 0,
            width: bounds.size.width - kLabelLeftMargin, height: bounds.size.height)
        tickLabel.frame = CGRect(x: -kUICuesWidth - kUICuesMargin, y: 0,
            width: kUICuesWidth, height: bounds.size.height)
        crossLabel.frame = CGRect(x: bounds.size.width + kUICuesMargin, y: 0,
            width: kUICuesWidth, height: bounds.size.height)
    }
    
    //MARK: - horizontal pan gesture methods
    func handlePan(recognizer: UIPanGestureRecognizer) {
        // 1
        if recognizer.state == .Began {
            // when the gesture begins, record the current center location
            originalCenter = center
        }
        // 2
        if recognizer.state == .Changed {
            let translation = recognizer.translationInView(self)
            center = CGPointMake(originalCenter.x + translation.x, originalCenter.y)
            // has the user dragged the item far enough to initiate a delete/Like?
            deleteOnDragRelease = frame.origin.x < -frame.size.width / 2.0
            likeOnDragRelease = frame.origin.x > frame.size.width / 2.0
            // fade the contextual clues
            let cueAlpha = fabs(frame.origin.x) / (frame.size.width / 2.0)
            tickLabel.alpha = cueAlpha
            crossLabel.alpha = cueAlpha
            // indicate when the user has pulled the item far enough to invoke the given action
            tickLabel.textColor = likeOnDragRelease ? UIColor.greenColor() : UIColor.whiteColor()
            crossLabel.textColor = deleteOnDragRelease ? UIColor.redColor() : UIColor.whiteColor()
        }
        // 3
        if recognizer.state == .Ended {
            let originalFrame = CGRect(x: 0, y: frame.origin.y,
                width: bounds.size.width, height: bounds.size.height)
            if deleteOnDragRelease {
                if delegate != nil && dish != nil {
                    // notify the delegate that this item should be deleted
                    delegate!.toDoItemDeleted(dish!)
                }
            } else if likeOnDragRelease {
                if dish != nil {
                    dish!.like = true
                }
                label.strikeThrough = true
                itemLikeLayer.hidden = false
                UIView.animateWithDuration(0.2, animations: {self.frame = originalFrame})
            } else {
                UIView.animateWithDuration(0.2, animations: {self.frame = originalFrame})
            }
        }
    }
    
    func handleTap(recognizer: UITapGestureRecognizer) {
        if recognizer.state == .Ended {
            println(dish)
            println("Delegate: \(delegate)" )
            if delegate != nil && dish != nil {
                println("Recognized the tap")
                delegate!.viewDishInfo(dish!)
            }
        }
    }
    
    override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
            let translation = panGestureRecognizer.translationInView(superview!)
            if fabs(translation.x) > fabs(translation.y) {
                return true
            }
            return false
        }
        
        if let tapGestureRecognizer = gestureRecognizer as? UITapGestureRecognizer {
            //            self.label.text = "Changed"
            //            self.label.textColor = UIColor.yellowColor()
            //            testLabel.hidden = false
            println("\(dish!.name)'s cell was clicked" )
            //var x = ()
            delegate!.viewDishInfo(dish!)
            
        }
        return false
    }
}
