//
//  CETweet.h
//  ios-demo
//
//  Created by Bal on 5/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface CETweet : NSObject  {
    NSDate *_created;
    NSString *_user;
    NSString *_user_id;
    NSString *_user_name;
    CLLocation *_location;
    NSString *_tweet_source;
    NSString *_tweet_id;
    NSString *_tweet_text;
    NSString *_profile_image_url;
}

@property (nonatomic, readonly) NSDate *created;
@property (nonatomic, readonly) NSString *user;
@property (nonatomic, readonly) NSString *user_id;
@property (nonatomic, readonly) NSString *user_name;
@property (nonatomic, readonly) CLLocation *location;
@property (nonatomic, readonly) NSString *tweet_source;
@property (nonatomic, readonly) NSString *tweet_id;
@property (nonatomic, readonly) NSString *tweet_text;
@property (nonatomic, readonly) NSString *profile_image_url;


- (id) initWithDictionary:(NSDictionary *) dictionary;

@end
