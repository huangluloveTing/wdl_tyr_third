//
//  BaseVC+Picker.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/11/1.
//  Copyright © 2018 yinli. All rights reserved.
//

import Foundation


enum PhotoPickerMode {
    case camera
    case album
}

var image_closure_store_key = "image_closure_store_key"
extension BaseVC {
    
    typealias ImagePickerClosure = (UIImage?) -> ()
    
    fileprivate var currentImageClosure:ImagePickerClosure? {
        set {
            objc_setAssociatedObject(self, &image_closure_store_key, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
        get {
            return objc_getAssociatedObject(self, &image_closure_store_key) as?ImagePickerClosure
        }
    }
    
    func takePhotoAlert(closure:((UIImage?) -> ())?) -> Void {
        self.showAlert(items: ["拍照","从相册获取"],
                       title: "请选择",
                       message: nil,
                       showCancel: true,
                       closure: { (index) in
                        if index == 0 {
                            self.takePhoto(mode: .camera, closure: closure, canEdit: true)
                        }
                        if index == 1 {
                            self.takePhoto(mode: .album, closure: closure, canEdit: true)
                        }
                        },
                       mode: .sheet)
    }
    
    func takePhoto(mode:PhotoPickerMode = .album , closure:((UIImage?) -> ())? = nil , canEdit:Bool = false) -> Void {
        
        let photoPicker = UIImagePickerController()
        switch mode {
        case .album:
            self.photoFromAlbum(imagePicker: photoPicker)
            break;
        default:
            self.photoFromCarmera(imagePicker: photoPicker)
        }
        photoPicker.allowsEditing = canEdit
        photoPicker.delegate = self
        self.currentImageClosure = closure
        self.present(photoPicker, animated: true, completion: nil)
    }
    
    
    // 相机获取图片
    func photoFromAlbum(imagePicker:UIImagePickerController ) -> Void {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.sourceType = .photoLibrary
        }
        if Util.isSimulator() {
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                imagePicker.sourceType = .photoLibrary
            }
        }
    }
    
    // 相册获取图片
    func photoFromCarmera(imagePicker:UIImagePickerController) -> Void {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        }
        if Util.isSimulator() {
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                imagePicker.sourceType = .photoLibrary
            }
        }
    }
}

extension BaseVC : UIImagePickerControllerDelegate&UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        var image:UIImage? = info[UIImagePickerControllerEditedImage] as? UIImage
        if image == nil {
            image = info[UIImagePickerControllerOriginalImage] as? UIImage
        }
        if let closure = self.currentImageClosure {
            closure(image)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
