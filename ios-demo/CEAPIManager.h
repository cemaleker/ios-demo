//
//  CEAPIManager.h
//  ios-demo
//
//  Created by Bal on 5/21/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HPUtils/HPUtils.h>


@interface CEAPIManager : NSObject {
    
}

+ (void)searchTweetsWithOptions:(NSDictionary *)options 
                 withIdentifier:(NSString *)identifier
                completionBlock:(void (^)(id, NSError *))completionBlock;

+ (void)searchTweetsWithQuery:(NSString *)query 
               withIdentifier:(NSString *)identifier
                completionBlock:(void (^)(id, NSError *))completionBlock;

@end
