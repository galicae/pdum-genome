SHELL=/usr/bin/env bash

index:
	grep -n "	gene	" chunks/* | cut -d"	" -f1,9 | cut -d";" -f1 | tr = : | awk -v OFS="\t" -F":" '{print $$4, $$2, $$1}' > chunk_index.tsv

# this is a bit of a hack; ideally I'd read the header as a dictionary and then use that to extract the relevant columns
lookup:
	grep ";name=" chunks/* | cut -d"	" -f9 | awk '{n=split($$0,A,";"); print A[1], A[n-1]}' | tr "=" " " | cut -f2,4 -d" " > slim_lookup.tsv

# this is a bit of a hack; ideally I'd read the header as a dictionary and then use that to extract the relevant columns
genes_named:
	grep "notator=" chunks/* | awk '{n=split($$0,A,"="); print A[n]}' | sort | uniq -c | sort -nr | awk '{$$1=$$1;print}' > genes_named.tsv