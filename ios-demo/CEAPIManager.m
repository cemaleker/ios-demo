//
//  CEAPIManager.m
//  ios-demo
//
//  Created by Bal on 5/21/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CEAPIManager.h"

static NSString * const kBaseAPIURL = @"http://search.twitter.com";
static NSString * const kAPISearchPath = @"/search.json";


@implementation CEAPIManager

+ (void)searchTweetsWithOptions:(NSDictionary *)options 
                 withIdentifier:(NSString *)identifier
             completionBlock:(void (^)(id, NSError *))completionBlock { 

    HPRequestManager *requestManager = [HPRequestManager sharedManager];
    NSString *requestPath = [requestManager pathFromBasePath:kAPISearchPath 
                                                 withOptions:options];
    
    [requestManager cancelOperationsWithIdentifier:identifier];
    
    NSLog(@"Loading with options: %@", requestPath);
    HPRequestOperation *requestOperation = [requestManager requestForPath:requestPath 
                                                              withBaseURL:kBaseAPIURL 
                                                                 withData:nil 
                                                                   method:HPRequestMethodGet 
                                                                   cached:NO];
    
    [requestOperation setIdentifier:identifier];
    [requestOperation addCompletionBlock:completionBlock];
    [requestManager enqueueRequest:requestOperation];
}

+ (void)searchTweetsWithQuery:(NSString *)query 
               withIdentifier:(NSString *)identifier
              completionBlock:(void (^)(id, NSError *))completionBlock {
    
    HPRequestManager *requestManager = [HPRequestManager sharedManager];
    NSString *requestPath = [NSString stringWithFormat:@"%@%@", kAPISearchPath, query];
    
    [requestManager cancelOperationsWithIdentifier:identifier];
    
    NSLog(@"Loading with query: %@", requestPath);
    HPRequestOperation *requestOperation = [requestManager requestForPath:requestPath 
                                                              withBaseURL:kBaseAPIURL
                                                                 withData:nil
                                                                   method:HPRequestMethodGet
                                                                   cached:NO];
    
    [requestOperation setIdentifier:identifier];
    [requestOperation addCompletionBlock:completionBlock];
    [requestManager enqueueRequest:requestOperation];
}

@end
