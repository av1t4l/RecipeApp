//
//  SwipeController.swift
//  RecipeApp
//
//  Created by Avital Miskella on 15/9/19.
//  Copyright © 2019 Avital Miskella. All rights reserved.
//

import UIKit

class SwipeController: UIPageViewController,UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var recipeIndex:Int = 0 //current recipe
    var viewModel: RecipeCollectionViewModel!

    /** To create new ViewController and register with the View **/
    //using a super class "BaseViewController" so that data can be passed into the UIViewControllers
    func newVC(viewController: String) -> UIViewController {
        if let vc: BaseViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController) as? BaseViewController {
            vc.recipeIndex = recipeIndex
            let _ = vc.view
            vc.bindViewModel(viewModel: viewModel)
            return vc
        }
        return UIViewController()
    }
    func bindViewModel(viewModel: RecipeCollectionViewModel) {
        self.viewModel = viewModel
    }
    
    // create array for the two views the ppageViewController swipes between
    lazy var VCTablesArray: [UIViewController] = {
        return [self.newVC(viewController: "IngredientsTable"),
                self.newVC(viewController: "MethodTable")]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set delegate for PageViewController
        self.delegate = self
        self.dataSource = self
        
        //set the first view
        if let firstViewController = VCTablesArray.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
  
    /** Built In Function:
     Get view for swipe left **/
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let VCIndex = VCTablesArray.firstIndex(of: viewController ) else {
            return nil
        }
        let previousIndex = VCIndex - 1
        
        //perform checks
        //to stop loop
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard VCTablesArray.count > previousIndex else {
            return nil
        }
        //return View to display
        return VCTablesArray[previousIndex]
    }
    
    /** Built In Function:
     Get view for swipe right **/
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = VCTablesArray.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        //perform checks
        guard VCTablesArray.count != nextIndex else {
            return nil
        }
        guard VCTablesArray.count > nextIndex else {
            return nil
        }
        //return View to display
        return VCTablesArray[nextIndex]
    }
    /** Built In Function **/
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
    }
    
}
