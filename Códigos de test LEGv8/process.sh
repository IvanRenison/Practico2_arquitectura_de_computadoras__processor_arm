

FILE=$1

LONG=$(cat $FILE.list | grep -oP '\t[0-9a-f]{8}' | wc -l)

cat $FILE.list | grep -oP '\t[0-9a-f]{8}' | awk -v awkvar="$LONG" '{if (NR==1) {print "		rom [0:" awkvar-1 "] = \x27{\n			32\x27h" $1 ","} else { if (NR==awkvar){print "			32\x27h" $1 "\n		};"} else {print "			32\x27h" $1 ","}}}'


