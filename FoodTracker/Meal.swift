import UIKit
import os.log

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
    
    //MARK: Archiving Paths
    
    // mark these constants static we set to belong to the class, so we make sure it will be just one copy of these objects no matter how many instances of the class will exist
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
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
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // the name is required; if we can't decode a name string, the initializer should fail
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: .default, type: .debug)
            return nil
        }
        
        
        // because photo is an optional property of Meal, just use conditional cast
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        // using decodeInteger instead of decodeObject
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        
        self.init(name: name, photo: photo, rating: rating)
        
    }
}




