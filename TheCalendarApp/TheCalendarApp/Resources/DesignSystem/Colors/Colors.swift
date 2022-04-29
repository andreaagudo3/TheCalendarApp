import UIKit

struct Color {
    // MARK: Brand
    static let brand = UIColor(named: "brand") ?? UIColor.darkGray
    static let yellowSelection = UIColor(named: "yellowSelection") ?? UIColor.yellow
    static let brandDark = UIColor(named: "brandDark") ?? UIColor.darkGray
    static let brandDarkest = UIColor(named: "brandDarkest") ?? UIColor.darkGray
    static let brandAlpha20 = UIColor(named: "brandAlpha20") ?? UIColor.darkGray
    static let brandAlpha60 = UIColor(named: "brandAlpha60") ?? UIColor.darkGray
    static let brandAlpha10 = UIColor(named: "brandAlpha10") ?? UIColor.darkGray

    // MARK: Greyscale
    static let greyPrimary = UIColor(named: "greyPrimary") ?? UIColor.darkGray
    static let greySecondary = UIColor(named: "greySecondary") ?? UIColor.darkGray
    static let greyTertiary = UIColor(named: "greyTertiary") ?? UIColor.lightGray
    static let greyQuaternary = UIColor(named: "greyQuaternary") ?? UIColor.darkGray

    // MARK: Semantic
    /// Error
    static let error = UIColor(named: "error") ?? UIColor.darkGray
    static let errorLight = UIColor(named: "errorLight") ?? UIColor.darkGray
    static let errorLightest = UIColor(named: "errorLightest") ?? UIColor.darkGray

    /// Info
    static let info = UIColor(named: "info") ?? UIColor.darkGray
    static let infoLight = UIColor(named: "infoLight") ?? UIColor.darkGray
    static let infoLightest = UIColor(named: "infoLightest") ?? UIColor.darkGray

    /// Success
    static let success = UIColor(named: "success") ?? UIColor.darkGray
    static let successLight = UIColor(named: "successLight") ?? UIColor.darkGray
    static let successLightest = UIColor(named: "successLightest") ?? UIColor.darkGray

    /// Warning
    static let warning = UIColor(named: "warning") ?? UIColor.darkGray
    static let warningLight = UIColor(named: "warningLight") ?? UIColor.darkGray
    static let warningLightest = UIColor(named: "warningLightest") ?? UIColor.darkGray
    
    static let defaultMessage = UIColor(named: "defaultMessage") ?? UIColor.darkGray
}
