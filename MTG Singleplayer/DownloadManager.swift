//
//  Card.swift
//  MTG Singleplayer
//
//  Created by Loic D on 31/07/2022.
//

import Foundation
import SwiftUI

class DownloadManager: NSObject {
    
    @objc static let shared = DownloadManager()
    @Published var data = Data()
    @Published var imageReadyToShow = false
    
    func startDownloading(card: Card) {
        if card.cardImageURL != "" {
            //print(card.cardName + " -> " + card.cardImageURL + " -> " + card.cardOracleId + card.specificSet)
            let url = URL(string: card.cardImageURL)!

            self.loadData(cardName: card.cardId + card.specificSet, url: url) { (data, error) in
                // Handle the loaded file data
                if error == nil {
                    DispatchQueue.main.async {
                        if data != nil {
                            self.data = data! as Data
                            card.cardUIImage = Image(uiImage: (UIImage(data: self.data)) ?? UIImage(named: "MTGBackground")!)
                            print("Finished downloding image for \(card.cardName)")
                        }
                    }
                }
            }
        }
    }
    
    private func download(url: URL, toFile file: URL, completion: @escaping (Error?) -> Void) {
        // Download the remote URL to a file
        let task = URLSession.shared.downloadTask(with: url) {
            (tempURL, response, error) in
            // Early exit on error
            guard let tempURL = tempURL else {
                completion(error)
                return
            }

            do {
                // Remove any existing document at file
                if FileManager.default.fileExists(atPath: file.path) {
                    try FileManager.default.removeItem(at: file)
                }

                // Copy the tempURL to file
                try FileManager.default.copyItem(
                    at: tempURL,
                    to: file
                )

                //try FileManager.default.moveItem(at: tempURL, to: file)
                
                completion(nil)
            }

            // Handle potential file system errors
            catch _ {
                completion(error)
            }
        }

        // Start the download
        task.resume()
    }
    
    private func loadData(cardName: String, url: URL, completion: @escaping (Data?, Error?) -> Void) {
        // Compute a path to the URL in the cache
        /*
        let fileCachePath = FileManager.default.temporaryDirectory
            .appendingPathComponent(
                cardName,
                isDirectory: false
            )
         */
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileCachePath = documents.appendingPathComponent(cardName, isDirectory: false)
        // If the image exists in the cache,
        // load the image from the cache and exit
        if let data = try? Data(contentsOf: fileCachePath) {
            completion(data, nil)
            return
        }
        
        // If the image does not exist in the cache,
        // download the image to the cache
        download(url: url, toFile: fileCachePath) { (error) in
            let data = try? Data(contentsOf: fileCachePath)
            completion(data, error)
        }
    }
    
    static func removeAllSavedImages() {
        let fileManager = FileManager.default
        do {
            let documentDirectoryURL = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileURLs = try fileManager.contentsOfDirectory(at: documentDirectoryURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            for url in fileURLs {
               try fileManager.removeItem(at: url)
            }
        } catch {
            print(error)
        }
    }
}

class DownloadQueue: NSObject {
    
    @objc static let queue = DownloadQueue()
    private override init(){
        self.timeToStartDownload = Date()
    }
    private var timeToStartDownload: Date
    private var delayBetweenDownloads: CGFloat = 0.5
    
    func getDelayBeforeDownload(card: Card) -> TimeInterval {
        if imageAlreadyDownloaded(card: card) { return 0 }
        let timeInterval = timeToStartDownload.timeIntervalSinceNow
        
        // Last download is old -> the queue is empty -> start downloading now
        if timeInterval < 0 {
            timeToStartDownload = Date() + delayBetweenDownloads
            return 0
        }
        
        // If the queue is not empty
        timeToStartDownload += delayBetweenDownloads
        return timeInterval
    }
    
    private func imageAlreadyDownloaded(card: Card) -> Bool {
        // If the image exists in the cache,
        // load the image from the cache and exit
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let cardFileCachePath = documents.appendingPathComponent(card.cardId + card.specificSet, isDirectory: false)
        //if (try? Data(contentsOf: cardFileCachePath)) != nil {
        if FileManager.default.fileExists(atPath: cardFileCachePath.path) {
            return true
        }
        return false
    }
    
    func resetQueue() {
        self.timeToStartDownload = Date()
    }
}
