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

# Output Working mode 'A' (Read: 'All' or 'Main working mode')

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

We give the headers to the columns in bold. The examples further discussed are based on the following example paragraph from the QUINE output. The actual tabs in the output have here been replaced by a space enclosed pipe symbol, i.e. ' | ' for reasons of clarity:

```20  |  YYYNN  |  P_013705  |  B_0134P_0018  |  QUINE-A-1981d-Grammar_Truth_and_Logic-V0_5.txt.p.18  |  U:3:1,Y:2:1Y:3:3,Ybis:3:2  |  channeling[1] grammar[1] logical[1] logician[1] mathematician[1] scientific[1] truth[2] -- --  |  146  |  7  |  4.79  |  8  |  87.50  |  U:3:1  |  channeling[1]  |  Y:2:1 Y:3:3  |  grammar[1] logical[1] logician[1] mathematician[1]  |  Ybis:3:2  |  scientific[1] truth[2]  |  n.a.  |  --  |  n.a.  |  --  |  LEM:for the latter-day logician , logical regimentation of grammar be standard procedure . -pron- have note the motivation of one such reform , and -pron- be characteristic of many . other of -pron- reform serve to resolve structural ambiguity ; other serve to economize on construction . -pron- interest in grammatical structure be oneside : -pron- be interested in how -pron- channel truth condition . if a grammatical reform make for a more copious channeling of truth condition and cause no complication in other quarter , -pron- be happy to adopt -pron- . -pron- adopt -pron- not as a reform to be impose on society , but as a technical by-language to expedite scientific inference . the shift be the same in principle as program a computer , and the same , for that matter , as the mathematician 's habitual recourse to plan notation .   |  TOK:For the latter-day logician , logical regimentation of grammar is standard procedure . We have noted the motivation of one such reform , and it is characteristic of many . Others of his reforms serve to resolve structural ambiguities ; others serve to economize on constructions . His interest in grammatical structure is onesided : he is interested in how it channels truth conditions . If a grammatical reform makes for a more copious channeling of truth conditions and causes no complications in other quarters , he is happy to adopt it . He adopts it not as a reform to be imposed on society , but as a technical by-language to expedite scientific inference . The shift is the same in principle as programming a computer , and the same , for that matter , as the mathematician 's habitual recourse to planned notations . ```

A block of data as the example above in fact constitutes a single line in the actual HitPaRank output file.

**The column information, per header**

**9999** : The header to the first column is the rather arbitrarily large number: 9,999. This is to ensure that when the full output file is numerically and descendingly sorted on this column, the header will remain on top, the value being larger than any that is likely ever to have been calculated for any of the paragraph, given any corpus.

The numbers in this column are in fact derived from the data in the column headed 'CollectedHitRankSummary'. After we have there described the contents, we will give the formula to arrive at the value per paragraph in this 'ranking' column.

The higher the value in this column, the more hits, or better: the more higher ranked hits, were found in the entire paragraph. So, we expect the user to mainly want to sort this column numerically and descendingly.

In fact, this column was not yet available at the time we wrote the paper. Its value towards this kind of research as yet needs to be assessed by the experts, but the layman writing this description here is impressed by what he sees.

One might e.g. use this column to rank only the paragraphs selected by e.g. focusing only on a particular pattern of List hits in the second column, headed 'LABEL:UYYbisXZ'. Or one might query the table for a particular pattern, e.g. 'naturali*' (as the experts did for Research Question 1 in the paper), in the relevant Term List's column, and then rank these. In fact, we think the possibilities are primarily limited by the user's command-line skills, given the user consults this output file on the command-line. 

**LABEL:UYYbisXZ** : The label gives a quick overview over whether or not the paragraph gave hits on the lists. 'Y': one or more hits. 'N': There were no hits. The ordering of the lists is specified in the header. 

Example: 'YYYNN': the paragraph gave hits on lists U, Y and Ybis, but none on lists X and Z.

**Paragraph_ID** : This is a sequentially produced ID based on the number of the retrieved paragraph, meant for easy reference. 

Example: 'P_013705': the thirteen thousand seven hundred and fifth paragraph retrieved from the corpus.

**Book_Paragraph_ID** : This is an alternative easy reference short ID for the paragraph that tells the number of the 'book' the paragraph is from and per book sequentially numbers the paragraphs retrieved.

Example: 'B_0134P_0018' : This paragraph is from the 134th. book in the QUINE corpus, and is the 18th. paragraph to have been retrieved on the basis of the five lists.

Works in QUINE (the corpus) come ordered according to their year of publication, possibly followed by a lower case letter (e.g. 'a' or 'b' or 'c', etc.). This identifies each separate volume. A single volume is usually divided over several FoLiA XML files, e.g. per chapter or other subsection. The 'book' number here applies to all the separate files that constitute the original printed volume.

This column immediately would give stats on the number of paragraphs retrieved per book. We surmise it may also facilitate work into studying how the author's ideas developed over time.

This column too is a later addition to HitPaRank, not available at the time of the study.

**Paragraph_Reference** : This is the actual reference to the paragraph in the whole corpus, specifying the full input file name supplemented by the sequence number of the paragraph within that file. 

Example: 'QUINE-A-1981d-Grammar_Truth_and_Logic-V0_5.txt.p.18'. First we have 'QUINE': the name for our corpus. Next: 'A': Willard Van Orman Quine was the author of this paragraph. The book was the fourth ('d') to be published by him in 1981. Follows the (possibly shortened or slightly modified) title of the work. 'V0_5' signifies this is version 0.5 of the QUINE corpus. The 'txt' signifies the original input file that was converted to FoLiA XML was a plain text file. Finally we get 'p.', i.e. paragraph, and its sequential number, here: '18'.

**CollectedHitRankSummary** : This is a collation of the information gathered about the hits on the 5 lists.

Example: 'U:3:1,Y:2:1Y:3:3,Ybis:3:2' (source: P_013705 or QUINE-A-1981d-Grammar_Truth_and_Logic-V0_5.txt.p.18): There was one hit with rank '3' in List U, one hit with rank '2' and 3 with rank '3' in List Y and 2 hits with rank '3' in List Ybis.

The grading score reported in the first column, i.e. under header '9999' is straightforwardly obtained by summing the results of multiplying the ranks with the frequencies observed for all the lists.

Example: So here we get: (3*1) + (2*1) + (3*3) + (3*2) = 20.

**CollectedHits** : This collates the hit terms from the five lists. The 'empty-field' label '--' signifies there were no hits in a particular list.

Example: 'channeling[1] grammar[1] logical[1] logician[1] mathematician[1] scientific[1] truth[2] -- --'. The numbers between square brackets give the number of times the term was found in the paragraph: only the term 'truth' occurred twice in this paragraph.

**TokensInParagraph** : a simple count of the number of tokens within the paragraph.

**TotalUniquedScore** : Counting each retrieved term just once, given the example above for 'CollectedHits', we arrive at '7' for this score.

**TotalUniquedScorePercentage** : this is the percentage of the number for TotalUniquedScore versus the number of TokensInParagraph.

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

# Contents of Output Lists B/ and C/

We think the information given for List A/ together with the self-explanatory nature of presentation of the data in these Lists should suffice.

# Output Working mode 'F' (Read: 'Frequency Lists')

In this mode HitParank requires access to the FoLiA XML corpus only. 

It builds four ngram frequency lists, one each for word unigrams up to word fourgrams. The file names get the extension '.[1-4]gram.tsv'. These are currently written to the same directory the script reads the FoLiA XML files from. Spaces in the multigrams are represented by underscores, i.e. '_'.

**Usage** : $ perl HitPaRank.V1.pl /reddata/EIDEAS/QUINE/QUINEV05FOLIASPACY folia.xml

# Output Working mode 'E' (Read: 'Extend' or 'Expand' tentative expert term lists)

Producing the final term lists was in fact a three step process.

First, the experts produced lists of what they considered relevant terms for their research queries. These broke down into five categories, hence the five lists, finally. These first version lists had wilcards, for terms that likely had multiple word forms in the QUINE corpus.

***The five initial lists, input for Mode 'E'***

List 1:

List 2:

List 3:

List 4:

List 5:

Second, these five lists served as input for the 'E' mode of HitPaRank and produced the following five expanded lists, with extra annotations to appraise the experts of the outcome of the expansion step and to guide them in their final decision-taking over whether or not to retain the expanded terms in the lists. They were further provided with lists of likely (pseudo-)scientific they might have overlooked in building their first version lists or might not even be aware of Quine ever mentioned them in his writing. These were lists drawn from the corpus frequency lists for words ending e.g. in -olog*, -ics, -ism, -omy.

***The five expanded lists, input for for the experts***

List 1:

List 2:

List 3:

List 4:

List 5:

Third, after their final decision-taking round, we finally ended up with the following five manually vetted and curated lists that served as input to Mode 'A' of HitPaRank. 

***The five final lists, input for Mode 'A'***

List 1:

List 2:

List 3:

List 4:

List 5:

These final lists are also available in spreadsheet format from the Companion Github Repository, where more detailed information is also provided.
