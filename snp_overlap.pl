#!perl
my $chr=$ARGV[0];

open(IN1,"../SNP_CIMBL55ref_B73/vcf/NUC_CIMBL55ref_B73_$chr.filter.delta.snp")or die;
open(IN2,"../SNP_B73ref_CIMBL55/NUC_B73ref_CIMBL55_$chr.filter.delta.ref.snp")or die;
while(<IN2>){
$_=~s/[\r\n]//g;
my @array=split(/\t/,$_);
$hash{$array[0]."\t".$array[1]."\t".$array[2]."\t".$array[3]."\t".$array[11]}=1;
}
while(<IN1>){
$_=~s/[\r\n]//g;
my @array=split(/\t/,$_);
if($hash{$array[3]."\t".$array[2]."\t".$array[1]."\t".$array[0]."\t".$array[12]})
{
print $array[3]."\t".$array[2]."\t".$array[1]."\t".$array[0]."\t".$array[12]."\n";

}
}
