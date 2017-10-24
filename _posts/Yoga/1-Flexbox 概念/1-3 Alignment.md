# Alignment

### AlignItems

The `AlignItems` property describes how to align children along the cross axis of their container. `AlignItems` is very similar to `JustifyContent` but instead of applying to the main axis, it applies to the cross axis. There are 4 options for `AlignItems`:

- `Stretch` (default)
- `FlexStart`
- `FlexEnd`
- `Center`

The only non-obvious option of the four is `Stretch`. With `AlignItems = Stretch` you instruct children to match the size of their container in the cross axis.

#### AlignItems = Stretch

![WX20171024-174204](/upload_imgs/yoga-doc-assets/WX20171024-174204.png)

#### AlignItems = FlexStart

![WX20171024-174217](/upload_imgs/yoga-doc-assets/WX20171024-174217.png)

#### AlignItems = FlexEnd

![WX20171024-174226](/upload_imgs/yoga-doc-assets/WX20171024-174226.png)

#### AlignItems = Center

![WX20171024-174252](/upload_imgs/yoga-doc-assets/WX20171024-174252.png)

### AlignSelf

The `AlignSelf` property has the same options and effect as `AlignItems` but instead of affecting the children within a container, you can apply this property to a single child to change its alignment within its parent.

This property overrides any option set by the parent via the `AlignItems` property.

#### AlignItems = FlexEnd; AlignSelf = FlexStart;

![WX20171024-174307](/upload_imgs/yoga-doc-assets/WX20171024-174307.png)

### AlignContent

The `AlignContent` property is used to control how multiple lines of content are aligned within a container which uses `FlexWrap = wrap`. There are 6 options:

- `FlexStart` (default)
- `FlexEnd`
- `Center`
- `Stretch`
- `SpaceBetween`
- `SpaceAround`

#### AlignContent = FlexEnd

![WX20171024-174319](/upload_imgs/yoga-doc-assets/WX20171024-174319.png)