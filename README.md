# MBENetworking

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
