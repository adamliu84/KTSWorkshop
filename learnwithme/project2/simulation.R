MAX_HP = 100
NUM_SIMULATION = 100

###################################
#     FUNCTION
####################################
shortRangeATK <- function(){
  return(sample(18:25, 1))
}

longRangeATK <- function(){
  return(sample(10:35, 1))
}

healRange <- function(){
  return(sample(18:25, 1))
}


initRound <- function(){
  dfBattle = data.frame(round=integer(), playerhp=integer(),npchp=integer(), playeraction=character(0), npcaction=character(0))
  dfBattle <- rbind(dfBattle, data.frame(round=0, playerhp=MAX_HP, npchp=MAX_HP, playeraction="init", npcaction="init"))  
}

####################################
fightRound <- function(dfBattle, playersimulation=list(short=c(1,2,3), long=c(4,5,6))){
  previousRound <- tail(dfBattle, 1)
  curRound <- as.integer(previousRound["round"])
  playerhp <- as.integer(previousRound["playerhp"])
  npchp <- as.integer(previousRound["npchp"])
  
  # Assume player always have the first move in a round
  nPlayerdice <- playerdicemove(dfBattle, playersimulation)
  # Pos# deal damage to opp, Neg# heal self
  if(nPlayerdice$value < 0){
    npchp <- max(0, npchp + nPlayerdice$value)
  }else{
    playerhp <- min(MAX_HP, playerhp + nPlayerdice$value)
  }  
  
  # Assuming player move at start of each round, requrie to check if npc still alive to perform additional action
  if(npchp <= 0){
    npcaction <- "End"
  }else{    
    nNpcdice <- npcdicemove(dfBattle)
    # Pos# deal damage to opp, Neg# heal self
    if(nNpcdice$value < 0){
      playerhp <- max(0, playerhp + nNpcdice$value)
    }else{
      npchp <- min(MAX_HP, npchp + nNpcdice$value)
    }
    npcaction <- paste0(nNpcdice$action,"|",nNpcdice$value)
  }
  
  
  dfBattle <- addRound(dfBattle, curRound+1, playerhp, npchp, paste0(nPlayerdice$action,"|",nPlayerdice$value), npcaction)
  return(dfBattle)
}

addRound <- function(dfBattle, newround, newplayerhp, newnpchp, newplayeraction, newnpcaction){  
  return (rbind(dfBattle,data.frame(round=newround, playerhp=newplayerhp, npchp=newnpchp, playeraction=newplayeraction, npcaction=newnpcaction)))
}

isEndRound <- function(dfBattle){
  previousRound <- tail(dfBattle, 1)
  if(0 >= previousRound["playerhp"] || 0 >= previousRound["npchp"]){
    return(TRUE)
  }else{
    return(FALSE)
  }
}

####################################
npcdicemove <- function(dfBattle){
  previousRound <- tail(dfBattle, 1)
  if(previousRound["npchp"] > 0.35 * MAX_HP){
    nChoice <- sample(1:3, 1)  
  }else{
    nChoice <- sample(1:4, 1)  
  }
  if(1==nChoice){
    return(list(action="short_atk", value=-1*shortRangeATK()))
  } else if (2==nChoice) {
    return(list(action="long_atk", value=-1*longRangeATK()))
  } else { # Ignore full hp, will still cast heal
    return(list(action="heal", value=healRange()))
  }  
}

playerdicemove <- function(dfBattle, playersimulation){
  #dfBattle not used for the moment
  nRandom <- sample(1:9, 1)
  
  #For short range probability
  if(nRandom %in% playersimulation$short){
    return(list(action="short_atk", value=-1*shortRangeATK()))
  }
  #For long range probability
  else if (nRandom %in% playersimulation$long){
    return(list(action="long_atk", value=-1*longRangeATK()))
  }
  #For heal probability (fall thru case) Ignore full hp, will still cast heal
  else{
    return(list(action="heal", value=healRange()))
  }
}

####################################
battleSummary <- function(dfBattle){
  # Who won
  szWinner = ""
  if(0==tail(dfBattle,1)$playerhp){
    szWinner = "N"
  }else if (0==tail(dfBattle,1)$npchp){
    szWinner = "P"
  }
  
  # Number of round
  nRound = nrow(dfBattle)-1
  
  return(list(winner=szWinner, rounds=nRound))
}

addBattleResult <- function(type,dfBattle){  
  lResult <- battleSummary(dfBattle)
  return (rbind(dfSimulation,data.frame(type=type, winner=lResult$winner, rounds=lResult$rounds)))
}

###################################
#     MAIN
####################################
# Type of player action
type0 = list(type="Balance of atk & heal", dicedata=list(short=c(1,2,3), long=c(4,5,6)))
type1 = list(type="Focus on short range", dicedata=list(short=c(1,2,3,4,5), long=c()))
type2 = list(type="Focus on long range", dicedata=list(short=c(), long=c(1,2,3,4,5)))
type3 = list(type="Attack only", dicedata=list(short=c(1,2,3,4,5), long=c(6,7,8,9)))
type4 = list(type="Focus on heal", dicedata=list(short=c(1), long=c(2)))
typelisting = list(type0, type1, type2 , type3, type4)

# Simulation run
dfSimulation <- data.frame(type=character(0), winnner=character(0) ,rounds=integer())
for (type in typelisting){  
  for(i in 1:NUM_SIMULATION){        
    dfBattle <- initRound()
    while(!isEndRound(dfBattle)){
      dfBattle <- fightRound(dfBattle, playersimulation=type$dicedata[])
    }
    dfSimulation <- addBattleResult(type$type,dfBattle)
  }
}

# Report generation
lSimType <- split(dfSimulation, dfSimulation$type)
pdf("samplereport.pdf")
par(mfrow = c(3, 2))  # 3 rows and 2 columns
for(type in lSimType){
  mean(type$rounds)
  szTitle = paste0(type$type[1], "\nAverage rounds:", mean(type$rounds))
  pie(table(type$winner), main=szTitle)
}
dev.off()