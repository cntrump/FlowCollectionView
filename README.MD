# FlowListView

a simple list view template upon UICollectionView.

```objc
_listView = [[FlowListView alloc] initWithFrame:self.view.bounds];
_listView.numberOfSectionsBlock = ^NSInteger (FlowListView *collectionView) {
    return 10;
};
_listView.numberOfItemsInSectionBlock = ^NSInteger (FlowListView *listView) {
    return 10;
};

// setup Cell
_listView.sizeForItemBlock = ^CGSize (FlowListView * listView, NSIndexPath *indexPath) {
    return CGSizeMake(CGRectGetWidth(listView.bounds), 64);
};
_listView.cellForIndexPathBlock = ^__kindof UICollectionViewCell * _Nonnull(FlowListView *listView, __kindof UICollectionViewCell * (^make)(Class cellClass), NSIndexPath *indexPath) {
    Cell *cell = make(Cell.class);

    return cell;
};
_listView.didSelectItemBlock = ^(FlowListView *listView, NSIndexPath *indexPath) {
    NSLog(@"clicked: %ld - %ld", indexPath.section, indexPath.row);
};
[_listView registerCellClass:Cell.class];

// setup Header View
_listView.sizeForHeaderInSectionBlock = ^CGSize (FlowListView *listView, NSInteger section) {
    return CGSizeMake(CGRectGetWidth(listView.bounds), 44);
};
_listView.headerViewForIndexPathBlock = ^__kindof UICollectionReusableView * (FlowListView *listView, __kindof UICollectionReusableView * (^make)(Class viewClass), NSIndexPath *indexPath) {
    HeaderView *view = make(HeaderView.class);

    return view;
};
[_listView registerHeaderViewClass:HeaderView.class];
```
