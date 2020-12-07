//
//  SearchViewController.swift
//  GitSearch
//
//  Created by Mac on 12/5/20.
//  
//

import RxCocoa
import RxSwift
import RxDataSources

class SearchViewController: UIViewController, StoryboardInitializable {

    // - Outlets
    @IBOutlet weak var searchTableView: UITableView!
    
    // - Internal properties
    var viewModel: SearchViewModel!

    // - Private properties
    private var disposeBag = DisposeBag()
    private var searchView = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupBinding()
    }

    // - UI Setup
    private func setupUI() {
        self.navigationItem.titleView = self.searchView
        self.setupSearchTableView()
    }

    private func setupSearchTableView() {
        self.searchTableView.register(SearchCell.nib, forCellReuseIdentifier: SearchCell.identifier)
        self.searchTableView.tableFooterView = UIView()
    }
    
    // - Binding Setup
    private func setupBinding() {
        self.searchView.rx.text
            .debounce(.milliseconds(300), scheduler: MainScheduler.asyncInstance)
            .map { $0 ?? "" }
            .subscribe(onNext: { [weak self] text in
                self?.viewModel.searchRepository(by: text)
            })
            .disposed(by: self.disposeBag)
        
        self.viewModel.searchDataSource
            .bind(to: self.searchTableView.rx.items(dataSource: self.dataSource))
            .disposed(by: self.disposeBag)
    }
}

// SearchViewController - RxTableViewSectionedAnimatedDataSource
extension SearchViewController {
    var dataSource: RxTableViewSectionedAnimatedDataSource<SearchSectionItem> {
        let animationConfiguration = AnimationConfiguration(
            insertAnimation: .fade,
            reloadAnimation: .fade,
            deleteAnimation: .fade
        )
        
        let sectionedDataSource = RxTableViewSectionedAnimatedDataSource<SearchSectionItem>(animationConfiguration: animationConfiguration, configureCell: { _, collectionView, indexPath, item -> UITableViewCell in

            let cell = collectionView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath) as! SearchCell
            cell.configCell(with: item.repository)
            return cell
        })
        return sectionedDataSource
    }
}
