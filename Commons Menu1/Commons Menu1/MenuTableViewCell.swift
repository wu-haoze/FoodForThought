//
//  MenuTableViewCell.swift
//  Commons Menu1
//
//  Created by Bjorn Ordoubadian on 18/6/15.
//  Copyright (c) 2015 Davidson College Mobile App Team. All rights reserved.
//

import UIKit
import QuartzCore
import Parse


/**
Manages the cell representation of a dish in a menu
*/
class MenuTableViewCell: UITableViewCell {
    private let gradientLayer = CAGradientLayer()
    private var originalCenter = CGPoint()
    private var deleteOnDragRelease = false, likeOnDragRelease = false
    private var tickLabel: UILabel, crossLabel: UILabel
    private let label: UILabel
    private var itemLikeLayer = CALayer()
    private var itemDislikeLayer = CALayer()
    private let arrowImage = CALayer()

    // The object that acts as delegate for this cell
    var delegate: MenuTableViewCellDelegate?
    // The dish that this cell renders
    var dish: Dish? {
        didSet {
            label.text = dish!.name
            itemLikeLayer.hidden = !dish!.like
            itemDislikeLayer.hidden = !dish!.dislike
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        // create a label that renders the to-do item text
        label = UILabel(frame: CGRect.null)
        label.textColor = UIColor.whiteColor()
        //label.font = UIFont(name: "Helvetica-Neue Light", size: 16)

        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping

        /**
        utility method for creating the contextual cues
        */
        func createCueLabel() -> UILabel {
            let label = UILabel(frame: CGRect.null)
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
        itemLikeLayer.backgroundColor = UIColor(red: 0.75, green: 0.9, blue: 0.75, alpha: 1.0).CGColor
        itemLikeLayer.hidden = true
        layer.insertSublayer(itemLikeLayer, atIndex: 0)
        
        itemDislikeLayer = CALayer(layer: layer)
        itemDislikeLayer.backgroundColor = UIColor(red: 0.9, green: 0.75, blue: 0.75, alpha: 1.0).CGColor
        itemDislikeLayer.hidden = true
        layer.insertSublayer(itemDislikeLayer, atIndex: 0)
        
        // add a pan recognizer
        let panRecognizer = UIPanGestureRecognizer(target: self, action: "handlePan:")
        panRecognizer.delegate = self
        addGestureRecognizer(panRecognizer)

        let tapRecognizer = UITapGestureRecognizer(target: self, action: "handleTap:")
        tapRecognizer.delegate = self
        addGestureRecognizer(tapRecognizer)
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // ensure the gradient layer occupies the full bounds
        gradientLayer.frame = bounds
        itemLikeLayer.frame = bounds
        itemDislikeLayer.frame = bounds
        let width = 0.01 * bounds.size.width
        let height = 0.01 * bounds.size.height
        let kLabelLeftMargin: CGFloat = 36 * width
        let kUICuesMargin: CGFloat = 10.0, kUICuesWidth: CGFloat = 50.0
        label.frame = CGRect(x: kLabelLeftMargin - 20, y: 0,
            width: bounds.size.width - kLabelLeftMargin-20, height: bounds.size.height)
        label.font = UIFont(name: "Helvetica-Neue Light", size: 16.0)
        tickLabel.frame = CGRect(x: -kUICuesWidth - kUICuesMargin, y: 0,
            width: kUICuesWidth, height: bounds.size.height)
        crossLabel.frame = CGRect(x: bounds.size.width + kUICuesMargin, y: 0,
            width: kUICuesWidth, height: bounds.size.height)
        self.imageView?.frame = CGRect(x: 5 * width, y: 0.5 * (100 * height - 18 * width), width: 18 * width, height: 18 * width)
        self.imageView?.layer.borderColor = UIColor.blackColor().CGColor
        self.imageView?.layer.borderWidth = 1.0
        
        let arrowImageView = UIImageView(frame: CGRectMake(90 * width, 42 * height, 4 * width, 20 * height))
        let arrowImage : UIImage = UIImage(named: "MenuItemArrow")!
        arrowImageView.image = arrowImage
        self.backgroundView = UIView()
        self.backgroundView!.addSubview(arrowImageView)
        self.bringSubviewToFront(backgroundView!)
        
        self.backgroundColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0.1)
    }
    
    /**
    MARK: - horizontal pan gesture methods
    */
     func handlePan(recognizer: UIPanGestureRecognizer) {
        // 1
        if recognizer.state == .Began {
            // when the gesture begins, record the current center location
            originalCenter = center
        }
        // 2
        if recognizer.state == .Changed {
            let translation = recognizer.translationInView(self)
            // Updates the center point of the cell so that cell is animatable when panned
            center = CGPointMake(originalCenter.x + translation.x, originalCenter.y)
            // has the user dragged the item far enough to initiate a delete/Like?
            deleteOnDragRelease = frame.origin.x < -frame.size.width / 3.0
            likeOnDragRelease = frame.origin.x > frame.size.width / 3.0
            // fades the contextual clues
            let cueAlpha = fabs(frame.origin.x) / (frame.size.width / 3.0)
            tickLabel.alpha = cueAlpha
            crossLabel.alpha = cueAlpha
            // indicates when the user has pulled the item far enough to invoke the given action
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
                    dish!.dislike = !dish!.dislike
                    itemLikeLayer.hidden = true
                    itemDislikeLayer.hidden = !dish!.dislike
                    dish!.like = false
                    delegate!.edit()
                    delegate!.handleDealtWithOnLike(dish!)
                }
            } else if likeOnDragRelease {
                if dish != nil {
                    dish!.like = !dish!.like
                    itemLikeLayer.hidden = !dish!.like
                    itemDislikeLayer.hidden = true
                    dish!.dislike = false
                    delegate!.edit()
                    delegate!.handleDealtWithOnDislike(dish!)
                }
            }
            UIView.animateWithDuration(0.3, animations: {self.frame = originalFrame})
        }
    }
    
    
    /**
    MARK: - tap gesture methods
    */
     func handleTap(sender: AnyObject) {
        if delegate != nil && dish != nil {
            delegate!.viewDishInfo(dish!)
        }
    }
    
    
    /**
    Returns true when a gesture should begin
    */
    override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        // pan gesture recognizer
        if let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
            let translation = panGestureRecognizer.translationInView(superview!)
            if fabs(translation.x) > fabs(translation.y) {
                return true
            }
            return false
        }
        // pan gesture recognizer
        if let tapGestureRecognizer = gestureRecognizer as? UITapGestureRecognizer {
            return true
        }
        return false
    }
}
