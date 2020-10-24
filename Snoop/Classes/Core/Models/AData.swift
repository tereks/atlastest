//
//  AData.swift
//  Snoop
//
//  Created by Sergey Kim on 19.10.2020.
//

import UIKit

public struct AData: ADataDescribing {

    public var title: String
    public var desc: String
    public var value: Int
    public var image: UIImage?

    public init(title: String, desc: String, value: Int, image: UIImage?) {
        self.title = title
        self.desc  = desc
        self.value = value
        self.image = image
    }
}

extension AData {

    typealias ManagedObject = AObject

    init?(object: ManagedObject?) {
        guard let object = object else { return nil }

        self.init(title: object.title, desc: object.desc, value: object.value, image: object.image)
    }

    func toManagedObject<T: ManagedObject>() -> T {
        let object   = T()
        object.title = self.title
        object.value = self.value
        object.desc  = self.desc
        object.image = self.image
        return object
    }
}
