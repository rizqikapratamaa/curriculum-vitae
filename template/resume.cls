%% resume.cls -- shared class for all CV variants
%% Single-column, serif, compact layout with ruled section headers.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{template/resume}[2026/07/20 Single-source multi-variant CV class]

\LoadClass[letterpaper,10pt]{article}

\RequirePackage[left=0.55in,right=0.55in,top=0.5in,bottom=0.5in]{geometry}
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage{newtxtext}
\RequirePackage{newtxmath}
\RequirePackage{enumitem}
\RequirePackage{titlesec}
\RequirePackage{tabularx}
\RequirePackage{xcolor}
\RequirePackage{etoolbox}
% bookmarks=false: section titles are uppercased through \MakeUppercase, which
% is awkward to expand inside PDF bookmarks, and a CV has no use for an outline.
\RequirePackage[hidelinks,bookmarks=false]{hyperref}

\pagestyle{empty}
\setlength{\parindent}{0pt}
\setlength{\tabcolsep}{0pt}
\raggedbottom
\raggedright

% ---------------------------------------------------------------------------
% Variant tagging
% ---------------------------------------------------------------------------
% Each variant file declares its identity via \cvsetvariant{<name>}. Content
% files then wrap variant-specific bullets in \cvitemif{tag,tag}{...} so that a
% given sentence is authored exactly once and merely switched on or off.
%
% Tags are matched literally -- there is deliberately no wildcard. Two phrasings
% of the same fact (e.g. a long and a short thesis line) can therefore never
% both fire, because no variant name appears in both tag lists.
% Valid tags: full, softeng, ai, data.

\def\cv@variant{full}
\newcommand{\cvsetvariant}[1]{\def\cv@variant{#1}}

\newif\ifcv@match
\newcommand{\cvifvariant}[3]{%
  \cv@matchfalse
  \@for\cv@tag:=#1\do{%
    \ifx\cv@tag\cv@variant\cv@matchtrue\fi
  }%
  \ifcv@match#2\else#3\fi
}

% Bullet that only appears for the listed variants.
\newcommand{\cvitemif}[2]{\cvifvariant{#1}{\item #2}{}}

% Arbitrary block gated on variant.
\newcommand{\cvonly}[2]{\cvifvariant{#1}{#2}{}}

% ---------------------------------------------------------------------------
% Section headers: small-caps-free uppercase, bold, followed by a rule
% ---------------------------------------------------------------------------
% The fourth argument is before-code; ending it with \MakeUppercase makes
% titlesec pass the title in as that command's argument, so the whole heading is
% uppercased rather than just its first token.
\titleformat{\section}
  {\normalfont\large\bfseries}
  {}{0em}{\MakeUppercase}[\vspace{-0.6ex}\rule{\textwidth}{0.7pt}]
\titlespacing*{\section}{0pt}{1.6ex plus 0.4ex}{0.9ex}

% ---------------------------------------------------------------------------
% Header block
% ---------------------------------------------------------------------------
% \cvheader{Name}{contact line 1}{contact line 2}
\newcommand{\cvheader}[3]{%
  \begin{center}
    {\LARGE\bfseries #1}\\[0.6ex]
    {\small #2}\\[0.35ex]
    {\small #3}
  \end{center}
  \vspace{-0.8ex}%
}

\newcommand{\cvsep}{\hspace{0.4em}|\hspace{0.4em}}

% Profile / summary paragraph.
\newcommand{\cvsummary}[1]{{\small #1}\par\vspace{0.4ex}}

% ---------------------------------------------------------------------------
% Entries
% ---------------------------------------------------------------------------
% \cventry{Organisation - Location}{Date range}{Role}
\newcommand{\cventry}[3]{%
  \vspace{0.7ex}%
  \begin{tabularx}{\textwidth}{@{}X r@{}}
    \textbf{#1} & #2
  \end{tabularx}\par
  \textit{#3}\par
  \vspace{-0.3ex}%
}

% Entry with no role line (achievements, certifications).
% \cvrecord{Title - Location}{Date}
\newcommand{\cvrecord}[2]{%
  \vspace{0.7ex}%
  \begin{tabularx}{\textwidth}{@{}X r@{}}
    \textbf{#1} & #2
  \end{tabularx}\par
  \vspace{-0.3ex}%
}

% Free-standing descriptive line under an entry.
\newcommand{\cvdesc}[1]{{\small #1}\par}

% Tight bullet list.
\newlist{cvbullets}{itemize}{1}
\setlist[cvbullets]{
  label=\textbullet,
  leftmargin=1.4em,
  labelsep=0.5em,
  topsep=0.25ex,
  itemsep=0.15ex,
  parsep=0pt,
  partopsep=0pt,
  font=\small,
  before=\small,
}

% Tight bullet list used for the skills section (no surrounding entry).
\newlist{cvskills}{itemize}{1}
\setlist[cvskills]{
  label=\textbullet,
  leftmargin=1.4em,
  labelsep=0.5em,
  topsep=0.3ex,
  itemsep=0.2ex,
  parsep=0pt,
  partopsep=0pt,
  before=\small,
}

\endinput
