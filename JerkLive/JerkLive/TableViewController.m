//
//  TableViewController.m
//  JerkLive
//
//  Created by YuXiang on 2017/4/28.
//  Copyright © 2017年 Rookie.YXiang. All rights reserved.
//

#import "TableViewController.h"
#import "VLCAddress.h"
#import "ViewController.h"
@interface TableViewController ()
@property (nonatomic, strong) NSMutableArray *radioListArr;
@property (nonatomic, strong) NSMutableArray *radioUrlArr;

@end

@implementation TableViewController

- (NSMutableArray *)radioListArr {
    if (!_radioListArr) {
        _radioListArr = [NSMutableArray array];
    }
    return _radioListArr;
}

- (NSMutableArray *)radioUrlArr {
    if (!_radioUrlArr) {
        _radioUrlArr = [NSMutableArray array];
    }
    return _radioUrlArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellID"];
    
}

- (void)loadData {
    NSDictionary *dataDic = [[VLCAddress sharedInstance] loadVLCUrlAddress];
    
    [self.radioListArr addObjectsFromArray:dataDic.allKeys];
    [self.radioUrlArr addObjectsFromArray:dataDic.allValues];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.radioListArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID" forIndexPath:indexPath];
    
    cell.textLabel.text = self.radioListArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *sbVC = [sb instantiateViewControllerWithIdentifier:@"ViewController"];
    ViewController *vc  = (ViewController *)sbVC;
    vc.vlcUrlStr = self.radioUrlArr[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
