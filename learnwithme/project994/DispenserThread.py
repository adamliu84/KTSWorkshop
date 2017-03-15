import threading
import time

# Reference: http://stackoverflow.com/questions/33640283/python-thread-that-i-can-pause-and-resume
class DrinkThread(threading.Thread):
    def __init__(self):
        threading.Thread.__init__(self)
        self.pause_cond = threading.Condition(threading.Lock())
        self.paused = True
        self.flavour = ""

    def updateFlavour(self, flavour):
        self.flavour = flavour

    def run(self):
        while True:
            with self.pause_cond:
                while self.paused:
                    self.pause_cond.wait()
                #thread should do the thing if
                #not paused
                print('Dispening flavour :', self.flavour)
            time.sleep(0.05)

    def pause(self):
        self.paused = True
        # If in sleep, we acquire immediately, otherwise we wait for thread
        # to release condition. In race, worker will still see self.paused
        # and begin waiting until it's set back to False
        self.pause_cond.acquire()

    #should just resume the thread
    def resume(self):
        self.paused = False
        # Notify so thread will wake after lock released
        self.pause_cond.notify()
        # Now release the lock
        self.pause_cond.release()
