# Min & Max dimensions

Using `MinWidth`, `MinHeight`, `MaxWidth`, and `MaxHeight` gives you increased control over the final size of items in a layout. By mixing these properties with `FlexGrow`, `FlexShrink`, and `AlignItems = Stretch`, you are able to have items with dynamic size within a range which you control.

An example of when `Max` properties can be useful is if you are using `AlignItems = Stretch` but you know that your item won’t look good after it increases past a certain point. In this case, your item will stretch to the size of its parent or until it is as big as specified in the `Max` property.

Same goes for the `Min` properties when using `FlexShrink`. For example, you may want children of a container to shrink to fit on one row, but if you specify a minimum width, they will break to the next line after a certain point (if you are using `FlexWrap = Wrap`).

Another case where `Min` and `Max` dimension constraints are useful is when using `AspectRatio`.

#### FlexGrow = 1; MaxWidth = 200;

![WX20171024-174706](/upload_imgs/yoga-doc-assets/WX20171024-174706.png)

#### AlignItems = Stretch; MaxHeight: 100;

![WX20171024-174721](/upload_imgs/yoga-doc-assets/WX20171024-174721.png)