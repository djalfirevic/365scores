//
//  WebServiceManager.m
//  Scores365
//
//  Created by Djuro Alfirevic on 6/28/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "WebServiceManager.h"
#import "Reachability.h"

@implementation WebServiceManager

#pragma mark - Singleton

+ (WebServiceManager *)sharedInstance {
    static WebServiceManager *sharedManager;
    
    @synchronized(self)	{
        if (sharedManager == nil) {
            sharedManager = [[WebServiceManager alloc] init];
        }
    }
	
	return sharedManager;
}

#pragma mark - Public API

- (void)requestDataFromURL:(NSString *)urlString
                withLoader:(BOOL)loaderOn
            withCompletion:(WebServiceCompletionHandler)handler {
    if ([self hasInternetConnection]) {
        if (loaderOn) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        }
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
        
        [[session dataTaskWithRequest:request
                   completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
        {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            if (!error) {
                if ([request.URL isEqual:[NSURL URLWithString:urlString]]) {
                    /*// Header
                    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                    if ([response respondsToSelector:@selector(allHeaderFields)]) {
                        NSDictionary *dictionary = [httpResponse allHeaderFields];
                        NSLog(@"%@", [dictionary description]);
                    }*/
                    
                    if (data) {
                        NSError *serializationError;
                        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&serializationError];
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            handler(YES, dictionary, nil);
                        });
                    }
                }
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    handler(NO, nil, error);
                });
            }
        }] resume];
    }
}

@end