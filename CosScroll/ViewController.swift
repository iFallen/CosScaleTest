//
//  ViewController.swift
//  CosScroll
//
//  Created by Juan Felix on 2020/12/15.
//

import UIKit

extension UIView {
    func setX(_ x: CGFloat) {
        var center = self.center
        center.x = x
        self.center = center
    }
}

class ViewController: UIViewController {
    private let testView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        testView.backgroundColor = UIColor.systemBlue
        view.addSubview(testView)
        testView.frame = CGRect(x: 0, y: 0, width: mWidth, height: UIScreen.main.bounds.size.height / 1.5)
        testView.layer.cornerRadius = 5
        testView.center = view.center
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panGesture(gesture:)))
        view.addGestureRecognizer(pan)
    }
    private let centerX = UIScreen.main.bounds.width / 2
    private let mWidth = UIScreen.main.bounds.size.width / 1.5
    private var beginPoint: CGPoint = .zero
    
    @objc
    private func panGesture(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            beginPoint = gesture.location(in: self.view)
        case .changed:
            let currentPoint = gesture.location(in: self.view)
            // Line scale
            /*
            do {
                let zoneX = centerX * 5
                let offset = currentPoint.x - beginPoint.x
                var finalX = testView.center.x + offset
                if abs(finalX) > zoneX {
                    if finalX < 0 {
                        finalX = -zoneX
                    } else {
                        finalX = zoneX
                    }
                }
                testView.setX(finalX)
                let dt = abs(testView.center.x - centerX)
                let scale = 1 - dt / zoneX
                testView.layer.transform = CATransform3DMakeScale(scale, scale, 1)
            }*/
            // Curve Scale
            do {
                let zoneX = centerX * 5
                let offset = currentPoint.x - beginPoint.x
                var finalX = testView.center.x + offset
                if abs(finalX) > zoneX {
                    if finalX < 0 {
                        finalX = -zoneX
                    } else {
                        finalX = zoneX
                    }
                }
                testView.setX(finalX)
                let dt = abs(testView.center.x - centerX)
                let scale = abs(cos((dt / zoneX) * (CGFloat.pi / 2)))
                testView.layer.transform = CATransform3DMakeScale(scale, scale, 1)
            }
            beginPoint = currentPoint
        default:
            break
        }
    }


}

