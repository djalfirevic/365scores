//
//  Constants.h
//  Scores365
//
//  Created by Djuro Alfirevic on 6/28/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

// Application
#define kDebugging 1

// URLs
static NSString *const GAMES_URL            = @"Data/Games/?lang=1&uc=6&tz=15&countries=1";
static NSString *const IMAGE_CACHE_URL      = @"http://imagescache.365scores.com/";

// Strings & numbers
static NSString *const EMPTY_STRING         = @"";
static NSString *const NEWLINE_STRING       = @"\n";
static NSString *const OK_STRING            = @"OK";
#define ZERO_VALUE                          0.0

// Macros
#define MAIN_URL                            [[[NSBundle mainBundle] infoDictionary] objectForKey:@"WebServiceURL"]