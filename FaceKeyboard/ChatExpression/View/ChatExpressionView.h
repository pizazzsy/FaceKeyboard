//
//  ChatExpressionView.h
//  CloudEdu_AI
//
//  Created by linkcircle on 2020/5/21.
//  Copyright © 2020 linkcircle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatEmojiModel.h"
@protocol ChatExpressionViewDelegate
// 选择表情
- (void)selectedEmoji:(ChatEmojiModel *_Nullable)emoji;
@required
// 删除事件
- (void)deleteEvent;

@end
NS_ASSUME_NONNULL_BEGIN

@interface ChatExpressionView : UIView
@property (nonatomic,strong)UICollectionView *myCollectionView;
@property (nonatomic, weak) id<ChatExpressionViewDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *allEmojiModels;

@end

NS_ASSUME_NONNULL_END
