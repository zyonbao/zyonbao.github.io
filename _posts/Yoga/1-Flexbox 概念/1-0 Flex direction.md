# Flex direction

The `FlexDirection` property controls the direction in which children are laid out. There are 4 options, of which 2 are commonly used:

- `Column` (default)
- `Row`
- `ColumnReverse`
- `RowReverse`

The `Column` option stacks children horizontally from top to bottom, and the `Row` option stacks children from left to right. The `Reverse` variants of the options reverse the order. If your layout supports right-to-left direction, Yoga will automatically toggle between `Row` and `RowReverse` as necessary.

`FlexDirection` introduces another important aspect of Flexbox, the main and cross axes. This is important as other properties will reference which axis they operate on. Simply put, the main axis follows the `FlexDirection` and the cross axis crosses the main axis at a 90 degree angle.

#### FlexDirection = Row

In this example the main axis goes from the left to the right. The cross axis goes from the top to the bottom.

![WX20171024-173809](/upload_imgs/yoga-doc-assets/WX20171024-173809.png)

#### FlexDirection = Column

In this example the main axis goes from the top to the bottom. The cross axis goes from the left to the right.

![WX20171024-173839](/upload_imgs/yoga-doc-assets/WX20171024-173839.png)