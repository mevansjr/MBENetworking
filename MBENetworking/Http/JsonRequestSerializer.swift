//  Created by Mark Evans on 12/18/15.
//  Copyright © 2015 3Advance, LLC. All rights reserved.
//

import Foundation

/**
A request serializer to JSON objects/
*/
public class JsonRequestSerializer:  HttpRequestSerializer {
    /**
    Build an request using the specified params passed in.
    
    :param: url the url of the resource.
    :param: method the method to be used.
    :param: parameters the request parameters.
    :param: headers any headers to be used on this request.
    
    :returns: the URLRequest object.
    */
    public override func request(url: NSURL, method: HttpMethod, parameters: [String: AnyObject]?, var headers: [String: String]? = nil) -> NSURLRequest {
        if method == HttpMethod.GET || method == HttpMethod.HEAD || method == HttpMethod.DELETE {
            if let accessToken = NSUserDefaults.standardUserDefaults().valueForKey(Global.API_ACCESS_TOKEN) as? String {
                if headers != nil {
                    headers!["Authorization"] = accessToken
                }
                else {
                    headers = ["Authorization": accessToken]
                }
            }
            return super.request(url, method: method, parameters: parameters, headers: headers)
        } else {
            let request = NSMutableURLRequest(URL: url, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
            request.HTTPMethod = method.rawValue
            
            var skip = false
            
            // set body
            if (parameters != nil) {
                
                if method == HttpMethod.LOGIN {
                    skip = true
                    request.HTTPMethod = HttpMethod.POST.rawValue
                    
                    if let p = parameters! as Dictionary<String,AnyObject>! {
                        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                        
                        let queryString = p.urlEncodedQueryStringWithEncoding()
                        request.HTTPBody = queryString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
                        
                    }
                }
                else {
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    
                    var body: NSData?
                    do {
                        body = try NSJSONSerialization.dataWithJSONObject(parameters!, options: [])
                    } catch _ {
                        body = nil
                    }
                    // set body
                    if (body != nil) {
                        request.setValue("\(body?.length)", forHTTPHeaderField: "Content-Length")
                        request.HTTPBody = body
                    }

                }
            }
            else {
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            // apply headers to new request
            if !skip {
                if let accessToken = NSUserDefaults.standardUserDefaults().valueForKey(Global.API_ACCESS_TOKEN) as? String {
                    if headers != nil {
                        headers!["Authorization"] = accessToken
                    }
                    else {
                        headers = ["Authorization": accessToken]
                    }
                }
            }
            
            if(headers != nil) {
                for (key,val) in headers! {
                    request.addValue(val, forHTTPHeaderField: key)
                }
            }

            return request
        }
    }
}
