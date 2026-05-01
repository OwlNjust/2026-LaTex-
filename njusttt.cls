\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{njusttt}[2026/05/01 v1.0 NJUST undergraduate thesis template]

%% ========================================
%%  Class options
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

%% ========================================
%%  Base class
%% ========================================
\LoadClass[a4paper,zihao=-4,UTF8,fontset=none,openright]{ctexbook}

%% ========================================
%%  Page geometry (2026 undergraduate spec)
%% ========================================
\RequirePackage[paper=a4paper,
  top=30mm,bottom=24mm,left=25mm,right=25mm,
  headheight=14pt,headsep=6mm,
  footskip=10mm]{geometry}

%% ========================================
%%  Required packages
%% ========================================
\RequirePackage{fancyhdr}
\RequirePackage{mathtools,amsthm,amsfonts,amssymb,bm}
\RequirePackage{graphicx,flafter}
\RequirePackage[margin=10.5pt,font=small]{caption}
\RequirePackage[section]{placeins}

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

%% ========================================
%%  Load definitions
%% ========================================
\InputIfFileExists{njusttt.def}{}{
  \ClassError{njusttt}{njusttt.def not found}{Place njusttt.def next to njusttt.cls}
}

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

%% Fixed 20pt line spacing for body text (2026 spec)
\RequirePackage{setspace}
\setstretch{1.0}
\renewcommand{\baselinestretch}{1.667}

%% ========================================
%%  Headers and footers
%% ========================================
\renewcommand\frontmatter{\pagenumbering{Roman}}

\fancypagestyle{plain}{
  \fancyhf{}
  \fancyhead[LO]{\songti\zihao{-5}\NJUST@value@pageDegree}
  \fancyhead[RO]{\songti\zihao{-5}\NJUST@value@titlemark}
  \fancyhead[LE]{\songti\zihao{-5}\leftmark}
  \fancyhead[RE]{\songti\zihao{-5}\NJUST@value@pageDegree}
  \fancyfoot[RO,LE]{\zihao{-5}~\thepage~}
}

\pagestyle{fancy}
\fancyhf{}
\fancyhead[LO]{\songti\zihao{-5}\NJUST@value@pageDegree}
\fancyhead[RO]{\songti\zihao{-5}\NJUST@value@titlemark}
\fancyhead[LE]{\songti\zihao{-5}\leftmark}
\fancyhead[RE]{\songti\zihao{-5}\NJUST@value@pageDegree}
\fancyfoot[RO,LE]{\zihao{-5}~\thepage~}

%% ========================================
%%  Cover generation -- Front cover (附件2.1)
%% ========================================
\newcommand\makefrontcover{
  \cleardoublepage
  \thispagestyle{empty}
  \begin{center}

    %% Logo
    \includegraphics[width=0.7\textwidth]{fig/logo/njust.eps}
    \vskip 20pt

    %% Report type
    {\songbf\fontsize{26pt}{32pt}\selectfont 毕\hspace{0.5em}业\hspace{0.5em}设\hspace{0.5em}计（论\hspace{0.5em}文）报\hspace{0.5em}告}
    \vskip 36pt

    %% Paper title (小一黑体加粗，每行等长下划线)
    {\heibf\zihao{-1}
      \underline{\makebox[0.85\textwidth][c]{\NJUST@value@titleUpp}}
      \vskip 20pt
      \underline{\makebox[0.85\textwidth][c]{\NJUST@value@titleLow}}}

    \vskip 42pt

    %% Author & Student ID (居中，小二楷体加粗)
    \begin{minipage}{0.45\textwidth}
      \centering
      {\kaibf\zihao{-2}\underline{\makebox[0.8\linewidth][c]{\NJUST@value@author}}}
      \par\vskip 2pt
      {\songti\zihao{5}（学生姓名）}
      \par\vskip 12pt
      {\kaibf\zihao{-2}\underline{\makebox[0.8\linewidth][c]{\NJUST@value@studentid}}}
      \par\vskip 2pt
      {\songti\zihao{5}（学号）}
    \end{minipage}

    \vskip 36pt

    %% Bottom info table (左侧标签分散对齐，右侧填空等宽下划线)
    \begin{tabular}{@{} p{3cm} @{\hspace{0cm}} p{8cm} @{}}
      \makebox[3cm][s]{\songbf\zihao{4} 指\hspace{0.3em}导\hspace{0.3em}教\hspace{0.3em}师} &
        \underline{\makebox[8cm][c]{\kaishu\zihao{4}\NJUST@value@advisor\quad\NJUST@value@advisortitle}} \\[2pt]
      \makebox[3cm][s]{\songbf\zihao{4} 学\hspace{0.3em}生\hspace{0.3em}学\hspace{0.3em}院} &
        \underline{\makebox[8cm][c]{\kaishu\zihao{4}\NJUST@value@college}} \\[2pt]
      \makebox[3cm][s]{\songbf\zihao{4} 专\hspace{2.9em}业} &
        \underline{\makebox[8cm][c]{\kaishu\zihao{4}\NJUST@value@major}} \\[2pt]
      \makebox[3cm][s]{\songbf\zihao{4} 研\hspace{0.3em}究\hspace{0.3em}方\hspace{0.3em}向} &
        \underline{\makebox[8cm][c]{\kaishu\zihao{4}\NJUST@value@researchdir}} \\[2pt]
      \makebox[3cm][s]{\songbf\zihao{4} 提\hspace{0.3em}交\hspace{0.3em}时\hspace{0.3em}间} &
        \underline{\makebox[8cm][c]{\kaishu\zihao{4}\NJUST@value@submitdate}}
    \end{tabular}
  \end{center}
  \songti
}

%% ========================================
%%  Cover generation -- Inner cover / 封二 (附件2.2)
%% ========================================
\newcommand\makeincover{
  \cleardoublepage
  \thispagestyle{empty}
  \begin{center}
    \vspace*{60pt}

    %% Paper title (小一黑体加粗)
    {\heibf\zihao{-1}\NJUST@value@titleUpp}
    \vskip 8pt
    {\heibf\zihao{-1}\NJUST@value@titleLow}

    \vfill

    %% Author & advisor (小二楷体加粗)
    {\kaibf\zihao{-2}
      \NJUST@label@incoverauthor\NJUST@value@author}
    \vskip 30pt
    {\kaibf\zihao{-2}
      \NJUST@label@incoveradvisor\NJUST@value@advisor\quad\NJUST@value@advisortitle}

    \vfill

    %% School & date (小二宋体加粗)
    {\songbf\zihao{-2} 南\hspace{1em}京\hspace{1em}理\hspace{1em}工\hspace{1em}大\hspace{1em}学}
    \vskip 16pt
    {\songbf\zihao{-2}\NJUST@value@incoverdate}
  \end{center}
  \clearpage
  \if@twoside
    \thispagestyle{empty}
    \cleardoublepage
  \fi
}

%% ========================================
%%  Cover generation -- English inner cover (英文封二, 附件2.3)
%% ========================================
\newcommand\makeenglishincover{
  \cleardoublepage
  \thispagestyle{empty}
  \begin{center}
    \vspace*{60pt}

    %% English title (二号 Times New Roman 加粗)
    {\rmbf\zihao{2}\NJUST@value@englishtitle}

    \vfill

    %% Author
    {\rmit\zihao{-2}\NJUST@label@englishauthor}
    \vskip 8pt
    {\rmbfit\zihao{-2}\NJUST@value@englishauthor}

    \vskip 40pt

    %% Supervisor
    {\rmit\zihao{-2}\NJUST@label@englishadvisor\NJUST@value@englishadvisor}

    \vfill

    %% Institute & date
    {\rmn\zihao{-2}\NJUST@value@englishinstitute}
    \vskip 16pt
    {\rmn\zihao{-2}\NJUST@value@englishdate}
  \end{center}
  \clearpage
  \if@twoside
    \thispagestyle{empty}
    \cleardoublepage
  \fi
}

%% ========================================
%%  Cover generation -- Statement (附件2.4)
%% ========================================
\newcommand\makestatement{
  \cleardoublepage
  \thispagestyle{empty}
  \begin{center}
    \vspace*{12pt}
    \parbox{\textwidth}{\centering\bf\songbf\zihao{3}\NJUST@label@statement}
    \vskip 24pt
    \parbox{\textwidth}{\songti\zihao{4}\renewcommand{\baselinestretch}{1.6}\hspace{2em}\NJUST@value@statement}
    \vskip 24pt
    \parbox{\textwidth}{\noindent\zihao{4}\NJUST@label@authorsign\hspace{3.5cm}\NJUST@label@signdate}
    \vskip 48pt

    \parbox{\textwidth}{\centering\bf\songbf\zihao{3}\NJUST@label@accredit}
    \vskip 24pt
    \parbox{\textwidth}{\songti\zihao{4}\renewcommand{\baselinestretch}{1.6}\hspace{2em}\NJUST@value@accredit}
    \vskip 24pt
    \parbox{\textwidth}{\noindent\zihao{4}\NJUST@label@authorsign\hspace{3.5cm}\NJUST@label@signdate}
  \end{center}
  \clearpage
  \if@twoside
    \thispagestyle{empty}
    \cleardoublepage
  \fi
}

%% ========================================
%%  Convenience wrapper
%% ========================================
\newcommand\makecover{
  \makefrontcover
  \makeincover
  \makeenglishincover
  \makestatement
}

%% ========================================
%%  Table of Contents
%% ========================================
\renewcommand*\l@chapter[2]{
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}
    \vskip 0em \@plus\p@
    \setlength\@tempdima{1.5em}
    \begingroup
    \parindent \z@ \rightskip \@pnumwidth
    \parfillskip -\@pnumwidth
    \leavevmode \songbf\zihao{4}
    \advance\leftskip\@tempdima
    \hskip -\leftskip
    #1\nobreak
    \leaders\hbox{$\m@th\mkern 2mu\bm{\cdot}\mkern 5mu$}
    \hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
    \penalty\@highpenalty
    \endgroup
  \fi
}
\renewcommand*\l@section[2]{
  \ifnum \c@tocdepth >1
    \vskip 0em \@plus\p@
    \setlength\@tempdima{2.5em}       % 序号到标题文字的间距
    \begingroup
    \parindent \z@ \rightskip \@pnumwidth
    \parfillskip -\@pnumwidth
    \leavevmode \songti\zihao{-4}
    \advance\leftskip\@tempdima
    \hskip -\leftskip
    \hskip 1.5em                      % ← 序号缩进量（距左边界）
    #1\nobreak
    \leaders\hbox{$\m@th\mkern 1mu\cdot\mkern 3mu$}
    \hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
    \endgroup
  \fi
}
\renewcommand*\l@subsection[2]{
  \ifnum \c@tocdepth >2
    \vskip 0em \@plus\p@
    \setlength\@tempdima{2.5em}       % 序号到标题文字的间距
    \begingroup
    \parindent \z@ \rightskip \@pnumwidth
    \parfillskip -\@pnumwidth
    \leavevmode \songti\zihao{-4}
    \advance\leftskip\@tempdima
    \hskip -\leftskip
    \hskip 3em                        % ← 序号缩进量（距左边界，比二级更大）
    #1\nobreak
    \leaders\hbox{$\m@th\mkern 1mu\cdot\mkern 3mu$}
    \hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
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

%% ========================================
%%  Chapter and section styles (2026 spec)
%%  一级: 小三(15pt) bold, 二级: 四号(14pt) bold, 三级: 小四(12pt) bold
%% ========================================
\ctexset{
  chapter={
    format={\songbf\zihao{-3}\raggedright},
    name={,},number={\arabic{chapter}},
    beforeskip={18pt},afterskip={18pt}
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

%% ========================================
%%  Figure and table captions (五号 10.5pt per 2026 spec)
%% ========================================
%% Caption font: 五号宋体 (使用 DeclareCaptionFont 避免 font= key 解析问题)
\DeclareCaptionFont{songfive}{\songti\zihao{5}}
\captionsetup[figure]{font=songfive}
\captionsetup[table]{font=songfive}

%% ========================================
%%  Helper commands
%% ========================================
\newcommand{\dw}[2]{~\SI{#1}{#2}}
\newcommand{\td}[0]{~\~{}~}

\newcommand\NJUSTprintbib{
  \cleardoublepage
  \phantomsection
  \addcontentsline{toc}{chapter}{\NJUST@bibname}
  \printbibliography
}

\endinput
