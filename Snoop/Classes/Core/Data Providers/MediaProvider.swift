//
//  MediaProvider.swift
//  Snoop
//
//  Created by Sergey Kim on 20.10.2020.
//

import UIKit
import Photos

public enum MediaProviderError: Error {
    case libraryPermissionDenied
    case cameraPermissionDenied
    case noAlbum
    case cancel
}

extension MediaProviderError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case .libraryPermissionDenied, .cameraPermissionDenied:
            return "To give permissions tap on 'Settings' button"
        case .noAlbum:
            return "No album found"
        case .cancel:
            return "Cancelled"
        }
    }
}

public typealias PermissionHandler = (PermissionStatus) -> Void

public enum PermissionStatus {
    case granted
    case restricted
}

public final class MediaProvider: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var completion: PhotosClosure?

    public func getImagesFromLibrary(presentationController: UIViewController,
                                     completion: @escaping PhotosClosure) {
        let pickerController = UIImagePickerController()
        pickerController.allowsEditing = false
        pickerController.mediaTypes = ["public.image"]
        pickerController.delegate = self
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            return
        }

        func showLibrary() {
            self.completion = completion
            presentationController.present(pickerController, animated: true, completion: nil)
        }

        checkPhotoLibraryPermission { status in
            switch status {
            case .granted:
                showLibrary()
            case .restricted:
                completion(.failure(MediaProviderError.libraryPermissionDenied))
            }
        }
    }

    private func checkPhotoLibraryPermission(with handler: @escaping PermissionHandler) {
        let status = PHPhotoLibrary.authorizationStatus()

        switch status {
        case .authorized, .limited:
            handler(.granted)
        case .denied, .restricted:
            handler(.restricted)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ (newStatus) in
                DispatchQueue.main.async {
                    if newStatus == PHAuthorizationStatus.authorized {
                        handler(.granted)
                    } else {
                        handler(.restricted)
                    }
                }
            })
        @unknown default:
            handler(.restricted)
        }
    }

    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        picker.dismiss(animated: true, completion: nil)
        self.completion?(.success([image]))
    }
}
