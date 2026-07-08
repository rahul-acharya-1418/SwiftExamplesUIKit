//
//  FairPlayDemoController.swift
//  SwiftExamplesUIKit
//
//  Created by Rahul Acharya on 24/06/26.
//  Copyright © 2026 Swift Examples. All rights reserved.
//

import Foundation
import AVKit
// https://gist.github.com/ankit0812/cb1f60e5d69a5f730b61515509af9a48
class FairPlayDemoController: UIViewController, AVAssetResourceLoaderDelegate {
    
    let ACCESS_TOKEN: String = "DRM-key"
    let RESOURCE_URL: String = "m3u8-url"
    let CUSTOM_SERIAL_QUEUE_LABEL: String = "FairPlayLicenseQueue"
    let CERTIFICATE_URL: String = "CERTIFICATE_URL"
    let CKC_URL: String = "https://fairplay.keyos.com/api/v4/getLicense"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func playVideo(_ sender: UIButton) {
        let url = URL(string: RESOURCE_URL)!
        
        let asset = AVURLAsset(url: url)
        let queue = DispatchQueue(label: CUSTOM_SERIAL_QUEUE_LABEL)
        asset.resourceLoader.setDelegate(self, queue: queue)
        
        // Create the player item and the player to play it back in.
        let playerItem = AVPlayerItem(asset: asset)
        let player = AVPlayer(playerItem: playerItem)
        
        // Create a new AVPlayerViewController and pass it a reference to the player.
        let controller = AVPlayerViewController()
        controller.player = player
        
        // Modally present the player and call the player's play() method when complete.
        present(controller, animated: true) {
            player.play()
        }
    }
    
    func resourceLoader(_ resourceLoader: AVAssetResourceLoader, shouldWaitForLoadingOfRequestedResource loadingRequest: AVAssetResourceLoadingRequest) -> Bool {
        
        guard let url = loadingRequest.request.url else {
            print(#function, "Unable to read URL from loadingRequest")
            loadingRequest.finishLoading(with: NSError(domain: "", code: -1, userInfo: nil))
            return false
        }
        
        guard let certificateData = try? Data(contentsOf: URL(string: CERTIFICATE_URL)!) else {
            print(#function, "Unable to read the certificate data.")
            loadingRequest.finishLoading(with: NSError(domain: "", code: -2, userInfo: nil))
            return false
        }
        
        guard let contentId = url.host, let contentIdData = contentId.data(using: String.Encoding.utf8) else {
            loadingRequest.finishLoading(with: NSError(domain: "", code: -3, userInfo: nil))
            print(#function, "Unable to read the SPC data.")
            return false
        }
        
        guard let spcData = try? loadingRequest.streamingContentKeyRequestData(forApp: certificateData, contentIdentifier: contentIdData, options: nil) else {
            loadingRequest.finishLoading(with: NSError(domain: "", code: -3, userInfo: nil))
            print(#function, "Unable to read the SPC data.")
            return false
        }
        
        let requestUrl = CKC_URL
        let stringBody = "spc=\(spcData.base64EncodedString())&assetId=\(contentId)"
        let postData = NSData(data: stringBody.data(using: String.Encoding.utf8)!)
        
        var request = URLRequest(url: URL(string: requestUrl)!)
        request.httpMethod = "POST"
        request.httpBody = postData as Data
        request.allHTTPHeaderFields = ["customdata" : ACCESS_TOKEN]
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        let task = session.dataTask(with: request) { data, response, error in
            if let data = data {
                
                do {
                    let parsedData = try JSONSerialization.jsonObject(with: data) as! [String:Any]
                    let errorId = parsedData["errorid"] as! String
                    let errorMsg = parsedData["errormsg"] as! String
                    print(#function, "License request failed with an error: \(errorMsg) [\(errorId)]")
                } catch let error as NSError {
                    print(#function, "The response may be a license. Moving on.", error)
                }
                
                // The response from the KeyOS MultiKey License server is Base64 encoded.
                let dataRequest = loadingRequest.dataRequest!
                
                // This command sends the CKC to the player.
                dataRequest.respond(with: Data(base64Encoded: data)!)
                loadingRequest.finishLoading()
            } else {
                print(#function, error?.localizedDescription ?? "Error during CKC request.")
            }
        }
        
        task.resume()
        
        return true
    }
}
