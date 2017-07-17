//
//  ViewController.m
//  OC_Demo
//
//  Created by LUOSU on 2017/7/2.
//  Copyright © 2017年 LUOSU. All rights reserved.
//

#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT   ([UIScreen mainScreen].bounds.size.height)

#import "ViewController.h"
#import "ESPicPageView.h"
#import "PPBadgeView.h"

#import "Person.h"
#import "UIImage+image.h"
#import "NSObject+Property.h"
#import "NSObject+ModelDic.h"
#import "status.h"
#import "ScrollMenuView.h"



#import <objc/message.h>

@interface ViewController ()<UITextFieldDelegate, ScrollMenuViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *leftItem;
@property (nonatomic, strong) NSDictionary *statusDic;
@property (nonatomic, strong) Person *xiaoMing;



@end

@implementation ViewController

- (NSDictionary *)statusDic{
    if (!_statusDic) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Property List.plist" ofType:nil];
        _statusDic = [[NSDictionary alloc] initWithContentsOfFile:path];
    }
    return _statusDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;//防止出现scrollVIew的镂空
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSArray *images = @[@"image_0", @"image_1", @"image_2", @"image_3", @"image_4"];
    ESPicPageView *eSPicPageView = [[ESPicPageView alloc]initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, SCREEN_WIDTH / 2)];
    eSPicPageView.images = images;
    [self.view addSubview:eSPicPageView];
    
    [self.leftItem pp_addBadgeWithNumber:11];
    [self.navigationController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:68/255.0 green:173/255.0 blue:159/255.0 alpha:1]} forState:UIControlStateSelected];
    [self.navigationController.tabBarItem pp_addBadgeWithText:@"11+"];
    
    
    /*********************************** runtime ***********************************/
    // Person *p = [Person alloc];
    // 底层的实际写法
    Person *p = objc_msgSend(objc_getClass("Person"), sel_registerName("alloc"));
    p = objc_msgSend(p, sel_registerName("init"));
    // 调用对象方法（本质：让对象发送消息）
    //[p eat];
    objc_msgSend(p, @selector(eat));
    objc_msgSend(p, @selector(run:),20);
    
    UIImage *image = [UIImage imageNamed:@"image_0"];
//    NSObject *objc = [[NSObject alloc] init];
//    objc.name = @"123";
//    NSLog(@"runtime动态添加属性name==%@",objc.name);
  //  NSLog(@"%@", self.statusDic);
   
    
    status *sta = [status modelWithDict4:self.statusDic];
  //  NSLog(@"%@",sta);
    
    [p performSelector:@selector(run1:) withObject:@10];
    self.xiaoMing = [[Person alloc] init];
    [self answer];
    
    /*********************************** runtime 下Class的各项操zuo***********************************/
    unsigned int count = 0;
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (unsigned int i=0; i<count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
       // NSLog(@"property---->%@", [NSString stringWithUTF8String:propertyName]);
    }
    
    Method *methodList = class_copyMethodList([self class], &count);
    for (unsigned int i = 0; i<count; i++) {
        Method method = methodList[i];
       // NSLog(@"method---->%@", NSStringFromSelector(method_getName(method)));
    }
    //成员变量
    Ivar *ivarList = class_copyIvarList([self class], &count);
    for (unsigned int i = 0; i<count; i++) {
        Ivar myIvar = ivarList[i];
        const char *ivarName = ivar_getName(myIvar);
       // NSLog(@"Ivar---->%@", [NSString stringWithUTF8String:ivarName]);
    }
    
    //协议
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([self class], &count);
    for (unsigned int i = 0; i<count; i++) {
        Protocol *myProtocal = protocolList[i];
        const char *protocolName = protocol_getName(myProtocal);
        //NSLog(@"protocol---->%@", [NSString stringWithUTF8String:protocolName]);
    }
    
    [self getClassMethod];
    [self setMenuScrollBtnView];
}
- (int)test:(int)num
{
    while (num >= 10) {
        num = num/10 + num%10;
    }
    return num;
}
#pragma mark -- 设置一个滚动的菜单栏
- (void)setMenuScrollBtnView{
    NSArray *btnTitleArr = @[@"新闻",@"咨询",@"开心一刻",@"手机控",@"热点",@"南京",@"女人",@"视频"];
    ScrollMenuView *scrollBtnMenu = [[ScrollMenuView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    scrollBtnMenu.titleArray = btnTitleArr;
    scrollBtnMenu.menuViewdelegate = self;
    [self.view addSubview:scrollBtnMenu];
}




- (IBAction)leftAction:(id)sender {
    [self.leftItem pp_increase];
}

#pragma mark --获取类方法
- (void)getClassMethod
{
    Class PersonClass = object_getClass([Person class]);
    SEL oriSEL = @selector(test);
    Method oriMethod = class_getClassMethod([_xiaoMing class], oriSEL);
}

-(void)answer{
    unsigned int count = 0;
    Ivar *ivar = class_copyIvarList([self.xiaoMing class], &count);
    for (int i = 0; i<count; i++) {
        Ivar var = ivar[i];
        const char *varName = ivar_getName(var);
        NSString *name = [NSString stringWithUTF8String:varName];
        if ([name isEqualToString:@"_age"]) {
            object_setIvar(self.xiaoMing, var, @"20");
            break;
        }
    }
  //  NSLog(@"XiaoMing's age is %@",self.xiaoMing.age);
}

#pragma mark -- ScrollMenuViewDelegate
- (void)scrollMenuView:(ScrollMenuView *)scrollMenuView btnClickedIndex:(NSInteger)index{
    NSLog(@"点击了%ld", index);
}


@end
