//
//  ChatEmojiManager.h
//  CloudEdu_AI
//
//  Created by linkcircle on 2020/5/21.
//  Copyright © 2020 linkcircle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ChatEmojiModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChatEmojiManager : NSObject
+ (instancetype)sharedManager;
- (UIImage *)imageForEmotionPNGName:(NSString *)pngName;
/**
将表情文本转为属性字符串

@param text 表情文本
@param font 文本d大小
@return 属性字符串
*/
- (NSMutableAttributedString *)convertTextEmotionToAttachment:(NSString *)text font:(UIFont *)font;
/**
将已进行过格式处理的 NSMutableAttributedString 类型的表情文本转为属性字符串

@param attributeString 表情文本
@param font 文本d大小
@return 属性字符串
*/
- (NSMutableAttributedString *)convertTextEmotionToAttachmentWithAttributedString:(NSMutableAttributedString *)attributeString
                                                                             font:(UIFont *)font;
/// 表情字典数据
@property (nonatomic) NSMutableDictionary *emotionDictionary;

/// 表情模型数据
@property (nonatomic) NSMutableArray<ChatEmojiModel *> *allEmojiModels;
@property (nonatomic, strong) NSBundle *emotionBundle;
@property (nonatomic, strong) NSRegularExpression *regularExpression;


@end

NS_ASSUME_NONNULL_END
