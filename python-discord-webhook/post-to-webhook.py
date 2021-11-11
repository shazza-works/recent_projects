#!/usy/bin/python3
#
# Shazza-Works
#
#

import sys
from discord_webhook import DiscordWebhook, DiscordEmbed


def make_webhook(url, title, desc, colour, footer, user):
	embed = DiscordEmbed(title=title, description=desc, color=colour)
	embed.set_footer(text=footer)
	webhook = DiscordWebhook(url=url, username=user)
	webhook.add_embed(embed)
	response = webhook.execute()
	return response




url = input("Hook URL: ")
username = input("Username: ")
title = input("Title: ")
description = input("Description: ")
footer_text = input("Footer: ")
colour = input("Colour: ")

resp = make_webhook(url, title, description, colour, footer_text, username)

print (resp)

sys.exit(0)
