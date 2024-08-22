.include  "data_section.asm"


.text
main:
  li $v0, 4
  la $a0, newline
  syscall

  # Print the welcome message
  li $v0, 4
  la $a0, welcome_message
  syscall

  la $a0, list
  lw $a1, size
  jal print_grid

  li $a1, 9
  li $v0, 42
  syscall
  sw $a0, num1
  lw $t1, num1
  addi $t1, $t1, 1
  sw $t1, num1
  sw $t1, pNum1

start:
  # Print both numbers
  li $v0, 4
  la $a0, numOne
  syscall

  lw $a0, num1
  li $v0, 1
  syscall

  # Add a newline character
  li $v0, 11
  li $a0, 10
  syscall

  li $v0, 4
  la $a0, numTwo
  syscall

  lw $a0, num2
  li $v0, 1
  syscall

  li $v0, 4
  la $a0, newline
  syscall

  # Print menu for user choice
  li $v0, 4
  la $a0, prompt
  syscall

  # Prompt user for choice
  li $v0, 5
  syscall

  # Check user choice
  beq $v0, 1, enter_num1
  beq $v0, 2, enter_num2
  j start  # Repeat loop if choice is neither 1 nor 2

enter_num1:
  # Prompt user for num1
  li $v0, 4
  la $a0, enterNumOne
  syscall

  # Get user input for num1
  li $v0, 5
  syscall

  # Validate input for num1 (between 1 and 9)
  blt $v0, 1, invalid_input_num1
  bgt $v0, 9, invalid_input_num1
  lw $t1, num1
  sw $t1, pNum1
  sw $v0, num1
  j continue_start

invalid_input_num1:
  # Print an error message for invalid input
  li $v0, 4
  la $a0, newline
  syscall

  li $v0, 4
  la $a0, error_message1
  syscall
  j start

continue_start:
  # Multiplying 2 numbers
  lw $t1, num1  # Load num1
  lw $t0, num2  # Load num2
  mul $t2, $t0, $t1  # Multiply num1 and num2, store result in $t
  add $t5, $t2, $zero

  la $t0, list
  li $t3, 0  # Initialize index counter to 0

find_index1_loop:
  lw $t4, 0($t0)  # Load current element in the list

  # Compare the current element with the product
  beq $t4, $t2, found_index1

  addi $t3, $t3, 1  # Increment index counter
  addi $t0, $t0, 4  # Move to the next element

  # Check if we have reached the end of the list
  beq $t3, 36, invalid_move_num1

  j find_index1_loop

found_index1:
  # Store the index where the product is located
  move $t1, $t3

  # Update the list with the product
  la $t0, list
  li $t3, 4
  mul $t1, $t1, $t3
  add $t0, $t0, $t1
  li $t2, 11
  sw $t2, 0($t0)


  # Print the result
  li $v0, 4
  la $a0, result
  syscall

  # Print the result value
  li $v0, 1
  move $a0, $t5
  syscall

  # Add a newline character
  li $v0, 11
  li $a0, 10
  syscall

#Check for user win here
  
#computer move here
j computer_move

#check for computer win

  la $a0, list
  lw $a1, size
  jal print_grid
  
  j start

invalid_move_num1:

lw $t1, pNum1
sw $t1, num1

# Add a newline character
  li $v0, 11
  li $a0, 10
  syscall
  
  li $v0, 4
  la $a0, error_message2
  syscall

  j start  # Repeat the loop

enter_num2:
# Prompt user for num2
  li $v0, 4
  la $a0, enterNumTwo
  syscall

  # Get user input for num2
  li $v0, 5
  syscall

  # Validate input for num2 (between 1 and 9)
  blt $v0, 1, invalid_input_num2
  bgt $v0, 9, invalid_input_num2
  lw $t1, num2
  sw $t1, pNum2
  sw $v0, num2
  
  
  j continue_start_2

invalid_input_num2:
  # Print an error message for invalid input
  li $v0, 4
  la $a0, newline
  syscall
  li $v0, 4
  la $a0, error_message1
  syscall
  j start
  
  continue_start_2:
  
   # Multiplying 2 numbers
  lw $t1, num1  # Load num1
  lw $t0, num2  # Load num2
  mul $t2, $t0, $t1  # Multiply num1 and num2, store result in $t
  add $t5, $t2, $zero
  
  # Find the index where the product is located in the list
  la $t0, list
  li $t3, 0  # Initialize index counter to 0

find_index2_loop:
  lw $t4, 0($t0)  # Load current element in the list

  # Compare the current element with the product
  beq $t4, $t2, found_index2

  addi $t3, $t3, 1  # Increment index counter
  addi $t0, $t0, 4  # Move to the next element
  
  beq $t3, 36, invalid_move_num2
  
  j find_index2_loop
  

found_index2:

  # Store the index where the product is located
  move $t1, $t3

  # Update the list with the constant value 11
  la $t0, list
  li $t3, 4
  mul $t1, $t1, $t3
  add $t0, $t0, $t1
  li $t2, 11
  sw $t2, 0($t0)

  # Print the result
  li $v0, 4
  la $a0, result
  syscall

  # Print the result value
  li $v0, 1
  move $a0, $t5
  syscall

# Add a newline character
  li $v0, 11
  li $a0, 10
  syscall
  
  j computer_move
  
  #Check for user win here
  
  #computer move here
  computer_move:
  li $a1, 2
  li $v0, 42
  syscall
  addi $a0, $a0, 1
  sw $a0, computerChoice
  
  
  beq $a0, 1, enter_num1npc
  beq $a0 2, enter_num2npc
  
  
  enter_num1npc:

#generate random number from 1-10
  li $a1, 9
  li $v0, 42
  syscall
  addi $a0, $a0, 1
  sw $a0, num1
  
  
  lw $t1, num1  # Load num1
  lw $t0, num2  # Load num2
  mul $t2, $t0, $t1  # Multiply num1 and num2, store result in $t
  add $t5, $t2, $zero

  la $t0, list
  li $t3, 0  # Initialize index counter to 0

find_computer1_loop:
  lw $t4, 0($t0)  # Load current element in the list

  # Compare the current element with the product
  beq $t4, $t2, found_computer1

  addi $t3, $t3, 1  # Increment index counter
  addi $t0, $t0, 4  # Move to the next element

  # Check if we have reached the end of the list
  beq $t3, 36, invalid_computer1

  j find_computer1_loop

found_computer1:
  # Store the index where the product is located
  move $t1, $t3

  # Update the list with the product
  la $t0, list
  li $t3, 4
  mul $t1, $t1, $t3
  add $t0, $t0, $t1
  li $t2, 22
  sw $t2, 0($t0)
  
  la $a0, list
  lw $a1, size
  jal print_grid
  
  j horizontal_check
  
  invalid_computer1:
lw $t1, pNum1
sw $t1, num1

  j computer_move  # Repeat the loop
  
  
  enter_num2npc:

#generate random number from 1-10
  li $a1, 9
  li $v0, 42
  syscall
  addi $a0, $a0, 1
  sw $a0, num2
 
  
  lw $t1, num1  # Load num1
  lw $t0, num2  # Load num2
  mul $t2, $t0, $t1  # Multiply num1 and num2, store result in $t
  add $t5, $t2, $zero

  la $t0, list
  li $t3, 0  # Initialize index counter to 0

find_computer2_loop:
  lw $t4, 0($t0)  # Load current element in the list

  # Compare the current element with the product
  beq $t4, $t2, found_computer2

  addi $t3, $t3, 1  # Increment index counter
  addi $t0, $t0, 4  # Move to the next element

  # Check if we have reached the end of the list
  beq $t3, 36, invalid_computer2

  j find_computer2_loop

found_computer2:
  # Store the index where the product is located
  move $t1, $t3

  # Update the list with the product
  la $t0, list
  li $t3, 4
  mul $t1, $t1, $t3
  add $t0, $t0, $t1
  li $t2, 22
  sw $t2, 0($t0)
  
  la $a0, list
  lw $a1, size
  jal print_grid
  
horizontal_check:
  
  la $a1, list           # Load address of the list
    li $a2, 11             # Set the target value to find (11)
    li $a3, 4              # Set the number of consecutive occurrences to find

    lw $t4, size           # Load the size of the list
    
    li $t0, 0              # Initialize counter for consecutive occurrences
    li $t1, 0              # Initialize index variable
    
check_consecutive:
    bge $t1, $t4, go_next  # Terminate loop if we have reached the end of the list

    lw $t2, 0($a1)         # Load the current element from the list

    beq $t2, $a2, found     # Check if the current element is equal to the target value
    j not_found            # Jump to not_found if not equal

found:
    addi $t0, $t0, 1        # Increment consecutive occurrences counter
    beq $t0, $a3, consecutive_found  # Check if the required consecutive occurrences are found
    j next_element         # Jump to the next element

consecutive_found:
    la $a0, userWin  # Load address of the consecutive message
    li $v0, 4              # Print string syscall
    syscall
    
    j after_consecutive_found  # Jump to a label after the consecutive occurrences are found
    
not_found:
    j reset_counters       # Jump to reset_counters
    
not_found_message:

    
reset_counters:
    li $t0, 0              # Reset consecutive occurrences counter
    j next_element         # Jump to the next element
    
next_element:
    addi $a1, $a1, 4        # Move to the next element in the list
    addi $t1, $t1, 1        # Increment index variable
    j check_consecutive    # Jump to check_consecutive
    
go_next:
#User right diagonal check
la $t0, list

    # Get the length of the array
    li $t1, 36  # Number of elements in the array

    # Check for "4 in a row"
    lw $t2, 0($t0)        # Load the first element
    lw $t3, 28($t0)       # Load the eighth element
    lw $t4, 56($t0)       # Load the fifteenth element
    lw $t5, 84($t0)       # Load the twenty-second element

    beq $t2, 11, check_next
    j try_next1

check_next:
    beq $t3, 11, check_next2
    j try_next1

check_next2:
    beq $t4, 11, check_next3
    j try_next1

check_next3:
    beq $t5, 11, consecutive_found
    j try_next1
    
try_next1:
# Check for "4 in a row"

    lw $t2, 28($t0)        # Load the first element
    lw $t3, 56($t0)       # Load the eighth element
    lw $t4, 84($t0)       # Load the fifteenth element
    lw $t5, 112($t0)       # Load the twenty-second element

    beq $t2, 11, check_next4
    j try_next2

check_next4:
    beq $t3, 11, check_next5
    j try_next2

check_next5:
    beq $t4, 11, check_next6
    j try_next2

check_next6:
    beq $t5, 11, consecutive_found
    j try_next2
    
try_next2:

    lw $t2, 56($t0)        # Load the first element
    lw $t3, 84($t0)       # Load the eighth element
    lw $t4, 112($t0)       # Load the fifteenth element
    lw $t5, 140($t0)       # Load the twenty-second element

    beq $t2, 11, check_next7
    j try_next3

check_next7:
    beq $t3, 11, check_next8
    j try_next3

check_next8:
    beq $t4, 11, check_next9
    j try_next3

check_next9:
    beq $t5, 11, consecutive_found
    j try_next3
    
try_next3:


    lw $t2, 48($t0)        # Load the first element
    lw $t3, 76($t0)       # Load the eighth element
    lw $t4, 104($t0)       # Load the fifteenth element
    lw $t5, 132($t0)       # Load the twenty-second element

    beq $t2, 11, check_next10
    j try_next4

check_next10:
    beq $t3, 11, check_next11
    j try_next4

check_next11:
    beq $t4, 11, check_next12
    j try_next4

check_next12:
    beq $t5, 11, consecutive_found
    j try_next4


try_next4:

    lw $t2, 24($t0)        # Load the first element
    lw $t3, 52($t0)       # Load the eighth element
    lw $t4, 80($t0)       # Load the fifteenth element
    lw $t5, 108($t0)       # Load the twenty-second element

    beq $t2, 11, check_next13
    j try_next5

check_next13:
    beq $t3, 11, check_next14
    j try_next5

check_next14:
    beq $t4, 11, check_next15
    j try_next5

check_next15:
    beq $t5, 11, consecutive_found
    j try_next5

try_next5:


    lw $t2, 52($t0)        # Load the first element
    lw $t3, 80($t0)       # Load the eighth element
    lw $t4, 108($t0)       # Load the fifteenth element
    lw $t5, 136($t0)       # Load the twenty-second element

    beq $t2, 11, check_next16
    j try_next6

check_next16:
    beq $t3, 11, check_next17
    j try_next6

check_next17:
    beq $t4, 11, check_next18
    j try_next6

check_next18:
    beq $t5, 11, consecutive_found
    j try_next6
    
try_next6:


    lw $t2, 4($t0)        # Load the first element
    lw $t3, 32($t0)       # Load the eighth element
    lw $t4, 60($t0)       # Load the fifteenth element
    lw $t5, 88($t0)       # Load the twenty-second element

    beq $t2, 11, check_next19
    j try_next7

check_next19:
    beq $t3, 11, check_next20
    j try_next7

check_next20:
    beq $t4, 11, check_next21
    j try_next7

check_next21:
    beq $t5, 11, consecutive_found
    j try_next7
    
try_next7:


    lw $t2, 32($t0)        # Load the first element
    lw $t3, 60($t0)       # Load the eighth element
    lw $t4, 88($t0)       # Load the fifteenth element
    lw $t5, 116($t0)       # Load the twenty-second element

    beq $t2, 11, check_next22
    j try_next8

check_next22:
    beq $t3, 11, check_next23
    j try_next8

check_next23:
    beq $t4, 11, check_next24
    j try_next8

check_next24:
    beq $t5, 11, consecutive_found
    j try_next8
    
try_next8:

    lw $t2, 8($t0)        # Load the first element
    lw $t3, 36($t0)       # Load the eighth element
    lw $t4, 64($t0)       # Load the fifteenth element
    lw $t5, 92($t0)       # Load the twenty-second element

    beq $t2, 11, check_next25
     j go_next1

check_next25:
    beq $t3, 11, check_next26
     j go_next1

check_next26:
    beq $t4, 11, check_next27
    j go_next1

check_next27:
    beq $t5, 11, consecutive_found
    j go_next1


go_next1:
    la $t0, list

    # Get the length of the array
    li $t1, 36  # Number of elements in the array

    # Check for "4 in a row" from right to left
    lw $t2, 20($t0)       # Load the first element
    lw $t3, 40($t0)       # Load the eighth element
    lw $t4, 60($t0)       # Load the fifteenth element
    lw $t5, 80($t0)      # Load the twenty-second element

    beq $t2, 11, check_next28
    j try_next9

check_next28:
    beq $t3, 11, check_next29
    j try_next9

check_next29:
    beq $t4, 11, check_next30
    j try_next9

check_next30:
    beq $t5, 11, consecutive_found
    j try_next9
    
try_next9:

    lw $t2, 40($t0)        # Load the first element
    lw $t3, 60($t0)       # Load the eighth element
    lw $t4, 80($t0)       # Load the fifteenth element
    lw $t5, 100($t0)       # Load the twenty-second element

    beq $t2, 11, check_next31
    j try_next10

check_next31:
    beq $t3, 11, check_next32
    j try_next10

check_next32:
    beq $t4, 11, check_next33
    j try_next10

check_next33:
    beq $t5, 11, consecutive_found
    j try_next10
    
try_next10:

    lw $t2, 60($t0)        # Load the first element
    lw $t3, 80($t0)       # Load the eighth element
    lw $t4, 100($t0)       # Load the fifteenth element
    lw $t5, 120($t0)       # Load the twenty-second element

    beq $t2, 11, check_next34
    j try_next11

check_next34:
    beq $t3, 11, check_next35
    j try_next11

check_next35:
    beq $t4, 11, check_next36
    j try_next11

check_next36:
    beq $t5, 11, consecutive_found
    j try_next11
    
try_next11:

    lw $t2, 44($t0)        # Load the first element
    lw $t3, 64($t0)       # Load the eighth element
    lw $t4, 84($t0)       # Load the fifteenth element
    lw $t5, 104($t0)       # Load the twenty-second element

    beq $t2, 11, check_next37
    j try_next12

check_next37:
    beq $t3, 11, check_next38
    j try_next12

check_next38:
    beq $t4, 11, check_next39
    j try_next12

check_next39:
    beq $t5, 11, consecutive_found
    j try_next12


try_next12:

    lw $t2, 64($t0)        # Load the first element
    lw $t3, 84($t0)       # Load the eighth element
    lw $t4, 104($t0)       # Load the fifteenth element
    lw $t5, 124($t0)       # Load the twenty-second element

    beq $t2, 11, check_next40
    j try_next13

check_next40:
    beq $t3, 11, check_next41
    j try_next13

check_next41:
    beq $t4, 11, check_next42
    j try_next13

check_next42:
    beq $t5, 11, consecutive_found
    j try_next13

try_next13:

    lw $t2, 68($t0)        # Load the first element
    lw $t3, 88($t0)       # Load the eighth element
    lw $t4, 108($t0)       # Load the fifteenth element
    lw $t5, 128($t0)       # Load the twenty-second element7

    beq $t2, 11, check_next43
    j try_next14

check_next43:
    beq $t3, 11, check_next44
    j try_next14

check_next44:
    beq $t4, 11, check_next45
    j try_next14

check_next45:
    beq $t5, 11, consecutive_found
    j try_next14
    
try_next14:

    lw $t2, 16($t0)        # Load the first element
    lw $t3, 36($t0)       # Load the eighth element
    lw $t4, 56($t0)       # Load the fifteenth element
    lw $t5, 76($t0)       # Load the twenty-second element

    beq $t2, 11, check_next46
    j try_next15

check_next46:
    beq $t3, 11, check_next47
    j try_next15

check_next47:
    beq $t4, 11, check_next48
    j try_next15

check_next48:
    beq $t5, 11, consecutive_found
    j try_next15
    
try_next15:

    lw $t2, 36($t0)        # Load the first element
    lw $t3, 56($t0)       # Load the eighth element
    lw $t4, 76($t0)       # Load the fifteenth element
    lw $t5, 96($t0)       # Load the twenty-second element

    beq $t2, 11, check_next49
    j try_next16

check_next49:
    beq $t3, 11, check_next50
    j try_next16

check_next50:
    beq $t4, 11, check_next51
    j try_next16

check_next51:
    beq $t5, 11, consecutive_found
    j try_next16
    
try_next16:
    lw $t2, 12($t0)        # Load the first element
    lw $t3, 32($t0)       # Load the eighth element
    lw $t4, 52($t0)       # Load the fifteenth element
    lw $t5, 72($t0)       # Load the twenty-second element

    beq $t2, 11, check_next52
    j go_next20

check_next52:
    beq $t3, 11, check_next53
    j go_next20

check_next53:
    beq $t4, 11, check_next54
    j go_next20

check_next54:
    beq $t5, 11, consecutive_found
    j go_next20
    
go_next20:

#Column 1
    # Initialize the array
    la $t0, list

    # Get the length of the array
    li $t1, 36  # Number of elements in the array

    # Check for "4 in a row" from right to left
    lw $t2, 0($t0)       # Load the first element
    lw $t3, 24($t0)       # Load the eighth element
    lw $t4, 48($t0)       # Load the fifteenth element
    lw $t5, 72($t0)      # Load the twenty-second element

    beq $t2, 11, check_next55
    j try_next18

check_next55:
    beq $t3, 11, check_next56
    j try_next18

check_next56:
    beq $t4, 11, check_next57
    j try_next18

check_next57:
    beq $t5, 11, consecutive_found
    j try_next18
    
try_next18:

    lw $t2, 24($t0)        # Load the first element
    lw $t3, 48($t0)       # Load the eighth element
    lw $t4, 72($t0)       # Load the fifteenth element
    lw $t5, 96($t0)       # Load the twenty-second element

    beq $t2, 11, check_next58
    j try_next19

check_next58:
    beq $t3, 11, check_next59
    j try_next19

check_next59:
    beq $t4, 11, check_next60
    j try_next19

check_next60:
    beq $t5, 11, consecutive_found
    j try_next19
    
try_next19:

    lw $t2, 48($t0)        # Load the first element
    lw $t3, 72($t0)       # Load the eighth element
    lw $t4, 96($t0)       # Load the fifteenth element
    lw $t5, 120($t0)       # Load the twenty-second element

    beq $t2, 11, check_next61
    j try_next20

check_next61:
    beq $t3, 11, check_next62
    j try_next20

check_next62:
    beq $t4, 11, check_next63
    j try_next20

check_next63:
    beq $t5, 11, consecutive_found
    j try_next20
    
    #Column 2
try_next20:

    lw $t2, 4($t0)        # Load the first element
    lw $t3, 28($t0)       # Load the eighth element
    lw $t4, 52($t0)       # Load the fifteenth element
    lw $t5, 76($t0)       # Load the twenty-second element

    beq $t2, 11, check_next64
    j try_next21

check_next64:
    beq $t3, 11, check_next65
    j try_next21

check_next65:
    beq $t4, 11, check_next67
    j try_next21

check_next67:
    beq $t5, 11, consecutive_found
    j try_next21


try_next21:

    lw $t2, 28($t0)        # Load the first element
    lw $t3, 52($t0)       # Load the eighth element
    lw $t4, 76($t0)       # Load the fifteenth element
    lw $t5, 100($t0)       # Load the twenty-second element

    beq $t2, 11, check_next68
    j try_next22

check_next68:
    beq $t3, 11, check_next69
    j try_next22

check_next69:
    beq $t4, 11, check_next70
    j try_next22

check_next70:
    beq $t5, 11, consecutive_found
    j try_next22

try_next22:

    lw $t2, 52($t0)        # Load the first element
    lw $t3, 76($t0)       # Load the eighth element
    lw $t4, 100($t0)       # Load the fifteenth element
    lw $t5, 124($t0)       # Load the twenty-second element7

    beq $t2, 11, check_next71
    j try_next23

check_next71:
    beq $t3, 11, check_next72
    j try_next23

check_next72:
    beq $t4, 11, check_next73
    j try_next23

check_next73:
    beq $t5, 11, consecutive_found
    j try_next23

# Column 3
try_next23:


    lw $t2, 8($t0)        # Load the first element
    lw $t3, 32($t0)       # Load the eighth element
    lw $t4, 56($t0)       # Load the fifteenth element
    lw $t5, 80($t0)       # Load the twenty-second element

    beq $t2, 11, check_next74
    j try_next24

check_next74:
    beq $t3, 11, check_next75
    j try_next24

check_next75:
    beq $t4, 11, check_next76
    j try_next24

check_next76:
    beq $t5, 11, consecutive_found
    j try_next24
    
try_next24:


    lw $t2, 32($t0)        # Load the first element
    lw $t3, 56($t0)       # Load the eighth element
    lw $t4, 80($t0)       # Load the fifteenth element
    lw $t5, 104($t0)       # Load the twenty-second element

    beq $t2, 11, check_next77
    j try_next25

check_next77:
    beq $t3, 11, check_next78
    j try_next25

check_next78:
    beq $t4, 11, check_next79
    j try_next25

check_next79:
    beq $t5, 11, consecutive_found
    j try_next25
    
try_next25:

    lw $t2, 56($t0)        # Load the first element
    lw $t3, 80($t0)       # Load the eighth element
    lw $t4, 104($t0)       # Load the fifteenth element
    lw $t5, 128($t0)       # Load the twenty-second element

    beq $t2, 11, check_next80
    j try_next26

check_next80:
    beq $t3, 11, check_next81
    j try_next26

check_next81:
    beq $t4, 11, check_next82
    j try_next26

check_next82:
    beq $t5, 11, consecutive_found
    j try_next26

#column 4
try_next26:


    lw $t2, 12($t0)        # Load the first element
    lw $t3, 36($t0)       # Load the eighth element
    lw $t4, 60($t0)       # Load the fifteenth element
    lw $t5, 84($t0)       # Load the twenty-second element

    beq $t2, 11, check_next83
    j try_next27
    
    
check_next83:
    beq $t3, 11, check_next84
    j try_next27

check_next84:
    beq $t4, 11, check_next85
    j try_next27

check_next85:
    beq $t5, 11, consecutive_found
    j try_next27

try_next27:

    lw $t2, 36($t0)        # Load the first element
    lw $t3, 60($t0)       # Load the eighth element
    lw $t4, 84($t0)       # Load the fifteenth element
    lw $t5, 108($t0)       # Load the twenty-second element

    beq $t2, 11, check_next86
    j try_next28
    
    
check_next86:
    beq $t3, 11, check_next87
    j try_next28

check_next87:
    beq $t4, 11, check_next88
    j try_next28

check_next88:
    beq $t5, 11, consecutive_found
    j try_next28

try_next28:

    lw $t2, 60($t0)        # Load the first element
    lw $t3, 84($t0)       # Load the eighth element
    lw $t4, 108($t0)       # Load the fifteenth element
    lw $t5, 132($t0)       # Load the twenty-second element

    beq $t2, 11, check_next89
    j try_next29
    
    
check_next89:
    beq $t3, 11, check_next90
    j try_next29

check_next90:
    beq $t4, 11, check_next91
    j try_next29

check_next91:
    beq $t5, 11, consecutive_found
    j try_next29
    
#Column 5
try_next29:

    lw $t2, 16($t0)        # Load the first element
    lw $t3, 40($t0)       # Load the eighth element
    lw $t4, 64($t0)       # Load the fifteenth element
    lw $t5, 88($t0)       # Load the twenty-second element

    beq $t2, 11, check_next92
    j try_next30
    
    
check_next92:
    beq $t3, 11, check_next93
    j try_next30

check_next93:
    beq $t4, 11, check_next94
    j try_next30

check_next94:
    beq $t5, 11, consecutive_found
    j try_next30
    
try_next30:

    lw $t2, 40($t0)        # Load the first element
    lw $t3, 64($t0)       # Load the eighth element
    lw $t4, 88($t0)       # Load the fifteenth element
    lw $t5, 112($t0)       # Load the twenty-second element

    beq $t2, 11, check_next95
    j try_next31
    
    
check_next95:
    beq $t3, 11, check_next96
    j try_next31

check_next96:
    beq $t4, 11, check_next97
    j try_next31

check_next97:
    beq $t5, 11, consecutive_found
    j try_next31
    
try_next31:


    lw $t2, 64($t0)        # Load the first element
    lw $t3, 68($t0)       # Load the eighth element
    lw $t4, 112($t0)       # Load the fifteenth element
    lw $t5, 136($t0)       # Load the twenty-second element

    beq $t2, 11, check_next98
    j try_next32
    
    
check_next98:
    beq $t3, 11, check_next99
    j try_next32

check_next99:
    beq $t4, 11, check_next100
    j try_next32

check_next100:
    beq $t5, 11, consecutive_found
    j try_next32
    
#Column 6
try_next32:

    lw $t2, 20($t0)        # Load the first element
    lw $t3, 44($t0)       # Load the eighth element
    lw $t4, 68($t0)       # Load the fifteenth element
    lw $t5, 92($t0)       # Load the twenty-second element

    beq $t2, 11, check_next101
    j try_next33
    
    
check_next101:
    beq $t3, 11, check_next102
    j try_next33

check_next102:
    beq $t4, 11, check_next103
    j try_next33

check_next103:
    beq $t5, 11, consecutive_found
    j try_next33
    
try_next33:

    lw $t2, 44($t0)        # Load the first element
    lw $t3, 68($t0)       # Load the eighth element
    lw $t4, 92($t0)       # Load the fifteenth element
    lw $t5, 116($t0)       # Load the twenty-second element

    beq $t2, 11, check_next104
    j try_next34
    
    
check_next104:
    beq $t3, 11, check_next105
    j try_next34

check_next105:
    beq $t4, 11, check_next106
    j try_next34

check_next106:
    beq $t5, 11, consecutive_found
    j try_next34
    
try_next34:

    lw $t2, 68($t0)        # Load the first element
    lw $t3, 92($t0)       # Load the eighth element
    lw $t4, 116($t0)       # Load the fifteenth element
    lw $t5, 140($t0)       # Load the twenty-second element

    beq $t2, 11, check_next107
    j go_next2
    
    
check_next107:
    beq $t3, 11, check_next108
    j go_next2

check_next108:
    beq $t4, 11, check_next109
    j go_next2

check_next109:
    beq $t5, 11, consecutive_found
    j go_next2


go_next2: 
  
    la $a1, list           # Load address of the list
    li $a2, 22             # Set the target value to find (11)
    li $a3, 4              # Set the number of consecutive occurrences to find

    lw $t4, size           # Load the size of the list
    
    li $t0, 0              # Initialize counter for consecutive occurrences
    li $t1, 0              # Initialize index variable
    
check_consecutive1:
    bge $t1, $t4, go_next8 # Terminate loop if we have reached the end of the list

    lw $t2, 0($a1)         # Load the current element from the list

    beq $t2, $a2, found1     # Check if the current element is equal to the target value
    j not_found1            # Jump to not_found if not equal

found1:
    addi $t0, $t0, 1        # Increment consecutive occurrences counter
    beq $t0, $a3, consecutive_found1  # Check if the required consecutive occurrences are found
    j next_element1         # Jump to the next element

consecutive_found1:
    la $a0, computerWin  # Load address of the consecutive message
    li $v0, 4              # Print string syscall
    syscall
    
    j after_consecutive_found  # Jump to a label after the consecutive occurrences are found
    
not_found1:
    j reset_counters1      # Jump to reset_counters
    
not_found_message1:

    
reset_counters1:
    li $t0, 0              # Reset consecutive occurrences counter
    j next_element1         # Jump to the next element
    
next_element1:
    addi $a1, $a1, 4        # Move to the next element in the list
    addi $t1, $t1, 1        # Increment index variable
    j check_consecutive1    # Jump to check_consecutive

go_next8:
#CHECKING COMPUTER RIGHT DIAGONAL
    la $t0, list

    # Get the length of the array
    li $t1, 36  # Number of elements in the array

    # Check for "4 in a row"
    lw $t2, 0($t0)        # Load the first element
    lw $t3, 28($t0)       # Load the eighth element
    lw $t4, 56($t0)       # Load the fifteenth element
    lw $t5, 84($t0)       # Load the twenty-second element

    beq $t2, 22, check_next1101
    j try_next50

check_next1101:
    beq $t3, 22, check_next1102
    j try_next50

check_next1102:
    beq $t4, 22, check_next1103
    j try_next50

check_next1103:
    beq $t5, 22, consecutive_found1
    j try_next50
    
try_next50:
# Check for "4 in a row"

    lw $t2, 28($t0)        # Load the first element
    lw $t3, 56($t0)       # Load the eighth element
    lw $t4, 84($t0)       # Load the fifteenth element
    lw $t5, 112($t0)       # Load the twenty-second element

    beq $t2, 22, check_next1104
    j try_next51

check_next1104:
    beq $t3, 22, check_next1105
    j try_next51

check_next1105:
    beq $t4, 22, check_next1106
    j try_next51

check_next1106:
    beq $t5, 22, consecutive_found1
    j try_next51
    
try_next51:

    lw $t2, 56($t0)        # Load the first element
    lw $t3, 84($t0)       # Load the eighth element
    lw $t4, 112($t0)       # Load the fifteenth element
    lw $t5, 140($t0)       # Load the twenty-second element

    beq $t2, 22, check_next1107
    j try_next52

check_next1107:
    beq $t3, 22, check_next1108
    j try_next52

check_next1108:
    beq $t4, 22, check_next1109
    j try_next52

check_next1109:
    beq $t5, 22, consecutive_found1
    j try_next52
    
try_next52:


    lw $t2, 48($t0)        # Load the first element
    lw $t3, 76($t0)       # Load the eighth element
    lw $t4, 104($t0)       # Load the fifteenth element
    lw $t5, 132($t0)       # Load the twenty-second element

    beq $t2, 22, check_next1110
    j try_next53

check_next1110:
    beq $t3, 22, check_next1111
    j try_next53

check_next1111:
    beq $t4, 22, check_next1112
    j try_next53

check_next1112:
    beq $t5, 22, consecutive_found1
    j try_next53


try_next53:

    lw $t2, 24($t0)        # Load the first element
    lw $t3, 52($t0)       # Load the eighth element
    lw $t4, 80($t0)       # Load the fifteenth element
    lw $t5, 108($t0)       # Load the twenty-second element

    beq $t2, 22, check_next1113
    j try_next54

check_next1113:
    beq $t3, 22, check_next1114
    j try_next54

check_next1114:
    beq $t4, 22, check_next1115
    j try_next54

check_next1115:
    beq $t5, 22, consecutive_found1
    j try_next54

try_next54:


    lw $t2, 52($t0)        # Load the first element
    lw $t3, 80($t0)       # Load the eighth element
    lw $t4, 108($t0)       # Load the fifteenth element
    lw $t5, 136($t0)       # Load the twenty-second element

    beq $t2, 22, check_next1116
    j try_next55

check_next1116:
    beq $t3, 22, check_next1117
    j try_next55

check_next1117:
    beq $t4, 22, check_next1118
    j try_next55

check_next1118:
    beq $t5, 22, consecutive_found1
    j try_next55
    
try_next55:


    lw $t2, 4($t0)        # Load the first element
    lw $t3, 32($t0)       # Load the eighth element
    lw $t4, 60($t0)       # Load the fifteenth element
    lw $t5, 88($t0)       # Load the twenty-second element

    beq $t2, 22, check_next1119
    j try_next56

check_next1119:
    beq $t3, 22, check_next1120
    j try_next56

check_next1120:
    beq $t4, 22, check_next1121
    j try_next56

check_next1121:
    beq $t5, 22, consecutive_found1
    j try_next56
    
try_next56:


    lw $t2, 32($t0)        # Load the first element
    lw $t3, 60($t0)       # Load the eighth element
    lw $t4, 88($t0)       # Load the fifteenth element
    lw $t5, 116($t0)       # Load the twenty-second element

    beq $t2, 22, check_next1122
    j try_next57

check_next1122:
    beq $t3, 22, check_next1123
    j try_next57

check_next1123:
    beq $t4, 22, check_next1124
    j try_next57

check_next1124:
    beq $t5, 22, consecutive_found1
    j try_next57
    
try_next57:

    lw $t2, 8($t0)        # Load the first element
    lw $t3, 36($t0)       # Load the eighth element
    lw $t4, 64($t0)       # Load the fifteenth element
    lw $t5, 92($t0)       # Load the twenty-second element

    beq $t2, 22, check_next1125
     j go_next9

check_next1125:
    beq $t3, 22, check_next1126
     j go_next9

check_next1126:
    beq $t4, 22, check_next1127
    j go_next9

check_next1127:
    beq $t5, 22, consecutive_found1
    j go_next9

go_next9:
    # Initialize the array
    la $t0, list

    # Get the length of the array
    li $t1, 36  # Number of elements in the array

    # Check for "4 in a row" from right to left
    lw $t2, 20($t0)       # Load the first element
    lw $t3, 40($t0)       # Load the eighth element
    lw $t4, 60($t0)       # Load the fifteenth element
    lw $t5, 80($t0)      # Load the twenty-second element

    beq $t2, 22, check_next1128
    j try_next58

check_next1128:
    beq $t3, 22, check_next1129
    j try_next58
check_next1129:
    beq $t4, 22, check_next1130
    j try_next58

check_next1130:
    beq $t5, 22, consecutive_found1
    j try_next58
    
try_next58:

    lw $t2, 40($t0)        # Load the first element
    lw $t3, 60($t0)       # Load the eighth element
    lw $t4, 80($t0)       # Load the fifteenth element
    lw $t5, 100($t0)       # Load the twenty-second element

    beq $t2, 22, check_next1131
    j try_next59

check_next1131:
    beq $t3, 22, check_next1132
    j try_next59

check_next1132:
    beq $t4, 22, check_next1133
    j try_next59

check_next1133:
    beq $t5, 22, consecutive_found1
    j try_next59
    
try_next59:

    lw $t2, 60($t0)        # Load the first element
    lw $t3, 80($t0)       # Load the eighth element
    lw $t4, 100($t0)       # Load the fifteenth element
    lw $t5, 120($t0)       # Load the twenty-second element

    beq $t2, 22, check_next1134
    j try_next60

check_next1134:
    beq $t3, 22, check_next1135
    j try_next60

check_next1135:
    beq $t4, 22, check_next1136
    j try_next60

check_next1136:
    beq $t5, 22, consecutive_found1
    j try_next60
    
try_next60:

    lw $t2, 44($t0)        # Load the first element
    lw $t3, 64($t0)       # Load the eighth element
    lw $t4, 84($t0)       # Load the fifteenth element
    lw $t5, 104($t0)       # Load the twenty-second element

    beq $t2, 22, check_next1137
    j try_next61

check_next1137:
    beq $t3, 22, check_next1138
    j try_next61

check_next1138:
    beq $t4, 22, check_next1139
    j try_next61

check_next1139:
    beq $t5, 22, consecutive_found1
    j try_next61


try_next61:

    lw $t2, 64($t0)        # Load the first element
    lw $t3, 84($t0)       # Load the eighth element
    lw $t4, 104($t0)       # Load the fifteenth element
    lw $t5, 124($t0)       # Load the twenty-second element

    beq $t2, 22, check_next1140
    j try_next62

check_next1140:
    beq $t3, 22, check_next1141
    j try_next62

check_next1141:
    beq $t4, 22, check_next1142
    j try_next62

check_next1142:
    beq $t5, 22, consecutive_found1
    j try_next62

try_next62:

    lw $t2, 68($t0)        # Load the first element
    lw $t3, 88($t0)       # Load the eighth element
    lw $t4, 108($t0)       # Load the fifteenth element
    lw $t5, 128($t0)       # Load the twenty-second element7

    beq $t2, 22, check_next1143
    j try_next63

check_next1143:
    beq $t3, 22, check_next1144
    j try_next63

check_next1144:
    beq $t4, 22, check_next1145
    j try_next63

check_next1145:
    beq $t5, 22, consecutive_found1
    j try_next63
    
try_next63:

    lw $t2, 16($t0)        # Load the first element
    lw $t3, 36($t0)       # Load the eighth element
    lw $t4, 56($t0)       # Load the fifteenth element
    lw $t5, 76($t0)       # Load the twenty-second element

    beq $t2, 22, check_next1146
    j try_next64

check_next1146:
    beq $t3, 22, check_next1147
    j try_next64

check_next1147:
    beq $t4, 22, check_next1148
    j try_next64

check_next1148:
    beq $t5, 22, consecutive_found1
    j try_next64
    
try_next64:

    lw $t2, 36($t0)        # Load the first element
    lw $t3, 56($t0)       # Load the eighth element
    lw $t4, 76($t0)       # Load the fifteenth element
    lw $t5, 96($t0)       # Load the twenty-second element

    beq $t2, 22, check_next1149
    j try_next65

check_next1149:
    beq $t3, 22, check_next1150
    j try_next65

check_next1150:
    beq $t4, 22, check_next1151
    j try_next65

check_next1151:
    beq $t5, 22, consecutive_found1
    j try_next65
    
try_next65:
    lw $t2, 12($t0)        # Load the first element
    lw $t3, 32($t0)       # Load the eighth element
    lw $t4, 52($t0)       # Load the fifteenth element
    lw $t5, 72($t0)       # Load the twenty-second element

    beq $t2, 22, check_next1152
    j go_next10

check_next1152:
    beq $t3, 22, check_next1153
    j go_next10

check_next1153:
    beq $t4, 22, check_next1154
    j go_next10

check_next1154:
    beq $t5, 22, consecutive_found1
    j go_next10

go_next10:
#Column 1
    # Initialize the array
    la $t0, list

    # Get the length of the array
    li $t1, 36  # Number of elements in the array

    # Check for "4 in a row" from right to left
    lw $t2, 0($t0)       # Load the first element
    lw $t3, 24($t0)       # Load the eighth element
    lw $t4, 48($t0)       # Load the fifteenth element
    lw $t5, 72($t0)      # Load the twenty-second element

    beq $t2, 22, check_next500
    j try_next201

check_next500:
    beq $t3, 22, check_next501
    j try_next201

check_next501:
    beq $t4, 22, check_next502
    j try_next201

check_next502:
    beq $t5, 22, consecutive_found1
    j try_next201
    
try_next201:


    lw $t2, 24($t0)        # Load the first element
    lw $t3, 48($t0)       # Load the eighth element
    lw $t4, 72($t0)       # Load the fifteenth element
    lw $t5, 96($t0)       # Load the twenty-second element

    beq $t2, 22, check_next503
    j try_next202

check_next503:
    beq $t3, 22, check_next504
    j try_next202

check_next504:
    beq $t4, 22, check_next505
    j try_next202

check_next505:
    beq $t5, 22, consecutive_found1
    j try_next202
    
try_next202:

    lw $t2, 48($t0)        # Load the first element
    lw $t3, 72($t0)       # Load the eighth element
    lw $t4, 96($t0)       # Load the fifteenth element
    lw $t5, 120($t0)       # Load the twenty-second element

    beq $t2, 22, check_next506
    j try_next203

check_next506:
    beq $t3, 22, check_next507
    j try_next203

check_next507:
    beq $t4, 22, check_next508
    j try_next203

check_next508:
    beq $t5, 22, consecutive_found1
    j try_next203
    
    #Column 2
try_next203:

    lw $t2, 4($t0)        # Load the first element
    lw $t3, 28($t0)       # Load the eighth element
    lw $t4, 52($t0)       # Load the fifteenth element
    lw $t5, 76($t0)       # Load the twenty-second element

    beq $t2, 22, check_next509
    j try_next204

check_next509:
    beq $t3, 22, check_next510
    j try_next204

check_next510:
    beq $t4, 22, check_next511
    j try_next204

check_next511:
    beq $t5, 22, consecutive_found1
    j try_next204


try_next204:

    lw $t2, 28($t0)        # Load the first element
    lw $t3, 52($t0)       # Load the eighth element
    lw $t4, 76($t0)       # Load the fifteenth element
    lw $t5, 100($t0)       # Load the twenty-second element

    beq $t2, 22, check_next512
    j try_next205

check_next512:
    beq $t3, 22, check_next513
    j try_next205

check_next513:
    beq $t4, 22, check_next514
    j try_next205

check_next514:
    beq $t5, 22, consecutive_found1
    j try_next205

try_next205:

    lw $t2, 52($t0)        # Load the first element
    lw $t3, 76($t0)       # Load the eighth element
    lw $t4, 100($t0)       # Load the fifteenth element
    lw $t5, 124($t0)       # Load the twenty-second element7

    beq $t2, 22, check_next515
    j try_next206

check_next515:
    beq $t3, 22, check_next516
    j try_next206

check_next516:
    beq $t4, 22, check_next517
    j try_next206

check_next517:
    beq $t5, 22, consecutive_found1
    j try_next206

# Column 3
try_next206:

    lw $t2, 8($t0)        # Load the first element
    lw $t3, 32($t0)       # Load the eighth element
    lw $t4, 56($t0)       # Load the fifteenth element
    lw $t5, 80($t0)       # Load the twenty-second element

    beq $t2, 22, check_next518
    j try_next207

check_next518:
    beq $t3, 22, check_next519
    j try_next207

check_next519:
    beq $t4, 22, check_next520
    j try_next207

check_next520:
    beq $t5, 22, consecutive_found1
    j try_next207
    
try_next207:

    lw $t2, 32($t0)        # Load the first element
    lw $t3, 56($t0)       # Load the eighth element
    lw $t4, 80($t0)       # Load the fifteenth element
    lw $t5, 104($t0)       # Load the twenty-second element

    beq $t2, 22, check_next521
    j try_next208

check_next521:
    beq $t3, 22, check_next522
    j try_next208

check_next522:
    beq $t4, 22, check_next523
    j try_next208

check_next523:
    beq $t5, 22, consecutive_found1
    j try_next208
    
try_next208:

    lw $t2, 56($t0)        # Load the first element
    lw $t3, 80($t0)       # Load the eighth element
    lw $t4, 104($t0)       # Load the fifteenth element
    lw $t5, 128($t0)       # Load the twenty-second element

    beq $t2, 22, check_next524
    j try_next209

check_next524:
    beq $t3, 22, check_next525
    j try_next209

check_next525:
    beq $t4, 22, check_next526
    j try_next209

check_next526:
    beq $t5, 22, consecutive_found1
    j try_next209

#column 4
try_next209:

    lw $t2, 12($t0)        # Load the first element
    lw $t3, 36($t0)       # Load the eighth element
    lw $t4, 60($t0)       # Load the fifteenth element
    lw $t5, 84($t0)       # Load the twenty-second element

    beq $t2, 22, check_next527
    j try_next210
    
    
check_next527:
    beq $t3, 22, check_next528
    j try_next210

check_next528:
    beq $t4, 22, check_next529
    j try_next210

check_next529:
    beq $t5, 22, consecutive_found1
    j try_next210

try_next210:

    lw $t2, 36($t0)        # Load the first element
    lw $t3, 60($t0)       # Load the eighth element
    lw $t4, 84($t0)       # Load the fifteenth element
    lw $t5, 108($t0)       # Load the twenty-second element

    beq $t2, 22, check_next530
    j try_next211
    
    
check_next530:
    beq $t3, 22, check_next531
    j try_next211

check_next531:
    beq $t4, 22, check_next532
    j try_next211

check_next532:
    beq $t5, 22, consecutive_found1
    j try_next211

try_next211:

    lw $t2, 60($t0)        # Load the first element
    lw $t3, 84($t0)       # Load the eighth element
    lw $t4, 108($t0)       # Load the fifteenth element
    lw $t5, 132($t0)       # Load the twenty-second element

    beq $t2, 22, check_next533
    j try_next212
    
    
check_next533:
    beq $t3, 22, check_next534
    j try_next212

check_next534:
    beq $t4, 22, check_next535
    j try_next212

check_next535:
    beq $t5, 22, consecutive_found1
    j try_next212
    
#Column 5
try_next212:

    lw $t2, 16($t0)        # Load the first element
    lw $t3, 40($t0)       # Load the eighth element
    lw $t4, 64($t0)       # Load the fifteenth element
    lw $t5, 88($t0)       # Load the twenty-second element

    beq $t2, 22, check_next536
    j try_next213
    
    
check_next536:
    beq $t3, 22, check_next537
    j try_next213

check_next537:
    beq $t4, 22, check_next538
    j try_next213

check_next538:
    beq $t5, 22, consecutive_found1
    j try_next213
    
try_next213:

    lw $t2, 40($t0)        # Load the first element
    lw $t3, 64($t0)       # Load the eighth element
    lw $t4, 88($t0)       # Load the fifteenth element
    lw $t5, 112($t0)       # Load the twenty-second element

    beq $t2, 22, check_next539
    j try_next214
    
    
check_next539:
    beq $t3, 22, check_next540
    j try_next214

check_next540:
    beq $t4, 22, check_next541
    j try_next214

check_next541:
    beq $t5, 22, consecutive_found1
    j try_next214
    
try_next214:

    lw $t2, 64($t0)        # Load the first element
    lw $t3, 68($t0)       # Load the eighth element
    lw $t4, 112($t0)       # Load the fifteenth element
    lw $t5, 136($t0)       # Load the twenty-second element

    beq $t2, 22, check_next542
    j try_next215
    
    
check_next542:
    beq $t3, 22, check_next543
    j try_next215

check_next543:
    beq $t4, 22, check_next544
    j try_next215

check_next544:
    beq $t5, 22, consecutive_found1
    j try_next215
    
#Column 6
try_next215:

    lw $t2, 20($t0)        # Load the first element
    lw $t3, 44($t0)       # Load the eighth element
    lw $t4, 68($t0)       # Load the fifteenth element
    lw $t5, 92($t0)       # Load the twenty-second element

    beq $t2, 22, check_next545
    j try_next216
    
    
check_next545:
    beq $t3, 22, check_next546
    j try_next216

check_next546:
    beq $t4, 22, check_next547
    j try_next216

check_next547:
    beq $t5, 22, consecutive_found1
    j try_next216
    
try_next216:

    lw $t2, 44($t0)        # Load the first element
    lw $t3, 68($t0)       # Load the eighth element
    lw $t4, 92($t0)       # Load the fifteenth element
    lw $t5, 116($t0)       # Load the twenty-second element

    beq $t2, 22, check_next548
    j try_next217
    
    
check_next548:
    beq $t3, 22, check_next549
    j try_next217

check_next549:
    beq $t4, 22, check_next550
    j try_next217

check_next550:
    beq $t5, 22, consecutive_found1
    j try_next217
    
try_next217:

    lw $t2, 68($t0)        # Load the first element
    lw $t3, 92($t0)       # Load the eighth element
    lw $t4, 116($t0)       # Load the fifteenth element
    lw $t5, 140($t0)       # Load the twenty-second element

    beq $t2, 22, check_next551
    j go_next11
    
    
check_next551:
    beq $t3, 22, check_next552
    j go_next11

check_next552:
    beq $t4, 22, check_next553
    j go_next11

check_next553:
    beq $t5, 22, consecutive_found1
    j go_next11
    
go_next11:



  j start
 
  
  invalid_computer2:
lw $t1, pNum2
sw $t1, num2

  j computer_move  # Repeat the loop
  
  #check for computer win
  
  
  j start

invalid_move_num2:
lw $t1, pNum2
sw $t1, num2
# Add a newline character
  li $v0, 11
  li $a0, 10
  syscall
  
  li $v0, 4
  la $a0, error_message2
  syscall

  j start  # Repeat the loop

  jal start
  # Exit the program
  after_consecutive_found:

  li $v0, 10
  syscall


# Function to print a grid of integers
# Arguments: $a0 = base address of the array, $a1 = size of the array
print_grid:
  move $t1, $a1   # Copy size to $t1
  move $t2, $a0   # Copy base address to $t2

print_loop:
  beq $t1, $zero, print_loop_end  # check for array end

  lw $a0, 0($t2)  # load value at the array pointer
  move $t5, $a0

  # Check if the value is less than 10
  li $t3, 10
  blt $a0, $t3, print_zero

  # Print the actual value
  li $v0, 1
  syscall
  j print_pipe

print_zero:
  # Print '0'
  li $v0, 11
  li $a0, 48  # ASCII code for '0'
  syscall

  # Print the actual value
  li $v0, 1
  move $a0, $t5
  syscall

print_pipe:
  # Print a pipe character
  li $v0, 11
  li $a0, 124  # ASCII code for pipe character
  syscall

  addi $t2, $t2, 4  # advance array pointer
  addi $t1, $t1, -1 # decrement loop counter

  # Check if 6 numbers have been printed (every 6 numbers)
  li $t3, 6
  rem $t4, $t1, $t3
  beqz $t4, print_divider

  j print_loop  # repeat the loop

print_divider:
  # Print a newline character before the divider
  li $v0, 11
  li $a0, 10  # ASCII code for newline character
  syscall

  # Print the divider
  li $v0, 4
  la $a0, divider
  syscall

  j print_loop  # repeat the loop

print_loop_end:
  # Print a newline character at the end_
  li $v0, 11
  li $a0, 10  # ASCII code for newline character
  syscall

  jr $ra  # return from function
