//
//  ViewController.m
//  QueueTest
//
//  Created by Sophia Lee on 3/8/2016.
//  Copyright © 2016 Test. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
       
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 * 用异步函数往并发队列中添加任务
 * 创建 4 个新线程（并发关系），与调用线程异步
 */
- (IBAction)addTaskToConcurrentQueueUsingAsynMethod:(id)sender {
    dispatch_queue_t concurrentQueue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // add task to concurrent queue
    for (int index = 1; index <= 4; index++) {
        dispatch_async(concurrentQueue, ^{
            NSLog(@"Add %s %d, thread name = %@", __func__, index, [NSThread currentThread]);
            [NSThread sleepForTimeInterval:1];
        });
    }
    
    NSLog(@"Main Thread = %@", [NSThread mainThread]);
}

/*
 * 用异步函数往串行队列中添加任务
 * 创建一个线程（执行 4 个 task），与调用线程异步
 */
- (IBAction)addTaskToSerialQueueUsingAsynMethod:(id)sender {
    dispatch_queue_t serialQueque = dispatch_queue_create(__func__, NULL);
    
    for (int index = 1; index <= 4; index++) {
        dispatch_async(serialQueque, ^{
            NSLog(@"Add %s %d, thread name = %@", __func__, index, [NSThread currentThread]);
        });
    }
    
    NSLog(@"Main Thread = %@", [NSThread mainThread]);
}

/*
 * 用同步函数往并发队列中添加任务
 * 不会创建线程，失去并发队列并发功能，在调用线程中顺序执行 4 个任务
 */
- (IBAction)addTaskToCurrencyQueueUsingSynMethod:(id)sender {
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    for (int index = 1; index <= 4; index++) {
        dispatch_sync(concurrentQueue, ^{
            NSLog(@"Add %s %d, thread name = %@", __func__, index, [NSThread currentThread]);
            [NSThread sleepForTimeInterval:1];
        });
    }
    NSLog(@"Main Thread = %@", [NSThread mainThread]);
}

/*
 * 用同步函数往串行队列中添加任务
 * 不会创建线程，在调用线程中顺序执行 4 个任务
 */
- (IBAction)addTaskToSerialQueueUsingSynMethod:(id)sender {
    dispatch_queue_t serialQueue = dispatch_queue_create(__func__, NULL);
    
    for (int index = 1; index <= 4; index++) {
        dispatch_sync(serialQueue, ^{
            NSLog(@"Add %s %d, thread name = %@", __func__, index, [NSThread currentThread]);
            [NSThread sleepForTimeInterval:1];
        });
    }
    NSLog(@"Main Thread = %@", [NSThread mainThread]);
}

@end
