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
A more OO approach comparsion to the Haskell & first python functional approach
"""

class WallState:
    
    def MAX_BOTTLE_OF_BEER():
        return 99
    
    def __init__(self, nBottle):
        self.nBottle = nBottle
    
    def _bottleBeerCount(self):
        if (0==self.nBottle):
            return "no more bottles of beer"
        else:
            szbottlePS = " bottles" if (1<self.nBottle) else " bottle"
            return str(self.nBottle) + szbottlePS + " of beer"

    def _partOne(self):
        return str(self._bottleBeerCount()).capitalize() + " on the wall, " + self._bottleBeerCount() + "."
        
    def _partTwo(self):
        if (0==self.nBottle):
            temp = WallState(WallState.MAX_BOTTLE_OF_BEER())
            return "Go to the store and buy some more, " + temp._bottleBeerCount() + " on the wall."
        else:
            temp = WallState(self.nBottle-1)
            return "Take one down and pass it around, " + temp._bottleBeerCount() + " on the wall."
     
    def verse(self): 
        return self._partOne() + "\n" + self._partTwo() + "\n"

def WallStateGenerator():
    for i in range(WallState.MAX_BOTTLE_OF_BEER(),-1,-1):
        yield(WallState(i))

if __name__ == "__main__":
    wallStateGenerator = WallStateGenerator()
    for wallState in wallStateGenerator:
        print(wallState.verse())