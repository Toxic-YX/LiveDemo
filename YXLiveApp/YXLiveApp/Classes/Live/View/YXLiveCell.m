//
//  YXLiveCell.m
//  YXLiveApp
//
//  Created by YuXiang on 2017/5/2.
//  Copyright © 2017年 Rookie.YXiang. All rights reserved.
//

#import "YXLiveCell.h"
#import "YXLiveItem.h"
#import "YXCreatorItem.h"
#import <UIImageView+WebCache.h>

#define Color(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface YXLiveCell()
@property (weak, nonatomic) IBOutlet UIImageView *iocnImg;
@property (weak, nonatomic) IBOutlet UILabel *liveLbl;
@property (weak, nonatomic) IBOutlet UILabel *adressLbl;
@property (weak, nonatomic) IBOutlet UILabel *personNumLbl;
@property (weak, nonatomic) IBOutlet UIImageView *bigPicImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;

@end
@implementation YXLiveCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    _iocnImg.layer.cornerRadius = 5.0;
    _iocnImg.layer.masksToBounds = YES;
    
    _liveLbl.layer.cornerRadius = 5.0;
    _liveLbl.layer.masksToBounds = YES;
}

- (void)setLiveItem:(YXLiveItem *)liveItem {
    _liveItem = liveItem;
    
    NSURL *iocnImageUrl =  [NSURL URLWithString:[NSString stringWithFormat:@"%@",liveItem.creator.portrait]];
    
    [self.iocnImg sd_setImageWithURL:iocnImageUrl placeholderImage:[UIImage imageNamed:@"placeholder.jpeg"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    
    if (liveItem.city.length == 0) {
        _adressLbl.text = @"未知地点";
    }else {
        _adressLbl.text = liveItem.city;
    }
    
    self.nameLbl.text = liveItem.creator.nick;
    
    [self.bigPicImg sd_setImageWithURL:iocnImageUrl placeholderImage:[UIImage imageNamed:@"placeholder.jpeg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
    // 观众数量
    NSString *fullChaoyang = [NSString stringWithFormat:@"%zd人在看", liveItem.online_users];
    NSRange range = [fullChaoyang rangeOfString:[NSString stringWithFormat:@"%zd", liveItem.online_users]];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:fullChaoyang];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range: range];
    [attr addAttribute:NSForegroundColorAttributeName value:Color(216, 41, 116) range:range];
    self.personNumLbl.attributedText = attr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
