# NJUST Undergraduate Thesis Template
# 南京理工大学本科毕业设计（论文）报告 LaTeX 模板

南京理工大学 2026 年本科毕业设计（论文）报告 LaTeX 模板。本模板基于 [pasteller/njusttt](https://github.com/pasteller/njusttt) 重构，采用两层架构设计（排版引擎 + 定义层），严格遵循《南京理工大学本科毕业设计（论文）报告撰写格式》（2026版）。

## 快速开始

1. 克隆或下载本仓库（master 分支 = 本科版本）
2. 用 LaTeX 编辑器打开 main.tex
3. 编辑 tex/cover.tex 填写论文元数据
4. 编辑 tex/ch1.tex ~ tex/ch5.tex 撰写正文
5. 编译：xelatex → biber → xelatex → xelatex

命令行：

```
xelatex main.tex
biber main
xelatex main.tex
xelatex main.tex
```

## 项目结构

```
njusttt-main/
├── main.tex              # 入口文件
├── njusttt.cls            # 文档类（排版引擎）
├── njusttt.def            # 定义文件（标签、默认值、字体）
├── tex/                   # 论文内容
│   ├── cover.tex          #   元数据 + 封面/封二/英文封二/声明
│   ├── abstract.tex       #   中英文摘要
│   ├── ch1.tex ~ ch5.tex  #   各章节
│   ├── abbreviations.tex  #   缩略语对照表
│   ├── symbols.tex        #   符号表
│   ├── thanks.tex         #   致谢
│   └── publications.tex   #   附录（发表论文等）
├── ref/ref.bib            # 参考文献
├── fig/                   # 图片
├── fonts/                 # 嵌入字体（可选）
└── .vscode/               # VS Code 编译方案
```

## 架构

两层分离设计：

| 文件 | 职责 | 修改时机 |
|------|------|----------|
| njusttt.cls | 排版引擎：页面布局、封面生成、目录格式、第三方包加载 | 极少修改 |
| njusttt.def | 定义层：所有标签、默认值、用户命令、字体配置 | 校方要求更换标签时 |

## 元数据配置命令

在 tex/cover.tex 中设置：

- **标题**：\title[页眉短标题]{完整标题}、\titleUpp{第一行}、\titleLow{第二行}
- **作者**：\author{姓名}、\studentid{学号}
- **导师**：\advisor{姓名}、\advisortitle{职称}
- **学位信息**：\college{学院}、\major{专业}、\researchdir{研究方向}
- **日期**：\submitdate{提交时间}、\incoverdate{封二日期}、\signdate{签名日期}
- **英文**：\englishtitle{...}、\englishauthor{...}、\englishadvisor{...}、\englishinstitute{...}、\englishdate{...}
- **封面生成**：\makecover（一键生成封面 + 封二 + 英文封二 + 声明）

## 内容环境

| 环境 | 命令 | 用途 |
|------|------|------|
| abstract | \keywords{...} | 中文摘要 + 关键词 |
| englishabstract | \englishkeywords{...} | 英文摘要 + 关键词 |
| abbr | \abbreviation{缩略}{英文全称}{中文全称} | 缩略语对照表 |
| symbols | \notation{符号}{含义} | 符号表 |
| thanks | -- | 致谢 |
| publications | \pubitem{...} | 附录（发表论文等） |

## 字体选项

```latex
\documentclass[eprint,font=embedded]{njusttt}   % 默认：嵌入字体，自包含
\documentclass[eprint,font=fandol]{njusttt}     % Fandol 开源字体（推荐 Overleaf）
\documentclass[eprint,font=system]{njusttt}     % Windows 系统字体
```

## 参考文献

统一使用 ref/ref.bib，GB/T 7714-2015 标准。引用方式：\cite{key}

## 环境要求

TeX Live 2023+，XeLaTeX，Biber

## 已验证环境

| 环境 | 状态 |
|------|------|
| Windows 11 + TeX Live 2023 + XeLaTeX | ✅ |
| Overleaf + XeLaTeX | ✅ |

## 分支说明

| 分支 | 用途 |
|------|------|
| master | 本科毕业设计（论文）报告 |
| doctor | 硕士/博士学位论文（重构版） |

## 致谢

本模板基于 [pasteller/njusttt](https://github.com/pasteller/njusttt) 完全重构，修改自更早期的前人成果：

- pasteller/njusttt：https://github.com/pasteller/njusttt
- njustThesis：https://github.com/jiec827/njustThesis

## 许可证

MIT License
