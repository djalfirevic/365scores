//
//  WebServiceManager.h
//  Scores365
//
//  Created by Djuro Alfirevic on 6/28/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^WebServiceCompletionHandler)(BOOL success, NSDictionary *dictionary, NSError *error);

@interface WebServiceManager : NSObject
+ (id)sharedInstance;
- (void)requestDataFromURL:(NSString *)urlString
                withLoader:(BOOL)loaderOn
            withCompletion:(WebServiceCompletionHandler)handler;
@end