//
//  ViewController.m
//  Today
//
//  Created by shendong on 2017/2/21.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import "ViewController.h"
#import "AccountService.h"
#import "Account.h"

#import <AVOSCloud/AVOSCloud.h>
#import <DateTools/DateTools.h>
#import "TodayEvents.h"
#import "NSDate+events.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    Account *current = [Account currentUser];
    NSLog(@"current.id = %@",current.objectId);

    NSDate *ee = [NSDate today];
    NSLog(@"ee = %@",ee);
    
    
    NSDate *hh = [NSDate dateWithYear:[NSDate today].year month:[NSDate today].month day:1];
    NSString *dff  = [hh formattedDateWithFormat:@"yyyy-MM-dd HH:mm:ss" locale:[NSLocale currentLocale]];
    NSString *hh2 = [[hh dateByAddingMonths:1] formattedDateWithFormat:@"yyyy-MM-dd HH:mm:ss" locale:[NSLocale currentLocale]];
    NSLog(@"hh = %@,%@,%@",hh,dff,hh2);
    
//    [NSDate[NSDate dateWithYear:[NSDate today].year month:[NSDate today].month day:1]]
    
    


}

- (IBAction)daterpickerChanged:(UIDatePicker *)sender {
    NSLog(@"picker = %@",sender.date);
    
    NSLog(@"sender = %@",[sender.date formattedDateWithStyle:NSDateFormatterFullStyle locale:[NSLocale currentLocale]]);
    NSLog(@"sender = %@",[sender.date formattedDateWithFormat:@"yyyy-MM-dd HH:mm:ss" locale:[NSLocale currentLocale]]);
    NSLog(@"sender = %@",[[NSDate today] formattedDateWithFormat:@"yyyy-MM-dd HH:mm:ss" locale:[NSLocale currentLocale]]);
    NSLog(@"sender = %@",[[[NSDate today] dateByAddingDays:1] formattedDateWithFormat:@"yyyy-MM-dd HH:mm:ss" locale:[NSLocale currentLocale]]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tapAction:(id)sender {
    
    AVObject *object = [AVObject objectWithClassName:@"Account"];
    [object setObject:@"shendong" forKey:@"name"];
    [object setObject:@22 forKey:@"age"];
    [object setObject:@"M" forKey:@"gender"];
    [object save];
    
}
- (IBAction)deleteAction:(id)sender {

}
- (IBAction)changeAction:(id)sender {
    //退出登录
    [AVUser logOut];
}
- (IBAction)queryAction:(id)sender {
    AVQuery *query = [AVQuery queryWithClassName:@"TodayEvents"];
//    [query whereKey:@"gender" equalTo:@"M"]; //查询指定key值的
    NSArray *array =  [query findObjects];
    for (Account *account in array) {
        NSLog(@"name = %@",account.objectId);
    }
    NSLog(@"array = %lu",array.count);
}
#pragma mark - Events
- (IBAction)addEvents:(id)sender {
    TodayEvents *today = [TodayEvents event];
    [today setObject:@"读书" forKey:@"title"];
    [today setObject:@"科技想要什么，凯文凯利" forKey:@"contents"];
    [today setObject:[NSDate today]  forKey:@"beginDate"];
    [today setObject:[[NSDate date] dateByAddingHours:8]  forKey:@"endDate"];
    today.tag = @"Study";
    today.group = @"Home";
    [today save];
    
}
- (IBAction)deleteEvents:(id)sender {
}
- (IBAction)changeEvents:(id)sender {
    
    
    
    
}
- (IBAction)queryEvents:(id)sender {
//    AVQuery *query = [TodayEvents query];
//    [query whereKey:@"owner" equalTo:[Account currentUser]];
//    [query setLimit:10];
//    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
//            TodayEvents *events = objects.firstObject;
//            NSLog(@"begin =%@, end = %@",events.beginDate, events.endDate);
//    }];
    //查询今天的事件
    AVQuery *startQueryDate = [TodayEvents query];
    [startQueryDate whereKey:@"beginDate" greaterThan:[NSDate today]];
    AVQuery *endQueryDate = [TodayEvents query];
    [endQueryDate whereKey:@"endDate" lessThan:[[NSDate today] dateByAddingDays:1]];
    AVQuery *query = [AVQuery andQueryWithSubqueries:[NSArray arrayWithObjects:startQueryDate, endQueryDate, nil]];
    
    
    //查询接下来的一周
   // [endQueryDate whereKey:@"endDate" lessThan:[[NSDate today] dateByAddingWeeks:1];
    
    //查询当月
    
    
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        TodayEvents *events = objects.firstObject;
        NSLog(@"begin =%@, end = %@",events.beginDate, events.endDate);
    }];
}
- (void)test{
    //注册
    Account *account = [Account user];
    account.username = @"大东哥";
    account.password = @"123456";
    
    [account signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"注册成功");
        }else{
            NSLog(@"注册失败");
        };
    }];
}


@end
