//
//  ImageFileManager.swift
//  Travel-Planner
//
//  Created by siye yang on 12/03/2024.
//

import Foundation
import UIKit

class ImageFileManager {
    static let instance = ImageFileManager()
    private let folderName = "Activity_Images"
    private let cache = NSCache<NSString, UIImage>()

    private init() {
        createFolderIfNeeded()
    }

    private func createFolderIfNeeded() {
        guard let url = getFolderURL() else { return }
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
                print("Folder created at \(url.path)")
            } catch {
                print("Error creating folder: \(error)")
            }
        }
    }

    private func getFolderURL() -> URL? {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(folderName)
    }

    private func getImageURL(name: String) -> URL? {
        getFolderURL()?.appendingPathComponent(name + ".jpg")
    }

    func saveImage(image: UIImage, name: String) -> Bool {
        guard let data = image.jpegData(compressionQuality: 1.0),
              let url = getImageURL(name: name) else { return false }
        do {
            try data.write(to: url)
            return true
        } catch {
            print("Error saving image: \(error)")
            return false
        }
    }

    func getImage(name: String) -> UIImage? {
        if let cachedImage = cache.object(forKey: name as NSString) {
            return cachedImage
        }
        guard let url = getImageURL(name: name),
              FileManager.default.fileExists(atPath: url.path),
              let image = UIImage(contentsOfFile: url.path) else { return nil }
        cache.setObject(image, forKey: name as NSString)
        return image
    }

    func deleteImage(name: String) {
        cache.removeObject(forKey: name as NSString)
        guard let url = getImageURL(name: name),
              FileManager.default.fileExists(atPath: url.path) else { return }
        do {
            try FileManager.default.removeItem(at: url)
        } catch {
            print("Error deleting image: \(error)")
        }
    }
}
