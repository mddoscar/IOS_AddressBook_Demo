//
//  ViewController.m
//  TestAddress
//
//  Created by mac on 16/2/27.
//  Copyright © 2016年 mddoscar. All rights reserved.
//

#import "ViewController.h"
//
#import "MddAddressSelectTableViewController.h"
@interface ViewController ()
{
   

}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self myInit];
}

-(void) myInit
{
    NSLog(@"hello");
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doAddressBook:(id)sender {
    UIViewController * tVc=[MddAddressSelectTableViewController initializeForNib];
    [self.navigationController pushViewController:tVc animated:YES];
}
@end
