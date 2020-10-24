//
//  DataDescribing.swift
//  Snoop
//
//  Created by Sergey Kim on 19.10.2020.
//

import UIKit

public protocol ADataDescribing {

    var title: String { get set }
    var desc: String { get set }
    var value: Int { get set }
    var image: UIImage? { get set }
}

public protocol BDataDescribing: ADataDescribing {

    var labels: [String] { get set }
}
