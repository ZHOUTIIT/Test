//
//  FirstTabBarSelectionViewController.swift
//  demo
//
//  Created by Zhou Ti on 11/21/15.
//  Copyright © 2015 Zhou Ti. All rights reserved.
//

import UIKit

class FirstTabBarSelectionViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let imagePickerController: UIImagePickerController = UIImagePickerController()
    @IBOutlet var navigationbar: UINavigationItem!
    @IBOutlet var personal: UIView!
    @IBOutlet var whatup: UILabel!
    
    @IBOutlet var introduction: UIView!
    @IBOutlet var edit: UIButton!
    @IBOutlet var profileimage: UIImageView!
    @IBOutlet var history: UIView!
    @IBOutlet var selection: UISegmentedControl!

    @IBOutlet var background: UIImageView!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        if ((NSUserDefaults.standardUserDefaults().valueForKey("backgroundimage") ) == nil){
            background.image = UIImage(named: "j.png")
        }
        else{
            
            background.image = UIImage(data: NSUserDefaults.standardUserDefaults().valueForKey("backgroundimage") as! NSData)!
        }
        
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        let navigationTitleAttribute : NSDictionary = NSDictionary(object: UIColor.whiteColor(),forKey: NSForegroundColorAttributeName)
        self.navigationController?.navigationBar.titleTextAttributes = navigationTitleAttribute as? [String : AnyObject]
        whatup.numberOfLines = 0
        whatup.lineBreakMode = NSLineBreakMode.ByWordWrapping
        if ((NSUserDefaults.standardUserDefaults().valueForKey("whatup")) != nil){
            whatup.text = NSUserDefaults.standardUserDefaults().valueForKey("whatup") as? String
        }
        
        
        edit.layer.borderColor = UIColor(red: 0x0b/255, green: 0xa9/255, blue: 0x29/255, alpha: 1).CGColor
        edit.layer.borderWidth = 1
        edit.layer.cornerRadius = 10
        navigationbar.title = NSUserDefaults.standardUserDefaults().valueForKey("UserNameKey") as? String
        //        profileimage.image = UIImage(data: NSUserDefaults.standardUserDefaults().valueForKey("profileimage") as! NSData)
        
        //           whatup.text = NSUserDefaults.standardUserDefaults().valueForKey("whatup") as? String
        if ((NSUserDefaults.standardUserDefaults().valueForKey("profileimage")) != nil){
            let image = NSUserDefaults.standardUserDefaults().valueForKey("profileimage") as! NSData
            
            profileimage.image = UIImage(data: image)
        }
        else{
            profileimage.image = UIImage(named: "d.jpg")
        }
        personal.hidden = false
        history.hidden = true
        
        //        navigationbar.title = NSUserDefaults.standardUserDefaults().valueForKey("UserNameKey") as? String
        
    }
    @IBAction func changesegment(sender: UISegmentedControl) {
        switch selection.selectedSegmentIndex
        {
        case 0:
            personal.hidden = false
            history.hidden = true
        case 1:
            personal.hidden = true
            history.hidden = false
        default:
            break;
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //self.isFullScreen = !self.isFullScreen
        
        let touch: UITouch = touches.first as UITouch!
        let touchPoint: CGPoint  = touch.locationInView(self.view)
        let imagePoint: CGPoint = self.profileimage.frame.origin

        if(imagePoint.x <= touchPoint.x && imagePoint.x + self.profileimage.frame.size.width >= touchPoint.x && imagePoint.y <=  touchPoint.y && imagePoint.y+self.profileimage.frame.size.height >= touchPoint.y){
            self.imagePickerController.delegate = self
            self.imagePickerController.allowsEditing = true
            if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
                let alertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)

                let cameraAction: UIAlertAction = UIAlertAction(title: "Take Photo", style: .Default) { (action: UIAlertAction!) -> Void in
                    self.imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
                    self.presentViewController(self.imagePickerController, animated: true, completion: nil)
                }
                alertController.addAction(cameraAction)
                let photoLibraryAction: UIAlertAction = UIAlertAction(title: "Choose from Photos", style: .Default) { (action: UIAlertAction!) -> Void in
                    self.imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary

                    self.presentViewController(self.imagePickerController, animated: true, completion: nil)
                }
                alertController.addAction(photoLibraryAction)
                let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
                alertController.addAction(cancelAction)
                presentViewController(alertController, animated: true, completion: nil)
            }
            else{
                let alertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)

                let photoLibraryAction: UIAlertAction = UIAlertAction(title: "Choose from Photos", style: .Default) { (action: UIAlertAction!) -> Void in
                    self.imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary

                }
                alertController.addAction(photoLibraryAction)
                let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
                alertController.addAction(cancelAction)
                presentViewController(alertController, animated: true, completion: nil)
                
            }
        }

            
        }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        var image: UIImage!
        if(picker.allowsEditing){
            image = info[UIImagePickerControllerEditedImage] as! UIImage
        }else{
            image = info[UIImagePickerControllerOriginalImage] as! UIImage
        }

        self.saveImage(image, newSize: CGSize(width: 256, height: 256), percent: 0.5, imageName: "currentImage.png")
        let fullPath: String = NSHomeDirectory() + "/" + "currentImage.png"
        print("fullPath=\(fullPath)")

        self.profileimage.image = image
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func saveImage(currentImage: UIImage, newSize: CGSize, percent: CGFloat, imageName: String){
        UIGraphicsBeginImageContext(newSize)
        currentImage.drawInRect(CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let imageData: NSData = UIImageJPEGRepresentation(newImage, percent)!
        let fullPath: String = NSHomeDirectory() + "/" + imageName
        print("fullPath=\(fullPath)")
        imageData.writeToFile(fullPath, atomically: false)
        NSUserDefaults.standardUserDefaults().setObject(imageData, forKey: "profileimage")
        
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
