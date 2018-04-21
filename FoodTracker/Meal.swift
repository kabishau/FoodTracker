import UIKit


// to conform NSCoding Meal needs to subclass NSObject
class Meal: NSObject, NSCoding {
    
    //MARK: Properties
    
    struct PropertyKey {
        
        // static indicates that the constant belong to struct itself, not the instance of the structure
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //MARK: Initialization
    
    init?(name: String, photo: UIImage?, rating: Int) {
        
        // name must be not empty
        guard !name.isEmpty else {
            return nil
        }
        
        // rating must be between 0 and 5
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        self.name = name
        self.photo = photo
        self.rating = rating
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
    }
}
