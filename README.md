# 东北大学试卷 LaTeX 模板

`neu-exam.cls` 负责通用版式，题头信息集中在 `exam-info.tex`。

## 使用

**新建试卷推荐从 `example.tex` 开始**：使用 `\documentclass[flow]{neu-exam}`，正文自动换行、分栏和分页，不需要填写坐标。`main.tex` 仍是原卷的定位排版示例，使用不带 `flow` 的文档类。

打开 `example.pdf` 查看编译效果。修改 `exam-info.tex` 中的课程、卷别、考试对象、年份；修改 `example.tex` 中的题目、分值和选项。请将 `neu-exam.cls`、`exam-info.tex` 和 `example.tex` 放在同一目录中。

使用 **XeLaTeX** 编译：

```sh
xelatex -interaction=nonstopmode -halt-on-error example.tex
xelatex -interaction=nonstopmode -halt-on-error example.tex
```

连续编译两次以更新题头总页数，不依赖构建脚本。

需要 MiKTeX 或 TeX Live，包含 `fontspec`、`xeCJK`、`tikz`、`geometry`、`eso-pic`、`xfp`、`enumitem`、`zhnumber`、`lastpage` 等常用包。字体使用 **宋体（SimSun）、黑体（SimHei）和 Times New Roman**；编译设备需安装这些字体。无需安装 Word。

## 按题型编写试卷（推荐）

编译示例：`xelatex -interaction=nonstopmode -halt-on-error example.tex`，连续执行两次。

```latex
\documentclass[flow]{neu-exam}
\input{exam-info}
\begin{document}
\MakeExamTitle % 仅在开头调用一次，使用 exam-info.tex 的题头信息

\SingleChoice[每题3分，共6分]
\Question{这里是题干。}
\begin{choices}
  \item 第一个选项
  \item 第二个选项
\end{choices}
\Question{第二题的答案是\ExamBlank。}

\Comprehensive[共10分]
\Question[10]{这里是公共材料，可以包含公式和图片。}
\begin{subquestions}
  \item 第一个小问。（4分）
    \AnswerSpace[2cm]
  \item 第二个小问。（6分）
    \AnswerSpace[3cm]
\end{subquestions}

\section{附加题} % 仍支持普通 section、section*、subsection 等
\Question[5]{自定义题目。}
\AnswerSpace
\end{document}
```

| 命令 | 默认大题标题 |
| --- | --- |
| `\SingleChoice[说明]` | 单选题 |
| `\MultipleChoice[说明]` | 多选题 |
| `\FillInBlank[说明]` | 填空题 |
| `\ShortAnswer[说明]` | 简答题 |
| `\TrueFalse[说明]` | 判断题 |
| `\Comprehensive[说明]` | 综合题 |

六个命令都像 `\section{标题}` 一样开启大题，可任意排序、重复或省略；可选参数用于填写分值、题数、作答说明，例如 `\FillInBlank[每空2分，共10分]`。大题自动使用中文编号，小题从 1 重新编号。普通 `\section{自定义标题}` 参与同一套编号并重置题号；`\section*` 不参与编号，也不重置题号。

- `\Question[分值]{题干}`：自动编号，分值可省略。题干支持自然换行和数学公式；无需手动 `\linebreak`。
- `choices` 环境：每个 `\item` 是一个选项，自动标为 A）、B）等；每道题的选项单独开一个环境。选项横向连续排列，一行可以放多个选项，放不下时自动换行；长选项本身也可跨行，不必指定列数。
- `subquestions` 环境：每个 `\item` 是一个小问，自动标为（1）、（2）等；既可用于综合题，也可用于简答题。
- `\ExamBlank[宽度]`：填空横线，默认 `48bp`。
- `\TrueFalseBox`：判断题末尾的作答括号，不自动显示答案。
- `\AnswerSpace[高度]`：答题留白，默认三行，可写 `2cm`、`40bp` 等长度。留白不会拆成跨页的两段，大块留白可能造成提前换栏，应检查编译结果。
- 图片使用普通 `\includegraphics[width=\linewidth]{assets/文件名.png}`；可放在题干或小问中。

`flow` 模式保留 B4 横向纸张、装订栏、中间竖线和页码，采用两个等宽正文栏；长题目可跨栏、跨页。不要在此模式中混用定位模式的 `ExamPage`、`\ExamSection`、`\ExamQuestion`。题型命令不自动计算总分。题头总页数通过 `lastpage` 自动读取；首次编译或分页变化后需连续编译两次，首次可能显示 `??`。题头成绩表沿用原版固定的八个大题格。


## 版式设置

| 项目 | 数值 / 处理方式 |
| --- | --- |
| 纸张 | Word B4 横向，1031.95 × 728.60 bp（约 364.05 × 257.03 mm） |
| 上、下页边距 | 70.90 bp |
| 左页边距与装订预留 | 28.35 + 113.40 bp |
| 正文栏宽度 | 自动排版模式左右栏均约 399 bp |
| 栏间距 | 21.25 bp，保留中间竖线 |
| 字体与字号 | 正文宋体、英文 Times New Roman，小四（12pt）；题型标题同为小四加粗，校名 18 bp |
| 页面 | 按正文自动分页；当前示例为 3 页 |
| 装订区 | 座位号、学号、班级、姓名框及竖排文字；保留三页原有位置差异 |
| 页码 | 正文区域居中显示 `- 1 -` 等，与原稿位置一致 |

这里的 `bp` 是 Word/PDF 使用的 1/72 英寸；不是 LaTeX 默认的 1/72.27 英寸 `pt`。

## 高级用法：手动定位排版

文档类仍保留手动定位接口。如需精确控制坐标，请使用 `\documentclass{neu-exam}`（不带 `flow`），每页使用一个 `ExamPage` 环境。此模式需自行管理换行、位置与分页。

```latex
\begin{ExamPage}
  % x、y、width 的单位都是 bp；y 是第一行文字的基线。
  \ExamQuestion{141.72}{303.84}{399}{1}{这里输入题目。}
  \ExamLines{141.72}{323.28}{399}{A）选项一\\B）选项二}
\end{ExamPage}
```

- `\ExamQuestion{x}{y}{width}{编号}{题干}`：题干使用 `\linebreak` 明确换行，后续行自动缩进。为保持原卷行界，超过指定宽度的单行会水平缩小；新增较长题目应主动换行，避免文字过度缩小。
- `\ExamLines{x}{y}{width}{内容}`：用于选项，`\\` 换行，行距 19.5 bp。
- `\ExamText{x}{y}{width}{内容}`：一般文字块，可自然换行。
- `\ExamImage{x}{y}{width}{height}{文件}`：图片的 `y` 是上边缘坐标。
- `\ExamSection{x}{y}{得分框宽度}{标题基线偏移}{标题}`：大题得分框和标题。
- `\ExamBlank[48bp]`：填空横线。
