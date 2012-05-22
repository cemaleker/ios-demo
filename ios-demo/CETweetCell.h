//
//  CETweetCell.h
//  ios-demo
//
//  Created by Bal on 5/21/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HPUtils/HPUtils.h>

@class CETweet;

@interface CETweetCell : UITableViewCell {
    UIImageView *_profileImage;
    UILabel *_name;
    UILabel *_identity;
    UILabel *_time;
    UILabel *_tweetBody;
}

+ (CGFloat)cellHeightForTweet:(CETweet *)tweet forTableview: (UITableView*)tableView;
- (void) setTweet: (CETweet*) tweet;

@end
