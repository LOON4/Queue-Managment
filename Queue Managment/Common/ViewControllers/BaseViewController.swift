//
//  BaseViewController.swift
//  Queue Managment
//
//  Created by WINTAA on 06.07.22.
//
import UIKit

open class BaseViewController<ViewType: UIView>: UIViewController, ControllerProtocol, UIParentChangeListener {
    public var currentView: ViewType {
        return view as! ViewType
    }
    
    private let viewCreator: () -> ViewType
    
    public init(viewCreator: @escaping () -> ViewType = { ViewType() }) {
        self.viewCreator = viewCreator
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func loadView() {
        view = viewCreator()
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        uiUpdated(animated: false)
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (view as? ScreenNavigationEventListener)?.willAppear(animated: animated)
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        (view as? ScreenNavigationEventListener)?.didAppear(animated: animated)
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        (view as? ScreenNavigationEventListener)?.willDisappear(animated: animated)
    }
    
    open func uiUpdated(animated: Bool) {
        title = (view as? PageRootView)?.pageTitle
    }
}

public protocol ControllerProtocol {
    associatedtype ViewType
    var currentView: ViewType { get }
}


public protocol ScreenNavigationEventListener {
    func willAppear(animated: Bool)
    func didAppear(animated: Bool)
    func willDisappear(animated: Bool)
}

public extension ScreenNavigationEventListener {
    func willAppear(animated: Bool) { }
    func didAppear(animated: Bool) { }
    func willDisappear(animated: Bool) { }
}


public protocol UIParentChangeListener {
    func uiUpdated(animated: Bool)
}

public extension UIView {
    func firstParentChangeListener() -> UIParentChangeListener? {
        var resp = next
        while resp != nil {
            if let listener = resp as? UIParentChangeListener {
                return listener
            }
            resp = resp?.next
        }
        return nil
    }
}

public protocol PageRootView {
    var pageTitle: String? { get }
}
