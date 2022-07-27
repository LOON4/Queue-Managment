//
//  ViewController.swift
//  Queue Managment
//
//  Created by WINTAA on 21.06.22.
//
//swiftlint
import UIKit
import Resolver
import Combine

class SplashScreenController: UIViewController {

    @IBOutlet weak var background: UIView!
    
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var backgroundTopEqualsSafeAreTop: NSLayoutConstraint!
    @IBOutlet weak var backgroundTopEqualsSuperViewBottom: NSLayoutConstraint!
    
    @IBOutlet weak var horizontalRectangleOnScreen: NSLayoutConstraint!
    @IBOutlet weak var horizontalRectangleOffScreen: NSLayoutConstraint!
    
    @IBOutlet weak var elipseTrailingsDistanceFromSuperViewsLeading: NSLayoutConstraint!
    
    @IBOutlet weak var polygonLeadingDistanceFromSuperviewTrailing: NSLayoutConstraint!
    
    @IBOutlet weak var verticalRectangleTrailingDistanceFromSuperViewsLeading: NSLayoutConstraint!
    @IBOutlet weak var verticalRectangleFarFromAppLabelName: NSLayoutConstraint!
    @IBOutlet weak var verticalRectrangleNearAppLabelName: NSLayoutConstraint!
    
    private var loader: LoaderView!
    
    @LazyInjected private var splashScreenViewModel: SplashScreenViewModel
    private var bindings = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoader()
        registerDependencies()
        scaleAppNameLabel()
        setUpBindings()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateSplashScreen()
        showLoginScreen()
    }
    
    private func setUpBindings(){
        func bindViewModelToView() {
            splashScreenViewModel.$userStatus
                .sink(){ [self] receivedValue in
                    if receivedValue == .sessionRestored{
                        splashScreenViewModel.router.showFirstScreen(firstScreen: .profileVC)
                    } else if receivedValue != nil {
                        splashScreenViewModel.router.showFirstScreen(firstScreen: .loginVC)

                    }
                }
                .store(in: &bindings)
            
            splashScreenViewModel.$isLoading
                .sink(){ [weak self] receivedValue in
                    if receivedValue {
                        self?.loader.startLoader()
                    } else {
                        self?.loader.stopLoader()
                    }
                }.store(in: &bindings)
        }
        bindViewModelToView()
    }

    private func setupLoader(){
        loader = LoaderView(view)
    }
    
    private func registerDependencies(){
        splashScreenViewModel.router = Resolver.resolve(OnboardingRouter.self, args: self)
    }
    
    private func animateSplashScreen() {
        animateBackgroundSink()
        animateAppNameLabel()
        animateFigures()
    }
    
    private func animateFigures(){
        UIView.animate(withDuration: 1) {
            self.horizontalRectangleOffScreen.priority = UILayoutPriority.defaultLow
            self.horizontalRectangleOnScreen.priority = UILayoutPriority.defaultHigh
            
            self.elipseTrailingsDistanceFromSuperViewsLeading.constant = -20
            
            self.polygonLeadingDistanceFromSuperviewTrailing.constant = 38
            
            self.verticalRectangleTrailingDistanceFromSuperViewsLeading.constant = -self.view.center.x
            self.verticalRectangleFarFromAppLabelName.priority = UILayoutPriority.defaultLow
            self.verticalRectrangleNearAppLabelName.priority = UILayoutPriority.defaultHigh
            self.view.layoutIfNeeded()
        }
    }
    
    private func animateBackgroundSink() {
        UIView.animate(withDuration: 1) {
            self.backgroundTopEqualsSafeAreTop.priority = UILayoutPriority.defaultLow
            self.backgroundTopEqualsSuperViewBottom.priority = UILayoutPriority.defaultHigh
            self.view.layoutIfNeeded()
        }
    }
    
    private func animateAppNameLabel() {
        UIView.animate(withDuration: 1){
            self.appNameLabel.transform = .identity
            self.appNameLabel.alpha = 1
            self.view.layoutIfNeeded()
        }
    }
    
    private func scaleAppNameLabel() {
        appNameLabel.transform = CGAffineTransform(scaleX: 0.1 , y: 0.1)
    }
        
    private func  showLoginScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            self.splashScreenViewModel.determineUserStatus()
        }
    }
}

