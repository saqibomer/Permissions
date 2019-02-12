# Permissions
Request and check permission to Camera, Location, Contacts, Microphone, Photos, Healthkit, File access easily. Supports all platforms.

## Installation
Installing using Cocoapods

```
pod 'Permissions'
```
Add Permissions to your ViewController

```Swift
Import Permissions

YourViewController : UIViewController, PmPermissionDelegate {
...

weak var delegate: PmPermissionDelegate?

 ```swift
     override func viewDidLoad() {
     let permissions: Permissions(device : .camera, shouldRequest : true)
     permissions.delegate = self
     ...
     ```
```

Add Delegates
 ```swift
    func didCheckPermissionStatus(_ response: PermissionResponse)
    func didFailToGetPermissionStatus(_ response: PermissionResponse)
```
