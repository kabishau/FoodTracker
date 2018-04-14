import UIKit

// @IBDesignable lets IB instantiate and draw a copy of your control directly in the canvas
@IBDesignable class RatingControl: UIStackView {
    
    //MARK: Properties
    
    private var ratingButtons = [UIButton]()
    var rating = 0
    
    // add properties that can then be set in the Attributes inspector (@IBInspectable)
    // making code more generic
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0)
    @IBInspectable var statCount: Int = 5

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
        print("Button Tapped")
    }
    
    //MARK: Private Methods
    
    private func setupButtons() {
        
        //creating five buttons
        for _ in 0..<statCount {
            
            let button = UIButton()
            button.backgroundColor = UIColor.red
            
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
        }
    }
}
