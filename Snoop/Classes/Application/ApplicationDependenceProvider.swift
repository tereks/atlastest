//
//  ApplicationDependenceProvider.swift
//  Snoop
//
//  Created by Sergey Kim on 19.10.2020.
//

import Foundation
import Dip

let container = DependencyContainer(configBlock: configureContainer)

func configureContainer(container rootContainer: DependencyContainer) {
}

func resolve<T>() -> T {
    return try! container.resolve() as T
}

final class ApplicationDependenceProvider {

    func configure() {
        container.register(.singleton) { () -> RootRoutable in
            return RootRouter()
        }

        container.register(.singleton) { () -> ApplicationNavCoordinator in
            let dependencies = ApplicationNavCoordinator.Dependencies(router: resolve())
            return ApplicationNavCoordinator(dependencies: dependencies)
        }

        container.register(.shared) { () -> TextGenerator in
            return TextGenerator()
        }
        container.register(.shared) { () -> MediaProvider in
            return MediaProvider()
        }
    }
}
