//
//  CETableTweetItemCell.h
//  ios-demo
//
//  Created by Bal on 5/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CETableTweetItemCell : TTTableViewCell {
    UILabel *_userLabel;
    UILabel *_userNameLabel;
    UILabel *_timestampLabel;
    TTImageView *_imageView2;
    TTStyledTextLabel *_tweetBodyLabel;
}

@property (nonatomic, readonly) UILabel *userLabel;
@property (nonatomic, readonly) UILabel *userNameLabel;
@property (nonatomic, readonly) UILabel *timestampLabel;
@property (nonatomic, readonly) TTImageView *imageView2;
@property (nonatomic, readonly) TTStyledTextLabel *tweetBodyLabel;

@end

