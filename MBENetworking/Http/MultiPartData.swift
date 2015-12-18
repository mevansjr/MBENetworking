//  Created by Mark Evans on 12/18/15.
//  Copyright © 2015 3Advance, LLC. All rights reserved.
//

import Foundation

/**
Represents a multipart object containing a file plus metadata to be processed during upload.
*/
public class MultiPartData {

    /// The 'name' to be used on the request.
    public var name: String
    /// The 'filename' to be used on the request.
    public var filename: String
    /// The 'MIME type' to be used on the request.
    public var mimeType: String
    /// The actual data to be sent.
    public var data: NSData
    
    /**
    Initialize a multipart object using an NSURL and a corresponding MIME type. 
    
    :param: url the url of the local file.
    :param: mimeType the MIME type.
    
    :returns: the newly created multipart data.
    */
    public init(url: NSURL, mimeType: String) {
        self.name = url.lastPathComponent!
        self.filename = url.lastPathComponent!
        self.mimeType = mimeType;
        
        self.data = NSData(contentsOfURL: url)!
    }
    
    /**
    Initialize a multipart object using an NSData plus metadata.
    
    :param: data the actual data to be uploaded.
    :param: name the 'name' to be used on the request.
    :param: filename the 'filename' to be used on the request.
    :param: mimeType the 'MIME type' to be used on the request.
    
    :returns: the newly created multipart data.
    */
    public init(data: NSData, name: String, filename: String, mimeType: String) {
        self.data = data;
        self.name = name;
        self.filename = filename;
        self.mimeType = mimeType;
    }
}
