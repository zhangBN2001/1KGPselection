import sys,math
from scipy.stats import fisher_exact



if __name__ == '__main__' :
    counts_table = sys.argv[1]
    fh=open(counts_table)
    while True:
        line = fh.readline()
        if not line:
            break
        infs=line.split()
        counts=infs[2].split(';',)
        total=counts[-1].split(':',)
        out_line = str(infs[0]) + "\t" + str(infs[1]) + "\t"
        for idx in range(len(counts)-1):
            count   = counts[idx].split(':',)
            a,b,c,d = int(count[1]),int(total[1])-int(count[1]),int(count[2]),int(total[2])-int(count[2])
            ratio,pvalue = fisher_exact([[a, b], [c, d]], alternative='two-sided')
            pvalue  = -1 * math.log10(pvalue)
            out_line     = out_line +str(count[0]) + ":" + str(pvalue) + "\t"
        print(out_line)
