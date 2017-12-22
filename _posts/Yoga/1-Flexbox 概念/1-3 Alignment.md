# Alignment

### AlignItems

`AlignItems` 属性描述了如何在容器内按照交轴排列子控件. `AlignItems` 与 `JustifyContent` 非常相似,  但不是应用在主轴上, 而是应用在交轴上的. `AlignItems` 有四个选项:

- `Stretch` (默认)
- `FlexStart`
- `FlexEnd`
- `Center`

上述四个选项中唯一一个不明显的是 `Stretch` . 当使用 `AlignItems = Stretch` 时, 你可以指定子控件沿着侧轴方向匹配他们的容器的大小.

#### AlignItems = Stretch

![WX20171024-174204](/upload_imgs/yoga-doc-assets/WX20171024-174204.png)

#### AlignItems = FlexStart

![WX20171024-174217](/upload_imgs/yoga-doc-assets/WX20171024-174217.png)

#### AlignItems = FlexEnd

![WX20171024-174226](/upload_imgs/yoga-doc-assets/WX20171024-174226.png)

#### AlignItems = Center

![WX20171024-174252](/upload_imgs/yoga-doc-assets/WX20171024-174252.png)

### AlignSelf

 `AlignSelf` 属性有着和 `AlignItems` 相同的选项, 但不是影响容器内的全部子控件, 你可以将此属性应用在单个子控件上以更改其父控件内的对齐方式.

这个属性会覆盖父控件设置 `AlignItems` 的任何选项. 

#### AlignItems = FlexEnd; AlignSelf = FlexStart;

![WX20171024-174307](/upload_imgs/yoga-doc-assets/WX20171024-174307.png)

### AlignContent

 `AlignContent` 属性用来控制如何在设置了 `FlexWrap = wrap` 的容器内控制多行内容的对齐. 有6个选项:

- `FlexStart` (default)
- `FlexEnd`
- `Center`
- `Stretch`
- `SpaceBetween`
- `SpaceAround`

#### AlignContent = FlexEnd

![WX20171024-174319](/upload_imgs/yoga-doc-assets/WX20171024-174319.png)