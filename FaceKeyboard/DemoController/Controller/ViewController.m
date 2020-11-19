//
//  ViewController.m
//  FaceKeyboard
//
//  Created by linkcircle on 2020/11/19.
//

#import "ViewController.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
#import "ChatExpressionView.h"
#import "SYTextView.h"
#import "Masonry.h"
#import "ChatTextLeftCell.h"
#import "ChatTextRightCell.h"
#import "MessageModel.h"


#define SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height
#define WeakSelf    __weak typeof(self) weakSelf = self


@interface ViewController ()<UITextViewDelegate, UITableViewDelegate, UITableViewDataSource,ChatExpressionViewDelegate,UITextViewDelegate>
{
    UIView *emojiView;
    UIView *bottomView;
    UIButton *faceBtn;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SYTextView *textView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [[NSMutableArray alloc]init];
    [self initData];
    [self CreatView];
}
#pragma mark 初始化数据
-(void)initData{
    for (int i=0; i<4; i++) {
        if (i%2==0) {
            MessageModel *MsgModel = [MessageModel new];
            MsgModel.msgContent = @"哈哈";
            MsgModel.sendBy = @"me";
            [self.dataSource addObject:MsgModel];
        }else{
            MessageModel *MsgModel = [MessageModel new];
            MsgModel.msgContent = @"收到";
            MsgModel.sendBy = @"you";
            [self.dataSource addObject:MsgModel];
        }
    }
}
#pragma mark 视图创建和更新
-(void)CreatView{
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-53);
    }];
    bottomView=[[UIView alloc]init];
    [bottomView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tableView.mas_bottom);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
    
    UIView *lineView=[[UIView alloc]init];
    [lineView setBackgroundColor:[UIColor grayColor]];
    [bottomView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomView.mas_top);
        make.left.right.mas_equalTo(bottomView);
        make.height.mas_equalTo(1);
    }];
    
    self.textView = [[SYTextView alloc] init];
    self.textView.delegate = self;
    self.textView.returnKeyType = UIReturnKeyDone;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 2.0;
    paragraphStyle.minimumLineHeight = 19.0;
    paragraphStyle.maximumLineHeight = 30.0;
    self.textView.Attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:17.0], NSParagraphStyleAttributeName : paragraphStyle};
    self.textView.placeholderContent = [[NSMutableAttributedString alloc] initWithString:@"我也来聊几句" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17.0], NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : [UIColor lightGrayColor]}];
    self.textView.emptyContent = [[NSAttributedString alloc] initWithString:@"" attributes:self.textView.Attributes];
    [self placeholderTextView];
    self.textView.layer.borderWidth = 1;
    self.textView.layer.cornerRadius = 2;
    self.textView.layer.borderColor = [UIColor grayColor].CGColor;
    self.textView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:0.4/1.0];
    [bottomView addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bottomView.mas_centerY);
        make.left.mas_equalTo(bottomView.mas_left).offset(15);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(self.view.frame.size.width-32-60-30);
    }];
    faceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [faceBtn setImage:[UIImage imageNamed:@"ChatFace"] forState:UIControlStateNormal];
    [faceBtn addTarget:self action:@selector(faceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:faceBtn];
    [faceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.textView.mas_right).offset(5);
        make.width.height.mas_equalTo(32);
        make.centerY.mas_equalTo(bottomView.mas_centerY);
    }];
    
    UIButton *sendBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    sendBtn.layer.cornerRadius = 4;
    [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendBtn setBackgroundColor:[UIColor colorWithRed:86/255.0 green:199/255.0 blue:249/255.0 alpha:1]];
    [sendBtn addTarget:self action:@selector(sendBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:sendBtn];
    [sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(faceBtn.mas_right).offset(5);
        make.centerY.mas_equalTo(bottomView.mas_centerY);
        make.width.mas_equalTo(60);
    }];
    [self AddExpression];
}
-(void)AddExpression{
    emojiView =[[UIView alloc]init];
    [self.view addSubview:emojiView];
    [emojiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomView.mas_bottom);
        make.left.right.mas_equalTo(bottomView);
        make.height.mas_equalTo(200);
    }];
    ChatExpressionView *ev = [[ChatExpressionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    ev.delegate=self;
    [emojiView addSubview:ev];

}
-(void)remakeLayoutWithShowKeyboard:(BOOL)showKeyboard ShowExpression:(BOOL)showExpression KeyboardHeight:(CGFloat)keyboardHeight{
    WeakSelf;
    if (showKeyboard) {
        
        [UIView animateWithDuration:0.3 animations:^{
            [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(weakSelf.view);
                make.top.equalTo(weakSelf.view);
                make.bottom.equalTo(weakSelf.view.mas_bottom).offset(-53-keyboardHeight);
            }];
            [bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(weakSelf.view.mas_bottom).offset(-keyboardHeight);
                make.left.right.mas_equalTo(weakSelf.view);
                make.height.mas_equalTo(53);
            }];
            if (showExpression) {
                [emojiView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(bottomView.mas_bottom);
                    make.left.right.mas_equalTo(bottomView);
                    make.height.mas_equalTo(keyboardHeight);
                }];
                emojiView.hidden=NO;
            }else{
                faceBtn.selected=NO;
                emojiView.hidden=YES;
            }
        }];
    }else{
        faceBtn.selected=NO;
        WeakSelf;
        [UIView animateWithDuration:0.3 animations:^{
             [bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
                 make.top.mas_equalTo(weakSelf.tableView.mas_bottom);
                 make.left.right.bottom.mas_equalTo(weakSelf.view);
             }];
             emojiView.hidden=YES;
             [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                 make.left.right.mas_equalTo(weakSelf.view);
                 make.top.equalTo(weakSelf.view);
                 make.bottom.equalTo(weakSelf.view.mas_bottom).offset(-53);
             }];
        }];
    }
}
#pragma mark placeholder显示和清除
-(void)textViewDidBeginEditing:(UITextView *)textView{
    [self clearPlaceholderTextView];
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    [self placeholderTextView];
}
- (void)placeholderTextView {
    if (self.textView.attributedText.length == 0 && !faceBtn.selected) {
        self.textView.attributedText = self.textView.placeholderContent;
    }
}
- (void)clearPlaceholderTextView {
    if (self.textView.textColor == [UIColor lightGrayColor]) {
        self.textView.textColor = [UIColor blackColor];
        self.textView.attributedText = self.textView.emptyContent;
    }
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageModel *model = [self.dataSource objectAtIndex:indexPath.row];
    CGFloat height = 0;
    if ([model.sendBy isEqualToString:@"me"]) {
        height = [ChatTextRightCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
            ChatTextRightCell *cell = (ChatTextRightCell *)sourceCell;
            [cell setItem:model];
        }];
    }else {
        height = [ChatTextLeftCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
            ChatTextLeftCell *cell = (ChatTextLeftCell *)sourceCell;
            [cell setItem:model];
        }];
    }
    return height+15;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageModel *model = [self.dataSource objectAtIndex:indexPath.row];
    if ([model.sendBy isEqualToString:@"me"]) {
        static NSString *reuseIdentifier_default = @"QYChatTextLeftCell";
        ChatTextRightCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier_default];
        if (cell == nil) {
            cell = [[ChatTextRightCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier_default];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setItem:model];
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }else {
        static NSString *reuseIdentifier_default = @"QYChatTextRightCell";
        ChatTextLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier_default];
        if (cell == nil) {
            cell = [[ChatTextLeftCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier_default];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setItem:model];
        cell.backgroundColor = [UIColor whiteColor];
    return cell;
    }
}
#pragma mark Click事件
-(void)sendBtnClick:(UIButton*)sender{
    [self.view endEditing:YES];
    [self remakeLayoutWithShowKeyboard:NO ShowExpression:NO KeyboardHeight:0];
    if (self.textView.textColor == [UIColor lightGrayColor]) {
        return;
    }
    if (self.textView.attributedText.length > 0 ) {
        NSString*str=[self.textView TextForRange:NSMakeRange(0, self.textView.attributedText.length)];
        //去除首尾空格和换行
        NSString *content = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (content.length>0) {
            [self sendIMMessage:str];
        }
        self.textView.attributedText = self.textView.emptyContent;
    }
    [self placeholderTextView];
    [self scrollowBottom];
}
-(void)faceBtnClick:(UIButton*)sender{
    [self.view endEditing:YES];
    sender.selected=!sender.selected;
    if (sender.selected) {
        [self remakeLayoutWithShowKeyboard:YES ShowExpression:YES KeyboardHeight:200];
        [self clearPlaceholderTextView];
    }else{
        [self remakeLayoutWithShowKeyboard:NO ShowExpression:NO KeyboardHeight:0];
        [self placeholderTextView];
    }
}

#pragma mark ChatExpressionViewDelegate
- (void)selectedEmoji:(ChatEmojiModel * _Nullable)emoji {
    if ([self.textView.text length] < 200) {
           NSRange cursorRange = self.textView.selectedRange;
           NSAttributedString *emojiAttrStr = [self.textView convertTextWithEmoji:emoji.text];
           [self.textView replaceCharactersInRange:cursorRange withAttributedString:emojiAttrStr];
           self.textView.selectedRange = NSMakeRange(cursorRange.location + emojiAttrStr.length, 0);
       }else {
           NSLog(@"字数超限！");
       }
}
#pragma mark 其他方法
- (void)sendIMMessage:(NSString *)command{
    //模拟发送信息
    MessageModel *sendMsgModel = [MessageModel new];
    sendMsgModel.msgContent = command;
    sendMsgModel.sendBy = @"me";
    [self.dataSource addObject:sendMsgModel];
    //模拟对方回复
    MessageModel *reMsgModel = [MessageModel new];
    reMsgModel.msgContent = @"收到";
    reMsgModel.sendBy = @"you";
    [self.dataSource addObject:reMsgModel];
    [self.tableView reloadData];
}
- (void)scrollowBottom {
    [UIView animateWithDuration:0.5 animations:^{
        if (self.dataSource.count>0) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataSource.count-1 inSection:0];
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }
    }];
}
@end
