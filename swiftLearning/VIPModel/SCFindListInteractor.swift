//
//  SCFindListInteractor.swift
//  Scripts
//
//  Created by 陈小贝 on 2022/11/28.
//

import Foundation

protocol FindListDataProtocol {
    func getFindListData(request: SCFindListModels.FetchLists.Request);
    func requestFindListLike(request: SCFindListModels.FetchLike.Request)
}

protocol FindListDataStoreProtocol {
    var dataSource: [ListModel] { get }
}

class SCFindListInteractor: FindListDataProtocol, FindListDataStoreProtocol {
    var dataSource: [ListModel] = [];
    var presenter: FindListPresenterDataProtocol?
    var worker: SCFindListWorker = SCFindListWorker()
    
    func getFindListData(request: SCFindListModels.FetchLists.Request) {
        worker.requestForFindListData(cid: request.cid, pageIndex: request.pageIndex, pageSize: request.pageSize) {[weak self] dataModel in
            if request.isMore {
                self?.dataSource.append(contentsOf: dataModel.list)
            } else {
                self?.dataSource = dataModel.list
            }
            let response = SCFindListModels.FetchLists.Response(dataSource: self?.dataSource ?? [], count: dataModel.count ?? 0,isMore: request.isMore)
            self?.presenter?.presentListData(response: response)
        }
    }
    
    func requestFindListLike(request: SCFindListModels.FetchLike.Request) {
        worker.requestForBtnLike(id: request.id, likeType: request.likeType) { [weak self] in
            if let dataSource = self?.dataSource {
                for model in dataSource {
                    if model.id == request.id {
                        if request.likeType == 1 {
                            model.isLike = 1
                            let count = model.likeCount
                            model.likeCount = count + 1
                        } else {
                            model.isLike = 2
                            let count = model.likeCount
                            model.likeCount = (count - 1) <= 0 ? 0 : count - 1
                        }
                    }
                }
                let response = SCFindListModels.FetchLists.Response(dataSource: dataSource, count: dataSource.count,isMore: false)
                self?.presenter?.presentListData(response: response)
            }
        }
    }
}
