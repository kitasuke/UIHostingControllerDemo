//
//  ViewController.swift
//  UIHostingControllerDemo
//
//  Created by ptn-yusuke.kita on 2023/08/22.
//

import UIKit
import SwiftUI

final class ViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.delegate = self
        $0.dataSource = self
        $0.register(SwiftUICollectionViewCell.self, forCellWithReuseIdentifier: String(describing: SwiftUICollectionViewCell.self))
        $0.register(UIKitCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: UIKitCollectionViewCell.self))
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))
    
    private let swiftUIView: SwiftUIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(SwiftUIView())

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /// 1: SwiftView on UIHostingController in UICollectionViewCell
        /// 2: UILabel in UICollectionViewCell
        /// 3: SwiftView on UIHostingController
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            collectionView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        view.addSubview(swiftUIView)
        NSLayoutConstraint.activate([
            swiftUIView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            swiftUIView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            swiftUIView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            swiftUIView.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private static let cellForItemSize = UIKitCollectionViewCell()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = view.frame.width
//        let cell = ViewController.cellForItemSize
//        let height = cell.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel).height
//        let size = cell.label.sizeThatFits(view.frame.size)
        return .init(width: width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell
        if indexPath.row == 0 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SwiftUICollectionViewCell.self), for: indexPath)
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: UIKitCollectionViewCell.self), for: indexPath)
        }
        return cell
    }
}

final class SwiftUICollectionViewCell: UICollectionViewCell {
    private(set) lazy var hostingController: UIHostingController = {
        $0._disableSafeArea = true
        $0.safeAreaRegions = SafeAreaRegions()
        $0.view.translatesAutoresizingMaskIntoConstraints = false
        $0.view.backgroundColor = .lightGray
        return $0
    }(UIHostingController(rootView: SwiftView()))
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .lightGray
        contentView.addSubview(hostingController.view)
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

final class UIKitCollectionViewCell: UICollectionViewCell {

    private(set) lazy var label: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = multilineText
        $0.numberOfLines = 0
        $0.backgroundColor = .white
        return $0
    }(UILabel(frame: .zero))
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = .lightGray
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

final class SwiftUIView: UIView {
    private lazy var hostingController: UIHostingController = {
        $0._disableSafeArea = true
        $0.safeAreaRegions = SafeAreaRegions()
        $0.additionalSafeAreaInsets = .zero
        $0.view.translatesAutoresizingMaskIntoConstraints = false
        $0.view.backgroundColor = .lightGray
        return $0
    }(UIHostingController(rootView: SwiftView()))
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(hostingController.view)
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

struct SwiftView: View {
    
    var body: some View {
        VStack {
            Text(multilineText)
                .frame(alignment: .topLeading)
                .lineLimit(nil)
                .background(.white)
        }
    }
}

private var multilineText = """
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
"""
