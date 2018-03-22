import string

head=True
with open("/g/db/2/results/fairspan.csv") as f:
	with open("/g/db/2/results/fairspan_mod.csv","r+") as f_mod:
		for line in f:
			if head:
				head=False
			elif "NULL" not in line:
				a,b=line.rsplit(",",1)
				b=b.rstrip()
				b=b.replace("_",",")
				b="\"{"+b+"}\"\n"
				line=a+","+b
			f_mod.write(line)
