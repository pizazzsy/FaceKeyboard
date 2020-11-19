//
//  ChatEmojiModel.h
//  CloudEdu_AI
//
//  Created by linkcircle on 2020/5/21.
//  Copyright © 2020 linkcircle. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChatEmojiModel : NSObject
// emoji 符号（字符串）
@property (nonatomic, copy) NSString *text;

// emoji 图片名称
@property (nonatomic, copy) NSString *imagePNG;

/**
 生成一个表情模型
 */
+ (instancetype)modelWithDictionary:(NSDictionary *)data;
@end

NS_ASSUME_NONNULL_END
