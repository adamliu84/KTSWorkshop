# Example 0 : Zen of Python
import this

# Example 1 : Hello World!
print("Hello World!")

# Example 2 : Multi value return aka Tuple
def tuple_return():
	return("String", 123,'A')
szAnimal, nNumber, cChar = tuple_return()
print(szAnimal, nNumber, cChar)

# Example 3 : List comprehension
lNum1 = range(12)
lNum2 = [x for x in lNum1 if x % 2 ==0]
lWordUpAndCount = [(w.upper(), len(w)) for w in "r Haskell Python Java".split()]
print(list(lNum1),"->",list(lNum2),"\n",lWordUpAndCount)

# Example 4: Map & Lambda
import math
lNum1 = range(2, 20, 3)
lNum2 = map(lambda x : round(math.sqrt(x),3), lNum1)
print(list(lNum1),"->",list(lNum2))

# Example 5: Filter & Lambda
lRemain = filter(lambda x: x not in ["K","V","A"], ["A","V","K","B"])
print(list(lRemain))

# Example 6: Generator
def generator_function():
	print("Start")
	for i in range(10):
		yield i
	print("End")
	yield
y = generator_function()
if(True):
	print(next(y))#0, start generator
	print(next(y))#1
	print(next(y))#2
	print(next(y))#3
	print(next(y))#4
	print(next(y))#5
	print(next(y))#6
	print(next(y))#7
	print(next(y))#8
	print(next(y))#9
	print(next(y))#10?

