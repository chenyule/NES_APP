//
//  ViewController.m
//  NewsApp
//
//  Created by 陈玉乐 on 2018/6/12.
//  Copyright © 2018年 陈玉乐. All rights reserved.
//

#import "ViewController.h"
#import "NESViewController.h"

#import "TabHeader.h"

@interface  TestModel : NSObject

@property(copy,nonatomic) NSString *title;
@property(strong,nonatomic) UIViewController *vc;

@end

@implementation TestModel


@end


@interface ViewController ()<ManegerViewDataSource>


@property(strong,nonatomic) NSArray *modelArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"新闻app";
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat y = CGRectGetHeight(self.navigationController.navigationBar.frame) + CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
    
    CGFloat h = CGRectGetHeight(self.view.frame) - y - (KIsiPhoneX ? 34 : 0);
    
    ManegerView *manegerView = [[ManegerView alloc] initWithFrame:CGRectMake(0, y, self.view.frame.size.width, h) currentViewController:self manegerViewDataSource:self];
    
    [self.view addSubview:manegerView];
    
    [manegerView loadViews];
    

}

-(NSArray *)modelArray{
    
    
    if (!_modelArray) {
        
        TestModel *testModel1 = [[TestModel alloc] init];
        testModel1.title = @"刀塔二";
        testModel1.vc = [NESViewController new];
        
        TestModel *testModel2 = [[TestModel alloc] init];
        testModel2.title = @"撸啊撸";
        testModel2.vc = [NESViewController new];
        
        TestModel *testModel3 = [[TestModel alloc] init];
        testModel3.title = @"大吉大利今晚吃鸡";
        testModel3.vc = [NESViewController new];
        
        TestModel *testModel4 = [[TestModel alloc] init];
        testModel4.title = @"王者荣耀";
        testModel4.vc = [NESViewController new];
        
        TestModel *testModel5 = [[TestModel alloc] init];
        testModel5.title = @"为了联盟";
        testModel5.vc = [NESViewController new];
        
        TestModel *testModel6 = [[TestModel alloc] init];
        testModel6.title = @"兽人永不为奴";
        testModel6.vc = [NESViewController new];
        
        TestModel *testModel7 = [[TestModel alloc] init];
        testModel7.title = @"倩女幽魂";
        testModel7.vc = [NESViewController new];
        
        TestModel *testModel8 = [[TestModel alloc] init];
        testModel8.title = @"绝地反击";
        testModel8.vc = [NESViewController new];
        
        _modelArray = @[testModel1,testModel2,testModel3,testModel4,testModel5,testModel6,testModel7,testModel8];
    }
    
    return _modelArray;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma - ManegerViewDataSource


//不需要header 可以注释 下面代码
-(UIView *)headerView{

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 180)];
    view.backgroundColor = [UIColor greenColor];
    return view;

}

//可注释
-(ManagerConfig *)managerConfig{
    
    ManagerConfig *managerConfig = [ManagerConfig new];
    managerConfig.tabHeight = @(44);
    return managerConfig;
}


-(NSInteger )numberOfPage{
    
    return self.modelArray.count;
}

-(NSString *)pageTitleAtIndex:(NSInteger)index{
    
    TestModel *testModel = self.modelArray[index];
    return testModel.title;
    
}
-(UIViewController *)viewControllerAtIndex:(NSInteger )index{
    
    TestModel *testModel = self.modelArray[index];
    testModel.vc.title = testModel.title;
    return testModel.vc;
}

@end
