\name{salamander}

\alias{salamander}
\title{Salamander mating dataset from McCullagh and Nelder (1989)}

\description{

The salamader dataset is from an experiment conducted at the University of Chicago in 1986 to study the extent to which 
mountain dusky salamanders from different populations would interbred. 
More detailed description of the data is given in McCullagh 
and Nelder (1989, Section 14.5).


The dataset contains 6 columns and 360 rows. 

\describe{
\item{y}{whether a mating was successful, Yes=1 and No=0.}
\item{female}{identification number of the female salamander.}
\item{male}{identification number of the male salamander.}
\item{group}{group number; 1,2,3,4,5,6}
\item{experiment}{experiment number; 1,2,3.}
\item{rbm}{type of the male salamander; Rough Butt=1 and White Side=0}
\item{rbf}{type of the female salamander; Rough Butt=1 and White Side=0}
\item{wsm}{type of the male salamander; White Side=1 and Rough Butt=0}
\item{wsf}{type of the female salamander; White Side=1 and Rough Butt=0}
\item{ww}{interaction between female White Side and male White side; 1: a White Side female was crossed with a White Side male}
}

}


\examples{

data(salamander) 
str(salamander)


}

\source{McCullagh P. and Nelder, J. A. 1989. \emph{Generalized Linear Models}, Section 14.5, Chapman and Hall/CRC.}
\keyword{datasets}
