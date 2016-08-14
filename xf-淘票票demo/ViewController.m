//
//  ViewController.m
//  xf-淘票票demo
//
//  Created by 朱晓峰 on 16/8/14.
//  Copyright © 2016年 朱晓峰. All rights reserved.
//

#import "ViewController.h"
#import "XFMovieBrowser.h"

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<XFMovieBrowserdelegate>

@property (nonatomic, strong, readwrite) XFMovieBrowser *movieBrowser;
@property (nonatomic, strong, readwrite) UILabel *titileLabel;
@property (nonatomic, strong, readwrite) NSMutableArray *movies;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"xf-淘票票影视资讯";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    
    [self setupSubviews];
}
- (void)setupSubviews
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"movies" ofType:@"plist"];
    NSArray *dictArray = [NSArray arrayWithContentsOfFile:filePath];
    
    NSMutableArray *movies = [NSMutableArray array];
    for (NSDictionary *dict in dictArray) {
        XFMovie *movie = [[XFMovie alloc] init];
        movie.name = dict[@"name"];
        movie.coverUrl = dict[@"coverUrl"];
        [movies addObject:movie];
    }
    self.movies = movies;
    
    XFMovieBrowser *movieBrowser = [[XFMovieBrowser alloc] initWithFrame:CGRectMake(0, 200, kScreenWidth, kMovieBrowserHeight) movies:self.movies currentIndex:1];
    movieBrowser.delegate = self;
    [self.view addSubview:movieBrowser];
    self.movieBrowser = movieBrowser;
    
    UILabel *titileLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 330, kScreenWidth, 50)];
    titileLabel.textAlignment = NSTextAlignmentCenter;
    titileLabel.textColor = [UIColor blackColor];
    titileLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:titileLabel];
    self.titileLabel = titileLabel;
}

#pragma mark - Delegate

- (void)movieBrowser:(XFMovieBrowser *)movieBrowser didSelectItemAtIndex:(NSInteger)index
{
    
    UIViewController *movieDetailVc = [[UIViewController alloc] init];
    movieDetailVc.view.backgroundColor = [UIColor whiteColor];
    movieDetailVc.title = ((XFMovie *)self.movies[index]).name;
    [self.navigationController pushViewController:movieDetailVc animated:YES];
}

- (void)movieBrowser:(XFMovieBrowser *)movieBrowser didChangeItemAtIndex:(NSInteger)index
{

    
    self.titileLabel.text = ((XFMovie *)self.movies[index]).name;
}

static NSInteger _lastIndex = -1;
- (void)movieBrowser:(XFMovieBrowser *)movieBrowser didEndScrollingAtIndex:(NSInteger)index
{
//    if (_lastIndex != index) {
//        NSLog(@"刷新---%@", ((XFMovie *)self.movies[index]).name);
//    }
    _lastIndex = index;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
