//
//  VIPC.m
//  TestIPC
//
//  Created by Shen Slavik on 11/1/12.
//  Copyright (c) 2012 Voyager Apps. All rights reserved.
//

#import "VIPC.h"
#import "NSData+Base64.h"
#import "NSData+Hex.h"
#define VIPC_DOMAIN @"vipc"

@implementation VIPC

+ (BOOL)canHandleURL:(NSURL*)url {

	NSString* domain = [url host];
    if( [domain isEqualToString:VIPC_DOMAIN] ) {
    	return YES;
    }
    
    return NO;
}

+ (NSDictionary*)unpackURL:(NSURL*)url {

	NSString* query = [url query];
	NSString* base64 = [query stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSData* data = [NSData dataFromBase64String:base64];
    NSDictionary* args = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    return args;
}

+ (NSArray*)cookiesForURL:(NSURL*)url {
	NSHTTPCookieStorage* storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray* array = [storage cookiesForURL:url];
    return array;
}

+ (void)setCookies:(NSArray*)cookies forURL:(NSURL*)url {

	NSHTTPCookieStorage* storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
	[storage setCookies:cookies forURL:url mainDocumentURL:nil];
    
}

+ (void)invoke:(NSString*)scheme withArgs:(NSDictionary*)args {


    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:args];
	NSString* base64 = [data base64EncodedString];
    NSString* encoded = [base64 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString* urlStr = [NSString stringWithFormat:@"%@://%@/?%@", scheme, VIPC_DOMAIN, encoded];
    
    NSURL* url = [NSURL URLWithString:urlStr];
    
    [[UIApplication sharedApplication] openURL:url];

}

+ (NSDictionary*)IPCRequestForURLRequest:(NSURLRequest*)request {

	NSURL* url = request.URL;
    NSArray* cookies = [self cookiesForURL:url];
    
    NSDictionary* pkg = @{
    	VIPC_KEY_URLREQUEST:  request,
		VIPC_KEY_COOKIES : cookies
	};
    
    return pkg;
}

@end
