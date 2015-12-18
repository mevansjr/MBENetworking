# MBENetworking

*This module builds with Xcode 7 and supports iOS7 [1], iOS8, iOS9.*

Thin layer to take care of your http requests working with NSURLSession. Taking care of:

-JSON serializer
-Multipart upload
-HTTP Basic/Digest authentication support
-Pluggable object serialization
-background processing support

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
