.data
list: .word 01,02,03,04,05,06,
            07,08,09,10,12,14,
            15,16,18,20,21,24,
            25,27,28,30,32,35,
            36,40,42,45,48,49,
            54,56,63,64,72,81
size: .word 36
welcome_message: .asciiz "Welcome to the multiplication game !\n"
newline: .asciiz "\n"
space: .asciiz " "
divider: .asciiz "------------------\n"
numOne: .asciiz "Number 1: "
numTwo: .asciiz "Number 2: "
enterNumOne: .asciiz "Enter Number 1: "
enterNumTwo: .asciiz "Enter Number 2: "
initialTwo: .asciiz "Number 2: null\n"
num1: .word 0
num2: .word 0
pNum1: .word 0
pNum2:.word 0
prompt: .asciiz "Choose an option:\n1. Enter Number 1\n2. Enter Number 2\n"
result:  .asciiz "The product is: "
error_message1: .asciiz "Invalid move. Number must be from 1-9. Please try again\n"
error_message2: .asciiz "Invalid move. Square is already taken. Please try again\n"
computerChoice: .word 0
userWin: .asciiz "Congrats on Winning!You got 4 in a row before the computer"
computerWin: .asciiz "You lost. The computer got 4 in a row before you"