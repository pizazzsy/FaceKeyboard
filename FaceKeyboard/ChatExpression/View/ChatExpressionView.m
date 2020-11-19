//
//  ChatExpressionView.m
//  CloudEdu_AI
//
//  Created by linkcircle on 2020/5/21.
//  Copyright © 2020 linkcircle. All rights reserved.
//

#import "ChatExpressionView.h"
#import "ChatExpressionCell.h"
#import "ChatEmojiManager.h"
#import "HLHorizontalPageLayout.h"
#define rowNum 21   //3行7列
#define TopAndBottom 5  //行间距
#define LeftAndRight 15 //列间距

@interface ChatExpressionView ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UIPageControl*pageControlBottom;
}
@property (nonatomic, strong) NSBundle *emotionBundle;

@end
@implementation ChatExpressionView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //横向排列
        CGFloat width = self.bounds.size.width;
        NSInteger col = 7; // 列数
        self.allEmojiModels=[ChatEmojiManager sharedManager].allEmojiModels;
        HLHorizontalPageLayout *layout = [[HLHorizontalPageLayout alloc]init];
        layout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
        layout.minimumInteritemSpacing = LeftAndRight;
        layout.minimumLineSpacing = TopAndBottom;
        CGFloat itemWidth = (width - LeftAndRight * (col-1) - layout.sectionInset.left - layout.sectionInset.right) / col;
        layout.itemSize = CGSizeMake( itemWidth, itemWidth);
        self.myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, width, frame.size.height-20) collectionViewLayout:layout];
        self.myCollectionView.dataSource = self;
        self.myCollectionView.delegate = self;
        self.myCollectionView.pagingEnabled = YES;
        self.myCollectionView.showsVerticalScrollIndicator = NO;
        self.myCollectionView.showsHorizontalScrollIndicator=NO;
        [self.myCollectionView registerNib:[UINib nibWithNibName:@"ChatExpressionCell" bundle:nil] forCellWithReuseIdentifier:@"ChatExpressionCell"];
        self.myCollectionView.backgroundColor = UIColor.whiteColor;

        pageControlBottom = [[UIPageControl alloc]initWithFrame:CGRectMake(0, frame.size.height-20, self.frame.size.width, 20)];
        pageControlBottom.pageIndicatorTintColor=[UIColor grayColor];
        pageControlBottom.currentPageIndicatorTintColor=[UIColor orangeColor];
        pageControlBottom.numberOfPages=(self.allEmojiModels.count/rowNum)+(self.allEmojiModels.count%rowNum==0?0:1);
        [self addSubview:self.myCollectionView];
        [self addSubview:pageControlBottom];
    }
    return self;
}

-(UIImage *)imageForEmotionPNGName:(NSString *)pngName{
     return [UIImage imageNamed:pngName inBundle:[ChatEmojiManager sharedManager].emotionBundle compatibleWithTraitCollection:nil];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.allEmojiModels.count;
}

#pragma mark cell的视图
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"ChatExpressionCell";
    ChatExpressionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    ChatEmojiModel *model = [self.allEmojiModels objectAtIndex:indexPath.item];
    cell.showImg.image =[[ChatEmojiManager sharedManager] imageForEmotionPNGName:model.imagePNG];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.item;
    ChatEmojiModel *model = [self.allEmojiModels objectAtIndex:index];
    if (_delegate) {
        [_delegate selectedEmoji:model];
    }
}

- (NSBundle *)emotionBundle {
    if (!_emotionBundle) {
        _emotionBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"Emotion" ofType:@"bundle"]];
    }
    return _emotionBundle;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat contenOffset = scrollView.contentOffset.x;
    int page = contenOffset/scrollView.bounds.size.width+((int)contenOffset%(int)scrollView.bounds.size.width==0?0:1);
    pageControlBottom.currentPage = page;
 
}

@end
