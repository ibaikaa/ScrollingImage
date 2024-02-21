//
//  ViewController.swift
//  StrecthedImage
//
//  Created by Ian Baikuchukov on 20/2/24.
//

import UIKit

class ViewController: UIViewController {

    private let IMAGE_HEIGHT: CGFloat = 270.0

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(
            frame: .init(
                x: 0,
                y: 0,
                width: view.frame.width,
                height: IMAGE_HEIGHT
            )
        )
        imageView.image = UIImage(named: "image")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.contentSize.height = view.frame.height + IMAGE_HEIGHT
        return scrollView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addScrollView()
    }
    
    func addScrollView() {
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - UIScrollViewDelegate

extension ViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        if offset <= .zero {
            imageView.frame.origin.y = offset
            imageView.frame.size.height = IMAGE_HEIGHT - offset
        }
        
        scrollView.verticalScrollIndicatorInsets.top = IMAGE_HEIGHT - offset - view.safeAreaInsets.top
    }
    
}
