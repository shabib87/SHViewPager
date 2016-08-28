//
//  SHBaseView_.swift
//  Pods
//
//  Created by shabib hossain on 8/29/16.
//
//

import UIKit
import PodAsset

class SHBaseView_: UIView {
    
    private var containerView: UIView!
    private var customConstraints = [NSLayoutConstraint]()

    /**
     Constructor method to create a view from xib file
     
     - parameter nibname: name of the xib file
     */
    func commonInitWithNibName(nibName: String) {
        
        self.backgroundColor = UIColor.clearColor()
        let contentView = viewWithNibName(nibName)
        self.customConstraints = [];
        setSubview(contentView)
    }
    
    /**
     Constructor method to create a base view from a view object
     
     - parameter contentView: the view object
     */
    func commonInitWithView(contentView: UIView) {
        self.customConstraints = [];
        setSubview(contentView)
    }
    
    private func setSubview(view: UIView!) {
        if view != nil {
            self.containerView = view
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
            self.setNeedsUpdateConstraints()
        }
    }
    
    private func viewWithNibName(nibName: String) -> UIView! {
        var view: UIView!
        var bundlePath = PodAsset.bundlePathForPod("SHViewPager")
        var bundle = NSBundle(path: bundlePath)
        var objects = bundle?.loadNibNamed(nibName, owner: self, options: nil)
        for object in objects! as [AnyObject] {
            if object is UIView {
                view = object as! UIView
                break
            }
        }
        return view;
    }
    
    private func clearConstraints () {
        self.removeConstraints(self.customConstraints)
        self.customConstraints.removeAll()
    }
    
    override func updateConstraints() {
        clearConstraints()
        if self.containerView != nil {
            setViewConstraints()
        }
        super.updateConstraints()
    }
    
    private func setViewConstraints () {
        let view = self.containerView;
        var views = ["view" : view]
        self.customConstraints.appendContentsOf(NSLayoutConstraint.constraintsWithVisualFormat("H:|[view]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.customConstraints.appendContentsOf(NSLayoutConstraint.constraintsWithVisualFormat("V:|[view]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.addConstraints(self.customConstraints)
    }
}
