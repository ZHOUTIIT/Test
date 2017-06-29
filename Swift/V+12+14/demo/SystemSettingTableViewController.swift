//
//  SystemSettingTableViewController.swift
//  demo
//
//  Created by Zhou Ti on 11/22/15.
//  Copyright © 2015 Zhou Ti. All rights reserved.
//

import UIKit

class SystemSettingTableViewController: UITableViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
let imagePickerController: UIImagePickerController = UIImagePickerController()
    @IBAction func cancel(sender: UIBarButtonItem) {
        let mystoryboard = self.storyboard
        let loginController = mystoryboard!.instantiateViewControllerWithIdentifier("main") as! UITabBarController
        loginController.selectedIndex = 1
        self.presentViewController(loginController, animated: false, completion: nil)
    }
   
    @IBAction func changebackground(sender: UIButton) {

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
        picker.dismissViewControllerAnimated(true, completion: nil)
        var image: UIImage!
        image = info[UIImagePickerControllerOriginalImage] as! UIImage


    self.saveImage(image, newSize: CGSize(width: 256, height: 600), percent: 0.5, imageName: "currentImage.png")
    let fullPath: String = NSHomeDirectory() + "/" + "currentImage.png"
    print("fullPath=\(fullPath)")

    
    self.systemsetting.backgroundColor = UIColor(patternImage: image)
    
    
}


func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    self.dismissViewControllerAnimated(true, completion: nil)
}
func saveImage(currentImage: UIImage, newSize: CGSize, percent: CGFloat, imageName: String){
    let imageData: NSData = UIImageJPEGRepresentation(currentImage, percent)!
    let fullPath: String = NSHomeDirectory() + "/" + imageName
    print("fullPath=\(fullPath)")
    imageData.writeToFile(fullPath, atomically: false)
    NSUserDefaults.standardUserDefaults().setObject(imageData, forKey: "backgroundimage")
    
}

    @IBOutlet var alpha: UISlider!
    @IBOutlet var transparencycell: UITableViewCell!
    @IBOutlet var backgrondcell: UITableViewCell!
    @IBOutlet var systemsetting: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        systemsetting.separatorColor = UIColor.clearColor()
        systemsetting.backgroundColor = UIColor.clearColor()
        transparencycell.backgroundColor = UIColor.clearColor()
        backgrondcell.backgroundColor = UIColor.clearColor()
        if ((NSUserDefaults.standardUserDefaults().valueForKey("alpha")) != nil){
        let value = NSUserDefaults.standardUserDefaults().valueForKey("alpha") as! CGFloat
        
            transparencycell.contentView.alpha = value
            backgrondcell.contentView.alpha = value
        }
        else {
        transparencycell.contentView.alpha = 0.6
        backgrondcell.contentView.alpha = 0.6
        }
        if ((NSUserDefaults.standardUserDefaults().valueForKey("alpha")) == nil){
            alpha.value = 0.6
        }
        else{
            alpha.value = NSUserDefaults.standardUserDefaults().valueForKey("alpha") as! Float
        }
        if (NSUserDefaults.standardUserDefaults().valueForKey("backgroundimage") == nil){
            systemsetting.backgroundColor = UIColor.grayColor()
        }
        else{
            
            systemsetting.backgroundColor = UIColor(patternImage: UIImage(data: NSUserDefaults.standardUserDefaults().valueForKey("backgroundimage") as! NSData)!)
        }
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        let navigationTitleAttribute : NSDictionary = NSDictionary(object: UIColor.whiteColor(),forKey: NSForegroundColorAttributeName)
        self.navigationController?.navigationBar.titleTextAttributes = navigationTitleAttribute as? [String : AnyObject]

    }

    @IBAction func changealpha(sender: UISlider) {
        NSUserDefaults.standardUserDefaults().setObject(alpha.value, forKey: "alpha")
        transparencycell.contentView.alpha = CGFloat(alpha.value)
        backgrondcell.contentView.alpha = CGFloat(alpha.value)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}
