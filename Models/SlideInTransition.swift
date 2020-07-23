
import UIKit

class SlideInTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresenting = false
     
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 3.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to),
            let fromViewController = transitionContext.viewController(forKey: .from) else { return}
        
        let containerView = transitionContext.containerView
        
        let finalWidth = toViewController.view.bounds.width * 0.9
        let finalHeight = toViewController.view.bounds.height
        
        if isPresenting {
            containerView.addSubview(toViewController.view)
            toViewController.view.frame = CGRect(x: -finalWidth, y: 0, width: finalWidth, height: finalHeight)
        }
         
        let transform = {
            toViewController.view.transform = CGAffineTransform(translationX: finalWidth, y: 0)
        }
        
        let identity = {
            fromViewController.view.transform = .identity
        }
        
       // let duration = transitionDuration(using: transitionContext)
        let isCancelled = transitionContext.transitionWasCancelled
        UIView.animate(withDuration: 0.5, animations: {
            self.isPresenting ? transform() : identity()
        }) { (_) in
            transitionContext.completeTransition(!isCancelled)
        }
        
    }
    
}
