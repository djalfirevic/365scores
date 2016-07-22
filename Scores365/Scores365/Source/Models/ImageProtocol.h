//
//  ImageProtocol.h
//  Scores365
//
//  Created by Djuro Alfirevic on 7/22/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#ifndef ImageProtocol_h
#define ImageProtocol_h

@protocol ImageProtocol <NSObject>
@required
- (NSString *)imageURL;
@end

#endif /* ImageProtocol_h */