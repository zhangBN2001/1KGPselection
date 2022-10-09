for class in "c" "D" "E" "I" "U" "A" "d" "e" "i" "u";do
for fanwei in "0_0.1" "0.1_0.5" "0.5_1" "1_2";do
for bianyi in "SNV" "ID" "SV";do
echo $class $fanwei $bianyi
less -S $fanwei.$bianyi.$class.list|wc -l
done
done
done
