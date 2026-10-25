\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{neu-exam}[2026/10/25 NEU Qinhuangdao Word exam layout]
\newif\ifExamFlow
\DeclareOption{flow}{\ExamFlowtrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[12pt]{article}
\RequirePackage{iftex}
\ifXeTeX\else\ClassError{neu-exam}{Please compile with XeLaTeX}{}\fi
\RequirePackage[paperwidth=1031.95bp,paperheight=728.6bp,margin=0bp]{geometry}
\RequirePackage{fontspec}
\RequirePackage{xeCJK}
\RequirePackage{graphicx}
\RequirePackage{xcolor}
\RequirePackage{tikz}
\RequirePackage{eso-pic}
\RequirePackage{lastpage}
\setmainfont{Times New Roman}
\setCJKmainfont{SimSun}[AutoFakeBold=2.5]
\setCJKsansfont{SimHei}
\xeCJKsetup{PunctStyle=plain,CJKecglue=\hskip .2em plus .08em minus .08em}
\pagestyle{empty}
\setlength{\parindent}{0pt}
\setlength{\parskip}{0pt}
\setlength{\unitlength}{1bp}
\newcommand{\ExamFont}{\normalfont\fontsize{12pt}{19.5bp}\selectfont}
\newcommand{\ExamBlank}[1][48bp]{\underline{\hspace{#1}}}
\newcommand{\ExamStar}{\textsuperscript{*}}
% Coordinates are measured in PDF points (bp), from the top-left paper corner.
% y is the first text baseline. Boxes remain real, editable LaTeX text.
\newcommand{\ExamText}[4]{%
  \node[anchor=base west,inner sep=0pt,outer sep=0pt] at (#1,-#2)
    {\begin{minipage}[t]{#3bp}\ExamFont #4\par\end{minipage}};}
\newcommand{\ExamQuestion}[5]{%
  \ExamText{#1}{#2}{#3}{\hangindent=17.88bp\hangafter=1
    \makebox[17.88bp][l]{#4.}#5}}
\newcommand{\ExamImage}[5]{%
  \node[anchor=north west,inner sep=0pt,outer sep=0pt] at (#1,-#2)
    {\includegraphics[width=#3bp,height=#4bp]{#5}};}
\newcommand{\ExamRule}[4]{\draw[line width=.5bp] (#1,-#2)--(#3,-#4);}
\newcommand{\ExamFrame}[4]{\draw[line width=.5bp] (#1,-#2) rectangle ++(#3,-#4);}

% A reusable page: the original has slightly different binding-strip offsets
% on pages 1--3. Subsequent pages reuse the first-page strip.
\newcommand{\ExamBinding}[2]{%
 \begin{scope}[shift={(#1,-#2)}]
  \foreach \y/\label in {0/座位号,93.15/学\ 号,185.85/班\ 级,275.2/姓\ 名}{%
   \ExamFrame{0}{\y}{72}{70.2}
   \ifdim\y pt=185.85pt\else
    \draw[line width=.5bp] (0,{-\y-32})--(72,{-\y-32});\fi
   \node[anchor=base,inner sep=0pt] at (36,{-\y-23.5})
     {\fontsize{14bp}{16bp}\selectfont\bfseries\label};}
  \foreach \t [count=\i from 0] in {装,订,线,内,不,要,答,题}{%
   \node[anchor=base,inner sep=0pt] at (30.9,{-369.8-27.7*\i})
    {\fontsize{14bp}{14bp}\selectfont\bfseries\t};}
 \end{scope}}
\newcommand{\ExamDecorations}{%
 \ifcase\value{page}\or
   \ExamBinding{39.75}{84.9}\def\bindx{123.75}\def\bindtop{63.6}\def\bindbottom{660.7}%
 \or
   \ExamBinding{42.35}{76.4}\def\bindx{124.8}\def\bindtop{71.8}\def\bindbottom{664.0}%
 \or
   \ExamBinding{29.7}{67.85}\def\bindx{113.6}\def\bindtop{71.8}\def\bindbottom{659.5}%
 \else
   \ExamBinding{39.75}{84.9}\def\bindx{123.75}\def\bindtop{63.6}\def\bindbottom{660.7}%
 \fi
 \ExamRule{\bindx}{\bindtop}{\bindx}{\bindbottom}
 \foreach \t [count=\i from 0] in {装,订,线}{%
   \node[fill=white,inner sep=.8bp,anchor=base] at (\bindx,{-289.5-53*\i + (\value{page}-1)*8.5})
    {\fontsize{9bp}{9bp}\selectfont\bfseries\t};}
 \ExamRule{551.325}{70.9}{551.325}{657.7}
 \ExamText{562.92}{677.04}{40}{\fontsize{9bp}{10bp}\selectfont - \thepage\ -}}
\NewDocumentEnvironment{ExamPage}{+b}{%
 \AddToShipoutPictureFG*{\AtPageUpperLeft{%
  \begin{tikzpicture}[overlay,x=1bp,y=1bp]
   \ExamDecorations #1
  \end{tikzpicture}}}%
 \null\newpage
}{}

% The total-score grid and section heading boxes retain the source dimensions.
\newcommand{\ExamScoreTable}{%
 \begin{scope}[shift={(141.72,-180.6)}]
  \ExamFrame{0}{0}{382.25}{63.36}
  \ExamRule{0}{31.68}{382.25}{31.68}
  \foreach \x in {34.6,69.65,104.65,139.65,174.65,209.65,244.65,279.65,314.65}
   {\ExamRule{\x}{0}{\x}{63.36}}
  \ExamText{11.28}{12.12}{15}{题\\[-3.9bp]号}
  \ExamText{11.28}{43.8}{15}{得\\[-3.9bp]分}
  \foreach \x/\t in {52.12/一,87.15/二,122.15/三,157.15/四,192.15/五,227.15/六,262.15/七,297.15/八,348.45/总分}
   {\node[anchor=base,inner sep=0pt] at (\x,-19.92){\ExamFont\t};}
 \end{scope}}
\newcommand{\ExamSection}[5]{%
 \ExamFrame{#1}{#2}{#3}{32.04}
 \draw[line width=.5bp] ({#1+29.25},-#2)--++(0,-32.04);
 \ExamText{\fpeval{#1+8.7}}{\fpeval{#2+13.6}}{15}{得\\[-3.9bp]分}
 \ExamText{\fpeval{#1+#3+5.4}}{\fpeval{#2+#4}}{325}{\bfseries #5}}
\RequirePackage{xfp}
\RequirePackage{fix-cm}
% Keep Word's explicit lines together. TeX otherwise reflows a line when its
% punctuation metrics differ by a fraction of a point. Only overlong lines
% are reduced horizontally; the 12 pt type size / vertical metrics are kept.
\newsavebox{\ExamLineBox}
\newcommand{\ExamFitLine}[2]{%
 \sbox{\ExamLineBox}{#2}%
 \ifdim\wd\ExamLineBox>#1bp
  \resizebox{#1bp}{\height}{\usebox{\ExamLineBox}}%
 \else\usebox{\ExamLineBox}\fi}
\ExplSyntaxOn
\seq_new:N \l_exam_lines_seq
\RenewDocumentCommand{\ExamQuestion}{mmmmm}{
 \seq_set_split:Nnn \l_exam_lines_seq {\linebreak} {#5}
 \int_zero:N \l_tmpa_int
 \seq_map_inline:Nn \l_exam_lines_seq {
  \int_compare:nNnTF {\l_tmpa_int}={0}
   {\ExamText{#1}{#2}{#3}{\makebox[17.88bp][l]{#4.}\ExamFitLine{\fp_eval:n{#3-17.88}}{##1}}}
   {\ExamText{\fp_eval:n{#1+17.88}}{\fp_eval:n{#2+19.5*\l_tmpa_int}}{\fp_eval:n{#3-17.88}}{\ExamFitLine{\fp_eval:n{#3-17.88}}{##1}}}
  \int_incr:N \l_tmpa_int
 }
}
\NewDocumentCommand{\ExamLines}{mmmm}{
 \seq_set_split:Nnn \l_exam_lines_seq {\\} {#4}
 \int_zero:N \l_tmpa_int
 \seq_map_inline:Nn \l_exam_lines_seq {
  \ExamText{#1}{\fp_eval:n{#2+19.5*\l_tmpa_int}}{#3}{\ExamFitLine{#3}{##1}}
  \int_incr:N \l_tmpa_int
 }
}
\ExplSyntaxOff

% Semantic authoring API. Use [flow] for ordinary, automatically paginated text.
\RequirePackage[inline]{enumitem}
\RequirePackage{zhnumber}
\newcounter{question}[section]
\renewcommand{\thequestion}{\arabic{question}}
\newcommand{\ExamTypeSection}[2]{%
  \section{#1\if\relax\detokenize{#2}\relax\else（#2）\fi}}
\NewDocumentCommand{\SingleChoice}{O{}}{\ExamTypeSection{单选题}{#1}}
\NewDocumentCommand{\MultipleChoice}{O{}}{\ExamTypeSection{多选题}{#1}}
\NewDocumentCommand{\FillInBlank}{O{}}{\ExamTypeSection{填空题}{#1}}
\NewDocumentCommand{\ShortAnswer}{O{}}{\ExamTypeSection{简答题}{#1}}
\NewDocumentCommand{\TrueFalse}{O{}}{\ExamTypeSection{判断题}{#1}}
\NewDocumentCommand{\Comprehensive}{O{}}{\ExamTypeSection{综合题}{#1}}
\NewDocumentCommand{\Question}{O{} +m}{%
  \par\addvspace{8bp}\refstepcounter{question}%
  \noindent\hangindent=2em\hangafter=1
  \makebox[2em][l]{\thequestion.}%
  \if\relax\detokenize{#1}\relax\else（#1分）\fi#2\par\nopagebreak}
% Unboxed inline items allow even an option longer than a column to wrap.
\newlist{examchoices}{enumerate*}{1}
\setlist[examchoices]{label=\Alph*）,ref=\Alph*,mode=unboxed,
  afterlabel=\nobreak\hspace{.3em},itemjoin=\hspace{2em}}
\NewDocumentEnvironment{choices}{}{%
  \par\addvspace{3bp}\noindent\begin{examchoices}%
}{\end{examchoices}\par\addvspace{3bp}}
\newlist{subquestions}{enumerate}{1}
\setlist[subquestions]{label=（\arabic*）,ref=\thequestion(\arabic*),
  leftmargin=3em,labelsep=.5em,itemsep=6bp,parsep=0pt,topsep=6bp}
\NewDocumentCommand{\AnswerSpace}{O{3\baselineskip}}{\par\vspace*{#1}}
\NewDocumentCommand{\TrueFalseBox}{}{（\hspace{2em}）}
\NewDocumentCommand{\MakeExamTitle}{}{%
  \ifExamFlow
    \AddToShipoutPictureFG*{\AtPageUpperLeft{%
      \begin{tikzpicture}[overlay,x=1bp,y=1bp]\ExamHeading\end{tikzpicture}}}%
    \vspace*{175bp}%
  \else
    \ClassError{neu-exam}{MakeExamTitle requires the flow class option}
      {Use documentclass[flow]{neu-exam}, or ExamHeading inside ExamPage.}%
  \fi}
\ifExamFlow
  % Two 399 bp columns; the binding strip and title retain their original positions.
  \geometry{left=141.72bp,right=70.98bp,top=70.9bp,bottom=70.9bp}
  \setlength{\columnsep}{21.25bp}
  \renewcommand{\thesection}{\zhnumber{\arabic{section}}}
  \renewcommand{\section}{\@startsection{section}{1}{\z@}%
    {-12pt plus -3pt minus -2pt}{6pt plus 2pt}%
    {\normalfont\fontsize{12pt}{19.5bp}\selectfont\bfseries}}
  \AtBeginDocument{%
    \ExamFont\twocolumn
    \AddToShipoutPictureFG{\AtPageUpperLeft{%
      \begin{tikzpicture}[overlay,x=1bp,y=1bp]\ExamDecorations\end{tikzpicture}}}}
\fi
\endinput
