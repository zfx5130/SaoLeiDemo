//
//  PaihangViewController.m
//  text
//
//  Created by hanlu on 16/8/4.
//  Copyright © 2016年 吴迪. All rights reserved.
//

#import "PaihangViewController.h"
#import "PaihangTableViewCell.h"
#import "SaveHandle.h"

@interface PaihangViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *dataArray;

@end

@implementation PaihangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = ({
        UITableView *table = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        
        table.delegate = self;
        
        table.dataSource = self;
        
        [table registerNib:[UINib nibWithNibName:@"PaihangTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
        
        table;
    });
    
    [self.view addSubview:_tableView];
}


- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[SaveHandle shareSaveHandle] findModelWithDifficulty:_difficulty];
    }
    return _dataArray;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PaihangTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    
    cell.model = _dataArray[indexPath.row];
    
    if (cell.model.randomNum == self.randomNum) {
        cell.backgroundColor = [UIColor yellowColor];
    }else {
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    cell.ranking = indexPath.row + 1;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self dismissViewControllerAnimated:YES completion:nil];
}
//重置本控制器的大小
-(CGSize)preferredContentSize{
    
    if (self.popoverPresentationController != nil) {
        CGSize tempSize ;
        tempSize.height = self.view.frame.size.height;
        tempSize.width  = [UIScreen mainScreen].bounds.size.width / 2;
        CGSize size = [_tableView sizeThatFits:tempSize];  //返回一个完美适应tableView的大小的 size
        return size;
    }else{
        return [super preferredContentSize];
    }
    
}
@end
