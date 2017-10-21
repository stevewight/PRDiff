//
//  UIExtensions.swift
//  PRDiff
//
//  Created by Steve on 10/20/17.
//  Copyright © 2017 Steve Wight. All rights reserved.
//

import UIKit

extension UIImageView {

    func loadURL(_ url:URL, complete:@escaping()->Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data,
                let image = UIImage(data:data)
                else { return }
            DispatchQueue.main.async {
                self.image = image
                complete()
            }
        }.resume()
    }
    
    func makeCircle() {
        layer.masksToBounds = true
        layer.cornerRadius = min(
            frame.width/2,
            frame.height/2
        )
        clipsToBounds = true
    }
    
}
