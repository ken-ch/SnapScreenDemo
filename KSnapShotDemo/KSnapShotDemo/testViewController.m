//
//  testViewController.m
//  KSnapShotDemo
//
//  Created by mac on 2018/11/2.
//  Copyright © 2018 mac. All rights reserved.
//

#import "testViewController.h"
#import "UIView+KSnap.h"
#import "UITableView+KSnap.h"


@interface testViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *testTableView;

@property(nonatomic,strong)NSMutableArray *testArray;

@end

@implementation testViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    header.backgroundColor = [UIColor redColor];
    [self.view addSubview:header];
    [self.view addSubview:self.testTableView];
    
    [self makeTestInfo];
    
    self.title = @"snap test";
   
    [self configScreenShotBtn:^{

        [self showScreenShotWithTopImg:header.screenShotImage andBottomImg:self.testTableView.tableShotImage];
        
    }];
    
    
    self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
    UIBarButtonItem *anotherButton2 = [[UIBarButtonItem alloc] initWithCustomView:self.snapBtn];
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:anotherButton2,nil]];

    
    
}

-(void)makeTestInfo{
    for (int i = 0; i < 100; i++) {
        NSString *str = [NSString stringWithFormat:@"测试数据：%d",i];
        [self.testArray addObject:str];
    }
    [self.testTableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.testArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *YSMsgreuseID = @"testID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YSMsgreuseID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:YSMsgreuseID];
        cell.textLabel.text = self.testArray[indexPath.row];
    }
    
    return cell;
}


-(UITableView *)testTableView{
    if (!_testTableView) {
        _testTableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 120, self.view.frame.size.width, self.view.frame.size.height)];
        _testTableView.delegate = self;
        _testTableView.dataSource = self;
        _testTableView.rowHeight = 60;
    }
    return _testTableView;
}

- (NSMutableArray *)testArray{
    if (!_testArray) {
        _testArray = [[NSMutableArray alloc]init];
    }
    return _testArray;
}

@end
