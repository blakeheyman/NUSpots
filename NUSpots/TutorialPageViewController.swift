//
//  TutorialPageViewController.swift
//  NUSpots
//
//  Created by Blake Heyman on 4/13/21.
//

import UIKit

class TutorialPageViewController: UIPageViewController {
    
    var vcs: [UIViewController] = []
    var pageControl = UIPageControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        self.delegate = self
        
        self.vcs = generateTutorialControllers()
        self.configurePageControl()
        // Do any additional setup after loading the view.
        
        if let firstViewController = vcs.first {
            setViewControllers([firstViewController],
                direction: .forward,
                animated: true,
                completion: nil)
        }
    }
    
    func configurePageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 125,width: UIScreen.main.bounds.width,height: 50))
        self.pageControl.numberOfPages = vcs.count
        self.pageControl.currentPage = 0
        self.pageControl.alpha = 1.0
        //self.pageControl.tintColor = UIColor.black
        self.pageControl.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        self.pageControl.pageIndicatorTintColor = UIColor.lightGray
        self.pageControl.currentPageIndicatorTintColor = UIColor.red
        self.pageControl.isUserInteractionEnabled = false
//        self.pageControl.layer.shadowRadius = 10
//        self.pageControl.layer.shadowOffset = CGSize(width: 5, height: 5)
//        self.pageControl.layer.shadowColor = UIColor.black.cgColor
//        self.pageControl.layer.shadowOpacity = 1.0
        self.view.addSubview(pageControl)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = vcs.firstIndex(of: pageContentViewController)!
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func generateTutorialControllers() -> [UIViewController] {
        var vcs: [UIViewController] = []
        for n in 1...6 {
            let vc = UIViewController()
            vc.view.backgroundColor = .red
            let tutorialImage = UIImage(named: "Tutorial\(n)") ?? UIImage()
            let imageView = UIImageView(image: tutorialImage)
            
            vc.view.addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor).isActive = true
            imageView.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor).isActive = true
            imageView.topAnchor.constraint(equalTo: vc.view.topAnchor).isActive = true
            imageView.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor).isActive = true
            imageView.contentMode = .scaleAspectFill
            vcs.append(vc)
        }
        
        // Add button to last vc
        
        if let vc = vcs.last {
            let button = UIView()
            let label = UILabel()
            button.addSubview(label)
            vc.view.addSubview(button)
            
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .white
            label.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
            label.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
            label.text = "Get Started"
            label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)

            button.translatesAutoresizingMaskIntoConstraints = false
            button.isUserInteractionEnabled = true
            button.layer.cornerRadius = 25
            button.backgroundColor = .red
            button.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
            button.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor, constant: -200).isActive = true
            button.widthAnchor.constraint(equalToConstant: 200).isActive = true
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
            button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(startedTapped(sender:))))
        }
        return vcs
    }
    
    @objc func startedTapped(sender: Any) {
        self.dismiss(animated: true, completion: {
            UserDefaults.standard.setValue(true, forKey: "tutorialComplete")
        })
    }
}

extension TutorialPageViewController: UIPageViewControllerDelegate {
    
}

extension TutorialPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = vcs.firstIndex(of: viewController) else {
            return nil
        }
        
        if viewControllerIndex - 1 < 0 { return nil }
        
        return vcs[viewControllerIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        guard let viewControllerIndex = vcs.firstIndex(of: viewController) else {
            return nil
        }
        
        if viewControllerIndex + 1 == vcs.count { return nil }
        
        return vcs[viewControllerIndex + 1]
    }
}
