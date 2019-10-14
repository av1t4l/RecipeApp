//
//  FaceDetectorViewController.swift
//  RecipeApp
//
//  Created by Sarah Nurwidhiafitri Sukamto on 13/10/19.
//  Copyright © 2019 Avital Miskella. All rights reserved.
//

import UIKit
import Vision

class FaceDetectorViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var faceDetected = false
    var imagePicker = UIImagePickerController()
    //var image: UIImage?
    var scaledHeight: CGFloat = 0
    var redBox = UIView()
    
    @IBOutlet var imageView: UIImageView!
    
    /*This button will redirect to the main scene if faces are detected.*/
    @IBAction func accessAppBtn(_ sender: Any) {
        
        if(faceDetected){
            print("Face detected. Access granted.")
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
            self.present(nextViewController, animated:true, completion:nil)
            
        } else {
            
            let alertController = UIAlertController(title: "Access Denied", message: "No face was detected.", preferredStyle: .alert)
            let doneButton = UIAlertAction(title: "Okay", style: .default, handler: {(action) -> Void in print("Okay")})
            
            alertController.addAction(doneButton)
            self.present(alertController, animated: true, completion: nil)
            
            print("Face not detected. Access denied.")
        }
    }
    
    //The button will redirect the app to the gallery.
    @IBAction func chooseImgBtn(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")

            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = true

            present(imagePicker, animated: true, completion: nil)
        }
    }

    //Upon choosing an image, the photo on the screen will change to the selected image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageView.image = image
        self.redBox.isHidden = true
        self.faceDetected = false
        
        //Get the height of the image
        scaledHeight = view.frame.width / image.size.width * image.size.height
        
        //Create a request to detect faces in the photo
        let request = VNDetectFaceRectanglesRequest { (req, err) in
            
            if let err = err {
                self.redBox.isHidden = true
                print("Failed to detect faces: \(err)")
                return
            }
            
            req.results?.forEach({ (res) in
                
                guard let faceObservation = res as? VNFaceObservation else {return}
                
                //Set the box coordinates and size
                let x = self.view.frame.width * faceObservation.boundingBox.origin.x
                let height = self.scaledHeight * faceObservation.boundingBox.height
                let y = self.view.frame.height * (1-faceObservation.boundingBox.origin.y)-height
                let width = self.view.frame.width * faceObservation.boundingBox.width
                
                //Create the box
                self.redBox.isHidden = false
                self.redBox.backgroundColor = .red
                self.redBox.alpha = 0.4
                self.redBox.frame = CGRect(x: x, y: y, width: width, height: height)
                
                self.view.addSubview(self.redBox)
                
                print(faceObservation.boundingBox)
                
                self.faceDetected = true
            })
        }
        
        guard let cgImage = image.cgImage else {return}
        
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        
        do{
            try handler.perform([request])
        } catch let errReq{
            print("Failed to perform request: \(errReq)")
        }
        
        dismiss(animated:true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Get the image
        guard let image = UIImage(named: "sample") else {return}
        imageView.image = image
        
        imagePicker.delegate = self
        
        //Get the height of the image
        scaledHeight = view.frame.width / image.size.width * image.size.height
        
        //Create a request to detect faces in the photo
        let request = VNDetectFaceRectanglesRequest { (req, err) in
            
            if let err = err {
                self.redBox.isHidden = true
                print("Failed to detect faces: \(err)")
                return
            }
            
            req.results?.forEach({ (res) in
                
                guard let faceObservation = res as? VNFaceObservation else {return}
                
                //Set the box coordinates and size
                let x = self.view.frame.width * faceObservation.boundingBox.origin.x
                let height = self.scaledHeight * faceObservation.boundingBox.height
                let y = self.view.frame.height * (1-faceObservation.boundingBox.origin.y)-height
                let width = self.view.frame.width * faceObservation.boundingBox.width
                
                //Create the box
                self.redBox.isHidden = false
                self.redBox.backgroundColor = .red
                self.redBox.alpha = 0.4
                self.redBox.frame = CGRect(x: x, y: y, width: width, height: height)
                
                self.view.addSubview(self.redBox)
                
                print(faceObservation.boundingBox)
                
                self.faceDetected = true
            })
        }
        
        guard let cgImage = image.cgImage else {return}
        
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        
        do{
            try handler.perform([request])
        } catch let errReq{
            print("Failed to perform request: \(errReq)")
        }
        
        self.detectFace()
    }

    func detectFace(){
        
    }
}
