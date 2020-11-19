//
//  QYChatTextRightCell.m
//  CloudEdu_AI
//
//  Created by linkcircle on 2020/5/19.
//  Copyright © 2020 linkcircle. All rights reserved.
//

#import "ChatTextRightCell.h"
#import <Masonry/Masonry.h>
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
#define kAvatarWidth 30
#define kAvatarHeight 30


@implementation ChatTextRightCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self configView];
    }
    return self;
}

#pragma mark - Private

- (void)configView {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _backView = [[UIView alloc]init];
    _backView.layer.cornerRadius = 5;
    _backView.backgroundColor = [UIColor colorWithRed:86/255.0 green:199/255.0 blue:249/255.0 alpha:1];
    [self.contentView addSubview:_backView];
    
    _nameLab = [[UILabel alloc] init];
    _nameLab.textAlignment = NSTextAlignmentRight;
    _nameLab.textColor = [UIColor blackColor];
    _nameLab.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_nameLab];
    
    
    _labelContent = [[SYChatTextView alloc] init];
    _labelContent.textAlignment = NSTextAlignmentCenter;
    _labelContent.textColor = [UIColor blackColor];
//    _labelContent.numberOfLines = 0;
    _labelContent.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_labelContent];
    
    [self layoutUI];
}

- (void)layoutUI {
        
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(16);
        make.top.equalTo(self.mas_top).offset(1);
    }];
    
    [_labelContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_lessThanOrEqualTo(200);
        make.right.equalTo(self.mas_right).offset(-20);
        make.height.greaterThanOrEqualTo(@(15));
        make.top.equalTo(_nameLab.mas_bottom).offset(9);
    }];
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.labelContent.mas_right).offset(10);
        make.top.equalTo(self.labelContent.mas_top).offset(-2);
        make.left.equalTo(self.labelContent.mas_left).offset(-10);
        make.bottom.equalTo(self.labelContent.mas_bottom).offset(2);
    }];
    
    self.hyb_lastViewInCell = _labelContent;
    self.hyb_bottomOffsetToCell = 5;
}

- (void)setItem:(MessageModel *)item {
    _item = item;
    self.nameLab.text = [NSString stringWithFormat:@"%@ ",(item.sendBy)];
    [self.labelContent setMessageContent:item.msgContent admin:YES];
    
}

- (NSString*)getCurrentTimes{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    //现在时间,你可以输出来看下是什么格式
    NSDate *datenow = [NSDate date];
    //----------将nsdate按formatter格式转成nsstring
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    NSLog(@"currentTimeString =  %@",currentTimeString);
    return currentTimeString;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
