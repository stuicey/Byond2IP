/world/proc/file2list(filename, seperator="\n")
	return splittext(file2text(filename),seperator)

/world/New()
	// Get the base list [name]:[worldID]
	var list = file2list("config/worlds.txt")

	// Delete the previous netstat.log*
	shell("echo '' > data/.netstat.log.bak")
	shell("echo '' > data/ips.log")

	for(var/item in list)
		if(!item)	break
		world.log << "Checking " + item 
		
		// For each item in [list] ping the byond world address
		// world Export doesn't handle timeouts?? so spawn(0) it for non-blocking connection
		var result = world.Export("byond://BYOND.world." + splittext(item, ":")[2] + "?ping", 1)
		if(!result)	continue

		// Check netstat to reveal the real IP address
		shell("sh scripts/GetIP.sh " + splittext(item, ":")[1])
	
	world.log << "Done now!"
	shutdown()
