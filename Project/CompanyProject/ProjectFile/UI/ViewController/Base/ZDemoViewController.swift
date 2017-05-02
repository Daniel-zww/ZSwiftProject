//
//  ZDemoViewController.swift
//  CompanyProject
//
//  Created by Daniel on 18/04/2017.
//  Copyright © 2017 Z. All rights reserved.
//

import UIKit
import MobileCoreServices
import Photos
import AssetsLibrary
import AVFoundation

class ZDemoViewController: ZBaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    // MARK: - PrivateProperty
    
    // MARK: - SuperMethod
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = kLocalUser
        self.innerInit()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        if (self.view.window != nil) && self.isViewLoaded {
            self.setViewNil()
        }
    }
    private func setViewNil() {
        
    }
    deinit {
        self.setViewNil()
    }
    
    // MARK: - PrivateMethod
    
    private func innerInit() {
        
    }
    private func reloadData() {
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    // MARK: - ImagePickerEvent
    
    @objc func showImageActionSheet() {
        ZActionSheet.showAction(kLocalChangeAvatar, nil, [kLocalSelectCamera, kLocalSelectAlbum]) { [weak self] (btnIndex) in
            switch btnIndex {
            case 1:
                self?.checkCameraAuthorization()
                break
            case 2:
                self?.checkAlbumAuthorization()
                break
            default: break
            }
        }
    }
    /// 检测相册访问权限
    private func checkAlbumAuthorization() {
        let author: PHAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch author {
        case .authorized:
            // 用户已经授权应用访问相册数据
            self.showAlbumVC()
            break
        case .denied:
            // 用户已经明确否认了这一照片数据的应用程序访问
            ZAlertView.showAlert(kLocalYouDisableTheAlbumOpenTheAlbumInTheSettingsToUse, [kLocalSetting], kLocalCancel, { (btnIndex) in
                switch btnIndex {
                case 1:
                    UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
                    break
                default: break
                }
            })
            break
        case .notDetermined:
            // 用户尚未做出选择这个应用程序的问候
            PHPhotoLibrary.requestAuthorization({ [weak self] (status) in
                switch status {
                case .authorized:
                    self?.showAlbumVC()
                    break
                default: break
                }
            })
            break
        case .restricted:
            // 此应用程序没有被授权访问的照片数据。可能是家长控制权限
            ZAlertView.showAlertOne(kLocalYouAreUsingParentalControl)
            break
        }
    }
    /// 检测相机访问权限
    private func checkCameraAuthorization() {
        let author = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        switch author {
        case .authorized:
            // 用户已经授权应用访问照片数据
            self.showCameraVC()
            break
        case .denied:
            // 用户已经明确否认了这一照片数据的应用程序访问
            ZAlertView.showAlert(kLocalYouDisableTheCameraOpenTheCameraInTheSettingsToUse, [kLocalSetting], kLocalCancel, { (btnIndex) in
                switch btnIndex {
                case 1:
                    UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
                    break
                default: break
                }
            })
            break
        case .notDetermined:
            // 用户尚未做出选择这个应用程序的问候
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { [weak self] (granted: Bool) in
                if granted {
                    self?.showCameraVC()
                }
            })
            break
        case .restricted:
            // 此应用程序没有被授权访问的照片数据。可能是家长控制权限
            ZAlertView.showAlertOne(kLocalYouAreUsingParentalControl)
            break
        }
    }
    /// 调用相册
    private func showAlbumVC() {
        if ZImagePickerViewController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagepicker: ZImagePickerViewController = ZImagePickerViewController()
            imagepicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagepicker.delegate = self
            imagepicker.allowsEditing = true
            self.present(imagepicker, animated: true, completion: { })
        } else {
            ZProgressHUD.showError(kLocalYourDeviceDoesNotSupportTheAlbum)
        }
    }
    /// 调用相机
    private func showCameraVC() {
        if ZImagePickerViewController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagepicker: ZImagePickerViewController = ZImagePickerViewController()
            imagepicker.sourceType = UIImagePickerControllerSourceType.camera
            imagepicker.cameraDevice = UIImagePickerControllerCameraDevice.rear
            imagepicker.cameraFlashMode = UIImagePickerControllerCameraFlashMode.auto
            imagepicker.delegate = self
            imagepicker.allowsEditing = true
            self.present(imagepicker, animated: true, completion: { })
        } else {
            ZProgressHUD.showError(kLocalYourDeviceDoesNotSupportTheCamera)
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true) {
            let mediaType = info[UIImagePickerControllerMediaType] as? String
            if mediaType != nil && mediaType!.isEqualToString(verifyValue: (kUTTypeImage as String)) {
                let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage
                if editedImage != nil {
                    
                }
            }
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) { }
    }

}
