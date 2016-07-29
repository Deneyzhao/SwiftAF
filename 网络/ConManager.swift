//
//  ConManager.swift
//  test
//
//  Created by Deney on 15/6/16.
//  Copyright © 2016年 Brandsh. All rights reserved.
//

import UIKit

typealias sucessBlock = (responseObj:AnyObject) -> Void
typealias failedBlock = (error : NSError) -> Void
typealias downHandle = (totleByte:Int,currentByte:Int) -> Void
typealias downComplated = (url:NSURL)->Void


//NSURLConnectionDownloadDelegate
class Request: NSObject ,NSURLConnectionDelegate,NSURLConnectionDataDelegate{
    
        /// 单利
    static let defaultRequest = Request()
        /// url
    var baseUrl : NSURL?
        /// 请求体
    var httpBody : AnyObject?
        /// 请求方法
    var httpMethod : String?
        /// 数据
    var _data : NSMutableData?
        /// 请求成功闭包
    var sucess : sucessBlock?
        /// 请求失败闭包
    var failed : failedBlock?
        /// 下载数据操作
    var handle : downHandle?
        /// 下载完成
    var complated : downComplated?
    
    
    
    //MARK: begin request
    func startRequest() -> Void {
        let mutReuqest = NSMutableURLRequest(URL: baseUrl!)
        mutReuqest.timeoutInterval = 20.0
        mutReuqest.HTTPBody = httpBody as? NSData
        mutReuqest.HTTPMethod = httpMethod!
        let con =  NSURLConnection(request: mutReuqest,delegate: self)
//        NSURLSession
        con?.start()
    }
    
    //MARK: NSURLConnectionDelegate
    /**
     请求失败
     
     - parameter connection:
     - parameter error:
     */
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        failed!(error: error)
    }
    
    //MARK: NSURLConnectionDataDelegate
    /**
     接收到数据
     
     - parameter connection:
     - parameter data:
     */
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        _data!.appendData(data)
    }
    /**
     接收到请求
     
     - parameter connection:
     - parameter response:
     */
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
        _data = NSMutableData()
    }
    /**
     请求完成
     
     - parameter connection:
     */
    func connectionDidFinishLoading(connection: NSURLConnection) {
        let res : AnyObject!  = try? NSJSONSerialization.JSONObjectWithData(_data!, options: NSJSONReadingOptions.AllowFragments)
        sucess!(responseObj:res)
    }
    
//    func connection(connection: NSURLConnection, didSendBodyData bytesWritten: Int, totalBytesWritten: Int, totalBytesExpectedToWrite: Int) {
//        handle!(totleByte: totalBytesExpectedToWrite,currentByte:totalBytesWritten)
//    }

    
    
    
    
    //MARK: NSURLConnectionDownloadDelegate
    /**
     正在下载数据
     
     - parameter connection:
     - parameter bytesWritten:
     - parameter totalBytesWritten:
     - parameter expectedTotalBytes:
     */
//    func connection(connection: NSURLConnection, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, expectedTotalBytes: Int64) {
//        handle!(totleByte: totalBytesWritten,currentByte:bytesWritten)
//    }
//    /**
//     重新开始下载
//     
//     - parameter connection:
//     - parameter totalBytesWritten:
//     - parameter expectedTotalBytes:
//     */
//    func connectionDidResumeDownloading(connection: NSURLConnection, totalBytesWritten: Int64, expectedTotalBytes: Int64) {
////        handle!(totleByte: totalBytesWritten,currentByte:bytesWritten)
//    }
//    
//    /**
//     下载完成
//     
//     - parameter connection:
//     - parameter destinationURL:
//     */
//    func connectionDidFinishDownloading(connection: NSURLConnection, destinationURL: NSURL) {
//        complated!(url:destinationURL)
//    }
    
}



class ConManager: NSObject {

        /// 单利
    static let sharedInstance = ConManager()
    //MARK: get 请求
    func getDataFromServer(url url:String,partmers:AnyObject ,sucess:(responseObj:AnyObject) -> Void ,failed :(error : NSError) -> Void ) -> Void {
        let request = Request.defaultRequest
        request.baseUrl = NSURL.init(string: url)!
        request.httpBody = partmers
        request.httpMethod = "GET"
        request.startRequest()
        
        request.sucess = sucess
        request.failed = failed
    }
    
    //MARK: post 请求
    func postDataFromServer(url url:String,partmers:AnyObject ,sucess:(responseObj:AnyObject) -> Void ,failed :(error : NSError) -> Void) -> Void {
        let request = Request.defaultRequest
        request.baseUrl = NSURL.init(string: url)!
        request.httpBody = partmers
        request.httpMethod = "POST"
        request.startRequest()
        
        request.sucess = sucess
        request.failed = failed
    }
    
//    //MARK: 下载
//    func downLoadDataFromServer(url url:String,handle:(totleByte:Int,currentByte:Int) -> Void,complated:(destinationURL:NSURL)->Void) -> Void {
//        let request = Request.defaultRequest
//        request.baseUrl = NSURL.init(string: url)!
//        request.httpMethod = "POST"
//        request.startRequest()
//        request.handle = handle
//        request.complated = complated
//    }
    
    
    
}
