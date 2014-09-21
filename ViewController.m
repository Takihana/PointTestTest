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

@property  NSMutableArray *TouchArray;
@property (assign, nonatomic) Boolean flag;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.flag = false;
    self.TouchArray = [NSMutableArray array];

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
        CGPointMake(10, 100),
        CGPointMake(150, 30),
        CGPointMake(15, 150),
        CGPointMake(100, 200)
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
    
        CGContextMoveToPoint(context,points[i].x,points[i].y);
        CGContextAddLineToPoint(context,points[3-i].x, points[3-i].y);
        
        //CGContextMoveToPoint(context,100,1000);
        //CGContextAddLineToPoint(context,300, 300);
        
        
        //CGContextAddLines(context, points, 4);
        CGContextStrokePath(context);
        
        NSLog(@"%f", points[i].x);
        NSLog(@"%f", points[i].y);
        NSLog(@"%f", points[3-i].x);
        NSLog(@"%f", points[3-i].y);
       
       
    }
     self.canvas.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{// シングルタッチの場合
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.canvas];
    NSLog(@"x:%f y:%f", location.x, location.y);
    
   // NSMutableArray *toucharray = [NSMutableArray array];

    //タッチした座標をプロパティで保持できる形にする
    NSValue *value = [NSValue valueWithCGPoint:location];
    
    //一回目は線を引かない
    if(self.flag == false){
    
        [self.TouchArray addObject:value];
        
        self.flag = true;
        
    }
    else
    {
        //線を引く処理開始
        [self.TouchArray addObject:value];
        
        // 2014/09/21 キャンパス(後ろの画像)が消えてしまうバグと原点から線を引いてしまっている
        //self.canvas.image = [UIImage imageNamed:@"canvas"];
        
        //線を引くための頂点を格納する配列(現在は固定長だが可変長にすること)
        
        NSValue* value = [self.TouchArray objectAtIndex:0];
        CGPoint points[100];
        
        //線を引くための頂点を取得
        int j=0;
        for (NSValue *value in self.TouchArray) {
            points[j++] = [value CGPointValue];
        }
        
        UIGraphicsBeginImageContextWithOptions(self.canvas.frame.size, YES, 0.0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [self.canvas.image drawInRect:self.canvas.bounds];
        CGContextSetLineWidth(context, 10.0f);
        CGContextSetRGBStrokeColor(context, 255, 0, 0, 50);
        
        for(int i = 0 ; i < j;i++){
            
            CGContextMoveToPoint(context,points[i].x,points[i].y);
            CGContextAddLineToPoint(context,points[i+1].x, points[i+1].y);
            
            //CGContextMoveToPoint(context,100,1000);
            //CGContextAddLineToPoint(context,300, 300);
            
            
            //CGContextAddLines(context, points, 4);
            CGContextStrokePath(context);
            
            //NSLog(@"%f", points[i].x);
            //NSLog(@"%f", points[i].y);
            //NSLog(@"%f", points[j-i].x);
            //NSLog(@"%f", points[j-i].y);
            
            
        }
        self.canvas.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        
        
    
    }
    
    
    
}

@end
