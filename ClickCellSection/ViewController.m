//
//  ViewController.m
//  ClickCellSection
//
//  Created by mac on 16/7/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"

#define Screenwidth [UIScreen mainScreen].bounds.size.width
#define ScreennHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController (){
    UITableView *_tableView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //这个的目的是为了使得启动app时，单元格是收缩的
    for (int i=0; i<30; i++) {
        close[i] = YES;
    }
    //创建
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, Screenwidth, ScreennHeight) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];

}

//数据源方法的实现
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (close[section]) {
        return 0;
    }
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld组 第%ld行",indexPath.section,indexPath.row];
    
    return cell;
}

//组头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (close[section]) {
        
        return 0;
    }

    
        return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Screenwidth, 50)];
    [btn addTarget:self action:@selector(footSectionClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = 1000 + section;
    btn.backgroundColor = [UIColor blueColor];
    btn.highlighted = NO;

    [btn setTitle: [NSString stringWithFormat:@"%@",@"更多"] forState:UIControlStateNormal];
    return btn;

}

//创建组头视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Screenwidth, 50)];
    [btn addTarget:self action:@selector(sectionClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = 1000 + section;
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle: [NSString stringWithFormat:@"第%ld组",section] forState:UIControlStateNormal];
    
    return btn;
    
}


- (void)footSectionClick:(UIButton *)sender
{
}

-(void)sectionClick:(UIButton *)sender{
    
    //获取点击的组
    NSInteger i = sender.tag - 1000;
    //取反
    close[i] = !close[i];
    //刷新列表
    NSIndexSet * index = [NSIndexSet indexSetWithIndex:i];

    [_tableView reloadSections:index withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

@end
