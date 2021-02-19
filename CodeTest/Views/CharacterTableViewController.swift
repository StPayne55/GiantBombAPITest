//
//  CharacterTableTableViewController.swift
//  CodeTest
//
//  Created by Stephen Payne on 2/18/21.
//

import UIKit
import Kingfisher

class CharacterTableViewController: UITableViewController {
    private var selectedCharacter: Character?
    private let viewModel = CharacterTableViewModel()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        viewModel.getCharacters()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == CharacterTableViewModel.detailSegueIdentifier,
           let detailVC = segue.destination as? CharacterDetailViewController {
            detailVC.character = selectedCharacter
        }
    }

    // MARK: - Table view delegate & data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return viewModel.characters.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard viewModel.characters.indices.contains(indexPath.row) else { return }
        
        let character = viewModel.characters[indexPath.row]
        selectedCharacter = character

        performSegue(withIdentifier: CharacterTableViewModel.detailSegueIdentifier, sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard viewModel.characters.indices.contains(indexPath.row),
              let characterCell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell") as? CharacterTableViewCell else { return UITableViewCell() }
        
        let character = viewModel.characters[indexPath.row]
        let thumbnail = URL(string: character.image.iconURL) ?? URL(fileURLWithPath: String(""))
        characterCell.configureCell(imageURL: thumbnail, name: character.name)
        return characterCell
    }
}

// MARK: - CharacterTableViewModelDelegate
extension CharacterTableViewController: CharacterTableViewModelDelegate {
    func didFetchCharacters() {
        tableView.reloadData()
    }
    
    func didReceiveError(error: Error) {
        let alert = UIAlertController(title: "Uh oh!", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {_ in
            self.dismiss(animated: true, completion: nil)
        })

        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - CharacterTableViewCell
class CharacterTableViewCell: UITableViewCell {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func configureCell(imageURL: URL, name: String) {
        configureViews()
        self.thumbnailImageView.kf.setImage(with: imageURL)
        self.nameLabel.text = name
    }

    private func configureViews() {
        thumbnailImageView.layer.cornerRadius = thumbnailImageView.frame.width / 2
    }
}
