# HitPaRank
HitPaRank was developed as a tool to help select text units towards building a ground truth for concept-modeling which is domain expert controlled and geared towards replicability. It uses domain expert built lists of terms relevant to particular research questions applicable to a specific text corpus to help locate, extract and rank paragraphs from the corpus. It also helps defining and refining the actual term lists, adapting the theoretically relevant terms to the actual real-world forms as present in the corpus. It is currently geared towards working on corpora available in FoLiA XML format (https://proycon.github.io/folia/).

The name stands for: '(Query) Hit Paragraph Ranker'.

# Background
HitPaRank was developed in the context of the paper "Expert Concept-Modeling Ground Truth Construction for Word Embeddings Evaluation in Concept-Focused Domains", (https://aclanthology.org/2020.coling-main.586/).
# Companion Github Repository
More information about this work, its background, the QUINE corpus used and the actual Ground Truth built in part on the basis of HitPaRank output is available on this Companion Github Repository: https://github.com/YOortwijn/QuiNE-ground-truth.
# Working Modes
HitPaRank is a Perl script that extracts the paragraphs possibly relevant to the research question from the corpus. 

The script currently has three modes of working:

1/ Extraction of word ngrams (currently n <= 4) from the FoLiA XML files, in this study from the lemmatized text layer.

2/ Checking the wild card versions of the query terms deemed relevant to the researchers as regards the research question against the actual ngrams extracted from the corpus by 1/ and returning an expanded list of query terms and their actual corpus frequencies. In fact, this mode also shrinks the wildcard version of the lists in that non-occurring terms are not returned.

3/ Extraction of the paragraphs that give hits on any of the query term lists and gathering statistics on these actual paragraphs extracted, on the individual paragraph level and over the entire corpus. Table x gives some examples and more detailed information on the actual statistics collected.
# Input
To work, this Perl prototype requires

A/ A corpus in FoLiA XML format. In FoLiA XML, each text unit, i.e. each paragraph, sentence and individual word token, is assigned a unique identifier. Each extracted paragraph will be identified by its unique FoLiA paragraph ID. 

Unfortunately, for reasons of copyright, we cannot here share the corpus used in this study.

B/ Five lists of expert selected terms to query the corpus paragraphs for and to serve to rank the paragraphs based on the collected hit statistics.

We provide the five lists used in this study, in the format actually used by HitPaRank, below.
# The five expert-built lists
These lists are also available in spreadsheet format from the Companion Github Repository, where more detailed information is also provided.

List 1: [QUINE.ListX.txt](https://github.com/martinreynaert/HitPaRank/files/7661663/QUINE.ListX.txt)


List 2: [QUINE.ListY.txt](https://github.com/martinreynaert/HitPaRank/files/7661791/QUINE.ListY.txt)


List 3: [QUINE.ListYbis.txt](https://github.com/martinreynaert/HitPaRank/files/7661796/QUINE.ListYbis.txt)


List 4: [QUINE.ListZ.txt](https://github.com/martinreynaert/HitPaRank/files/7661799/QUINE.ListZ.txt)

List 5:
# Output

Output is in tab-separated columns. A header to each output file identifies the column's contents.

The HitPaRank script in mode 3/ delivers three output files: 

A/ Extracted paragraphs. Output file extension: *.Paragraphs.tsv

B/ Condensed paragraph info. Output file extension: *.RankCounts.tsv

C/ Summary of corpus-wide statistics. Output file extension: *.CorpusSummary.tsv

The prefix for the output files needs to be specified at run-time.
# Statistics reported in the output
Based on the statistics regarding each of the list hits, we precede each output line - each line containing all the data gathered for one paragraph - with a 5 letter Y/N code. This code provides a quick overview of which lists provided hits and allows for quick and easy selection of those paragraphs that do or do not contain any of the search terms. 

Further, for each of the five lists an overview is provided of the number of hits per rank, followed by the uniqued list terms that provided the hits. In so far that query terms may actually reoccur within the lists as part of either compounds or ngrams, i.e. multi-word expressions, multiple hits produced for a single paragraph are uniqued and counted as single hits towards to final hit score. Likewise terms fully re-occurring in a single paragraphs. 

Nevertheless the total hit score is also tallied and this score contrasted to the uniqued hit score allows us to also calculate a hit type-token ratio for each paragraph. This we also provide to the expert-annotators as a help towards deciding on the overall ranking within the retrieved paragraphs and to assign their relevance score to each paragraph retained for further annotation of `grade of relevance'.
# Actual output files for this study
The HitPaRank output files underlying this study are in this archive: [QUINETWIG112.20200629.tar.gz](https://github.com/martinreynaert/HitPaRank/files/7661857/QUINETWIG112.20200629.tar.gz).
