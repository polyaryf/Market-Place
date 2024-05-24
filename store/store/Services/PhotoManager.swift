//
//  PhotoManager.swift
//  store
//
//  Created by Evelina on 09.07.2023.
//

import PhotosUI

protocol PhotoManagerProtocol {
    func getPhotoFromLibrary(completion: @escaping (PHPickerViewController) -> Void)
}
protocol PhotoManagerDelegate: AnyObject {
    func didChooseImages(images: [UIImage])
}

class PhotoManager: PhotoManagerProtocol {
    weak var delegate: PhotoManagerDelegate?
    func getPhotoFromLibrary(completion: @escaping (PHPickerViewController) -> Void) {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.selectionLimit = 10
        config.filter = .images
        let photoPickerViewController = PHPickerViewController(configuration: config)
        photoPickerViewController.delegate = self
        completion(photoPickerViewController)
    }
}
extension PhotoManager: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        var images: [UIImage] = []
        let group = DispatchGroup()
        results.forEach { result in
            group.enter()
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
                guard let image = object as? UIImage, error == nil
                else {
                    group.leave()
                    return }
                images.append(image)
                group.leave()
            }
        }
        group.notify(queue: .main) {
            self.delegate?.didChooseImages(images: images)
        }
    }
}
