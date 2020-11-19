//
//  ChatTextView.h
//  CloudEdu_AI
//
//  Created by linkcircle on 2020/5/21.
//  Copyright © 2020 linkcircle. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYChatTextView : UITextView


- (instancetype)init;
- (CGSize)setMessageContent:(NSString *)content admin:(BOOL)admin;

+ (NSMutableAttributedString *)attributedStringWithContent:(NSString *)content;
@end

NS_ASSUME_NONNULL_END
