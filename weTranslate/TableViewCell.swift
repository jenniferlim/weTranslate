//
//  TableViewCell.swift
//  weTranslate
//
//  Created by Jennifer on 21/02/2016.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    // MARK: - Init

    init(style: UITableViewCellStyle = .default, reuseIdentifier: String?, view: UIView) {

        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.isOpaque = true
        backgroundColor = .white
        isOpaque = true

        contentView.addSubview(view)

        let margins = contentView.layoutMarginsGuide
        view.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
