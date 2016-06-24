//
//  FavoriteTableViewCell.swift
//  weTranslate
//
//  Created by Jennifer on 09/03/2016.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import UIKit

final class FavoriteTableViewCell: UITableViewCell {

    // MARK: - Properties

    @IBOutlet weak var originalView: UIView!
    @IBOutlet weak var translatedView: UIView!

    @IBOutlet weak var orignalWordLabel: UILabel!
    @IBOutlet weak var translatedWordLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        self.originalView.layer.cornerRadius = 4
        self.translatedView.layer.cornerRadius = 4
    }

    var viewModel: FavoriteViewModel? {
        didSet {
            if let viewModel = viewModel {
                self.orignalWordLabel?.text  = viewModel.searchText
                self.translatedWordLabel?.text = viewModel.translatedText
            }
        }
    }
}
