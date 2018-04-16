import UIKit

class Meal {
    
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //MARK: Initialization
    
    init?(name: String, photo: UIImage?, rating: Int) {
        
        // initialization should fail if there is no name or if the rating is negative
        if name.isEmpty || rating < 0 {
            return nil
        }
        
        self.name = name
        self.photo = photo
        self.rating = rating
    }
}