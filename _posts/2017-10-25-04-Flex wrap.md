---
layout: post
title: 'Yoga-04-Flex wrap'
subtitle: '这是facebook出品的flexbox布局库的翻译文档的第1章第2篇'
date: 2017-10-25
cover: '/upload_imgs/coverset/2017-10-24-yoga.jpg'
categories: 翻译文档
tags: Yoga
---

# Flex wrap

`Flex Wrap` 属性可以设置在容器和控件上, 用以控制子对象在沿主轴布局时溢出了容器大小时的表现. 有两个选项:

- `Nowrap` (默认)
- `Wrap`

如果一个容器指定了 `FlexWrap = Wrap` 那么他的子对象就会折到下一行而不是溢出容器.
折行将于上一行有相同的 `FlexDirection` 且沿着侧轴的方向排在上一行旁边. 即, 如果 `FlexDirection = Column` 就往下布局,  `FlexDirection = Row` 就往右布局.(这里应该是指折行与上一行的布局方向相同, 并没有要解释折行与上一行的排列方式的意思)

#### FlexWrap = Nowrap

![WX20171024-174104](/upload_imgs/yoga-doc-assets/WX20171024-174104.png)

#### FlexWrap = Wrap

![WX20171024-174117](/upload_imgs/yoga-doc-assets/WX20171024-174117.png)