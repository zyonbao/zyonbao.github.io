# Aspect ratio

`AspectRatio` is a property introduced by Yoga. `AspectRatio` solves the problem of knowing one dimension of an element and an aspect ratio, this is very common when it comes to videos, images, and other media types. `AspectRatio` accepts any floating point value > 0, the default is undefined.

- `AspectRatio` is defined as the ratio between the width and the height of a node e.g. if a node has an aspect ratio of 2 then its width is twice the size of its height.
- `AspectRatio` respects the `Min` and `Max` dimensions of an item.
- `AspectRatio` has higher priority than `FlexGrow`
- If `AspectRatio`, `Width`, and `Height` are set then the cross dimension is overridden.

#### Width = 100; AspectRatio = 2;

![WX20171024-174820](/upload_imgs/yoga-doc-assets/WX20171024-174820.png)

#### Width = 100; AspectRatio = 0.5;

![WX20171024-174829](/upload_imgs/yoga-doc-assets/WX20171024-174829.png)

#### FlexDirection = Row; FlexGrow = 1; AspectRatio = 2;

![WX20171024-174838](/upload_imgs/yoga-doc-assets/WX20171024-174838.png)

#### FlexDirection = Row; AlignItems = Stretch; AspectRatio = 0.5;

![WX20171024-174847](/upload_imgs/yoga-doc-assets/WX20171024-174847.png)