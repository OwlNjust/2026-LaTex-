# 南京理工大学本科毕业设计（论文）报告 LaTeX 模板

基于 [pasteller/njusttt](https://github.com/pasteller/njusttt) 重构，严格遵循《南京理工大学本科毕业设计（论文）报告撰写格式》（2026版）。
由于项目历史遗留问题，如果需要修改英文封面的内容，请在njusttt.def文件中找到对应位置修改。
## 快速开始

1. 下载本仓库
2. 用 LaTeX 编辑器打开 `main.tex`
3. 编辑 `tex/cover.tex` 填写论文元数据
4. 编辑 `tex/ch1.tex` ~ `tex/ch5.tex` 撰写正文
5. 编译

**VS Code**：选择方案 `latexmk（智能快速编译）`（日常）或 `xelatex → biber → xelatex × 2`（首次）

**命令行**：
```
xelatex main.tex
biber main
xelatex main.tex
xelatex main.tex
```

**Overleaf**：编译器设为 XeLaTeX，类选项加 `font=fandol`。

## 项目结构

```
├── main.tex              # 入口文件
├── njusttt.cls            # 排版引擎（页面布局、封面生成、目录格式）
├── njusttt.def            # 定义层（标签、默认值、用户命令、字体）
├── tex/                   # 论文内容
│   ├── cover.tex          #   元数据 + 封面生成
│   ├── abstract.tex       #   中英文摘要
│   ├── ch1.tex ~ ch5.tex  #   正文章节
│   ├── abbreviations.tex  #   缩略语对照表（可选）
│   ├── symbols.tex        #   符号表（可选）
│   ├── thanks.tex         #   致谢
│   └── publications.tex   #   附录
├── ref/ref.bib            # 参考文献
├── fig/                   # 图片
├── fonts/                 # 嵌入中文字体
└── .vscode/               # VS Code 编译方案
```

## 架构

两层分离设计，用户只需 `\documentclass[eprint]{njusttt}`：

| 文件 | 行数 | 职责 | 修改时机 |
|------|------|------|----------|
| `njusttt.cls` | 478 | 排版引擎：页面几何、页眉页脚、封面/封二/声明生成、目录格式、第三方包 | 格式规范变化时 |
| `njusttt.def` | 266 | 定义层：中英文标签、默认值、用户命令、字体配置 | 校方更换标签时 |

## 封面配置

在 `tex/cover.tex` 中设置，最后调用 `\makecover`：

**标题**
- `\title[页眉短标题]{完整标题}` — 论文标题（短标题显示于页眉）
- `\titleUpp{第一行}` `\titleLow{第二行}` — 封面标题分两行

**作者**
- `\author{姓名}` `\studentid{学号}`

**导师**
- `\advisor{姓名}` `\advisortitle{职称}`

**信息**
- `\college{学院}` `\major{专业}` `\researchdir{研究方向}`

**日期**
- `\submitdate{提交时间}` `\incoverdate{封二日期}` `\signdate{签名日期}`

**英文封面**
- `\englishtitle{...}` `\englishauthor{...}` `\englishadvisor{...}`
- `\englishinstitute{...}` `\englishdate{...}`

**一键生成**：`\makecover`（封面 + 封二 + 英文封二 + 声明）

## 内容环境

```latex
% 中文摘要
\begin{abstract}
  摘要内容（200~300字）...
  \keywords{关键词1；关键词2；关键词3}
\end{abstract}

% 英文摘要
\begin{englishabstract}
  Abstract content...
  \englishkeywords{keyword1; keyword2; keyword3}
\end{englishabstract}

% 缩略语对照表（可选，默认已注释）
\begin{abbr}
  \abbreviation{缩写}{英文全称}{中文全称}
\end{abbr}

% 符号表（可选，默认已注释）
\begin{symbols}
  \notation{符号}{含义}
\end{symbols}

% 致谢
\begin{thanks} ... \end{thanks}

% 附录
\begin{publications}
  \pubitem 论文信息...
\end{publications}
```

## 字体选项

```latex
\documentclass[eprint,font=embedded]{njusttt}   % 默认：嵌入字体，离线可用
\documentclass[eprint,font=fandol]{njusttt}     % Fandol 开源字体（Overleaf 推荐）
\documentclass[eprint,font=system]{njusttt}     % Windows 系统字体
```

## 参考文献

`ref/ref.bib`，GB/T 7714-2015 标准，biber 编译。引用：`\cite{key}`。

## 格式规范

模板已按 2026 官方格式预设：

| 项目 | 规范 |
|------|------|
| 纸张 | A4，上30mm 下24mm 左25mm 右25mm |
| 正文 | 小四宋体，固定 20pt 行距，Times New Roman 数字字母 |
| 一级标题 | 小三加粗宋体居左，段前后各 18pt |
| 二级标题 | 四号加粗宋体居左，段前后各 12pt |
| 三级标题 | 小四加粗宋体居左，段前后各 6pt |
| 图表标题 | 五号宋体，表名在表上，图名在图下 |
| 页眉 | 小五宋体，左"毕业设计（论文）报告" 右"题目" |
| 页码 | 摘要~目录用罗马数字，正文起用阿拉伯数字，居外侧 |

## 环境要求

- TeX Live 2023+（已测试 2025）
- XeLaTeX + Biber

## 已验证

| 环境 | 状态 |
|------|------|
| Windows 11 + TeX Live 2025 + XeLaTeX | ✅ |
| Windows + TeX Live 2023 + XeLaTeX | ✅ |
| Overleaf + XeLaTeX | ✅ |

## 致谢

本模板基于 [pasteller/njusttt](https://github.com/pasteller/njusttt) 完全重构：

- pasteller/njusttt：https://github.com/pasteller/njusttt
- njustThesis：https://github.com/jiec827/njustThesis

## 许可证

MIT License
