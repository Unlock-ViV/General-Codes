#!/bin/bash

######################################################################################
##################################### HOW TO RUN ?? ##################################

# ./separating_multiple_fasta_file.sh [Argument-1 = multiple multi line fasta] [Argument-2 = accession_list] [Argument-3 = Directory name]

# ./separating_multiple_fasta_file.sh multiple_multi-line.fasta accession_list.txt dir

######################################################################################
######################################################################################

multiple_multi_line_fasta="$1";
accession_list="$2";
new_folder_name="$3";
mkdir $new_folder_name;

#creating a multiple_single_line_fasta for the multiple_multi_line_fasta_file

###### finding > and adding delimiter __ in the end of the line
sed -e "/^>/s/$/__/g" $multiple_multi_line_fasta > $new_folder_name/multiple_single_line.fasta

###### removing all new line chracter from the file
sed -i -z "s/\n//g" $new_folder_name/multiple_single_line.fasta

###### creating single line fasta
sed -i -z "s/>/\n>/g" $new_folder_name/multiple_single_line.fasta

###### removing the empty lines from the file
sed -i '/^$/d' $new_folder_name/multiple_single_line.fasta

#creating separate files for each genome with accession.fasta as their file name
while read line
do
        line1=$((line1+1))
        ###### fetching the accession from multiple fasta file
        grep "$line" $new_folder_name/multiple_single_line.fasta > $new_folder_name/$line1.fasta

        ###### making it multiline again
        sed -i -z "s/__/\n/g" $new_folder_name/$line1.fasta

        ###### removing spaces ( ) and slashes (/) with underscore (_)
        sed -i 's/\//_/g' $new_folder_name/$line1.fasta
        sed -i 's/\ /_/g' $new_folder_name/$line1.fasta
done < $accession_list
