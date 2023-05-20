//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by endava-bootcamp on 02.04.2023..
//

import Foundation
import UIKit
import PureLayout
import MovieAppData

class MovieDetailsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var movieBanner: MovieBanner!
    var details: MovieDetailsModel?
    var overview: UILabel!
    var summary: UILabel!
    var roleCollectionView: UICollectionView!
    var crewList: [MovieCrewMemberModel]!
    let reuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        details = MovieUseCase().getDetails(id: 111161)
        guard let details else {return}
        crewList = details.crewMembers
        createViews()
        styleViews()
        defineLayout()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    private func createViews() {
        guard let details else { return }
        
        movieBanner = MovieBanner(details: details)
        view.addSubview(movieBanner)
        
        overview = UILabel()
        overview.text = "Overview"
        view.addSubview(overview)
        
        summary = UILabel()
        summary.text = details.summary
        view.addSubview(summary)

        let roleLayout = UICollectionViewFlowLayout()
        roleLayout.scrollDirection = .vertical
        roleLayout.minimumInteritemSpacing = 10
        roleLayout.itemSize = CGSize(width: 110, height: 40)
        roleCollectionView = UICollectionView(frame: .zero, collectionViewLayout: roleLayout)
        roleCollectionView.dataSource = self
        roleCollectionView.delegate = self
        roleCollectionView.register(CrewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        view.addSubview(roleCollectionView)
    }
    
    private func styleViews() {
        view.backgroundColor = .white
        
        overview.font = UIFont.boldSystemFont(ofSize: 20)
        
        summary.font = UIFont.systemFont(ofSize: 14)
        summary.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .vertical)
        summary.numberOfLines = 0
        summary.lineBreakMode = .byWordWrapping
        
        roleCollectionView.backgroundColor = .white
    }
    
    private func defineLayout() {
        movieBanner.autoPinEdge(toSuperviewEdge: .top)
        movieBanner.autoPinEdge(toSuperviewEdge: .leading)
        movieBanner.autoPinEdge(toSuperviewEdge: .trailing)
        
        overview.autoPinEdge(.top, to: .bottom, of: movieBanner, withOffset: 22)
        overview.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        overview.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
        
        summary.autoPinEdge(.top, to: .bottom, of: overview, withOffset: 8)
        summary.autoMatch(.width, to: .width, of: view, withOffset: -32)
        summary.autoAlignAxis(toSuperviewAxis: .vertical)
        
        roleCollectionView.autoPinEdge(.top, to: .bottom, of: summary, withOffset: 27)
        roleCollectionView.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        roleCollectionView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 16)
        roleCollectionView.autoPinEdge(toSuperviewEdge: .bottom)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        crewList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = roleCollectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CrewCell
        let crewMember = crewList[indexPath.item]
        cell.setText(name: crewMember.name, role: crewMember.role)
        return cell
    }
}
