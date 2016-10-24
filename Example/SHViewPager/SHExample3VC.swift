//
//  SHExample3VC.swift
//  SHViewPager
//
//  Created by shabib hossain on 8/28/16.
//  Copyright © 2014-2016 Code with Shabib. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining
//  a copy of this software and associated documentation files (the "Software"),
//  to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish,
//  distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to
//  the following conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
//  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
//  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
//  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import UIKit
import SHViewPager

class SHExample3VC: UIViewController {

    @IBOutlet fileprivate var pager: SHViewPager!
    fileprivate var menuItems = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuItems = ["menu 1", "menu 2", "menu 3", "menu 4", "menu 5", "menu 6", "menu 7", "menu 8", "menu 9"]
        pager.reloadData()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        // fixes bug for scrollview's content offset reset.
        // check SHViewPager's reloadData method to get the idea.
        // this is a hacky solution, any better solution is welcome.
        // check closed issues #1 & #2 for more details.
        // this is the example to fix the bug, to test this
        // comment out the following lines
        // and check what happens.
        pager.pagerWillLayoutSubviews()
    }
}

// MARK: - SHViewPagerDataSource

extension SHExample3VC: SHViewPagerDataSource {
    
    func numberOfPages(in viewPager: SHViewPager) -> Int {
        return menuItems.count
    }
    
    func containerController(for viewPager: SHViewPager) -> UIViewController {
        return self
    }
    
    func viewPager(_ viewPager: SHViewPager, controllerForPageAt index: Int) -> UIViewController {
        
        let contentVC = SHContentViewController(nibName: "SHContentViewController", bundle: nil)
        contentVC.menuIndex = index + 1
        contentVC.selectionIndicatorString = "Currently Selected :index \(index + 1)"
        return contentVC
    }
    
    func viewPager(_ viewPager: SHViewPager, titleForPageMenuAt index: Int) -> String {
        return menuItems[index] 
    }
}

// MARK: - SHViewPagerDelegate

extension SHExample3VC: SHViewPagerDelegate {
    
    func indexIndicatorImage(for viewPager: SHViewPager) -> UIImage {
        return UIImage(named: "IndexIndicatorIcon")!
    }
    
    func indexIndicatorImageDuringScrollAnimation(for viewPager: SHViewPager) -> UIImage {
        return UIImage(named: "IndexIndicatorMovingIcon")!
    }
    
    func menuWidthType(in viewPager: SHViewPager) -> SHViewPagerMenuWidthType {
        return .default
    }
    
    func firstContentPageLoaded(for viewPager: SHViewPager) {
        print("first viewcontroller content loaded")
    }
    
    func viewPager(_ viewPager: SHViewPager, willMoveToPageAt toIndex: Int, from fromIndex: Int) {
        print("content will move to page \(toIndex) from page: \(fromIndex)");
    }
    
    func viewPager(_ viewPager: SHViewPager, didMoveToPageAt toIndex: Int, from fromIndex: Int) {
        print("content moved to page \(toIndex) from page: \(fromIndex)");
    }
}
