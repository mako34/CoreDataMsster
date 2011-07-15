    //
//  RSSdetail.m
//  CoreDataMsster
//
//  Created by Manuel Betancurt on 15/07/11.
//  Copyright 2011 HYPER. All rights reserved.
//

#import "RSSdetail.h"


@implementation RSSdetail
@synthesize item;
@synthesize titleLbl, SummaryLbl, linkLbl, dateLbl;

- (id)initWithItem:(NSDictionary *)theItem {
	if (self = [super initWithNibName:@"Detail" bundle:nil]) {
		self.item = theItem;
		self.title = [item objectForKey:@"title"];
	}
	return self;
}


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
	NSLog(@"llego: %@",item);
	[self PopulateLbls];
    [super viewDidLoad];
}

-(void) PopulateLbls {

	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];	
	[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
	[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
	
	titleLbl.text = [item objectForKey:@"title"];
	SummaryLbl.text = [item objectForKey:@"summary"];
	linkLbl.text = [item objectForKey:@"link"];
	//dateLbl.text = [item objectForKey:@"date"];
	dateLbl.text = 	[dateFormatter stringFromDate:[item objectForKey:@"date"]];
	NSLog(@"date form>> %@",[dateFormatter stringFromDate:[item objectForKey:@"date"]]);

}

-(IBAction) SaveFeed:(id) sender{
	
}


-(IBAction) Back:(id) sender {
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
