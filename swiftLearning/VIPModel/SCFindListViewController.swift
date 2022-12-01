//
//  SCFindListViewController.swift
//  Scripts
//
//  Created by 陈小贝 on 2022/11/28.
//

import UIKit
import MJRefresh

protocol SCFindShowListProtocol: AnyObject {
    func showFindList(_ with: SCFindListModels.FetchLists.ViewModel)
}

class SCFindListViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
        setupVIP()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupVIP()
    }
    
    var index: Int = 0
    // 主题ID
    var cid: Int = -1
    // 当前页面
    var currentIndex = 1
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.separatorStyle = .none
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = UIColor(rgb: 0xF5F5F5)
        let footer = MJRefreshAutoNormalFooter.init(refreshingBlock: { [weak self] in
            self?.getMoreData()
        }) as MJRefreshAutoNormalFooter
        footer.stateLabel?.textColor = .lightGray
        view.mj_footer = footer
        let header = MJRefreshNormalHeader.init(refreshingBlock: { [weak self] in
            self?.refreshData()
        }) as MJRefreshNormalHeader
        header.stateLabel?.textColor = .lightGray
        header.lastUpdatedTimeLabel?.textColor = .lightGray
        view.mj_header = header
        if #available(iOS 11.0, *) {
            view.contentInsetAdjustmentBehavior = .always
        }
        view.register(SCFindListCell.self, forCellReuseIdentifier: "SCFindListCellIdentifier")
        return view
    }()
    
    var dataSource: [SCFindListModels.FetchLists.ViewModel.FindListModel] = []
    
    var interactor: FindListDataProtocol?
    
    var router: (NSObjectProtocol & FindListRouterProtocol & FindListRouteDataProtocol)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchRequest(isMore: false)
    }
    
    deinit {
        print("SCFindListViewController销毁了")
    }
    
    func setupVIP() {
        let interactor: SCFindListInteractor = SCFindListInteractor()
        let presenter: SCFindListPresenter = SCFindListPresenter()
        let router: SCFindListRouter = SCFindListRouter()
        let controller: SCFindListViewController = self
        controller.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = controller
        controller.router = router
        router.viewController = controller;
        router.dataStore = interactor
    }
    
    func setupUI() {
        self.title = "VIP架构"
        self.view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.equalTo(0)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(0)
        }
    }
    
    func refreshData() {
        currentIndex = 1
        fetchRequest(isMore: false)
    }
    
    func getMoreData() {
        currentIndex = currentIndex + 1
        fetchRequest(isMore: true)
    }
    
    func fetchRequest(isMore: Bool) {
        let request: SCFindListModels.FetchLists.Request = SCFindListModels.FetchLists.Request(cid: cid, pageIndex: currentIndex , pageSize: 10,isMore: isMore)
        interactor?.getFindListData(request: request)
    }
    
    func fetchLikeReqest(id: Int, likeType: Int) {
        let request: SCFindListModels.FetchLike.Request = SCFindListModels.FetchLike.Request(id: id, likeType: likeType)
        interactor?.requestFindListLike(request: request)
    }

    func routeToShowImage(index: Int, images: [UIImage]) {
        router?.routerToShowImage(index: index, images: images);
    }
}

extension SCFindListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SCFindListCell = tableView.dequeueReusableCell(withIdentifier: "SCFindListCellIdentifier") as! SCFindListCell
        cell.accessibilityIdentifier = "SCFindListCellIdentifier-\(indexPath.row)"
        let model: SCFindListModels.FetchLists.ViewModel.FindListModel = dataSource[indexPath.row]
        cell.model = model
        cell.clickLikeBlock =  { [weak self] (btn, model) in
            //类型，1:点赞,2:取消点赞
            let type = btn.isSelected ? 2 : 1
            self?.fetchLikeReqest(id: model.id!, likeType: type)
        }
        cell.clickImageBlock = { [weak self] (index, images) in
            self?.routeToShowImage(index: index, images: images)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routerToDetail(index: indexPath.row)
    }
}

extension SCFindListViewController: SCFindShowListProtocol {
    func showFindList(_ with: SCFindListModels.FetchLists.ViewModel) {
        if with.isMore {
            if with.count > self.dataSource.count {
                self.tableView.mj_footer?.endRefreshing()
            }else {
                self.tableView.mj_footer?.endRefreshingWithNoMoreData()
            }
        } else {
            self.tableView.mj_header?.endRefreshing()
            if with.count < 10 {
                self.tableView.mj_footer?.endRefreshingWithNoMoreData()
                self.tableView.mj_footer?.isHidden = true
            }
        }
        self.dataSource = with.dataSource
        self.tableView.reloadData()
    }
}

