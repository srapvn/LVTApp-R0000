

#import "BookViewChapter1.h"


@implementation BookViewChapter1


- (void) setListChapter:(NSMutableArray*) list{
	ListChapter = list;
}

- (void) changeTitle:(int) chapterid{
	self.title = [ListChapter objectAtIndex:chapterid];
}

- (IBAction)SwitchFullscreen {

	self.navigationController.navigationBar.hidden = !(self.navigationController.navigationBar.hidden);
	BottomBar.hidden = !(BottomBar.hidden);
	
	//myImageObj.frame = CGRectMake(position.X, position.Y, size.width, size.height);
    //myImageObj.CGImage.frame.y = position.Y;
	if (BottomBar.hidden) { 
		TextView.frame = CGRectOffset(TextView.frame, 0, -40);
		TextView.frame = CGRectMake(TextView.frame.origin.x, TextView.frame.origin.y, 320, 480);
	}
	else {
		TextView.frame = CGRectOffset(TextView.frame, 0, 40);
		TextView.frame = CGRectMake(TextView.frame.origin.x, TextView.frame.origin.y, 320, 400);
	}
}
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    
	//self.navigationController.navigationBar.hidden = FALSE;
	
	//Set delegate cho chapterview la rootview
	[self.view setdelegate:self];
	
	

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	self.navigationController.navigationBar.hidden = FALSE;
	
	[self.view checkRestoreMark];
	
	//[self performSelector:@selector(doTHis) withObject:nil afterDelay:0.5];
	
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	[ListChapter release];
}


- (void)dealloc {
    [super dealloc];
}


@end
