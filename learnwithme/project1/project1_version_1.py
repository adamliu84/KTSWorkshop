"""
For </Learn With Me> on Python Beginner Project #1!

【GOAL】
Create a program that prints out every line to the song "99 bottles of beer on the wall." 
This should be a pretty simple program, so to make it a bit harder, here are some rules to follow.

【RULES】
1. If you are going to use a list for all of the numbers, do not manually type them all in. Instead, use a built in function.
2. Besides the phrase "take one down," you may not type in any numbers/names of numbers directly into your song lyrics.
3. Remember, when you reach 1 bottle left, the word "bottles" becomes singular.
4. Put a blank line between each verse of the song.
https://www.reddit.com/r/beginnerprojects/comments/19kxre/project_99_bottles_of_beer_on_the_wall_lyrics/

【ADDITIONAL NOTE】
Based from Haskell quick protoyp implementation.
"""

import functools

bottleRange = range(99,-1,-1)

def bottleBeerCount(nCurBottle):
    if (0==nCurBottle):
        return "no more bottles of beer"
    else:
        szbottlePS = " bottles" if (1<nCurBottle) else " bottle"
        return str(nCurBottle) + szbottlePS + " of beer"

def onTheWall(nCurBottle):
    return bottleBeerCount(nCurBottle) + " on the wall"
    
def takeDown(nCurBottle):
    if (0==nCurBottle):
        return "Go to the store and buy some more, " + onTheWall(max(bottleRange)) + "."
    else:
        return "Take one down and pass it around, " + onTheWall(nCurBottle-1) + "."

def verse (nCurBottle):
    szFirstPart = onTheWall(nCurBottle).capitalize() + ", " + bottleBeerCount(nCurBottle) + "."
    szSecondPart = takeDown(nCurBottle)
    return szFirstPart + "\n" +szSecondPart +"\n\n"

if __name__ == "__main__":
    szSong = functools.reduce(lambda x,y : x + verse(y), bottleRange, "")
    print(szSong)
