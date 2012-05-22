//
//  CETweetCell.m
//  ios-demo
//
//  Created by Bal on 5/21/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CETweetCell.h"
#import "CETweet.h"
#import "NSDate+FuzzyTimeAdditions.h"

static CGFloat kDefaultMargin = 10.0;
static CGFloat kNameRowHeight = 15.0;
static CGFloat kTimeLabelWidth = 25.0;
static CGFloat kPhotoHeight = 50.0;
static CGFloat kPhotoWidth = 50.0;

@interface CETweetCell (PrivateMethods)

- (UIImageView*) profileImage;
- (UILabel*) name;
- (UILabel*) identity;
- (UILabel*) time;
- (UILabel*) tweetBody;
- (UIImage*) defaultImage;
+ (UILabel*) createTweetBodyLabel;


@end

@implementation CETweetCell

- (void)setTweet:(CETweet *)tweet {
    CGSize timeSize = CGSizeMake(25.0, 18.0);
    CGPoint currentPoint = CGPointMake(kDefaultMargin, kDefaultMargin);
    CGSize testSize;
    
    [[self profileImage] setFrame:CGRectMake(currentPoint.x, currentPoint.y, kPhotoWidth, kPhotoHeight)];
    currentPoint.x += kPhotoWidth + kDefaultMargin;
    
    [[HPRequestManager sharedManager] loadImageAtURL:tweet.profile_image_url withIndexPath: 0 identifier:@"identity" scaleToFit:CGSizeMake(kPhotoWidth, kPhotoHeight) contentMode:UIViewContentModeScaleAspectFill completionBlock:^(id resource, NSError *error) {
        NSAssert(error == nil, @"Image must be downloadable");
        UIImage *image = (UIImage*)resource;
        NSAssert([image isKindOfClass: [UIImage class]], @"Response must be an image");
        [[self profileImage] setImage: image];
    }];
    
    [[self tweetBody] setText: tweet.tweet_text];
    CGSize tweetBodySize =  [[self tweetBody] sizeThatFits: CGSizeMake(self.contentView.frame.size.width - currentPoint.x - kDefaultMargin , 999.0)];
    [[self tweetBody]  setFrame: CGRectMake(currentPoint.x, kNameRowHeight + kDefaultMargin, tweetBodySize.width, tweetBodySize.height)];
    
    [[self name] setText: tweet.user_name];
    testSize = CGSizeMake(self.contentView.frame.size.width - currentPoint.x - timeSize.width, 20);
    CGSize nameSize = [[self name] sizeThatFits:testSize];
    if(nameSize.width == 0 || nameSize.height == 0) {
        nameSize = testSize;
    }
    [[self name] setFrame: CGRectMake(currentPoint.x, currentPoint.y, nameSize.width, nameSize.height)];
    currentPoint.x += nameSize.width + kDefaultMargin;
    
    
    [[self identity] setText: tweet.user];
    testSize = CGSizeMake(self.contentView.frame.size.width - currentPoint.x - kTimeLabelWidth - kDefaultMargin, kNameRowHeight);
    [[self identity] setFrame: CGRectMake(currentPoint.x, currentPoint.y, testSize.width, testSize.height)];
    
    [[self time] setText: [tweet.created fuzzyTime]];
//    [[self time] setText: @"14m"];
    [[self time] setFrame:CGRectMake(self.contentView.frame.size.width - kDefaultMargin - kTimeLabelWidth, currentPoint.y, kTimeLabelWidth, kNameRowHeight)];
    
    
}

+ (CGFloat)cellHeightForTweet:(CETweet *)tweet forTableview: (UITableView*)tableView {
    UILabel *testLabel = [[self class] createTweetBodyLabel];
    [testLabel setText: tweet.tweet_text];
    CGSize tweetLabelSize = [testLabel sizeThatFits: CGSizeMake(tableView.frame.size.width - kPhotoWidth + (3* kDefaultMargin), 999.0)];
    
    CGFloat tweetTextHeight = tweetLabelSize.height + kNameRowHeight + (kDefaultMargin * 3);
    CGFloat photoHeight = (2 * kDefaultMargin) + kPhotoHeight;
    
    if(photoHeight > tweetTextHeight) {
        return photoHeight;
    } else {
        return tweetTextHeight;
    }
}
    
- (void) prepareForReuse {
    [super prepareForReuse];
}

#pragma mark - Subviews

- (UIImage*) defaultImage {
    return [UIImage imageNamed: @""];
}

- (UIImageView*) profileImage {
    if(_profileImage == nil) {
        _profileImage = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 50, 50)];
        [_profileImage setBackgroundColor: [UIColor orangeColor]];
        [self.contentView addSubview:_profileImage];
    }
    return _profileImage;
}

- (UILabel*) name {
    if(_name == nil) {
        _name = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        [_name setLineBreakMode:UILineBreakModeTailTruncation];
        [_name setTextAlignment: UITextAlignmentLeft];
        [_name setFont: [UIFont boldSystemFontOfSize:12.0]];
        [_name setTextColor: [UIColor blackColor]];
        [self.contentView addSubview:_name];
    }
    return _name;
}

- (UILabel*) identity {
    if(_identity == nil) {
        _identity = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        [_identity setLineBreakMode:UILineBreakModeTailTruncation];
        [_identity setTextAlignment:UITextAlignmentLeft];
        [_identity setFont: [UIFont systemFontOfSize:12.0]];
        [_identity setTextColor: [UIColor grayColor]];
        [self.contentView addSubview:_identity];
    }
    return _identity;
}

- (UILabel*) time {
    if(_time == nil) {
        _time = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        [_time setTextAlignment: UITextAlignmentRight];
        [_time setFont: [UIFont systemFontOfSize:12.0]];
        [_time setTextColor: [UIColor grayColor]];
        [self.contentView addSubview:_time];
    }
    return _time;
}

+ (UILabel*) createTweetBodyLabel {
    UILabel *tweetBodyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [tweetBodyLabel setLineBreakMode:UILineBreakModeWordWrap];
    [tweetBodyLabel setTextAlignment:UITextAlignmentLeft];
    [tweetBodyLabel setFont: [UIFont systemFontOfSize:13.0]];
    [tweetBodyLabel setTextColor: [UIColor blackColor]];
    [tweetBodyLabel setNumberOfLines: 0];
    return [tweetBodyLabel autorelease];
}

- (UILabel*) tweetBody {
    if(_tweetBody == nil) {
        _tweetBody = [[self class] createTweetBodyLabel];
        [self.contentView addSubview:_tweetBody];
    }
    return _tweetBody;
}


#pragma mark - Memory Management

- (void)dealloc {
    [_profileImage release], _profileImage = nil;
    [_name release], _name = nil;
    [_identity release], _identity = nil;
    [_time release], _time = nil;
    
    [super dealloc];
}

@end
