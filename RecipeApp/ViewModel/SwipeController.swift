//
//  SwipeController.swift
//  RecipeApp
//
//  Created by Avital Miskella on 15/9/19.
//  Copyright © 2019 Avital Miskella. All rights reserved.
//

import UIKit

class SwipeController: UIPageViewController,UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var recipeIndex:Int = 0

    func newVcIng(viewController: String) -> SwipeIngViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController) as! SwipeIngViewController
    }
    func newVcMeth(viewController: String) -> SwipeMethodViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController) as! SwipeMethodViewController
    }
    
//    lazy var orderedViewControllers: [SwipeViewController] = {
//        return [self.newVc(viewController: "IngredientsTable"),
//                self.newVc(viewController: "MethodTable")]
//        }()
    lazy var ingController: SwipeIngViewController = {
        return self.newVcIng(viewController: "IngredientsTable")
    }()
    lazy var methodController: SwipeMethodViewController = {
        return self.newVcMeth(viewController: "MethodTable")
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        
        let firstViewController = ingController
        setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        ingController.recipeIndex = recipeIndex
        methodController.recipeIndex = recipeIndex
    
    }
        
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController ) else {
//            return nil
//        }
//        let previousIndex = viewControllerIndex - 1
//
//        // User is on the first view controller and swiped left to loop to
//        // the last view controller.
//        guard previousIndex >= 0 else {
//            //do not loop
//            return nil
//        }
//
//        guard orderedViewControllers.count > previousIndex else {
//            return nil
//        }
//
//        return orderedViewControllers[previousIndex]
        return ingController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
//            return nil
//        }
//
//        let nextIndex = viewControllerIndex + 1
//        let orderedViewControllersCount = orderedViewControllers.count
//
//        // User is on the last view controller and swiped right to loop to
//        // the first view controller.
//        guard orderedViewControllersCount != nextIndex else {
//            return orderedViewControllers.first
//            // Uncommment the line below, remove the line above if you don't want the page control to loop.
//            // return nil
//        }
//
//        guard orderedViewControllersCount > nextIndex else {
//            return nil
//        }
//
//        return orderedViewControllers[nextIndex]
         return methodController
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
