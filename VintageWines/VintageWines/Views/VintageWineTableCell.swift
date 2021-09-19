//
//  VintageWineTableCell.swift
//  VintageWines
//
//  Created by ashokdy on 16/09/2021.
//

import UIKit

class VintageWineTableCell: UITableViewCell {
    
    @IBOutlet weak var vintageImageView: UIImageView?
    @IBOutlet weak var wineryNamelabel: UILabel?
    @IBOutlet weak var vintageNameLabel: UILabel?
    @IBOutlet weak var flagImageView: UIImageView?
    @IBOutlet weak var locationLabel: UILabel?
    
    var vintageModel: Match? {
        didSet {
            configureView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureView() {
        guard let vintageModel = vintageModel else { return }
        vintageImageView?.downloadImageFrom(link: "https:\(vintageModel.vintage.image.variations.medium)")
        vintageNameLabel?.text = vintageModel.vintage.name
        wineryNamelabel?.text = vintageModel.vintage.wine.winery.name
        flagImageView?.image = UIImage(named: vintageModel.vintage.wine.region?.country ?? "")
        if let region = vintageModel.vintage.wine.region {
            let locationDetailsArray = [
                region.name,
                region.country.uppercased()
            ]
            locationLabel?.text = locationDetailsArray.joined(separator: ", ")
        } else {
            locationLabel?.text = ""
        }
    }
}
