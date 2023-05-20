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
    
    private var movieBanner: MovieBanner!
    private var details: MovieDetailsModel?
    private var overview: UILabel!
    private var summary: UILabel!
    private var roleCollectionView: UICollectionView!
    private var crewList: [MovieCrewMemberModel]!

    private let movieId: Int
    
    init(movieId: Int) {
        self.movieId = movieId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        details = MovieUseCase().getDetails(id: movieId)
        guard let details else {return}
        crewList = details.crewMembers
        createViews()
        styleViews()
        defineLayout()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            
        summary.transform = summary.transform.translatedBy(x: -view.frame.width, y: 0)
        roleCollectionView.alpha = 0
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate( withDuration: 0.2, animations: { self.summary.transform = .identity })
        UIView.animate( withDuration: 0.3, delay: 0.2, animations: { self.roleCollectionView.alpha = 1})
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
        roleCollectionView.register(CrewCell.self, forCellWithReuseIdentifier: CrewCell.reuseIdentifier)
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
        
        navigationItem.title = "Movie details"
    }
    
    private func defineLayout() {
        movieBanner.autoPinEdge(toSuperviewSafeArea: .top)
        movieBanner.autoMatch(.width, to: .width, of: view)
        
        overview.autoPinEdge(.top, to: .bottom, of: movieBanner, withOffset: 22)
        overview.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        overview.autoSetDimension(.height, toSize: 31)
        
        summary.autoPinEdge(.top, to: .bottom, of: overview, withOffset: 8)
        summary.autoMatch(.width, to: .width, of: view, withOffset: -32)
        summary.autoAlignAxis(toSuperviewAxis: .vertical)
        
        roleCollectionView.autoPinEdge(.top, to: .bottom, of: summary, withOffset: 27)
        roleCollectionView.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        roleCollectionView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 16)
        roleCollectionView.autoPinEdge(toSuperviewEdge: .bottom)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return crewList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = roleCollectionView.dequeueReusableCell(withReuseIdentifier: CrewCell.reuseIdentifier, for: indexPath) as? CrewCell else { fatalError() }
        let crewMember = crewList[indexPath.item]
        cell.setText(name: crewMember.name, role: crewMember.role)
        return cell
    }
}
