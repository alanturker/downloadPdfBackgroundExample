//
//  ViewController.swift
//  PdfDownloadBackground
//
//  Created by Türker Alan on 1.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        button.backgroundColor = .green
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        view.addSubview(button)
        button.center = view.center
        button.setTitle("download", for: .normal)
        button.addTarget(self, action: #selector(didTapDownloadButton), for: .touchUpInside)
    }

    @objc func didTapDownloadButton() {
        print("didTapDownload")
        Service.shared.downloadPdf(delegate: self)
    }
}

extension ViewController: URLSessionDelegate, URLSessionDownloadDelegate {
    //    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge) async -> (URLSession.AuthChallengeDisposition, URLCredential?) {
    //    }
    
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        DispatchQueue.main.async {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
                  let backgroundCompletionHandler =
                    appDelegate.backgroundCompletionHandler else {
                return
            }
            backgroundCompletionHandler()
        }
    }
        
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("finished downloading Location: \(location)")
        print("session: \(session)")
        do {    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            let documentDirectory = URL(fileURLWithPath: path)
            let destinationPath = documentDirectory.appendingPathComponent(session.configuration.identifier ?? "")
            try FileManager.default.moveItem(at: location, to: destinationPath)
            print(destinationPath)
        }
        catch {
            print(error)
            
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        print(Double(totalBytesWritten)/Double(totalBytesExpectedToWrite))
    }
}
