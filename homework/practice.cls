%%
%% This is file `practice.cls',
%%
%% Style for homework and practices
%%
%% Copyright 2017 zodiacfireworks
%%

%% Package info ---------------------------------------------------------------
\def\RCSfile{practice}%
\def\RCSversion{0.1}%
\def\RCSdate{2017/06/28}%
\def\@shortjnl{\relax}
\def\@journal{SoftButterfly}
\def\@company{SoftButterfly}
\def\@shortjid{practice}
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{\@shortjid}[\RCSdate, \RCSversion: \@journal]

%% Options --------------------------------------------------------------------
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions
\LoadClass{article}

%% Requirements ---------------------------------------------------------------
\RequirePackage[spanish]{babel}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{graphicx}
\RequirePackage{xstring}
\RequirePackage{xcolor}
\RequirePackage{ifthen}
\RequirePackage{babel}

%% Misc settings ad the begin of the document ---------------------------------
\AtBeginDocument{%
  % No indentation
  \setlength{\parindent}{0pt}%
}

%% Page aspect definitions ----------------------------------------------------
% Color customization
\definecolor{textcolor}{rgb}{0.1216, 0.1216, 0.1216}
\definecolor{backgroundcolor}{rgb}{0.9804, 0.9804, 0.9804}
\def\textcolor{textcolor}
\def\backgroundcolor{backgroundcolor}

\AtBeginDocument{%
  \color{\textcolor}\global\let\default@color\current@color%
  \pagecolor{\backgroundcolor}%
}

%% Utilities -----------------------------------------------------------------
\newcommand*\iflanguagepackage[1]{%
  \@ifpackageloaded{babel}{#1}{%
  \@ifpackageloaded{polyglossia}{#1}{}}%
}

%% Environments --------------------------------------------------------------
% The problem environment
\newcommand*\problemname{Problem}
\iflanguagepackage{%
  \addto\captionsenglish{\def\problemname{Problem}}%
  \addto\captionsspanish{\def\problemname{Problema}}%
}

\newcounter{problem}
\renewcommand{\theproblem}{\arabic{problem}}
\def\@theproblem{{\bfseries \problemname~\arabic{problem}}}

\newenvironment{problem}[1]{
  \refstepcounter{problem}\par\bigskip
  \@theproblem\par
  #1%
}{\par\medskip\ignorespacesafterend}

% The problem part environment
\newcounter{problempart}[problem]
\renewcommand{\theproblempart}{\theproblem\alph{problempart}}
\def\@theproblempart{\alph{problempart})}

\newenvironment{problempart}[1]{
  \refstepcounter{problempart}\par\bigskip
  \setlength{\leftskip}{10pt}
  \@theproblempart~{#1}%
}

% The problem recomendation environment
\newcommand*\recommendationname{Recommendation}
\iflanguagepackage{%
  \addto\captionsenglish{\def\recommendationname{Recommendation}}%
  \addto\captionsspanish{\def\recommendationname{Recomendación}}%
}

\def\@therecommendation{\textit{\bfseries \recommendationname:}}

\newenvironment{recommendation}[1]{
  \par\bigskip
  \@therecommendation~{#1}%
}

% The problem solution environment
\newcommand*\solutionname{Solution}
\iflanguagepackage{%
  \addto\captionsenglish{\def\solutionname{Solution}}%
  \addto\captionsspanish{\def\solutionname{Solución}}%
}

\def\@thesolution{\textit{\bfseries \solutionname:}}

\newenvironment{solution}[1]{
  \par\bigskip
  \@thesolution~{#1}%
}

%% make title customization ---------------------------------------------------
% Logo: Optional
\let\@logo\@empty
\newcommand{\logo}[1]{
  \def\@logo{#1}
}

% University: Optional
\let\@university\@empty
\newcommand{\university}[1]{
  \def\@university{#1}
}

% Coutse: Optional
\def\@course{\@latex@warning@no@line{No \noexpand\course given}}
\newcommand{\course}[1]{
  \def\@course{#1}
}

\def\maketitle{
  \begin{center}
    % if no \logo then launch a warning, else, put the logo at the page top
    \ifx\@logo\@empty
      \logo{\@latex@warning@no@line{No \noexpand\logo given}}
      \@logo
    \else
      \includegraphics[width=1cm]{\@logo}\par
      % if no \university add space after \logo
      \ifx\@university\@empty
        \vskip\baselineskip
      \fi
    \fi

    % if no \univeristy then launch a warning, else, put the \university
    % and then put an space.
    \ifx\@university\@empty
      \university{\@latex@warning@no@line{No \noexpand\university given}}
      \@university
    \else
      \small\textsc{\@university}\par
      \vskip\baselineskip
    \fi

    % if no \course then launch a warning, else, put the \university
    % and then put an space.
    \ifx\@course\@empty
      \course{\@latex@warning@no@line{No \noexpand\course given}}
      \@course
    \else
      \normalsize\@course\par
    \fi

    % \title is required
    {\Large\@title\par}
  \end{center}
  \vskip\baselineskip%
  \hrule\par\par%
}
