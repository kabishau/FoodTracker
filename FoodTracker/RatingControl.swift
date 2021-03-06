import UIKit

// @IBDesignable lets IB instantiate and draw a copy of your control directly in the canvas
@IBDesignable class RatingControl: UIStackView {
    
    //MARK: Properties
    
    private var ratingButtons = [UIButton]()
    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    // add properties that can then be set in the Attributes inspector (@IBInspectable)
    // making code more generic
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }
    @IBInspectable var statCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }

    //MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    //MARK: Button Action
    
    @objc func ratingButtonTapped(button: UIButton) {
        
        guard let index = ratingButtons.index(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        
        // calculate the rating of selected button
        let selectedRating = index + 1
        
        // update rating depending on selected button
        if selectedRating == rating {
            // reset the rating to 0 if user clicked current rating
            rating = 0
        } else {
            // otherwise set new rating to the selected star
            rating = selectedRating
        }
        
    }
    
    //MARK: Private Methods
    
    private func setupButtons() {
        
        // clear any axisting buttons in case of using property observers on starCount and starSize
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        
        ratingButtons.removeAll()
        
        // load Button Images
        let bundle = Bundle(for: type(of: self))
        // images can be loaded using the shorter UIImage(named:) but because the control is @IBDesignable, the setup code also needs to run in Interface Builder (you must explicitly specify the catalog’s bundle)
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        
        //creating five buttons
        for _ in 0..<statCount {
            
            let button = UIButton()
            
            // set the button images for different states
            button.setImage(emptyStar, for: UIControlState.normal)
            button.setImage(filledStar, for: UIControlState.selected)
            button.setImage(highlightedStar, for: UIControlState.highlighted)
            button.setImage(highlightedStar, for: [UIControlState.selected, UIControlState.highlighted])
            
            // add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            // set up the button action
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: UIControlEvents.touchUpInside)
            
            // add button view to the list of views managed by the RatingControl stack view
            addArrangedSubview(button)
            
            // add newly created in loop button to the ratingButton array
            ratingButtons.append(button)
            
            updateButtonSelectionStates()
        }
    }
    
    private func updateButtonSelectionStates() {
        
        for (index, button) in ratingButtons.enumerated() {
            // if the index of a button is less than the rating, that button should be selected
            button.isSelected = index < rating
        }
    }
}
