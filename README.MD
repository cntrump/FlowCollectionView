# FlowListView

a simple list view template upon UICollectionView.

```objc
- (void)viewDidLoad {
    [super viewDidLoad];

    _listView = [[FlowListView alloc] initWithFrame:self.view.bounds];
    _listView.dataSourceProvider = [self createDataSourceProvider];
    [_listView registerCellClass:Cell.class];
    [_listView registerHeaderViewClass:HeaderView.class];
    [self.view addSubview:_listView];
}

- (FlowListViewDataSource *)createDataSourceProvider {
    FlowListViewDataSource *dataSourceProvider = [[FlowListViewDataSource alloc] init];

    dataSourceProvider.numberOfSectionsBlock = ^NSInteger (FlowListView *collectionView) {
        return 10;
    };

    dataSourceProvider.numberOfItemsInSectionBlock = ^NSInteger (FlowListView *listView) {
        return 10;
    };

    dataSourceProvider.sizeForItemBlock = ^CGSize (FlowListView * listView, NSIndexPath *indexPath) {
        return CGSizeMake(CGRectGetWidth(listView.bounds), 64);
    };

    dataSourceProvider.cellForIndexPathBlock = ^__kindof UICollectionViewCell * _Nonnull(FlowListView *listView, __kindof UICollectionViewCell * (^make)(Class cellClass), NSIndexPath *indexPath) {
        Cell *cell = make(Cell.class);

        return cell;
    };

    dataSourceProvider.didSelectItemBlock = ^(FlowListView *listView, NSIndexPath *indexPath) {
        NSLog(@"clicked: %ld - %ld", indexPath.section, indexPath.row);
    };

    dataSourceProvider.sizeForHeaderInSectionBlock = ^CGSize (FlowListView *listView, NSInteger section) {
        return CGSizeMake(CGRectGetWidth(listView.bounds), 44);
    };

    dataSourceProvider.headerViewForIndexPathBlock = ^__kindof UICollectionReusableView * (FlowListView *listView, __kindof UICollectionReusableView * (^make)(Class viewClass), NSIndexPath *indexPath) {
        HeaderView *view = make(HeaderView.class);

        return view;
    };

    return dataSourceProvider;
}
```
