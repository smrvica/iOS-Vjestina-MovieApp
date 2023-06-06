//
//  MovieCategorisedCollectionView.swift
//  MovieApp
//
//  Created by endava-bootcamp on 12.04.2023..
//

import Foundation
import UIKit
import PureLayout

class MovieCategorisedCollectionView: UIView {
    
    private var categoryCollectionView: UICollectionView!
    private var categoryLabel: UILabel!
    private var movieList: [[MovieModel]]!
    private var categoryString: String!
    
    private var btnStack: UIStackView!
    private var selected = 0
    private var tagBtns: [UILabel] = []
    private var tags: [String]
    
    private var favoritesList: [Int] = []
    private var changeFavorite: ((Int) -> Void)!
    
    private var movieDetailsRouter: MovieDetailsRouter!
    
    init(category: String, listOfMovies: [[MovieModel]], router: MovieDetailsRouter, tags: [String], changeFavoriteFunc: @escaping (Int) -> Void) {
        movieDetailsRouter = router
        categoryString = category
        movieList = listOfMovies
        self.tags = tags
        changeFavorite = changeFavoriteFunc
        super.init(frame: .zero)
        buildViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        categoryString = ""
        movieList = []
        tags = []
        super.init(coder: aDecoder)
        buildViews()
    }
    
    private func buildViews() {
        createViews()
        styleViews()
        defineLayout()
    }
    
    private func createViews() {
        categoryLabel = UILabel()
        addSubview(categoryLabel)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 8
        flowLayout.itemSize = CGSize(width: 122, height: 179)
        
        categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.register(MovieImageCell.self, forCellWithReuseIdentifier: MovieImageCell.reuseIdentifier)
        addSubview(categoryCollectionView)
        
        btnStack = UIStackView()
        addSubview(btnStack)
        
        for (index, tag) in tags.enumerated() {
            let btn = UIButton()
            let btnLabel = UILabel()
            btnLabel.text = tag
            if index == selected {
                btnLabel.font = .boldSystemFont(ofSize: 16)
            } else {
                btnLabel.font = .systemFont(ofSize: 16)
                btnLabel.textColor = .gray
            }
            btn.addSubview(btnLabel)
            btnLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
            btnLabel.autoAlignAxis(toSuperviewAxis: .vertical)
            btn.tag = index
            btn.addTarget(self, action: #selector(changeSelected), for: .touchUpInside)
            tagBtns.append(btnLabel)
            btnStack.addArrangedSubview(btn)
        }
    }
    
    private func styleViews() {
        categoryLabel.text = categoryString
        categoryLabel.font = .systemFont(ofSize: 20, weight: .heavy)
        
        btnStack.axis = .horizontal
        btnStack.alignment = .fill
        btnStack.distribution = .fillProportionally
        btnStack.spacing = 20
    }
    
    private func defineLayout() {
        categoryLabel.autoPinEdge(toSuperviewEdge: .top)
        categoryLabel.autoPinEdge(toSuperviewEdge: .leading)
        categoryLabel.autoPinEdge(toSuperviewEdge: .trailing)
        
        btnStack.autoPinEdge(.top, to: .bottom, of: categoryLabel, withOffset: 8)
        btnStack.autoPinEdge(toSuperviewEdge: .leading)
        btnStack.autoPinEdge(toSuperviewEdge: .trailing)
        
        categoryCollectionView.autoPinEdge(.top, to: .bottom, of: btnStack, withOffset: 24)
        categoryCollectionView.autoPinEdge(toSuperviewEdge: .bottom)
        categoryCollectionView.autoPinEdge(toSuperviewEdge: .leading)
        categoryCollectionView.autoPinEdge(toSuperviewEdge: .trailing)
        categoryCollectionView.autoSetDimension(.height, toSize: 179)
    }
    
    func setMovieList(movies: [[MovieModel]]) {
        movieList = movies
        DispatchQueue.main.async {
            self.categoryCollectionView.reloadData()
        }
    }
    
    func setFavoritesList(favorites: [Int]) {
        let old = favoritesList
        favoritesList = favorites
        
        var updatedIndexes: [IndexPath] = []
        var needUpdate = old.filter({
            let id = $0
            return favorites.contains(where: {$0 != id})
        })
        needUpdate.append(contentsOf: favorites.filter({
            let id = $0
            return old.contains(where: {$0 != id})
        }))
        for i in needUpdate {
            guard let index = movieList[selected].firstIndex(where: {$0.id == i}) else { continue }
            let indexPath = IndexPath(item: index, section: 0)
            updatedIndexes.append(indexPath)
        }
        
        DispatchQueue.main.async {
            self.categoryCollectionView.performBatchUpdates({
                self.categoryCollectionView.reloadItems(at: updatedIndexes)
            }, completion: nil)
        }
    }
    
    @objc func changeSelected(sender: UIButton) {
        guard tagBtns.count > 0 else { return }
        let index = sender.tag
        selected = index
        for i in 0...tagBtns.count - 1 {
            if i == index {
                tagBtns[i].font = .boldSystemFont(ofSize: 16)
                tagBtns[i].textColor = .black
            } else {
                tagBtns[i].font = .systemFont(ofSize: 16)
                tagBtns[i].textColor = .gray
            }
        }
        DispatchQueue.main.async {
            self.categoryCollectionView.reloadData()
        }
    }
}

extension MovieCategorisedCollectionView : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: MovieImageCell.reuseIdentifier, for: indexPath) as? MovieImageCell else { fatalError() }
        let movie = movieList[selected][indexPath.item]
        let isFav = favoritesList.contains(where: {$0 == movie.id})
        cell.setData(imageURL: movie.imageUrl, id: movie.id, router: movieDetailsRouter, isFavorite: isFav) { [weak self] id in self?.changeFavorite(id) }
        
        return cell
    }
}
