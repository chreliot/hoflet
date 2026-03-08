% -------------------------------- identification ------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{hoflet}[2026-03-08]


% -------------------------------- initial code -------------------------



% --------------------------- declaration of options --

% \DeclareOption{12pt}{\PassOptionsToClass{12pt}{article}}

\DeclareKeys {
  report.if = @hoflet@report,
  noclosing.if = @hoflet@noclosing, 
  noletterhead.if = @hoflet@noletterhead
}

% \DeclareOption{nosignature}{code}

% ------------------ forward non-key options to article -----
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}%
}

% ---------------------------- execution of options ---------------------

\ProcessKeyOptions

\ProcessOptions\relax  % run old-style option handler so 12pt can be passed through to article



% --------------------------------package loading ------------------------

\LoadClass{article} 

\RequirePackage{ifthen}

\RequirePackage{geometry}
\geometry{letterpaper,driver=luatex,top=1.5in,bottom=1.5in,hmargin=1.13in}

\RequirePackage{ragged2e}

\RequirePackage{url}

\RequirePackage{graphicx}
\graphicspath{ {../images/} }
\RequirePackage{tikz}

% -------------------------------- main code ----------------------------


% format paragraphs: ragged right, no indenting, and 1 em inter-paragraph spacing

\AtBeginDocument{%
  \setlength{\parindent}{0pt}%
  \setlength{\parskip}{1em}%
  \RaggedRight%
}

% create input commands for the user to store letter information

\def\recipient#1{\gdef\@recipient{#1}}   % e.g., Professor Barbara McClintock
\def\salutation#1{\gdef\@salutation{#1}} % e.g., Dr. McClintock
\def\mailingaddress#1{\gdef\@mailingaddress{#1}} % e.g.,  Cold Spring Harbor Laboratory\\ 1 Bungtown Rd\\ Cold Spring Harbor, NY 11724
\def\myfullname#1{\gdef\@myfullname{#1}} % e.g., Christopher H. ELiot
\def\myposition#1{\gdef\@myposition{#1}} % e.g., Associate Professor

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% opening, and report class option %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% define two versions of opening: date, recipient address, salutation
% first version is with the `report` class option active
% second version is a regular letter with no options

\if@hoflet@report               % `report` class option active
\def\makeopening{%
  \par                          % end any previous paragraph
  \begingroup
   \leftskip=0pt\rightskip=0pt % remove any horizontal glue
   \parindent=0pt              % no first-line indent
   \RaggedRight                % make text flush left
   \noindent\today\par         % the date, flush with left margin
   \vspace{1.5em}
   % \noindent\@recipient\\    % recipient and salut commented out 
   % \noindent\@mailingaddress\par
   % \medskip%
   %  \noindent Dear~\@salutation,\par
   % \medskip%
   \bigskip
  \endgroup
}
\else  
\def\makeopening{%       % without `report` class active — regular letter
  \par                          % end any previous paragraph
  \begingroup
   \leftskip=0pt\rightskip=0pt % remove any horizontal glue
   \parindent=0pt              % no first-line indent
   \RaggedRight                % make text flush left
   \noindent\today\par         % the date, flush with left margin
   \vspace{1.5em}
   \noindent\@recipient\\
   \noindent\@mailingaddress\par
   % \medskip%
   \noindent Dear~\@salutation,\par
   % \medskip%
  \endgroup
}
\fi


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% closing, and noclosing class option %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% define closing: 
% define two versions closing: signature, name, affiliation
% first version is with the `noclosing` class option active
% second version is a regular letter with no options


\if@hoflet@noclosing  % `noclosing` class option active
 \def\makeclosing{
 \par \vspace{1.5em}
 }
\else
\def\makeclosing{
\par \vspace{1.5em}
\setlength{\parindent}{0pt}%
\setlength{\parskip}{0pt}%
Respectfully submitted,\par
\includegraphics[alt={the sender's signature},height=2cm]{signature.png}\par
\@myfullname \\ \@myposition
}
\fi  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% letterhead images, and noletterhead class option %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% create letterhead overlays
% if the noletterhead option is selected, the overlay is whitespace

% for the noletterhead option, compute exact aspect ratios of images to replace with whitespace
\newlength{\headerheight}
\newlength{\footerheight}
\setlength{\headerheight}{\dimexpr \paperwidth/85*19\relax}    % header: 570/2550 = 19/85
\setlength{\footerheight}{\dimexpr \paperwidth/2562*495\relax} % footer: 495/2562

\if@hoflet@noletterhead

% whitespace header (from page.north west downwards)
\newcommand{\makeheader}{%
  \begin{tikzpicture}[remember picture, overlay]
    \path (current page.north west) rectangle ++(\paperwidth,-\headerheight);
  \end{tikzpicture}%
}

% whitespace footer (from page.south west upwards)
\newcommand{\makefooter}{%
  \begin{tikzpicture}[remember picture, overlay]
    \path (current page.south west) rectangle ++(\paperwidth,\footerheight);
  \end{tikzpicture}%
}

\else

% image header (from page.north west downwards)
\newcommand{\makeheader}{%
  \begin{tikzpicture}[remember picture, overlay]
    \node[anchor=north west,inner sep=0,outer sep=0]
      at (current page.north west)
      {\includegraphics[alt={Hofstra University letterhead header},width=\paperwidth]{../images/department-header.png}};
  \end{tikzpicture}%
}

% image footer (from page.south west upwards)
\newcommand{\makefooter}{%
  \begin{tikzpicture}[remember picture, overlay]
    \node[anchor=south west,inner sep=0,outer sep=0]
      at (current page.south west)
      {\includegraphics[alt={Hofstra University letterhead footer},width=\paperwidth]{../images/department-footer.png}};
  \end{tikzpicture}%
}

\fi


% make "cc:" section after everything, if cc is defined
% format is hanging indent, following university style

\makeatletter

% default label (user/class may \renewcommand\ccname{Copied to})
\providecommand\ccname{cc}

% set indent length for cc recipient column (change 1cm if you you like)
\newlength\ccindent
\setlength\ccindent{1cm}

% store appended CC entries in a list
\newcommand\@cclist{}%

% \cc{...} appends to \@cclist, so that multiple calls work
\newcommand\cc[1]{%
  \ifx\@cclist\@empty
    \gdef\@cclist{#1}%
  \else
    \g@addto@macro\@cclist{\\#1}%
  \fi
}

% simple \makecc: label flush left, recipients start at \ccindent
\newcommand\makecc{%
  \ifx\@cclist\@empty
    % nothing to do
  \else
    \par\vspace{1.5cm}
    \noindent
    % put label flush left without taking horizontal space
    \makebox[0pt][l]{\normalfont\ccname:}%
    % then leave \ccindent of space and typeset recipients inside a parbox
    \hspace{\ccindent}%
    \parbox[t]{\dimexpr\linewidth-\ccindent\relax}{%
      \raggedright
      \ignorespaces\@cclist\strut
    }%
    \par
  \fi
}
\makeatother

\thispagestyle{empty}


\AtBeginDocument{\makeheader}
\AtBeginDocument{\makefooter}


\AtBeginDocument{\makeopening}
\AtEndDocument{\makeclosing}
\AtEndDocument{\makecc}