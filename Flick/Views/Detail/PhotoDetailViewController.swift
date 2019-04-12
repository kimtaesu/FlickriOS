//
//  DetailViewController.swift
//  Flick
//
//  Created by tskim on 01/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Hero
import MapKit
import ReactorKit
import ReadMoreTextView
import RxDataSources
import RxSwift
import UIKit

class PhotoDetailViewController: UIViewController {

    let imageView = UIImageView()
    let descriptionView = ReadMoreTextView()
    let profileImageView = UIImageView()
    let ownerName = UILabel()
    let dateTaken = UILabel()
    let popularView = PopularView()
    private var uiPanGesture = UIPanGestureRecognizer()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(_ photo: Photo) {
        super.init(nibName: nil, bundle: nil)
        reactor = PhotoDetailReactor(rootContainer.resolve(FlickrPhotoRepositoryType.self)!, photo: photo)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Asset.icClose.image, style: .plain, target: self, action: #selector(close))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationItem()
        view.backgroundColor = .white
        view.do {
            $0.addGestureRecognizer(uiPanGesture)
        }
        uiPanGesture.do {
            $0.addTarget(self, action: #selector(panGesture))
        }
        let preferHeight = view.frame.height * 0.4
        let preferSize = CGSize(width: view.frame.width, height: preferHeight)
        reactor?.action.onNext(.setLoadView(preferSize))
        imageView.do {
            view.addSubview($0)
            $0.snp.makeConstraints({ make in
                make.leading.equalToSuperview()
                make.centerX.equalToSuperview()
                make.top.equalToSuperview()
                make.height.equalTo(preferHeight)
            })
        }
        profileImageView.do {
            let width = 48
            view.addSubview($0)
            $0.snp.makeConstraints({ make in
                make.width.equalTo(width)
                make.height.equalTo(width)
                make.leading.equalToSuperview()
                make.top.equalTo(imageView.snp.bottom)
            })
            $0.layer.cornerRadius = CGFloat(width / 2)
            $0.clipsToBounds = true
        }
        ownerName.do {
            view.addSubview($0)
            $0.snp.makeConstraints({ make in
                make.leading.equalTo(profileImageView.snp.trailing)
                make.top.equalTo(profileImageView.snp.top)
            })
        }
        dateTaken.do {
            view.addSubview($0)
            $0.snp.makeConstraints({ make in
                make.trailing.equalToSuperview()
                make.top.equalTo(profileImageView.snp.top)
            })
        }
        popularView.do {
            view.addSubview($0)
            $0.snp.makeConstraints({ make in
                make.top.equalTo(profileImageView.snp.bottom)
                make.centerX.equalToSuperview()
                make.leading.equalToSuperview()
            })
            $0.setUp([
                LikesViewModel(type: .likes, count: 12, image: Asset.icThumbUp.image),
                LikesViewModel(type: .views, count: 14, image: Asset.icViews.image),
                LikesViewModel(type: .comments, count: 122, image: Asset.icComments.image)
                ])
        }
        descriptionView.do {
            view.addSubview($0)
            $0.snp.makeConstraints({ make in
                make.top.equalTo(popularView.snp.bottom)
                make.leading.equalToSuperview()
                make.centerX.equalToSuperview()
            })
            
            $0.shouldTrim = true
            $0.maximumNumberOfLines = 4
            let readMoreTextAttributes: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key.foregroundColor: view.tintColor,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)
            ]
            $0.attributedReadMoreText = NSAttributedString(string: "...Read more", attributes: readMoreTextAttributes)
        }
        
//        self.addViewContainer(commentViewController)
//        commentViewController.view.do {
//            view.addSubview($0)
//            $0.snp.makeConstraints({ make in
//                make.leading.equalToSuperview()
//                make.centerX.equalToSuperview()
//                make.top.equalTo(descriptionView.snp.bottom)
//                make.bottom.equalTo(safeAreaBottom)
//            })
//        }
    }

    @objc
    func panGesture() {
        let translation = uiPanGesture.translation(in: nil)
        let progress = translation.y / view.bounds.height
        switch uiPanGesture.state {
        case .began:
            hero.dismissViewController()
        case .changed:
            Hero.shared.update(progress)
            let currentPos = CGPoint(x: translation.x + view.center.x, y: translation.y + view.center.y)
            Hero.shared.apply(modifiers: [.position(currentPos)], to: imageView)
        default:
            if progress + uiPanGesture.velocity(in: nil).y / view.bounds.height > 0.3 {
                Hero.shared.finish()
            } else {
                Hero.shared.cancel()
            }
        }
    }

    private func initNavigationItem() {
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: Asset.icClose.image, style: .plain, target: self, action: #selector(close))
        ]
    }

    @objc
    func close() {
        hero.dismissViewController()
    }
    @objc
    func switchMapView() {

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.do {
            $0.setBackgroundImage(UIImage(), for: .default)
            $0.shadowImage = UIImage()
            $0.isTranslucent = true
            $0.tintColor = UIColor.white
        }
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}

extension PhotoDetailViewController: View, HasDisposeBag {
    func bind(reactor: PhotoDetailReactor) {

        reactor.state.map { $0.ownerName }
            .bind(to: ownerName.rx.text)
            .disposed(by: disposeBag)

        reactor.state.map { $0.dateTaken }
            .bind(to: dateTaken.rx.text)
            .disposed(by: disposeBag)

        reactor.state.map { $0.title }
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)

        reactor.state.map { $0.desc }
            .bind(to: descriptionView.rx.text)
            .disposed(by: disposeBag)

        reactor.state.map { $0.detailImage }
            .distinctUntilChanged()
            .bind { [weak self] url in
                guard let self = self else { return }
                self.imageView.kf.setImage(
                    with: url,
                    placeholder: nil,
                    options: [],
                    progressBlock: { receivedSize, totalSize in
                    },
                    completionHandler: { result in
                        logger.info(result)
                    }
                )
            }
            .disposed(by: disposeBag)

        reactor.state.map { $0.buddyIcon }
            .distinctUntilChanged()
            .bind { [weak self] url in
                guard let self = self else { return }
                self.profileImageView.kf.setImage(
                    with: url,
                    placeholder: nil,
                    options: [],
                    progressBlock: { receivedSize, totalSize in
                    },
                    completionHandler: { result in
                        logger.info(result)
                    }
                )
            }
            .disposed(by: disposeBag)
    }
}
