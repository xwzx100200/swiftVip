//
//  SCFindListCell.swift
//  Scripts
//
//  Created by 陈小贝 on 2022/11/28.
//

import UIKit
import Kingfisher
import KingfisherWebP
import SnapKit

class SCFindListCell: UITableViewCell {
    
    var clickShareBlock: ((_ model: SCFindListModels.FetchLists.ViewModel.FindListModel, _ images: [UIImage])->())?
    
    var clickImageBlock: ((_ index: Int, _ images: [UIImage])->())?
    
    var clickLikeBlock: ((_ sender: UIButton, _ model: SCFindListModels.FetchLists.ViewModel.FindListModel)->())?
    
    var model: SCFindListModels.FetchLists.ViewModel.FindListModel? = nil {
        willSet {
            self.reloadData(newValue!)
        }
    }
    
    private var headerImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = UIColor(rgb: 0xF5F5F5)
        image.layer.cornerRadius = 17
        image.layer.masksToBounds = true
        return image
    }()
    
    var headerNameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font =  UIFont.systemFont(ofSize: 13)
        nameLabel.textColor = .init(rgb: 0x222222)
        nameLabel.text = ""
        nameLabel.textAlignment = .left
        return nameLabel
    }()

    var contentLabel: UILabel = {
        let contentLabel = UILabel()
        contentLabel.font =  UIFont.systemFont(ofSize: 15)
        contentLabel.textColor = .init(rgb: 0x222222)
        contentLabel.text = ""
        contentLabel.textAlignment = .left
        contentLabel.numberOfLines = 0
        return contentLabel
    }()
    
    // 分享
    lazy private var shareBtn: UIButton = {
        let shareBtn: UIButton = UIButton()
        shareBtn.setTitle("分享", for: .normal)
        shareBtn.setImage(UIImage(named: "sc_find_share"), for: .normal)
        shareBtn.setTitleColor(UIColor(rgb: 0x999999), for: .normal)
        shareBtn.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        shareBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        shareBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
        shareBtn.addTarget(self, action: #selector(clickShareBtn), for: .touchUpInside)
        return shareBtn
    }()
    
    // 点赞
    lazy private var likeBtn: UIButton = {
        let likeBtn: UIButton = UIButton()
        likeBtn.setTitle("点赞", for: .normal)
        likeBtn.setImage(UIImage(named: "sc_find_like_normal"), for: .normal)
        likeBtn.setImage(UIImage(named: "sc_find_like_selected"), for: .selected)
        likeBtn.setTitleColor(UIColor(rgb: 0x999999), for: .normal)
        likeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        likeBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        likeBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
        //likeBtn.contentHorizontalAlignment = .right
        likeBtn.setTitleColor(UIColor(rgb: 0x5C55F1), for: UIControl.State.selected)
        likeBtn.addTarget(self, action: #selector(clickLikeBtn(sender:)), for: UIControl.Event.touchUpInside)
        return likeBtn
    }()
    
    private var imageContentView: UIView = {
        let contentView: UIView = UIView()
        contentView.backgroundColor = .clear
        return contentView
    }()
    
    private var lineView: UIView = {
        let lineView: UIView = UIView()
        lineView.backgroundColor = UIColor(rgb: 0xF5F5F5)
        return lineView
    }()
    
    private var images: [UIImageView] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupUI()
        remakeConstraints()
    }
    
    func setupUI() {
        contentView.addSubview(headerImage)
        contentView.addSubview(headerNameLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(imageContentView)
        contentView.addSubview(shareBtn)
        contentView.addSubview(likeBtn)
        contentView.addSubview(lineView)
    }
    
    func reloadData(_ model: SCFindListModels.FetchLists.ViewModel.FindListModel) {
        print("reloadData")
        headerNameLabel.text = model.nickname
        //headerImage.setImage(model.avatar)
        headerImage.kf.setImage(with: .network(URL(string: model.avatar)!))
        contentLabel.text = model.content
        if model.isLike == 1 {
            likeBtn.isSelected = true
            likeBtn.setTitle("\(model.likeCount)", for: .selected)
        }else {
            likeBtn.isSelected = false
            let titleStr: String = model.likeCount == 0 ? "点赞" : "\(model.likeCount)"
            likeBtn.setTitle(titleStr, for: .normal)
        }
        
        images.removeAll { image in
            image.removeFromSuperview()
            return true
        }
        if model.images.count == 0 {
            imageContentView.snp.remakeConstraints { make in
                make.top.equalTo(contentLabel.snp.bottom).offset(10)
                make.left.right.equalTo(contentLabel)
                make.height.equalTo(0)
            }
        } else {
            layoutImages(model)
        }
        
        setupAccessibility(model)
        
        self.setNeedsDisplay()
    }
    
    func layoutImages(_ model: SCFindListModels.FetchLists.ViewModel.FindListModel) {
        let count = model.images.count
        let screenWidth = UIScreen.main.bounds.size.width
        let width = screenWidth - 15 - 34 - 10 - 15
        let space: CGFloat = 8
        let imageWidth: CGFloat = (width - 2*space) / 3.0
        for i in 0..<count {
            let imageStr = model.images[i]
            let image: UIImageView = UIImageView(frame: CGRect(x: CGFloat(i%3)*(imageWidth+space), y: CGFloat(i/3)*(imageWidth+space), width: imageWidth, height: imageWidth))
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickImage(sender:)))
            image.isUserInteractionEnabled = true
            image.addGestureRecognizer(tap)
            image.backgroundColor = UIColor(rgb: 0xF5F5F5)
            image.kf.setImage(with: .network(URL(string: imageStr)!))
            //image.setImage(imageStr)
            imageContentView.addSubview(image)
            image.contentMode = .scaleAspectFill
            image.layer.cornerRadius = 10
            image.layer.masksToBounds = true
            images.append(image)
        }
        let lastImage: UIImageView = images.last!
        imageContentView.snp.remakeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(10)
            make.left.right.equalTo(contentLabel)
            make.height.equalTo(lastImage.frame.origin.y + imageWidth)
        }
    }
    
    func remakeConstraints() {
        headerImage.snp.remakeConstraints { make in
            make.left.equalTo(15)
            make.width.height.equalTo(34)
            make.top.equalTo(15)
        }
        
        headerNameLabel.snp.remakeConstraints { make in
            make.left.equalTo(headerImage.snp.right).offset(10)
            make.centerY.equalTo(headerImage)
            make.right.equalTo(-15)
        }
        
        contentLabel.snp.remakeConstraints { make in
            make.top.equalTo(headerImage.snp.bottom).offset(10)
            make.left.right.equalTo(headerNameLabel)
        }
        
        imageContentView.snp.remakeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(10)
            make.left.right.equalTo(contentLabel)
            make.height.equalTo(10)
            
        }
        
        shareBtn.snp.remakeConstraints { make in
            make.top.equalTo(imageContentView.snp.bottom).offset(15)
            make.right.equalTo(contentLabel)
            make.width.equalTo(50)
        }
        
        likeBtn.snp.remakeConstraints { make in
            make.top.equalTo(shareBtn)
            make.right.equalTo(shareBtn.snp.left).offset(-15)
            make.width.equalTo(60)
        }
        
        lineView.snp.remakeConstraints { make in
            make.left.equalTo(0)
            make.right.equalToSuperview()
            make.top.equalTo(likeBtn.snp.bottom).offset(20)
            make.height.equalTo(0.5)
            make.bottom.equalToSuperview()
        }
    }
    
    func setupAccessibility(_ model: SCFindListModels.FetchLists.ViewModel.FindListModel) {
        headerImage.isAccessibilityElement = true
        headerImage.accessibilityLabel = "发布者头像"
        headerNameLabel.isAccessibilityElement = true
        headerNameLabel.accessibilityLabel = model.nickname
        headerNameLabel.accessibilityHint = "发布者名称"
        
        // 跟随系统的设置里字体变大而变大
        /*contentLabel.font = .preferredFont(forTextStyle: .body)
        contentLabel.adjustsFontForContentSizeCategory = true*/
        
        
        
        for image in images {
            image.isAccessibilityElement = true
            image.accessibilityLabel = "发布的图片"
            image.accessibilityHint = "点击可看大图"
            image.accessibilityTraits = .image
        }
        
    }
    
    @objc func clickShareBtn() {
        if let model = model {
            var imageArr: [UIImage] = []
            for iv in images {
                if let image = iv.image {
                    imageArr.append(image)
                }
            }
            self.clickShareBlock?(model, imageArr)
        }
    }
    
    @objc func clickLikeBtn(sender: UIButton) {
        self.clickLikeBlock?(sender, self.model!)
    }
    
    @objc func clickImage(sender: UITapGestureRecognizer) {
        let imageView: UIImageView = sender.view as! UIImageView
        let index: Int = images.firstIndex(of: imageView) ?? 0
        var imageArr: [UIImage] = []
        for iv in images {
            if let image = iv.image {
                imageArr.append(image)
            }
        }
        self.clickImageBlock?(index, imageArr)
        //print("点击了图片")
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
