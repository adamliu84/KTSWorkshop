import random
from enum import Enum

class CPet(object):
    
    def __init__(self, szName, szShortRangeATK, szLongRangeATK, szHeal, nHp=100):
        self.name =szName
        self.shortRangeATKName = szShortRangeATK
        self.longRangeATKName = szLongRangeATK
        self.healName = szHeal
        self.hp = nHp
        self.maxhp = nHp
   
    def _moveRange(self, x):
        return(random.randrange(x[0],x[1]+1))
   
    def attack(self, cTarPet, nType=1):            
        if(1==nType):
            szAtkname = self.shortRangeATKName
            nAtkvalue = self._moveRange(CPet.SHORT_RANGE())
            cTarPet.receiveDMG(nAtkvalue)           
        if(2==nType):
            szAtkname = self.longRangeATKName
            nAtkvalue = self._moveRange(CPet.LONG_RANGE())
            cTarPet.receiveDMG(nAtkvalue)            
        return(szAtkname, nAtkvalue)
    
    def heal(self):           
        nValue = self._moveRange(CPet.HEAL_RANGE())
        self.hp += nValue
        if(self.hp > self.maxhp):
            self.hp = self.maxhp
        return (self.healName, nValue)        
   
    def receiveDMG(self, nDMG):
        self.hp -= nDMG
        if(self.hp < 0):
            self.hp = 0
   
    def isDead(self):
        return True if (0==self.hp) else False
   
    @staticmethod
    def SHORT_RANGE():
        return(18,25)
        
    @staticmethod    
    def LONG_RANGE():
        return(10,35)
        
    @staticmethod    
    def HEAL_RANGE():
        return(18,25)
 
class CNPCPet(CPet):

    def __init__(self, szName, szShortRangeATK, szLongRangeATK, szHeal, nHp=100):      
        super().__init__(szName, szShortRangeATK, szLongRangeATK, szHeal, nHp)                
    
    def dicerollAction(self):
        # If HP is max ignore heal
        if(self.hp == self.maxhp):
            nMoveIndex = random.randrange(1,3)
        else:
            # Dice roll action, if hp is less than 35%, trance mode        
            nMoveIndex = random.randrange(1,4)
            if(self.isTrance()):
                nMoveIndex = random.randrange(1,5)
        # Dice roll action    
        if(nMoveIndex in [1]):
            return (CNPCMove.SHORT_RANGE_ATK)
        if(nMoveIndex in [2]):                
            return (CNPCMove.LONG_RANGE_ATK)
        if(nMoveIndex in [3,4]):                
            return (CNPCMove.HEAL)
 
    # Trance mode when current hp is equal & less than 35%
    def isTrance(self):
        if(self.hp <= (self.maxhp * 0.35)):
            return True
        else:
            return False
 
class CNPCMove(Enum):
    SHORT_RANGE_ATK = 1    
    LONG_RANGE_ATK = 2
    HEAL = 3