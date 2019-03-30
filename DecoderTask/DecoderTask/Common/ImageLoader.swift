//
//  ImageLoader.swift
//  DecoderTask
//
//  Created by Shubham bairagi on 17/02/19.
//  Copyright © 2019 SB. All rights reserved.
//

import UIKit

class ImageLoader: NSObject {
    
    class func path(name: String) -> String {
        let finalPath = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
        return finalPath + name
    }
    
    class func getImagen(url: String?, completion: @escaping(UIImage) -> Void) {
        
        guard let url = url, let name = url.components(separatedBy: "/").last else { return }

        guard let localImage = UIImage(contentsOfFile: self.path(name: name)) else {
            let qos = DispatchQoS(qosClass: .userInitiated, relativePriority: 0)
            DispatchQueue.global(qos: qos.qosClass).async(execute: {
                if let imagenData = try? Data(contentsOf: URL(string: url)!) {
                    DispatchQueue.main.async( execute: {
                        try? imagenData.write(to: URL(string: self.path(name: name))!)
                        let finalImage = UIImage(data: imagenData as Data)
                        completion(finalImage!)
                    })
                }
            })
            return
        }
        completion(localImage)
    }
}
