//
//  NewPlaceTableViewCell.swift
//  MyPlaces
//
//  Created by Victor on 19.05.2022.
//

import UIKit
import Photos
import PhotosUI

class NewPlaceViewController: UITableViewController {
    // MARK: - @IBOutlets
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeName: UITextField!
    @IBOutlet weak var placeLocation: UITextField!
    @IBOutlet weak var placeType: UITextField!
    // MARK: - Public Properties
    var newPlace: Place!
    // MARK: - Override Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        tableView.tableFooterView = UIView()
        super.viewDidLoad()
        saveButton.isEnabled = false
        
        placeName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let cameraIcon = UIImage(systemName: "camera")
            let photoIcon = UIImage(systemName: "photo")
            let alertActionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                let camera = UIImagePickerController.SourceType.camera
                self.chooseImagePicker(source: camera)
            }
            camera.setValue(cameraIcon, forKey: "image")
            camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                self.showPhotoLibrary()
            }
            photo.setValue(photoIcon, forKey: "image")
            photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            
            alertActionSheet.addAction(camera)
            alertActionSheet.addAction(photo)
            alertActionSheet.addAction(cancel)
            
            present(alertActionSheet, animated: true)
        } else {
            view.endEditing(true)
        }
    }
    // MARK: - @IBActions
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    // MARK: - Public Methods
    func saveNewPlace() {
        newPlace = Place(name: placeName.text!,
                         location: placeName.text,
                         type: placeType.text,
                         image: placeImage.image,
                         restaurantImage: nil
        )
    }
    // MARK: - Private Methods
    @objc private func textFieldChanged() {
        if placeName.text?.isEmpty == false {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
 }

// MARK: - TextField Delegate

extension NewPlaceViewController: UITextFieldDelegate {
    //Hide keyboard on tapped Done
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      true
    }
}

// MARK: - Work with image

extension NewPlaceViewController: UIImagePickerControllerDelegate, PHPickerViewControllerDelegate, UINavigationControllerDelegate {
        
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
            for image in results {
                if image.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    image.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                        DispatchQueue.main.async {
                            guard let self = self, let image = image as? UIImage, error == nil else { return }
                            self.placeImage.image = image
                            self.placeImage.contentMode = .scaleAspectFit
                            self.placeImage.clipsToBounds = true
                            picker.dismiss(animated: true)
                        }
                    }
                }
            }
        }
    
    func showPhotoLibrary() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .any(of: [.images, .livePhotos])
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
}
