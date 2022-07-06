import UIKit

public extension UIView {
    /// SwifterSwift: Anchor all sides of the view into it's superview.
    @available(iOS 9, *)
    func fillToSuperview(left: CGFloat? = 0, right: CGFloat? = 0, top: CGFloat? = 0, bottom: CGFloat? = 0) {
        // https://videos.letsbuildthatapp.com/
        translatesAutoresizingMaskIntoConstraints = false
        
        guard let superview = superview else {
            return
        }
        left.flatMap { leftAnchor.constraint(equalTo: superview.leftAnchor, constant: $0) }?.isActive = true
        right.flatMap { rightAnchor.constraint(equalTo: superview.rightAnchor, constant: $0) }?.isActive = true
        top.flatMap { topAnchor.constraint(equalTo: superview.topAnchor, constant: $0) }?.isActive = true
        bottom.flatMap { bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: $0) }?.isActive = true
    }
    
    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) -> AnchoredConstraints {
        
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        
        if let top = top {
            anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
        
        if let leading = leading {
            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        
        if let bottom = bottom {
            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }
        
        if let trailing = trailing {
            anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }
        
        if size.width != 0 {
            anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
        }
        
        if size.height != 0 {
            anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
        }
        
        [anchoredConstraints.top, anchoredConstraints.leading,
         anchoredConstraints.bottom, anchoredConstraints.trailing,
         anchoredConstraints.width, anchoredConstraints.height].forEach { $0?.isActive = true }
        
        return anchoredConstraints
    }
    
    @discardableResult
    func fillSuperview(padding: UIEdgeInsets = .zero) -> AnchoredConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        let anchoredConstraints = AnchoredConstraints()
        guard let superviewTopAnchor = superview?.topAnchor,
            let superviewBottomAnchor = superview?.bottomAnchor,
            let superviewLeadingAnchor = superview?.leadingAnchor,
            let superviewTrailingAnchor = superview?.trailingAnchor else {
                return anchoredConstraints
        }
        
        return anchor(top: superviewTopAnchor, leading: superviewLeadingAnchor,
                      bottom: superviewBottomAnchor, trailing: superviewTrailingAnchor, padding: padding)
    }
    
    @discardableResult
    
    func fillSuperviewSafeAreaLayoutGuide(padding: UIEdgeInsets = .zero) -> AnchoredConstraints {
        let anchoredConstraints = AnchoredConstraints()
        if #available(iOS 11.0, *) {
            guard let superviewTopAnchor = superview?.safeAreaLayoutGuide.topAnchor,
                let superviewBottomAnchor = superview?.safeAreaLayoutGuide.bottomAnchor,
                let superviewLeadingAnchor = superview?.safeAreaLayoutGuide.leadingAnchor,
                let superviewTrailingAnchor = superview?.safeAreaLayoutGuide.trailingAnchor else {
                    return anchoredConstraints
            }
            return anchor(top: superviewTopAnchor, leading: superviewLeadingAnchor,
                          bottom: superviewBottomAnchor, trailing: superviewTrailingAnchor, padding: padding)
            
        } else {
            return anchoredConstraints
        }
    }
    
    func center(in view: UIView, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    func centerInSuperview(size: CGSize = .zero) {
        superview.flatMap { center(in: $0, size: size) }
    }
    
    func centerInSuperviewSafeArea() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.safeAreaLayoutGuide.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
        
        if let superviewCenterYAnchor = superview?.safeAreaLayoutGuide.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }
    }
    
    func centerXToSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
    }
    
    @discardableResult
    func centerYToSuperview() -> NSLayoutConstraint? {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            let constraint = centerYAnchor.constraint(equalTo: superviewCenterYAnchor)
            constraint.isActive = true
            return constraint
        }
        return nil
    }
    
    @discardableResult
    func centerYToSuperviewSafeArea() -> NSLayoutConstraint? {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterYAnchor = superview?.safeAreaLayoutGuide.centerYAnchor {
            let constraint = centerYAnchor.constraint(equalTo: superviewCenterYAnchor)
            constraint.isActive = true
            return constraint
        }
        return nil
    }
    
    @discardableResult
    func constrainHeight(_ constant: CGFloat) -> AnchoredConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        anchoredConstraints.height = heightAnchor.constraint(equalToConstant: constant)
        anchoredConstraints.height?.isActive = true
        return anchoredConstraints
    }
    
    @discardableResult
    func constrainWidth(_ constant: CGFloat) -> AnchoredConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        anchoredConstraints.width = widthAnchor.constraint(equalToConstant: constant)
        anchoredConstraints.width?.isActive = true
        return anchoredConstraints
    }
    
    func setupShadow(opacity: Float = 0, radius: CGFloat = 0, offset: CGSize = .zero, color: UIColor = .black) {
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
    }
    
    convenience init(backgroundColor: UIColor = .clear) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
    }
    
}
public extension UIStackView {
    func dapAddBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
   func dapCustomize(backgroundColor: UIColor = .clear, radiusSize: CGFloat = 0) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = backgroundColor
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)

        subView.layer.cornerRadius = radiusSize
        subView.layer.masksToBounds = true
        subView.clipsToBounds = true
    }
}

public extension UIStackView {
    func dapCustomizeShadowCard(backgroundColor: UIColor = .clear, radiusSize: CGFloat = 0, showShadowForCard: Bool = true) -> Self {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = backgroundColor
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)

        subView.layer.cornerRadius = radiusSize
        subView.layer.masksToBounds = true
        subView.clipsToBounds = true
//        subView.shadowForCard()
        return self
    }
    
    func addSubviewsNew(_ views: UIView...) {
        views.forEach { v in
            self.addArrangedSubview(v)
        }
    }
    func addSubviews(_ views: [UIView]) {
        views.forEach { v in
            self.addArrangedSubview(v)
        }
    }
}

public extension UIStackView {
    func dapCustomizeBackgroundColor(backgroundColor: UIColor = .clear) -> Self {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = backgroundColor
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
        return self
    }
}

public extension UIStackView {
    convenience init(axis: NSLayoutConstraint.Axis = .vertical,
                     distribution: Distribution = .fill,
                     alignment: Alignment = .fill,
                     spacing: CGFloat = 0,
                     arrangedSubviews: [UIView]? = nil) {
        self.init()
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
        
        if let subviews = arrangedSubviews {
            subviews.forEach { addArrangedSubview($0) }
        }
    }
    
    func removeAllArrangedSubviews() {
        for subview in arrangedSubviews {
            removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
    }
    
    func addArranged(subview: UIView, spacingBellow: CGFloat) {
        addArrangedSubview(subview)
        setCustomSpacing(spacingBellow, after: subview)
    }
}

public extension UIView {
    func rounded() {
        layer.cornerRadius = frame.width / 2
    }
    // MARK: - Animation
    func shake(delegate: CAAnimationDelegate) {
        let animationKeyPath = "transform.translation.x"
        let shakeAnimation = "shake"
        let duration = 0.6
        let animation = CAKeyframeAnimation(keyPath: animationKeyPath)
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = duration
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0]
        animation.delegate = delegate
        layer.add(animation, forKey: shakeAnimation)
    }
    
    func shadowForCard() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 2
        self.layer.masksToBounds = false
    }
    
    func shadowForBottomCard() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: -2)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 2
        self.layer.masksToBounds = false
    }
    
    func addIconShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 1
        self.layer.masksToBounds = false
    }
    
    func roundWithShadowFrom(image: UIImage) {
            // add the shadow to the base view
            self.backgroundColor = UIColor.clear
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOffset = CGSize(width: 0, height: 1)
            self.layer.shadowOpacity = 0.5
            self.layer.shadowRadius = 1.0
            self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: bounds.width/2).cgPath
            self.layer.shouldRasterize = true
            self.layer.rasterizationScale = UIScreen.main.scale
            
            // add the border to subview
            let borderView = UIView()
            borderView.frame = self.bounds
            borderView.layer.cornerRadius = bounds.width/2
            borderView.layer.masksToBounds = true
            self.addSubview(borderView)
            
            // add any other subcontent that you want clipped
            let otherSubContent = UIImageView()
            otherSubContent.image = image
            otherSubContent.frame = borderView.bounds
            borderView.addSubview(otherSubContent)
    }

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func addSubview(
        _ subview: UIView,
        constrainedTo anchorsView: UIView, widthAnchorView: UIView? = nil, multiplier: CGFloat = 1
        ) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subview.centerXAnchor.constraint(equalTo: anchorsView.centerXAnchor),
            subview.centerYAnchor.constraint(equalTo: anchorsView.centerYAnchor),
            subview.widthAnchor.constraint(equalTo: (widthAnchorView ?? anchorsView).widthAnchor, multiplier: multiplier),
            subview.heightAnchor.constraint(equalTo: anchorsView.heightAnchor, multiplier: multiplier)
            ])
    }
    
    //////////
    // Top
    //////////
    func createTopBorderWithHeight(height: CGFloat, color: UIColor) -> CALayer {
        
        return getOneSidedBorderWithFrame(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: height), color: color)
    }
    
    func createViewBackedTopBorderWithHeight(height: CGFloat, color: UIColor) -> UIView {
        return getViewBackedOneSidedBorderWithFrame(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: height), color: color)
    }
    
    func addTopBorderWithHeight(height: CGFloat, color: UIColor) {
        addOneSidedBorderWithFrame(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: height), color: color)
    }
    
    func addViewBackedTopBorderWithHeight(height: CGFloat, color: UIColor) {
        addViewBackedOneSidedBorderWithFrame(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: height), color: color)
    }
    func addTopBorderWithHeightGradient(height: CGFloat, color: [CGColor]) {
        return createGradientLayer(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: height), currentColorSet: color)
    }
    
    //////////
    // Top + Offset
    //////////
    
    func createTopBorderWithHeight(height: CGFloat, color: UIColor, leftOffset: CGFloat, rightOffset: CGFloat, topOffset: CGFloat) -> CALayer {
        // Subtract the bottomOffset from the height and the thickness to get our final y position.
        // Add a left offset to our x to get our x position.
        // Minus our rightOffset and negate the leftOffset from the width to get our endpoint for the border.
        return getOneSidedBorderWithFrame(
            frame: CGRect(x: 0 + leftOffset, y: 0 + topOffset,
                          width: self.frame.size.width - leftOffset - rightOffset,
                          height: height),
            color: color)
    }
    
    func createViewBackedTopBorderWithHeight(height: CGFloat, color: UIColor, leftOffset: CGFloat, rightOffset: CGFloat, topOffset: CGFloat) -> UIView {
        return getViewBackedOneSidedBorderWithFrame(
            frame: CGRect(x: 0 + leftOffset, y: 0 + topOffset,
                          width: self.frame.size.width - leftOffset - rightOffset, height: height),
            color: color)
    }
    
    func addTopBorderWithHeight(height: CGFloat, color: UIColor, leftOffset: CGFloat, rightOffset: CGFloat, topOffset: CGFloat) {
        // Add leftOffset to our X to get start X position.
        // Add topOffset to Y to get start Y position
        // Subtract left offset from width to negate shifting from leftOffset.
        // Subtract rightoffset from width to set end X and Width.
        addOneSidedBorderWithFrame(
            frame: CGRect(x: 0 + leftOffset, y: 0 + topOffset, width: self.frame.size.width - leftOffset - rightOffset, height: height),
            color: color)
    }
    
    func addViewBackedTopBorderWithHeight(height: CGFloat, color: UIColor, leftOffset: CGFloat, rightOffset: CGFloat, topOffset: CGFloat) {
        addViewBackedOneSidedBorderWithFrame(
            frame: CGRect(x: 0 + leftOffset, y: 0 + topOffset, width: self.frame.size.width - leftOffset - rightOffset, height: height),
            color: color)
    }
    
    //////////
    // Right
    //////////
    
    func createRightBorderWithWidth(width: CGFloat, color: UIColor) -> CALayer {
        return getOneSidedBorderWithFrame(
            frame: CGRect(x: self.frame.size.width-width, y: 0, width: width, height: self.frame.size.height),
            color: color)
    }
    
    func createViewBackedRightBorderWithWidth(width: CGFloat, color: UIColor) -> UIView {
        return getViewBackedOneSidedBorderWithFrame(
            frame: CGRect(x: self.frame.size.width-width, y: 0, width: width, height: self.frame.size.height),
            color: color)
    }
    
    func addRightBorderWithWidth(width: CGFloat, color: UIColor) {
        addOneSidedBorderWithFrame(
            frame: CGRect(x: self.frame.size.width-width, y: 0, width: width, height: self.frame.size.height),
            color: color)
    }
    
    func addViewBackedRightBorderWithWidth(width: CGFloat, color: UIColor) {
        addViewBackedOneSidedBorderWithFrame(
            frame: CGRect(x: self.frame.size.width-width, y: 0, width: width, height: self.frame.size.height),
            color: color)
    }
    
    //////////
    // Right + Offset
    //////////
    
    func createRightBorderWithWidth(width: CGFloat, color: UIColor, rightOffset: CGFloat, topOffset: CGFloat, bottomOffset: CGFloat) -> CALayer {
        // Subtract bottomOffset from the height to get our end.
        return getOneSidedBorderWithFrame(
            frame: CGRect(x: self.frame.size.width-width-rightOffset, y: 0 + topOffset,
                          width: width, height: self.frame.size.height - topOffset - bottomOffset),
            color: color)
    }
    
    func createViewBackedRightBorderWithWidth(width: CGFloat, color: UIColor, rightOffset: CGFloat, topOffset: CGFloat, bottomOffset: CGFloat) -> UIView {
        return getViewBackedOneSidedBorderWithFrame(
            frame: CGRect(x: self.frame.size.width-width-rightOffset, y: 0 + topOffset,
                          width: width, height: self.frame.size.height - topOffset - bottomOffset),
            color: color)
    }
    
    func addRightBorderWithWidth(width: CGFloat, color: UIColor, rightOffset: CGFloat, topOffset: CGFloat, bottomOffset: CGFloat) {
        // Subtract the rightOffset from our width + thickness to get our final x position.
        // Add topOffset to our y to get our start y position.
        // Subtract topOffset from our height, so our border doesn't extend past teh view.
        // Subtract bottomOffset from the height to get our end.
        addOneSidedBorderWithFrame(
            frame: CGRect(x: self.frame.size.width-width-rightOffset, y: 0 + topOffset, width:
                            width, height: self.frame.size.height - topOffset - bottomOffset),
            color: color)
    }
    
    func addViewBackedRightBorderWithWidth(width: CGFloat, color: UIColor, rightOffset: CGFloat, topOffset: CGFloat, bottomOffset: CGFloat) {
        addViewBackedOneSidedBorderWithFrame(
            frame: CGRect(x: self.frame.size.width-width-rightOffset, y: 0 + topOffset,
                          width: width, height: self.frame.size.height - topOffset - bottomOffset),
            color: color)
    }
    
    //////////
    // Bottom
    //////////
    
    func createBottomBorderWithHeight(height: CGFloat, color: UIColor) -> CALayer {
        return getOneSidedBorderWithFrame(
            frame: CGRect(x: 0, y: self.frame.size.height-height, width: self.frame.size.width, height: height),
            color: color)
    }
    
    func createViewBackedBottomBorderWithHeight(height: CGFloat, color: UIColor) -> UIView {
        return getViewBackedOneSidedBorderWithFrame(
            frame: CGRect(x: 0, y: self.frame.size.height-height, width: self.frame.size.width, height: height),
            color: color)
    }
    
    func addBottomBorderWithHeight(height: CGFloat, color: UIColor) {
        return addOneSidedBorderWithFrame(
            frame: CGRect(x: 0, y: self.frame.size.height-height, width: self.frame.size.width, height: height),
            color: color)
    }
    func addBottomBorderWithHeightGradient(height: CGFloat, color: [CGColor]) {
        return createGradientLayer(
            frame: CGRect(x: 0, y: self.frame.size.height-height, width: self.frame.size.width, height: height),
            currentColorSet: color)
    }
    
    func addViewBackedBottomBorderWithHeight(height: CGFloat, color: UIColor) {
        addViewBackedOneSidedBorderWithFrame(
            frame: CGRect(x: 0, y: self.frame.size.height-height, width: self.frame.size.width, height: height),
            color: color)
    }
    
    //////////
    // Bottom + Offset
    //////////
    
    func createBottomBorderWithHeight(height: CGFloat, color: UIColor, leftOffset: CGFloat, rightOffset: CGFloat, bottomOffset: CGFloat) -> CALayer {
        // Subtract the bottomOffset from the height and the thickness to get our final y position.
        // Add a left offset to our x to get our x position.
        // Minus our rightOffset and negate the leftOffset from the width to get our endpoint for the border.
        return getOneSidedBorderWithFrame(
            frame: CGRect(x: 0 + leftOffset, y: self.frame.size.height-height-bottomOffset,
                          width: self.frame.size.width - leftOffset - rightOffset, height: height),
            color: color)
    }
    
    func createViewBackedBottomBorderWithHeight(height: CGFloat, color: UIColor, leftOffset: CGFloat, rightOffset: CGFloat, bottomOffset: CGFloat) -> UIView {
        return getViewBackedOneSidedBorderWithFrame(
            frame: CGRect(x: 0 + leftOffset, y: self.frame.size.height-height-bottomOffset,
                          width: self.frame.size.width - leftOffset - rightOffset, height: height),
            color: color)
    }
    
    func addBottomBorderWithHeight(height: CGFloat, color: UIColor, leftOffset: CGFloat, rightOffset: CGFloat, bottomOffset: CGFloat) {
        // Subtract the bottomOffset from the height and the thickness to get our final y position.
        // Add a left offset to our x to get our x position.
        // Minus our rightOffset and negate the leftOffset from the width to get our endpoint for the border.
        addOneSidedBorderWithFrame(
            frame: CGRect(x: 0 + leftOffset, y: self.frame.size.height-height-bottomOffset,
                          width: self.frame.size.width - leftOffset - rightOffset, height: height),
            color: color)
    }
    
    func addViewBackedBottomBorderWithHeight(height: CGFloat, color: UIColor, leftOffset: CGFloat, rightOffset: CGFloat, bottomOffset: CGFloat) {
        addViewBackedOneSidedBorderWithFrame(
            frame: CGRect(x: 0 + leftOffset, y: self.frame.size.height-height-bottomOffset,
                          width: self.frame.size.width - leftOffset - rightOffset, height: height),
            color: color)
    }
    
    //////////
    // Left
    //////////
    
    func createLeftBorderWithWidth(width: CGFloat, color: UIColor) -> CALayer {
        return getOneSidedBorderWithFrame(
            frame: CGRect(x: 0, y: 0, width: width, height: self.frame.size.height),
            color: color)
    }
    
    func createViewBackedLeftBorderWithWidth(width: CGFloat, color: UIColor) -> UIView {
        return getViewBackedOneSidedBorderWithFrame(
            frame: CGRect(x: 0, y: 0, width: width, height: self.frame.size.height),
            color: color)
    }
    
    func addLeftBorderWithWidth(width: CGFloat, color: UIColor) {
        addOneSidedBorderWithFrame(
            frame: CGRect(x: 0, y: 0, width: width, height: self.frame.size.height),
            color: color)
    }
    
    func addViewBackedLeftBorderWithWidth(width: CGFloat, color: UIColor) {
        addViewBackedOneSidedBorderWithFrame(
            frame: CGRect(x: 0, y: 0, width: width, height: self.frame.size.height),
            color: color)
    }
    
    //////////
    // Left + Offset
    //////////
    
    func createLeftBorderWithWidth(width: CGFloat, color: UIColor, leftOffset: CGFloat, topOffset: CGFloat, bottomOffset: CGFloat) -> CALayer {
        return getOneSidedBorderWithFrame(
            frame: CGRect(x: 0 + leftOffset, y: 0 + topOffset, width: width, height: self.frame.size.height - topOffset - bottomOffset),
            color: color)
    }
    
    func createViewBackedLeftBorderWithWidth(width: CGFloat, color: UIColor, leftOffset: CGFloat, topOffset: CGFloat, bottomOffset: CGFloat) -> UIView {
        return getViewBackedOneSidedBorderWithFrame(
            frame: CGRect(x: 0 + leftOffset, y: 0 + topOffset, width: width, height: self.frame.size.height - topOffset - bottomOffset),
            color: color)
    }
    
    func addLeftBorderWithWidth(width: CGFloat, color: UIColor, leftOffset: CGFloat, topOffset: CGFloat, bottomOffset: CGFloat) {
        addOneSidedBorderWithFrame(
            frame: CGRect(x: 0 + leftOffset, y: 0 + topOffset, width: width, height: self.frame.size.height - topOffset - bottomOffset),
            color: color)
    }
    
    func addViewBackedLeftBorderWithWidth(width: CGFloat, color: UIColor, leftOffset: CGFloat, topOffset: CGFloat, bottomOffset: CGFloat) {
        addViewBackedOneSidedBorderWithFrame(
            frame: CGRect(x: 0 + leftOffset, y: 0 + topOffset, width: width, height: self.frame.size.height - topOffset - bottomOffset),
            color: color)
    }
    
    //////////
    // Private: Our methods call these to add their borders.
    //////////
    
    private func addOneSidedBorderWithFrame(frame: CGRect, color: UIColor) {
        let border = CALayer()
        border.frame = frame
        border.backgroundColor = color.cgColor
        self.layer.addSublayer(border)
    }
    
    func createGradientLayer(frame: CGRect, currentColorSet: [CGColor], locations: [NSNumber] = [0.0, 1], startPoint: CGPoint = CGPoint(x: 0.0, y: 0.5), endPoint: CGPoint = CGPoint(x: 1.0, y: 0.5)) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        
        gradientLayer.colors = currentColorSet
        gradientLayer.locations = locations
        
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        
        self.layer.addSublayer(gradientLayer)
    }
    
    private func getOneSidedBorderWithFrame(frame: CGRect, color: UIColor) -> CALayer {
        let border = CALayer()
        border.frame = frame
        border.backgroundColor = color.cgColor
        return border
    }
    
    private func addViewBackedOneSidedBorderWithFrame(frame: CGRect, color: UIColor) {
        let border = UIView(frame: frame)
        border.backgroundColor = color
        self.addSubview(border)
    }
    
    private func getViewBackedOneSidedBorderWithFrame(frame: CGRect, color: UIColor) -> UIView {
        let border = UIView(frame: frame)
        border.backgroundColor = color
        return border
    }
}
