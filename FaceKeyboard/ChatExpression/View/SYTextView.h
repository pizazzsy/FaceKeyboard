//
//  QYTextView.h
//  CloudEdu_AI
//
//  Created by linkcircle on 2020/5/21.
//  Copyright © 2020 linkcircle. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYTextView : UITextView

@property (nonatomic, assign) CGRect emojiFrame;
@property (nonatomic, strong) NSDictionary *Attributes;
@property (nonatomic, strong) NSAttributedString *emptyContent;
@property (nonatomic, strong) NSAttributedString *placeholderContent;

- (NSString *)TextForRange:(NSRange)range;

- (void)replaceCharactersInRange:(NSRange)range withAttributedString:(NSAttributedString *)attrStr;

- (NSAttributedString *)convertTextWithEmoji:(NSString *)text;
@end

NS_ASSUME_NONNULL_END
