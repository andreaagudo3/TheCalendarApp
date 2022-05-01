import UIKit

final class SectionHeaderView: UIView {

    @IBOutlet weak private var titleLabel: UILabel!

    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib(nibName: SectionHeaderView.reuseID)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib(nibName: SectionHeaderView.reuseID)
    }
}
