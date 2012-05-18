//
//  CETableTweetItemCell.m
//  ios-demo
//
//  Created by Bal on 5/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CETableTweetItemCell.h"
#import "CETableTweetItem.h"


@implementation CETableTweetItemCell

@synthesize 
    userLabel = _userLabel,
    userNameLabel = _userNameLabel,
    timestampLabel = _timestampLabel,
    imageView2 = _imageView2,
    tweetBodyLabel = _tweetBodyLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {
    self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier];
    if (self) {
//        self.textLabel.font = TTSTYLEVAR(font);
//        self.textLabel.textColor = TTSTYLEVAR(textColor);
//        self.textLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
//        self.textLabel.backgroundColor = TTSTYLEVAR(backgroundTextColor);
//        self.textLabel.textAlignment = UITextAlignmentLeft;
//        self.textLabel.lineBreakMode = UILineBreakModeTailTruncation;
//        self.textLabel.adjustsFontSizeToFitWidth = YES;
//        self.textLabel.contentMode = UIViewContentModeLeft;
//        
//        self.detailTextLabel.font = TTSTYLEVAR(font);
//        self.detailTextLabel.textColor = TTSTYLEVAR(tableSubTextColor);
//        self.detailTextLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
//        self.detailTextLabel.backgroundColor = TTSTYLEVAR(backgroundTextColor);
//        self.detailTextLabel.textAlignment = UITextAlignmentLeft;
//        self.detailTextLabel.contentMode = UIViewContentModeTop;
//        self.detailTextLabel.lineBreakMode = UILineBreakModeTailTruncation;
//        self.detailTextLabel.numberOfLines = kMessageTextLineCount;
//        self.detailTextLabel.contentMode = UIViewContentModeLeft;
    }
    
    return self;
}

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object {
    // XXXjoe Compute height based on font sizes
    return 110;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)prepareForReuse {
    [super prepareForReuse];
    [_imageView2 unsetImage];
    _userLabel.text = nil;
    _userNameLabel.text = nil;
    _timestampLabel.text = nil;
    _tweetBodyLabel.text = nil;
}




- (void)setObject:(id)object {
    [super setObject: object];
    
    CETableTweetItem *item = object;
    self.userLabel.text = item.user;
    self.userNameLabel.text = item.userName;
    self.timestampLabel.text = item.timestamp;
    self.imageView2.urlPath = item.imageUrl;
//    self.tweetBodyLabel.text = ;
}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//    
//    CGFloat left = 0.0f;
//    if (_imageView2) {
//        _imageView2.frame = CGRectMake(kTableCellSmallMargin, kTableCellSmallMargin,
//                                       kDefaultMessageImageWidth, kDefaultMessageImageHeight);
//        left += kTableCellSmallMargin + kDefaultMessageImageHeight + kTableCellSmallMargin;
//        
//    } else {
//        left = kTableCellMargin;
//    }
//    
//    CGFloat width = self.contentView.width - left;
//    CGFloat top = kTableCellSmallMargin;
//    
//    if (_titleLabel.text.length) {
//        _titleLabel.frame = CGRectMake(left, top, width, _titleLabel.font.ttLineHeight);
//        top += _titleLabel.height;
//        
//    } else {
//        _titleLabel.frame = CGRectZero;
//    }
//    
//    if (self.captionLabel.text.length) {
//        self.captionLabel.frame = CGRectMake(left, top, width, self.captionLabel.font.ttLineHeight);
//        top += self.captionLabel.height;
//        
//    } else {
//        self.captionLabel.frame = CGRectZero;
//    }
//    
//    if (self.detailTextLabel.text.length) {
//        CGFloat textHeight = self.detailTextLabel.font.ttLineHeight * kMessageTextLineCount;
//        self.detailTextLabel.frame = CGRectMake(left, top, width, textHeight);
//        
//    } else {
//        self.detailTextLabel.frame = CGRectZero;
//    }
//    
//    if (_timestampLabel.text.length) {
//        _timestampLabel.alpha = !self.showingDeleteConfirmation;
//        [_timestampLabel sizeToFit];
//        _timestampLabel.left = self.contentView.width - (_timestampLabel.width + kTableCellSmallMargin);
//        _timestampLabel.top = _titleLabel.top;
//        _titleLabel.width -= _timestampLabel.width + kTableCellSmallMargin*2;
//        
//    } else {
//        _timestampLabel.frame = CGRectZero;
//    }
//}




#pragma mark subviews

- (UILabel*) userLabel {
    if(!_userLabel) {
        _userLabel = [[UILabel alloc] init];
        _userLabel.textColor = [UIColor blackColor];
        _userLabel.font = [UIFont systemFontOfSize: 12.0];
        _userLabel.contentMode = UIViewContentModeLeft;
        [self.contentView addSubview: _userLabel];
    }
    
    return _userLabel;
}

- (UILabel*) userNameLabel {
    if(!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.textColor = [UIColor blackColor];
        _userNameLabel.font = [UIFont systemFontOfSize: 13.0];
        _userNameLabel.contentMode = UIViewContentModeLeft;
        [self.contentView addSubview: _userNameLabel];
    }
    
    return _userNameLabel;
}

- (UILabel*) timestampLabel {
    if(!_timestampLabel) {
        _timestampLabel = [[UILabel alloc] init];
        _timestampLabel.textColor = [UIColor grayColor];
        _timestampLabel.font = [UIFont systemFontOfSize: 10.0];
        _timestampLabel.contentMode = UIViewContentModeRight;
        [self.contentView addSubview: _timestampLabel];
    }
    
}

- (TTImageView*) imageView2 {
    if(!_imageView2) {
        _imageView2 = [[TTImageView alloc] init];
        [self.contentView addSubview: _imageView2];
    }
    
    return _imageView2;
}

- (TTStyledTextLabel*) tweetBodyLabel {
    if(_tweetBodyLabel) {
        _tweetBodyLabel = [[TTStyledTextLabel alloc] init];
        _tweetBodyLabel.contentMode = UIViewContentModeLeft;
        [self.contentView addSubview: _tweetBodyLabel];
    }
}



@end



/**


 static const NSInteger  kMessageTextLineCount       = 2;
 static const CGFloat    kDefaultMessageImageWidth   = 34.0f;
 static const CGFloat    kDefaultMessageImageHeight  = 34.0f;
 
 
 ///////////////////////////////////////////////////////////////////////////////////////////////////
 ///////////////////////////////////////////////////////////////////////////////////////////////////
 ///////////////////////////////////////////////////////////////////////////////////////////////////
 @implementation TTTableMessageItemCell
 
 
 ///////////////////////////////////////////////////////////////////////////////////////////////////
 - (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {
 self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier];
 if (self) {
 self.textLabel.font = TTSTYLEVAR(font);
 self.textLabel.textColor = TTSTYLEVAR(textColor);
 self.textLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
 self.textLabel.backgroundColor = TTSTYLEVAR(backgroundTextColor);
 self.textLabel.textAlignment = UITextAlignmentLeft;
 self.textLabel.lineBreakMode = UILineBreakModeTailTruncation;
 self.textLabel.adjustsFontSizeToFitWidth = YES;
 self.textLabel.contentMode = UIViewContentModeLeft;
 
 self.detailTextLabel.font = TTSTYLEVAR(font);
 self.detailTextLabel.textColor = TTSTYLEVAR(tableSubTextColor);
 self.detailTextLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
 self.detailTextLabel.backgroundColor = TTSTYLEVAR(backgroundTextColor);
 self.detailTextLabel.textAlignment = UITextAlignmentLeft;
 self.detailTextLabel.contentMode = UIViewContentModeTop;
 self.detailTextLabel.lineBreakMode = UILineBreakModeTailTruncation;
 self.detailTextLabel.numberOfLines = kMessageTextLineCount;
 self.detailTextLabel.contentMode = UIViewContentModeLeft;
 }
 
 return self;
 }
 
 
 ///////////////////////////////////////////////////////////////////////////////////////////////////
 - (void)dealloc {
 TT_RELEASE_SAFELY(_titleLabel);
 TT_RELEASE_SAFELY(_timestampLabel);
 TT_RELEASE_SAFELY(_imageView2);
 
 [super dealloc];
 }
 
 
 ///////////////////////////////////////////////////////////////////////////////////////////////////
 ///////////////////////////////////////////////////////////////////////////////////////////////////
 #pragma mark -
 #pragma mark TTTableViewCell class public
 
 
 ///////////////////////////////////////////////////////////////////////////////////////////////////
 + (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object {
 // XXXjoe Compute height based on font sizes
 return 90;
 }
 
 
 ///////////////////////////////////////////////////////////////////////////////////////////////////
 ///////////////////////////////////////////////////////////////////////////////////////////////////
 #pragma mark -
 #pragma mark UIView
 
 
 ///////////////////////////////////////////////////////////////////////////////////////////////////
 - (void)prepareForReuse {
 [super prepareForReuse];
 [_imageView2 unsetImage];
 _titleLabel.text = nil;
 _timestampLabel.text = nil;
 self.captionLabel.text = nil;
 }
 
 
 ///////////////////////////////////////////////////////////////////////////////////////////////////
 - (void)layoutSubviews {
 [super layoutSubviews];
 
 CGFloat left = 0.0f;
 if (_imageView2) {
 _imageView2.frame = CGRectMake(kTableCellSmallMargin, kTableCellSmallMargin,
 kDefaultMessageImageWidth, kDefaultMessageImageHeight);
 left += kTableCellSmallMargin + kDefaultMessageImageHeight + kTableCellSmallMargin;
 
 } else {
 left = kTableCellMargin;
 }
 
 CGFloat width = self.contentView.width - left;
 CGFloat top = kTableCellSmallMargin;
 
 if (_titleLabel.text.length) {
 _titleLabel.frame = CGRectMake(left, top, width, _titleLabel.font.ttLineHeight);
 top += _titleLabel.height;
 
 } else {
 _titleLabel.frame = CGRectZero;
 }
 
 if (self.captionLabel.text.length) {
 self.captionLabel.frame = CGRectMake(left, top, width, self.captionLabel.font.ttLineHeight);
 top += self.captionLabel.height;
 
 } else {
 self.captionLabel.frame = CGRectZero;
 }
 
 if (self.detailTextLabel.text.length) {
 CGFloat textHeight = self.detailTextLabel.font.ttLineHeight * kMessageTextLineCount;
 self.detailTextLabel.frame = CGRectMake(left, top, width, textHeight);
 
 } else {
 self.detailTextLabel.frame = CGRectZero;
 }
 
 if (_timestampLabel.text.length) {
 _timestampLabel.alpha = !self.showingDeleteConfirmation;
 [_timestampLabel sizeToFit];
 _timestampLabel.left = self.contentView.width - (_timestampLabel.width + kTableCellSmallMargin);
 _timestampLabel.top = _titleLabel.top;
 _titleLabel.width -= _timestampLabel.width + kTableCellSmallMargin*2;
 
 } else {
 _timestampLabel.frame = CGRectZero;
 }
 }
 
 
 ///////////////////////////////////////////////////////////////////////////////////////////////////
 - (void)didMoveToSuperview {
 [super didMoveToSuperview];
 
 if (self.superview) {
 _imageView2.backgroundColor = self.backgroundColor;
 _titleLabel.backgroundColor = self.backgroundColor;
 _timestampLabel.backgroundColor = self.backgroundColor;
 }
 }
 
 
 ///////////////////////////////////////////////////////////////////////////////////////////////////
 ///////////////////////////////////////////////////////////////////////////////////////////////////
 #pragma mark -
 #pragma mark TTTableViewCell
 
 
 ///////////////////////////////////////////////////////////////////////////////////////////////////
 - (void)setObject:(id)object {
 if (_item != object) {
 [super setObject:object];
 
 TTTableMessageItem* item = object;
 if (item.title.length) {
 self.titleLabel.text = item.title;
 }
 if (item.caption.length) {
 self.captionLabel.text = item.caption;
 }
 if (item.text.length) {
 self.detailTextLabel.text = item.text;
 }
 if (item.timestamp) {
 self.timestampLabel.text = [item.timestamp formatShortTime];
 }
 if (item.imageURL) {
 self.imageView2.urlPath = item.imageURL;
 }
 }
 }
 
 
 ///////////////////////////////////////////////////////////////////////////////////////////////////
 ///////////////////////////////////////////////////////////////////////////////////////////////////
 #pragma mark -
 #pragma mark Public
 
 
 ///////////////////////////////////////////////////////////////////////////////////////////////////
 - (UILabel*)titleLabel {
 if (!_titleLabel) {
 _titleLabel = [[UILabel alloc] init];
 _titleLabel.textColor = [UIColor blackColor];
 _titleLabel.highlightedTextColor = [UIColor whiteColor];
 _titleLabel.font = TTSTYLEVAR(tableFont);
 _titleLabel.contentMode = UIViewContentModeLeft;
 [self.contentView addSubview:_titleLabel];
 }
 return _titleLabel;
 }
 
 
 ///////////////////////////////////////////////////////////////////////////////////////////////////
 - (UILabel*)captionLabel {
 return self.textLabel;
 }
 
 
 ///////////////////////////////////////////////////////////////////////////////////////////////////
 - (UILabel*)timestampLabel {
 if (!_timestampLabel) {
 _timestampLabel = [[UILabel alloc] init];
 _timestampLabel.font = TTSTYLEVAR(tableTimestampFont);
 _timestampLabel.textColor = TTSTYLEVAR(timestampTextColor);
 _timestampLabel.highlightedTextColor = [UIColor whiteColor];
 _timestampLabel.contentMode = UIViewContentModeLeft;
 [self.contentView addSubview:_timestampLabel];
 }
 return _timestampLabel;
 }
 
 
 ///////////////////////////////////////////////////////////////////////////////////////////////////
 - (TTImageView*)imageView2 {
 if (!_imageView2) {
 _imageView2 = [[TTImageView alloc] init];
 //    _imageView2.defaultImage = TTSTYLEVAR(personImageSmall);
 //    _imageView2.style = TTSTYLE(threadActorIcon);
 [self.contentView addSubview:_imageView2];
 }
 return _imageView2;
 }



**/