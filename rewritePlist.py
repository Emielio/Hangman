
plistFile = open("Hangman/words.plist", "r")

t = 0

offset = len("	<string></string>\n")


plistArray = [[] for i in range(25)]

for line in plistFile:
	if t > 30:
		break

	if "<string>" in line:
		print line
		plistArray[len(line) - offset].append(line)

	t += 1

for i, plist in enumerate(plistArray):
	if plist:
		for item in plist:
			f = open("Hangman/words" + str(i) + ".plist", "a")

			f.write(item)

			f.close()