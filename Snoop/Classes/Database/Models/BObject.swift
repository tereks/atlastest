//
//  BObject.swift
//  Snoop
//
//  Created by Sergey Kim on 19.10.2020.
//

import Foundation
import RealmSwift

private let separator = "~^~"

public final class BObject: AObject {

    private var labelsValue = List<String>()
    var labels: [String] {
        get {
            return Array(labelsValue)
        }
        set {
            labelsValue.removeAll()
            labelsValue.append(objectsIn: newValue)
        }
    }

    public required init() {
        super.init()
    }
}
