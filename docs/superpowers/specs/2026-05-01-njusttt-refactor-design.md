# NJUST Thesis Template Refactoring Design

## Scope

Complete refactoring of the NJUST (南京理工大学) PhD thesis LaTeX template. Preserve all functionality, clean architecture, improve robustness, usability, and modifiability. No backward compatibility required — users will be given clear documentation.

---

## 1. Architecture

Two-layer separation with a single user entry point:

```
njusttt-main/
├── main.tex              # User entry document (example)
├── njusttt.cls            # Typesetting ENGINE: page geometry, headers, chapter/section style,
│                          #   cover/statement/abstract generation logic, TOC/LOF/LOT formatting.
│                          #   Loads all third-party packages. Rarely touched.
├── njusttt.def            # DEFINITION layer: all CJK/English label strings, default values,
│                          #   user-config commands (\title{}, \advisor{}, etc), font setup,
│                          #   theorem environments. Changed when university updates branding.
├── tex/                   # Example chapter content
│   ├── cover.tex          #   metadata assignment + cover generation calls
│   ├── abstract.tex       #   Chinese + English abstracts
│   ├── ch1.tex ~ ch6.tex  #   chapter bodies
│   ├── abbreviations.tex  #   abbreviation table
│   ├── symbols.tex        #   symbol table
│   ├── thanks.tex         #   acknowledgements
│   └── publications.tex   #   publication list
├── ref/                   # Bibliography files (one per chapter, user-maintained)
│   └── ch1.bib ~ ch6.bib
├── fig/                   # Image resources
├── fonts/                 # Optional: bundled CJK fonts for offline/Overleaf use
├── .vscode/               # VS Code LaTeX build settings (local only)
├── .gitignore
├── LICENSE
└── README.md              # Full usage documentation
```

### Responsibility split

| File | What it contains | When it changes |
|------|-----------------|-----------------|
| `njusttt.cls` | Page geometry, headers, chapter/section style, cover/statement/abstract generation logic, TOC formatting, third-party package loading | When template formatting rules change |
| `njusttt.def` | All label strings (CJK + English), default values, user-setter commands, font family definitions, theorem environments | When university rebrands or renames departments |

### Design principles

- `.cls` loads `.def` automatically at `\AtBeginDocument` — user writes `\documentclass{njusttt}`, nothing else
- `.cls` never hardcodes Chinese strings — all labels go through `\NJUST@label@*` defined in `.def`
- User commands are `\newcommand` with sensible defaults (empty or placeholder text)
- Internal macros use `\def` only for low-level TeX tricks; standard naming `\NJUST@...`
- All dimension values use meaningful names or clear grouping with comments

---

## 2. User Interface

### 2.1 Entry point

```latex
% main.tex
\documentclass[eprint]{njusttt}   % eprint=draft (colored links), print=black-and-white
\begin{document}
\input{tex/cover}                   % metadata + cover generation
\frontmatter
\input{tex/abstract}
\tableofcontents
\listoffiguresandtables
\input{tex/abbreviations}
\input{tex/symbols}
\mainmatter
\input{tex/ch1} ... \input{tex/ch6}
\backmatter
\input{tex/thanks}
\printbibliography[heading=bibintoc]
\input{tex/publications}
\end{document}
```

### 2.2 Metadata commands (all in `cover.tex`)

```latex
%% Classification header
\classification{}          % 分类号
\confidential{}            % 密级
\UDC{}                     % UDC

%% Title (cover uses \titleUpp + \titleLow split; \title for internal marks)
\title[Short title for header]{Full Chinese Title}
\titleUpp{上排标题部分}
\titleLow{下排副标题部分}

%% Author
\author{姓名}
\advisor{导师姓名}\advisortitle{教授}
\coadvisor{协同导师姓名}\coadvisortitle{教授}
\degree{工学博士}
\major{机械工程}
\interest{研究方向}
\school{南京理工大学}
\submitdate{2024年1月}

%% Spine (auto-generated if not set by user)
\titleBackbone{脊\\背\\标\\题}
\schoolBackbone{南\\京\\理\\工\\大\\学}

%% English cover
\englishtitle{English Title of Thesis}
\englishauthor{Author Name}
\englishadvisor{Supervisor Name}\englishadvisortitle{Professor}
\englishcoadvisor{Co-supervisor Name}\englishcoadvisortitle{Lecturer}
\englishdegree{Doctor of Philosophy}
\englishmajor{Aerospace Engineering}
\englishinstitute{Nanjing University of Science \& Technology}
\englishdate{January, 2024}            % defaults to auto-generated

%% Statement
\signdate{2024 年 1 月 19 日}

%% Generate all cover pages
\makecover
```

### 2.3 Environments

```latex
\begin{abstract}
  中文摘要内容...
  \keywords{关键词1；关键词2}
\end{abstract}

\begin{englishabstract}
  English abstract content...
  \englishkeywords{keyword1; keyword2}
\end{englishabstract}

\begin{abbr}
  \abbreviation{SMJ}{supersonic milk jetting}{超音速牛奶喷射}
  \abbreviation{TT}{time travel}{时间旅行}
\end{abbr}

\begin{symbols}
  \notation{$\mathrm{log}(\cdot)$}{对数变换}
  \notation{$\mathrm{argmin}(\cdot)$}{取最小值的位置}
\end{symbols}

\begin{publications}
  \pubitem 作者. 论文标题[J]. 期刊名, 年份, 卷: 页.
  \pubitem 作者. 论文标题[J]. 期刊名, 年份, 卷: 页.
\end{publications}

\begin{thanks}
  致谢内容...
\end{thanks}
```

### 2.4 Theorem-like environments

```latex
\begin{definition}{标签} ... \end{definition}
\begin{theorem}{标签} ... \end{theorem}
\begin{lemma}{标签} ... \end{lemma}
\begin{proposition}{标签} ... \end{proposition}
\begin{corollary}{标签} ... \end{corollary}
\begin{algorithm}{标签} ... \end{algorithm}
\begin{example}{标签} ... \end{example}
\begin{remark}{标签} ... \end{remark}
\begin{proof} ... \end{proof}
```

---

## 3. Font Strategy

Three tiers, user-selectable via class option:

```latex
% Tier 1: Bundled fonts (default) — works offline, self-contained
\documentclass[font=embedded]{njusttt}

% Tier 2: Fandol (CTAN, free) — no license issues, auto-installed with TeX Live
\documentclass[font=fandol]{njusttt}

% Tier 3: System fonts (Windows) — smallest, but platform-dependent
\documentclass[font=system]{njusttt}
```

| Option | Song | Hei | Kai | WeiBei | Bundle size |
|--------|------|-----|-----|--------|-------------|
| `embedded` (default) | simsun.ttc | simhei.ttf | simkai.ttf | weibei.ttf | ~42 MB |
| `fandol` | FandolSong | FandolHei | FandolKai | (fallback to FandolKai) | 0 |
| `system` | SimSun | SimHei | KaiTi | (fallback to KaiTi) | 0 |

Implementation: `njusttt.def` has three `\ifNJUST@font@*` branches using `\setCJKfamilyfont`.

---

## 4. Package Upgrade Path

| Remove | Replace with | Reason |
|--------|-------------|--------|
| `subfigure` | `subfig` or `subcaption` | Deprecated since 2005 |
| `subfigmat` | None (remove) | Unmaintained, barely used |
| `psfrag` | None (remove) | Irrelevant for XeLaTeX |
| `nomencl` | Custom list environment | Non-standard usage for abbreviations |
| `\usepackage{graphicx}` in both `.cls` and `.sty` | Single `\RequirePackage` in `.cls` | Duplicate loading |
| `algorithmic` | `algpseudocode` or `algorithmicx` | `algorithmic` is frozen |

Keep as-is: `ctexbook`, `fancyhdr`, `mathtools`, `amsthm`, `amsfonts`, `amssymb`, `bm`, `graphicx`, `flafter`, `caption`, `booktabs`, `multirow`, `tabularx`, `threeparttable`, `enumitem`, `hyperref`, `geometry` (new, replacing manual dimension setting), `biblatex`, `siunitx`, `algorithm` + `algorithmic`.

---

## 5. Key Improvements

### 5.1 Page geometry
Replace manual `\oddsidemargin`/`\textheight`/`\textwidth` with `geometry` package for readability and safety.

### 5.2 `\makecover` decomposition
Current single `\makecover` calls 5 sub-pages. Refactored to individual commands:
- `\makefrontcover`
- `\makebackbone` (spine)
- `\makeincover` (Chinese inner cover)
- `\makeenglishincover`
- `\makestatement`
- `\makecover` = call all 5 (convenience wrapper)

### 5.3 Bibliography
Per-chapter `.bib` files, declared explicitly by user in their preamble (or in `njusttt.def` as defaults):
```latex
\addbibresource{ref/ch1.bib}
\addbibresource{ref/ch2.bib}
...
```
Default config in `njusttt.def` pre-declares `ref/ch1.bib` ~ `ref/ch6.bib`; user overrides by re-declaring in `main.tex`.

### 5.4 Page geometry values
Preserve original NJUST specification, implemented via `geometry` package:
```
paper     = a4paper
textwidth = 16 true cm
textheight= 24 true cm
vmargin   = 2.54cm (with headsep adjustment to match original topmargin)
hmargin   = centered (from original \oddsidemargin=0, \evensidemargin=0)
headheight= 15pt
footskip  = 32pt
```

### 5.5 VS Code integration
Provide `.vscode/settings.json` with LaTeX Workshop recipe for `xelatex -> biber -> xelatex -> xelatex`.

### 5.6 Error handling
- All `\NJUST@value@*` have non-empty defaults (placeholder text like `（论文题目）`)
- Missing `\title` etc. produce `PackageWarning`, not undefined control sequence
- `\advisor` without `\advisortitle` produces warning

---

## 6. Files to modify/create/delete

### Create
- `njusttt.cls` (rewrite from scratch)
- `njusttt.def` (rewrite from scratch) 
- `.vscode/settings.json` (LaTeX build recipes)
- `README.md` (comprehensive documentation)

### Delete
- `sty/njusttt.cls` → replaced by root `njusttt.cls`
- `sty/njusttt.cfg` → merged into `njusttt.def`
- `sty/customize.sty` → merged into `njusttt.cls`

### Modify
- `main.tex` — update `\documentclass` and cleanup
- `tex/cover.tex` — minor syntax updates
- `tex/abstract.tex` — minor syntax updates
- `tex/abbreviations.tex` — migrate to new `\abbreviation` command
- `tex/symbols.tex` — migrate to new `\notation` command

### Keep as-is
- `fig/` — all images
- `ref/` — all `.bib` files
- `sty/font/` → moved to `fonts/`
- `LICENSE`
- `.gitignore`

---

## 7. Verification

After refactoring, compile with `xelatex + biber + xelatex + xelatex` and verify:
1. No compilation errors or warnings (except font warnings on non-Windows)
2. Cover page renders correctly with all fields
3. Spine, Chinese incover, English incover pages render
4. Statement page renders
5. TOC, LOF, LOT all generate
6. Abstract (CN + EN) with keywords
7. Abbreviation and symbol tables render
8. Each chapter appendix with image and table
9. Bibliography with GB7714-2015 style
10. Publication list enumerates correctly
11. Thanks page
12. Page numbers: Roman for frontmatter, Arabic for mainmatter
13. Headers show chapter titles
