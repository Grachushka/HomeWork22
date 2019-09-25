//
//  ViewController.swift
//  HomeWork22
//
//  Created by Pavel Procenko on 25/09/2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    

    
    var image: UIImageView?
    
    @IBOutlet weak var labe1: UILabel!
    private var imagePicker: UIImagePickerController?

    private enum Source {
          case camera
          case library
      }
    
    func config () {
        
        let attrString = NSMutableAttributedString()
               let amount = "1"
               let amountAttrs: [NSAttributedString.Key: Any] = [
                   .font: UIFont.systemFont(ofSize: 50),
                   .foregroundColor: UIColor.black,
                   .kern: 1
               ]
               let amountString = NSAttributedString(string: amount, attributes: amountAttrs)
               
               let unit = "g"
               let unitAttrs: [NSAttributedString.Key: Any] = [
                   .font: UIFont.systemFont(ofSize: 40),
                   .foregroundColor: UIColor.green,
                   .kern: 0.2
               ]
                let unit2 = "v"
                let unitAttrs2: [NSAttributedString.Key: Any] = [
                          .font: UIFont.systemFont(ofSize: 100),
                          .foregroundColor: UIColor.yellow,
                          .kern: 0.2
                      ]
                let unit3 = "O"
                let unitAttrs3: [NSAttributedString.Key: Any] = [
                          .font: UIFont.systemFont(ofSize: 250),
                          .foregroundColor: UIColor.orange,
                          .kern: 0.2
                      ]
                let unitString = NSAttributedString(string: unit, attributes: unitAttrs)
                let unitString2 = NSAttributedString(string: unit2, attributes: unitAttrs2)
                let unitString3 = NSAttributedString(string: unit3, attributes: unitAttrs3)
               
                attrString.append(amountString)
                attrString.append(unitString)
                attrString.append(unitString2)
                attrString.append(unitString3)
        
                let attachment = NSTextAttachment()
                attachment.image = UIImage(named: "icon")
                let imageString = NSAttributedString(attachment: attachment)
                attrString.insert(imageString, at: 3)
        
                labe1.attributedText = attrString
           

        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
       
        
    }
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesBegan(touches, with: event)
    
            let points = touches.map { $0.location(in: self.view) }
            let point = points.randomElement()!
            if let view = self.view.hitTest(point, with: event), view != self.view {
                image = view as? UIImageView
                
                showChoose { [weak self] source in
                    guard let source = source else { return }
                    
                    let picker = UIImagePickerController()
                 picker.delegate = self!
                    
                    switch source {
                    case .camera:
                        picker.sourceType = .camera
                        picker.cameraCaptureMode = .photo
                    case .library:
                        picker.sourceType = .photoLibrary
                        picker.allowsEditing = true
                    }
                    
                    self?.present(picker, animated: true)
                    self?.imagePicker = picker
                    
                }
                self.view.bringSubviewToFront(view)
            }
        }
    
     private func showChoose(choosen: @escaping (Source?) -> Void) {

        let alert = UIAlertController(title: "Choose source", message: nil, preferredStyle: .actionSheet)
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                alert.addAction(UIAlertAction(title: "Camera", style: .default) { _ in
                    choosen(.camera)
                })
            }
            alert.addAction(UIAlertAction(title: "Library", style: .default) { _ in
                choosen(.library)
            })
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
                choosen(nil)
            })
            
            present(alert, animated: true)
        }
    }

extension ViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {

func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
    print(picker)
    let cropped = info[.editedImage] as! UIImage
    
    image!.image = cropped
    picker.dismiss(animated: true)
    
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Cancel")
        picker.dismiss(animated: true)
    }
}



