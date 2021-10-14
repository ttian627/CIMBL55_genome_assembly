#!perl
open(IN1,"55ref.intersect.bed")or die;
open(IN2,"Mo17ref.intersect.bed")or die;
open(SV1,"CIMBL55ref.Mo17.sv.bed")or die;
open(SV2,"Mo17ref.CIMBL55.sv.bed")or die;
while(<SV1>){
$_=~s/[\r\n]//g;
my @a=split(/\t/,$_);
$hashsv1{$a[3]}=$a[1]."\t".$a[2];
}
while(<SV2>){
$_=~s/[\r\n]//g;
my @b=split(/\t/,$_);
$hashsv2{$b[3]}=$b[1]."\t".$b[2];

}
while(<IN1>){
$_=~s/[\r\n]//g;
my @arr=split(/\t/,$_);
$hash{$arr[10]."\t".abs($arr[4])}=$_;
}
while(<IN2>){
my @brr=split(/\t/,$_);
if($hash{$brr[10]."\t".abs($brr[4])}){
if(($_=~/.*INS.*/ && $hash{$brr[10]."\t".abs($brr[4])}=~/.*DEL.*/) || ($_=~/.*DEL.*/ && $hash{$brr[10]."\t".abs($brr[4])}=~/.*INS.*/))
#if(/.*INS.*/)
{
if(!$hash_tmp{$brr[3]}){
my @c=split(/\t/,$hash{$brr[10]."\t".abs($brr[4])});
my @d=split(/\t/,$hashsv1{$c[3]});
my @e=split(/\t/,$hashsv2{$brr[3]});
if($c[6]<= $d[0]){
$dis1=($d[0]-$c[6]);
$loc1="up";
}
elsif($c[6]>=$d[1]){
$dis1=($c[6]-$d[1]);
$loc1="down";
}
else{
$dis1=($d[1]-$c[6]);
$loc1="inner";
}
if($brr[6]<=$e[0]){
$dis2=($e[0]-$brr[6]);
$loc2="up";
}
elsif($brr[6]>=$e[1])
{
$dis2=($brr[6]-$e[1]);
$loc2="down";
}
else{
$dis2=($e[1]-$brr[6]);
$loc2="inner";
}

if($loc1 eq $loc2 && abs($dis2-$dis1)<=500){
print "$loc1$dis1\t$loc2$dis2\t55ref\t".$hashsv1{$c[3]}."\t".$hash{$brr[10]."\t".abs($brr[4])}."\tMo17ref\t$hashsv2{$brr[3]}\t".$_;
$hash_tmp{$brr[3]}=1;
}
}
}
}

}
