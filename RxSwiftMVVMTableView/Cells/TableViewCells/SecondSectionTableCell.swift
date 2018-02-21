//
//  SecondSectionTableCell.swift
//  RxSwiftMVVMTableView
//
//  Created by tokijh on 2018. 2. 21..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import UIKit
import SnapKit

class SecondSectionTableCell: UITableViewCell {
    
    public static let Identifier = "SecondSectionTableCell"
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "This is second section cell"
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    func initView() {
        appendSubViews()
        setConstraints()
    }
    
    func appendSubViews() {
        self.contentView.addSubview(self.label)
    }
    
    func setConstraints() {
        self.label.snp.makeConstraints {
            $0.edges.equalTo(self.contentView).inset(UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15))
        }
    }
}

