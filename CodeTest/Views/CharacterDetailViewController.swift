//
//  CharacterDetailViewController.swift
//  CodeTest
//
//  Created by Stephen Payne on 2/18/21.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    var character: Character?

    // MARK: - Outlets
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var aliasLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
    }

    private func configureViews() {
        guard let char = character,
              let charImage = URL(string: char.image.screenLargeURL) else { return }

        aliasLabel.text = character?.aliases?.formattedAlias()
        characterImageView.layer.cornerRadius = 10
        characterImageView.kf.setImage(with: charImage)
        nameLabel.text = char.name
        descriptionLabel.text = char.deck
    }
}
