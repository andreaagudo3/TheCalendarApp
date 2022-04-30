//
//  ImageManager.swift
//  CalendarApp
//
//  Created by Andrea Agudo on 18/4/22.
//

import Nuke
import CommonCrypto.CommonDigest

extension String {
    private func digest(input: NSData) -> NSData {
        let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
        var hash = [UInt8](repeating: 0, count: digestLength)
        CC_SHA256(input.bytes, UInt32(input.length), &hash)
        return NSData(bytes: hash, length: digestLength)
    }

    func sha256() -> String {
        if let stringData = self.data(using: String.Encoding.utf8) {
            return hexStringFromData(input: digest(input: stringData as NSData))
        }

        return ""
    }

    private  func hexStringFromData(input: NSData) -> String {
        var bytes = [UInt8](repeating: 0, count: input.length)
        input.getBytes(&bytes, length: input.length)

        var hexString = ""
        for byte in bytes {
            hexString += String(format: "%02x", UInt8(byte))
        }

        return hexString
    }
}

struct ImageManager {

    // On older versions this name was defined internally by Nuke,
    // now that we must define it, if we don't want the people to clear the entire image caching
    // when they update the app, we must set the same data cache name that it used to be when internally managed.
    static internal let dataCacheName = "com.TheCalendarApp.DataCache"

    static let loadingOptions: ImageLoadingOptions = {
        return createImageLoadingOptions()
    }()
    
    static func createImageLoadingOptions(placeHolder: PlatformImage? = nil,
                                          transition: ImageLoadingOptions.Transition? = nil) -> ImageLoadingOptions {
        var loadingOptions = ImageLoadingOptions.shared
        loadingOptions.pipeline = ImageManager.pipeline
        loadingOptions.placeholder = placeHolder
        loadingOptions.transition = transition
        return loadingOptions
    }

    static let dataCache: DataCache? = {
        return try? DataCache(name: dataCacheName, filenameGenerator: {
            return $0.sha256()
        })
    }()

    static let memoryCache: ImageCache = {
        return ImageCache()
    }()

    static let pipeline = ImagePipeline {
        $0.dataLoader = DataLoader(configuration: {
            // Disable disk caching built into URLSession
            let conf = DataLoader.defaultConfiguration
            conf.urlCache = nil
            return conf
        }())

        $0.imageCache = memoryCache
        $0.dataCache = dataCache
        $0.isTaskCoalescingEnabled = false
    }

    @discardableResult
    static func loadImage(with url: URL, options: ImageLoadingOptions = ImageManager.loadingOptions,
                          into view: ImageDisplayingView,
                          progress: ((_ response: ImageResponse?, _ completed: Int64, _ total: Int64) -> Void)? = nil,
                          completion: ((_ result: Swift.Result<ImageResponse, ImagePipeline.Error>) -> Void)? = nil) -> ImageTask? {
        var options = options
        options.pipeline = pipeline
        return Nuke.loadImage(with: url, options: options, into: view, progress: progress, completion: completion)
    }
}
