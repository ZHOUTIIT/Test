//
//  ChangeSettingViewController.swift
//  demo
//
//  Created by Zhou Ti on 11/15/15.
//  Copyright © 2015 Zhou Ti. All rights reserved.
//

import UIKit
import Firebase

class ChangeSettingViewController: UITableViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var nickname: UITextField!
    let imagePickerController: UIImagePickerController = UIImagePickerController()
  
    @IBOutlet var wholeview: UITableView!
    
    @IBOutlet var profile: UITableView!
    @IBOutlet var imagecell: UITableViewCell!
    
    @IBOutlet var nicknamecell: UITableViewCell!
    

    @IBOutlet var gendercell: UITableViewCell!
    
    @IBOutlet var heightcell: UITableViewCell!
    
    @IBOutlet var weightcell: UITableViewCell!
    
    @IBOutlet var whatsupcell: UITableViewCell!
    
    @IBOutlet var typecell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wholeview.separatorColor = UIColor.clearColor()
        if ((NSUserDefaults.standardUserDefaults().valueForKey("backgroundimage")) == nil){
            profile.backgroundColor = UIColor.grayColor()
        }
        else{
            
        profile.backgroundColor = UIColor(patternImage: UIImage(data: NSUserDefaults.standardUserDefaults().valueForKey("backgroundimage") as! NSData)!)
        }
        if ((NSUserDefaults.standardUserDefaults().valueForKey("alpha")) != nil){
        let value = NSUserDefaults.standardUserDefaults().valueForKey("alpha") as! CGFloat
        
            imagecell.contentView.alpha = value
            nicknamecell.contentView.alpha = value
            heightcell.contentView.alpha = value
            weightcell.contentView.alpha = value
            typecell.contentView.alpha = value
            gendercell.contentView.alpha = value
            
            whatsupcell.contentView.alpha = value
        }
        else{
            imagecell.contentView.alpha = 0.6
            nicknamecell.contentView.alpha = 0.6
            heightcell.contentView.alpha = 0.6
            weightcell.contentView.alpha = 0.6
            typecell.contentView.alpha = 0.6
            gendercell.contentView.alpha = 0.6
            
            whatsupcell.contentView.alpha = 0.6
        }
        imagecell.backgroundColor = UIColor.clearColor()
        nicknamecell.backgroundColor = UIColor.clearColor()
        heightcell.backgroundColor = UIColor.clearColor()
        weightcell.backgroundColor = UIColor.clearColor()
        typecell.backgroundColor = UIColor.clearColor()
        gendercell.backgroundColor = UIColor.clearColor()
        whatsupcell.backgroundColor = UIColor.clearColor()
        //Firebase.defaultConfig().persistenceEnabled = true
        let ref=Firebase(url: "https://glowing-inferno-3788.firebaseio.com/")
//        if ref.authData != nil {
//            // user authenticated
//            ref.childByAppendingPath("users")
//                .childByAppendingPath(ref.authData.uid).observeEventType(.Value, withBlock: { snapshot in
//                    NSUserDefaults.standardUserDefaults().setObject(snapshot.value.objectForKey("height"), forKey: "height")
//                    NSUserDefaults.standardUserDefaults().setObject(snapshot.value.objectForKey("weight"), forKey: "weight")
//                    NSUserDefaults.standardUserDefaults().setObject(snapshot.value.objectForKey("whatup"), forKey: "whatup")
//                    NSUserDefaults.standardUserDefaults().synchronize()
//                    }, withCancelBlock: { error in
//                        print(error.description)
//                })
//            
//            print(ref.authData)
//        } else {
//            // No user is signed in
//            let myStoryBoard = self.storyboard
//            let anotherView = myStoryBoard!.instantiateViewControllerWithIdentifier("relogin")
//            self.presentViewController(anotherView, animated: true, completion: nil)
//            
//        }
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        let navigationTitleAttribute : NSDictionary = NSDictionary(object: UIColor.whiteColor(),forKey: NSForegroundColorAttributeName)
        self.navigationController?.navigationBar.titleTextAttributes = navigationTitleAttribute as? [String : AnyObject]
        nickname.text = NSUserDefaults.standardUserDefaults().valueForKey("UserNameKey") as? String
        nickname.clearButtonMode = UITextFieldViewMode.WhileEditing
        if ((NSUserDefaults.standardUserDefaults().valueForKey("profileimage")) != nil){
        photo.image = UIImage(data: NSUserDefaults.standardUserDefaults().valueForKey("profileimage") as! NSData)
        }
        else{
            photo.image = UIImage(named: "d.jpg")
        }

        height.text = NSUserDefaults.standardUserDefaults().valueForKey("height") as? String
        weight.text = NSUserDefaults.standardUserDefaults().valueForKey("weight") as? String
        whatup.text = NSUserDefaults.standardUserDefaults().valueForKey("whatup") as? String
        
        
    }

  
    @IBAction func cancel(sender: UIBarButtonItem) {
        let mystoryboard = self.storyboard
        let loginController = mystoryboard!.instantiateViewControllerWithIdentifier("main") as! UITabBarController
        loginController.selectedIndex = 1
        self.presentViewController(loginController, animated: false, completion: nil)
    }
   
    @IBAction func done(sender: UIBarButtonItem) {
        let ref=Firebase(url: "https://glowing-inferno-3788.firebaseio.com/")

        NSUserDefaults.standardUserDefaults().setObject(0, forKey: "first")
        NSUserDefaults.standardUserDefaults().setObject(height.text, forKey: "height")

        NSUserDefaults.standardUserDefaults().setObject(weight.text, forKey: "weight")

        var exercisetype: String
        if (exercise.selectedSegmentIndex == 0){
            exercisetype = "Riding"
        }
        else{
            exercisetype = "Running"
        }
        NSUserDefaults.standardUserDefaults().setObject(exercisetype, forKey: "UserExerciseType")

        NSUserDefaults.standardUserDefaults().setObject(whatup.text, forKey: "whatup")

        var mygender: String
        if (gender.selectedSegmentIndex == 0){
            mygender = "Male"
        }
        else{
            mygender = "Female"
        }
        NSUserDefaults.standardUserDefaults().setObject(mygender, forKey: "gender")

        NSUserDefaults.standardUserDefaults().setObject(nickname.text, forKey: "UserNameKey")
        if ref.authData != nil {
            // user authenticated
            ref.childByAppendingPath("users")
                .childByAppendingPath(ref.authData.uid).updateChildValues(
                    [
                    "height":height.text!,
                    "weight":weight.text!,
                    "gender":mygender,
                    "type":exercisetype,
                    "whatup":whatup.text
                    ]
            )
            print(ref.authData)
        } else {
            // No user is signed in
            let myStoryBoard = self.storyboard
            let anotherView = myStoryBoard!.instantiateViewControllerWithIdentifier("relogin")
            self.presentViewController(anotherView, animated: true, completion: nil)
        }
        let mystoryboard = self.storyboard
        let loginController = mystoryboard!.instantiateViewControllerWithIdentifier("main") as! UITabBarController
        loginController.selectedIndex = 1
         self.presentViewController(loginController, animated: false, completion: nil)

        
    }
    @IBOutlet var whatup: UITextView!
    
    @IBOutlet var height: UITextField!

    @IBOutlet var weight: UITextField!

    
    @IBOutlet var exercise: UISegmentedControl!

    
    
    @IBOutlet var gender: UISegmentedControl!

    

    @IBAction func changephoto(sender: UIButton) {
        // 设置代理
        self.imagePickerController.delegate = self
        // 设置是否可以管理已经存在的图片或者视频
        self.imagePickerController.allowsEditing = true
        // 判断是否支持相机
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
        // 判断，图片是否允许修改
//        if(picker.allowsEditing){
  
        //裁剪后图片
        if (picker.allowsEditing){
        image = info[UIImagePickerControllerEditedImage] as! UIImage
        }else{
            //原始图片
            image = info[UIImagePickerControllerOriginalImage] as! UIImage
        }
        /* 此处info 有六个值
        * UIImagePickerControllerMediaType; // an NSString UTTypeImage)
        * UIImagePickerControllerOriginalImage;  // a UIImage 原始图片
        * UIImagePickerControllerEditedImage;    // a UIImage 裁剪后图片
        * UIImagePickerControllerCropRect;       // an NSValue (CGRect)
        * UIImagePickerControllerMediaURL;       // an NSURL
        * UIImagePickerControllerReferenceURL    // an NSURL that references an asset in the AssetsLibrary framework
        * UIImagePickerControllerMediaMetadata    // an NSDictionary containing metadata from a captured photo
        */
        
        self.saveImage(image, newSize: CGSize(width: 256, height: 256), percent: 0.5, imageName: "currentImage.png")
        let fullPath: String = NSHomeDirectory() + "/" + "currentImage.png"
        print("fullPath=\(fullPath)")
        //let savedImage: UIImage = UIImage(contentsOfFile: fullPath)!
        //self.isFullScreen = false
        self.photo.image = image
    
        
        
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
//        NSNotificationCenter.defaultCenter().postNotificationName("changeprofilephoto", object: nil, userInfo: ["key":"haschanged"])
        


    @IBOutlet var photo: UIImageView!

//    @IBAction func setrun(sender: UIButton) {
//        NSUserDefaults.standardUserDefaults().setObject("running", forKey: "UserExerciseType")
//        NSUserDefaults.standardUserDefaults().synchronize()
//        let mystoryboard = self.storyboard
//        let mainTabController = mystoryboard!.instantiateViewControllerWithIdentifier("main") as! UITabBarController
//        self.presentViewController(mainTabController, animated: false, completion: nil)
//    }
//    @IBAction func setride(sender: UIButton) {
//        NSUserDefaults.standardUserDefaults().setObject("riding", forKey: "UserExerciseType")
//        NSUserDefaults.standardUserDefaults().synchronize()
//        let mystoryboard = self.storyboard
//        let mainTabController = mystoryboard!.instantiateViewControllerWithIdentifier("main") as! UITabBarController
//        self.presentViewController(mainTabController, animated: false, completion: nil)
//    }
    

}
