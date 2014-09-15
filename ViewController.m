//
//  ViewController.m
//  PointTestTest
//
//  Created by 滝花　悠介 on 2014/08/24.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *canvas;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showArray {
    // 配列に数値を格納する
    NSMutableArray *array = [NSMutableArray array];
    
    CGPoint test[4] = {
        CGPointMake(0.0, 0.0),
        CGPointMake(50.0, 10.0),
        CGPointMake(10.0, 15.0),
        CGPointMake(10.0, 15.0)
    };
    
    // NSValueにCGPoint型の構造体をセット
    NSValue *value0 = [NSValue valueWithCGPoint:test[0]];
    NSValue *value1 = [NSValue valueWithCGPoint:test[1]];
    NSValue *value2 = [NSValue valueWithCGPoint:test[2]];
    NSValue *value3 = [NSValue valueWithCGPoint:test[3]];
    
    
    [array addObject:value0];
    [array addObject:value1];
    [array addObject:value2];
    [array addObject:value3];
    
    NSLog(@"%@", array);
    
    NSValue* value = [array objectAtIndex:0];
    CGPoint point2 = [value CGPointValue];
    
    UIGraphicsBeginImageContextWithOptions(self.canvas.frame.size, YES, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.canvas.image drawInRect:self.canvas.bounds];
    CGContextSetLineWidth(context, 10.0f);
    CGContextSetRGBStrokeColor(context, 255, 0, 0, 50);
    

    
    CGPoint points[4];
    
    int i=0;
    for (NSValue *value in array) {
        points[i++] = [value CGPointValue];
    }
    
     //NSLog(@"%@", points);
    for(int i = 0 ; i < 4;i++){
    
        //CGContextMoveToPoint(context,points[i].x,points[i].y);
        //CGContextAddLineToPoint(context,points[3-i].x, points[3-i].y);
        
        CGContextMoveToPoint(context,0,0);
        CGContextAddLineToPoint(context,100, 100);
        
        
        //CGContextAddLines(context, points, 4);
        CGContextStrokePath(context);
        
        NSLog(@"%f", points[i].x);
        NSLog(@"%f", points[i].y);
        NSLog(@"%f", points[3-i].x);
        NSLog(@"%f", points[3-i].y);
       
       
    }
     self.canvas.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();}

@end
