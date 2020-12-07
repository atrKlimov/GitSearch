//
//  SearchSectionModel.swift
//  GitSearch
//
//  Created by Mac on 12/6/20.
//

import RxSwift
import RxCocoa
import RxDataSources

// MARK: - SearchSectionItem
struct SearchSectionItem {
    var id: String
    var items: [Item]
}

// MARK: - SearchSectionItem: SectionModelType
extension SearchSectionItem: AnimatableSectionModelType, IdentifiableType {
    
    typealias Item = RepositoryItem
    
    var identity: String {
        return id
    }
    
    init(original: SearchSectionItem, items: [Item]) {
        self = original
        self.items = items
    }
}

// MARK: - SearchSectionItem: Equatable
extension SearchSectionItem: Equatable {
    
    static func == (lhs: SearchSectionItem, rhs: SearchSectionItem) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - RepositoryItem
struct RepositoryItem: IdentifiableType {
    
    var id: Int
    var repository: RepositoryModel
    
    var identity: String {
        return String(id) + repository.name
    }
    
    init(model: RepositoryModel) {
        self.id = model.id
        self.repository = model
    }
}

// MARK: - RepositoryModel: Equatable
extension RepositoryItem: Equatable {
    
    static func == (lhs: RepositoryItem, rhs: RepositoryItem) -> Bool {
        return lhs.identity == rhs.identity
    }
}
