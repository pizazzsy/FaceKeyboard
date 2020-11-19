//
//  MessageModel.h
//  CloudEdu
//
//  Created by linkcircle on 2018/7/19.
//  Copyright © 2018 linkcircle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

/// 消息内容
@property (nonatomic, strong) NSString * msgContent;
/// 发送者
@property (nonatomic, strong) NSString * sendBy;

@end
