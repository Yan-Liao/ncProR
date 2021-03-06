% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Structure.R
\name{computeStructure}
\alias{computeStructure}
\title{Computation of the Secondary Structural Features of RNA or Protein Sequences}
\usage{
computeStructure(seqs, seqType = c("RNA", "Pro"), structureRNA.num = 6,
  structurePro = c("ChouFasman", "DeleageRoux", "Levitt"),
  Fourier.len = 10, workDir.Pro = getwd(), as.list = TRUE,
  path.RNAsubopt = "RNAsubopt", path.Predator = "Predator/predator",
  path.stride = "Predator/stride.dat", verbose = FALSE,
  parallel.cores = 2)
}
\arguments{
\item{seqs}{sequences loaded by function \code{\link[seqinr]{read.fasta}} of package
"seqinr" (\code{\link[seqinr]{seqinr-package}}). Or a list of RNA/protein sequences.
RNA sequences will be converted into lower case letters, but
protein sequences will be converted into upper case letters, and non-AA letters will be ignored.
Each sequence should be a vector of single characters.}

\item{seqType}{a string that specifies the nature of the sequence: \code{"RNA"} or \code{"Pro"} (protein).
If the input is DNA sequence and \code{seqType = "RNA"}, the DNA sequence will be converted to RNA sequence automatically.
Default: \code{"RNA"}.}

\item{structureRNA.num}{integer. The number of random samples of suboptimal structures. Default: \code{6}.}

\item{structurePro}{strings specifying the secondary structural information that are extracted from protein sequences.
Ignored if \code{seqType = "RNA"}.
Options: \code{"ChouFasman"}, \code{"DeleageRoux"}, and \code{"Levitt"}. See details below.(Ref: [2-4])
Multiple elements can be selected at the same time.}

\item{Fourier.len}{postive integer specifying the Fourier series length that will be used as features.
The \code{Fourier.len} should be >= the length of the input sequence. Default: \code{10}.}

\item{workDir.Pro}{string specifying the directory for temporary files.
The temp files will be deleted automatically when
the calculation is completed.}

\item{as.list}{logical. The result will be returned as a list or data frame.}

\item{path.RNAsubopt}{string specifying the location of RNAsubopt program. (Ref: [5])}

\item{path.Predator}{string specifying the location of Predator program. (Ref: [6])}

\item{path.stride}{string specifying the location of file "stride.dat" required by program Predator.}

\item{verbose}{logical. Should the relevant information be printed during the calculation? (Only available on UNIX/Linux.)}

\item{parallel.cores}{an integer that indicates the number of cores for parallel computation. Default: \code{2}.
Set \code{parallel.cores = -1} to run with all the cores.}
}
\value{
This function returns a data frame if \code{as.list = FALSE} or returns a list if \code{as.list = TRUE}.
}
\description{
The function \code{computeStructure} computes the secondary structural features of RNA
or protein sequences.
}
\details{
The secondary structures of RNA and protein are computed by RNAsubopt and Predator, respectively.
And the protein secondary features are encoded using three amino acid scales:
\enumerate{
\item Chou & Fasman conformational parameter (Ref: [2])
\item Deleage & Roux conformational parameter (Ref: [3])
\item Levitt normalised frequency (Ref: [4])
}
The feature encoding strategy is based on lncPro (Ref: [7]).
}
\section{References}{

[1] Han S, Liang Y, Li Y, \emph{et al}.
ncProR: an integrated R package for effective ncRNA-protein interaction prediction.
(\emph{Submitted})

[2] Chou PY, Fasman GD.
Prediction of the secondary structure of proteins from their amino acid sequence.
Adv. Enzymol. Relat. Areas Mol. Biol. 1978; 47:45-148

[3] Deleage G, Roux B.
An algorithm for protein secondary structure prediction based on class prediction.
Protein Eng. Des. Sel. 1987; 1:289-294

[4] Levitt M.
Conformational preferences of amino acids in globular proteins.
Biochemistry 1978; 17:4277-85

[5] Frishman D, Argos P.
Incorporation of non-local interactions in protein secondary structure prediction from the amino acid sequence.
Protein Eng. 1996; 9:133-42

[6] Lorenz R, Bernhart SH, Honer zu Siederdissen C, \emph{et al}.
ViennaRNA Package 2.0.
Algorithms Mol. Biol. 2011; 6:26

[7] Lu Q, Ren S, Lu M, \emph{et al}.
Computational prediction of associations between long non-coding RNAs and proteins.
BMC Genomics 2013; 14:651
}

\examples{
\dontrun{
data(demoNegativeSeq)
seqsRNA <- demoNegativeSeq$RNA.negative
seqsPro <- demoNegativeSeq$Pro.negative

StructureRNA <- computeStructure(seqsRNA, seqType = "RNA", structureRNA.num = 8,
                                 Fourier.len = 12, as.list = FALSE,
                                 path.RNAsubopt = "RNAsubopt", parallel.cores = 2)

StructurePro <- computeStructure(seqsPro, seqType = "Pro",
                                 structurePro = c("ChouFasman", "DeleageRoux",
                                                  "Levitt"),
                                 Fourier.len = 10, workDir.Pro = getwd(),
                                 as.list = TRUE,
                                 path.Predator = "Predator/predator",
                                 path.stride = "Predator/stride.dat",
                                 parallel.cores = 2)
}
}
\seealso{
\code{\link{runRNAsubopt}}, \code{\link{runPredator}}, \code{\link{featureStructure}}
}
