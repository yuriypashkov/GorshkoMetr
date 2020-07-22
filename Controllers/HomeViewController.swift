//
//  MainViewController.swift
//  GorshkoMetr
//
//  Created by Yuriy Pashkov on 6/11/20.
//  Copyright © 2020 Yuriy Pashkov. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var menuViewController: UIViewController!
    
    let transition = SlideInTransition()
    //var menuShow = false
    
    @IBOutlet weak var backImage: UIImageView!
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    @IBAction func newTapMenu(_ sender: UIButton) {
        //guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") else { return }
        //if #available(iOS 13, *) { menuViewController.modalPresentationStyle = .fullScreen }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true, completion: nil)
    }
    
    @objc func tap(_ sender: AnyObject) {
        print("TAP VIEW")
        menuViewController.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController")
        //попробую отслеживать тап на вьюху
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.tap(_:)))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    

}

extension HomeViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
}
