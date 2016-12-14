//
//  ViewController.m
//  text
//
//  Created by hanlu on 16/7/30.
//  Copyright © 2016年 吴迪. All rights reserved.
//

#import "SaoleiViewController.h"
#import "SaoleiView.h"
#import "SaoleiHeaderView.h"
#import "SaoleiNumberOrTimeImageView.h"
#import "SaoleiFooterView.h"
#import "SaveHandle.h"
#import "PopViewController.h"
#import "PaihangViewController.h"
@interface SaoleiViewController ()<UIPopoverPresentationControllerDelegate,PopViewControllerDelegate>
/**
 *  用户选择的点击方式
 */
@property (nonatomic,assign) SaoleiUserClickKind clickKind;
/**
 *  是否是第一次点击
 */
@property (nonatomic,assign) BOOL firstClick;
/**
 *  还剩余的雷数(用来控制左侧计数面板的显示数字)
 */
@property (nonatomic,assign) NSInteger numberOfLeiExist;
/**
 *  雷存在的总数
 */
@property (nonatomic,assign) NSInteger numberOfLei;
/**
 *  用来控制右侧计时面板的显示时间
 */
@property (nonatomic,assign) NSInteger timeInterval;
/**
 *  右侧计时面板定时器
 */
@property (nonatomic,strong) NSTimer *timer;
/**
 *  扫雷主视图
 */
@property (nonatomic,strong) SaoleiView *saoleiView;
/**
 *  扫雷头部视图
 */
@property (nonatomic,strong) SaoleiHeaderView *headerView;
/**
 *  扫雷选择视图
 */
@property (nonatomic,strong) SaoleiFooterView *footerView;

@property (nonatomic,copy) NSString *userName;
/**
 *  难度(中级16X16 40个雷，初级8X8 10个雷)
 */
@property (nonatomic,assign) KindOfUserDifficulty difficulty;

@property (nonatomic,strong) PopViewController *popVC;

@property (nonatomic,strong) PaihangViewController *paihangVC;

@property (nonatomic,assign) NSInteger randomNum;

@end

@implementation SaoleiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _firstClick = YES;
    
    [self setupUI];
    
    self.userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    
    self.difficulty = [[[NSUserDefaults standardUserDefaults] objectForKey:@"difficulty"] integerValue];
}

- (void)setupUI {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"选择难度" style:(UIBarButtonItemStylePlain) target:self action:@selector(popView)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"排行榜" style:(UIBarButtonItemStylePlain) target:self action:@selector(popPaihang)];
    
    SaoleiView *view = [[SaoleiView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetWidth(self.view.frame)) NumberOfChessInLine:0 NumberOfChessInList:0 ViewController:self];
    
    view.center = CGPointMake(self.view.center.x, self.view.center.y  + 50 * [UIScreen mainScreen].bounds.size.height / 736);
    
    self.saoleiView = view;
    
    [self.view addSubview:view];
    
    _headerView = [[SaoleiHeaderView alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(view.frame) - 60, self.view.frame.size.width, 60)];
    
    [_headerView.restartButton addTarget:self action:@selector(gameRestarted) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view addSubview:_headerView];
    
    _footerView = [[SaoleiFooterView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view.frame), self.view.frame.size.width, 60)];
    
    [_footerView.normalButton addTarget:self action:@selector(changeClickKindWithButton:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [_footerView.questionButton addTarget:self action:@selector(changeClickKindWithButton:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [_footerView.flagButton addTarget:self action:@selector(changeClickKindWithButton:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view addSubview:_footerView];
}

-(void)popPaihang{
    _paihangVC = [[PaihangViewController alloc] init];
    
    _paihangVC.randomNum = self.randomNum;
    
    _paihangVC.difficulty = self.difficulty;
    
    _paihangVC.modalPresentationStyle = UIModalPresentationPopover;
    
    //设置依附的按钮
    _paihangVC.popoverPresentationController.barButtonItem = self.navigationItem.rightBarButtonItem;
    
    //可以指示小箭头颜色
    _paihangVC.popoverPresentationController.backgroundColor = [UIColor whiteColor];
    
    //content尺寸
    _paihangVC.preferredContentSize = CGSizeMake(400, 400);
    
    //pop方向
    _paihangVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    //delegate
    _paihangVC.popoverPresentationController.delegate = self;
    
    [self presentViewController:_paihangVC animated:YES completion:nil];
}

-(void)popView{
    _popVC = [[PopViewController alloc] init];
    
    _popVC.delegate = self;
    
    _popVC.modalPresentationStyle = UIModalPresentationPopover;
    
    //设置依附的按钮
    _popVC.popoverPresentationController.barButtonItem = self.navigationItem.leftBarButtonItem;
    
    //可以指示小箭头颜色
    _popVC.popoverPresentationController.backgroundColor = [UIColor whiteColor];
    
    //content尺寸
    _popVC.preferredContentSize = CGSizeMake(400, 400);
    
    //pop方向
    _popVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    //delegate
    _popVC.popoverPresentationController.delegate = self;
    
    [self presentViewController:_popVC animated:YES completion:nil];
}
//代理方法 ,点击即可dismiss掉每次init产生的PopViewController
-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationNone;
}

- (void)popViewController:(PopViewController *)popViewController didselectedWith:(NSInteger)indexPathRow {
    [popViewController dismissViewControllerAnimated:YES completion:^{
        self.difficulty = indexPathRow;
        
        [self gameRestarted];
    }];
}

- (void)changeClickKindWithButton:(UIButton *)sender {
    self.clickKind = sender.tag;
}

- (void)gameRestarted {
    self.numberOfLeiExist = self.numberOfLei;
    
    self.timeInterval = 0;
    
    self.saoleiView.userInteractionEnabled = YES;
    
    self.firstClick = YES;
    
    self.clickKind = SaoleiUserClickKindNormal;
    
    self.headerView.restartKind = RestartKindNormal;
    
    [self timerEnd];
    
    [self.saoleiView getRestarted];
}

- (void)timerStart {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeAdd) userInfo:nil repeats:YES];
}

- (void)timerEnd {
    [self.timer invalidate];
}

- (void)timeAdd{
    self.timeInterval ++;
}
/**
 *  棋盘上的按钮被点到
 */
- (void)buttonDidClicked:(SaoleiChessView *)sender{
    switch (self.clickKind) {
        case SaoleiUserClickKindFlag:{
            [self otherClickStyle:SaoleiUserClickKindFlag withSender:sender];
            
            [self checkWin];
        }
            break;
        case SaoleiUserClickKindNormal:{
            [self normalClickStyleWithSender:sender];
        }
            break;
        case SaoleiUserClickKindQusetion:{
            [self otherClickStyle:SaoleiUserClickKindQusetion withSender:sender];
        }
            break;
    }
    
}

- (void)normalClickStyleWithSender:(SaoleiChessView *)sender {
    if (_firstClick) {
        [self setLeiNumber:self.numberOfLei andFirstPosition:sender.position];
        
        [self timerStart];
        
        _firstClick = !_firstClick;
    }
    
    /**
     *  该按钮首先需要可以被点击
     */
    if (sender.enabled) {
        /**
         *  该按钮其次上面不能有棋子和问号，这俩都不能被点击
         */
        if (sender.clickKind == SaoleiUserClickKindNormal) {
            /**
             *  当该棋子为雷的时候
             */
            if (sender.isLei) {
                [sender setBackgroundImage:[UIImage imageNamed:@"tile_0_b"] forState:(UIControlStateDisabled)];
                
                sender.enabled = NO;
                
                [self loseGame];
            }else {
                /**
                 *  周围的雷数不为0
                 */
                if (sender.numberOfLei) {
                    NSString *string = [NSString stringWithFormat:@"tile_0_%ld~hd.png",sender.numberOfLei];
                    
                    [sender setBackgroundImage:[UIImage imageNamed:string] forState:(UIControlStateDisabled)];
                    
                    sender.enabled = NO;
                }else {
                    [sender setBackgroundImage:[UIImage imageNamed:@"tile_0_base~hd"] forState:(UIControlStateDisabled)];
                    
                    sender.enabled = NO;
                    /**
                     *  当用户点击的这个棋子周围8个格都没有雷的时候，系统自动帮忙点击其余8个,加快游戏进度
                     */
                    for (SaoleiChessView *chess in [self getButtonsAroundSender:sender]) {
                        [self normalClickStyleWithSender:chess];
                    }
                }
            }
        }
    }
}

- (void)otherClickStyle:(SaoleiUserClickKind)clickKind withSender:(SaoleiChessView *)sender {
    if (sender.clickKind != clickKind) {
        sender.clickKind = clickKind;
    } else {
        sender.clickKind = SaoleiUserClickKindNormal;
    }
    [self checkNumberOfLeiExistist];
}

- (void)checkNumberOfLeiExistist {
    NSInteger numberOfFlags = 0;
    
    for (SaoleiChessView *chess in self.saoleiView.subviews) {
        if (chess.clickKind == SaoleiUserClickKindFlag) {
            numberOfFlags ++;
        }
    }
    
    self.numberOfLeiExist = self.numberOfLei - numberOfFlags;
}

- (void)checkWin {
    NSInteger realNumber = 0;
    
    for (SaoleiChessView *chess in self.saoleiView.subviews) {
        if (chess.isLei) {
            if (chess.clickKind == SaoleiUserClickKindFlag) {
                realNumber ++;
            }
        }
        
    }
    if (realNumber == self.numberOfLei && self.numberOfLeiExist == 0) {
        [self winGame];
    }
}

- (void)winGame {
    self.headerView.restartKind = RestartKindWin;
    
    self.saoleiView.userInteractionEnabled = NO;
    
    [self timerEnd];
    
    NSString *message = nil;
    
    NSString *difficulty = nil;
    
    switch (self.difficulty) {
        case KindOfUserDifficultyEasy:
            difficulty = @"简单";
            break;
        case KindOfUserDifficultyNormal:
            difficulty = @"中等";
            break;
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"恭喜大侠" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
    
    NSArray *array = [[SaveHandle shareSaveHandle]findModelWithDifficulty:self.difficulty];
    
    if (array.count < 5 || (array.count >= 5 && ((UserModel *)array.lastObject).time > self.timeInterval)) {
        message = [NSString stringWithFormat:@"你赢得了%@模式,完成比赛所用时间为%ld秒,进入了记录榜哦！！！",difficulty,self.timeInterval];
        
        UserModel *model = array.lastObject;
    
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"请输入大侠的昵称";
            textField.text = self.userName;
        }];
        
        __weak SaoleiViewController *weakSelf = self;
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            NSString *userName = alert.textFields.firstObject.text;
            
            [[NSUserDefaults standardUserDefaults] setObject:userName forKey:@"userName"];
            
            if (userName.length == 0) {
                userName = @"默认";
            }
            if (array.count >= 5) {
                [[SaveHandle shareSaveHandle] deleteWithID:model.id_vierfy];
            }
            
            self.randomNum = arc4random()%10000 + 1;
            
            [[SaveHandle shareSaveHandle] saveWithUsrName:userName andUserTime:weakSelf.timeInterval andDifficulty:weakSelf.difficulty RandomNum:self.randomNum];
        }]];
        
    }else {
        message = [NSString stringWithFormat:@"你赢得了%@模式,完成比赛所用时间为%ld秒",difficulty,self.timeInterval];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil]];
    }
    
    alert.message = message;
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)loseGame {
    self.headerView.restartKind = RestartKindLose;
    
    [self.saoleiView showAll];
    
    self.saoleiView.userInteractionEnabled = NO;
    
    [self timerEnd];
}

/**
 *  返回按钮周围一圈按钮的数组
 */
- (NSArray <__kindof SaoleiChessView *> *)getButtonsAroundSender:(SaoleiChessView *)sender {
    NSMutableArray *array = [NSMutableArray array];
    
    NSInteger x = sender.position.x;
    
    NSInteger y = sender.position.y;
    
    for (int y1 = 0; y1 < 3; y1 ++) {
        for (int x1 = 0; x1 < 3; x1 ++) {
            SaoleiChessView *chess = [self.saoleiView viewWithPostion:[Position positionWithX:x - 1 + x1 andY:y - 1 +y1]];
            if (chess && ![chess isEqual:sender] && [chess isKindOfClass:[SaoleiChessView class]]) {
                [array addObject:chess];
            }
        }
    }
    
    return array;
}
/**
 *  该按钮设置周围雷的数量
 */
- (void)setNumberOfLeiToSender:(SaoleiChessView *)sender {
    NSArray *array = [self getButtonsAroundSender:sender];
    
    if (!sender.isLei) {
        for (SaoleiChessView *item in array) {
        
            if (item.isLei) {
                sender.numberOfLei ++;
            }
        }
    }
}
/**
 *  设置雷的数量
 *
 *  @param number
 */
- (void)setLeiNumber:(NSInteger)number andFirstPosition:(Position  *)position{
    NSMutableArray *array = [NSMutableArray array];
    
    while (number) {
        NSInteger x = arc4random() % self.saoleiView.numberOfChessInLine + 1;
        
        NSInteger y = arc4random() % self.saoleiView.numberOfChessInList + 1;
        
        if (position.x == x && position.y == y) {
            continue;
        }else {
            Position *p = [Position positionWithX:x andY:y];
            
            if ([array containsObject:p]) {
                continue;
            } else {
                [array addObject:p];
            }
        }
        number --;
    }
    for (Position *p in array) {
        SaoleiChessView *chess = [self.saoleiView viewWithPostion:p];

        chess.isLei = YES;
    }
    
    for (SaoleiChessView *chess in self.saoleiView.subviews) {
        [self setNumberOfLeiToSender:chess];
    }
}
/**
 *  设置有多少个雷的时候更换显示
 */
- (void)setNumberOfLeiExist:(NSInteger)numberOfLeiExist {
    _numberOfLeiExist = numberOfLeiExist;
    
    self.headerView.numberOfLeiView.numberInImage = numberOfLeiExist;
}
/**
 *  设置过了多长时间
 */
- (void)setTimeInterval:(NSInteger)timeInterval {
    _timeInterval = timeInterval;
    
    self.headerView.timeOfLeiView.numberInImage = timeInterval;
}

- (void)setNumberOfLei:(NSInteger)numberOfLei {
    _numberOfLei = numberOfLei;
    
    self.numberOfLeiExist = numberOfLei;
}

- (void)setDifficulty:(KindOfUserDifficulty)difficulty {
    _difficulty = difficulty;
    
    [[NSUserDefaults standardUserDefaults] setObject:@(difficulty) forKey:@"difficulty"];
    
    switch (difficulty) {
        case KindOfUserDifficultyNormal:{
            self.saoleiView.numberOfChessInLine = 16;
            self.saoleiView.numberOfChessInList = 16;
            self.numberOfLei = 40;
            self.title = @"中等难度";
            
            break;
        }
        case KindOfUserDifficultyEasy:{
            self.saoleiView.numberOfChessInLine = 9;
            self.saoleiView.numberOfChessInList = 9;
            self.numberOfLei = 10;
            self.title = @"简单难度";
            
            break;
        }
    }
    [self.saoleiView resetView];
}


@end
