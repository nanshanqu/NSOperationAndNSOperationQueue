//
//  ViewController.m
//  NSOperationQueue
//
//  Created by Mac on 2020/4/30.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark- function

/// 设置依赖
- (IBAction)dependencyOperation {
    
    /**
     假设有A、B、C、D四个操作，要求：
     1. 4个操作都异步执行
     2.操作D依赖于操作C
     3. 操作C依赖于操作B
     4. 操作B依赖于操作A
     */
    
    // 1.创建一个队列（非主队列）
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 2.创建4个操作
    NSBlockOperation *operationA = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"A-----%@", [NSThread currentThread]);
    }];
    
//    [operationA addExecutionBlock:^{
//
//        NSLog(@"A2---%@", [NSThread currentThread]);
//    }];
//
//    [operationA setCompletionBlock:^{
//
//        NSLog(@"AAAAA---%@", [NSThread currentThread]);
//    }];
    
    NSBlockOperation *operationB = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"B-----%@", [NSThread currentThread]);
    }];
    NSBlockOperation *operationC = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"C-----%@", [NSThread currentThread]);
    }];
    NSBlockOperation *operationD = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"D-----%@", [NSThread currentThread]);
    }];
    
    // 设置依赖
    [operationB addDependency:operationA];
    [operationC addDependency:operationB];
    [operationD addDependency:operationC];
    
    // 3.添加操作到队列中（自动异步执行任务）
    [queue addOperation:operationD];
    [queue addOperation:operationC];
    [queue addOperation:operationA];
    [queue addOperation:operationB];
}

/// 设置最大并发
- (IBAction)setMaxOperationCount {
    
    // 添加操作到队列中（自动异步执行任务，并发）
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下载图片1---%@", [NSThread currentThread]);
    }];
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下载图片2---%@", [NSThread currentThread]);
    }];
    NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下载图片3---%@", [NSThread currentThread]);
    }];
    NSBlockOperation *operation4 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下载图片4---%@", [NSThread currentThread]);
    }];
    NSInvocationOperation *operation5 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(download) object:nil];
    
    [self.queue addOperation:operation1];
    [self.queue addOperation:operation2];
    [self.queue addOperation:operation3];
    [self.queue addOperation:operation4];
    [self.queue addOperation:operation5];
    
    [self.queue addOperationWithBlock:^{
        NSLog(@"下载图片5---%@", [NSThread currentThread]);
    }];
    [self.queue addOperationWithBlock:^{
        NSLog(@"下载图片6---%@", [NSThread currentThread]);
    }];
    [self.queue addOperationWithBlock:^{
        NSLog(@"下载图片7---%@", [NSThread currentThread]);
    }];
    [self.queue addOperationWithBlock:^{
        NSLog(@"下载图片8---%@", [NSThread currentThread]);
    }];
    [self.queue addOperationWithBlock:^{
        NSLog(@"下载图片9---%@", [NSThread currentThread]);
    }];
    
//    [queue cancelAllOperations];
}



- (void)download
{
    NSLog(@"download---%@", [NSThread currentThread]);
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
    [self.queue cancelAllOperations]; // 取消队列中的所有任务（不可恢复）
}

#pragma mark- scrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self.queue setSuspended:YES]; // 暂停队列中的所有任务
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    [self.queue setSuspended:NO]; // 恢复队列中的所有任务
}

#pragma mark- lazying

- (NSOperationQueue *)queue {
    if (!_queue) {
        
        // 1.创建一个队列（非主队列）
        _queue = [[NSOperationQueue alloc] init];
        
        // 2.设置最大并发(最多同时并发执行3个任务)
        _queue.maxConcurrentOperationCount = 3;
    }
    return _queue;
}



@end
