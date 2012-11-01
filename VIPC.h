//
//  VIPC.h
//  TestIPC
//
//  Created by Shen Slavik on 11/1/12.
//  Copyright (c) 2012 Voyager Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

#define VIPC_KEY_URLREQUEST @"URLRequest"
#define VIPC_KEY_COOKIES @"Cookies"


@interface VIPC : NSObject

+ (BOOL)canHandleURL:(NSURL*)url;

+ (NSDictionary*)unpackURL:(NSURL*)url;

+ (NSArray*)cookiesForURL:(NSURL*)url;
+ (void)setCookies:(NSArray*)cookies forURL:(NSURL*)url;

+ (void)invoke:(NSString*)scheme withArgs:(NSDictionary*)args;

+ (NSDictionary*)IPCRequestForURLRequest:(NSURLRequest*)request;


@end
