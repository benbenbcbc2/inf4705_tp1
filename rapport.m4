changequote(`<', `>')

\documentclass[letterpaper,12pt,final]{article}

\usepackage{datatool}

%% For the lab, we want to number the subsections in roman numerals to
%% follow the assignment
\renewcommand{\thesubsection}{\thesection.\roman{subsection}}

%%%%%%%%%%%%%%%%%%%%%%%%
%tmp
\usepackage{color}
\newcommand{\hilight}[1]{\colorbox{yellow}{\parbox{\dimexpr\linewidth-2\fboxsep}{#1}}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% Détails de langue pour bien supporter le français
%  Accepte les caractères accentués dans le document (UTF-8).
\usepackage[utf8]{inputenc}
% Police de caractères plus complète et généralement indistinguable
% visuellement de la police standard de LaTeX (Computer Modern).
\usepackage{lmodern}
% Bon encodage des caractères pour que les lecteurs de pdf
% reconnaissent les accents et les ligatures telles que ffi.
\usepackage[T1]{fontenc}
% Règles typographiques et d' "hyphenation" propres aux langues
\usepackage[english,frenchb]{babel}


%%%% Packages pour les références
\usepackage{hyperref}
\usepackage[numbers]{natbib}


%%%% Packages pour l'affichage graphique
% Charge le module d'affichage graphique.
\usepackage{graphicx}
% Recherche des images dans les répertoires.
\graphicspath{{./dia}}
% Un float peut apparaître seulement après sa définition, jamais avant.
\usepackage{flafter}
% Hyperlien vers la figure plutôt que son titre.
\usepackage{caption}
\usepackage{subcaption}
\usepackage{gnuplottex}
\usepackage{geometry}

%% Exemple de figure:
% \begin{figure}[h]
%   \centering
%     \includegraphics[width=\linewidth]{./dia/diagramme.png}
%   \caption{Diagramme de classes du projet}\label{fig:dia_classes}
% \end{figure}



%%%% Packages pour l'affichage de différents types de texte
% Code source:
\usepackage{listings} % Code inline: \lstinline|<code here>|
\lstset{basicstyle=\ttfamily\itshape}
% Symboles mathématiques
\usepackage{amssymb}
% Manipulation de l'espace (page titre)
\usepackage{setspace}
%
% Ligne horizontale pour l'affichage du titre
\newcommand{\HRule}{\rule{\linewidth}{0.5mm}}


%%%% Variables pour le document
% Type de rapport
\newcommand{\monTypeDeRapport}{Rapport de laboratoire}
% Titre du document
\newcommand{\monTitre}{TP1}
% Auteurs
\newcommand{\mesAuteurs}{Premier Auteur, Second Auteur}
\newcommand{\mesAuteursX}{Premier Auteur, XXXXXXX \\ Second Auteur, XXXXXXX}
% Sigle du cours
\newcommand{\monCoursX}{INF4705}
% Nom du cours
\newcommand{\monCours}{Analyse et conception d’algorithmes}


%%%% Informations qui sont stockées dans un fichier PDF.
\hypersetup{
  pdftitle={\monTitre},
  pdfsubject={\monCours},
  pdfauthor={\mesAuteurs},
  bookmarksnumbered,
  pdfstartview={FitV},
  hidelinks,
  linktoc=all
}



\begin{document}
    %% Page titre du rapport
    \begin{titlepage}
      \begin{center}

        \begin{doublespace}

          \vspace*{\fill}
          \textsc{ \large \monTypeDeRapport}
          \vspace*{\fill}

          \HRule \\ [5mm]
          {\huge \bfseries \monTitre}\\ [3mm]
          \HRule \\
          \vspace*{\fill}

          \begin{onehalfspace} \large
            \mesAuteursX
          \end{onehalfspace}

          \vfill
          { \Large Cours \monCoursX \\ \monCours } \\

          \today

        \end{doublespace}
      \end{center}
    \end{titlepage}

\newpage

%% Insertion d'une table des matières
%  Cette ligne peut être enlevée si l'on ne 
%  veut pas de table des matières.
\tableofcontents\newpage

\section{Introduction}

Dans le but d'apprendre à décider quel algorithme utiliser dans
différentes situations, il est primordial de s'exercer à l'analyse de
ceux-cis.  L'objectif de ce laboratoire est donc de faire l'analyse
selon plusieurs techniques vues en classe d'algorithmes de tri que
nous implémentons nous-mêmes.  Suivant l'introduction de ces
algorithmes ainsi que le cadre expérimental et les données, notre
analyse de ceux-cis sera exposée en utilisant les approches empirique,
théorique et hybride pour finalement décider des situations où chacun
est avantageux.

\section{Algorithmes implémentés}

Les algorithmes implémentés sont deux algorithmes récursifs, soit le
tri par paquets (\textit{bucketsort}) et le tri par fusion
(\textit{mergesort}).  Aussi, on analyse leur version hybride qui
emploie le tri par insertion pour les exemplaires de petite taille.
En effet, malgré la complexité supérieure du tri par insertion, ses
facteurs constants généralement inférieurs en font un choix plus
rapide pour les petites listes.  Le seuil auquel on passe de
l'algorithme principal au tri par insertion et l'influence de ce choix
seront également étudiés.

Ces algorithmes ne sont pas écrits dans leur version \textit{in~situ},
mais plutôt dans la version qui retourne un nouveau tableau trié, ce
qui rend leur écriture plus simple. (Les versions populaires du
\textit{bucketsort} et du \textit{mergesort} ne sont pas
\textit{in~situ}, mais celles du tri par insertion le sont.) On ne
cherche donc pas à en particulier à minimiser l'utilisation de la
mémoire.

\hilight{Expliquer le layout du projet maybe?}

\section{Cadre expérimental}

Les algorithmes sont implémentés dans le langage \textit{Python 3}.
L'exécution est faite sur les ordinateurs du laboratoire.  En
particulier, les informations concernant le matériel utilisé sont
présentées à la figure~\ref{lst:hardware}.

\begin{figure}[htbp]
  \centering
  \lstinputlisting[breaklines=true]{results/hardware.txt}
  \caption{Matériel utilisé pour l'exécution des chronométrages}\label{lst:hardware}
\end{figure}

Afin d'améliorer la précision des mesures de temps, il pourrait être
préférable de changer la politique de changement de fréquence des
processeurs pour qu'elle assure une fréquence constante.  En effet, on
utilise la fonction \lstinline|time.process_time()| de Python, qui
donne la somme du temps du côté utilisateur et noyau et ainsi ce temps
est obtenu en prenant le compte des \textit{ticks} de processeur
divisé par la fréquence actuelle \cite{PEP418}.  Alors, si cette
fréquence change entre les mesures, cela peut avoir un effet sur les
temps mesurés.

\hilight{est-ce possible de faire ce changements sur les ordinateurs
  des labos?}

% TODO see https://wiki.archlinux.org/index.php/CPU_frequency_scaling

\section{Jeux de données}

\section{Résultats}

Les résultats sont présentés dans la figure~\ref{lst:results}.  Ils
montrent les fichiers obtenus par nos bancs d'essais.  La première
colonne donne la taille des exemplaires utilisés pour le
chronométrage, et les colonnes suivantes correspondent aux moyennes de
temps d'exécution (en secondes) pour les différents groupes
d'exemplaires de la taille donnée.  Il y a un fichier de résultats par
algorithme et seuil de récursivité.

\begin{figure}[p]
  \centering
  \begin{subfigure}[htbp]{\textwidth}
    \centering
    \lstinputlisting[breaklines=true]{results/bucket.dat}
    \caption{\textit{bucketsort}}
  \end{subfigure}

  \begin{subfigure}[htbp]{\textwidth}
    \centering
    \lstinputlisting[breaklines=true]{results/bucketSeuil.dat}
    \caption{\textit{bucketsort} avec seuil de récursivité}
  \end{subfigure}

  \begin{subfigure}[htbp]{\textwidth}
    \centering
    \lstinputlisting[breaklines=true]{results/merge.dat}
    \caption{\textit{mergesort}}
  \end{subfigure}

  \begin{subfigure}[htbp]{\textwidth}
    \centering
    \lstinputlisting[breaklines=true]{results/mergeSeuil.dat}
    \caption{\textit{mergesort} avec seuil de récursivité}
  \end{subfigure}
  \caption{Fichiers de résultats}\label{lst:results}
\end{figure}

\section{Analyse}

Les résultats obtenus à la section précédente sont analysés ici selon
les diverses méthodes vues en cours.

\subsection{Tests de puissance}

%define(<powertest>, <
\begin{figure}[htbp]
  \centering
  \begin{gnuplot}[terminal=epslatex, terminaloptions=color dashed]
    set print $2
    print "Série, m, b"
    g(x) = 10**b*x**m
    fit g(x) $1 u 1:2 via m,b
    print "0-9,",m,",", b
    fit g(x) $1 u 1:2 via m,b
    print "10-19,",m,",", b
    fit g(x) $1 u 1:2 via m,b
    print "20-29,",m,",", b

    set grid
    set xlabel "Taille des exemplaires à trier [-]"
    set ylabel "Temps d'exécution [s]"
    set logscale xy
    set key center top
    plot $1 u 1:2 w linesp t "Série [ 0- 9]",\
    $1 u 1:3 w linesp t "Série [10-19]",\
    $1 u 1:4 w linesp t "Série [20-29]",\
    g(x) w l t "Régression"
  \end{gnuplot}
  \caption{Tests de puissance pour $3}\label{fig:$4}
\end{figure}

\DTLloaddb{powerdb}{$2}

\begin{table}[htbp]
  \centering
  \DTLdisplaydb{powerdb}
  \caption{Résultats des tests de puissance pour $3}\label{tbl:$4}
\end{table}

\DTLmeanforcolumn{powerdb}{m}{\meanm}
\DTLmeanforcolumn{powerdb}{b}{\meanb}
%>)

powertest("./results/bucket.dat", "./results/bucket_fit.csv", <\textit{bucketsort}>, powbuck)

La fonction trouvée est donc (en prenant les moyennes)
$10^{\meanb}*x^{\meanm}$.

\subsection{Complexités théoriques}

\subsection{Test du rapport}

\subsection{Test des constantes}

\subsection{Choix du seuil de récursivité}

\section{Discussion}

\section{Conclusion}


\bibliographystyle{plainnat} %% or perhaps IEEEtranN
\bibliography{rapport}

\end{document}
