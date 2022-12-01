//
//  SCFindListRouter.swift
//  Scripts
//
//  Created by 陈小贝 on 2022/11/28.
//

import UIKit
import ZLPhotoBrowser
import ShowImage

protocol FindListRouterProtocol {
    func routerToDetail(index: Int)
    func routerToShowImage(index: Int, images: [UIImage])
}

protocol FindListRouteDataProtocol {
    var dataStore: FindListDataStoreProtocol? { get }
}

class SCFindListRouter: NSObject, FindListRouterProtocol, FindListRouteDataProtocol {
    
    var dataStore: FindListDataStoreProtocol?
    
    weak var viewController: SCFindListViewController?
    
    
    func routerToShowImage(index: Int, images: [UIImage]) {
        /*let vc: ZLImagePreviewController = ZLImagePreviewController(datas: images,index: index, showSelectBtn: false, showBottomView: false)
        vc.modalPresentationStyle = .fullScreen
        viewController?.present(vc, animated: false)*/
        
        let vc: SCShowImageController = SCShowImageController()
        vc.index = index
        vc.images = images
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func routerToDetail(index: Int) {
        let model = dataStore?.dataSource[index]
        viewController?.navigationController?.pushViewController(DetailViewController(), animated: true)
    }

}
