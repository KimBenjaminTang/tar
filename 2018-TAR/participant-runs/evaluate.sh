#!/usr/local/Cellar/bash/4.4.19/bin/bash
# version-test.sh
echo $BASH_VERSION
echo "This script requires Bash 4+"

if true
then
    
echo "Processing each task1 result file"

if [ -e task1.out.all ]
then
    rm task1.out.all
fi


touch task1.out.all
echo "Run Total_Rel Rel_Found Avg_Last_Rel Perc_Last_Rel MAP recall@10 recall@20 recall@30 recall@40 recall@50 recall@100 recall@200 recall@300 recall@400 recall@500 recall@1000 recall@2000 recall@5000 recall@threshold threshold" > task1.out.all

for filename in $(find * | grep "task1$"); do
   echo $filename
   python ../../scripts/tar_eval_2018.py 1 ../Task1/Testing/qrels/task1.test.content.2018.qrels $filename > ${filename}".all.out"
   grep "ALL" ${filename}".all.out" > ${filename}".out"
   declare -A hashmap
   while read  qid metric score ; do
        hashmap["$metric"]="$score"
   done < ${filename}".out"
   echo "${filename} ${hashmap["num_rels"]} ${hashmap["rels_found"]} ${hashmap["last_rel"]} ${hashmap["norm_last_rel"]} ${hashmap["ap"]} ${hashmap["recall@10"]} ${hashmap["recall@20"]} ${hashmap["recall@30"]} ${hashmap["recall@40"]} ${hashmap["recall@50"]} ${hashmap["recall@100"]} ${hashmap["recall@200"]} ${hashmap["recall@300"]} ${hashmap["recall@400"]} ${hashmap["recall@500"]} ${hashmap["recall@1000"]} ${hashmap["recall@2000"]} ${hashmap["recall@5000"]} ${hashmap["recall_at_threshold"]} ${hashmap["recall_threshold"]}" >> task1.out.all
done

fi


