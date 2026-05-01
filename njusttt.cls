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

%% ========================================
%%  Base class
%% ========================================
\LoadClass[a4paper,zihao=-4,UTF8,fontset=none]{ctexbook}

%% ========================================
%%  Required packages
%% ========================================
\RequirePackage[
  textwidth=16truecm,textheight=24truecm,
  headheight=15pt,footskip=32pt,
  centering]{geometry}

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

%% ========================================
%%  Load definitions (labels, defaults, user commands, fonts)
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

\newcommand\makecover{
  \makefrontcover
  \makebackbone
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
