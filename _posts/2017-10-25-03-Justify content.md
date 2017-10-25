---
layout: post
title: 'Yoga-03-Justify content'
subtitle: '这是facebook出品的flexbox布局库的翻译文档的第1章第1篇'
date: 2017-10-25
cover: '/upload_imgs/coverset/2017-10-24-yoga.jpg'
categories: 翻译文档
tags: Yoga
---

# Justify content

`JustifyContent`属性描述了如何在容器的主轴上对齐子对象 . 例如，你可以使用该属性在 `FlexDirection = Row` 的容器里（垂直居中地）水平放置子对象，或者在 `FlexDirection = Column` 的容器中（水平居中地）垂直放置子对象。For example, you can use this property to center a child horizontally within a container with  or vertically within a container with `FlexDirection = Column`.

`JustifyContent` 接受以下5个属性之一:

- `FlexStart` (默认)
- `FlexEnd`
- `Center`
- `SpaceBetween`
- `SpaceAround`

#### JustifyContent = FlexStart

![WX20171024-173917](/upload_imgs/yoga-doc-assets/WX20171024-173917.png)

#### JustifyContent = FlexEnd

![WX20171024-173952](/upload_imgs/yoga-doc-assets/WX20171024-173952.png)

#### JustifyContent = Center

![WX20171024-174014](/upload_imgs/yoga-doc-assets/WX20171024-174014.png)

#### JustifyContent = SpaceBetween

![WX20171024-174033](/upload_imgs/yoga-doc-assets/WX20171024-174033.png)

#### JustifyContent = SpaceAround

![WX20171024-174042](/upload_imgs/yoga-doc-assets/WX20171024-174042.png)