# Swift Package Manager 教程

翻译自[原文](https://theswiftdev.com/2017/11/09/swift-package-manager-tutorial/)

是时候学习如何使用 Swift Package Manager 去处理外部依赖、在 macOS 和 linux 上创建你自己的 Swift 库和 app 了。

------

## Swift Package Manager 基础

注意：由于 Apple 在 Swift 4 中为 Swift Package Manager 的 API 做了一个完全的重新设计（你可以阅读相关更改的内容），本教程并不适用于 Swift 3。 所以首先在我们开始之前，请在检查你的设备上的 Swift 版本。

```shell
swift --version
Apple Swift version 4.0.2 (swiftlang-900.0.69.2 clang-900.0.38)
Target: x86_64-apple-macosx10.9

```

### 创建 apps

所有困难的工作都可以交由 `swift package` 命令来完成。你可以在终端中输入该命令查看可用的子命令。为了生成一个新的包，你应该使用初始化命令。如果你不提供一个类型标志，默认情况下该命令将会生成一个库，但这一次我们想要生成一个可执行的应用。

```shell
swift package init --type executable 
swift build 
swift run my-app

```
编译器可以在 `swift build` 命令的帮助下构建你的源文件。该可执行文件将会被放置在 **.build/** 目录下的某个地方，如果你使用 `swift run my-app` 命令来运行刚刚创建的应用，你应该呢个看到基本的 'Hello, world!' 消息。

> 祝贺你成功生成了你的第一个命令行 Swift 应用程序！

现在你应当来做一些切实的编码了。通常而言你的 Swift 源文件应该在 **Sources** 目录下， 然而你可能想要为你的 app 创建一些可复用的部分。所以让我们通过创建一个全新的库来为这个场景做准备吧。

### 生成一个 Library

我们依旧从从初始化命令开始，但这次我们不指定 init 的类型了。实际上我们可以键入 `swift package init --type library` 但这需要键入很多单词。 😜 另外由于我们正在生成一个库， SPM 将会给我们提供一些基本的测试，让我们使用 `swift test` 命令来运行它们吧。

```shell
swift package init
swift test

```

如果你此时检查文件结构，你会在 **Tests** 下看到一个单元测试的例子，而不会在 source 中找到 **main.swift** 文件。

现在你有了一些基础了。你有一个示例程序和一个 library， 让我们在 Swift Package Manager Manifest API 的帮助下将它们链接在一起吧。

## The Manifest API(清单 API) - Package.swift

每一个 SPM 包内都有一个 Package.swift 清单文件(manifest file). 在清单文件中你可以定义你的全部依赖、targets 甚至为你的工程定义指定的源文件.在本节我会教你清单文件 (manifest file) 的一些基础内容.

### 工具版本

首先如果你想支持新的 manifest file 的格式 (换言之, Swift 4 版本) ， 你得以注释的方式在你的 manifest 文件设置  swift-tools-version. 

```shell
// swift-tools-version:4.0

```

现在你已经准备好在全新的 manifest API 下工作了！



### 依赖

让我们先通过在 Package.swift 文件中创建一个新的包依赖 (package dependency) 来为主程序添加一个依赖库. 第一个参数是一条包 url 字符串，可以是本地文件路径也可以是远程 url (通常是一个 github 仓库链接). 注意, 你还应当将你的依赖添加到 targets 中. 通常而言包的特定名称 (包名) 已经在该 library 的 manifest 文件中定义了.  

```swift
// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "my-app",
    dependencies: [
        .package(url: "../my-lib", .branch("master")),
    ],
    targets: [
        .target(
            name: "my-app",
            dependencies: ["my-lib"]
        ),
    ]
)

```

如果你现在运行 `swift build` 你将编译源文件失败. 那是因为 SPM 仅会工作在 git 仓库下. 这就意味着你需要为你的 library 创建一个 git 仓库. 让我们移动到该目录并执行如下命令:

```shell
git init
git add .
git commit -m 'initial'

```

你也应当标记我们指定的包依赖的分支。你可以使用 version 号，甚至也可以用 commit hashes 。所有可用的选项都很好的被写在了 [manifest api redesign proposal](https://github.com/apple/swift-evolution/blob/master/proposals/0158-package-manager-manifest-api-redesign.md) 文档中。

现在让我们回到应用目录并使用 `swift package update` 命令来更新以来。这次它就能够获取、克隆并成功搞定我们的依赖了。

你可以构建并运行，然而我们忘了设置我们 library 中结构体的访问级为 public， 所以从该 API 中看不到任何东西。

```swift
public struct my_lib {
    public var text = "Hello, World!"

    public init() {}
}

```

让我们来做一些修改并将其提交到该 library 的主分支上。

```shell
git add .
git commit -m 'access level fix'

```

你已经准备好在 app 中使用该 lib 了，修改 main.swift file 如下。

```swift
import my_lib

print(my_lib().text)

```

再一次更新依赖，这次我们来构建一个 release 构建。

```shell
swift package update
swift build -c release
swift run -c release

```

通过 **-c** 或 **--configuration** 标识你可以生成一个 release 构建。

### Products 与 targets

默认情况下， SPM 与下列 targets 目录一起工作:

> Regular targets: package root, Sources, Source, src, srcs.
> Test targets: Tests, package root, Sources, Source, src, srcs.

这就表明，如果你在这些目录下创建 `.swift` 文件，这些源文件将根据文件路径被编译或测试。另外，生成的 mainfest 文件将仅仅包含一份构建 target (像 Xcode targets一样) , 但有时候你想要从同一个 bundle 中创建多个 apps 或 libraries. 让我们稍微修改下我们的 Package.swift, 并看看如何能创造一个全新的 target.

```swift
// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "my-app",
    dependencies: [
        .package(url: "../my-lib", .branch("master")),
        .package(url: "https://github.com/kylef/Commander", from: "0.8.0"),
    ],
    targets: [
        .target(
            name: "my-app",
            dependencies: ["my-lib"]
        ),
        .target(
            name: "my-cmd",
            dependencies: ["Commander"],
            path: "./Sources/my-cmd",
            sources: ["main.swift"]
        ),
    ]
)

```

我们刚刚从 github 创建了一个新的依赖 和一个在 **Sources/my-cmd** 目录下只含有 **main.swift** 文件的全新的 target. 现在让我们创建这个目录并为这个新的 app 添加一些源码.

```swift
import Foundation
import Commander

let main = command { (name:String) in
    print("Hello, \(name.capitalized)!")
}

main.run()

```

使用 `swift build` 编译这个工程并用一个额外的 name 参数运行这个新创建的 app. 希望你能看到的输出如下:

```shell
swift run my-cmd guest
// Hello, Guest!

```

因此我们刚刚创建了一个全新的可执行的 target, 但如果你想将你的 targets 暴露给其他的 packages , 你应当也将它们定义为 products. 如果你打开这个 library 的 manifest 文件, 你会看到里面有个从该 library target 定义 target 字段. 通过这种方式, 包管理器可以根据给定的 product name 链接 product 依赖.

注意: 你可以定义 static 或 dynamic 的 libraries. 但推荐使用 automatic , 这样可以让 SPM 决定合适的链接.

```swift
// swift-tools-version:4.0
import PackageDescription


let package = Package(
    name: "my-lib-package",
    products: [
        .library(name: "my-lib", targets: ["my-lib"]),
        //.library(name: "my-lib", type: .static, targets: ["my-lib"]),
        //.library(name: "my-lib", type: .dynamic, targets: ["my-lib"]),
    ],
    dependencies: [
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "my-lib",
            dependencies: []),
        .testTarget(
            name: "my-libTests",
            dependencies: ["my-lib"]),
    ]
)

```

### 部署目标(Deployment target), 其他 build flags

有时候你需要为你的包指定部署的 target. 现在 Swift Package Manager 已经能做到了 (已经有 [一段时间](https://oleb.net/blog/2017/04/swift-3-1-package-manager-deployment-target/)了). 你只需要在构建阶段为编译器提供一些额外的参数就行了.

```shell
swift build -Xswiftc "-target" -Xswiftc "x86_64-apple-macosx10.12"

```

定义构建的 flags 也是可行的.

```shell
swift build -Xswiftc "-D" -Xswiftc "DEBUG"

```

现在在你的源码里面你可以检查 DEBUG 标志的存在了.

```shell
#if DEBUG
    print("debug mode")
#endif

```

如果你想了解更多关于构建过程的内容, 只需要键入 `swift build --help` 你就可以看到该构建命令可用的选项.

## 还有一件事

你可以通过 Swift Package Manager 来生成 Xcode Projects。

```shell
swift package generate-xcodeproj

```

这就是 SPM 的简单介绍了。实际上我们不仅仅介绍了 Swift Package Manager 的基础知识，也稍微拓展了一些，现在你应该对 targets、products 以及大部分可用的命令比较熟悉了，但仍然还有很多需要学习。所以如果你想对这个 amazing 的工具了解更多，这里还有一些非常棒的资源等着你去浏览。 Enjoy！ 😉

另外，本教程的源码可以在  [github](https://github.com/theswiftdev/swift-package-manager) 上获取。

## 拓展阅读

- [Swift.org Package Manager](https://swift.org/package-manager/)
- [SPM usage](https://github.com/apple/swift-package-manager/blob/master/Documentation/Usage.md)
- [SPM PackageDescription API](https://github.com/apple/swift-package-manager/blob/master/Documentation/PackageDescriptionV4.md#targets)
- [SPM Manifest API redesign proposal](https://github.com/apple/swift-evolution/blob/master/proposals/0158-package-manager-manifest-api-redesign.md)
- [SPM Manifest API redesign](https://swift.org/blog/swift-package-manager-manifest-api-redesign/)
- [SPM Evolution](https://apple.github.io/swift-evolution/#?search=package%20manager)