//
//  BookViewBookmarks.h
//  BookViewer
//
//  Created by Khanh Nguyen on 7/28/10.
//  Copyright 2010 KAIST. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookViewChapter1.h"

@interface BookViewBookmarks : UITableViewController {

	NSMutableArray *ListChapter;
	//NSMutableArray *bookmarkArray;
	int bmArray[100];
	int numberofBM;
}

@end
