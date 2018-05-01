# Write a function called generate_password that selects three random words from
# the list of words word_list and concatenates them into a single string. Your
# function should not accept any arguments and should reference the global
# variable word_list to build the password.


import random

word_file = "words.txt"
word_list = []

#fill up the word_list
with open(word_file,'r') as words:
	for line in words:
		# remove white space and make everything lowercase
		word = line.strip().lower()
		# don't include words that are too long or too short
		if 3 < len(word) < 8:
			word_list.append(word)

def generate_password():
    return random.choice(word_list) + random.choice(word_list) + random.choice(word_list)

# Alternative method:
# def generate_password():
#     return ''.join(random.sample(word_list,3))

print(generate_password())
