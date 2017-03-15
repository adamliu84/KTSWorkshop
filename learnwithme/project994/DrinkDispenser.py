# "Software" version of the soda dispenser
# https://www.facebook.com/9gag/videos/10155472253936840/

from tkinter import *
from DispenserThread import DrinkThread

# Init dispenser thread
drinkThread = DrinkThread()
drinkThread.start()
drinkThread.pause()

# Button pressed event
def pressEvt(flavour):
    drinkThread.updateFlavour(flavour)
    drinkThread.resume()

# Button "released" event
def releaseEvt(event):
    drinkThread.pause()

# Overall UI
root = Tk()
frame = Frame(root, width=300)
root.title("JH Sugar Drink Disprenser")

# Various flavour button
b = Button(root, text="Cola")
b.bind("<Button-1>", lambda event: pressEvt("Cola"))
b.bind("<ButtonRelease-1>", releaseEvt)
b.pack()
b = Button(root, text="Fanta")
b.bind("<Button-1>", lambda event: pressEvt("Fanta"))
b.bind("<ButtonRelease-1>", releaseEvt)
b.pack()
b = Button(root, text="Sprite")
b.bind("<Button-1>", lambda event: pressEvt("Sprite"))
b.bind("<ButtonRelease-1>", releaseEvt)
b.pack()

# Start TK loop
frame.pack()
root.mainloop()
