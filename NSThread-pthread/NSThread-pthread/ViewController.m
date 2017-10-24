//
//  ViewController.m
//  NSThread-pthread
//
//  Created by soliloquy on 2017/8/10.
//  Copyright © 2017年 soliloquy. All rights reserved.
//

#import "ViewController.h"
#import <pthread.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /*
     如果CPU现在调度当前线程对象，则当前线程对象进入运行状态，如果CPU调度其他线程对象，则当前线程对象回到就绪状态。
     如果CPU在运行当前线程对象的时候调用了sleep方法\等待同步锁，则当前线程对象就进入了阻塞状态，等到sleep到时\得到同步锁，则回到就绪状态。
     如果CPU在运行当前线程对象的时候线程任务执行完毕\异常强制退出，则当前线程对象进入死亡状态。
        见图: http://upload-images.jianshu.io/upload_images/1877784-18eab813719d579d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240
     */

}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self threadDemo4];
}



//隐式创建并启动线程
- (void)threadDemo4 {

    /*
        任务后台执行, 即开启一个子线程
     */
//    [self performSelectorInBackground:@selector(thread:) withObject:@"performSelectorInBackground"];
    
    /*
        第二个参数: NO: 不用等待全面的代码执行完 就执行thread:函数
     */
    [self performSelectorOnMainThread:@selector(thread:) withObject:@"performSelectorOnMainThread" waitUntilDone:NO];
}

// 创建线程后自动启动线程
- (void)threadDemo3 {

    [NSThread detachNewThreadSelector:@selector(thread:) toTarget:self withObject:@"detach"];
    /*
     iOS10以上
     */
    //    [NSThread detachNewThreadWithBlock:^{
    //
    //    }];
}

// 线程一启动，就会在线程thread中执行self的run方法
- (void)threadDemo2 {

    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(thread:) object:@"要传入的值"];
    [thread start];

    /*
     iOS10以上
     */
//    NSThread *thread = [[NSThread alloc]initWithBlock:^{
//        for (NSInteger i = 0; i < 10; i++) {
//            NSLog(@"%zd -- %@",i, [NSThread currentThread]);
//        }
//    }];
//    [thread start];
}

- (void)thread:(id)param {
    NSLog(@"%@", param);
    for (NSInteger i = 0; i < 10; i++) {
        NSLog(@"%zd -- %@",i, [NSThread currentThread]);
        
//        if (i == 5) {
//            // 强制停止线程  线程进入死亡状态
//            [NSThread exit];
//        }
    }
}

// pthread的使用方法
- (void)threadDemo1 {
    // 创建线程——定义一个pthread_t类型变量
    pthread_t thread;
    // 开启线程——执行任务
    
    /**
     第一个参数&thread是线程对象
     第二个和第四个是线程属性，可赋值NULL
     第三个run表示指向函数的指针(run对应函数里是需要在新线程中执行的任务)
     */
    pthread_create(&thread, NULL, run, NULL);
}

void *run(void *param) {
    
    for (NSInteger i = 0; i < 10; i++) {
        
        NSLog(@"%zd -- %@",i, [NSThread currentThread]);
    }
    return NULL;
}

@end
