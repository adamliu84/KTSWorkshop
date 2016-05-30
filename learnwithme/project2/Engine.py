# "python Engine.py" to start the game

from CPet import *

# Init 2 NPC pet & round index
playerPet = CPet("Ace Attorney", "Take that!", "Objection", "Hold it")
npcPet = CNPCPet("Pikachu", "Tail Whip", "Spark", "Refresh")
nRound = 1

def performAtk(cSrcPet, cTarPet, cType):
    if(cSrcPet.isDead()):
        return
    tAtk = cSrcPet.attack(cTarPet, cType)
    print(cSrcPet.name + " use " + tAtk[0] + " on " + cTarPet.name + ", dealing " + str(tAtk[1]) + " damange")    
    
def performHeal(cSrcPet):
    if(cSrcPet.isDead()):
        return
    tHeal = cSrcPet.heal()
    print(cSrcPet.name + " use " + tHeal[0] + " on self, recovering "+ str(tHeal[1]))
    
def playerRoundMove():

    # Print current pets status & move selection during player move
    print("{0} at HP: {1}/{2}".format(playerPet.name, playerPet.hp, playerPet.maxhp))
    print("{0} at HP: {1}/{2}".format(npcPet.name, npcPet.hp, npcPet.maxhp))    
    print("[1] Perform short range attack {0}".format(playerPet.shortRangeATKName))    
    print("[2] Perform long range attack {0}".format(playerPet.longRangeATKName))
    print("[3] Perform healing {0}".format(playerPet.healName))
    response = input("Enter your move:")
    if("1"==response):
        performAtk(playerPet, npcPet, 1)   
    elif("2"==response):
        performAtk(playerPet, npcPet, 2)
    elif("3"==response):
        performHeal(playerPet)    
        
def npcRoundMove():
    randomNpcAction = npcPet.dicerollAction()
    if(CNPCMove.SHORT_RANGE_ATK == randomNpcAction):
        performAtk(npcPet, playerPet, 1)
    elif(CNPCMove.LONG_RANGE_ATK == randomNpcAction):
        performAtk(npcPet, playerPet, 2)
    elif(CNPCMove.HEAL == randomNpcAction):
        performHeal(npcPet)
    
# Main game loop
while True: 

    print("===========ROUND %1d===========" % nRound)
    nRound += 1

    # Random first movement per round between player & npc
    if(bool(random.getrandbits(1))):
        print("Player move first")
        playerRoundMove()
        if(not npcPet.isDead()):
            npcRoundMove()
    else:
        print("NPC move first")
        npcRoundMove()
        if(not playerPet.isDead()):
            playerRoundMove()       
    
    print("Player Pet HP [{0}] | NPC Pet HP [{1}]".format(playerPet.hp, npcPet.hp))
    if(playerPet.isDead() or npcPet.isDead()):
        if(playerPet.isDead()):
            print("You lose")
        elif(npcPet.isDead()):
            print("You win")
        break