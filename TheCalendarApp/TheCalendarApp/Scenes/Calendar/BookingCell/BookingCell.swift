import UIKit

struct BookingCellViewData {
    let spaceName: String
    let hourRange: String
    let imageUrl: URL?
}

final class BookingCell: UITableViewCell {
    @IBOutlet weak var spaceName: UILabel!
    @IBOutlet weak var hourRange: UILabel!
    @IBOutlet weak var spaceImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    private func commonInit() {
        spaceImageView.cornerRadius = ViewConstants.cornerRadius
    }
    
    func setViewData(_ data: BookingCellViewData) {
        spaceName.text = data.spaceName
        hourRange.text = data.hourRange
        spaceImageView.isHidden = data.imageUrl == nil
        
        if let imageUrl = data.imageUrl {
            self.loadImage(url: imageUrl, into: spaceImageView)
        }
    }
}
