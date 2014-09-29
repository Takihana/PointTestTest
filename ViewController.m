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
@property  NSMutableArray *FromToArray;
@property (assign, nonatomic) Boolean flag;

//@property  UIView *uiView;
@property float x;
@property float y;



@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //初期フラグ
    self.flag = false;
    //線をつなぐための配列
    self.TouchArray = [NSMutableArray array];
    //直前のタッチした点とその前のものを確保する配列
    self.FromToArray = [NSMutableArray array];
    
    CGPoint org = CGPointMake(self.view.frame.size.width/2,
                              self.view.frame.size.height/2);
    
    CGPoint Init = CGPointMake(0,0);
    NSValue* InitPoint = [NSValue valueWithCGPoint:Init];
    
    [self.TouchArray addObject:InitPoint];
    [self.TouchArray addObject:InitPoint];
    
    NSLog(@"org.x:%f org.y:%f", org.x, org.y);
    
    self.x = org.x;
    self.y = org.y;
    
    //self.uiView = [[UIView alloc] initWithFrame:CGRectMake(org.x,org.y,100,100)];
    //self.uiView.backgroundColor = [UIColor redColor];  //分かりやすいように色付け
    //[self.view addSubview:self.uiView];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 /*- (IBAction)showArray {
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
*/

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{// シングルタッチの場合
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.canvas];
    
    NSLog(@"location.x:%f location.y:%f", location.x, location.y);
    
    //座標の周りに領域を作る。今回は決めうちしているが、本来は座標の配列分繰り返して判定する。
    CGRect rc = CGRectMake(300,300,100,100);
    
    if(CGRectContainsPoint(rc,location)){
    //if(CGRectContainsPoint(self.uiView.frame,location)){
         NSLog(@"this touch!");
        
        location.x=300;
        location.y=300;
        
        
    }
    
    
    //float x = location.x - org.x;
    //float y = -(location.y - org.y);
    // 距離rを求める
    //float r = sqrt(x*x + y*y);
    //NSLog(@"距離：%f", r);
    
    //if(r <= 200) {
    //    location.x = org.x;
    //    location.y = org.y;
    //
    //    NSLog(@"変化後.x:%f 変化後.y:%f", location.x, location.y);
    //
    //}
    
    
    
    // NSMutableArray *toucharray = [NSMutableArray array];
    NSValue *value = [NSValue valueWithCGPoint:location];
    NSValue *FromTovalue = [NSValue valueWithCGPoint:location];
    
    //一回目は線を引かない
    if(self.flag == false){
    
        [self.TouchArray addObject:value];
        [self.FromToArray addObject:FromTovalue];
        self.flag = true;
        
        
        
    }
    else
    {
        //線を引く処理開始
        
        //タッチした座標をプロパティで保持できる形にする
        
        [self.TouchArray addObject:value];
        [self.FromToArray addObject:FromTovalue];
        
   /*     //今回選択した始点と終点を取得（用意）
        NSValue* Fromto = [self.FromToArray objectAtIndex:0];
        CGPoint FromToPoint[2];
        
         //今回選択した始点と終点を取得
        int w = 0;
        for(NSValue *Fromto in self.FromToArray){
            FromToPoint[w++] = [value CGPointValue];
        }

        
        if(self.TouchArray[0] != NULL){// != NULLだとすり抜ける
            //今までの線を引く座標の組み合わせを取得（用意）
            NSValue* check = [self.TouchArray objectAtIndex:0];
            CGPoint checkpoint[100];
                       //今までの線を引く座標の組み合わせを取得
            int checknum = 0;
            for(NSValue *check in self.TouchArray){
                checkpoint[checknum++] = [value CGPointValue];
            }
           
            
            for(int v = 0;v < checknum-1 ;v = v + 2){
            
                if(checkpoint[v].x == FromToPoint[0].x && checkpoint[v].y == FromToPoint[0].y){
                    if(checkpoint[v+1].x == FromToPoint[1].x && checkpoint[v+1].y == FromToPoint[1].y){
                    
                        self.TouchArray[v+1]=self.TouchArray[v];
                    
                    }
                
                }else if (checkpoint[v].x == FromToPoint[1].x && checkpoint[v].y == FromToPoint[1].y){
                    if(checkpoint[v+1].x == FromToPoint[0].x && checkpoint[v+1].y == FromToPoint[0].y){
                        self.TouchArray[v+1]=self.TouchArray[v];
                    }
                
                }
            
            }
        }
        
        //FromToPointが同じ座標になってしまうため線が引けなくなってしまった
        NSValue *From = [NSValue valueWithCGPoint:FromToPoint[0]];
        NSValue *To   = [NSValue valueWithCGPoint:FromToPoint[1]];
        
        [self.TouchArray addObject:From];
        [self.TouchArray addObject:To];
        [self.FromToArray removeObject:0];
        [self.FromToArray removeObject:0];
        
        */
        
        // 2014/09/21 キャンパス(後ろの画像)が消えてしまうバグと原点から線を引いてしまっている
        // 2014/09/23 キャンパスの後ろの画像は右側の使った画面の名前を指定すること
        //             原点から線を引いてしまうのはjと同じ回数だけまわすと配列が一つ足りなくなるため
        //            →　無事解決
        self.canvas.image = [UIImage imageNamed:@"Image"];
        
        //線を引くための頂点を格納する配列(現在は固定長だが可変長にすること)
        
        NSValue* value = [self.TouchArray objectAtIndex:0];
        CGPoint points[100];
        
        //線を引くための頂点を取得
        int j=0;
        for (NSValue *value in self.TouchArray) {
            points[j++] = [value CGPointValue];
        }
        
        // 線を引くキャンパスのサイズや不透明度、スケールを指定する
        UIGraphicsBeginImageContextWithOptions(self.canvas.frame.size, YES, 0.0);
        //指定したキャンパスの場所を取得
        CGContextRef context = UIGraphicsGetCurrentContext();
        // 今まで記述したものを描く（このシステムでは存在していないはず）
        [self.canvas.image drawInRect:self.canvas.bounds];
        // 描画する線の情報を記述
        CGContextSetLineWidth(context, 10.0f);
        CGContextSetRGBStrokeColor(context, 255, 0, 0, 50);
        
        // 線で一回目と二回目でタッチした所をつなぐ
        //for(int i = 0 ; i < j-1;i++){
        for(int i = 0 ; i < j-1 ; i = i + 2){
            // 始点と終点を設定
            CGContextMoveToPoint(context,points[i].x,points[i].y);
            CGContextAddLineToPoint(context,points[i+1].x, points[i+1].y);
            // 実際に線を描画
            CGContextStrokePath(context);
            
            //NSLog(@"%f", points[i].x);
            //NSLog(@"%f", points[i].y);
            //NSLog(@"%f", points[j-i].x);
            //NSLog(@"%f", points[j-i].y);
            
            
        }
        //描画した線を実際に画面に書き写す
        self.canvas.image = UIGraphicsGetImageFromCurrentImageContext();
        // メモリ領域を解放
        UIGraphicsEndImageContext();
        // フラグを一回目にする
        self.flag = false;
        
        
        
    
    }
    
    
    
}

@end
