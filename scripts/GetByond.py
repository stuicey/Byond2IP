#!/usr/bin/python
# Script to generate a list of [Server Name]:[World Address] in ./config/worlds.txt from the given Byond Hub $URL
import os, urllib2, re

def getByondHub(url = 'http://www.byond.com/games/Exadv1/SpaceStation13'):
	return urllib2.urlopen(url+'?format=text').read()

def main():
	# Make sure script is executed in ./scripts
	abspath = os.path.abspath(__file__)
	os.chdir(os.path.dirname(abspath))

	# Download the server listing page
	pageContent = getByondHub()
	
	# Find all the world addresses and server names from pageContent
	worldRegList = re.findall(r"""world\/\d{1,}.+?url \= \"byond\:\/\/BYOND\.world\.(\d{8,})\".+?status \= \"(\<.+?)\players""", pageContent, re.S)
	worldBuff = list()
	
	# Clean up the server name to remove the garbage flairs
	for server in worldRegList:
		worldBuff.append([server[0], re.search(r"\<b\>(?:\<.+?\>\-?\-?)?\\?(.+?)[\<|\-|\:|\\|\&|\(]", server[1]).group(1).strip()])
	
	# Delete worlds.txt if it exists already
	try:
		os.remove('../config/worlds.txt')
	except OSError:
		pass

	# Save the worldBuff to ./config/worlds in format [Servername]:[World Address]
	file = open('../config/worlds.txt','w')
	for line in worldBuff:
		# line[] internally stored backwards as [(worldaddress, servername)]
		file.write(line[1] + ":" + line[0] + '\n')
	file.close()

if __name__ == '__main__':
  main()

