# Facebook friend who post the following & <Mr. Robot Season 2, Episode 11>, ROT13 cipher   
# trigger me to create a Haskell script to comb list of english words that fulfil the requirement
# https://www.reddit.com/r/todayilearned/comments/2x3gea/til_that_if_you_take_all_the_letters_from_the/
# Original Haskell version: https://github.com/adamliu84/KTSWorkshop/blob/master/learnwithme/project999/Til.hs

import urllib.request
import csv
import io

def parseOnlineCSV():
    url = "https://raw.githubusercontent.com/eneko/data-repository/master/data/words.txt"
    pageResponse = urllib.request.urlopen(url)
    awords = csv.reader(io.TextIOWrapper(pageResponse))
    return awords

def checkrevword(temp):
    word = temp[0].lower()
    revword = ''.join(list(map(revrot, word)))
    compareword = revword[::-1] #http://stackoverflow.com/questions/931092/reverse-a-string-in-python  
    return (word == compareword)

def revrot(singlechar):
    charord = ord(singlechar)
    if charord >= 97 and charord <= 110:
        return(chr(122 - (charord-97)))
    elif charord > 111 and charord <= 122:
        return(chr(97 + (122-charord)))
    else:
        return(singlechar)
    
awords = parseOnlineCSV()
aresult = filter(checkrevword, awords)
for row in aresult:
    print(row)