// Start of loop
(START)
@SCREEN		// Holds the starting memory address for the screen memory map.
D=A
@0			// Assign the starting address for the screen memory map to Ram[0]
M=D

@KBD		// Holds the starting memory address for the keyboard memory map.
D=M
@BLACK
D;JGT   	// Jump to Black label if key is pressed (> 0)
@WHITE
D;JEQ   	// Jump to White label if key is not pressed (== 0)

(BLACK)
@1
M=-1    	// -1 turns the word of pixels represented by m register to black
@CHANGE		// Jumps to the function that will change the colour.
0;JMP

(WHITE)
@1
M=0     	// 0 turns the word of pixels represented by m register to white
@CHANGE		// Jumps to the function that will change the colour.
0;JMP

(CHANGE)
@1      	// Regiter containing -1 or 0 for black or white respectively
D=M     	// Copying the data from the register

@0
A=M     	
M=D     	// This is what will colour the word represented by that register

@0
D=M+1   	// Moving to next register (word of pixels)
@KBD
D=A-D   	// Holds the difference between the keyboard memory map starting address and the current screen address

@0
M=M+1   	// Moving to next register (word of pixels)
A=M

@CHANGE		// If the difference between the keyboard address and the screen address is not 0
D;JGT		// it will jump to the next word (if >0)

@START		// Jumps back to start and starts colouring from the beginning of the screen memory map
0;JMP		// Regardless of the colour it will overwrite it