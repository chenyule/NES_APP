//
//  NESViewController.m
//  NewsApp
//
//  Created by 陈玉乐 on 2018/6/13.
//  Copyright © 2018年 陈玉乐. All rights reserved.
//

#import "NESViewController.h"

#import "TabHeader.h"

@interface NESViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic) UITableView *newsTabelView;

@end

@implementation NESViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.newsTabelView];
    self.contentScrollView = self.newsTabelView;
    
    
    //可添加 下拉刷新 上拉加载等
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView *)newsTabelView{
    
    if (!_newsTabelView) {
        
        CGFloat y = 44 + CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
        CGFloat h = CGRectGetHeight(self.view.frame) - y - (KIsiPhoneX ? 34 : 0) ;
        _newsTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, h) style:UITableViewStyleGrouped];
        _newsTabelView.dataSource = self;
        _newsTabelView.delegate = self;
    }
    
    return _newsTabelView;
}

-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    static NSString * identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [self.title stringByAppendingString:[NSString stringWithFormat:@"%@",@(indexPath.row)]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"第 %ld 行", indexPath.row + 1);
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return  60;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [UIView new];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}
-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1;
}

-(CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
