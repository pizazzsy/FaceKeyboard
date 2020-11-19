//
//  QYChatTextLeftCell.h
//  CloudEdu_AI
//
//  Created by linkcircle on 2020/5/19.
//  Copyright © 2020 linkcircle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"
#import "SYChatTextView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChatTextLeftCell : UITableViewCell
@property (strong, nonatomic) SYChatTextView       *labelContent;
@property (strong, nonatomic) UILabel       *nameLabel;
@property (strong, nonatomic) UIView        *backView;
@property (strong, nonatomic) MessageModel  *item;
@end

NS_ASSUME_NONNULL_END
