//
//  QYChatTextLeftCell.m
//  CloudEdu_AI
//
//  Created by linkcircle on 2020/5/19.
//  Copyright © 2020 linkcircle. All rights reserved.
//

#import "ChatTextLeftCell.h"
#import <Masonry/Masonry.h>
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
#define kAvatarWidth 30
#define kAvatarHeight 30

@implementation ChatTextLeftCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self configView];
    }
    return self;
}
- (void)configView {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _backView = [[UIView alloc]init];
    _backView.layer.cornerRadius = 5;
    _backView.backgroundColor = [UIColor colorWithRed:89/255.0 green:208/255.0 blue:118/255.0 alpha:1];
    [self.contentView addSubview:_backView];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.textColor = [UIColor blackColor];
    _nameLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_nameLabel];
    
    _labelContent = [[SYChatTextView alloc] init];
    _labelContent.textAlignment = NSTextAlignmentCenter;
    _labelContent.textColor = [UIColor blackColor];
    _labelContent.font = [UIFont systemFontOfSize:14];
    [_backView addSubview:_labelContent];
    
    [self layoutUI];
}

- (void)layoutUI {
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(1);
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.height.mas_equalTo(16);
    }];
    
    [_labelContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.width.mas_lessThanOrEqualTo(200);
        make.height.greaterThanOrEqualTo(@(15));
        make.top.equalTo(self.nameLabel.mas_bottom).offset(9);
    }];
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.labelContent.mas_right).offset(10);
        make.top.equalTo(self.labelContent.mas_top).offset(-2);
        make.left.equalTo(self.labelContent.mas_left).offset(-10);
        make.bottom.equalTo(self.labelContent.mas_bottom).offset(2);
    }];
    self.hyb_lastViewInCell = _backView;
    self.hyb_bottomOffsetToCell = 5;
}

- (void)setItem:(MessageModel *)item {
    _item = item;
    self.nameLabel.text = [NSString stringWithFormat:@"%@ ",(item.sendBy)];
    [self.labelContent setMessageContent:item.msgContent admin:YES];
    
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
