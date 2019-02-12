//
//  Permissions.swift
//  Permissions-iOS
//
//  Created by TOxIC on 08/02/2019.
//

import Foundation
import Contacts

protocol PmPermissionDelegate: class {
    /**
     - Usegae : '''func didCheckPermissionStatus(_ response: PmPermissionDevice)'''
     - Description : Triggered when permission status changed
     */
    func didCheckPermissionStatus(_ response: PermissionResponse)
    
    /**
     - Usegae : '''func didCheckPermissionStatus(_ response: PmPermissionDevice)'''
     - Description : Triggered when permission status changed
     */
    func didFailToGetPermissionStatus(_ response: PermissionResponse)
    
    
    
}

/**
 Check hardware devices permission granted to app.
 
 ```swift
 import Permissions
 ...
 
 
 ```
 */
struct PermissionResponse {
    var status : Bool
    var message : String
    var device  : PmPermissionDevice
    
    init(st : Bool, msg : String, device : PmPermissionDevice) {
        self.status = st
        self.message = msg
        self.device = device
    }
    
}
enum PmPermissionDevice {
    /// Check permission for Camera
    case camera
    /// Check permission for Microphone
    case microphone
    /// Check permission for Contacts
    case contacts
    /// Check permission for Location
    case location
    /// Check permission for Photos
    case photos
    /// Check permission for Filestorage
    case file
    /// Check permission for Healthkit
    case healthkit
}

class Permissions: NSObject {
    
    fileprivate var status : Bool?
    fileprivate var device : PmPermissionDevice?
    
    weak var delegate: PmPermissionDelegate?
    
    
    
    /**
     Check Permission for Delegate
     
     ```swift
     import Permissions
     ...
     ```
     
     ```swift
     YourViewController : UIViewController, PmPermissionDelegate {
     
     
     
     
     ...
     ```
     
     ```swift
     weak var delegate: PmPermissionDelegate?
     
     ...
     ```
     
     ```swift
     override func viewDidLoad() {
     let permissions: Permissions(device : .camera, shouldRequest : true)
     permissions.delegate = self
     ...
     ```
     
     
    
     
     - Parameter  **device**: Hardware device eg **.camera**
     - Parameter  **shouldRequest**: Should request for permission if not authorised/determined/granted eg  **true**
     
     */
    
    override init() {
        
    }
    
    convenience init(device : PmPermissionDevice, shouldRequest : Bool?) {
        self.init()
        self.status = false
        self.device = device
        
    }
    
    func checkPermission() {
        
        if self.device == .contacts {
            self.checkContactsPermission()
            
        }
        
    }
    
    
    fileprivate func checkContactsPermission () {
        self.status = false
        var message = "Unable to get permission"
        #if os(macOS)
        if #available(OSX 10.11, *) { // OSX Contacts Availability
            let store = CNContactStore()
            switch CNContactStore.authorizationStatus(for: .contacts) {
            case .authorized:
                self.status = true
                message = "Authorised"
                let resp = PermissionResponse(st: self.status!, msg: message, device : self.device!)
                self.delegate?.didCheckPermissionStatus(resp)
            case .denied:
                self.status = false
                message = "Permission Denied"
                let resp = PermissionResponse(st: self.status!, msg: message, device : self.device!)
                self.delegate!.didFailToGetPermissionStatus(resp)
            case .restricted, .notDetermined:
                message = "Permission Restricted or not determined"
                
                store.requestAccess(for: .contacts) { granted, error in
                    if granted {
                        message = "Permission Granted"
                        self.status = true
                        let resp = PermissionResponse(st: self.status!, msg: message, device : self.device!)
                        self.delegate?.didCheckPermissionStatus(resp)
                    } else {
                        self.status = false
                        message = "Permission not granted"
                        let resp = PermissionResponse(st: self.status!, msg: message, device : self.device!)
                        self.delegate?.didCheckPermissionStatus(resp)
                    }
                }
            default :
                message = "Unable to determine permission"
                self.status = false
                let resp = PermissionResponse(st: self.status!, msg: message, device : self.device!)
                self.delegate?.didCheckPermissionStatus(resp)
            }
            
        }
        
        #endif
        
        #if os(iOS)
            if #available(iOS 9.0, *) {
                let store = CNContactStore()
                switch CNContactStore.authorizationStatus(for: .contacts) {
                case .authorized:
                    self.status = true
                    message = "Authorised"
                    let resp = PermissionResponse(st: self.status!, msg: message, device : self.device!)
                    self.delegate?.didCheckPermissionStatus(resp)
                case .denied:
                    self.status = false
                    message = "Permission Denied"
                    let resp = PermissionResponse(st: self.status!, msg: message, device : self.device!)
                    self.delegate!.didFailToGetPermissionStatus(resp)
                case .restricted, .notDetermined:
                    message = "Permission Restricted or not determined"
                    
                    store.requestAccess(for: .contacts) { granted, error in
                        if granted {
                            message = "Permission Granted"
                            self.status = true
                            let resp = PermissionResponse(st: self.status!, msg: message, device : self.device!)
                            self.delegate?.didCheckPermissionStatus(resp)
                        } else {
                            self.status = false
                            message = "Permission not granted"
                            let resp = PermissionResponse(st: self.status!, msg: message, device : self.device!)
                            self.delegate?.didCheckPermissionStatus(resp)
                        }
                    }
                default :
                    message = "Unable to determine permission"
                    self.status = false
                    let resp = PermissionResponse(st: self.status!, msg: message, device : self.device!)
                    self.delegate?.didCheckPermissionStatus(resp)
                }
                
            }
        #endif
        
    }
    
    
}
