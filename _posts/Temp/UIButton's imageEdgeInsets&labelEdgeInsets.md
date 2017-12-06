# UIButton 的 imageEdgeInsets 与 labelEdgeInsets 属性挖坑

1. 只有一个 Image 属性或只有一个 Label 属性情况下：

```swift
let beforFrame: CGRect = CGRect(x: x, y: y, width: width, height: height)
let insets: UIEdgeInsets = UIEdgeInsectsMake(top, left, bottom, right)
let resultFrame = CGRect(x: beforFrame.x + insets.left, 
                         y: beforFrame.y + insets.top, 
                         width: beforFrame.width - insets.left - insets.right, 
                         height: beforFrame.height - insets.top - insets.bottom)
```

   ​

2. ImageView 属性与 Label 同时存在

   在这种情况下，计算方式变得有些微妙。 不知道为什么， 上述计算规则在 ImageView 与 Label 两种控件同时存在于 UIButton 中的时候：

   *纵向关系遵循上述规则， 
   *横向关系上只能移动 offset， 且计算方式变成了 `resultFrame.x = beforFrame.x + (insets.left + insets.right)/2`
   *横向上 beforFrame 的 width不可被改变

   ​
   即：
```swift
let beforFrame: CGRect = CGRect(x: x, y: y, width: width, height: height)
let insets: UIEdgeInsets = UIEdgeInsectsMake(top, left, bottom, right)
let resultFrame = CGRect(x: beforFrame.x + (insets.left + insets.right)/2, 
                         y: beforFrame.y + insets.top, 
                         width: beforFrame.width, 
                         height: beforFrame.height - insets.top - insets.bottom)
```
