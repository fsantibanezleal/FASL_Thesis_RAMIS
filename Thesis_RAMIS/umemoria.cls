%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%
%%%%%%%%	Clase U-Memoria
%%%%%%%%	Primer Autor: Nikolas Tapia M.
%%%%%%%%	Version: 1.5
%%%%%%%%	Fecha: 21-06-2012
%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}[2009/09/24]
\ProvidesClass{umemoria}[2012/06/18 v1.2 Clase LaTeX para estandarizacion de Memorias U. de Chile]

%% Definicion de Condicionales
\newif\if@swapnum
\newif\if@contnum
\@swapnumfalse
\@contnumtrue

%% Declaracion de Opciones
\DeclareOption{leftnum}{\@swapnumtrue}
\DeclareOption{rightnum}{\@swapnumfalse}
\DeclareOption{contnum}{\@contnumtrue}
\DeclareOption{nocontnum}{\@contnumfalse}
\DeclareOption{uprightd}{\AtEndOfPackage{\DeclareMathSymbol{d}{\mathalpha}{operators}{`d}}}
\DeclareOption{uprighte}{\AtEndOfPackage{\DeclareMathSymbol{e}{\mathalpha}{operators}{`e}}}
\DeclareOption{uprighti}{\AtEndOfPackage{\DeclareMathSymbol{i}{\mathalpha}{operators}{`i}}}
\DeclareOption{upright}{\ExecuteOptions{uprightd,uprighte,uprighti}}

%% Pasar Opciones a clase Book
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax
\LoadClass[12pt, openany]{book}

%% Packages necesarios
\RequirePackage[utf8]{inputenc} %Encoding
\RequirePackage[top=2cm, left=3cm, bottom=2cm, right=2cm, paper=letterpaper]{geometry} % Margenes
\RequirePackage{amsmath, amssymb, amsthm, graphicx} % Varios
%\RequirePackage[spanish, es-nolists, es-lcroman]{babel} % Lenguaje
\RequirePackage[english]{babel} % Lenguaje
\RequirePackage[pdfpagelabels]{hyperref} % Links y numeracion del PDF
\RequirePackage{listings} % Codigo Fuente
\RequirePackage{pgffor} % foreach

%% Lenguaje
%\addto\captionsspanish{\renewcommand\tablename{Tabla}}
%\addto\captionsspanish{\renewcommand\contentsname{Tabla de Contenido}}
%\addto\captionsspanish{\renewcommand\listtablename{Índice de Tablas}}
%\addto\captionsspanish{\renewcommand\listfigurename{Índice de Ilustraciones}}
%\addto\captionsspanish{\renewcommand\tablename{Table}}
%\addto\captionsspanish{\renewcommand\contentsname{Contents}}
%\addto\captionsspanish{\renewcommand\listtablename{List of Tables}}
%\addto\captionsspanish{\renewcommand\listfigurename{List of Figures}}
%\addto\captionsenglish{\renewcommand{\chaptername}{Chapter}}

%% Interlineado
\RequirePackage{parskip}
\setlength{\parskip}{1em}
\setlength{\parindent}{15pt}

%% Renovar enumerate e itemize
\let\oldenum\enumerate
\let\oldendenum\endenumerate
\renewenvironment{enumerate}{\oldenum\setlength{\parskip}{\smallskipamount}}{\oldendenum}
\let\olditem\itemize
\let\oldenditem\enditemize
\renewenvironment{itemize}{\olditem\setlength{\parskip}{\smallskipamount}}{\oldenditem}

%% Entornos nuevos

\newenvironment{abstractesp}{%
\cleardoublepage
\begin{flushright}
\small
\begin{tabular}{l}
RESUMEN DE LA TESIS PARA OPTAR \\
AL TÍTULO DE \MakeUppercase\@carrera \\
POR: \MakeUppercase\@author \\
FECHA: \MakeUppercase\@datefullesp\\
PROF. GUÍA: \foreach \x in \@guia { \MakeUppercase\x }
\end{tabular}
\end{flushright}

\begin{center}
\small{
\MakeUppercase\@titleesp
}
\end{center}

}{\vfill\null}

\newenvironment{abstract}{%
\cleardoublepage
\begin{flushright}
\small
\begin{tabular}{l}
SUMMARY OF THE THESIS SUBMITTED \\
FOR THE DEGREE OF \MakeUppercase\@carrera \\
BY: \MakeUppercase\@author \\
DATE: \MakeUppercase\@datefulleng\\
ADVISOR: \foreach \x in \@guia { \MakeUppercase\x }
\end{tabular}
\end{flushright}

\begin{center}
\small{
\MakeUppercase\@title
}
\end{center}

}{\vfill\null}

\newenvironment{dedicatoria}{\cleardoublepage\null\vspace{\stretch{1}}\begin{flushright}\itshape}{\end{flushright}\vspace{\stretch{2}}\null}
\let\thanks\undefined
\newenvironment{thanks}{\cleardoublepage\chapter*{Agradecimientos}}{\vfill\null}
\newenvironment{intro}{
  \chapter*{Introduction}
  \addcontentsline{toc}{chapter}{\protect\numberline{}Introduction}
}{\vfill\null}
\newenvironment{conclusion}{
  \chapter*{Conclusion}
  \addcontentsline{toc}{chapter}{\protect\numberline{}Conclusion}
}{\vfill\null}

%% Teoremas, proofs, etc
\renewenvironment{proof}[1][\proofname] {\par\pushQED{\qed}\normalfont\topsep6\p@\@plus6\p@\relax\trivlist\item[\hskip\labelsep\scshape\footnotesize#1\@addpunct{.}]\ignorespaces}{\popQED\endtrivlist\@endpefalse}

\newtheoremstyle{miestilo}{\baselineskip}{3pt}{\itshape}{}{\bfseries}{}{.5em}{}
\newtheoremstyle{miobs}{\baselineskip}{3pt}{}{}{\bfseries}{}{.5em}{}
\if@swapnum
	\swapnumbers
\fi
\theoremstyle{miestilo}
\newtheorem{defn}{Definition}[chapter]
\if@contnum
\newtheorem{teo}[defn]{Theorem}
\newtheorem{cor}[defn]{Corolario}
\newtheorem{lema}[defn]{Lema}
\newtheorem{prop}[defn]{Proposition}
\else
\newtheorem{teo}{Theorem}[chapter]
\newtheorem{cor}{Corolario}[chapter]
\newtheorem{lema}{Lema}[chapter]
\newtheorem{prop}{Proposition}[chapter]
\fi
\theoremstyle{miobs}
\newtheorem*{ej}{Example}
\newtheorem*{obs}{Observation}

%% Comandos para la portada
\global\let\@carrera\@empty
\newcommand{\setcarrera}[1]{\def\@carrera{#1}}
\let\carrera\setcarrera
\let\setcarrera\relax

\global\let\@memoria\@empty
\newcommand{\setmemoria}[1]{\def\@memoria{#1}}
\let\memoria\setmemoria
\let\setmemoria\relax

\global\let\@guia\@empty
\newcommand{\setguia}[1]{\def\@guia{#1}}
\let\guia\setguia
\let\setguia\relax

\global\let\@depto\@empty
\newcommand{\setdepto}[1]{\def\@depto{#1}}
\let\depto\setdepto
\let\setdepto\relax

\global\let\@comision\@empty
\newcommand{\setcomision}[1]{\def\@comision{#1}}
\let\comision\setcomision
\let\setcomision\relax

\global\let\@auspicio\@empty
\newcommand{\setauspicio}[1]{\def\@auspicio{#1}}
\let\auspicio\setauspicio
\let\setauspicio\relax

\global\let\@titleesp\@empty
\newcommand{\settitleesp}[1]{\def\@titleesp{#1}}
\let\titleesp\settitleesp
\let\settitleesp\relax

\global\let\@datefullesp\@empty
\newcommand{\setdatefullesp}[1]{\def\@datefullesp{#1}}
\let\datefullesp\setdatefullesp
\let\setdatefullesp\relax

\global\let\@datefulleng\@empty
\newcommand{\setdatefulleng}[1]{\def\@datefulleng{#1}}
\let\datefulleng\setdatefulleng
\let\setdatefulleng\relax

%%Portada
\renewcommand{\maketitle}{
	\begin{titlepage}
		\begin{minipage}{1.6cm}
			\includegraphics[scale=.12]{imagenes/escudoU2014.pdf}
		\end{minipage}
		\begin{minipage}[t]{12cm}
			UNIVERSIDAD DE CHILE\\FACULTAD DE CIENCIAS FÍSICAS Y MATEMÁTICAS\\\MakeUppercase\@depto
		\end{minipage}

		\vspace{2cm}
		\centering
			\MakeUppercase\@title

		\vspace{1cm}
			\MakeUppercase\@memoria

		\vspace{1cm}
			\MakeUppercase\@author

		\vspace{2cm}
			\foreach \x [count=\xi] in \@guia {
				PROFESOR \ifnum\xi>1 \ CO- \fi GUÍA:\\ \MakeUppercase\x\\
			}
			

		\vspace{1cm}
			MIEMBROS DE LA COMISIÓN:\\
			\foreach \x in \@comision { \MakeUppercase\x\\ }

		\if\@auspicio\@empty\else
		\vfill
			\normalfont
			Este trabajo ha sido parcialmente financiado por \@auspicio
		\fi

		\vfill
			SANTIAGO DE CHILE\\ \MakeUppercase\@date
	\end{titlepage}
}

%%Estilo del frontmatter
\newcommand{\ps@front}{
	\renewcommand{\thepage}{\roman{page}}
	\renewcommand{\@oddhead}{}
	\renewcommand{\@evenhead}{}
	\renewcommand{\@oddfoot}{\hfill\thepage\hfill}
	\renewcommand{\@evenfoot}{\hfill\thepage\hfill}
}

\let\oldfrontmatter\frontmatter
\renewcommand{\frontmatter}{
	\pagestyle{front}
	\oldfrontmatter
}
\let\oldfrontmatter\relax

%% Miscelaneos
\newcommand{\A}{\mathcal{A}}
\newcommand{\C}{\mathbb{C}}
\newcommand{\D}{\mathbb{D}}
\newcommand{\E}{\mathbb{E}}
\newcommand{\F}{\mathcal{F}}
\newcommand{\G}{\mathcal{G}}
\renewcommand{\H}{\mathcal{H}}
\newcommand{\K}{\mathcal{K}}
\renewcommand{\L}{\mathcal{L}}
\newcommand{\M}{\mathcal{M}}
\newcommand{\N}{\mathbb{N}}
\renewcommand{\M}{\mathcal{M}}
\renewcommand{\P}{\mathbb{P}}
\newcommand{\Q}{\mathbb{Q}}
\newcommand{\R}{\mathbb{R}}
\renewcommand{\S}{\mathcal{S}}
\newcommand{\T}{\mathcal{T}}
\newcommand{\Z}{\mathbb{Z}}
\newcommand{\1}{\mathbf{1}}
\let\epsilon\varepsilon
