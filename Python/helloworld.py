# x = 1
# if x == 1:
#     print("x is 1.")
#
# myint = 20
# myfloat = 10.0
# mystring = "hello"
# if isinstance(myint, int) and myint == 20:
#     print("int: %d" % myint)
# if isinstance(myfloat, float) and myfloat == 10.0:
#     print("float: %f" % myfloat)
# if mystring == "hello":
#     print("string: " + mystring)
#
# mylist = []
# mylist.append("aaa")
# mylist.append(222)
# mylist.insert(1, 333)
# mylist.sort()
# for x in mylist:
#     print(x)
#
# string = "abcd" * 5
# print(string)
#
# even_numbers = [2, 4, 6, 8]
# odd_numbers = [1, 3, 5, 7]
# all_numbers = odd_numbers + even_numbers
# print(all_numbers)
#
# print([1, 2, 3] * 3)
#
# mylist = [[1, 2], [2, 3], [2, 2]]
# mylist2 = [mylist * 3, mylist, mylist.count([2, 2])]
# print(mylist2)
#
# name = "John"
# age = 23
# print("%s is %d years old." % (name, age))
#
#
# data = ("John", "Doe", 53.44)
# format_string = "Hello %s %s. Your current balance is $%s."
# print(format_string % data)
# astring = "HelloWorldThisisaTestofStringProcess"
# print(astring[3:17:2])

# astring = "Hello world!"
# print(astring[::-1])

# astring = "Hello world!"
# afewwords = astring.split(" ")
# afewwords.append("http")
# print(afewwords)

# name = "John"
# if name in ["Joh", "Rick"]:
#     print("Your name is either John or Rick.")
# elif "Rick" in ["John", "Rick"]:
#     print("yes")
# else:
#     print("no")

# x = 257
# y = 256 + 1
# print(x is y)
# y = x
# print(x is y)
#
# # Prints out the numbers 0,1,2,3,4
# for x in range(5):
#     print(x)
#
# Prints out 3,4,5
# for x in range(3, 6):
#     print(x)
#
# # Prints out 3,5,7
# for x in range(3, 8, 2):
#     print(x)


# def list_benefits():
#     return ["More organized code", "More readable code", "Easier code reuse",
#             "Allowing programmers to share and connect code together"]
#
#
# def build_sentence(benefit):
#     return "%s is a benefit of functions!" % benefit
#
#
# def name_the_benefits_of_functions():
#     list_of_benefits = list_benefits()
#     for benefit in list_of_benefits:
#         print(build_sentence(benefit))
#
#
# name_the_benefits_of_functions()
# print(list_benefits())
# define the Vehicle class
# class Vehicle:
#     name = ""
#     kind = "car"
#     color = ""
#     value = 100.00
#
#     def description(self):
#         desc_str = "%s is a %s %s worth $%.2f." % (
#             self.name, self.color, self.kind, self.value)
#         return desc_str
#
#
# # your code goes here
# car1 = Vehicle()
# car2 = Vehicle()
# car1.color = "red"
# car1.value = 60000.00
# car1.name = "Fer"
# car2.color = "blue"
# car2.name = "Jump"
# car2.value = 10000.00
#
# # test code
# print(car1.description())
# print(car2.description())
# import numpy as np
# # Create 2 new lists height and weight
# height = [1.87,  1.87, 1.82, 1.91, 1.90, 1.85]
# weight = [81.65, 97.52, 95.25, 92.98, 86.18, 88.45]
#
# # Create 2 numpy arrays from height and weight
# np_height = np.array(height)
# print(type(np_height))
# np_weight = np.array(weight)
#
# # Calculate bmi
# bmi = np_weight / np_height ** 2
#
# # Print the result
# print(bmi)
import pandas as pd
brics = pd.read_csv('transaction.csv')
print(brics)
