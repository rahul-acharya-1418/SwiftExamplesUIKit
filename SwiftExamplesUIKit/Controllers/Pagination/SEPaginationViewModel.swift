//
//  SEPaginationViewModel.swift
//  SwiftExamplesUIKit
//
//  Created by Rahul Acharya on 22/07/26.
//  Copyright © 2026 Swift Examples. All rights reserved.
//

import Foundation

final class SEPaginationViewModel  {
    
    public func getCharaterList() {
        let request = SERequest.character.getURL
        APIManager.shared.execute(
            request,
            expecting: CharaterResponse.self) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let success):
                    print(String(describing: success))
                case .failure(let failure):
                    print(String(describing: failure))
                }
            }
    }
}

