# ������ 1.1 �� 07.02.17
# ������ ��������� ����� ������ ��� (mkio.txt). � ���������� ��������� ��� �����:
# 1) mkio_1.txt - ���� ��� "��������" ����� � � ������������ ���������
# 2) mkio_2.txt - ���� "�������� �����" (time>0)

$mkio_file='mkio.txt';
$obr_mkio='mkio_1.txt';
$chist_sbros='mkio_2.txt';
@blocks;
@drop_line;
@MaxLength;
@TitleLength;

# ��������� ����������� �������, ��� ��������� ������� �������
@allowed_symbols=('0','1','2','3','4','5','6','7','8','9','.','-');

# ��������� �������� ��������� �����
@titles=(
"Time_BSR",
"Nx_filter",
"Ny_filter",
"Nz_filter", 
"omx_filter",
"omy_filter",
"omz_filter",
"time",
"u1",
"u2",
"u3",
"u4",
"omx_rd",
"SSB1",
"SSB2",
"Theta",
"gam",
"thet",
"psi",
"X_bu",
"Y_bu",
"Z_bu",
"Vx_bu",
"Vy_bu",
"Vz_bu",
"dH",
"dZ",
"omx_acp",
"omy_acp",
"omz_acp",
"omx_rd_acp",
"Temp",
"Nx_acp",
"Ny_acp",
"Nz_acp",
"D",
"CPK",
"Tzad",
"Kurs_cn",
"Kren_cn",
"Tang_cn",
"Bti",
"Lti",
"Hti",
"Bcn",
"Lcn",
"Hcn",
"V_N",
"V_E",
"V_H",
"Rez1",	
"Rez2",
"Rez3",
"H_barom",
"dn",
"dv",
"de",
"Ax_cn",
"Ay_cn",
"Az_cn",
"check_summa",
"Wx_cn",
"Wy_cn",
"Wz_cn",
"mark_SNS",
"Rez4",
"Rez5",
"Rez6",
"kol_strob",
"interval",
"Bgeo",
"Lgeo",
"Hgeo",
"Vn",
"Ve",
"Vh",
"factor",
"NS_NSS_SO",
"SN",
"NS_NSS_SO1",
"SN1",
"NS_NSS_SO2",
"SN2",
"tabl41",
"tabl42",
"NS_NSS_SO3",
"SN3",
"NS_NSS_SO4",
"SN4",
"NS_NSS_SO5",
"SN5",
"NS_NSS_SO6",
"SN6",
"NS_NSS_SO7",
"SN7",
"NS_NSS_SO8",
"SN8",
"NS_NSS_SO9",
"SN9",
"NS_NSS_SO10",
"SN10",
"NS_NSS_SO11",
"SN11",
"year",
"month",
"day",
"hour",
"minute",
"second",
"Res7",
"Res8",
"delta_kren",
"Eg",
"Ek",
"Nz_zad",
"Ny_zad",
"tabl31",
"tabl32",
"priznak1",
"priznak2",
"M1_1",
"M1_2",
"M2_1",
"M2_2",
"M31_1",
"M31_2",
"M32_1",
"M32_2",
"M4_1",
"M4_2",
"M5_1",
"M5_2",
"M6_1",
"M6_2",
"M7_1",
"M7_2",
"SD_9GJ"
);

# ���������� ���������� - 1
$AllTitles=$#titles;

# �������, ��� ������������ ������ ������� ������������� ��������������� ������� ���������
for ($i=0;$i<=$AllTitles;$i++)
{
	$MaxLength[$i]=length($titles[$i]);
} 

$AllSymbNum=$#allowed_symbols;
print "Allowed Symbols Number:  ",$AllSymbNum+1,"\n";

# ��������� �� ������ mkio.txt
open($file,'<',$mkio_file) or die "Cannot open mkio.txt\n";

$total_strings=0;
$lines_copied=0;

# ������ ���� ���������
while(<$file>)
{
# ����������� ������� ����� �� �������
	$total_strings++;
	$drop_line[$total_strings]=0;
	
# ���������� ������ ������
	next if($total_strings==1);
	
#	�������� ��������� ������
	chomp;
		
# ����� ������ �� �����, ����������� ����������� ���������
	@blocks=split(' ',$_);
	
# ���������� ������ � ������� ������ - 1
	$BloNumb=$#blocks;
	
# ����������� ������ ���� �� ������� �������� ��������
	for($i=0;$i<=$BloNumb;$i++)
	{
		last if($drop_line[$total_strings]==1);
		
		# ���������� �������� � ������� �����
		$SymbNum=length($blocks[$i]);
		
		# ���� ���������� �������� ������ ������������� �������� - ��������� ������������ ��������
		if($SymbNum>$MaxLength[$i])
		{
			$MaxLength[$i]=$SymbNum;
		}
		# ��������� ������ ������, ���� �� �� �� �����������, ������ ���� ������� ������
		for($j=0;$j<$SymbNum;$j++)
		{
			last if($drop_line[$total_strings]==1);
			$Symbol=substr($blocks[$i],$j,1);
			for($k=0;$k<=$AllSymbNum;$k++)
			{
			$drop_line[$total_strings]=1;
				if($Symbol eq $allowed_symbols[$k])
				{
					$drop_line[$total_strings]=0;
					last;
				}
			}
		}
	}
}

# �������� ��������� ��������� �� ������������ ������ ���������������� �������
for ($i=0;$i<=$AllTitles;$i++)
{
	for ($j=length($titles[$i]);$j<$MaxLength[$i];$j++)
	{
		$titles[$i]=$titles[$i]." ";
	}
}

$,='  ';

# ��������� ���� mkio.txt
close($file);

# ��������� �� ������ mkio.txt
open($file,'<',$mkio_file) or die "Cannot open mkio.txt\n";

# ��������� �� ������ ������������ ����
open($obr_file,'>',$obr_mkio) or die "Cannot open $obr_mkio\n";

# ��������� �� ������ ���� "������� ������"
open($ch_file,'>',$chist_sbros) or die "Cannot open $chist_sbros\n";

# ���������� � ������������ ���� ������ ����������
print $obr_file @titles,"\n";
print $ch_file @titles,"\n";

$lines_copied=0;
$lines_ch_sbr=0;
$i=0;
while(<$file>)
{
	$i++;
	
# ���������� ������ ������
	next if($i==1);	
	
	if($drop_line[$i]==0)
	{
		# �������� ��������� ������
		chomp;
		# ����� ������ �� �����, ����������� ����������� ���������
		@blocks=split(' ',$_);
		$col8=$blocks[7];
		
		# ���������� ������ � ������� ������ - 1
		$BloNumb=$#blocks;
		
		# �������� ������� ��������� �� ������������ ������ ���������������� �������		
		for ($j=0;$j<=$BloNumb;$j++)
		{
			for ($n=length($blocks[$j]);$n<$MaxLength[$j];$n++)
			{
				$blocks[$j]=$blocks[$j]." ";
			}
		}
		$lines_copied++;
		print $obr_file @blocks,"\n";
		
		# ���� ������� ������� �� ����� ����, ����� ������ � ���� "������� ������"
		if($col8!=0.0)
		{
			print $ch_file @blocks,"\n";
			$lines_ch_sbr++;
		}
	}
}
# ��������� ��� �����
close($file);
close($obr_file);
close($ch_file);

print "Total lines processed: ",$total_strings-1,"\n";
print "Lines copied:          ",$lines_copied,"\n";
print "Lines (t>0) copied:    ",$lines_ch_sbr,"\n";
print "Program finished. Press ENTER to close...\n";
$wait=<>;
