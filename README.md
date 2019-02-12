[![MIT Licence](https://badges.frapsoft.com/os/mit/mit.svg?v=103)](https://opensource.org/licenses/mit-license.php)
[![Generic badge](https://img.shields.io/badge/<Version>-<0.0.1>-<COLOR>.svg)](https://shields.io/)
[![Generic badge](https://img.shields.io/badge/<macOS>-<10.11>-<COLOR>.svg)](https://shields.io/)
[![Generic badge](https://img.shields.io/badge/<iOS>-<9.0>-<COLOR>.svg)](https://shields.io/)
[![Generic badge](https://img.shields.io/badge/<watchOS>-<4.0>-<COLOR>.svg)](https://shields.io/)
[![Generic badge](https://img.shields.io/badge/<tvOS>-<2.0>-<COLOR>.svg)](https://shields.io/)


# Permissions
Request and check permission to Camera, Location, Contacts, Microphone, Photos, Healthkit, File access easily. Supports all platforms.

## Platform

## Installation
Installing using Cocoapods

```
pod 'Permissions'
```
Add Permissions to your ViewController

```Swift
import Permissions

YourViewController : UIViewController, PmPermissionDelegate {
...

weak var delegate: PmPermissionDelegate?

     override func viewDidLoad() {
     let permissions: Permissions(device : .camera, shouldRequest : true)
     permissions.delegate = self
     ...
     
```

Add Delegates
 ```swift
    func didCheckPermissionStatus(_ response: PermissionResponse)
    func didFailToGetPermissionStatus(_ response: PermissionResponse)
```

## TO DO
- [x] Contacts Permission
- [ ]  Location Permission
- [ ]  Camera Permission
- [ ]  Micophone Permission
- [ ]  Photos Permission
- [ ]  Healthkit Permission
- [ ]  Update Readme
