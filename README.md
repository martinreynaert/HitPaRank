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

1/ Extraction of word ngrams (currently n <= 4) from the FoLiA XML files, in this study from the lemmatized text layer. Parameter: 'F'.

2/ Checking the wild card versions of the query terms deemed relevant to the researchers as regards the research question against the actual ngrams extracted from the corpus by 1/ and returning an expanded list of query terms and their actual corpus frequencies. In fact, this mode also shrinks the wildcard version of the lists in that non-occurring terms are not returned. Parameter: 'E'.

3/ Extraction of the paragraphs that give hits on any of the query term lists and gathering statistics on these actual paragraphs extracted, on the individual paragraph level and over the entire corpus. Parameter: 'A'.

Table x gives some examples and more detailed information on the actual statistics collected.
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
# Contents of Output List A/
The contents of Output List A/ are 23 tab separated columns. On the basis of the headers to the columns we describe their individual contents.

**9999** : The header to the first column is the rather arbitrarily large number: 9,999. This is to ensure that when the full output file is numerically sorted on this column, the header will remain on top, the value being larger than any that is likely ever to have been calculated for any of the paragraph, given any corpus.

The numbers in this column are in fact derived from the data in the column headed 'CollectedHitRankSummary'. After we have there described the contents, we will give the formula to arrive at the value per paragraph in this 'ranking' column.

The higher the value in this column, the more hits, or better, the more higher ranked hits were found in the entire paragraph. So, we expect the user to mainly want to sort this column numerically and descendingly.

One might e.g. use this column to rank only the paragraphs selected by e.g. focusing only on a particular pattern of List hits in the second column, headed 'LABEL:UYYbisXZ'. Or one might query the table for a particular pattern, e.g. 'naturali*' (as the experts did for Research Question 1 in the paper), in the relevant Term List's column, and then rank these. In fact, we think the possibilities are primarily limited by the user's command-line skills, given the user consults this output file on the command-line. 

**LABEL:UYYbisXZ** : The label gives a quick overview over whether or not the paragraph gave hits on the lists. 'Y': one or more hits. 'N': There were no hits. The ordering of the lists is specified in the header. 

Example: 'YYYNN': the paragraph gave hits on lists U, Y and Ybis, but none on lists X and Z.

**Paragraph_ID** : This is a sequentially produced ID based on the number of the retrieved paragraph, meant for easy reference. 

Example: 'P_000010': the tenth paragraph retrieved from the corpus.

**Paragraph_Reference** : This is the actual reference to the paragraph in the whole corpus, specifying the full input file name supplemented by the sequence number of the paragraph within that file. 

Example: (the actual reference to the FoLiA version of 'P_000010': 'QUINE-A-1933a-A_Theorem_in_the_Calculus_of_Classes-V0_5.txt.p.10'. First we have 'QUINE': the name for our corpus. Next: 'A': Willard Van Orman Quine was the author of this paragraph. The book was the first ('a') to be published by him in 1933. Follows the (possibly shortened or slightly modified) title of the work. 'V0_5' signifies this is version 0.5 of the QUINE corpus. The 'txt' signifies the original input file that was converted to FoLiA XML was a plain text file. Finally we get 'p.', i.e. paragraph, and its sequential number, here: '10'.

**CollectedHitRankSummary** : This is a collation of the information gathered about the hits on the 5 lists.

Example: 'U:3:1,Y:2:1Y:3:3,Ybis:3:2' (source: P_013705 or QUINE-A-1981d-Grammar_Truth_and_Logic-V0_5.txt.p.18): There was one hit with rank '3' in List U, one hit with rank '2' and 3 with rank '3' in List Y and 2 hits with rank '3' in List Ybis.

**CollectedHits** : This collates the hit terms from the five lists. The 'empty-field' label '--' signifies there were no hits in a particular list.

Example (same source as example for previous column): 'channeling[1] grammar[1] logical[1] logician[1] mathematician[1] scientific[1] truth[2] -- --'. The numbers between square brackets give the number of times the term was found in the paragraph: only the term 'truth' occurred twice in this paragraph.

**#TokensInParagraph** : a simple count of the number of tokens within the paragraph.

**TotalUniquedScore** : Counting each retrieved term just once, given the example above for 'CollectedHits', we arrive at '7' for this score.

**TotalUniquedScorePercentage** : this is the percentage of the number for TotalUniquedScore versus the number of #TokensInParagraph.

**TotalHitCount** : Summing the frequencies of occurrence for the retrieved terms, we arrive at '8' for this score, given the example above for 'CollectedHits'.

**HitTypeTokenRatio** : We calculate this percentage on the basis of the TotalUniquedScore and the TotalHitCount.

The next 10 columns detail, in two columns per List, the same information as described and exemplified for the columns 'CollectedHitRankSummary' and 'CollectedHits'. The ordering of the Lists replicates the order stated in the header of the first column: 'LABEL:UYYbisXZ'.

**SummaryUnique_Hits_U**

**Unique_Hits_U**

**SummaryUnique_Hits_Y**

**Unique_Hits_Y**

**SummaryUnique_Hits_Ybis**

**Unique_Hits_Ybis**

**SummaryUnique_Hits_X**

**Unique_Hits_X**

**SummaryUnique_Hits_Z**

**Unique_Hits_Z**

**Paragraph_(lemmatized)** : The actual paragraph in lemmatized form extracted from the FoLiA XML corpus file. All statistics reported in this file are derived from this lemmatized text layer in the FoLiA XML. For this study, the lemmatizer used was Spacy. For clear identification, the paragraph is preceded by the lable: 'LEM:'.

**Paragraph_(tokenized)** : The actual paragraph in tokenized form extracted from the FoLiA XML corpus file. For this study, the lemmatizer used was UCTO. For clear identification, the paragraph is preceded by the lable: 'TOK:'.
