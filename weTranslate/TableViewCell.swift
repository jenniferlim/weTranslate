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

    init(style: UITableViewCellStyle = .Default, reuseIdentifier: String?, view: UIView) {

        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.opaque = true
        backgroundColor = .whiteColor()
        opaque = true

        contentView.addSubview(view)

        let margins = contentView.layoutMarginsGuide
        view.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor).active = true
        view.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor).active = true
        view.topAnchor.constraintEqualToAnchor(margins.topAnchor).active = true
        view.bottomAnchor.constraintEqualToAnchor(margins.bottomAnchor).active = true
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
