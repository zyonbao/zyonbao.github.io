# Flex

### FlexGrow

The `FlexGrow` property describes how any space within a container should be distributed among its children along the main axis. After laying out its children, a container will distribute any remaining space according to the `FlexGrow` values specified by its children.

`FlexGrow` accepts any floating point value >= 0, with 0 being the default value. A container will distribute any remaining space among its children weighted by the child’s `FlexGrow` value.

![WX20171024-174349](/upload_imgs/yoga-doc-assets/WX20171024-174349.png)

![WX20171024-174404](/upload_imgs/yoga-doc-assets/WX20171024-174404.png)

![WX20171024-174424](/upload_imgs/yoga-doc-assets/WX20171024-174424.png)

![WX20171024-174441](/upload_imgs/yoga-doc-assets/WX20171024-174441.png)



### FlexShrink

The `FlexShrink` property describes how to shrink children along the main axis in the case that the total size of the children overflow the size of the container on the main axis.

`FlexShrink` is very similar to `FlexGrow` and can be thought of in the same way if any overflowing size is considered to be negative remaining space. These two properties also work well together by allowing children to grow and shrink as needed.

`FlexShrink` accepts any floating point value >= 0, with 0 being the default value. A container will shrink its children weighted by the child’s `FlexShrink` value.

![WX20171024-174500](/upload_imgs/yoga-doc-assets/WX20171024-174500.png)

![WX20171024-174516](/upload_imgs/yoga-doc-assets/WX20171024-174516.png)

![WX20171024-174531](/upload_imgs/yoga-doc-assets/WX20171024-174531.png)

![WX20171024-174555](/upload_imgs/yoga-doc-assets/WX20171024-174555.png)

### FlexBasis

The `FlexBasis` property is an axis-independent way of providing the default size of an item on the main axis. Setting the `FlexBasis` of a child is similar to setting the `Width` of that child if its parent is a container with `FlexDirection = row` or setting the `Height` of a child if its parent is a container with `FlexDirection = column`. The `FlexBasis` of an item is the default size of that item, the size of the item before any `FlexGrow` and `FlexShrink` calculations are performed.