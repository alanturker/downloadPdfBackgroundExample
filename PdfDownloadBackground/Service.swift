//
//  Service.swift
//  PdfDownloadBackground
//
//  Created by Türker Alan on 1.02.2023.
//

import Foundation
import Alamofire

class Service {
    static let shared = Service()
    
//    let configuration = URLSessionConfiguration.background(withIdentifier: "com.example.app.background")
//    let manager = AF.Ma
    
    func downloadPdf(delegate: URLSessionDelegate) {
        let configuration = URLSessionConfiguration.background(withIdentifier: "Model\(UUID().uuidString).pdf")
        configuration.isDiscretionary = false
        configuration.sessionSendsLaunchEvents = true
        let session = URLSession(configuration: configuration, delegate: delegate, delegateQueue: nil)
        var backgroundTask = session.downloadTask(with: URL(string: "https://www.tutorialspoint.com/swift/swift_tutorial.pdf")!)
        
//    https://www.tutorialspoint.com/swift/swift_tutorial.pdf
 //   https://decapoda.nhm.org/pdfs/26408/26408.pdf
//        backgroundTask.setValue("Tutorial.pdf", forUndefinedKey: "fileName")
        backgroundTask.resume()
    }
}

//let destination: DownloadRequest.Destination = { _, _ in
//
//    let documentUrls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//
//    let fileUrl = documentUrls.appendingPathComponent("RandomFile\(Int.random(in: 1..<10000)).pdf")
//    return (fileUrl, [.removePreviousFile, .createIntermediateDirectories])
//}
//
////        let requestModifier: Session.RequestModifier.Type
////        requestModifier.
//
//AF.download(URL(string: "https://decapoda.nhm.org/pdfs/26408/26408.pdf")!, method: .get, requestModifier: { request in
//    request.timeoutInterval = 120
//
//}, to: destination).downloadProgress { (progress) in
//    print(progress.fractionCompleted)
//}.validate()
//    .response { response in
//        if response.error == nil {
//            debugPrint(response)
//            print("noError")
//        } else {
//            print("error")
//        }
//    }
