//
//  ZLImageViewDisplayView.m
//  ZLImageViewDisplay
//
//  Created by Mr.LuDashi on 15/8/14.
//  Copyright (c) 2015年 ludashi. All rights reserved.
//

#import "ZXDLabelInViewDisplay.h"
//#import "UIImageView+WebCache.h"

@interface ZXDLabelInViewDisplay ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UIPageControl *mainPageControl;
@property (nonatomic, assign) CGFloat widthOfView;
@property (nonatomic, assign) CGFloat heightView;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UILabel *rateLabel;
@property (nonatomic, assign) UIViewContentMode imageViewcontentModel;
@property (nonatomic, strong) TapImageViewButtonBlock block;
@end

@implementation ZXDLabelInViewDisplay

#pragma -- 遍历构造器
+ (instancetype) zlImageViewDisplayViewWithFrame: (CGRect) frame {
    ZXDLabelInViewDisplay *instance = [[ZXDLabelInViewDisplay alloc] initWithFrame:frame];
    return instance;
}


#pragma -- mark 遍历初始化方法
- (instancetype)initWithFrame: (CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _widthOfView = frame.size.width;            //获取滚动视图的宽度
        _heightView = frame.size.height;            //获取滚动视图的高度
        _scrollInterval = 3;
        _animationInterVale = 0.7;
        _currentPage = 1;                           //当前显示页面
        _imageViewcontentModel = UIViewContentModeScaleToFill;
        self.clipsToBounds = YES;
    }
    return self;
}

-(void)layoutSubviews {
    [self initMainScrollView];                          //初始化滚动视图
    [self addImageviewsForMainScroll];    //添加ImageView
    [self addTimerLoop];            //添加timer
    [self addPageControl];
    [self initImageViewButton];
//    [self addSubview:self.rateLabel];
}


- (void)addTapEventForImageWithBlock:(TapImageViewButtonBlock) block{
    if (_block == nil) {
        if (block != nil) {
            _block = block;
        }
    }
}


#pragma -- mark 初始化按钮
- (void)initImageViewButton{
    for( int i = 0; i < _dataArray.count + 1; i ++) {
        
        CGRect currentFrame = CGRectMake(_widthOfView * i, 0, _widthOfView, _heightView);
        
        UIButton *tempButton = [[UIButton alloc] initWithFrame:currentFrame];
        [tempButton addTarget:self action:@selector(tapImageButton:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            tempButton.tag = _dataArray.count;
        } else {
            tempButton.tag = i;
        }
        [_mainScrollView addSubview:tempButton];
    }
}

- (UILabel *)rateLabel {
    if (!_rateLabel) {
        _rateLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.frame) - 45*ScalePpth, CGRectGetMaxY(self.frame) - 30*ScalePpth, 35*ScalePpth, 20*ScalePpth)];
        _rateLabel.backgroundColor = RGBHexAlpha(0x000000, 0.5);
        _rateLabel.layer.cornerRadius = 10*ScalePpth;
        _rateLabel.layer.masksToBounds = YES;
        _rateLabel.textColor = UIColor.whiteColor;
        _rateLabel.text = @"1/2";
        _rateLabel.font = FontSize(12);
        _rateLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _rateLabel;
}

- (void) tapImageButton: (UIButton *) sender{
    if (_block) {
        _block(sender.tag);
    }
}

/**
 *  初始化ScrollView
 */
- (void) initMainScrollView{
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _widthOfView, _heightView)];
    _mainScrollView.contentSize = CGSizeMake(_widthOfView, _heightView);
    _mainScrollView.pagingEnabled = YES;
    _mainScrollView.bounces = NO;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    _mainScrollView.showsVerticalScrollIndicator = NO;
    _mainScrollView.delegate = self;
    [self addSubview:_mainScrollView];
}

/**
 *  添加PageControl
 */
- (void) addPageControl{
    _imageViewPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _heightView - 20, _widthOfView, 20)];
    
    _imageViewPageControl.numberOfPages = _dataArray.count;
    
    _imageViewPageControl.currentPage = _currentPage - 1;
    
    _imageViewPageControl.tintColor = [UIColor blackColor];
    
    _imageViewPageControl.hidden = !self.showPageControl;
    
    [self addSubview:_imageViewPageControl];
}


/**
 *  给ScrollView添加ImageView
 */
-(void) addImageviewsForMainScroll{
    if (_dataArray != nil) {
        //设置ContentSize
       
        NSUInteger i = (_dataArray.count < 2) ? 0 : 1;
        _mainScrollView.contentSize = CGSizeMake(_widthOfView * (_dataArray.count+i), _heightView);
        
        for ( int i = 0; i < _dataArray.count + 1; i ++) {
            CGRect currentFrame = CGRectMake(_widthOfView * i, 0, _widthOfView, _heightView);
            UIView *tempImageView = [[UIView alloc] initWithFrame:currentFrame];
            tempImageView.contentMode = _imageViewcontentModel;
            tempImageView.clipsToBounds = YES;
            
            [_mainScrollView addSubview:tempImageView];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:AutoFrame(15.5, 0, 17, 20)];
            imageView.image = [UIImage imageNamed:@"home_tips"];
            [tempImageView addSubview:imageView];
             UIButton *button = [[UIButton alloc] initWithFrame:AutoFrame(43.5, 4, 48, 16)];
             UILabel *label = [[UILabel alloc] initWithFrame:AutoFrame(98.5,6.5, 270, 12)];
            if (i == 0) {
                 [button setTitle:[_dataArray lastObject][@"title"] forState:UIControlStateNormal];
                 label.text = [_dataArray lastObject][@"content"];
            } else {
                [button setTitle:_dataArray[i-1][@"title"] forState:UIControlStateNormal];
                label.text = _dataArray[i-1][@"content"];
            }
           
            button.layer.cornerRadius = 2*ScalePpth;
            button.layer.masksToBounds = YES;
            button.layer.borderWidth = 0.5;
            button.layer.borderColor = RGBHex(0xFF5F56).CGColor;
            button.titleLabel.font = FontSize(10);
            [button setTitleColor:RGBHex(0xFF5F56) forState:UIControlStateNormal];
            [tempImageView addSubview:button];
           
            label. textColor = RGBHex(0x000000);
            label.font = FontSize(12);
            [tempImageView addSubview:label];
        }
        _mainScrollView.contentOffset = CGPointMake(_widthOfView, 0);
    }
}

- (void) addTimerLoop{
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:_scrollInterval target:self selector:@selector(changeOffset) userInfo:nil repeats:YES];
    }
}

- (void)changeOffset{
    
    if (_dataArray.count < 2) {
        return;
    }
    _currentPage ++;
    if (_currentPage == _dataArray.count + 1) {
        _currentPage = 1;
    }
    _rateLabel.text = [NSString stringWithFormat:@"%ld/%ld",_currentPage,_dataArray.count];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:_animationInterVale animations:^{
        weakSelf.mainScrollView.contentOffset = CGPointMake(weakSelf.widthOfView * weakSelf.currentPage, 0);
    } completion:^(BOOL finished) {
        if (weakSelf.currentPage == weakSelf.dataArray.count) {
            weakSelf.mainScrollView.contentOffset = CGPointMake(0, 0);
        }
    }];
     _imageViewPageControl.currentPage = _currentPage - 1;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (_dataArray.count < 2) {
        return;
    }
    
    NSInteger currentPage = scrollView.contentOffset.x / _widthOfView;
    if(currentPage == 0){
        _mainScrollView.contentOffset = CGPointMake(_widthOfView * _dataArray.count, 0);
        _imageViewPageControl.currentPage = _dataArray.count;
        _currentPage = _dataArray.count;
        _rateLabel.text = [NSString stringWithFormat:@"%ld/%ld",_currentPage,_dataArray.count];
        [self resumeTimer];
        return;
    }
    
    if (_currentPage + 1 == currentPage || currentPage == 1) {
        _currentPage = currentPage;
        
        if (_currentPage == _dataArray.count + 1) {
            _currentPage = 1;
        }
        
        if (_currentPage == _dataArray.count) {
            _mainScrollView.contentOffset = CGPointMake(0, 0);
        }
        
        _imageViewPageControl.currentPage = _currentPage - 1;
        _rateLabel.text = [NSString stringWithFormat:@"%ld/%ld",_currentPage,_dataArray.count];
        [self resumeTimer];
        return;
    }
      _rateLabel.text = [NSString stringWithFormat:@"%ld/%ld",_currentPage,_dataArray.count];
    
}

/**
 *  暂停定时器
 */
-(void)resumeTimer{
    
    if (![_timer isValid]) {
        return ;
    }
    [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:_scrollInterval-_animationInterVale]];
}


@end
