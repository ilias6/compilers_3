***Ilias Kontonis***\
***1115201700055***

# Compilers - Project 3 - IR (LLVM) production 

## OffSets

A class that holds the offsets of the methods and the fields of each class is made.
Each ClassEntry object (from the previous part of the project) now, maintains the offsets
of its fields and methods. When inheritance occurs, we can access the offsets of the parent
class via the ClassEntry pointer to the super class.


## LLVMVisitor

This visitor generates the LLVM code. The class contains also a counter to enumerate unique
registers and one for the labels (one for all kind of labels: and/ while/ if-else). Also,
three HashMaps are used to keep info about the registers (e.g. the type of a register or 
the name of the identifier that corresponds to a register. Finally the whole output is hold in a string
of the class.
