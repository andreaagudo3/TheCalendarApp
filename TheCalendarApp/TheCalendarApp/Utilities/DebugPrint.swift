import Foundation

struct DebugPrint {

    enum IconType { 
        static let error = "📕[ERROR] "
        static let ok = "📗[OK] "
        static let warning = "⚠️[WARNING] "
        static let action = "📘[ACTION] "
        static let canceled = "📓[CANCELED] "
        static let other = "📔[OTHER] "
        static let notification = "🔴[PUSH] "
        static let info = "📣[INFO] "
        static let tada = "🎉[TADA] "
    }

    static func error(_ error: String = "") {
        logInfo(IconType.error + error)
    }

    static func ok(_ response: String = "") {
        logInfo(IconType.ok + response)
    }

    static func data(_ data: String = "") {
        logInfo(IconType.other + data)
    }

    static func canceled(_ data: String = "") {
        logInfo(IconType.canceled + data)
    }

    static func action(_ data: String = "") {
        logInfo(IconType.action + data)
    }

    static func warning(_ data: String = "") {
        logInfo(IconType.warning + data)
    }

    static func notification(_ data: String = "") {
        logInfo(IconType.notification + data)
    }

    static func info(_ info: String = "") {
        logInfo(IconType.info + info)
    }

    static func tada(_ info: String = "") {
        logInfo(IconType.tada + info)
    }

    fileprivate static func logInfo(_ message: String) {
        #if !RELEASE
        print("DEBUGPRINT " + message)
        #endif
    }
}
