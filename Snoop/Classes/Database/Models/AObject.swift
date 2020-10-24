//
//  AObject.swift
//  Snoop
//
//  Created by Sergey Kim on 19.10.2020.
//

import Foundation
import RealmSwift

public class AObject: Object {

    @objc dynamic var title: String = ""
    @objc dynamic var desc: String = ""
    @objc dynamic var value: Int = 0
    @objc dynamic var imageData: Data? = nil

    var image: UIImage? {
        get {
            guard let imageData = imageData else { return nil }
            return UIImage(data: imageData)
        }
        set {
            imageData = newValue?.jpegData(compressionQuality: 1)
        }
    }

    public required init() {
        super.init()
    }
}
