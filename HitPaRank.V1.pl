# HitPaRank.V1.pl
# Development name: QUINE.TWIG.122.pl
# by Martin Reynaert
# ILLC - Universiteit van Amsterdam and CS&AI - Tilburg University - The Netherlands
# 2021 - Licensed under GPLv3

## Copyright Martin Reynaert 2020, 2021
## MRE 2021-12-12
## Written in NWO VICI e-Ideas project by Arianna Betti, ILLC, UvA

## Usage: 
## Mode A: $ perl /path/HitPaRank.V1.pl /path/QUINEV05FOLIASPACY folia.xml A /path/QUINE.ListY.FinalExpandedRevised.tildes.txt /path/QUINE.ListX.FinalExpandedRevised.tildes.txt /path/QUINE.ListU.FinalExpandedRevised.tildes.txt /path/QUINE.ListYbis.FinalExpandedRevised.tildes.txt /path/QUINE.ListZ.FinalExpandedRevised.tildes.txt /path/HITPARANK.QUINETWIG122
## Mode E: perl /path/HitPaRank.V1.pl /path/QUINEV05FOLIASPACY folia.xml E /path/QUINE.ListY.Ranked.Codes.txt /path/QUINE.ListX.ranked.txt /path/QUINE.ListU.ranked.txt /path/QUINE.ListYbis.ranked.txt /path/QUINE.ListZ.ranked.txt /path/QUINEV05FOLIASPACY/QUINEV05FOLIASPACY.1gram.tsv /path/QUINEV05FOLIASPACY/QUINEV05FOLIASPACY.2gram.tsv /path/QUINEV05FOLIASPACY/QUINEV05FOLIASPACY.3gram.tsv /path/QUINEV05FOLIASPACY/QUINEV05FOLIASPACY.4gram.tsv
## Mode F: $ perl /path/HitPaRank.V1.pl /path/QUINEV05FOLIASPACY folia.xml F

## Full description on GitHub: https://github.com/martinreynaert/HitPaRank/

use utf8;

##We set the binmode to UTF-8 for STDOUT and STDERR--BEGIN
binmode(STDOUT, ":utf8"); # if ($mode =~ /D/);
binmode(STDERR, ":utf8"); # if ($mode =~ /D/);
##We set the binmode to UTF-8 for STDOUT and STDERR--END

##Specifies the input directory
$dir = $ARGV[0];
##Extension for the files to be processed
$ext = $ARGV[1];

##Specifies the working mode, either 'A', 'E' or 'F'.
$mode = $ARGV[2];

##Specifies List Y
if (defined ($ARGV[3])){
$listY = $ARGV[3];
}
##Specifies List X
if (defined ($ARGV[4])){
$listX = $ARGV[4];
}
##Specifies List U
if (defined ($ARGV[5])){
$listU = $ARGV[5];
}
##Specifies List W
if (defined ($ARGV[6])){
$listW = $ARGV[6];
}
##Specifies List Z
if (defined ($ARGV[7])){
$listZ = $ARGV[7];
}

if ($mode =~ /A/){
  $output = $ARGV[8]; ##Should be a generic filename, with path
  $outputA = $output . '.Paragraphs.tsv';
  $outputB = $output . '.RankCounts.tsv';
  $outputC = $output . '.CorpusSummary.tsv';  
	   open (outA, '>', $outputA) || die "couldn't open LIST outA: $outputA: $!\n";
           binmode(outA, ":utf8");
	   open (outB, '>', $outputB) || die "couldn't open LIST outB: $outputB: $!\n";
           binmode(outB, ":utf8");
  	   open (outC, '>', $outputC) || die "couldn't open LIST outC: $outputC: $!\n";
           binmode(outC, ":utf8");
}

if ($mode =~ /E/){
##NEW-BEGIN

  $corpusUNI = $ARGV[8];
  $corpusBI = $ARGV[9];
  $corpusTRI = $ARGV[10];
  $corpusQUAD = $ARGV[11];

##Within mode E we just open these ngramfrqfiles and read them into a hash, to have them handy--BEGIN
open (Ucorpus, $corpusUNI) || die "couldn't open LIST corpusUNI: $corpusUNI: $!\n";
         while ($corpusuni = <Ucorpus>) {
	   chomp $corpusuni;
	   @CORPUSUNI = split '\t', $corpusuni;
	   $CORPUSuni{@CORPUSUNI[0]} = @CORPUSUNI[1];
	 }
open (Bcorpus, $corpusBI) || die "couldn't open LIST corpusBI: $corpusBI: $!\n";
         while ($corpusbi = <Bcorpus>) {
	   chomp $corpusbi;
	   @CORPUSBI = split '\t', $corpusbi;
	   $CORPUSbi{@CORPUSBI[0]} = @CORPUSBI[1];
	 }
open (Tcorpus, $corpusTRI) || die "couldn't open LIST corpusTRI: $corpusTRI: $!\n";
         while ($corpustri = <Tcorpus>) {
	   chomp $corpustri;
	   @CORPUSTRI = split '\t', $corpustri;
	   $CORPUStri{@CORPUSTRI[0]} = @CORPUSTRI[1];
	 }
open (Qcorpus, $corpusQUAD) || die "couldn't open LIST corpusQUAD: $corpusQUAD: $!\n";
         while ($corpusquad = <Qcorpus>) {
	   chomp $corpusquad;
	   @CORPUSQUAD = split '\t', $corpusquad;
	   $CORPUSquad{@CORPUSQUAD[0]} = @CORPUSQUAD[1];
	 }
##Within mode E we just open these ngramfrqfiles and read them into a hash, to have them handy--END

##NEWY-Begin
if (defined ($ARGV[3])){
open (Y, $listY) || die "couldn't open LIST Y: $listY: $!\n";
binmode(Y, ":utf8");
while ($itemY = <Y>) {
	   chomp $itemY;

	   ##Create filename outputfile and open file--B

	   $outlistY = $listY;
	   $outlistY =~ s/txt/expanded\.tildes\.txt/;
	   open (Yout, '>>', $outlistY) || die "couldn't open LIST Yout: $outlistY: $!\n";
           binmode(Yout, ":utf8");
	   ##Create filename outpufile and open file--E
	     
	   if ($itemY !~ /\#/){
	     #$itemY = lc($itemY);
##HERE account for the new matching codes '_A', '_B' and '_E'--Begin
	     if ($itemY =~ /_A/){
	       $itemY =~ s/_A/\*/;
	     }
             elsif ($itemY =~ /_B/){
               $itemY =~ s/_B/\*/;
	     }	     
	     elsif ($itemY =~ /_E/){
	       $itemY =~ s/_E/\*/;
	     }
	     else {}
##HERE account for the new matching codes '_A', '_B' and '_E'--End	     
           $itemY = lc($itemY);
	   $itemY =~ s/ /_/g;
	   @ITEMY = split /\t/, $itemY;
	   @ITEMYGRAM = split /_/,  @ITEMY[0];
	   $ITEMY = @ITEMYGRAM; #Get ngramcount item
	   $itemy = @ITEMY[0];
	   $itemyorig = $itemy;
	   $itemyrank = @ITEMY[1];
           if ($itemy =~ /\*/){
	     #Have an item that needs expanding. Select the appropriate ngram frequency hash. Extract the matching lines and write them to an array.
		   $itemy =~ s/\*//g;
         	     if ($ITEMY == 1 ){
			   foreach $uniG (sort keys %CORPUSuni){
			     @uniG = split /\t/, $uniG;
			     @uniG[0] =~ s/[\\\|\(\)\[\{\^\*\+\?\.]/@/g;
			     $frquniG = $CORPUSuni{@uniG[0]};
	       if ($uniG[0] =~ /$itemy/){
                 push @Yexp, @uniG[0] . '~' . $itemyrank . '~' . $itemyorig;
                 print Yout "@uniG[0]~$itemyrank~$itemyorig~$frquniG\n";
	       }
	       }
	     }
	     else {
             @Yunigrams = split /_/, $itemy;
	     if ($ITEMY == 2 ){
	       	   #print STDOUT "ITEMY5: $itemY > @ITEMY >> $ITEMY >>> $itemy\n";
		   foreach $tobiG (sort keys %CORPUSbi){
		     @biG = split /\t/, $tobiG;
		     $biG = @biG[0];
		     $frqbiG = $CORPUSbi{@biG[0]};
	  	     $biG =~ s/[\\\|\(\)\[\{\^\*\+\?\.]/@/g;
		     if (($biG =~ @Yunigrams[0]) and ($biG =~ @Yunigrams[1])){
		       push @Yexp, $biG . '~' . $itemyrank . '~' . $itemyorig;
		       print Yout "@biG[0]~$itemyrank~$itemyorig~$frqbiG\n";
		 }
	       }
	     }
	     elsif ($ITEMY == 3 ){
               foreach $totriG (sort keys %CORPUStri){
		 @triG = split /\t/, $totriG;
		 $triG = @triG[0];
		 $frqtriG = $CORPUStri{@triG[0]};
		 $triG =~ s/[\\\|\(\)\[\{\^\*\+\?\.]/@/g;
		  if (($triG =~ @Yunigrams[0]) and ($triG =~ @Yunigrams[1]) and ($triG =~ @Yunigrams[2])){
		    push @Yexp, $triG . '~' . $itemyrank . '~' . $itemyorig;
		    print Yout "@triG[0]~$itemyrank~$itemyorig~$frqtriG\n";
		 }
	       }
	     }
	     elsif ($ITEMY == 4 ){
               foreach $toquadG (sort keys %CORPUSquad){
		 @quadG = split /\t/, $toquadG;
		 $quadG = @quadG[0];
		 $frqquadG = $CORPUSquad{@quadG[0]};
		 $quadG =~ s/[\\\|\(\)\[\{\^\*\+\?\.]/@/g;
		 if (($quadG =~ @Yunigrams[0]) and ($quadG =~ @Yunigrams[1]) and ($quadG =~ @Yunigrams[2]) and ($quadG =~ @Yunigrams[3])){
		   push @Yexp, $quadG . '~' . $itemyrank . '~' . $itemyorig;
		   print Yout "@quadG[0]~$itemyrank~$itemyorig~$frqquadG\n";
		 }
	       }
	     }
             else {
             # might print : 'should not happen!'
             }
	   }
		 }
	   else {
	     $itemY =~ s/\t/~/;
	     ##splitten en frq ophalen en printen. Moet ook per ngram frqlijst!! Eerst tellen welke lijst. Iets duidelijks printen indien niet aanwezig.
	   @ITEMY = split /~/, $itemY;
	   @ITEMYGRAM = split /_/,  @ITEMY[0];
	   $ITEMY = @ITEMYGRAM; #Get ngramcount item
	   $itemy = @ITEMY[0];
	   $itemyorig = $itemy;
	   $itemyrank = @ITEMY[1];
	     ##FRQ ophalen!!
	     if ($ITEMY == 1 ){
             $frqitemy = $CORPUSuni{$itemy};
	     }
	     elsif ($ITEMY == 2 ){
             $frqitemy = $CORPUSbi{$itemy};
	     }
             elsif ($ITEMY == 3 ){
             $frqitemy = $CORPUStri{$itemy};
	     }
	     elsif ($ITEMY == 4 ){
             $frqitemy = $CORPUSquad{$itemy};
	     }

	     if (!defined ($frqitemy)){
	     $frqitemy = 'NA';
	     }
           print Yout "$itemY~NoExpansion~$frqitemy\n";
           $frqitemy = ();
	   }
           @ITEMY = undef;
	 }
	 }
##NEWY-End

foreach $lookY (sort keys %LISTY){
  print STDERR "LISTYRANKED: $lookY RANK: $LISTY{$lookY}\n";
}
}

if (defined ($ARGV[4])){
open (X, $listX) || die "couldn't open LIST X: $listX: $!\n";
binmode(X, ":utf8");
while ($itemX = <X>) {
	   chomp $itemX;

	   ##Create filename outpufile and open file--Begin
	   $outlistX = $listX;
	   $outlistX =~ s/txt/expanded\.tildes\.txt/;
	   open (Xout, '>>', $outlistX) || die "couldn't open LIST Xout: $outlistX: $!\n";
           binmode(Xout, ":utf8");
	   ##Create filename outpufile and open file--End
	     
	   if ($itemX !~ /\#/){
	   $itemX = lc($itemX);  
	   $itemX =~ s/ /_/g;
	   @ITEMX = split /\t/, $itemX;
	   @ITEMXGRAM = split /_/,  @ITEMX[0];
	   $ITEMX = @ITEMXGRAM; #Get ngramcount item
	   $itemx = @ITEMX[0];
	   $itemxorig = $itemx;
	   $itemxrank = @ITEMX[1];

           if ($itemx =~ /\*/){
	     #Have an item that needs expanding. Select the appropriate ngram frequency hash. Extract the matching lines and write them to an array.
		   $itemx =~ s/\*//g;
	     if ($ITEMX == 1 ){
			   foreach $uniG (sort keys %CORPUSuni){
			     @uniG = split /\t/, $uniG;
	       @uniG[0] =~ s/[\\\|\(\)\[\{\^\*\+\?\.]/@/g;
	       if ($uniG[0] =~ /$itemx/){
                 push @Xexp, @uniG[0] . '~' . $itemxrank . '~' . $itemxorig;
                 print Xout "@uniG[0]~$itemxrank~$itemxorig\n";
	       }
	       }
	     }
	     else {
             @Xunigrams = split /_/, $itemx;
	     if ($ITEMX == 2 ){
		   foreach $tobiG (sort keys %CORPUSbi){
		     @biG = split /\t/, $tobiG;
		     $biG = @biG[0];
		     $biG =~ s/[\\\|\(\)\[\{\^\*\+\?\.]/@/g;
		     if (($biG =~ @Xunigrams[0]) and ($biG =~ @Xunigrams[1])){
		       push @Xexp, $biG . '~' . $itemxrank . '~' . $itemxorig;
		       print Xout "@biG[0]~$itemxrank~$itemxorig\n";
		 }
	       }
	     }
	     elsif ($ITEMX == 3 ){
               foreach $totriG (sort keys %CORPUStri){
		 @triG = split /\t/, $totriG;
		 $triG = @triG[0];
		 $triG =~ s/[\\\|\(\)\[\{\^\*\+\?\.]/@/g;
		  if (($triG =~ @Xunigrams[0]) and ($triG =~ @Xunigrams[1]) and ($triG =~ @Xunigrams[2])){
		    push @Xexp, $triG . '~' . $itemxrank . '~' . $itemxorig;
		    print Xout "@triG[0]~$itemxrank~$itemxorig\n";
		 }
	       }
	     }
	     elsif ($ITEMX == 4 ){
               foreach $toquadG (sort keys %CORPUSquad){
		 @quadG = split /\t/, $toquadG;
		 $quadG = @quadG[0];
		 $quadG =~ s/[\\\|\(\)\[\{\^\*\+\?\.]/@/g;
		 if (($quadG =~ @Xunigrams[0]) and ($quadG =~ @Xunigrams[1]) and ($quadG =~ @Xunigrams[2]) and ($quadG =~ @Xunigrams[3])){
		   push @Xexp, $quadG . '~' . $itemxrank . '~' . $itemxorig;
		   print Xout "@quadG[0]~$itemxrank~$itemxorig\n";
		 }
	       }
	     }
             else {
             # Might print : 'should not happen!'
             }
	   }
		 }
	   else {
	   $itemX =~ s/\t/~/;  
           print Xout "$itemX\n";
	   }
           @ITEMX = undef;
	 }
	 }
}

##NEW-U-B
if (defined ($ARGV[5])){
open (U, $listU) || die "couldn't open LIST U: $listU: $!\n";
binmode(U, ":utf8");
while ($itemU = <U>) {
	   chomp $itemU;

	   ##Create filename outpufile and open file--B
	   $outlistU = $listU;
	   $outlistU =~ s/txt/expanded\.tildes\.txt/;
	   open (Uout, '>>', $outlistU) || die "couldn't open LIST Uout: $outlistU: $!\n";
           binmode(Uout, ":utf8");
	   ##Create filename outpufile and open file--E
	     
	   if ($itemU !~ /\#/){
	   $itemU = lc($itemU);  
	   $itemU =~ s/ /_/g;
	   @ITEMU = split /\t/, $itemU;
	   @ITEMUGRAM = split /_/,  @ITEMU[0];
	   $ITEMU = @ITEMUGRAM; #Get ngramcount item
	   $itemu = @ITEMU[0];
	   $itemuorig = $itemu;
	   $itemurank = @ITEMU[1];
           if ($itemu =~ /\*/){
	     #Have an item that needs expanding. Select the appropriate ngram frequency hash. Extract the matching lines and write them to an array.
		   $itemu =~ s/\*//g;
	     if ($ITEMU == 1 ){
			   foreach $uniG (sort keys %CORPUSuni){
			     @uniG = split /\t/, $uniG;
	       @uniG[0] =~ s/[\\\|\(\)\[\{\^\*\+\?\.]/@/g;
	       if ($uniG[0] =~ /$itemu/){
                 push @Uexp, @uniG[0] . '~' . $itemurank . '~' . $itemuorig;
                 print Uout "@uniG[0]~$itemurank~$itemuorig\n";
	       }
	       }
	     }
	     else {
             @Uunigrams = split /_/, $itemu;
	     if ($ITEMU == 2 ){
		   foreach $tobiG (sort keys %CORPUSbi){
		     @biG = split /\t/, $tobiG;
		     $biG = @biG[0];
       		     $biG =~ s/[\\\|\(\)\[\{\^\*\+\?\.]/@/g;
		     if (($biG =~ @Uunigrams[0]) and ($biG =~ @Uunigrams[1])){
		       push @Uexp, $biG . '~' . $itemurank . '~' . $itemuorig;
		       print Uout "@biG[0]~$itemurank~$itemuorig\n";
		 }
	       }
	     }
	     elsif ($ITEMU == 3 ){
               foreach $totriG (sort keys %CORPUStri){
		 @triG = split /\t/, $totriG;
		 $triG = @triG[0];
		 $triG =~ s/[\\\|\(\)\[\{\^\*\+\?\.]/@/g;
		  if (($triG =~ @Uunigrams[0]) and ($triG =~ @Uunigrams[1]) and ($triG =~ @Uunigrams[2])){
		    push @Uexp, $triG . '~' . $itemurank . '~' . $itemuorig;
		    print Uout "@triG[0]~$itemurank~$itemuorig\n";
		 }
	       }
	     }
	     elsif ($ITEMU == 4 ){
               foreach $toquadG (sort keys %CORPUSquad){
		 @quadG = split /\t/, $toquadG;
		 $quadG = @quadG[0];
		 $quadG =~ s/[\\\|\(\)\[\{\^\*\+\?\.]/@/g;
		 if (($quadG =~ @Uunigrams[0]) and ($quadG =~ @Uunigrams[1]) and ($quadG =~ @Uunigrams[2]) and ($quadG =~ @Uunigrams[3])){
		   push @Uexp, $quadG . '~' . $itemurank . '~' . $itemuorig;
		   print Uout "@quadG[0]~$itemurank~$itemuorig\n";
		 }
	       }
	     }
             else {
             # Might print: 'should not happen!'
             }
	   }
		 }
	   else {
	   $itemU =~ s/\t/~/;  
           print Uout "$itemU\n";
	   }
           @ITEMU = undef;
	 }
	 }
}
  ##NEW-U-E
  ##NEW-W-B
if (defined ($ARGV[6])){
open (W, $listW) || die "couldn't open LIST W: $listW: $!\n";
binmode(W, ":utf8");
while ($itemW = <W>) {
	   chomp $itemW;

	   ##Create filename outpufile and open file--B
	   $outlistW = $listW;
	   $outlistW =~ s/txt/expanded\.tildes\.txt/;
	   open (Wout, '>>', $outlistW) || die "couldn't open LIST Wout: $outlistW: $!\n";
           binmode(Wout, ":utf8");
	   ##Create filename outpufile and open file--E
	     
	   if ($itemW !~ /\#/){
	   $itemW = lc($itemW);  
	   $itemW =~ s/ /_/g;
	   @ITEMW = split /\t/, $itemW;
	   @ITEMWGRAM = split /_/,  @ITEMW[0];
	   $ITEMW = @ITEMWGRAM; #Get ngramcount item
	   $itemw = @ITEMW[0];
	   $itemworig = $itemw;
	   $itemwrank = @ITEMW[1];
           if ($itemw =~ /\*/){
	     #Have an item that needs expanding. Select the appropriate ngram frequency hash. Extract the matching lines and write them to an array.
		   $itemw =~ s/\*//g;
	     if ($ITEMW == 1 ){
			   foreach $uniG (sort keys %CORPUSuni){
			     @uniG = split /\t/, $uniG;
	       @uniG[0] =~ s/[\\\|\(\)\[\{\^\*\+\?\.]/@/g;
	       if ($uniG[0] =~ /$itemw/){
                 push @Wexp, @uniG[0] . '~' . $itemwrank . '~' . $itemworig;
                 print Wout "@uniG[0]~$itemwrank~$itemworig\n";
	       }
	       }
	     }
	     else {
             @Wunigrams = split /_/, $itemw;
	     if ($ITEMW == 2 ){
		   foreach $tobiG (sort keys %CORPUSbi){
		     @biG = split /\t/, $tobiG;
		     $biG = @biG[0];
		     $biG =~ s/[\\\|\(\)\[\{\^\*\+\?\.]/@/g;
		     if (($biG =~ @Wunigrams[0]) and ($biG =~ @Wunigrams[1])){
		       push @Wexp, $biG . '~' . $itemwrank . '~' . $itemworig;
		       print Wout "@biG[0]~$itemwrank~$itemworig\n";
		 }
	       }
	     }
	     elsif ($ITEMW == 3 ){
               foreach $totriG (sort keys %CORPUStri){
		 @triG = split /\t/, $totriG;
		 $triG = @triG[0];
		 $triG =~ s/[\\\|\(\)\[\{\^\*\+\?\.]/@/g;
		  if (($triG =~ @Wunigrams[0]) and ($triG =~ @Wunigrams[1]) and ($triG =~ @Wunigrams[2])){
		    push @Wexp, $triG . '~' . $itemwrank . '~' . $itemworig;
		    print Wout "@triG[0]~$itemwrank~$itemworig\n";
		 }
	       }
	     }
	     elsif ($ITEMW == 4 ){
               foreach $toquadG (sort keys %CORPUSquad){
		 @quadG = split /\t/, $toquadG;
		 $quadG = @quadG[0];
		 $quadG =~ s/[\\\|\(\)\[\{\^\*\+\?\.]/@/g;
		 if (($quadG =~ @Wunigrams[0]) and ($quadG =~ @Wunigrams[1]) and ($quadG =~ @Wunigrams[2]) and ($quadG =~ @Wunigrams[3])){
		   push @Wexp, $quadG . '~' . $itemwrank . '~' . $itemworig;
		   print Wout "@quadG[0]~$itemwrank~$itemworig\n";
		 }
	       }
	     }
             else {
             # Might print: 'should not happen!'
             }
	   }
		 }
	   else {
	   $itemW =~ s/\t/~/;  
           print Wout "$itemW\n";
	   }
           @ITEMW = undef;
	 }
	 }
}
##NEW-W-E
##NEW-B
if (defined ($ARGV[7])){
open (Z, $listZ) || die "couldn't open LIST Z: $listZ: $!\n";
binmode(Z, ":utf8");
while ($itemZ = <Z>) {
	   chomp $itemZ;

	   ##Create filename outpufile and open file--B
	   $outlistZ = $listZ;
	   $outlistZ =~ s/txt/expanded\.tildes\.txt/;
	   open (Zout, '>>', $outlistZ) || die "couldn't open LIST Zout: $outlistZ: $!\n";
           binmode(Zout, ":utf8");
	   ##Create filename outpufile and open file--E
	     
	   if ($itemZ !~ /\#/){
	   $itemZ = lc($itemZ);  
	   $itemZ =~ s/ /_/g;
	   @ITEMZ = split /\t/, $itemZ;
	   @ITEMZGRAM = split /_/,  @ITEMZ[0];
	   $ITEMZ = @ITEMZGRAM; #Get ngramcount item
	   $itemz = @ITEMZ[0];
	   $itemzorig = $itemz;
	   $itemzrank = @ITEMZ[1];
           if ($itemz =~ /\*/){
	     #Have an item that needs expanding. Select the appropriate ngram frequency hash. Extract the matching lines and write them to an array.
		   $itemz =~ s/\*//g;
	     if ($ITEMZ == 1 ){
			   foreach $uniG (sort keys %CORPUSuni){
			     @uniG = split /\t/, $uniG;
	       @uniG[0] =~ s/[\\\|\(\)\[\{\^\*\+\?\.]/@/g;
	       if ($uniG[0] =~ /$itemz/){
                 push @Zexp, @uniG[0] . '~' . $itemzrank . '~' . $itemzorig;
                 print Zout "@uniG[0]~$itemzrank~$itemzorig\n";
	       }
	       }
	     }
	     else {
             @Zunigrams = split /_/, $itemz;
	     if ($ITEMZ == 2 ){
		   foreach $tobiG (sort keys %CORPUSbi){
		     @biG = split /\t/, $tobiG;
		     $biG = @biG[0];
		     $biG =~ s/[\\\|\(\)\[\{\^\*\+\?\.]/@/g;
		     if (($biG =~ @Zunigrams[0]) and ($biG =~ @Zunigrams[1])){
		       push @Zexp, $biG . '~' . $itemzrank . '~' . $itemzorig;
		       print Zout "@biG[0]~$itemzrank~$itemzorig\n";
		 }
	       }
	     }
	     elsif ($ITEMZ == 3 ){
               foreach $totriG (sort keys %CORPUStri){
		 @triG = split /\t/, $totriG;
		 $triG = @triG[0];
		 $triG =~ s/[\\\|\(\)\[\{\^\*\+\?\.]/@/g;
		  if (($triG =~ @Zunigrams[0]) and ($triG =~ @Zunigrams[1]) and ($triG =~ @Zunigrams[2])){
		    push @Zexp, $triG . '~' . $itemzrank . '~' . $itemzorig;
		    print Zout "@triG[0]~$itemzrank~$itemzorig\n";
		 }
	       }
	     }
	     elsif ($ITEMZ == 4 ){
               foreach $toquadG (sort keys %CORPUSquad){
		 @quadG = split /\t/, $toquadG;
		 $quadG = @quadG[0];
		 $quadG =~ s/[\\\|\(\)\[\{\^\*\+\?\.]/@/g;
		 if (($quadG =~ @Zunigrams[0]) and ($quadG =~ @Zunigrams[1]) and ($quadG =~ @Zunigrams[2]) and ($quadG =~ @Zunigrams[3])){
		   push @Zexp, $quadG . '~' . $itemzrank . '~' . $itemzorig;
		   print Zout "@quadG[0]~$itemzrank~$itemzorig\n";
		 }
	       }
	     }
             else {
             # Might print : 'should not happen!'
             }
	   }
		 }
	   else {
	   $itemZ =~ s/\t/~/;  
           print Zout "$itemZ\n";
	   }
           @ITEMZ = undef;
	 }
	 }
}  
}
else {
if (defined ($ARGV[3])){  
open (Y, $listY) || die "couldn't open LIST Y: $listY: $!\n";
         while ($itemY = <Y>) {
	   chomp $itemY;
	   if ($itemY !~ /\#/){	     
           $itemY =~ s/ /_/g;
	   @ITEMY = split '~', $itemY;
           $LISTY{lc(@ITEMY[0])} = @ITEMY[1];
           @ITEMY = undef;
	   }
	 }

foreach $lookY (sort keys %LISTY){
  print STDERR "LISTYRANKED: $lookY RANK: $LISTY{$lookY}\n";
}
}
if (defined ($ARGV[4])){
open (X, $listX) || die "couldn't open LIST X: $listX: $!\n";
         while ($itemX = <X>) {
	   chomp $itemX;
	   if ($itemX !~ /\#/){	
	   $itemX =~ s/ /_/g;
	   @ITEMX = split '~', $itemX;
           $LISTX{lc(@ITEMX[0])} = @ITEMX[1];
           @ITEMX = undef;
	 }
	 }
}
if (defined ($ARGV[5])){
open (U, $listU) || die "couldn't open LIST U: $listU: $!\n";
         while ($itemU = <U>) {
	   chomp $itemU;
	   if ($itemU !~ /\#/){	
	   $itemU =~ s/ /_/g;
	   @ITEMU = split '~', $itemU;
           $LISTU{lc(@ITEMU[0])} = @ITEMU[1];
           @ITEMU = undef;
	 }
	 }
}
if (defined ($ARGV[6])){
open (W, $listW) || die "couldn't open LIST W: $listW: $!\n";
         while ($itemW = <W>) {
	   chomp $itemW;
	   if ($itemW !~ /\#/){	
	   $itemW =~ s/ /_/g;
	   @ITEMW = split '~', $itemW;
           $LISTW{lc(@ITEMW[0])} = @ITEMW[1];
           @ITEMW = undef;
	 }
	 }
}
if (defined ($ARGV[7])){
open (Z, $listZ) || die "couldn't open LIST Z: $listZ: $!\n";
         while ($itemZ = <Z>) {
	   chomp $itemZ;
	   if ($itemZ !~ /\#/){	
	   $itemZ =~ s/ /_/g;
	   @ITEMZ = split '~', $itemZ;
           $LISTZ{lc(@ITEMZ[0])} = @ITEMZ[1];
           @ITEMZ = undef;
	 }
	 }
}
}

if ($mode !~ /E/){
##We use the use XML::Twig::XPath Perl module in this mode--BEGIN
use XML::Twig::XPath;
##We use the use XML::Twig::XPath Perl module in this mode--END

##We build the list of documents to be processed--BEGIN
use File::Find;

if ($dir =~ /dirlst$/){
open (Dir, $dir) || die "couldn't open $dir: $!\n";
         while ($dirname = <Dir>) {
         chomp $dirname;

find( sub{
            -f $_ and push @documents, $File::Find::name;
            -d $_ and push @dirs,  $File::Find::name;
}, $dirname );

	 print LOG "DOCNAMESREAD: $dirname >> @documents\n" if ($mode =~ /Z/);
	 foreach $docname (@documents){

   if ($docname =~ /$ext$/){
push(@coldocs, $docname);
   }
     }
	 @documents = ();
}
}
else {

find( sub{
            -f $_ and push @documents, $File::Find::name;
            -d $_ and push @dirs,  $File::Find::name;
}, $dir );

foreach $docname (@documents){

   if ($docname =~ /$ext$/){
           push(@coldocs, $docname);

   }
         }
}
##We build the list of documents to be processed--END

print STDERR "NR DOCS: $#coldocs\n";

if ($mode =~ /A/){
  
  print outA "9999\tLABEL:UYYbisXZ\tParagraph_ID\tBook_Paragraph_ID\tParagraph_Reference\tCollectedHitRankSummary\tCollectedHits\t\TokensInParagraph\tTotalUniquedScore\tTotalUniquedScorePercentage\tTotalHitCount\tHitTypeTokenRatio\tSummaryUnique_Hits_U\tUnique_Hits_U\tSummaryUnique_Hits_Y\tUnique_Hits_Y\tSummaryUnique_Hits_Ybis\tUnique_Hits_Ybis\tSummaryUnique_Hits_X\tUnique_Hits_X\tSummaryUnique_Hits_Z\tUnique_Hits_Z\tParagraph_(lemmatized)\tParagraph_(tokenized)\n";

  print outB "Paragraph_Reference\tLABEL:UYYbisXZ\tParagraph_ID\tBook_Paragraph_ID\tCollectedHitRankSummary\tTotalUniquedScore\tTotalUniquedScorePercentage\tTotalHitCount\tHitTypeTokenRatio\tSummaryUnique_Hits_U\tSummaryUnique_Hits_Y\tSummaryUnique_Hits_Ybis\tSummaryUnique_Hits_X\tSummaryUnique_Hits_Z\n";
}

@coldocs = sort @coldocs;

foreach $doc (@coldocs) {
    $counttokens = ();
    $countocrtokens = ();

##HERE-For each doc, extract the book title and increment the booknumber for each next one seen!!--BEGIN
    @FILENAME = split '-', $doc;
    $prevshortfilename = $shortfilename;
    $shortfilename = @FILENAME[2];
    if ($prevshortfilename !~ /^$shortfilename$/){
      $doccount++;
      undef $uniqsequencenumberbook;    
      undef $printuniqsequencenumberbook;
    }
        print STDOUT "DOCNAMES: $doc <> $doccount\n";
##HERE-For each doc, extract the book title and increment the booknumber for each next one seen!!--END    

my $t = XML::Twig::XPath->new( 
           twig_roots   => { 
                            "//p" => \&getparref,
			    "//w/t" => \&gettoken,
                            "//w/lemma" => \&getlemma,
           },
                      );

$t->parsefile( $doc );

sub gettoken
    { my( $t, $token)= @_;
        {
	  $tokentxt = $token->text; 
	  $coltokens .= $tokentxt . ' ';
	}}
sub getlemma
    { my( $t, $lemma)= @_;
      {
	if ($mode =~ /A/){
	  $prevlemmatxt = $lemmatxt;
	  $lemmatxt = lc($lemma->att( 'class' )); ##Explicit lowercasing
	  if (defined($LISTY{$lemmatxt})){
            push @LISTY, $lemmatxt;
	  }
	  $quadgramlemma = $trigramlemma . '_' . $lemmatxt;
	  $trigramlemma = $bigramlemma . '_' . $lemmatxt;
	  $bigramlemma = $prevlemmatxt . '_' . $lemmatxt;
          if (defined($LISTY{$bigramlemma})){
            push @LISTY, $bigramlemma;
	  }
          if (defined($LISTY{$trigramlemma})){
            push @LISTY, $trigramlemma;
	  }
          if (defined($LISTY{$quadgramlemma})){
            push @LISTY, $quadgramlemma;
	  }
	  
	  if (defined($LISTX{$lemmatxt})){
            push @LISTX, $lemmatxt;
	  }
          if (defined($LISTX{$bigramlemma})){
            push @LISTX, $bigramlemma;
	  }
          if (defined($LISTX{$trigramlemma})){
            push @LISTX, $trigramlemma;
	  }
          if (defined($LISTX{$quadgramlemma})){
            push @LISTX, $quadgramlemma;
	  }
	  
	  if (defined($LISTU{$lemmatxt})){
            push @LISTU, $lemmatxt;
	  }
          if (defined($LISTU{$bigramlemma})){
            push @LISTU, $bigramlemma;
	  }
          if (defined($LISTU{$trigramlemma})){
            push @LISTU, $trigramlemma;
	  }
	  if (defined($LISTU{$quadgramlemma})){
            push @LISTU, $quadgramlemma;
	  }
	  if (defined($LISTW{$lemmatxt})){
            push @LISTW, $lemmatxt;
	  }
          if (defined($LISTW{$bigramlemma})){
            push @LISTW, $bigramlemma;
	  }
          if (defined($LISTW{$trigramlemma})){
            push @LISTW, $trigramlemma;
	  }
          if (defined($LISTW{$quadgramlemma})){
            push @LISTW, $quadgramlemma;
	  }
	  if (defined($LISTZ{$lemmatxt})){
            push @LISTZ, $lemmatxt;
	  }
          if (defined($LISTZ{$bigramlemma})){
            push @LISTZ, $bigramlemma;
	  }
          if (defined($LISTZ{$trigramlemma})){
            push @LISTZ, $trigramlemma;
	  }
          if (defined($LISTZ{$quadgramlemma})){
            push @LISTZ, $quadgramlemma;
	  }
	  
          $tellemmas++;
	  $collemmas .= $lemmatxt . ' ';
	}
	elsif ($mode =~ /F/){
	  $prevlemmatxt = $lemmatxt;
	  $lemmatxt = lc($lemma->att( 'class' )); ##Explicit lowercasing
	  $quadgramlemma = $trigramlemma . '_' . $lemmatxt;
	  $trigramlemma = $bigramlemma . '_' . $lemmatxt;
	  $bigramlemma = $prevlemmatxt . '_' . $lemmatxt;
          $uni{$lemmatxt}++;
	  $bi{$bigramlemma}++;
          $tri{$trigramlemma}++;
	  $quad{$quadgramlemma}++;
	}
	  else {
	  $lemmatxt = lc($lemma->att( 'class' )); ##Explicit lowercasing	    
          $collemmas .= $lemmatxt . ' ';
	  }
	}}

if ($mode !~ /F/){
sub getparref
    { my( $t, $par)= @_;
        {
	  $partxt = $par->att( 'xml:id' );
	  $totalpar++;
	  $uniqsequencenumber++;
	  $uniqsequencenumberbook++;  

          if ($mode =~ /A/){ 
	  $listy = @LISTY;
	  if ($listy == 0){
          push @LISTY, 'XXXXXX';
          $label = 'N';
	  @LABEL[1] = 'N';
	  }
	  else {
	    $label = 'Y';
	    @LABEL[1] = 'Y';
	    foreach $y (@LISTY){
	      $seeny{$y}++;
	      $seenyALL++;
	    }
	    foreach $Yseen (sort keys %seeny){
              push @LISTSEENY, $Yseen;
	      push @LISTSEENYfrq, $Yseen . '[' . $seeny{$Yseen} . ']';
	    }

##NEW-BEGIN	  
          foreach $lseeny (@LISTSEENY){
            if ($lseeny =~ /_/){
	    $rankY = $LISTY{$lseeny};
	    $countrank{$rankY}++;
            @LSEENY = split '_', $lseeny;
	    foreach $lsy (@LSEENY){
            $seenlsy{$lsy}++;
	    }
       	  }
	  }
	  foreach $lseeny (@LISTSEENY){
            if ($lseeny !~ /_/){
	    $rankY = $LISTY{$lseeny};
	    $countrank{$rankY}++ if (!defined ($seenlsy{$lseeny}));
	    	    #print STDOUT "COUNT-Y-unigram: $lseeny <> $rankY <<>> $countrank{$rankY}\n";
	    }
	  }
	  undef %seenlsy;
	  undef @LSEENY;

          foreach $telrank (sort keys %countrank){
	    push @TELRANKY, 'Y:' . $telrank . ':' . $countrank{$telrank};
	    $colRANKY .= 'Y:' . $telrank . ':' . $countrank{$telrank};
       	    $totalY{$telrank} += $countrank{$telrank};
	    $totalthisY += $countrank{$telrank};
	    $toRANKthisY += ($telrank * $countrank{$telrank});
	  }
	  undef %countrank;
	  }
          $listseeny = @LISTSEENY;
##NEW-END
	  
	  $listx = @LISTX;
	  if ($listx == 0){
          push @LISTX, 'XXXXXX';
	  $label .= 'N';
	  @LABEL[3] = 'N';
	  }
	  else {
	    $label .= 'Y';
	    @LABEL[3] = 'Y';
	    foreach $x (@LISTX){
	      $seenx{$x}++;
	      $seenxALL++;
	    }
	    foreach $Xseen (sort keys %seenx){
              push @LISTSEENX, $Xseen;
	      push @LISTSEENXfrq, $Xseen . '[' . $seenx{$Xseen} . ']';
	    }

          foreach $lseenx (@LISTSEENX){
            if ($lseenx =~ /_/){
	    $rankX = $LISTX{$lseenx};
	    $countrank{$rankX}++;
            @LSEENX = split '_', $lseenx;
	    foreach $lsx (@LSEENX){
            $seenlsx{$lsx}++;
	    }
       	  }
	  }
	  foreach $lseenx (@LISTSEENX){
            if ($lseenx !~ /_/){
	    $rankX = $LISTX{$lseenx};
	    $countrank{$rankX}++ if (!defined ($seenlsx{$lseenx}));
	    }
	  }
	  undef %seenlsx;
	  undef @LSEENX;

          foreach $telrank (sort keys %countrank){
	    push @TELRANKX, 'X:' . $telrank . ':' . $countrank{$telrank};
	    $colRANKX .= 'X:' . $telrank . ':' . $countrank{$telrank};
	    $totalX{$telrank} += $countrank{$telrank};
	    $totalthisX += $countrank{$telrank};
	    $toRANKthisX += ($telrank * $countrank{$telrank});
	  }
	  undef %countrank;
	  }
          $listseenx = @LISTSEENX;
	  
	  $listu = @LISTU;
	  if ($listu == 0){
          push @LISTU, 'XXXXXX';
	  $label .= 'N';
	  @LABEL[0] = 'N';
	  }
	  else {
	    $label .= 'Y';
	    @LABEL[0] = 'Y';
	    foreach $u (@LISTU){
	      $seenu{$u}++;
	      $seenuALL++;
	    }
	    foreach $Useen (sort keys %seenu){
	      push @LISTSEENU, $Useen;
	      push @LISTSEENUfrq, $Useen . '[' . $seenu{$Useen} . ']';
	    }

          foreach $lseenu (@LISTSEENU){
            if ($lseenu =~ /_/){
	    $rankU = $LISTU{$lseenu};
	    $countrank{$rankU}++;
            @LSEENU = split '_', $lseenu;
	    foreach $lsu (@LSEENU){
            $seenlsu{$lsu}++;
	    }
       	  }
	  }
	  foreach $lseenu (@LISTSEENU){
            if ($lseenu !~ /_/){
	    $rankU = $LISTU{$lseenu};
	    $countrank{$rankU}++ if (!defined ($seenlsu{$lseenu}));
	    }
	  }
	  undef %seenlsu;
	  undef @LSEENU;

          foreach $telrank (sort keys %countrank){
	    push @TELRANKU, 'U:' . $telrank . ':' . $countrank{$telrank};
	    $colRANKU .= 'U:' . $telrank . ':' . $countrank{$telrank};
	    $totalU{$telrank} += $countrank{$telrank};
	    $totalthisU += $countrank{$telrank};
	    $toRANKthisU += ($telrank * $countrank{$telrank});
	  }
	  undef %countrank;
	  }
          $listseenu = @LISTSEENU;

      	  $listw = @LISTW;
	  if ($listw == 0){
          push @LISTW, 'XXXXXX';
	  $label .= 'N';
	  @LABEL[2] = 'N';
	  }
	  else {
	    $label .= 'Y';
    	    @LABEL[2] = 'Y';
	    foreach $w (@LISTW){
	      $seenw{$w}++;
	      $seenwALL++;
	    }
	    foreach $Wseen (sort keys %seenw){
	      push @LISTSEENW, $Wseen;
	      push @LISTSEENWfrq, $Wseen . '[' . $seenw{$Wseen} . ']';
	    }

            foreach $lseenw (@LISTSEENW){
            if ($lseenw =~ /_/){
	    $rankW = $LISTW{$lseenw};
	    $countrank{$rankW}++;
            @LSEENW = split '_', $lseenw;
	    foreach $lsw (@LSEENW){
            $seenlsw{$lsw}++;
	    }
       	  }
	  }
	  foreach $lseenw (@LISTSEENW){
            if ($lseenw !~ /_/){
	    $rankW = $LISTW{$lseenw};
	    $countrank{$rankW}++ if (!defined ($seenlsw{$lseenw}));
	    }
	  }
	  undef %seenlsw;
	  undef @LSEENW;

          foreach $telrank (sort keys %countrank){
	    push @TELRANKW, 'Ybis:' . $telrank . ':' . $countrank{$telrank};
	    $colRANKW .= 'Ybis:' . $telrank . ':' . $countrank{$telrank};
	    $totalW{$telrank} += $countrank{$telrank};
	    $totalthisW += $countrank{$telrank};
	    $toRANKthisW += ($telrank * $countrank{$telrank});
	  }
	  undef %countrank;	  
	  }
          $listseenw = @LISTSEENW;
	    
	  $listz = @LISTZ;
	  if ($listz == 0){
          push @LISTZ, 'XXXXXX';
	  $label .= 'N';
	  @LABEL[4] = 'N';
	  }
	  else {
	    $label .= 'Y';
	    @LABEL[4] = 'Y';
	    foreach $z (@LISTZ){
	      $seenz{$z}++;
	      $seenzALL++;
	    }
	    foreach $Zseen (sort keys %seenz){
	      push @LISTSEENZ, $Zseen;
	      push @LISTSEENZfrq, $Zseen . '[' . $seenz{$Zseen} . ']';
	    }

          foreach $lseenz (@LISTSEENZ){
            if ($lseenz =~ /_/){
	    $rankZ = $LISTZ{$lseenz};
	    $countrank{$rankZ}++;
            @LSEENZ = split '_', $lseenz;
	    foreach $lsz (@LSEENZ){
            $seenlsz{$lsz}++;
	    }
       	  }
	  }
	  foreach $lseenz (@LISTSEENZ){
            if ($lseenz !~ /_/){
	    $rankZ = $LISTZ{$lseenz};
	    $countrank{$rankZ}++ if (!defined ($seenlsz{$lseenz}));
	    }
	  }
	  undef %seenlsz;
	  undef @LSEENZ;

          foreach $telrank (sort keys %countrank){
	    push @TELRANKZ, 'Z:' . $telrank . ':' . $countrank{$telrank};
	    $colRANKZ .= 'Z:' . $telrank . ':' . $countrank{$telrank};
	    $totalZ{$telrank} += $countrank{$telrank};   ##This is 'per rank', towards the summary!!
	    $totalthisZ += $countrank{$telrank};
	    $toRANKthisZ += ($telrank * $countrank{$telrank});
	  }
	  undef %countrank;
	  }
          $listseenz = @LISTSEENZ;

	  $countlists = $listu + $listw + $listx + $listy + $listz;

	  $relative = ($countlists / $tellemmas) * 100;
	  $printrelative = sprintf("%.2f", $relative);

	  $uniquecountlists = $listseenu + $listseenw + $listseenx + $listseeny + $listseenz;
          $realuniquecountlists =  + $totalthisY + $totalthisU + $totalthisW + $totalthisZ;
	  $toRANKthisPAR = $toRANKthisX + $toRANKthisY + $toRANKthisU + $toRANKthisW + $toRANKthisZ;
	  $uniquerelative = ($uniquecountlists / $tellemmas) * 100;
	  $printuniquerelative = sprintf("%.2f", $uniquerelative);
	  $realuniquerelative = ($realuniquecountlists / $tellemmas) * 100;
	  $printrealuniquerelative = sprintf("%.2f", $realuniquerelative);
	  
	  if (($countlists > 0) and ($tellemmas > 5)){

	    $printuniqsequencenumber = 'P_' . sprintf("%06d", $uniqsequencenumber);
	    $printuniqsequencenumberbook = 'B_' . sprintf("%04d", $doccount) . 'P_' . sprintf("%04d", $uniqsequencenumberbook);
	     
	    foreach $mark (@LABEL){
            $newlabel .= $mark;
	    }
	    undef @LABEL;

            $telranks = $colRANKU . ',' . $colRANKY . ',' . $colRANKW . ',' . $colRANKX . ',' . $colRANKZ;
            $telranks =~ s/ /,/g;
	    $telranks =~ s/^,+//g;
	    $telranks =~ s/,+$//g;
            $telranks =~ s/,+/,/g;
	    
            $colRANKU = ();
            $colRANKY = ();	    
	    $colRANKW = ();
	    $colRANKX = ();
	    $colRANKZ = ();
	    
	    if (!@TELRANKU){
            push @TELRANKU, 'n.a.';
	    }
	    if (!@TELRANKY){
            push @TELRANKY, 'n.a.';
	    }
	    if (!@TELRANKW){
            push @TELRANKW, 'n.a.';
	    }
	    if (!@TELRANKX){
            push @TELRANKX, 'n.a.';
	    }
	    if (!@TELRANKZ){
            push @TELRANKZ, 'n.a.';
	    }
	    if (!@LISTSEENU){
            push @LISTSEENU, '--';
	    }
	    if (!@LISTSEENY){
            push @LISTSEENY, '--';
	    }
	    if (!@LISTSEENW){
            push @LISTSEENW, '--';
	    }
	    if (!@LISTSEENX){
            push @LISTSEENX, '--';
	    }
	    if (!@LISTSEENZ){
            push @LISTSEENZ, '--';
	    }
	    if (!@LISTSEENUfrq){
            push @LISTSEENUfrq, '--';
	    }
	    if (!@LISTSEENYfrq){
            push @LISTSEENYfrq, '--';
	    }
	    if (!@LISTSEENWfrq){
	    push @LISTSEENWfrq, '--';
	    }
	    if (!@LISTSEENXfrq){
	    push @LISTSEENXfrq, '--';
	    }
	    if (!@LISTSEENZfrq){
	    push @LISTSEENZfrq, '--';
	    }

$stats{$newlabel}++;
	    
	    ##Arianna wants this sequence of list outputs: U, Y, Ybis, X, Z

foreach $sawU (@LISTSEENU){ 
$haveseenU{$sawU}++ if ($sawU !~ '--');
}
foreach $sawY (@LISTSEENY){ 
$haveseenY{$sawY}++ if ($sawY !~ '--');
}
foreach $sawW (@LISTSEENW){ 
$haveseenW{$sawW}++ if ($sawW !~ '--');
}
foreach $sawX (@LISTSEENX){ 
$haveseenX{$sawX}++ if ($sawX !~ '--');
}
foreach $sawZ (@LISTSEENZ){ 
$haveseenZ{$sawZ}++ if ($sawZ !~ '--');
}

	    $hittypetoken = ($realuniquecountlists / $countlists) * 100;
	    $hittypetokenratio = sprintf("%.2f", $hittypetoken);
	    
	    print outA "$toRANKthisPAR\t$newlabel\t$printuniqsequencenumber\t$printuniqsequencenumberbook\t$partxt\t$telranks\t@LISTSEENUfrq @LISTSEENYfrq @LISTSEENWfrq @LISTSEENXfrq @LISTSEENZfrq\t$tellemmas\t$realuniquecountlists\t$printrealuniquerelative\t$countlists\t$hittypetokenratio\t@TELRANKU\t@LISTSEENUfrq\t@TELRANKY\t@LISTSEENYfrq\t@TELRANKW\t@LISTSEENWfrq\t@TELRANKX\t@LISTSEENXfrq\t@TELRANKZ\t@LISTSEENZfrq\tLEM:$collemmas\tTOK:$coltokens\n";
	    
	  $countoutA++;
	  print outB "$partxt\t$newlabel\t$printuniqsequencenumber\t$printuniqsequencenumberbook\t$telranks\t$realuniquecountlists\t$countlists\t$hittypetokenratio\t$printrealuniquerelative\t@TELRANKU\t@TELRANKY\t@TELRANKW\t@TELRANKX\t@TELRANKZ\n";
	  }
	  
	  $newlabel = ();
	  $telranks = ();

}
else { ##This is/was the output for mode = O
       ##May well be repurposed just to extract these data from FoLiA XML!!    
	  print STDOUT "$partxt\t$coltokens\t$collemmas\n";
	}

	  undef $totalthisX;
	  undef $totalthisY;
	  undef $totalthisU;
	  undef $totalthisW;
	  undef $totalthisZ;

	  undef $toRANKthisX;
	  undef $toRANKthisY;
	  undef $toRANKthisU;
	  undef $toRANKthisW;
	  undef $toRANKthisZ;
	  
	  undef @LISTU;
	  undef @LISTW;
	  undef @LISTX;
	  undef @LISTY;
	  undef @LISTZ;

          undef @TELRANKY;
	  undef @TELRANKX;
	  undef @TELRANKU;
	  undef @TELRANKW;
	  undef @TELRANKZ;
	  
	  $listu = ();
	  $listw = ();
	  $listx = ();
	  $listy = ();
	  $listz = ();

	  undef %seenu;
          undef %seenw;
	  undef %seenx;
	  undef %seeny;
	  undef %seenz;

	  undef @LISTSEENU;
	  undef @LISTSEENW;
          undef @LISTSEENX;
	  undef @LISTSEENY;
          undef @LISTSEENZ;

	  undef @LISTSEENUfrq;
	  undef @LISTSEENWfrq;
          undef @LISTSEENXfrq;
	  undef @LISTSEENYfrq;
          undef @LISTSEENZfrq;
	  
	  $listseenu = ();
	  $listseenw = ();
	  $listseenx = ();
	  $listseeny = ();
	  $listseenz = ();

	  $tellemmas = ();
	  $countlists = ();
	  
          $coltokens = ();
	  $collemmas = ();
          $countlists = ();
	  $relative = ();
	  $printrelative = ();
	  $uniquecountlists = ();
	  $uniquerelative = ();
	  $printuniquerelative = ();
	  $label = ();

	}}
  }
} ##to: foreach $doc (@coldocs)

    print STDOUT "COLTOKENSALL: Y: $seenyALL X: $seenxALL U: $seenuALL W: $seenwALL Z: $seenzALL\n";

if ($mode =~ /A/){
  print outC "Overall Corpus Statistics:\n\n";
  print outC "Number of documents: $#coldocs\n\n";
  print outC "Number of paragraphs retrieved from corpus: $totalpar\n\n";
  print outC "Number of corpus paragraphs annotated and ranked: $countoutA\n\n";

  $percentannotpars = ($countoutA / $totalpar) * 100;
  $printpercentannotpars = sprintf("%.2f", $percentannotpars);
  print outC "Percentage of corpus paragraphs annotated and ranked: $printpercentannotpars\%\n\n";

    print outC "Overview of retained hits per list:\n\n";
   foreach $totalrankY (sort keys %totalY){
     print outC "TOTALS_LISTY: $totalrankY $totalY{$totalrankY}\n";
     $totalYhitsretained += $totalY{$totalrankY};
	}
   print outC "\n";
   foreach $totalrankX (sort keys %totalX){
     print outC "TOTALS_LISTX: $totalrankX $totalX{$totalrankX}\n";
          $totalXhitsretained += $totalX{$totalrankX};
	}
   print outC "\n";
   foreach $totalrankU (sort keys %totalU){
     print outC "TOTALS_LISTU: $totalrankU $totalU{$totalrankU}\n";
     $totalUhitsretained += $totalU{$totalrankU};
	}
   print outC "\n";
   foreach $totalrankW (sort keys %totalW){
     print outC "TOTALS_LISTYbis: $totalrankW $totalW{$totalrankW}\n";
     $totalWhitsretained += $totalW{$totalrankW};
	}
   print outC "\n";
   foreach $totalrankZ (sort keys %totalZ){
     print outC "TOTALS_LISTZ: $totalrankZ $totalZ{$totalrankZ}\n";
     $totalZhitsretained += $totalZ{$totalrankZ};
	}

  print outC "\nParagraphs retrieved are currently retained if 1/ there were hits on any of the list 2/ the paragraph actually is longer than 5 word tokens (we try to avoid retrieving section 'titles', etc.\n";
  
  print outC "\nList Y : Hits retained vs. retrieved: $totalYhitsretained / $seenyALL\n";
  print outC "\nList X : Hits retained vs. retrieved: $totalXhitsretained / $seenxALL\n";
  print outC "\nList U : Hits retained vs. retrieved: $totalUhitsretained / $seenuALL\n";
  print outC "\nList Ybis : Hits retained vs. retrieved: $totalWhitsretained / $seenwALL\n";
  print outC "\nList Z : Hits retained vs. retrieved: $totalZhitsretained / $seenzALL\n";

print outC "\nHit Pattern Overview: Label\tNumber of members\n\n";
  
  foreach $seenlabel (reverse sort keys %stats){
  print outC "$seenlabel\t$stats{$seenlabel}\n";
}

  print outC "\n\nTermU\t\#OccurrencesU\tParagraphPercentageU\n\n";
  foreach $didseeU (sort keys %haveseenU){
    $percentdidseeU = ($haveseenU{$didseeU} / $totalUhitsretained) * 100;
    $printpercentdidseeU = sprintf("%.2f", $percentdidseeU);
  print outC "$didseeU\t$haveseenU{$didseeU}\t$printpercentdidseeU\n";
  }
  print outC "\n\nTermY\t\#OccurrencesY\tParagraphPercentageY\n\n";
  foreach $didseeY (sort keys %haveseenY){
    $percentdidseeY = ($haveseenY{$didseeY} / $totalYhitsretained) * 100;
    $printpercentdidseeY = sprintf("%.2f", $percentdidseeY);
  print outC "$didseeY\t$haveseenY{$didseeY}\t$printpercentdidseeY\n";
  }
  print outC "\n\nTermYbis\t\#OccurrencesYbis\tParagraphPercentageYbis\n\n";
  foreach $didseeW (sort keys %haveseenW){
    $percentdidseeW = ($haveseenW{$didseeW} / $totalWhitsretained) * 100;
    $printpercentdidseeW = sprintf("%.2f", $percentdidseeW);
  print outC "$didseeW\t$haveseenW{$didseeW}\t$printpercentdidseeW\n";
  }
  print outC "\n\nTermX\t\#OccurrencesX\tParagraphPercentageX\n\n";
  foreach $didseeX (sort keys %haveseenX){
    $percentdidseeX = ($haveseenX{$didseeX} / $totalXhitsretained) * 100;
    $printpercentdidseeX = sprintf("%.2f", $percentdidseeX);
  print outC "$didseeX\t$haveseenX{$didseeX}\t$printpercentdidseeX\n";
  }
  print outC "\n\nTermZ\t\#OccurrencesZ\tParagraphPercentageZ\n\n";
  foreach $didseeZ (sort keys %haveseenZ){
    $percentdidseeZ = ($haveseenZ{$didseeZ} / $totalZhitsretained) * 100;
    $printpercentdidseeZ = sprintf("%.2f", $percentdidseeZ);
  print outC "$didseeZ\t$haveseenZ{$didseeZ}\t$printpercentdidseeZ\n";
  }
}

if ($mode =~ /F/){
  ##get filenames and open files, then write to files instead of STDOUT
  @TOFILE = split '/', $dir;
  $tofilename = pop @TOFILE;
  $unifile = $dir .'/' . $tofilename . '.1gram.tsv';
  $bifile = $dir .'/' . $tofilename . '.2gram.tsv';
  $trifile = $dir .'/' . $tofilename . '.3gram.tsv';
  $quadfile = $dir .'/' . $tofilename . '.4gram.tsv';

open(UNI, ">$unifile") || die "Could nay open UNIFILE $unifile : $!\n";
binmode(UNI, ":utf8");

open(BI, ">$bifile") || die "Could nay open BIFILE $bifile : $!\n";
binmode(BI, ":utf8");

open(TRI, ">$trifile") || die "Could nay open TRIFILE $trifile : $!\n";
binmode(TRI, ":utf8");

open(QUAD, ">$quadfile") || die "Could nay open QUADFILE $quadfile : $!\n";
binmode(QUAD, ":utf8");
  
foreach $unigram (sort keys %uni){
print UNI "$unigram\t$uni{$unigram}\n";
}
foreach $bigram (sort keys %bi){
print BI "$bigram\t$bi{$bigram}\n";
}
foreach $trigram (sort keys %tri){
print TRI "$trigram\t$tri{$trigram}\n";
}
foreach $quadgram (sort keys %quad){
print QUAD "$quadgram\t$quad{$quadgram}\n";
}
  
  close UNI;
  close BI;
  close TRI;
  close QUAD;
}
} ##To: if not mode E
