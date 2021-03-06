XCell
=====

A better way to create efficient and performance centered UITableViews
----------------------------------------------------------------------

This library includes a framework that handles quickly generating a tableview populated with different kinds of cells.  It supports a few types of cells out of the box, with the ability to quickly create custom cells and populate your table's with those.  Using this library will:

* Split your UITableViewController from your UIViewController for better readability.
* Ensure maximum scrolling performance.
* Enable you to create UITableView's populated with cells very quickly.
* Handle some of the nitty gritty crap, like organizing a table's sections alphabetically.
* Handle editing textfields in cells, including scrolling the tableview for the keyboard.
* Work on iPhone/iTouch/iPad in all orientations.

**How to use this library**  
First, download the code, and include the XCode library in your source.

Next, create a UITableView on your view (don't use a UITableViewController) and create an XTableViewController property in your class.
In view did load, simply instantiate your table.

     -(void)viewDidLoad {  
       [super viewDidLoad];  
  
       NSArray *models = [NSArray arrayWithObjects: 
         [XTableViewCellModel modelWithType:XCELL_STANDARD withTitle:@"Predefined Cells"
         withContent:@"" withAccesoryType:UITableViewCellAccessoryDisclosureIndicator withTag:CELL_TYPES], 
         [XTableViewCellModel modelWithType:XCELL_STANDARD_WITH_WRAPPING 
         withTitle:@"Predefined Cells now with a ton of wrapping and stuff I can use with wrapping." withContent:@""], nil];

       UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];

       XTableViewController *tableController = [[XTableViewController alloc] initWithTableView:tableView];
       tableController.delegate = self;
       [_tableController setDataWithArray:models];

       [self addSubview:tableView];

       self.myTableController = tableController;
     }

**Questions or Comments:**   
Email: andrewzimmer906@gmail.com  
Twitter: @andrewzimmer906  
