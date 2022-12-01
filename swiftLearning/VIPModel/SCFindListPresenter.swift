//
//  SCFindListPresenter.swift
//  Scripts
//
//  Created by 陈小贝 on 2022/11/28.
//

import Foundation

protocol FindListPresenterDataProtocol {
    func presentListData(response: SCFindListModels.FetchLists.Response);
}

class SCFindListPresenter: FindListPresenterDataProtocol {
    weak var viewController: SCFindShowListProtocol?
    
    func presentListData(response: SCFindListModels.FetchLists.Response) {
        let datasource = response.dataSource.map { model -> SCFindListModels.FetchLists.ViewModel.FindListModel in
            var item: SCFindListModels.FetchLists.ViewModel.FindListModel = SCFindListModels.FetchLists.ViewModel.FindListModel()
            item.isLike = model.isLike
            item.id = model.id
            item.avatar = model.mem?.avatar ?? ""
            item.nickname = model.mem?.nickname ?? ""
            item.content = model.content
            item.likeCount = model.likeCount
            item.images = model.images
            return item
        }
        let vm = SCFindListModels.FetchLists.ViewModel(dataSource: datasource, count: response.count,isMore: response.isMore)
        
        viewController?.showFindList(vm)
        
    }
}

