---
layout: post
title: 'Yoga-01-快速开始-了解更多'
subtitle: '这是facebook出品的flexbox布局库的翻译文档的第0章第1篇'
date: 2017-10-21
cover: '/upload_imgs/coverset/2017-10-24-yoga.jpg'
categories: 翻译文档
tags: Yoga
---

# 了解更多

Yoga 是一个实现了 Flexbox 的开源跨平台布局库. Yoga 的重点是创建一个富有表现力的**布局**库, 而不是实现所有的 CSS. 因此, Yoga 并没有支持对 tables, floats 以及类似 CSS 概念的支持的计划. Yoga 也不支持对布局没有影响的样式属性, 比如颜色或背景属性.

### Yoga vs Flexbox

Yoga 旨在依据 [w3 规范](https://www.w3.org/TR/css3-flexbox) 与Flexbox兼容. 然而, Yoga 并不是严格遵守规范开发的; 因此, Yoga 有些方面与规范不同.

#### 默认值

为了更好的适应移动布局的用例, Yoga 选择改变一些默认的属性值. 以下 CSS 代码块描述了与 [Flexbox w3 规范](https://www.w3.org/TR/css3-flexbox) 中默认值的差异.

```css
div {
  box-sizing: border-box;
  position: relative;

  display: flex;
  flex-direction: column;
  align-items: stretch;
  flex-shrink: 0;
  align-content: flex-start;

  border-width: 0px;
  margin: 0px;
  padding: 0px;
  min-width: 0px;
}
```

我们建立了 [JSFiddle](https://jsfiddle.net/emilsjolander/jckmwztt/) 所以你可以动态地看到到这些默认值对布局的影响.

#### Right-to-Left

我们相信在布局方面 `Right-to-Left(RTL, 从右至左)` 应当是一等公民.因此, Yoga 对 margin, padding, border 和 position 属性实行非标准的 RTL 支持. 这就允许我们在指定这些属性时用 `start` 替代 `left`, 用 `end` 替代 `right`.

[了解更多有关 RTL](https://facebook.github.io/yoga/docs/rtl/)

#### Yoga 专有属性

Yoga 的目标是成为一个使布局容易的库. 当然, 实现一个常见又受欢迎的系统-- Flexbox 有助于实现这一目标. 但在有些地方，我们认为 Yoga 可以演变并超越 Flexbox, 并为开发人员提供些未包含在 [Flexbox w3 规范](https://www.w3.org/TR/css3-flexbox) 中的工具. 目前,  Yoga 已经添加了一个这样的属性 `AspectRatio` 来解决我们在许多UI中看到的常见问题。

[了解更多有关 ASPECT RATIO](https://facebook.github.io/yoga/docs/aspect-ratio/)