//
//  CharactersViewController.swift
//  RickAndMorty
//
//  Created by Konstantin Bratchenko on 14.09.2022.
//

import UIKit

final class CharactersViewController: ViewController {
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private var collectionView: UICollectionView!
    private var characters: CharactersResponse? {
        didSet { prepareNavigationButtons() }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadCharactersFrom(urlString: URLs.rickAndMortyCharacters)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
        
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        setItemSizeForCollectionView(layout: collectionView.collectionViewLayout, with: size)
    }
    
    override func configureViews() {
        view.backgroundColor = .secondarySystemBackground
        configureNavigationItem()
        configureCollectionView()
    }
    
    override func constrainViews() {
        view.addConstrainedSubviews(collectionView,
                                   activityIndicator)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor)
        ])
    }
    
    @objc private func didTapNextButton() {
        guard let nextPage = characters?.info.next else { return }
        downloadCharactersFrom(urlString: nextPage)
    }
    
    @objc private func didTapPrevButton() {
        guard let prevPage = characters?.info.prev else { return }
        downloadCharactersFrom(urlString: prevPage)
    }
    
    private func prepareNavigationButtons() {
        if (characters?.info.prev == nil) {
            navigationItem.leftBarButtonItem?.isEnabled = false
        } else {
            navigationItem.leftBarButtonItem?.isEnabled = true
        }
        if (characters?.info.next == nil) {
            navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
}

extension CharactersViewController {
    private func downloadCharactersFrom(urlString: String) {
        activityIndicator.startAnimating()
        NetworkManager.fetchCharactersFrom(urlString: urlString) { [weak self] characters in
            guard let self = self else { return }

            self.characters = characters
            self.collectionView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    
    private func setItemSizeForCollectionView(layout: UICollectionViewLayout, with size: CGSize) {
        guard let layout = layout as? UICollectionViewFlowLayout else { return }
        
        var numberOfElementsHorizontally: CGFloat
        
        if UIDevice.current.orientation.isPortrait {
            numberOfElementsHorizontally = 2
            layout.itemSize = CGSize(width: size.width / numberOfElementsHorizontally,
                                     height: size.width / numberOfElementsHorizontally)
        }
        if UIDevice.current.orientation.isLandscape {
            numberOfElementsHorizontally = 5
            layout.itemSize = CGSize(width: size.width / numberOfElementsHorizontally,
                                     height: size.width / numberOfElementsHorizontally)
        }
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()

        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        setItemSizeForCollectionView(layout: layout, with: CGSize(width: width, height: height))
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: CharacterCell.reuseIdentifier)
    }
    
    private func configureNavigationItem() {
        navigationItem.title = "Rick & Morty"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Prev", style: .plain, target: self, action: #selector(didTapPrevButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(didTapNextButton))
    }
}

extension CharactersViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        characters?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.reuseIdentifier, for: indexPath) as? CharacterCell else { fatalError("Couldn't dequeue cell") }
        guard let character = characters?.results[indexPath.item] else { return cell }
        cell.setData(with: character)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.object = characters?.results[indexPath.item]
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
