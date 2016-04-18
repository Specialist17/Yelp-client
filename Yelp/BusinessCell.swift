//
//  BusinessCell.swift
//  Yelp
//
//  Created by Fernando on 4/17/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {

    @IBOutlet var thumbImgView: UIImageView!
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var distanceLbl: UILabel!
    @IBOutlet var priceLbl: UILabel!
    @IBOutlet var reviewsCountLbl: UILabel!
    @IBOutlet var adressLbl: UILabel!
    @IBOutlet var categoriesLbl: UILabel!
    @IBOutlet var ratingsImgView: UIImageView!
    
    var business: Business! {
        didSet{
            nameLbl.text = business.name
            thumbImgView.setImageWithURL(business.imageURL!)
            categoriesLbl.text = business.categories
            adressLbl.text = business.address
            reviewsCountLbl.text = "\(business.reviewCount!) Reviews"
            ratingsImgView.setImageWithURL(business.ratingImageURL!)
            distanceLbl.text = business.distance
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbImgView.layer.cornerRadius = 4
        thumbImgView.clipsToBounds = true
        
        nameLbl.preferredMaxLayoutWidth =  nameLbl.frame.size.width
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLbl.preferredMaxLayoutWidth =  nameLbl.frame.size.width
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
