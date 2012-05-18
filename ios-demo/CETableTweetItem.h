//
//  CETableTweetItem.h
//  ios-demo
//
//  Created by Bal on 5/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CETableTweetItem : TTTableItem {
    NSString *_user;
    NSString *_userName;
    NSString *_tweetBody;
    NSDate   *_timestamp;
    NSString *_imageUrl;
}

@property (nonatomic, copy) NSString *user;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *tweetBody;
@property (nonatomic, retain) NSDate *timestamp;
@property (nonatomic, copy) NSString *imageUrl;



@end



//+ (id)itemWithTitle:(NSString*)title caption:(NSString*)caption text:(NSString*)text
//          timestamp:(NSDate*)timestamp URL:(NSString*)URL;
//+ (id)itemWithTitle:(NSString*)title caption:(NSString*)caption text:(NSString*)text
//          timestamp:(NSDate*)timestamp imageURL:(NSString*)imageURL URL:(NSString*)URL;
