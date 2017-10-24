# Flex wrap

The `FlexWrap` property is set on containers and controls what happens when children overflow the size of the container along the main axis. There are 2 options:

- `Nowrap` (default)
- `Wrap`

If a container specifies `FlexWrap = Wrap` then its children will wrap to the next line instead of overflowing. The next line will have the same `FlexDirection` as the first line and will appear next to the first line along the cross axis – below it if using `FlexDirection = Column` and to the right if using `FlexDirection = Row`.

#### FlexWrap = Nowrap

![WX20171024-174104](/upload_imgs/yoga-doc-assets/WX20171024-174104.png)

#### FlexWrap = Wrap

![WX20171024-174117](/upload_imgs/yoga-doc-assets/WX20171024-174117.png)