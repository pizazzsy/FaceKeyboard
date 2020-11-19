//
//  ChatEmojiModel.m
//  CloudEdu_AI
//
//  Created by linkcircle on 2020/5/21.
//  Copyright © 2020 linkcircle. All rights reserved.
//

#import "ChatEmojiModel.h"

@implementation ChatEmojiModel
+ (instancetype)modelWithDictionary:(NSDictionary *)data {
    ChatEmojiModel *model = [ChatEmojiModel new];
    model.text = [NSString stringWithFormat:@"[%@]",data[@"text"]];
    model.imagePNG = data[@"image"];
    return model;
}
@end
