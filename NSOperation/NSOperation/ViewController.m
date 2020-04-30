//
//  ViewController.m
//  NSOperation
//
//  Created by Mac on 2020/4/30.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)download {
    
    NSLog(@"download-----%@", [NSThread currentThread]);
}

/// 1、NSInvocationOperation - 同步执行
- (IBAction)createNSInvocationSynchronousExecution {
    
     // 创建操作
    NSInvocationOperation *operation1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(download) object:nil];
    NSInvocationOperation *operation2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(download) object:nil];
    NSInvocationOperation *operation3 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(download) object:nil];
    
    // operation直接调用start，是同步执行（在当前线程执行操作）
    [operation1 start];
    [operation2 start];
    [operation3 start];
    
}

/// 2、NSInvocationOperation - 异步执行
- (IBAction)createNSInvocationOperationAsynchronousExecution {
    
    // 创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 创建操作
    NSInvocationOperation *operation1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(download) object:nil];
    
    NSInvocationOperation *operation2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(download) object:nil];
    
    NSInvocationOperation *operation3 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(download) object:nil];
    
    // 添加操作到队列中，会自动异步执行
    [queue addOperation:operation1];
    [queue addOperation:operation2];
    [queue addOperation:operation3];
}


/// 3、NSBlockOperation - 同步执行1
- (IBAction)createNSBlockOperationAsynchronousExecution1 {
    
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{

        NSLog(@"---下载图片----1---%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{

        NSLog(@"---下载图片----2---%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^{

        NSLog(@"---下载图片----3---%@", [NSThread currentThread]);
    }];
    
    [operation1 start];
    [operation2 start];
    [operation3 start];
    // 同步执行
}


/// 4、NSBlockOperation - 同步执行2
- (IBAction)createNSBlockOperationAsynchronousExecution2 {
    
    NSBlockOperation *operation = [[NSBlockOperation alloc] init];
    
    [operation addExecutionBlock:^{
        
        NSLog(@"---下载图片----1---%@", [NSThread currentThread]);
    }];
    
    [operation addExecutionBlock:^{
        
        NSLog(@"---下载图片----2---%@", [NSThread currentThread]);
    }];
    
    [operation addExecutionBlock:^{
        
        NSLog(@"---下载图片----3---%@", [NSThread currentThread]);
    }];
    
    [operation start];
    // 同步执行
}

/// 5、创建队列 - 异步执行
- (IBAction)createNSBlockOperationAsynchronousExecution3 {
    
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        
        NSLog(@"---下载图片----11---%@", [NSThread currentThread]);
    }];
    
    [operation1 addExecutionBlock:^{
        
        NSLog(@"---下载图片----12---%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        
        NSLog(@"---下载图片----2---%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^{
        
        NSLog(@"---下载图片----3---%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *operation4 = [NSBlockOperation blockOperationWithBlock:^{
        
        NSLog(@"---下载图片----4---%@", [NSThread currentThread]);
    }];
    
    // 1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 2.添加操作到队列中（自动异步执行）
    [queue addOperation:operation1];
    [queue addOperation:operation2];
    [queue addOperation:operation3];
    [queue addOperation:operation4];
}

/// 6、主队列 - 在主线程中同步执行
- (IBAction)createNSBlockOperationAsynchronousExecution4 {
    
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        
        NSLog(@"---下载图片----11---%@", [NSThread currentThread]);
    }];
    
    [operation1 addExecutionBlock:^{
        
        NSLog(@"---下载图片----12---%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        
        NSLog(@"---下载图片----2---%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^{
        
        NSLog(@"---下载图片----3---%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *operation4 = [NSBlockOperation blockOperationWithBlock:^{
        
        NSLog(@"---下载图片----4---%@", [NSThread currentThread]);
    }];
    
    // 主队列
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    
    // 2.添加操作到队列中（自动同步执行）
    [queue addOperation:operation1];
    [queue addOperation:operation2];
    [queue addOperation:operation3];
    [queue addOperation:operation4];
}




@end
