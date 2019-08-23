def underscore_to_camelcase(value):
    def camelcase(): 
        yield str.lower
        while True:
            yield str.capitalize

    c = camelcase()
    return "".join(c.next()(x) if x else '_' for x in value.split("_"))

infile = "ptp4l.conf.erb"
outfile = "out.erb"

lines = []
with open(infile, 'r') as f:
    lines = f.readlines()
    
splitlines = []
for line in lines:
    splitlines.append(line.split())

newlines = []
for splitline in splitlines:
    print splitline[0]
    newstr = ""
    splitline[0] = underscore_to_camelcase(splitline[0])
    for element in splitline:
       newstr += element + " "
    newlines.append(newstr[:-1]+"\n")
    
with open(outfile, "w") as o:
    for line in newlines:
        o.write(line)

