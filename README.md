# NJUST Thesis Template（南京理工大学学位论文 LaTeX 模板）

南京理工大学博士学位论文 LaTeX 模板。本模板重构自前人的成果，采用两层架构设计，兼具健壮性与易修改性。

---

## 快速开始

1. 克隆或下载本仓库
2. 使用任意 LaTeX 编辑器打开 `main.tex`
3. 编辑 `tex/cover.tex` 填写论文元数据（标题、作者、导师等）
4. 编辑 `tex/ch1.tex` ~ `tex/ch6.tex` 撰写各章节内容（可在 `main.tex` 中增删章节文件）
5. 编译

**编译配方：** `xelatex → biber → xelatex → xelatex`

- **VS Code + LaTeX Workshop：** 选择编译方案 `xelatex → biber → xelatex → xelatex`
- **Overleaf：** 设置编译器为 XeLaTeX
- **命令行：**

```bash
xelatex main.tex
biber main
xelatex main.tex
xelatex main.tex
```

---

## 项目结构

```
njusttt-main/
├── main.tex              # 入口文件
├── njusttt.cls            # 文档类（排版引擎）
├── njusttt.def            # 定义文件（标签、默认值、字体配置）
├── tex/                   # 论文内容
│   ├── cover.tex          #   元数据 + 封面生成
│   ├── abstract.tex       #   中英文摘要
│   ├── ch1.tex ~ ch6.tex  #   各章节正文
│   ├── abbreviations.tex  #   缩略语对照表
│   ├── symbols.tex        #   符号表
│   ├── thanks.tex         #   致谢
│   └── publications.tex   #   发表论文列表
├── ref/                   # 参考文献（.bib 文件）
├── fig/                   # 图片资源
├── fonts/                 # 嵌入字体（可选）
└── .vscode/               # VS Code 编译方案
```

---

## 架构说明

模板采用**两层分离**设计：

| 文件 | 职责 | 修改时机 |
|------|------|---------|
| `njusttt.cls` | 排版引擎：页面布局、页眉页脚、封面生成逻辑、目录格式、第三方包加载 | 极少修改（仅格式规范变化时） |
| `njusttt.def` | 定义层：所有中英文标签字符串、默认值、用户配置命令、字体设置、定理环境 | 校方要求更换标签或新增字段时 |

用户只需写 `\documentclass[eprint]{njusttt}`，`.cls` 会自动加载 `.def`。

---

## 元数据配置命令

在 `tex/cover.tex` 中设置，然后在 `\makecover` 之前调用：

### 分类号与密级

- `\classification{...}` — 分类号
- `\confidential{...}` — 密级，默认 `（无）`
- `\UDC{...}` — UDC 号

### 标题

- `\title[页眉短标题]{完整中文标题}` — 论文标题
- `\titleUpp{...}` — 封面上排标题
- `\titleLow{...}` — 封面下排副标题

### 作者与导师

- `\author{...}` — 作者姓名
- `\advisor{...}` / `\advisortitle{...}` — 导师姓名和职称
- `\coadvisor{...}` / `\coadvisortitle{...}` — 协同导师姓名和职称

### 学位信息

- `\degree{...}` — 学位类别（如"工学博士"）
- `\major{...}` — 学科名称
- `\interest{...}` — 研究方向
- `\school{...}` — 学校名称（默认"南京理工大学"）
- `\submitdate{...}` — 论文提交日期

### 脊背

- `\titleBackbone{...}` — 脊背标题（用 `\\` 换行）
- `\schoolBackbone{...}` — 脊背学校名

### 英文封面

- `\englishtitle{...}`、`\englishauthor{...}`
- `\englishadvisor{...}`、`\englishadvisortitle{...}`
- `\englishcoadvisor{...}`、`\englishcoadvisortitle{...}`
- `\englishdegree{...}`、`\englishmajor{...}`
- `\englishinstitute{...}`、`\englishdate{...}`（默认自动生成当前月份年份）

### 声明页

- `\signdate{...}` — 签名日期

### 封面生成

- `\makecover` — 一键生成所有封面页（推荐）
- 或单独调用：`\makefrontcover`、`\makebackbone`、`\makeincover`、`\makeenglishincover`、`\makestatement`

---

## 内容环境

### 摘要

```latex
\begin{abstract}
  中文摘要内容...
  \keywords{关键词1；关键词2；关键词3}
\end{abstract}

\begin{englishabstract}
  English abstract content...
  \englishkeywords{keyword1; keyword2; keyword3}
\end{englishabstract}
```

### 缩略语对照表

```latex
\begin{abbr}
  \abbreviation{英文缩写}{英文全称}{中文全称}
  \abbreviation{SMJ}{supersonic milk jetting}{超音速牛奶喷射}
\end{abbr}
```

### 符号表

```latex
\begin{symbols}
  \notation{符号}{含义说明}
  \notation{$\mathrm{log}(\cdot)$}{对数变换}
\end{symbols}
```

### 发表论文列表

```latex
\begin{publications}
  \pubitem 作者. 论文标题[J]. 期刊名, 年份, 卷: 页.
  \pubitem 作者. 论文标题[J]. 期刊名, 年份, 卷: 页.
\end{publications}
```

### 致谢

```latex
\begin{thanks}
  致谢内容...
\end{thanks}
```

### 定理环境

```latex
\begin{definition} ... \end{definition}    % 定义
\begin{theorem} ... \end{theorem}          % 定理
\begin{lemma} ... \end{lemma}              % 引理
\begin{proposition} ... \end{proposition}   % 命题
\begin{corollary} ... \end{corollary}       % 推论
\begin{algorithm} ... \end{algorithm}       % 算法
\begin{example} ... \end{example}           % 例
\begin{remark} ... \end{remark}             % 注
\begin{proof} ... \end{proof}               % 证明
```

---

## 字体选项

通过 `font` 类选项选择中文字体方案：

| 选项 | 宋体 | 黑体 | 楷体 | 魏碑 | 适用场景 |
|------|------|------|------|------|---------|
| `font=embedded`（默认） | simsun.ttc | simhei.ttf | simkai.ttf | weibei.ttf | 离线/Overleaf，自包含 |
| `font=fandol` | FandolSong | FandolHei | FandolKai | FandolKai | TeX Live 自带，无授权问题 |
| `font=system` | SimSun | SimHei | KaiTi | KaiTi | 仅 Windows，体积最小 |

```latex
% 使用 Fandol 开源字体（推荐 Overleaf 用户）
\documentclass[eprint,font=fandol]{njusttt}

% 使用 Windows 系统字体
\documentclass[eprint,font=system]{njusttt}
```

---

## 参考文献

参考文献按章节组织，在 `njusttt.def` 中声明了默认的 6 个 `.bib` 文件。如需修改，在 `main.tex` 导言区覆盖：

```latex
% 在 \begin{document} 之前添加
\addbibresource{ref/ch1.bib}
\addbibresource{ref/ch2.bib}
```

使用 GB/T 7714-2015 标准格式，通过 `biblatex-gb7714-2015` 实现。引用方式：`\cite{key}` 或 `\parencite{key}`。

---

## 环境要求

- TeX Live 2023+ 或等效发行版
- XeLaTeX 编译器
- Biber 参考文献工具
- CTAN 宏包：`ctex`、`geometry`、`fancyhdr`、`mathtools`、`amsthm`、`biblatex-gb7714-2015`、`caption`、`booktabs`、`multirow`、`tabularx`、`threeparttable`、`enumitem`、`hyperref`、`siunitx`、`algorithm`、`algorithmic`、`fontspec`

---

## 已测试编译环境

1. Windows 11 + TeX Live 2023 + XeLaTeX
2. Overleaf + XeLaTeX

---

## 常见问题

**Q: 编译时出现 `Font "xxx" does not contain requested Script "CJK"` 警告？**

A: 使用 `font=fandol` 选项，或在 Overleaf 上将编译器设置为 XeLaTeX。此警告通常不影响生成效果。

**Q: 想换成硕士论文模板怎么办？**

A: 目前模板默认为博士学位论文。如需硕士论文，修改 `njusttt.def` 中 `\NJUST@label@thesis` 和 `\NJUST@value@incoverthesis` 的值，将"博士"改为"硕士"即可。

---

## 致谢

本模板基于 [pasteller/njusttt](https://github.com/pasteller/njusttt) 完全重构，并修改自更早期的前人成果，包括但不限于：

- pasteller/njusttt：https://github.com/pasteller/njusttt
- njustThesis：https://github.com/jiec827/njustThesis

---

## 许可证

MIT License
