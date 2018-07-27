//
//  GuestsHeaderView.swift
//  KnotSeatingHackathon
//
//  Created by Jesse Sahli on 7/27/18.
//  Copyright © 2018 XO Group. All rights reserved.
//

import UIKit

class GuestsHeaderView: UIView {

    @IBOutlet var contentView: UIView!


    override init(frame: CGRect) {
        super.init(frame: frame)
        prepare()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepare()
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }

    private func prepare() {
        Bundle.main.loadNibNamed("GuestsHeaderView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
    }


}
