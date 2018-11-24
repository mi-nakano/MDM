//
//  PhotoSaver.swift
//  MDM
//
//  Created by mizunaka on 2018/11/24.
//  Copyright © 2018 chukichi. All rights reserved.
//

import Foundation
import UIKit

final class PhotoSaver: NSObject {
    
    func save(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(didFinishSavingImage(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc
    private func didFinishSavingImage(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        var title = "保存完了"
        var message = "カメラロールに保存しました"
        if error != nil {
            title = "エラー"
            message = "保存に失敗しました"
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        self.present(alertController, animated: true, completion: nil)
        
    }
}
