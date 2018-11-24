//
//  ViewController.swift
//  MDM
//
//  Created by mizunaka on 2018/11/24.
//  Copyright © 2018 chukichi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var bezierPath: UIBezierPath!
    @IBOutlet var canvas: UIImageView!
    var lastDrawImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchEvent = touches.first!
        let currentPoint: CGPoint = touchEvent.location(in: self.canvas)
        bezierPath = UIBezierPath()
        bezierPath.lineWidth = 4.0
        bezierPath.lineCapStyle = .butt
        bezierPath.move(to:currentPoint)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if bezierPath == nil {
            return
        }
        let touchEvent = touches.first!
        let currentPoint:CGPoint = touchEvent.location(in: self.canvas)
        bezierPath.addLine(to: currentPoint)
        drawLine(path: bezierPath)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if bezierPath == nil {
            return
        }
        let touchEvent = touches.first!
        let currentPoint: CGPoint = touchEvent.location(in: canvas)
        bezierPath.addLine(to: currentPoint)
        drawLine(path: bezierPath)
        self.lastDrawImage = canvas.image
    }

    private func drawLine(path:UIBezierPath) {
        UIGraphicsBeginImageContext(canvas.frame.size)
        if let image = self.lastDrawImage {
            image.draw(at: CGPoint.zero)
        }
        let lineColor = UIColor.black
        lineColor.setStroke()
        path.stroke()
        self.canvas.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    @IBAction func saveAction(_ sender: Any) {
        print("save")
        // @TODO filename from note title
        UIImageWriteToSavedPhotosAlbum(self.lastDrawImage!, self, #selector(didFinishSavingImage(_:didFinishSavingWithError:contextInfo:)), nil)
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
        self.present(alertController, animated: true, completion: nil)
        
    }
}
