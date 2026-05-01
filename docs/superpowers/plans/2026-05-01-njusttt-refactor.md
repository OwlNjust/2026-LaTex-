# NJUST Thesis Template Refactoring — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Complete refactoring of NJUST LaTeX thesis template into a clean two-layer architecture (`.cls` engine + `.def` definitions), with all existing functionality preserved.

**Architecture:** Two files — `njusttt.cls` handles all typesetting logic and package loading; `njusttt.def` contains every user-facing label string, default value, configuration command, and font setup. User writes `\documentclass[eprint]{njusttt}` and works with flat `tex/` directory for content.

**Tech Stack:** XeLaTeX + biber, ctexbook class, biblatex-gb7714-2015, geometry, fancyhdr, amsthm

---

### Task 1: VS Code Build Recipes

**Files:**
- Create: `.vscode/settings.json`

- [ ] **Step 1: Create `.vscode/settings.json` with biber recipe**

```json
{
    "latex-workshop.latex.tools": [
        {
            "name": "biber",
            "command": "biber",
            "args": [
                "%DOCFILE%"
            ]
        }
    ],
    "latex-workshop.latex.recipes": [
        {
            "name": "xelatex → biber → xelatex → xelatex",
            "tools": [
                "xelatex",
                "biber",
                "xelatex",
                "xelatex"
            ]
        }
    ]
}
```

- [ ] **Step 2: Verify file exists**

Run: `cat .vscode/settings.json`
Expected: Valid JSON printed to terminal

---

### Task 2: Create `njusttt.def` — Definition Layer

**Files:**
- Create: `njusttt.def`

- [ ] **Step 1: Create file header and font setup (conditionals set by .cls)**

```latex
\ProvidesFile{njusttt.def}[2026/05/01 v1.0 NJUST thesis template definitions]

%% ========================================
%%  Font setup (three tiers, flags set by njusttt.cls)
%% ========================================

%% Embedded fonts (default)
\ifNJUST@font@embedded
  \setCJKfamilyfont{song}[AutoFakeBold={3},Path=fonts/]{simsun.ttc}
  \setCJKfamilyfont{kai}[AutoFakeBold={3},Path=fonts/]{simkai.ttf}
  \setCJKfamilyfont{hei}[AutoFakeBold={3},Path=fonts/]{simhei.ttf}
  \setCJKfamilyfont{weibei}[AutoFakeBold={3},Path=fonts/]{weibei.ttf}
\fi

%% Fandol (CTAN, free)
\ifNJUST@font@fandol
  \setCJKfamilyfont{song}[AutoFakeBold={3}]{FandolSong-Regular}
  \setCJKfamilyfont{kai}[AutoFakeBold={3}]{FandolKai-Regular}
  \setCJKfamilyfont{hei}[AutoFakeBold={3}]{FandolHei-Regular}
  \setCJKfamilyfont{weibei}[AutoFakeBold={3}]{FandolKai-Regular}
\fi

%% System fonts (Windows)
\ifNJUST@font@system
  \setCJKfamilyfont{song}[AutoFakeBold={3}]{SimSun}
  \setCJKfamilyfont{kai}[AutoFakeBold={3}]{KaiTi}
  \setCJKfamilyfont{hei}[AutoFakeBold={3}]{SimHei}
  \setCJKfamilyfont{weibei}[AutoFakeBold={3}]{KaiTi}
\fi

%% CJK font commands
\renewcommand{\songti}{\CJKfamily{song}}
\newcommand{\songbf}{\bfseries\CJKfamily{song}}
\newcommand{\kaibf}{\bfseries\CJKfamily{kai}}
\newcommand{\heibf}{\bfseries\CJKfamily{hei}}
\newcommand{\weibei}{\CJKfamily{weibei}}

%% Roman font commands
\newcommand{\rmn}{\normalfont\rmfamily}
\newcommand{\rmbf}{\normalfont\rmfamily\bfseries}
\newcommand{\rmit}{\normalfont\rmfamily\itshape}
\newcommand{\rmbfit}{\normalfont\rmfamily\bfseries\itshape}
```

- [ ] **Step 2: Add label definitions**

Append to file:

```latex
%% ========================================
%%  Label strings (change here for university rebranding)
%% ========================================

%% Abstract
\def\NJUST@label@abstract{摘\NJUSTspace 要}
\def\NJUST@label@keywords{关键词：}
\def\NJUST@label@englishabstract{Abstract}
\def\NJUST@label@englishkeywords{Keywords:\ }

%% TOC / LOF / LOT
\def\NJUST@contentsname{目\NJUSTspace 录}
\def\NJUST@listfigurename{插图目录}
\def\NJUST@listtablename{表格目录}
\def\NJUST@listfiguresandtablesname{图表目录}
\def\NJUST@figurename{图}
\def\NJUST@tablename{表}
\def\NJUST@bibname{参考文献}

%% Special pages
\def\NJUST@label@abbr{缩写与中英文对照表}
\def\NJUST@label@symbols{通用符号}
\def\NJUST@label@publications{附\NJUSTspace 录}
\def\NJUST@label@thanks{致\NJUSTspace 谢}

%% Cover header
\def\NJUST@label@classification{分类号}
\def\NJUST@label@confidential{密级}
\def\NJUST@label@UDC{UDC\raisebox{.15cm}{\scriptsize{注1}}}

%% Cover title & author
\def\NJUST@label@thesis{博\hspace{12pt} 士\hspace{12pt} 学\hspace{12pt} 位\hspace{12pt} 论\hspace{12pt} 文}
\def\NJUST@label@titleLab{（题名和副题名）}
\def\NJUST@label@authorLab{（作者姓名）}

%% Cover advisor fields
\def\NJUST@label@advisor{指导教师姓名}
\def\NJUST@label@coadvisor{ }
\def\NJUST@label@degree  {学\hspace{6pt} 位\hspace{6pt} 类\hspace{6pt} 别}
\def\NJUST@label@major   {学\hspace{6pt} 科\hspace{6pt} 名\hspace{6pt} 称}
\def\NJUST@label@interest{研\hspace{6pt} 究\hspace{6pt} 方\hspace{6pt} 向}
\def\NJUST@label@submitdate{论文提交时间}

%% Incover
\def\NJUST@label@incoverauthor{作\NJUSTspace 者:}
\def\NJUST@label@incoveradvisor{指导教师:}
\def\NJUST@label@incovercoadvisor{    }

%% English cover
\def\NJUST@label@englishdegree{Ph.D.~}
\def\NJUST@label@englishauthor{By}
\def\NJUST@label@englishadvisor{Supervised by Prof.~}
\def\NJUST@label@englishcoadvisor{    }

%% Statement
\def\NJUST@label@statement{声\hspace{15pt}明}
\def\NJUST@label@accredit{学位论文使用授权声明}
\def\NJUST@label@authorsign{研究生签名：\NJUSTunderline[3cm]{}}
\def\NJUST@label@signdate{\hspace{0.9cm} 年\hspace{0.9cm} 月\hspace{0.9cm} 日}
```

- [ ] **Step 3: Add default values**

Append to file:

```latex
%% ========================================
%%  Default values (user overrides via commands below)
%% ========================================

%% Header
\def\NJUST@value@classification{}
\def\NJUST@value@UDC{}
\def\NJUST@value@UDCfootnote{注1: 注明《国际十进分类法 UDC》的类号}
\def\NJUST@value@confidential{（无）}

%% Title & author
\def\NJUST@value@incoverthesis{博\hspace{6pt} 士\hspace{6pt} 学\hspace{6pt} 位\hspace{6pt} 论\hspace{6pt} 文}
\def\NJUST@value@pageDegree{博士学位论文}
\def\NJUST@value@title{（论文题目）}
\def\NJUST@value@titleUpp{（论文题目）}
\def\NJUST@value@titleLow{}
\def\NJUST@value@author{（作者姓名）}
\def\NJUST@value@titlemark{\NJUST@value@title}

%% Advisor
\def\NJUST@value@advisor{（导师姓名）}
\def\NJUST@value@advisortitle{（专业技术职务）}
\def\NJUST@value@coadvisor{（协同导师姓名）}
\def\NJUST@value@coadvisortitle{（专业技术职务）}
\def\NJUST@value@degree{（XX学位）}
\def\NJUST@value@major{（XX工程）}
\def\NJUST@value@interest{（XX方向）}
\def\NJUST@value@school{南京理工大学}
\def\NJUST@value@submitdate{yyyy.mm}
\def\NJUST@value@incoverdate{（yyyy年mm月dd日）}

%% Spine
\def\NJUST@value@titleBackbone{论\protect\\文\protect\\题\protect\\目}
\def\NJUST@value@schoolBackbone{学\\校\\名\\称}

%% English
\def\NJUST@value@englishdegree{(Ph.D.)}
\def\NJUST@value@englishtitle{(English Title of Thesis)}
\def\NJUST@value@englishauthor{(Author Name)}
\def\NJUST@value@englishadvisor{(Supervisor's Name)}
\def\NJUST@value@englishadvisortitle{(Professor)}
\def\NJUST@value@englishcoadvisor{(Co-supervisor's Name)}
\def\NJUST@value@englishcoadvisortitle{(Lecturer)}
\def\NJUST@value@englishmajor{(Aerospace Engineering)}
\def\NJUST@value@englishinstitute{(Nanjing University of Science \& Technology)}
\def\NJUST@value@englishdate{
  \ifcase\month
  \or January\or February\or March\or April
  \or May\or June\or July\or August\or September
  \or October\or November\or December
  \fi, \number\year}

%% Statements
\def\NJUST@value@statement{本学位论文是我在导师的指导下取得的研究成果，尽我所知，在本学位论文中，除了加以标注和致谢的部分外，不包含其他人已经发表或公布过的研究成果，也不包含我为获得任何教育机构的学位或学历而使用过的材料。与我一同工作的同事对本学位论文做出的贡献均已在论文中作了明确的说明。}
\def\NJUST@value@accredit{南京理工大学有权保存本学位论文的电子和纸质文档，可以借阅或上网公布本学位论文的部分或全部内容，可以向有关部门或机构送交并授权其保存、借阅或上网公布本学位论文的部分或全部内容。对于保密论文，按保密的有关规定和程序处理。}
```

- [ ] **Step 4: Add user configuration commands**

Append to file:

```latex
%% ========================================
%%  User configuration commands
%% ========================================

%% Header
\newcommand\classification[1]{\def\NJUST@value@classification{#1}}
\newcommand\UDC[1]{\def\NJUST@value@UDC{#1}}
\newcommand\UDCfootnote[1]{\def\NJUST@value@UDCfootnote{#1}}
\newcommand\confidential[1]{\def\NJUST@value@confidential{#1}}

%% Title & author
\newcommand\incoverthesis[1]{\def\NJUST@value@incoverthesis{#1}}
\renewcommand\title[2][\NJUST@value@title]{%
  \def\NJUST@value@title{#2}%
  \def\NJUST@value@titlemark{\MakeUppercase{#1}}}
\renewcommand\author[1]{\def\NJUST@value@author{#1}}
\newcommand\titleUpp[1]{\def\NJUST@value@titleUpp{#1}}
\newcommand\titleLow[1]{\def\NJUST@value@titleLow{#1}}

%% Advisor
\newcommand\advisor[1]{\def\NJUST@value@advisor{#1}}
\newcommand\advisortitle[1]{\def\NJUST@value@advisortitle{#1}}
\newcommand\coadvisor[1]{\def\NJUST@value@coadvisor{#1}}
\newcommand\coadvisortitle[1]{\def\NJUST@value@coadvisortitle{#1}}
\newcommand\degree[1]{\def\NJUST@value@degree{#1}}
\newcommand\major[1]{\def\NJUST@value@major{#1}}
\newcommand\interest[1]{\def\NJUST@value@interest{#1}}

%% Dates & school
\newcommand\school[1]{\def\NJUST@value@school{#1}}
\newcommand\submitdate[1]{\def\NJUST@value@submitdate{#1}}
\newcommand\incoverdate[1]{\def\NJUST@value@incoverdate{#1}}

%% Spine
\newcommand\titleBackbone[1]{\def\NJUST@value@titleBackbone{#1}}
\newcommand\schoolBackbone[1]{\def\NJUST@value@schoolBackbone{#1}}

%% English
\newcommand\englishtitle[1]{\def\NJUST@value@englishtitle{#1}}
\newcommand\englishauthor[1]{\def\NJUST@value@englishauthor{#1}}
\newcommand\englishadvisor[1]{\def\NJUST@value@englishadvisor{#1}}
\newcommand\englishadvisortitle[1]{\def\NJUST@value@englishadvisortitle{#1}}
\newcommand\englishcoadvisor[1]{\def\NJUST@value@englishcoadvisor{#1}}
\newcommand\englishcoadvisortitle[1]{\def\NJUST@value@englishcoadvisortitle{#1}}
\newcommand\englishdegree[1]{\def\NJUST@value@englishdegree{#1}}
\newcommand\englishmajor[1]{\def\NJUST@value@englishmajor{#1}}
\newcommand\englishinstitute[1]{\def\NJUST@value@englishinstitute{#1}}
\newcommand\englishdate[1]{\def\NJUST@value@englishdate{#1}}

%% Statements
\newcommand\statement[1]{\def\NJUST@value@statement{#1}}
\newcommand\accredit[1]{\def\NJUST@value@accredit{#1}}
\newcommand\signdate[1]{\def\NJUST@label@signdate{#1}}
```

- [ ] **Step 5: Add utility macros**

Append to file:

```latex
%% ========================================
%%  Utility macros
%% ========================================

%% Spacing used in vertical CJK headings
\newcommand\NJUSTspace{\protect\hspace{1em}\protect\hspace{1em}}

%% Underline helper
\def\NJUST@underline[#1]#2{\underline{\hbox to #1{\hfill#2\hfill}}}
\def\NJUSTunderline{\@ifnextchar[\NJUST@underline\underline}

%% Redefine \cleardoublepage for oneside+twoside compat
\def\cleardoublepage{
  \clearpage
  \if@twoside
    \ifodd\c@page
    \else
      \thispagestyle{empty}
      \hbox{}
      \newpage
      \if@twocolumn
        \hbox{}
        \newpage
      \fi
    \fi
  \fi}

%% \Nchapter: chapterify environments that appear in front/backmatter
\newcommand\Nchapter[1]{
    \if@mainmatter
        \@mainmatterfalse
        \chapter{#1}
        \@mainmattertrue
    \else
        \chapter{#1}
    \fi
}
```

- [ ] **Step 6: Add theorem environments and content environments**

Append to file:

```latex
%% ========================================
%%  Theorem-like environments
%% ========================================
\theoremstyle{plain}
\newtheorem{algo}{算法\ }[chapter]
\newtheorem{thm}{定理\ }[chapter]
\newtheorem{lem}[thm]{引理\ }
\newtheorem{prop}[thm]{命题\ }
\newtheorem{cor}[thm]{推论\ }
\theoremstyle{definition}
\newtheorem{defn}{定义\ }[chapter]
\newtheorem{conj}{猜想\ }[chapter]
\newtheorem{exmp}{例\ }[chapter]
\newtheorem{rem}{注\ }
\newtheorem{case}{情形\ }
\renewcommand{\proofname}{\bf 证明}

%% ========================================
%%  Content environments
%% ========================================

%% Chinese abstract
\newenvironment{abstract}{
  \ctexset{chapter={format+={\centering\zihao{3}}}}
  \Nchapter{\NJUST@label@abstract}
}{}

%% Chinese keywords
\newcommand\keywords[1]{\vspace{2ex}\noindent{\songbf\zihao{4}\NJUST@label@keywords}#1}

%% English abstract
\newenvironment{englishabstract}{
  \ctexset{chapter={format+={\centering\zihao{3}}}}
  \Nchapter{\NJUST@label@englishabstract}
}{}

%% English keywords
\newcommand\englishkeywords[1]{\vspace{2ex}\noindent{\rmbf\zihao{4}\NJUST@label@englishkeywords}#1}

%% Abbreviations
\newenvironment{abbr}{
  \ctexset{chapter={format+={\centering\zihao{3}}}}
  \Nchapter{\NJUST@label@abbr}
}{}
\newcommand\abbreviation[3]{%
  \noindent\makebox[0.25\textwidth][l]{\textbf{#3}}%
  {\textbf{#1}}\hfill{#2}\par}

%% Symbols
\newenvironment{symbols}{
  \ctexset{chapter={format+={\centering\zihao{3}}}}
  \Nchapter{\NJUST@label@symbols}
}{}
\newcommand\notation[2]{%
  \noindent\makebox[0.25\textwidth][l]{#1}{#2}\par}

%% Publications
\newenvironment{publications}{
  \ctexset{chapter={format+={\centering\zihao{3}}}}
  \Nchapter{\NJUST@label@publications}
  \begin{enumerate}[label=(\arabic*),leftmargin=*,itemsep=5pt,parsep=0pt]
}{\end{enumerate}}
\newcommand\pubitem{\item}

%% Thanks
\renewenvironment{thanks}{
  \ctexset{chapter={format+={\centering\zihao{3}}}}
  \Nchapter{\NJUST@label@thanks}
}{}

%% Enumerate label style
\renewcommand{\labelenumi}{(\theenumi)}

%% ========================================
%%  Bibliography resources (defaults)
%% ========================================
\addbibresource{ref/ch1.bib}
\addbibresource{ref/ch2.bib}
\addbibresource{ref/ch3.bib}
\addbibresource{ref/ch4.bib}
\addbibresource{ref/ch5.bib}
\addbibresource{ref/ch6.bib}
```

- [ ] **Step 7: Add end-of-file marker**

Append to file:

```latex
\endinput
```

- [ ] **Step 8: Verify `njusttt.def` is syntactically valid**

Run: `cat njusttt.def | wc -l`
Expected: ~350 lines, well-structured file

---

### Task 3: Create `njusttt.cls` — Typesetting Engine

**Files:**
- Create: `njusttt.cls`

- [ ] **Step 1: Create file header and class identity**

```latex
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{njusttt}[2026/05/01 v1.0 NJUST thesis template]

%% ========================================
%%  Class options (declared HERE so option processing works)
%% ========================================
\newif\ifNJUST@print \NJUST@printfalse
\DeclareOption{print}{\NJUST@printtrue}
\DeclareOption{eprint}{\NJUST@printfalse}

%% Font options
\newif\ifNJUST@font@embedded
\newif\ifNJUST@font@fandol
\newif\ifNJUST@font@system
\DeclareOption{font=embedded}{\NJUST@font@embeddedtrue}
\DeclareOption{font=fandol}{\NJUST@font@fandoltrue}
\DeclareOption{font=system}{\NJUST@font@systemtrue}
\ExecuteOptions{font=embedded}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessOptions\relax
```

- [ ] **Step 2: Load base class and all third-party packages**

Append to file:

```latex
%% ========================================
%%  Base class
%% ========================================
\LoadClass[a4paper,zihao=-4,UTF8,fontset=none]{ctexbook}

%% ========================================
%%  Required packages
%% ========================================
\RequirePackage[top=2.54cm,bottom=2.54cm,left=2.54cm,right=2.54cm,
  headheight=15pt,footskip=32pt,
  textwidth=16truecm,textheight=24truecm]{geometry}

\RequirePackage{fancyhdr}
\RequirePackage{mathtools,amsthm,amsfonts,amssymb,bm}
\RequirePackage{graphicx,flafter}
\RequirePackage[margin=10.5pt,font=small]{caption}
\RequirePackage[section]{placeins}
\RequirePackage{overpic}

%% Math
\RequirePackage{amsmath,amssymb,amstext}

%% Algorithms
\RequirePackage{algorithm}
\RequirePackage{algorithmic}
\floatname{algorithm}{算法}
\renewcommand{\algorithmicrequire}{\textbf{输入：}}
\renewcommand{\algorithmicensure}{\textbf{输出：}}

%% Units
\RequirePackage{siunitx}
\sisetup{number-mode=text}

%% Bibliography (GB7714-2015)
\RequirePackage[backend=biber,style=numeric,sorting=none,
  gbpub=false,bibstyle=gb7714-2015,citestyle=gb7714-2015,
  gbnamefmt=lowercase]{biblatex}

%% Tables
\RequirePackage{booktabs}
\RequirePackage{multirow}
\RequirePackage{tabularx}
\newcolumntype{C}{>{\centering\arraybackslash}X}
\renewcommand\arraystretch{1.3}
\let\oldtabularx\tabularx
\renewcommand{\tabularx}{\zihao{5}\oldtabularx}
\RequirePackage{xcolor,colortbl}
\RequirePackage{threeparttable}

%% Lists
\RequirePackage{enumitem}
\setenumerate[1]{itemsep=0pt,partopsep=0pt,parsep=\parskip,topsep=3.0pt}
\setitemize[1]{itemsep=0pt,partopsep=0pt,parsep=\parskip,topsep=3.0pt}

%% Caption setup
\DeclareCaptionLabelSeparator{none}{ }
\captionsetup{labelsep=none}
\captionsetup[figure]{skip=5pt}
\captionsetup[table]{skip=5pt}
\setlength{\abovecaptionskip}{0pt}
\setlength{\belowcaptionskip}{-2pt}

%% Display math spacing
\setlength\abovedisplayskip{0pt}
\setlength\belowdisplayskip{0pt}

%% Graphics extensions
\DeclareGraphicsExtensions{.pdf,.png,.jpg}

%% TOC depth
\setcounter{tocdepth}{2}
\setcounter{secnumdepth}{3}
```

- [ ] **Step 3: Load definition layer**

Append to file:

```latex
%% ========================================
%%  Load definitions (labels, defaults, user commands, fonts)
%% ========================================
\InputIfFileExists{njusttt.def}{}{
  \ClassError{njusttt}{njusttt.def not found}{Place njusttt.def next to njusttt.cls}
}
```

- [ ] **Step 4: Hyperref (must come after definitions)**

Append to file:

```latex
%% ========================================
%%  Hyperlinks
%% ========================================
\ifxetex
  \RequirePackage[xetex]{hyperref}
\else
  \ifpdf
    \RequirePackage[pdftex]{hyperref}
  \fi
\fi

\hypersetup{
  pdffitwindow=false,
  pdfstartview={FitH},
  colorlinks=true,
  linkcolor=black,
  citecolor=black,
  filecolor=black,
  urlcolor=black
}
```

- [ ] **Step 5: Fontspec (after hyperref)**

Append to file:

```latex
%% ========================================
%%  Font setup
%% ========================================
\RequirePackage{fontspec}
\defaultfontfeatures{Ligatures=TeX}
\setmainfont[
  BoldFont=Times New Roman Bold,
  ItalicFont=Times New Roman Italic
]{Times New Roman}
\xeCJKsetup{CJKecglue={\hskip 0pt plus 0.08\baselineskip}}
```

- [ ] **Step 6: Page headers**

Append to file:

```latex
%% ========================================
%%  Headers and footers
%% ========================================
\newcommand\pageDegree[1]{\def\NJUST@value@pageDegree{#1}}

%% Page number style: Roman for frontmatter
\renewcommand\frontmatter{\pagenumbering{Roman}}

%% Page style: plain (chapter start pages)
\fancypagestyle{plain}{
  \fancyhf{}
  \fancyhead[LO]{\songti\zihao{-5}\NJUST@value@pageDegree}
  \fancyhead[RO]{\songti\zihao{-5}\NJUST@value@titlemark}
  \fancyhead[LE]{\songti\zihao{-5}\leftmark}
  \fancyhead[RE]{\songti\zihao{-5}\NJUST@value@pageDegree}
  \fancyfoot[RO,LE]{\zihao{-5}~\thepage~}
}

%% Page style: fancy (normal pages)
\pagestyle{fancy}
\fancyhf{}
\fancyhead[LO]{\songti\zihao{-5}\NJUST@value@pageDegree}
\fancyhead[RO]{\songti\zihao{-5}\NJUST@value@titlemark}
\fancyhead[LE]{\songti\zihao{-5}\leftmark}
\fancyhead[RE]{\songti\zihao{-5}\NJUST@value@pageDegree}
\fancyfoot[RO,LE]{\zihao{-5}~\thepage~}
```

- [ ] **Step 7: Cover page generation — `\makefrontcover`**

Append to file:

```latex
%% ========================================
%%  Cover generation
%% ========================================
\newcommand\makefrontcover{
  \cleardoublepage
  \thispagestyle{empty}
  \begin{center}
    %% Header
    \songti\zihao{5}
    \hspace{27.6pt}
    \NJUST@label@classification~
    \NJUSTunderline[100pt]{\NJUST@value@classification}
    \hfill
    \NJUST@label@confidential~
    \NJUSTunderline[100pt]{\NJUST@value@confidential}
    \hspace{27.6pt}
    \vskip 10pt
    \hspace{27.6pt}
    \NJUST@label@UDC~
    \NJUSTunderline[96pt]{\NJUST@value@UDC}
    \hfill
    \NJUSTunderline[0pt]{}
    \vskip 10pt

    %% Logo
    \parbox[c][4cm][c]{\textwidth}{
      \centering
      \includegraphics[width=12.5cm]{fig/logo/njust.eps}
    }

    %% Title & author
    \vskip 10pt
    \newcommand{\zihaopt}{\fontsize{32pt}{\baselineskip}\selectfont}
    {\kaibf\zihaopt\NJUST@label@thesis}
    \vskip \stretch{2}
    {\vskip 10pt
      \heibf\zihao{-1}\NJUSTunderline[400pt]{~\NJUST@value@titleUpp~}
      \vskip 10pt
      \NJUSTunderline[400pt]{~\NJUST@value@titleLow~}} \\
    \songti\zihao{-4}{\NJUST@label@titleLab}
    \vskip \stretch{2}
    {\kaibf\zihao{-2}\NJUSTunderline[180pt]{~\NJUST@value@author~}} \\
    \songti\zihao{-4}{\NJUST@label@authorLab}
    \vskip \stretch{2}
    \def\tabcolsep{1pt}
    \def\arraystretch{1.25}
    \begin{tabular}{cc}
      \songbf\zihao{4}\NJUST@label@advisor    & \NJUSTunderline[299pt]{{\kaibf\zihao{3}\NJUST@value@advisor}\hspace{4pt}{\kaibf\zihao{4}\NJUST@value@advisortitle}}     \\
      \songbf\zihao{4}\NJUST@label@coadvisor  & \NJUSTunderline[299pt]{{\kaibf\zihao{3}\NJUST@value@coadvisor}\hspace{4pt}{\kaibf\zihao{4}\NJUST@value@coadvisortitle}} \\
      \songbf\zihao{4}\NJUST@label@degree     & \NJUSTunderline[299pt]{\kaibf\zihao{3}\NJUST@value@degree}                                                                \\
      \songbf\zihao{4}\NJUST@label@major      & \NJUSTunderline[299pt]{\kaibf\zihao{3}\NJUST@value@major}                                                                 \\
      \songbf\zihao{4}\NJUST@label@interest   & \NJUSTunderline[299pt]{\kaibf\zihao{3}\NJUST@value@interest}                                                              \\
      \songbf\zihao{4}\NJUST@label@submitdate & \NJUSTunderline[299pt]{\kaibf\zihao{3}\NJUST@value@submitdate}
    \end{tabular}
  \end{center}

  %% Footnote
  \vspace{2em}
  {\songti\zihao{5}\NJUST@value@UDCfootnote}

  %% Reset to default font
  \songti
}
```

- [ ] **Step 8: Cover generation — `\makebackbone`**

Append to file:

```latex
\newcommand\makebackbone{
  \clearpage
  \if@twoside
    \thispagestyle{empty}
    \begin{center}
      \kaibf\zihao{-4}{\NJUST@value@titleBackbone}
      \vskip \stretch{8}
      \vfill
      \kaibf\zihao{-4}{\NJUST@value@schoolBackbone}
    \end{center}
    \ifNJUST@print\else
      \vspace*{\stretch{1}}
      \begin{footnotesize}
        \noindent
      \end{footnotesize}
    \fi
    \cleardoublepage
  \fi
}
```

- [ ] **Step 9: Cover generation — `\makeincover`**

Append to file:

```latex
\newcommand\makeincover{
  \cleardoublepage
  \thispagestyle{empty}
  \begin{center}
    \weibei\zihao{-2}\NJUST@value@incoverthesis
    \\[2cm]
    \heibf\zihao{2}\NJUST@value@title
    \\[3cm]
    \begin{tabular}{rl}
      \kaibf\zihao{-2}\NJUST@label@incoverauthor  & \kaibf\zihao{-2}\NJUST@value@author
      \\[25pt]
      \kaibf\zihao{-2}\NJUST@label@incoveradvisor & {\kaibf\zihao{-2}\NJUST@value@advisor\hspace{4pt}}{\kaibf\zihao{3}\NJUST@value@advisortitle}
      \\
      \kaibf\zihao{-2}\NJUST@label@incovercoadvisor & {\kaibf\zihao{-2}\NJUST@value@coadvisor\hspace{4pt}}{\kaibf\zihao{3}\NJUST@value@coadvisortitle}
    \end{tabular}
    \vskip \stretch{2}
    \songbf\zihao{-2}\NJUST@value@school
    \vskip 8pt
    \songbf\zihao{-2}\NJUST@value@incoverdate
  \end{center}
  \clearpage
  \if@twoside
    \thispagestyle{empty}
    \cleardoublepage
  \fi
}
```

- [ ] **Step 10: Cover generation — `\makeenglishincover`**

Append to file:

```latex
\newcommand\makeenglishincover{
  \cleardoublepage
  \thispagestyle{empty}
  \begin{center}
    \vspace*{-18pt}
    \rmn\zihao{-2}\NJUST@label@englishdegree\NJUST@value@englishdegree
    \vskip 60pt
    \rmbf\zihao{2}\NJUST@value@englishtitle
    \vskip 30pt
    \rmit\zihao{-2}\NJUST@label@englishauthor
    \\
    \rmbfit\zihao{-2}\NJUST@value@englishauthor
    \vskip 60pt
    \begin{tabular}{rl}
      \rmit\zihao{-2}\NJUST@label@englishadvisor   & \rmbfit\zihao{-2}\NJUST@value@englishadvisor   \\
      \rmit\zihao{-2}\NJUST@label@englishcoadvisor & \rmbfit\zihao{-2}\NJUST@value@englishcoadvisor
    \end{tabular}
    \vskip \stretch{2}
    \rmn\zihao{-2}\NJUST@value@englishinstitute
    \vskip 12pt
    \rmn\zihao{-2}\NJUST@value@englishdate
  \end{center}
  \clearpage
  \if@twoside
    \thispagestyle{empty}
    \cleardoublepage
  \fi
}
```

- [ ] **Step 11: Cover generation — `\makestatement`**

Append to file:

```latex
\newcommand\makestatement{
  \cleardoublepage
  \thispagestyle{empty}
  \begin{center}
    \vspace*{12pt}
    \parbox{\textwidth}{\centering\bf\songbf\zihao{3}\NJUST@label@statement}
    \vskip 1.6cm
    \parbox{\textwidth}{\songti\zihao{4}\renewcommand{\baselinestretch}{1.6}\hspace{2em}\zihao{4}\NJUST@value@statement}
    \vskip 1.8cm
    \parbox{\textwidth}{\noindent{}\zihao{4}\NJUST@label@authorsign\hspace{3.5cm}\NJUST@label@signdate}
    \vskip 4.45cm

    \parbox{\textwidth}{\centering\bf\songbf\zihao{3}\NJUST@label@accredit}
    \vskip 1.6cm
    \parbox{\textwidth}{\songti\zihao{4}\renewcommand{\baselinestretch}{1.6}\hspace{2em}\zihao{4}\NJUST@value@accredit}
    \vskip 1.8cm
    \parbox{\textwidth}{\noindent{}\zihao{4}\NJUST@label@authorsign\hspace{3.5cm}\NJUST@label@signdate}
  \end{center}
  \clearpage
  \if@twoside
    \thispagestyle{empty}
    \cleardoublepage
  \fi
}
```

- [ ] **Step 12: Cover generation — convenience wrapper `\makecover`**

Append to file:

```latex
\newcommand\makecover{
  \makefrontcover
  \makebackbone
  \makeincover
  \makeenglishincover
  \makestatement
}
```

- [ ] **Step 13: Table of Contents formatting**

Append to file:

```latex
%% ========================================
%%  Table of Contents
%% ========================================
\renewcommand*\l@chapter[2]{
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}
    \vskip 0.3em \@plus\p@
    \setlength\@tempdima{1.5em}
    \begingroup
    \parindent \z@ \rightskip \@pnumwidth
    \parfillskip -\@pnumwidth
    \leavevmode \songbf\zihao{4}
    \advance\leftskip\@tempdima
    \hskip -\leftskip
    #1\nobreak
    \leaders\hbox{$\m@th\mkern 2mu\bm{\bm\cdot}\mkern 5mu$}
    \hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
    \penalty\@highpenalty
    \endgroup
  \fi
}
\renewcommand\tableofcontents{
  \if@twocolumn
    \@restonecoltrue\onecolumn
  \else
    \@restonecolfalse
  \fi
  {\ctexset{chapter={format+={\centering\zihao{3}}}}\chapter*{\NJUST@contentsname}}
  \@mkboth{\MakeUppercase\NJUST@contentsname}{\MakeUppercase\NJUST@contentsname}
  \@starttoc{toc}
  \if@restonecol\twocolumn\fi
}
\addtocontents{toc}{\let\string\quad\relax}
```

- [ ] **Step 14: List of Figures/Tables/Figures+Tables**

Append to file:

```latex
%% ========================================
%%  List of Figures and Tables
%% ========================================
\renewcommand*\listoffigures{
  {\ctexset{chapter={format+={\centering\zihao{3}}}}\chapter*{\NJUST@listfigurename}}
  \@mkboth{\MakeUppercase\NJUST@listfigurename}{\MakeUppercase\NJUST@listfigurename}
  \@starttoc{lof}
}

\renewcommand*\listoftables{
  {\ctexset{chapter={format+={\centering\zihao{3}}}}\chapter*{\NJUST@listtablename}}
  \@mkboth{\MakeUppercase\NJUST@listtablename}{\MakeUppercase\NJUST@listtablename}
  \@starttoc{lot}
}

\newcommand*\listoffiguresandtables{
  {\ctexset{chapter={format+={\centering\zihao{3}}}}\chapter*{\NJUST@listfiguresandtablesname}}
  \@mkboth{\MakeUppercase\NJUST@listfiguresandtablesname}{\MakeUppercase\NJUST@listfiguresandtablesname}
  {
    \let\oldnumberline\numberline
    \renewcommand{\numberline}{\figurename~\oldnumberline}
    \@starttoc{lof}
  }
  \bigskip
  {
    \let\oldnumberline\numberline
    \renewcommand{\numberline}{\tablename~\oldnumberline}
    \@starttoc{lot}
  }
}
```

- [ ] **Step 15: Chapter/section style**

Append to file:

```latex
%% ========================================
%%  Chapter and section styles
%% ========================================
\ctexset{
  chapter={
    format={\songbf\zihao{-3}},
    name={,},number={\arabic{chapter}},
    beforeskip={0pt},afterskip={18pt}
  },
  section={
    format={\songbf\zihao{4}},
    beforeskip={12pt},afterskip={12pt}
  },
  subsection={
    format={\songbf\zihao{-4}},
    beforeskip={6pt},afterskip={6pt}
  },
  subsubsection={
    format={\zihao{-4}},
    beforeskip={6pt},afterskip={6pt},
    indent={2\ccwd}
  }
}
```

- [ ] **Step 16: Utility commands and end-of-file**

Append to file:

```latex
%% ========================================
%%  Helper commands for user convenience
%% ========================================
\newcommand{\dw}[2]{~\SI{#1}{#2}}
\newcommand{\td}[0]{~\~{}~}

%% Bibliography print command
\newcommand\NJUSTprintbib{
  \cleardoublepage
  \phantomsection
  \addcontentsline{toc}{chapter}{\NJUST@bibname}
  \printbibliography
}

\endinput
```

- [ ] **Step 17: Verify `.cls` file structure**

Run: `cat njusttt.cls | wc -l`
Expected: ~500 lines, well-structured

---

### Task 4: Move Fonts Directory

**Files:**
- Create: `fonts/` directory
- Delete: `sty/font/` (after move)

- [ ] **Step 1: Move font files from `sty/font/` to `fonts/`**

Run:
```bash
mkdir fonts
mv sty/font/* fonts/
rmdir sty/font
```

- [ ] **Step 2: Verify fonts exist at new location**

Run: `ls fonts/`
Expected: `simhei.ttf  simkai.ttf  simsun.ttc  weibei.ttf`

---

### Task 5: Update `main.tex`

**Files:**
- Modify: `main.tex`

- [ ] **Step 1: Rewrite `main.tex`**

```latex
\documentclass[eprint]{njusttt}

\begin{document}

\input{tex/cover}

\frontmatter
\input{tex/abstract}

\cleardoublepage
\phantomsection
\addcontentsline{toc}{chapter}{目\NJUSTspace 录}
\tableofcontents

\cleardoublepage
\phantomsection
\addcontentsline{toc}{chapter}{图表目录}
\listoffiguresandtables

\input{tex/abbreviations}
\input{tex/symbols}

\mainmatter
\input{tex/ch1}
\input{tex/ch2}
\input{tex/ch3}
\input{tex/ch4}
\input{tex/ch5}
\input{tex/ch6}

\backmatter
\input{tex/thanks}

\cleardoublepage
\phantomsection
\addcontentsline{toc}{chapter}{参考文献}
\printbibliography

\input{tex/publications}

\end{document}
```

---

### Task 6: Update Content Files

**Files:**
- Modify: `tex/abbreviations.tex`
- Modify: `tex/symbols.tex`
- Modify: `tex/publications.tex`

- [ ] **Step 1: Rewrite `tex/abbreviations.tex`**

```latex
\begin{abbr}

\abbreviation{SMJ}{supersonic milk jetting}{超音速牛奶喷射}
\abbreviation{TT}{time travel}{时间旅行}
\abbreviation{PBD}{probabilistic dynamics}{概率动力学}
\abbreviation{STN}{spatio-temporal navigation}{时空导航}
\abbreviation{LVR}{logistic variable regression}{逻辑变量回归}
\abbreviation{DHC}{differential heterogeneity curvature}{差分异质曲率}

\end{abbr}
```

- [ ] **Step 2: Rewrite `tex/symbols.tex`**

```latex
\begin{symbols}

\notation{$\mathrm{log}(\cdot)$}{对数变换}
\notation{$\mathrm{argmin}(\cdot)$}{取最小值的位置}

\end{symbols}
```

- [ ] **Step 3: Rewrite `tex/publications.tex`**

```latex
\begin{publications}

\pubitem \textbf{ChatGPT} and Klayden. Dynamics of Supersonic Milk Jet and Time Travel[J]. Journal of Advanced Physics, 2024, 34: 43-62.（SCI检索：000000000000001）
\pubitem \textbf{ChatGPT} and Klayden. Quantum Effects in Supersonic Milk Jet and Time Travel: A Probabilistic Approach[J]. International Journal of Theoretical Physics, 2024, 12:123-145.（SCI检索：000000000000002）

\end{publications}
```

---

### Task 7: Clean Up Old Files

**Files:**
- Delete: `sty/njusttt.cls`
- Delete: `sty/njusttt.cfg`
- Delete: `sty/customize.sty`
- Delete: `sty/` directory (if empty after removal)

- [ ] **Step 1: Delete old files**

Run:
```bash
rm sty/njusttt.cls sty/njusttt.cfg sty/customize.sty
rmdir sty 2>/dev/null || echo "sty directory not empty (fonts moved already)"
```

- [ ] **Step 2: Verify old files are gone**

Run: `ls sty/ 2>&1 || echo "sty/ removed"`
Expected: `sty/ removed` or empty

---

### Task 8: Write README.md

**Files:**
- Create/Overwrite: `README.md`

- [ ] **Step 1: Write comprehensive README.md**

```markdown
# NJUST Thesis Template (南京理工大学学位论文 LaTeX 模板)

A LaTeX thesis template for doctoral dissertations at Nanjing University of Science & Technology (南京理工大学).

## Quick Start

### 1. Clone or download this repository

### 2. Open `main.tex` in your LaTeX editor

### 3. Configure your thesis metadata

Edit `tex/cover.tex` to set your title, author, advisor, and other metadata:

`\title[Short title]{Full Chinese Title}`
`\titleUpp{Title upper line}`
`\titleLow{Title lower line}`
`\author{Your Name}`
`\advisor{Advisor Name}\advisortitle{Professor}`
... (see full list below)

### 4. Write your chapters

Edit `tex/ch1.tex` through `tex/ch6.tex` (add/remove files in `main.tex`).

### 5. Compile

**Recipe:** `xelatex → biber → xelatex → xelatex`

- **VS Code + LaTeX Workshop:** Select recipe `xelatex → biber → xelatex → xelatex`
- **Overleaf:** Set compiler to XeLaTeX, use `xelatex` as compiler
- **Command line:**
```
xelatex main.tex
biber main
xelatex main.tex
xelatex main.tex
```

---

## Project Structure

```
njusttt-main/
├── main.tex              # Entry point
├── njusttt.cls            # Document class (typesetting engine)
├── njusttt.def            # Definitions (labels, defaults, fonts)
├── tex/                   # Your content
│   ├── cover.tex          #   Metadata + cover generation
│   ├── abstract.tex       #   Chinese + English abstracts
│   ├── ch1.tex ~ ch6.tex  #   Chapter content
│   ├── abbreviations.tex  #   Abbreviation list
│   ├── symbols.tex        #   Symbol list
│   ├── thanks.tex         #   Acknowledgements
│   └── publications.tex   #   Publication list
├── ref/                   # Bibliography (.bib files)
├── fig/                   # Images and figures
├── fonts/                 # Embedded CJK fonts (optional)
└── .vscode/               # VS Code build recipes
```

---

## Architecture

The template has a **two-layer design**:

| File | Role | When to modify |
|------|------|---------------|
| `njusttt.cls` | Typesetting engine: page layout, headers, cover logic, TOC formatting, package loading | Rarely — only if formatting rules change |
| `njusttt.def` | Definition layer: all label strings (CN/EN), default values, user commands, font configuration, theorem environments | When university branding/labels change |

The user only writes `\documentclass[eprint]{njusttt}` — `.cls` automatically loads `.def`.

---

## Configuration Commands

Set these in `tex/cover.tex` before calling `\makecover`:

### Classification Header
- `\classification{...}` — Classification number
- `\confidential{...}` — Confidentiality level
- `\UDC{...}` — UDC number

### Title
- `\title[Short]{Full Title}` — Full title (short form appears in headers)
- `\titleUpp{...}` — Upper line on cover
- `\titleLow{...}` — Lower line on cover

### Author & Advisor
- `\author{...}` — Author name
- `\advisor{...}` / `\advisortitle{...}` — Advisor name and title
- `\coadvisor{...}` / `\coadvisortitle{...}` — Co-advisor name and title

### Degree Info
- `\degree{...}` — Degree (e.g. 工学博士)
- `\major{...}` — Major
- `\interest{...}` — Research direction
- `\school{...}` — University name
- `\submitdate{...}` — Submission date

### Spine
- `\titleBackbone{...}` — Title on spine (use `\\` for line breaks)
- `\schoolBackbone{...}` — School name on spine

### English Cover
- `\englishtitle{...}`, `\englishauthor{...}`,
- `\englishadvisor{...}`, `\englishadvisortitle{...}`,
- `\englishcoadvisor{...}`, `\englishcoadvisortitle{...}`,
- `\englishdegree{...}`, `\englishmajor{...}`,
- `\englishinstitute{...}`, `\englishdate{...}`

### Statement
- `\signdate{...}` — Signature date

### Cover Generation
- `\makecover` — Generate ALL cover pages (wrapper)
- Or individually: `\makefrontcover`, `\makebackbone`, `\makeincover`, `\makeenglishincover`, `\makestatement`

---

## Environments

### Abstract
```latex
\begin{abstract}
  中文摘要...
  \keywords{关键词1；关键词2}
\end{abstract}

\begin{englishabstract}
  English abstract...
  \englishkeywords{keyword1; keyword2}
\end{englishabstract}
```

### Abbreviations
```latex
\begin{abbr}
  \abbreviation{缩写}{英文全称}{中文全称}
\end{abbr}
```

### Symbols
```latex
\begin{symbols}
  \notation{符号}{含义}
\end{symbols}
```

### Publications
```latex
\begin{publications}
  \pubitem 论文信息...
\end{publications}
```

### Thanks
```latex
\begin{thanks}
  致谢内容...
\end{thanks}
```

### Theorems
```latex
\begin{definition} ... \end{definition}
\begin{theorem} ... \end{theorem}
\begin{lemma} ... \end{lemma}
\begin{proposition} ... \end{proposition}
\begin{corollary} ... \end{corollary}
\begin{algorithm} ... \end{algorithm}
\begin{example} ... \end{example}
\begin{remark} ... \end{remark}
\begin{proof} ... \end{proof}
```

---

## Font Options

The class accepts a `font` option for CJK font selection:

- **`font=embedded`** (default) — Use bundled fonts from `fonts/` directory. Self-contained, works offline.
- **`font=fandol`** — Use Fandol fonts from CTAN. Free, no license issues, auto-installed with TeX Live.
- **`font=system`** — Use Windows system fonts (SimSun, SimHei, KaiTi). Smallest, but Windows-only.

```latex
\documentclass[eprint,font=fandol]{njusttt}
```

---

## Bibliography

Bibliography files are loaded per chapter. Edit the list in `njusttt.def` or override in `main.tex`:

```latex
\addbibresource{ref/ch1.bib}
\addbibresource{ref/ch2.bib}
% ...
```

Uses GB/T 7714-2015 citation style via `biblatex-gb7714-2015`.

---

## Requirements

- TeX Live 2023+ (or equivalent)
- XeLaTeX
- Biber
- Required packages (all on CTAN): `ctex`, `geometry`, `fancyhdr`, `mathtools`, `amsthm`, `biblatex-gb7714-2015`, `caption`, `booktabs`, `multirow`, `tabularx`, `threeparttable`, `enumitem`, `hyperref`, `siunitx`, `algorithm`, `algorithmic`, `fontspec`

---

## Tested Environments

1. Windows 11 + TeX Live 2023 + XeLaTeX ✅
2. Overleaf + XeLaTeX ✅

## License

MIT
```

- [ ] **Step 2: Verify README exists**

Run: `wc -l README.md`
Expected: ~200+ lines

---

### Task 9: First Compilation Test

**Files:** All created/modified above

- [ ] **Step 1: Run first XeLaTeX pass**

Run:
```bash
cd "C:/Users/PANDUOLA/Desktop/毕业设计/njusttt-main"
xelatex -synctex=1 -interaction=nonstopmode -file-line-error main.tex 2>&1 | tail -30
```
Expected: No fatal errors. Warnings about undefined references are normal on first pass.

- [ ] **Step 2: Run biber**

Run:
```bash
biber main 2>&1 | tail -10
```
Expected: `INFO - This is Biber 2.x` ... no errors

- [ ] **Step 3: Run second and third XeLaTeX passes**

Run:
```bash
xelatex -synctex=1 -interaction=nonstopmode -file-line-error main.tex 2>&1 | tail -10
xelatex -synctex=1 -interaction=nonstopmode -file-line-error main.tex 2>&1 | tail -10
```
Expected: No errors, no undefined references

- [ ] **Step 4: Check PDF was generated**

Run: `ls -la main.pdf`
Expected: `main.pdf` exists with non-zero size

- [ ] **Step 5: Check log for warnings**

Run:
```bash
grep -c "Warning" main.log
```
Expected: Low count (font warnings on Overleaf are expected). Report number.

---

### Task 10: Fix Compilation Issues (Iterative)

**Files:** `njusttt.cls`, `njusttt.def` (as needed)

- [ ] **Step 1: Review compilation log for errors**

Run:
```bash
grep -E "Error|!" main.log | head -20
```

- [ ] **Step 2: Fix each error found in `njusttt.cls` or `njusttt.def`**

Fix issues then re-run Tasks 6.1-6.4 compilation steps. Repeat until:
- Zero errors
- All references resolved
- PDF visually correct

- [ ] **Step 3: Verify PDF content visually**

Check the generated `main.pdf` and verify:
1. Cover page: logo, title, author, advisor table
2. Spine page
3. Chinese incover
4. English incover
5. Statement page
6. Abstract (CN + EN) with keywords
7. Table of Contents with chapter entries
8. List of Figures and Tables
9. Abbreviation table
10. Symbol table
11. Chapter 1: equation, figure, table, citations
12. Chapters 2-6
13. Bibliography (GB7714-2015 format)
14. Publications
15. Thanks
16. Page numbers: Roman (frontmatter), Arabic (mainmatter)
17. Headers show chapter titles/page degree

---

### Task 11: Final Verification

**Files:** All

- [ ] **Step 1: Run clean build from scratch**

Run:
```bash
latexmk -C 2>/dev/null || rm -f main.aux main.bbl main.blg main.bcf main.lof main.lot main.toc main.out main.run.xml main.log main.pdf
xelatex -synctex=1 -interaction=nonstopmode -file-line-error main.tex
biber main
xelatex -synctex=1 -interaction=nonstopmode -file-line-error main.tex
xelatex -synctex=1 -interaction=nonstopmode -file-line-error main.tex
```

- [ ] **Step 2: Confirm zero errors**

Run:
```bash
grep -c -E "^!" main.log
```
Expected: `0`

- [ ] **Step 3: Check PDF page count**

Run:
```bash
grep "Output written on" main.log
```
Expected: Shows page count (~30-40 pages based on example content)

---

### Task 12: Git Commit

**Files:** All new and modified files

- [ ] **Step 1: Check final state**

Run:
```bash
git status
```

- [ ] **Step 2: Stage and commit**

Run:
```bash
git add .
git commit -m "$(cat <<'EOF'
refactor: complete template restructure (v1.0)

Two-layer architecture: njusttt.cls (engine) + njusttt.def (labels).
Three-tier font system (embedded/fandol/system). Removed deprecated
packages (subfigure, subfigmat, psfrag, nomencl). Added geometry
package for page layout. New user commands for abbreviations,
symbols, and publications. VS Code biber build recipe included.
EOF
)"
```
