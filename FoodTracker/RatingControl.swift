import UIKit

class RatingControl: UIStackView {

    //MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setButtons()
    }
    
    //MARK: Button Action
    
    @objc func ratingButtonTapped(button: UIButton) {
        print("Button Tapped")
    }
    
    //MARK: Private Methods
    
    private func setButtons() {
        
        let button = UIButton()
        button.backgroundColor = UIColor.red
        
        // add constraints
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.widthAnchor.constraint(equalToConstant: 44).isActive = true
        
        // set up the button action
        button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: UIControlEvents.touchUpInside)
        
        // add button view to the list of views managed by the RatingControl stack view
        addArrangedSubview(button)
        
        
    }

}
