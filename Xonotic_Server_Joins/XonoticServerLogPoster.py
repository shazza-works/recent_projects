#!/usr/bin/python3
#
#
#
import time
import regex
import re
from discord_webhook import DiscordWebhook, DiscordEmbed



def make_webhook(url, title, desc, colour, footer_text, user):
	embed = DiscordEmbed(title=title, description=desc, color=colour)
	embed.set_footer(text=footer_text)
	webhook = DiscordWebhook(url=url, username=user)
	webhook.add_embed(embed)
	response = webhook.execute()
	return response



# Xonotic Chan Hook
url = "YOUR HOOK URL HERE"
username = "@Shazza-Works"
title = "_Xonotic_Server_Info_"
footer_text = "Come Join The Game !!"
colour = "FF0000"
filename = "/home/shazza/my.log"



while True:
	f = open(filename, "r+")
	lines = f.readlines()
	f.close()
	# wipe file
	open(filename, 'w').close()
	out = []
	for x in lines:
		m = regex.search("connected", x)
		if m:
			out.append(m.string)
	else:
		time.sleep(90)
		pass
	if not len(out) == 0:
		descrip = "\n".join(out)
		ansi_escape = re.compile(r'\x1B(?:[@-Z\\-_]|\[[0-?]*[ -/]*[@-~])')
		descrip = ansi_escape.sub('', descrip)
		print (descrip)
		make_webhook(url, title, descrip, colour, footer_text, username)
