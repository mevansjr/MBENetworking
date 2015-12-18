# MBENetworking

*This module builds with Xcode 7 and supports iOS7 [1], iOS8, iOS9.*

Thin layer to take care of your http requests working with NSURLSession. Taking care of:

* JSON serializer
* Multipart upload
* HTTP Basic/Digest authentication support
* Pluggable object serialization
* background processing support

100% Swift 2.0.

## Example Usage

To perform an HTTP request use the convenient methods found in the Http object. Here is an example usage:

```
let http = Http(baseURL: "http://server.com")

http.GET("/get", completionHandler: {(response, error) in
     // handle response
})

http.POST("/post",  parameters: ["key": "value"], 
                    completionHandler: {(response, error) in
     // handle response
})
...
```

### Authentication

The library also leverages the build-in foundation support for http/digest authentication and exposes a convenient interface by allowing the credential object to be passed on the request. Here is an example:

```
let credential = NSURLCredential(user: "john", 
                                 password: "pass", 
                                 persistence: .None)

http.GET("/protected/endpoint", credential: credential, 
                                completionHandler: {(response, error) in
   // handle response
})
```

You can also set a credential per protection space, so it's automatically picked up once http challenge is requested by the server, thus omitting the need to pass the credential on each request. In this case, you must initialize the Http object with a custom session configuration object, that has its credentials storage initialized with your credentials:

```
// create a protection space
var protectionSpace = NSURLProtectionSpace(host: "httpbin.org", 
                                    port: 443,
                                    protocol: NSURLProtectionSpaceHTTPS, 
                                    realm: "me@kennethreitz.com", 
                                    authenticationMethod: NSURLAuthenticationMethodHTTPDigest)

// setup credential
// notice that we use '.ForSession' type otherwise credential storage will discard and
// won't save it when doing 'credentialStorage.setDefaultCredential' later on
let credential = NSURLCredential(user: user, 
                                 password: password, 
                                 persistence: .ForSession)

// assign it to credential storage
var credentialStorage = NSURLCredentialStorage.sharedCredentialStorage()
credentialStorage.setDefaultCredential(credential, forProtectionSpace: protectionSpace);

// set up default configuration and assign credential storage
var configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
configuration.URLCredentialStorage = credentialStorage

// assign custom configuration to Http
var http = Http(baseURL: "http://httpbin.org", sessionConfig: configuration)

http.GET("/protected/endpoint", completionHandler: {(response, error) in
   // handle response
})
```

### Model: Mapper Example Usage

Create new file, example OAuth.swift.

```
public class OAuth: Mappable {
    
    var access_token: String?
    var refresh_token: String?
    var expires_in: Int?
    var username: String?
    var password: String?
    var grant_type: String?
    var client_id: String?
    var client_secret: String?
    var issued: String?
    var expires: String?
    
    public required init?(_ map: Map) {
        mapping(map)
    }
    public required init(){}
    
    public func mapping(map: Map) {
        access_token <- map["access_token"]
        refresh_token <- map["refresh_token"]
        expires_in <- map["expires_in"]
        username <- map["username"]
        password <- map["password"]
        grant_type <- map["grant_type"]
        client_id <- map["client_id"]
        client_secret <- map["client_secret"]
        issued <- map[".issued"]
        expires <- map[".expires"]
    }
}
```

How to map model from HTTP -> Boom!

```
func getOAuth(completion: (success: OAuth?) -> ()) {
        self.http.GET(version.stringByAppendingString("/oauth")) { (success, error) -> Void in
            var oauth: OAuth?
            if success != nil {
                if let response = success! as? NSDictionary {
                    oauth = Mapper().map(response)
                }
            }
            completion(success: oauth)
        }
    }
```

Using the mapped model -> Super Boom!

```
ClientService.sharedInstance.getOauth { (success) -> () in
            if success != nil {
                print(Mapper().toJSONString(success!, prettyPrint: true)!) // will log oauth
                print(success!.access_token) // will log access token
            }
        }
```
