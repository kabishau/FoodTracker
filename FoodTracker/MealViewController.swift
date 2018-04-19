import UIKit
// this imports unified logging system (lets send messages to the console)
import os.log

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Properties
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    // this value is either passed by MealTableViewController in prepare(for:sender:) orconstructed as part of adding a new meal
    var meal: Meal?
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // resigning the textField's first-responder status - hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    // this method is called right after the text field resign its first-responder status
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    // method is called when user starts editing session or keyboard get displayed
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        // disable the save button while editing
        saveButton.isEnabled = false
    }
    
    //MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // dismiss the picker if user canceled
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        photoImageView.image = selectedImage
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Navigation
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
        // dismiss modal scene and animates the transition back to the previous scene
        dismiss(animated: true, completion: nil)
    }
    
    // this method lets you configure a view controller before it's presented
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // UIViewController doesn't do anything but it's a good habit in case if it is different class
        super.prepare(for: segue, sender: sender)
        
        // configure the destination view controller when the save button is pressed
        guard let button = sender as? UIBarButtonItem,
            button === saveButton else {
                os_log("The save button was not pressed, cancelling", log: OSLog.default, type: OSLogType.debug)
                return
        }
        
        // using nil coalescing operator ??
        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating
        
        // set the meal to be passed to MealTableViewController after the unwind segue
        meal = Meal(name: name, photo: photo, rating: rating)
    }
    
    //MARK: Actions
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        // hide the keyboard if user taps imageView when typing in the text view
        nameTextField.resignFirstResponder()
        
        // this allow user to pick image from media galery
        let imagePickerController = UIImagePickerController()
        
        // only allow photos to be picked, not taken
        imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        // setting the delegate
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // handle the field's user input through delegate callbacks
        // when ViewController instance is loaded, it sets itself as the delegate of its nameTextField property
        nameTextField.delegate = self
        
        // enable the save button only if the text field has a valid Meal name
        updateSaveButtonState()
        
    }
    
    //MARK: Private Methods
    
    // helper method
    private func updateSaveButtonState() {
        
        // disable the save button if the text field is empty
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }

}

