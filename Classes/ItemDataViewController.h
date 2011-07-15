//
//  ItemDataViewController.h
//  CoreDataMsster
//
//  Created by Manuel Betancurt on 14/07/11.
//  Copyright 2011 HYPER. All rights reserved.
//

#import <UIKit/UIKit.h>
 

@interface ItemDataViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{

	UIActivityIndicatorView *activityIndicator;
	NSArray *items;
	
	
	
	NSString *ViewDataReceive;
 	
	IBOutlet UITextField *textName;
	
}

@property (nonatomic, retain) UITableView *tableViewRSS;


@property (retain, nonatomic) UIActivityIndicatorView *activityIndicator;
@property (retain, nonatomic) NSArray *items;

@property (retain) NSString *ViewDataReceive; //getter n setter
 @property (retain) 	IBOutlet UITextField *textName;
 



-(IBAction) cancel:(id) sender;

@end
