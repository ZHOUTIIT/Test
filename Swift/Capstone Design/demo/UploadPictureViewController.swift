//
//  UploadPictureViewController.swift
//  demo
//
//  Created by Zhou Ti on 11/21/15.
//  Copyright © 2015 Zhou Ti. All rights reserved.
//

import UIKit

class UploadPictureViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var image: UIImageView!
    @IBOutlet var imageView: UIImageView!

    @IBOutlet var background: UIImageView!
    @IBOutlet var later: UIButton!
    @IBOutlet var set: UIButton!
    let imagePickerController: UIImagePickerController = UIImagePickerController()
    var isFullScreen: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        background.backgroundColor = UIColor.clearColor()
        self.image.image = UIImage(named: "a.jpg")
        self.imageView.frame = CGRectMake(130, 195, 128, 128)
        self.imageView.image = UIImage(named: "d.jpg")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func chooseImage(sender: UIButton) {
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
    

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        set.setTitle("Change Photo", forState: UIControlState.Normal)
        later.setTitle("Done", forState: UIControlState.Normal)
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

                     self.imageView.image = image
        
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
                 imageData.writeToFile(fullPath, atomically: false)
                NSUserDefaults.standardUserDefaults().setObject(imageData, forKey: "profileimage")
                NSUserDefaults.standardUserDefaults().setObject(1, forKey: "hasprofile")
            
             }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.isFullScreen = !self.isFullScreen
        
        let touch: UITouch = touches.first as UITouch!
        let touchPoint: CGPoint  = touch.locationInView(self.view)
        let imagePoint: CGPoint = self.imageView.frame.origin
        if(imagePoint.x <= touchPoint.x && imagePoint.x + self.imageView.frame.size.width >= touchPoint.x && imagePoint.y <=  touchPoint.y && imagePoint.y+self.imageView.frame.size.height >= touchPoint.y){
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.5)
            
            if (isFullScreen) {
                self.imageView.frame = CGRectMake(0, 150, 378, 378)
                background.backgroundColor = UIColor.blackColor()
                set.enabled = false
                later.enabled = false
                
            }
            else {
                self.imageView.frame = CGRectMake(130, 195, 128, 128)
                background.backgroundColor = UIColor.clearColor()
                set.enabled = true
                later.enabled = true
            }
            UIView.commitAnimations()
            
        }

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
