//
//  ViewController.swift
//  GetInfoFromCameraImage
//
//  Created by Anil on 11/06/15.
//  Copyright (c) 2015 Variya Soft Solutions. All rights reserved.
//

import UIKit
import MobileCoreServices
import AssetsLibrary

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var imageV: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func TakePicture(sender: AnyObject) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.mediaTypes = [kUTTypeImage as NSString]
        imagePicker.allowsEditing = false
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        print(info["UIImagePickerControllerOriginalImage"] ?? "NO IMAGE")
        print(info["UIImagePickerControllerReferenceURL"] ?? "NO URL")
        print(info["UIImagePickerControllerMediaMetadata"] ?? "NO METADATA")

        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            println("Called")
            ALAssetsLibrary().writeImageToSavedPhotosAlbum(image.CGImage!, metadata: info[UIImagePickerControllerMediaMetadata]! as! [NSObject : AnyObject], completionBlock: { (url, error) -> Void in
                
                print("photo saved to asset")
                print(url)
            
                
//                 you can load your UIImage that was just saved to your asset as follow
                let assetLibrary = ALAssetsLibrary()
                assetLibrary.assetForURL(url,
                    resultBlock: { (asset) -> Void in
                        if let asset = asset {
                            let assetImage =  UIImage(CGImage:  asset.defaultRepresentation().fullResolutionImage().takeUnretainedValue())
                            print(assetImage)
                        }
                    }, failureBlock: { (error) -> Void in
                        if let error = error { print(error.description) }
                })
            
                if let error = error { print(error.description) }
                self.dismissViewControllerAnimated(true, completion: nil)
            })
        }
    }

}

