#!perl
$file=$ARGV[0];
open(SELF1,"bed/B73_contig.bed")or die;
open(SELF2,"bed/CIMBL55_contig.bed")or die;
open(IN1,"CIMBL55-B73.$file.bed.noN")or die;
open(IN2,"B73-CIMBL55.$file.bed.noN")or die;
open(OUT,">55ref-B73-alldirection-$ARGV[0].bed")or die;
open(OVERLAP,">55ref-B73-bidirection-$ARGV[0].bed")or die;
readline IN1;
readline IN2;
while(<SELF1>){
$_=~s/[\r\n]//g;
my @arr=split(/\t/,$_);
$hash_contig{$arr[3]}=$arr[0]."\t".$arr[1]."\t".$arr[2];
}

while(<IN1>){
my @brr=split(/\t/,$_);
my @contig=split(/\t/,$hash_contig{$brr[6]});
$hash{"$brr[0]\t$brr[1]\t$brr[2]\t$contig[0]\t".($contig[1]+$brr[7]-1)."\t".($contig[1]+$brr[8]-1)}=$brr[3];
print OUT "55ref\t$brr[0]\t$brr[1]\t$brr[2]\t$brr[3]\t$contig[0]\t".($contig[1]+$brr[7]-1)."\t".($contig[1]+$brr[8]-1)."\t$brr[6]\t$brr[7]\t$brr[8]\n";
#if($brr[3] eq "deletion"){
#print OUT "55ref\t$contig[0]\t".($contig[1]+$brr[7]-1)."\t".($contig[1]+$brr[8]-1)."\tinsertion\t$brr[0]\t$brr[1]\t$brr[2]\t$brr[6]\t$brr[7]\t$brr[8]\n";
#}
#elsif($brr[3] eq "insertion"){
#print OUT "55ref\t$contig[0]\t".($contig[1]+$brr[7]-1)."\t".($contig[1]+$brr[8]-1)."\tdeletion\t$brr[0]\t$brr[1]\t$brr[2]\t$brr[6]\t$brr[7]\t$brr[8]\n";
#}
#else{
#print OUT "55ref\t$contig[0]\t".($contig[1]+$brr[7]-1)."\t".($contig[1]+$brr[8]-1)."\t".$brr[3]."\t$brr[0]\t$brr[1]\t$brr[2]\t$brr[6]\t$brr[7]\t$brr[8]\n";
#}
}

while(<SELF2>){
$_=~s/[\r\n]//g;
my @arr=split(/\t/,$_);
$hash_contig{$arr[3]}=$arr[0]."\t".$arr[1]."\t".$arr[2];
}

while(<IN2>){
my @brr=split(/\t/,$_);
my @contig=split(/\t/,$hash_contig{$brr[6]});
if($hash{$contig[0]."\t".($contig[1]+$brr[7]-1)."\t".($contig[1]+$brr[8]-1)."\t$brr[0]\t$brr[1]\t$brr[2]"}){
#print OVERLAP "55-b73overlap\t$brr[0]\t$brr[1]\t$brr[2]\t$brr[3]\t$contig[0]\t".($contig[1]+$brr[7]-1)."\t".($contig[1]+$brr[8]-1)."\t$brr[6]\t$brr[7]\t$brr[8]\n";

if($brr[3] eq "deletion"){
print OVERLAP "55-b73overlap\t$contig[0]\t".($contig[1]+$brr[7]-1)."\t".($contig[1]+$brr[8]-1)."\tinsertion\t$brr[0]\t$brr[1]\t$brr[2]\t$brr[6]\t$brr[7]\t$brr[8]\n";
}
elsif($brr[3] eq "insertion"){
print OVERLAP "55-b73overlap\t$contig[0]\t".($contig[1]+$brr[7]-1)."\t".($contig[1]+$brr[8]-1)."\tdeletion\t$brr[0]\t$brr[1]\t$brr[2]\t$brr[6]\t$brr[7]\t$brr[8]\n";
}
else{
print OVERLAP "55-b73overlap\t$contig[0]\t".($contig[1]+$brr[7]-1)."\t".($contig[1]+$brr[8]-1)."\t$brr[3]\t$brr[0]\t$brr[1]\t$brr[2]\t$brr[6]\t$brr[7]\t$brr[8]\n";
}




}
else{
if($brr[3] eq "deletion"){
print OUT "b73ref\t$contig[0]\t".($contig[1]+$brr[7]-1)."\t".($contig[1]+$brr[8]-1)."\tinsertion\t$brr[0]\t$brr[1]\t$brr[2]\t$brr[6]\t$brr[7]\t$brr[8]\n";
}
elsif($brr[3] eq "insertion"){
print OUT "b73ref\t$contig[0]\t".($contig[1]+$brr[7]-1)."\t".($contig[1]+$brr[8]-1)."\tdeletion\t$brr[0]\t$brr[1]\t$brr[2]\t$brr[6]\t$brr[7]\t$brr[8]\n";
}
else{
print OUT "b73ref\t$contig[0]\t".($contig[1]+$brr[7]-1)."\t".($contig[1]+$brr[8]-1)."\t$brr[3]\t$brr[0]\t$brr[1]\t$brr[2]\t$brr[6]\t$brr[7]\t$brr[8]\n";
}
}

}
