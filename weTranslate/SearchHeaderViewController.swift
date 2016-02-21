//
//  SearchHeaderViewController.swift
//  weTranslate
//
//  Created by Lionel on 2/21/16.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import UIKit

protocol SearchHeaderViewControllerDelegate: class {
    func searchHeaderViewController(searchHeaderViewController: SearchHeaderViewController, didSearchWord word: String)
}

final class SearchHeaderViewController: UIViewController {

    // MARK: - Properties

    weak var delegate: SearchHeaderViewControllerDelegate?


    // MARK: - Init

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - UIViewController

    override func loadView() {
        self.view = SearchHeaderView(frame: .zero)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
