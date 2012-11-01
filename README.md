VIPC
====

Make IPC between apps through NSURL 


====

// Invoker

NSURLRequest* req = [NSURLRequest requestWithURL:[NSURL URLWithString:TEST_URL]];
NSDictionary* args = [VIPC IPCRequestForURLRequest:req];

[VIPC invoke:@"vbrowserapollos" withArg:args];


// Receiver

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {

    if( [VIPC canHandleURL:url] ) {
    	NSDictionary* args = [VIPC unpackURL:url];
        NSURLRequest* request = [args objectForKey:VIPC_KEY_URLREQUEST];
		if( request ) {
        	NSURL* pageURL = request.URL;
            DLog(@"VIPC Received:\n%@", args);
            NSArray* cookies = [args objectForKey:VIPC_KEY_COOKIES];
            if( cookies.count ) {
            	// update the cookie
                [VIPC setCookies:cookies forURL:pageURL];
            }
            // **** do something ****
        }
        return YES;
    }
    
    return NO;
}

    
    
