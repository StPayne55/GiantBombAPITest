//
//  CharacterTableViewModel.swift
//  CodeTest
//
//  Created by Stephen Payne on 2/18/21.
//

import Foundation

protocol CharacterTableViewModelDelegate: class {
    func didFetchCharacters()
    func didReceiveError(error: Error)
}

class CharacterTableViewModel {
    weak var delegate: CharacterTableViewModelDelegate?
    var characters = [Character]()
    static let detailSegueIdentifier = "ShowDetailsSegue"

    func getCharacters() {
        APIManager.shared.getCharacters { (result) in
            switch result {
            case .success(let characters):
                self.characters = characters
                self.delegate?.didFetchCharacters()
            case .failure(let err):
                self.delegate?.didReceiveError(error: err)
            }
        }
    }
}

extension String {
    func formattedAlias() -> String {
        let sanitizedString = self.replacingOccurrences(of: "\r\n", with: ", ")
        return "(A.K.A. \(sanitizedString))"
    }
}

