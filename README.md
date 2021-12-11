# HitPaRank
HitPaRank was developed as a tool to help select text units towards building a ground truth for concept-modeling which is domain expert controlled and geared towards replicability. It uses domain expert built lists of terms relevant to particular research questions applicable to a specific text corpus to help locate, extract and rank paragraphs from the corpus. It also helps defining and refining the actual term lists, adapting the theoretically relevant terms to the actual real-world forms as present in the corpus. It is currently geared towards working on corpora available in [FoLiA XML format](https://proycon.github.io/folia/).

The name stands for: '(Query) Hit Paragraph Ranker'.

# Background
HitPaRank was developed in the context of the paper "[Expert Concept-Modeling Ground Truth Construction for Word Embeddings Evaluation in Concept-Focused Domains](https://aclanthology.org/2020.coling-main.586/)", COLING2020.
# Companion Github Repository
More information about this work, its background, the QUINE corpus used and the actual Ground Truth built in part on the basis of HitPaRank output is available on this [Companion Github Repository](https://github.com/YOortwijn/QuiNE-ground-truth).
# Working Modes
HitPaRank is a Perl script that extracts the paragraphs possibly relevant to the research question from the corpus. 

The script currently has three modes of working:

1/ Extraction of word ngrams (currently n <= 4) from the FoLiA XML files, in this study from the lemmatized text layer. Parameter: 'F'.

2/ Checking the wild card versions of the query terms deemed relevant to the researchers as regards the research question against the actual ngrams extracted from the corpus by 1/ and returning an expanded list of query terms and their actual corpus frequencies. In fact, this mode also shrinks the wildcard version of the lists in that non-occurring terms are not returned. Parameter: 'E'.

3/ Extraction of the paragraphs that give hits on any of the query term lists and gathering statistics on these actual paragraphs extracted, on the individual paragraph level and over the entire corpus. Parameter: 'A'.

# Dependency
This prototype Perl script requires the following module:

`XML::Twig`

# Input
To work, this Perl prototype requires

A/ A corpus in FoLiA XML format. In FoLiA XML, each text unit, i.e. each paragraph, sentence and individual word token, is assigned a unique identifier. Each extracted paragraph will be identified by its unique FoLiA paragraph ID. 

Unfortunately, for reasons of copyright, we cannot here share the corpus used in this study.

B/ Five lists of expert selected terms to query the corpus paragraphs for and to serve to rank the paragraphs based on the collected hit statistics.

We provide the five lists used in this study, in the format actually used by HitPaRank, below.

# Usage Working mode 'A'

`$ perl /path/HitPaRank.V1.pl /path/QUINEV05FOLIASPACY folia.xml A /path/QUINE.ListY.FinalExpandedRevised.tildes.txt /path/QUINE.ListX.FinalExpandedRevised.tildes.txt /path/QUINE.ListU.FinalExpandedRevised.tildes.txt /path/QUINE.ListYbis.FinalExpandedRevised.tildes.txt /path/QUINE.ListZ.FinalExpandedRevised.tildes.txt /path/HITPARANK.QUINETWIG122`

The last parameter serves to provide the prefix for the three output files.

# Output Working mode 'A' (Read: 'All' or 'Main working mode')

Output is in tab-separated columns. A header to each output file identifies the column's contents.

The HitPaRank script in mode 3/ delivers three output files: 

A/ Extracted paragraphs. Output file extension: `*.Paragraphs.tsv`

B/ Condensed paragraph info. Output file extension: `*.RankCounts.tsv`

C/ Summary of corpus-wide statistics. Output file extension: `*.CorpusSummary.tsv`

The prefix for the output files needs to be specified at run-time.

# Statistics reported in the output
Based on the statistics regarding each of the list hits, we precede each output line - each line containing all the data gathered for one paragraph - with a 5 letter Y/N code. This code provides a quick overview of which lists provided hits and allows for quick and easy selection of those paragraphs that do or do not contain any of the search terms. 

Further, for each of the five lists an overview is provided of the number of hits per rank, followed by the uniqued list terms that provided the hits. In so far that query terms may actually reoccur within the lists as part of either compounds or ngrams, i.e. multi-word expressions, multiple hits produced for a single paragraph are uniqued and counted as single hits towards to final hit score. Likewise terms fully re-occurring in a single paragraph. 

Nevertheless the total hit score is also tallied and this score contrasted to the uniqued hit score allows us to also calculate a hit type-token ratio for each paragraph. This we also provide to the expert-annotators as a help towards deciding on the overall ranking within the retrieved paragraphs and to assign their relevance score to each paragraph retained for further annotation of `grade of relevance'.

# Actual output files for this study
The original HitPaRank mode 'A' output files underlying this study, provided here for possible verification or replication purposes only, are in this archive: [QUINETWIG112.20200629.tar.gz](https://github.com/martinreynaert/HitPaRank/files/7661857/QUINETWIG112.20200629.tar.gz).

The actual output of mode 'A' of the current version 1 of HitPaRank, which offers two extra columns of valuable data in file A/ : `*.Paragraphs.tsv`, is here: [HITPARANK.QUINETWIG122.20211212.tar.gz](https://github.com/martinreynaert/HitPaRank/files/7697259/HITPARANK.QUINETWIG122.20211212.tar.gz)

# Contents of Output List A/ : Extracted paragraphs
The contents of Output List A/ are 23 tab separated columns. On the basis of the headers to the columns we describe their individual contents.

The examples further discussed are based on the following example paragraph from the QUINE output. The actual tabs in the output have here been replaced by a space enclosed pipe symbol, i.e. ' | ' for reasons of clarity:

```20  |  YYYNN  |  P_013705  |  B_0134P_0018  |  QUINE-A-1981d-Grammar_Truth_and_Logic-V0_5.txt.p.18  |  U:3:1,Y:2:1Y:3:3,Ybis:3:2  |  channeling[1] grammar[1] logical[1] logician[1] mathematician[1] scientific[1] truth[2] -- --  |  146  |  7  |  4.79  |  8  |  87.50  |  U:3:1  |  channeling[1]  |  Y:2:1 Y:3:3  |  grammar[1] logical[1] logician[1] mathematician[1]  |  Ybis:3:2  |  scientific[1] truth[2]  |  n.a.  |  --  |  n.a.  |  --  |  LEM:for the latter-day logician , logical regimentation of grammar be standard procedure . -pron- have note the motivation of one such reform , and -pron- be characteristic of many . other of -pron- reform serve to resolve structural ambiguity ; other serve to economize on construction . -pron- interest in grammatical structure be oneside : -pron- be interested in how -pron- channel truth condition . if a grammatical reform make for a more copious channeling of truth condition and cause no complication in other quarter , -pron- be happy to adopt -pron- . -pron- adopt -pron- not as a reform to be impose on society , but as a technical by-language to expedite scientific inference . the shift be the same in principle as program a computer , and the same , for that matter , as the mathematician 's habitual recourse to plan notation .   |  TOK:For the latter-day logician , logical regimentation of grammar is standard procedure . We have noted the motivation of one such reform , and it is characteristic of many . Others of his reforms serve to resolve structural ambiguities ; others serve to economize on constructions . His interest in grammatical structure is onesided : he is interested in how it channels truth conditions . If a grammatical reform makes for a more copious channeling of truth conditions and causes no complications in other quarters , he is happy to adopt it . He adopts it not as a reform to be imposed on society , but as a technical by-language to expedite scientific inference . The shift is the same in principle as programming a computer , and the same , for that matter , as the mathematician 's habitual recourse to planned notations . ```

A block of data as the example above in fact constitutes a single line in the actual HitPaRank output file.

**The column information, per header**

We give the headers to the columns in bold. 

**9999** : The header to the first column is the rather arbitrarily large number: 9,999. This is to ensure that when the full output file is numerically and descendingly sorted on this column, the header will remain on top, the value being larger than any that is likely ever to have been calculated for any of the paragraphs, given any corpus.

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

This column is a later addition to HitPaRank, not available at the time of the study.

**Paragraph_Reference** : This is the actual reference to the paragraph in the whole corpus, specifying the full input file name supplemented by the sequence number of the paragraph within that file. 

Example: 'QUINE-A-1981d-Grammar_Truth_and_Logic-V0_5.txt.p.18'. First we have 'QUINE': the name for our corpus. Next: 'A': Willard Van Orman Quine was the author of this paragraph. The book was the fourth ('d') to be published by him in 1981. Follows the (possibly shortened or slightly modified) title of the work. 'V0_5' signifies this is version 0.5 of the QUINE corpus. The 'txt' signifies the original input file that was converted to FoLiA XML was a plain text file. Finally we get 'p.', i.e. paragraph, and its sequential number, here: '18'.

**CollectedHitRankSummary** : This is a collation of the information gathered about the hits on the 5 lists.

Example: 'U:3:1,Y:2:1Y:3:3,Ybis:3:2' (source: P_013705 or QUINE-A-1981d-Grammar_Truth_and_Logic-V0_5.txt.p.18): There was one hit with rank '3' in List U, one hit with rank '2' and 3 with rank '3' in List Y and 2 hits with rank '3' in List Ybis.

The grading score reported in the first column, i.e. under header '9999' is straightforwardly obtained by summing the results of multiplying the ranks with the frequencies observed for all the lists.

Example: So here we get: (3\*1) + (2\*1) + (3\*3) + (3\*2) = 20.

**CollectedHits** : This collates the hit terms from the five lists. The 'empty-field' label '--' signifies there were no hits in a particular list.

Example: 'channeling[1] grammar[1] logical[1] logician[1] mathematician[1] scientific[1] truth[2] -- --'. The numbers between square brackets give the number of times the term was found in the paragraph: only the term 'truth' occurred twice in this paragraph.

**TokensInParagraph** : a simple count of the number of tokens within the paragraph.

Example : The example paragraph has 8 running words of texts, i.e. 8 word tokens.

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

**Paragraph_(lemmatized)** : The actual paragraph in lemmatized form extracted from the FoLiA XML corpus file. All statistics reported in this file are derived from this lemmatized text layer in the FoLiA XML. For this study, the lemmatizer used was Spacy. For clear identification, the paragraph is preceded by the label: 'LEM:'.

**Paragraph_(tokenized)** : The actual paragraph in tokenized form extracted from the FoLiA XML corpus file. For this study, the lemmatizer used was UCTO. For clear identification, the paragraph is preceded by the label: 'TOK:'.

# Remark on Output Lists B/ and C/

We think the information given for List A/ together with the self-explanatory nature of presentation of the data in these Lists should largely suffice.

# Contents of Output List B/ : Condensed paragraph info
The contents of Output List A/ are 14 tab separated columns. These replicate the corresponding columns in file A/. This file is provided to afford an easier overview of the results.

# Contents of Output List C/ : Summary of corpus-wide statistics

This file provides a summary of the statistics of the corpus, the actual numbers of paragraphs retrieved on the basis of each list and of the numbers of hits per term of the five lists.

# Usage Working mode 'F'

`$ perl /path/HitPaRank.V1.pl /path/QUINEV05FOLIASPACY folia.xml F`

# Output Working mode 'F' (Read: 'Frequency Lists')

In this mode HitParank requires access to the FoLiA XML corpus only. 

It builds four ngram frequency lists, one each for word unigrams up to word fourgrams. Spaces in the multigrams are represented by underscores, i.e. '_'.

The prefix assigned to the output files is that of the last segment of the path where the corpus resides, i.e. the name of the directory the FoLiA XML files are in. The file names get the extension `.[1-4]gram.tsv`. These files are currently written to the same directory the script reads the FoLiA XML files from.

We implemented this mode as the scripts needs to build the ngrams for the texts anyway, for Mode 'A'. We do not recommend its use for larger FoLiA XML corpora. The QUINE corpus runs to about 2 million word tokens and building the ngram frequency lists on our hardware requires about 16 minutes. There are better solutions available, in particular 'FoLiA-stats'[^1].  

# Usage Working mode 'E'

`perl /path/HitPaRank.V1.pl /path/QUINEV05FOLIASPACY folia.xml E /path/QUINE.ListY.Ranked.Codes.txt /path/QUINE.ListX.ranked.txt /path/QUINE.ListU.ranked.txt /path/QUINE.ListYbis.ranked.txt /path/QUINE.ListZ.ranked.txt /path/QUINEV05FOLIASPACY/QUINEV05FOLIASPACY.1gram.tsv /path/QUINEV05FOLIASPACY/QUINEV05FOLIASPACY.2gram.tsv /path/QUINEV05FOLIASPACY/QUINEV05FOLIASPACY.3gram.tsv /path/QUINEV05FOLIASPACY/QUINEV05FOLIASPACY.4gram.tsv`

The output files will land in the same directory as the five input lists are read from.

Note: Although not used in this mode, the first parameter, i.e. the path to the corpus, nevertheless is required to be stated by the current script.

# Output Working mode 'E' (Read: 'Extend' or 'Expand' tentative expert term lists)

Producing the final term lists was in fact a three step process.

First, the experts produced lists of what they considered relevant terms for their research queries. These broke down into five categories, hence the five lists, finally. Four of these first version lists had wilcards, for terms that likely had multiple word forms in the QUINE corpus. In the case of the main list, ListY, wildcards have been replaced by simple codes, to refine and restrict retrieval of matching variants. 

Encoding scheme for list Y: An underscore followed by a capital letter 'A' for 'Match All', 'B' for 'Match only at the Beginning, 'E' for 'Match only at the End'. These are attached to the appropriate terms in the list. However, as it turned out along the way, this scheme did not deliver the expected results and the script was adapted to simply turn these codes into wildcards again.

Note: these initial lists are tab-separated: 'word tab rank', e.g. from ListU: 'mesmerism tab 3'. Also, spaces are not rendered as underscores, but are just spaces.

***The five initial lists, input for Mode 'E'***

List 1: [QUINE.ListY.Ranked.Codes.txt](https://github.com/martinreynaert/HitPaRank/files/7693261/QUINE.ListY.Ranked.Codes.txt)

List 2: [QUINE.ListX.ranked.txt](https://github.com/martinreynaert/HitPaRank/files/7693265/QUINE.ListX.ranked.txt)

List 3: [QUINE.ListU.ranked.txt](https://github.com/martinreynaert/HitPaRank/files/7693271/QUINE.ListU.ranked.txt)

List 4: [QUINE.ListYbis.ranked.txt](https://github.com/martinreynaert/HitPaRank/files/7693272/QUINE.ListYbis.ranked.txt)

List 5: [QUINE.ListZ.ranked.txt](https://github.com/martinreynaert/HitPaRank/files/7693276/QUINE.ListZ.ranked.txt)

Second, these five lists served as input for the 'E' mode of HitPaRank and produced the following five expanded lists, with extra annotations to appraise the experts of the outcome of the expansion step and to guide them in their final decision-taking over whether or not to retain the expanded terms in the lists. They were further provided with lists of likely (pseudo-)scientific they might have overlooked in building their first version lists or might not even be aware of Quine ever mentioned them in his writing. These were lists drawn from the corpus frequency lists for words ending e.g. in -olog*, -ics, -ism, -omy.

Note: these expanded lists are not tab-separated, a tilde, i.e. '~' replaces the tabs. Also, spaces are rendered as underscores. They also have a third column, repeating the matching input in case that has a wildcard. This is in order to show the experts on the basis of which pattern the particular expanded form was retrieved.

***The five expanded lists, input for for the experts***

List 1: [QUINE.ListY.Ranked.Codes.expanded.tildes.txt](https://github.com/martinreynaert/HitPaRank/files/7693282/QUINE.ListY.Ranked.Codes.expanded.tildes.txt)

List 2: [QUINE.ListX.ranked.expanded.tildes.txt](https://github.com/martinreynaert/HitPaRank/files/7693284/QUINE.ListX.ranked.expanded.tildes.txt)

List 3: [QUINE.ListU.ranked.expanded.tildes.txt](https://github.com/martinreynaert/HitPaRank/files/7693285/QUINE.ListU.ranked.expanded.tildes.txt)

List 4: [QUINE.ListYbis.ranked.expanded.tildes.txt](https://github.com/martinreynaert/HitPaRank/files/7693287/QUINE.ListYbis.ranked.expanded.tildes.txt)

List 5: [QUINE.ListZ.ranked.expanded.tildes.txt](https://github.com/martinreynaert/HitPaRank/files/7693290/QUINE.ListZ.ranked.expanded.tildes.txt)

Third, after their final decision-taking round, we finally ended up with the following five manually vetted and curated lists that served as input to Mode 'A' of HitPaRank. 

These lists have the manually assigned extension: `.FinalExpandedRevised.tildes.txt`.

Note: these expanded lists are also not tab-separated, a tilde, i.e. '~' replaces the tabs and spaces are again rendered as underscores.

***The five final lists, input for Mode 'A'***

List 1: [QUINE.ListY.FinalExpandedRevised.tildes.txt](https://github.com/martinreynaert/HitPaRank/files/7693294/QUINE.ListY.FinalExpandedRevised.tildes.txt)

List 2: [QUINE.ListX.FinalExpandedRevised.tildes.txt](https://github.com/martinreynaert/HitPaRank/files/7693296/QUINE.ListX.FinalExpandedRevised.tildes.txt)

List 3: [QUINE.ListU.FinalExpandedRevised.tildes.txt](https://github.com/martinreynaert/HitPaRank/files/7693299/QUINE.ListU.FinalExpandedRevised.tildes.txt)

List 4: [QUINE.ListYbis.FinalExpandedRevised.tildes.txt](https://github.com/martinreynaert/HitPaRank/files/7693303/QUINE.ListYbis.FinalExpandedRevised.tildes.txt)

List 5: [QUINE.ListZ.FinalExpandedRevised.tildes.txt](https://github.com/martinreynaert/HitPaRank/files/7693305/QUINE.ListZ.FinalExpandedRevised.tildes.txt)

These final lists are also available in spreadsheet format from the [Companion Github Repository](https://github.com/YOortwijn/QuiNE-ground-truth), where far more detailed information is also provided.

# Top 5 paragraphs retrieved

We list the top 5 best ranked actual paragraphs from the QUINE corpus to show the result of running HitPaRank. As before, the tabs in the output are here represented as space enclosed pipe sysmbols.

In fact, the last two of these would have been (possibly: highly) relevant for answering Research Question 1 in the paper.

***Command line used :*** `$ cat HITPARANK.QUINETWIG122.Paragraphs.tsv | sort -gr | head -n 8 | tail -n 5 | tr '\t' '@' | sed -e 's/@/ | /g' | sed -e 's/^/```/' | sed -e 's/$/```/g' | tr '\n' '@' | sed -e 's/@/@@/g' | tr '@' '\n'`

```55 | YYYYY | P_019224 | B_0187P_0803 | QUINE-A-1997-Hahn_Schilpp_Philosophy_Book_sub29_Morton_White_NORMATIVE_ETHICS_NORMATIVE_EPISTEMOLOGY_QUINE_HOLISM-V0_5.txt.p.8 | U:3:2,Y:2:1Y:3:4,Ybis:2:1Ybis:3:4,X:1:1X:2:3X:3:3,Z:2:1Z:3:1 | occult[1] parapsychological[1] engineering[2] mathematic[1] neurology[1] physics[1] psychology[2] finding[1] prediction[2] scientific[1] technology[2] truth[1] cognitive[1] epistemic[1] epistemological[1] epistemology[2] perceptual[1] source[1] thinking[1] naturalization[1] normative_epistemology[1] | 201 | 14 | 6.97 | 26 | 53.85 | U:3:2 | occult[1] parapsychological[1] | Y:2:1 Y:3:4 | engineering[2] mathematic[1] neurology[1] physics[1] psychology[2] | Ybis:2:1 Ybis:3:4 | finding[1] prediction[2] scientific[1] technology[2] truth[1] | X:1:1 X:2:3 X:3:3 | cognitive[1] epistemic[1] epistemological[1] epistemology[2] perceptual[1] source[1] thinking[1] | Z:2:1 Z:3:1 | naturalization[1] normative_epistemology[1] | LEM:a word now about the status , for -pron- , of epistemic value . naturalization of epistemology do not jettison the normative and settle for the indiscriminate description of ongoing procedure . for mc normative epistemology be a branch of engineering . -pron- be the technology of truth-seeking , or , in a more cautiously epistemological term , prediction . like any technology , -pron- make free use of whatever scientific finding may suit -pron- purpose . -pron- draw upon mathematic in compute standard deviation and probable error and in scout the gambler 's fallacy . -pron- draw upon experimental psychology in expose perceptual illusion , and upon cognitive psychology in scout wishful thinking . -pron- draw upon neurology and physics , in a general way , in discount testimony from occult or parapsychological source . there be no question here of ultimate value , as in moral ; -pron- be a matter of efficacy for an ulterior end , truth or prediction . the normative here , as elsewhere in engineering , become descriptive when the terminal parameter be express . -pron- could say the same of morality if -pron- could view -pron- as aim at reward in heaven .  | TOK:A word now about the status , for me , of epistemic values . Naturalization of epistemology does not jettison the normative and settle for the indiscriminate description of ongoing procedures . For mc normative epistemology is a branch of engineering . It is the technology of truth-seeking , or , in a more cautiously epistemological term , prediction . Like any technology , it makes free use of whatever scientific findings may suit its purpose . It draws upon mathematics in computing standard deviation and probable error and in scouting the gambler 's fallacy . It draws upon experimental psychology in exposing perceptual illusions , and upon cognitive psychology in scouting wishful thinking . It draws upon neurology and physics , in a general way , in discounting testimony from occult or parapsychological sources . There is no question here of ultimate value , as in morals ; it is a matter of efficacy for an ulterior end , truth or prediction . The normative here , as elsewhere in engineering , becomes descriptive when the terminal parameter is expressed . We could say the same of morality if we could view it as aimed at reward in heaven . ```

```53 | NYYYY | P_013582 | B_0131P_0548 | QUINE-A-1981-Quine_Theories_and_Things_ch23-V0_5.txt.p.3 | Y:2:1Y:3:9,Ybis:3:6,X:2:2,Z:2:1 | -- biologist[1] biology[1] cosmology[1] mathematician[1] philosopher[1] philosophical[1] philosophy[3] physicist[3] physics[1] psychologist[1] science[1] scientific[1] scientist[1] system[1] theoretical[1] theory[1] concept[2] conception[1] reality[1] | 206 | 17 | 8.25 | 24 | 70.83 | n.a. | -- | Y:2:1 Y:3:9 | biologist[1] biology[1] cosmology[1] mathematician[1] philosopher[1] philosophical[1] philosophy[3] physicist[3] physics[1] psychologist[1] | Ybis:3:6 | science[1] scientific[1] scientist[1] system[1] theoretical[1] theory[1] | X:2:2 | concept[2] conception[1] | Z:2:1 | reality[1] | LEM:aristotle be among other thing a pioneer physicist and biologist . plato be among other thing a physicist in a way , if cosmology be a theoretical wing of physics , descartes and leibniz be in part physicist . biology and physic be call philosophy in those day . -pron- be call natural philosophy until the nineteenth century . plato , descartes , and leibniz be also mathematician , and locke , berkeley , hume , and kant be in large part psychologist . all these luminary and other whom -pron- revere as great philosopher be scientist in search of an organized conception of reality . -pron- search do indeed go beyond the special science as -pron- now define -pron- ; there be also broad and more basic concept to untangle and clarify . but the struggle with these concept and the quest for a system on a grand scale be integral still to the overall scientific enterprise . the more general and speculative reach of theory be what -pron- look back on nowadays as distinctively philosophical . what be pursue under the name of philosophy today , moreover , have much these same concern when -pron- be at what -pron- deem -pron- technical good .  | TOK:Aristotle was among other things a pioneer physicist and biologist . Plato was among other things a physicist in a way , if cosmology is a theoretical wing of physics , Descartes and Leibniz were in part physicists . Biology and physics were called philosophy in those days . They were called natural philosophy until the nineteenth century . Plato , Descartes , and Leibniz were also mathematicians , and Locke , Berkeley , Hume , and Kant were in large part psychologists . All these luminaries and others whom we revere as great philosophers were scientists in search of an organized conception of reality . Their search did indeed go beyond the special sciences as we now define them ; there were also broader and more basic concepts to untangle and clarify . But the struggle with these concepts and the quest for a system on a grand scale were integral still to the overall scientific enterprise . The more general and speculative reaches of theory are what we look back on nowadays as distinctively philosophical . What is pursued under the name of philosophy today , moreover , has much these same concerns when it is at what I deem its technical best . ```

```52 | NYYYY | P_011854 | B_0102P_0008 | QUINE-A-1974a-Quine_Roots_of_Reference_sec01-V0_5.txt.p.8 | Y:2:1Y:3:1,Ybis:2:1Ybis:3:3,X:1:1X:2:2X:3:6,Z:2:2Z:3:3 | -- physical[1] psychologist[2] investigate[1] science[2] scientific[1] scientifically[1] acquisition[1] awareness[1] empirical[1] epistemological[1] epistemologist[3] epistemology[1] knowledge[1] recognize[3] sensory[3] liberated_epistemologist[1] old_epistemologist[1] old_epistemology[1] sense_datum[2] skeptical[1] | 158 | 11 | 6.96 | 29 | 37.93 | n.a. | -- | Y:2:1 Y:3:1 | physical[1] psychologist[2] | Ybis:2:1 Ybis:3:3 | investigate[1] science[2] scientific[1] scientifically[1] | X:1:1 X:2:2 X:3:6 | acquisition[1] awareness[1] empirical[1] epistemological[1] epistemologist[3] epistemology[1] knowledge[1] recognize[3] sensory[3] | Z:2:2 Z:3:3 | liberated_epistemologist[1] old_epistemologist[1] old_epistemology[1] sense_datum[2] skeptical[1] | LEM:once -pron- recognize this privilege , the epistemologist can scorn the gestalt psychologist 's stricture against sensory atomism . -pron- can appeal to physical receptor of sensory stimulation and say that for -pron- what be distinctive about sense datum be mere proximity to these receptor , without regard to awareness . better still , -pron- can drop the talk of sense datum and talk rather of sensory stimulation . -pron- liberated epistemologist end up as an empirical psychologist , scientifically investigate man 's acquisition of science . a far cry , this , from old epistemology . yet -pron- be no gratuitous change of subject matter , but an enlighten persistence rather in the original epistemological problem . -pron- be enlighten in recognize that the skeptical challenge spring from science -pron- , and that in cope with -pron- -pron- be free to use scientific knowledge . the old epistemologist fail to recognize the strength of -pron- position .  | TOK:Once he recognizes this privilege , the epistemologist can scorn the Gestalt psychologist 's strictures against sensory atomism . He can appeal to physical receptors of sensory stimulation and say that for him what is distinctive about sense data is mere proximity to these receptors , without regard to awareness . Better still , he can drop the talk of sense data and talk rather of sensory stimulation . Our liberated epistemologist ends up as an empirical psychologist , scientifically investigating man 's acquisition of science . A far cry , this , from old epistemology . Yet it is no gratuitous change of subject matter , but an enlightened persistence rather in the original epistemological problem . It is enlightened in recognizing that the skeptical challenge springs from science itself , and that in coping with it we are free to use scientific knowledge . The old epistemologist failed to recognize the strength of his position . ```

```51 | NYYYY | P_017533 | B_0171P_0020 | QUINE-A-1992d-On_Philosopher_s_Concern_with_Language-V0_5.txt.p.20 | Y:2:1,Ybis:2:1Ybis:3:5,X:2:2X:3:6,Z:2:2Z:3:2 | -- physical[2] finding[1] method[1] observation[1] prediction[1] science[3] scientific[6] scientific_method[1] scientific_theory[1] theory[2] empiricist[1] epistemologist[1] epistemology[2] evidence[1] foundation[1] information[1] information_about[1] information_about_the_world[1] input[1] sensory[2] sensory_evidence[1] naturalized[2] naturalized_epistemology[2] old_epistemologist[1] phenomenalistic_foundation[1] physical_world[1] world[3] | 184 | 11 | 5.98 | 42 | 26.19 | n.a. | -- | Y:2:1 | physical[2] | Ybis:2:1 Ybis:3:5 | finding[1] method[1] observation[1] prediction[1] science[3] scientific[6] scientific_method[1] scientific_theory[1] theory[2] | X:2:2 X:3:6 | empiricist[1] epistemologist[1] epistemology[2] evidence[1] foundation[1] information[1] information_about[1] information_about_the_world[1] input[1] sensory[2] sensory_evidence[1] | Z:2:2 Z:3:2 | naturalized[2] naturalized_epistemology[2] old_epistemologist[1] phenomenalistic_foundation[1] physical_world[1] world[3] | LEM:something analogous to the old epistemologist ' dream of a phenomenalistic foundation for science can still be entertain , however , with free access to scientific finding . after all , the empiricist ' insistence on exclusively sensory evidence be -pron- scientific ; -pron- be a fact of nature that -pron- ongoing information about the world around -pron- be limited to impact on -pron- sensory surface , plus a bit of kinesthetic input . how , -pron- may ask , do -pron- manage on such meagre datum to spin out -pron- elaborate scientific theory of the world , and indeed a theory that lead persistently to successful prediction of observation ? this be -pron- a question within science , a scientific question about science as an activity of physical being in the physical world . -pron- be a question of naturalized epistemology , as -pron- may say . naturalized epistemology be not calculate to yield a proof of the validity of scientific method , on pain of circularity , but -pron- be calculate to improve -pron- understanding and control of the scientific edifice .  | TOK:Something analogous to the old epistemologists ' dream of a phenomenalistic foundation for science can still be entertained , however , with free access to scientific findings . After all , the empiricists ' insistence on exclusively sensory evidence is itself scientific ; it is a fact of nature that our ongoing information about the world around us is limited to impacts on our sensory surfaces , plus a bit of kinesthetic input . How , we may ask , do we manage on such meagre data to spin out our elaborate scientific theory of the world , and indeed a theory that leads persistently to successful prediction of observations ? This is itself a question within science , a scientific question about science as an activity of physical beings in the physical world . It is a question of naturalized epistemology , as we may say . Naturalized epistemology is not calculated to yield a proof of the validity of scientific method , on pain of circularity , but it is calculated to improve our understanding and control of the scientific edifice . ```

```50 | YYYYY | P_020518 | B_0199P_0354 | QUINE-A-2004a-Quintessence_sec18-V0_5.txt.p.17 | U:3:1,Y:3:2,Ybis:2:1Ybis:3:6,X:2:2X:3:3,Z:2:1Z:3:2 | supra-scientific[1] antimetaphysician[1] philosophy[2] inquiry[1] method[2] natural_science[1] observation[1] science[3] scientist[1] system[1] theoretical[1] corrigible[1] fallible[1] justification[1] mind[1] source[2] first_philosophy[1] naturalism[4] reality[1] | 161 | 13 | 8.07 | 27 | 48.15 | U:3:1 | supra-scientific[1] | Y:3:2 | antimetaphysician[1] philosophy[2] | Ybis:2:1 Ybis:3:6 | inquiry[1] method[2] natural_science[1] observation[1] science[3] scientist[1] system[1] theoretical[1] | X:2:2 X:3:3 | corrigible[1] fallible[1] justification[1] mind[1] source[2] | Z:2:1 Z:3:2 | first_philosophy[1] naturalism[4] reality[1] | LEM:the fifth move , finally , bring naturalism : abandonment of the goal of a first philosophy . -pron- see natural science as an inquiry into reality , fallible and corrigible but not answerable to any supra-scientific tribunal , and not in need of any justification beyond observation and the hvpotherico-deductive method . naturalism have two source , both negative . one of -pron- be despair of be able to define theoretical term generally in term of phenomenon , even by contextual definition . a holistic or system - center attitude should suffice to induce this despair . the other negative source of naturalism be unregenerate realism , the robust state of mind of the natural scientist who have never feel any qualm beyond the negotiable uncertainty internal to science . naturalism have a representative already in 1830 in the antimetaphysician auguste comte , who declare that " positive philosophy " do not differ in method from the special science .  | TOK:The fifth move , finally , brings naturalism : abandonment of the goal of a first philosophy . It sees natural science as an inquiry into reality , fallible and corrigible but not answerable to any supra-scientific tribunal , and not in need of any justification beyond observation and the hvpotherico-deductive method . Naturalism has two sources , both negative . One of them is despair of being able to define theoretical terms generally in terms of phenomena , even by contextual definition . A holistic or system - centered attitude should suffice to induce this despair . The other negative source of naturalism is unregenerate realism , the robust state of mind of the natural scientist who has never felt any qualms beyond the negotiable uncertainties internal to science . Naturalism had a representative already in 1830 in the antimetaphysician Auguste Comte , who declared that “ positive philosophy " does not differ in method from the special sciences . ```

The last paragraph here unfortunately still displays a double OCR-error: 'hvpotherico-deductive' for 'hypothetico-deductive'. Towards version 0.6 we contemplate using our OCR-postcorrection system [TICCL](https://github.com/LanguageMachines/ticcltools) to automatically correct this kind of residual digitization error.

The observant reader will notice that the command line used in fact discards the top three lines of the file sorted on the first column, i.e. the grading scores. The first is the header, the next two spurious artefacts of a mishap in the conversion of the QUINE corpus from plain text format to FoLiA XML: footnotes within the text were all shifted to the end of each text. Each footnote should at least have been turned into a separate paragraph. Instead they were all collated into a single one and deliver top grading scores. This too is to be remedied in QUINE corpus version 0.6.

MRE - 20211212

[^1]:FoLiA-stats is one of the C++ tools available in the package [foliautils](https://github.com/LanguageMachines/foliautils). It is a production-grade, fast and well-developed word ngram frequency builder.
