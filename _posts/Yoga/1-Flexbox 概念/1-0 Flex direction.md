---
layout: post
title: 'Yoga-02-Flex direction'
subtitle: '这是facebook出品的flexbox布局库的翻译文档的第1章第0篇'
date: 2017-10-24
cover: '/upload_imgs/coverset/2017-10-24-yoga.jpg'
categories: 翻译文档
tags: Yoga
---

# Flex direction

`FlexDirection` 属性控制着子视图的布局方向.有 4 个选项, 其中 2 个比较常用:

- `Column` (默认)
- `Row`
- `ColumnReverse`
- `RowReverse`

`Column` 选项从上到下堆叠子视图, `Row` 选项从左到右堆叠子视图. 带`Reverse` 的选项则为颠倒对应的顺序. 如果你的视图支持 right-to-left(从右到左) 方向, Yoga 将根据需要在 `Row` and `RowReverse` 间自动切换.

`FlexDirection` 引入了 Flexbox 另外一个重要的点, **主轴**与**侧轴**. 这个概念很重要, 因为其他的布局属性将参考他们所在的轴布局. 简单的说, 主轴遵循 `FlexDirection` 而侧轴则以90度的角度穿过主轴.

#### FlexDirection = Row

本例中, 主轴从左到右, 侧轴从上到下.

![WX20171024-173809](/upload_imgs/yoga-doc-assets/WX20171024-173809.png)

#### FlexDirection = Column

本例中, 主轴从上到下的, 侧轴为从左到右.

![WX20171024-173839](/upload_imgs/yoga-doc-assets/WX20171024-173839.png)