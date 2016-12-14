//
//  SaoleiNumberOrTimeImageView.m
//  text
//
//  Created by hanlu on 16/8/2.
//  Copyright © 2016年 吴迪. All rights reserved.
//

#import "SaoleiNumberOrTimeImageView.h"

@interface SaoleiNumberOrTimeImageView ()
/**
 *  百位上的图片
 */
@property (nonatomic,strong) UIImageView *hundredsImageView;
/**
 *  十位上的图片
 */
@property (nonatomic,strong) UIImageView *decadeImageView;
/**
 *  个位上的图片
 */
@property (nonatomic,strong) UIImageView *unitImageView;


@end


@implementation SaoleiNumberOrTimeImageView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    CGFloat width = CGRectGetWidth(self.frame) / 3;
    
    CGFloat height = CGRectGetHeight(self.frame);
    
    _hundredsImageView = [self setImageViewWithFrame:CGRectMake(0, 0, width, height)];
    
    [self addSubview:_hundredsImageView];
    
    _decadeImageView = [self setImageViewWithFrame:CGRectMake(width, 0, width, height)];
    
    [self addSubview:_decadeImageView];
    
    _unitImageView = [self setImageViewWithFrame:CGRectMake(width * 2, 0, width, height)];
    
    [self addSubview:_unitImageView];
}

- (UIImageView *)setImageViewWithFrame:(CGRect)frame {
    UIImageView *image = [[UIImageView alloc] initWithFrame:frame];
    
    image.image = [UIImage imageNamed:@"classic_numbers_0"];
    
    return image;
}

- (void)setNumberInImage:(NSInteger)numberInImage {
    _numberInImage = numberInImage;
    
    if (!_showLineImage) {
        
        if (numberInImage >= 0 || numberInImage <= -100) {
            numberInImage = labs(numberInImage);
            
            NSInteger hundred = numberInImage / 100;
            
            NSInteger ten = numberInImage % 100 / 10;
            
            NSInteger one = numberInImage % 10;
            
            [self.hundredsImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"classic_numbers_%ld",hundred]]];
            
            [self.decadeImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"classic_numbers_%ld",ten]]];
            
            [self.unitImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"classic_numbers_%ld",one]]];
        } else {
            NSInteger zhengshu = -numberInImage;
            
            NSInteger ten = zhengshu % 100 / 10;
            
            NSInteger one = zhengshu % 10;
            
            [self.hundredsImageView setImage:[UIImage imageNamed:@"classic_numbers_-"]];
            
            [self.decadeImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"classic_numbers_%ld",ten]]];
            
            [self.unitImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"classic_numbers_%ld",one]]];
        }
        
        
    }
}

- (void)setShowLineImage:(BOOL)showLineImage {
    _showLineImage = showLineImage;
    
    if (_showLineImage) {
        [self.hundredsImageView setImage:[UIImage imageNamed:@"classic_numbers_-"]];
        
        [self.decadeImageView setImage:[UIImage imageNamed:@"classic_numbers_-"]];
        
        [self.unitImageView setImage:[UIImage imageNamed:@"classic_numbers_-"]];
    }
}
@end
