    //
//  ItemDataViewController.m
//  CoreDataMsster
//
//  Created by Manuel Betancurt on 14/07/11.
//  Copyright 2011 HYPER. All rights reserved.
//

#import "ItemDataViewController.h"
#import "Parser.h"
#import "RSSdetail.h"



@interface ItemDataViewController (PrivateMethods)
- (void)loadData;
@end 


@implementation ItemDataViewController

@synthesize ViewDataReceive;
@synthesize textName;
@synthesize activityIndicator, items;
@synthesize tableViewRSS;


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	NSLog(@"arrive: %@", ViewDataReceive);
	//NameLbl.text = ViewDataReceive;
	textName.text = ViewDataReceive;
 	
	/*
	UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	indicator.hidesWhenStopped = YES;
	[indicator stopAnimating];
	self.activityIndicator = indicator;
	[indicator release];
	
	UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:indicator];
	self.navigationItem.rightBarButtonItem = rightButton;
	[rightButton release];
 */
	
	tableViewRSS = [[UITableView alloc] initWithFrame:CGRectMake(110, 269, 320, 247)
					  //					  
												  style:UITableViewStylePlain];
	
    tableViewRSS.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
	
    tableViewRSS.delegate = self;
	
    tableViewRSS.dataSource = self;
	
    //[tableView reloadData];
	
	
 	
    [self.view addSubview: tableViewRSS];
	
	[tableViewRSS release];
	 }


- (void)viewDidAppear:(BOOL)animated {
	[self loadData];
    [super viewDidAppear:animated];
}

- (void)loadData {
	if (items == nil) {
		[activityIndicator startAnimating];
		
		Parser *rssParser = [[Parser alloc] init];
		//[rssParser parseRssFeed:@"http://feeds2.feedburner.com/TheMdnShow" withDelegate:self];
		
		[rssParser parseRssFeed:@"http://feeds.feedburner.com/hyperprogram/ngmM" withDelegate:self];
		
		[rssParser release];
		
	} else {
		[tableViewRSS reloadData];
 	}
	
}

- (void)receivedItems:(NSArray *)theItems {
	items = theItems;
	[tableViewRSS reloadData];
	[activityIndicator stopAnimating];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [items count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
	// Configure the cell.
	
	cell.textLabel.text = [[items objectAtIndex:indexPath.row] objectForKey:@"title"];
	
	// Format date
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];	
	[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
	[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
	
	cell.detailTextLabel.text = [dateFormatter stringFromDate:[[items objectAtIndex:indexPath.row] objectForKey:@"date"]];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
    return cell;
}




// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSDictionary *theItem = [items objectAtIndex:indexPath.row];
	//RSSdetail *nextController = [[RSSdetail alloc] initWithItem:theItem];
	//[self.navigationController pushViewController:nextController animated:YES];
	//[nextController release];
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];

	NSLog(@"saliendo a otra visata con : %@", theItem);
	
	
	//load the view in a modal window sliding up!
	RSSdetail *viewControllerData = [[RSSdetail alloc] initWithNibName:nil bundle:nil];
	
//	viewControllerData.ViewDataReceive = MessageToViewData; //send the message to the viewController
	viewControllerData.item = theItem; //send the message to the viewController

	
	viewControllerData.modalPresentationStyle = UIModalPresentationFormSheet;
	[self presentModalViewController:viewControllerData animated:YES];
	
 /*	
	MessageToViewData = info.item;
	ItemDataViewController *message  = [ItemDataViewController alloc];
	NSLog(@"the zender:%@",MessageToViewData);
	message.ViewDataReceive = MessageToViewData;
	
	NSLog(@"going  :%@",message.ViewDataReceive);
	
	//load the view in a modal window sliding up!
	ItemDataViewController *viewControllerData = [[ItemDataViewController alloc] initWithNibName:nil bundle:nil];
	
	viewControllerData.ViewDataReceive = MessageToViewData; //send the message to the viewController
	
	viewControllerData.modalPresentationStyle = UIModalPresentationFormSheet;
	[self presentModalViewController:viewControllerData animated:YES];*/
	
	
	
}


-(IBAction) cancel:(id) sender {
	[self dismissModalViewControllerAnimated:YES];
	
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
