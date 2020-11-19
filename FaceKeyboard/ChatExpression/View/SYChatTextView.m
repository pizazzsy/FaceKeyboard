//
//  ChatTextView.m
//  CloudEdu_AI
//
//  Created by linkcircle on 2020/5/21.
//  Copyright © 2020 linkcircle. All rights reserved.
//

#import "SYChatTextView.h"
#import "ChatEmojiManager.h"
static float kChatTextViewFontSize = 14.0;
static NSString *kFilterRegularExpression = @"((http[s]{0,1}://)?[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";

@interface SYChatTextView ()

@property (nonatomic, strong) NSDictionary *normalAttributes;
@property (nonatomic, strong) NSDictionary *linkAttributes;

@property (nonatomic, assign) BOOL showingMenu;
@property (nonatomic, assign) NSRange lastSelectedRange;

@end
@implementation SYChatTextView



- (instancetype)init{
    self = [super init];
    if (self) {
        self.editable = NO;
        self.scrollEnabled = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.textContainer.lineFragmentPadding = 0;
        self.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
        self.backgroundColor=[UIColor clearColor];
        self.normalAttributes = @{
        NSFontAttributeName:[UIFont systemFontOfSize:kChatTextViewFontSize]};
    }
    return self;
}

#pragma mark - Public

- (CGSize)setMessageContent:(NSString *)content admin:(BOOL)admin {

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:content];
    [attributedString addAttributes:self.normalAttributes range:NSMakeRange(0, content.length)];
// 将消息中的 emoji 编码转换为图片
    NSMutableAttributedString *emojiAttributedString = [[ChatEmojiManager sharedManager] convertTextEmotionToAttachmentWithAttributedString:attributedString font:[UIFont systemFontOfSize:kChatTextViewFontSize]];
    self.attributedText = emojiAttributedString;
    
    CGRect originRect = self.frame;
    
    return originRect.size;
}

+ (NSMutableAttributedString *)attributedStringWithContent:(NSString *)content {
    NSMutableAttributedString *attributedString = [[ChatEmojiManager sharedManager] convertTextEmotionToAttachment:content
                                                                                                          font:[UIFont systemFontOfSize:kChatTextViewFontSize]];
    return attributedString;
}

@end
