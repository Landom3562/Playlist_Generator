##############################################################
#Array
##############################################################
#   4 Bytes - Address of the Data
#   4 Bytes - Size
##############################################################

##############################################################
#Linked List Node
##############################################################
#   4 Bytes - Address of the Data
#   4 Bytes - Address of the Next Node
##############################################################

##############################################################
#Song
##############################################################
#   4 Bytes - Address of the Name (name itself is 64 bytes)
#   4 Bytes - Duration
##############################################################


.data
space: .asciiz " "
newLine: .asciiz "\n"
tab: .asciiz "\t"

name: .asciiz "Song name: "
duration: .asciiz "Song duration: "
emptyList: .asciiz "List is empty!\n"
noSong: .asciiz "\nSong not found!\n"
foundSong: .asciiz "\nSong found!\n"
songAdded: .asciiz "\nSong added.\n"

copmStr: .space 64

sReg: .word 3, 7, 1, 2, 9, 4, 6, 5
arrayOfPlaylistsAddress: .word 0 #the address of the array of playlists stored here!


p1s1: .asciiz "Summer Breeze"
p1s1_duration: .word 124

p1s2: .asciiz "Rhythm of the Night"
p1s2_duration: .word 225

p1s3: .asciiz "Golden Days"
p1s3_duration: .word 192

p1s4: .asciiz "Dancing in the Moonlight"
p1s4_duration: .word 186

p1s5: .asciiz "Island Paradise"
p1s5_duration: .word 213

p2s1: .asciiz "Chill Vibes"
p2s1_duration: .word 198

p2s2: .asciiz "Smooth Jazz Serenade"
p2s2_duration: .word 213

p2s3: .asciiz "Dreamscape"
p2s3_duration: .word 156

p2s4: .asciiz "Mellow Melodies"
p2s4_duration: .word 177

p2s5: .asciiz "Sunny Side Up"
p2s5_duration: .word 204

p3s1: .asciiz "Rock 'n Roll Classics"
p3s1_duration: .word 214

p3s2: .asciiz "Electric Dreams"
p3s2_duration: .word 199

p3s3: .asciiz "Highway to Heaven"
p3s3_duration: .word 235

p3s4: .asciiz "City Lights"
p3s4_duration: .word 186

p3s5: .asciiz "Rebel Yell"
p3s5_duration: .word 192

p4s1: .asciiz "Acoustic Serenity"
p4s1_duration: .word 176

p4s2: .asciiz "Gentle Guitar Grooves"
p4s2_duration: .word 205

p4s3: .asciiz "Woodland Whispers"
p4s3_duration: .word 153

p4s4: .asciiz "Folklore Fantasia"
p4s4_duration: .word 218

p4s5: .asciiz "Countryside Carols"
p4s5_duration: .word 242

p5s1: .asciiz "Hip-Hop Heatwave"
p5s1_duration: .word 193

p5s2: .asciiz "Urban Dreams"
p5s2_duration: .word 208

p5s3: .asciiz "Rap Revolution"
p5s3_duration: .word 177

p5s4: .asciiz "Street Symphony"
p5s4_duration: .word 205

p5s5: .asciiz "Groove City Groceries"
p5s5_duration: .word 221


search1: .asciiz "Highway to Heaven"
search2: .asciiz "Master of Puppets"

.text 
main:

	la $t0, sReg
	lw $s0, 0($t0)
	lw $s1, 4($t0)
	lw $s2, 8($t0)
	lw $s3, 12($t0)
	lw $s4, 16($t0)
	lw $s5, 20($t0)
	lw $s6, 24($t0)
	lw $s7, 28($t0)

mainStart:
	#Storing all s registers
	addi $sp, $sp, -32
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	
	#Initialize array of playlist by using with an initial size of 3.
	li $a0, 3
	jal createArray
	move $s0, $v0 #Address of the array
	la $t0, arrayOfPlaylistsAddress
	sw $s0, 0($t0)
	
	#Create 3 playlists as linked list and insert them into array of playlist.
	li $s1, 0
	li $s2, 3
playlistLoop1:
	jal createLinkedList
	move $a0, $s0
	move $a1, $s1
	move $a2, $v0
	jal putElementToArray
	addi $s1, $s1, 1
	bne $s1, $s2, playlistLoop1
	
	#Resize to size of 5. Create 2 more playlists and insert them into available areas in array of playlist.
	move $a0, $s0
	lw $a1, 4($s0)
	li $a2, 5
	jal resizeArray
	move $s0, $v0
	li $s1, 3
	li $s2, 5
playlistLoop2:
	jal createLinkedList
	move $a0, $s0
	move $a1, $s1
	move $a2, $v0
	jal putElementToArray
	addi $s1, $s1, 1
	bne $s1, $s2, playlistLoop2
	
	#Create 4 songs for each playlist and insert them into playlists. Each song must have a name and duration.
	la $s7, songAdded
	#First playlist
	lw $s1, 0($s0)
	lw $s1, 0($s1)
	#First Song
	la $a0, p1s1
	la $a1, p1s1_duration
	lw $a1, 0($a1)
	jal createSong
	move $a0, $s1
	move $a1, $v0
	jal putElementToLinkedList
	move $a0, $s7
	li $v0, 4
	syscall
	#Second Song
	la $a0, p1s2
	la $a1, p1s2_duration
	lw $a1, 0($a1)
	jal createSong
	move $a0, $s1
	move $a1, $v0
	jal putElementToLinkedList
	move $a0, $s7
	li $v0, 4
	syscall
	#Third Song
	la $a0, p1s3
	la $a1, p1s3_duration
	lw $a1, 0($a1)
	jal createSong
	move $a0, $s1
	move $a1, $v0
	jal putElementToLinkedList
	move $a0, $s7
	li $v0, 4
	syscall
	#Fourth Song
	la $a0, p1s4
	la $a1, p1s4_duration
	lw $a1, 0($a1)
	jal createSong
	move $a0, $s1
	move $a1, $v0
	jal putElementToLinkedList
	move $a0, $s7
	li $v0, 4
	syscall
	
	
	#Second playlist
	lw $s1, 0($s0)
	lw $s1, 4($s1)
	#First Song
	la $a0, p2s1
	la $a1, p2s1_duration
	lw $a1, 0($a1)
	jal createSong
	move $a0, $s1
	move $a1, $v0
	jal putElementToLinkedList
	move $a0, $s7
	li $v0, 4
	syscall
	#Second Song
	la $a0, p2s2
	la $a1, p2s2_duration
	lw $a1, 0($a1)
	jal createSong
	move $a0, $s1
	move $a1, $v0
	jal putElementToLinkedList
	move $a0, $s7
	li $v0, 4
	syscall
	#Third Song
	la $a0, p2s3
	la $a1, p2s3_duration
	lw $a1, 0($a1)
	jal createSong
	move $a0, $s1
	move $a1, $v0
	jal putElementToLinkedList
	move $a0, $s7
	li $v0, 4
	syscall
	#Fourth Song
	la $a0, p2s4
	la $a1, p2s4_duration
	lw $a1, 0($a1)
	jal createSong
	move $a0, $s1
	move $a1, $v0
	jal putElementToLinkedList
	move $a0, $s7
	li $v0, 4
	syscall
	
	#Third playlist
	lw $s1, 0($s0)
	lw $s1, 8($s1)
	#First Song
	la $a0, p3s1
	la $a1, p3s1_duration
	lw $a1, 0($a1)
	jal createSong
	move $a0, $s1
	move $a1, $v0
	jal putElementToLinkedList
	move $a0, $s7
	li $v0, 4
	syscall
	#Second Song
	la $a0, p3s2
	la $a1, p3s2_duration
	lw $a1, 0($a1)
	jal createSong
	move $a0, $s1
	move $a1, $v0
	jal putElementToLinkedList
	move $a0, $s7
	li $v0, 4
	syscall
	#Third Song
	la $a0, p3s3
	la $a1, p3s3_duration
	lw $a1, 0($a1)
	jal createSong
	move $a0, $s1
	move $a1, $v0
	jal putElementToLinkedList
	move $a0, $s7
	li $v0, 4
	syscall
	#Fourth Song
	la $a0, p3s4
	la $a1, p3s4_duration
	lw $a1, 0($a1)
	jal createSong
	move $a0, $s1
	move $a1, $v0
	jal putElementToLinkedList
	move $a0, $s7
	li $v0, 4
	syscall
	
	#Fourth playlist
	lw $s1, 0($s0)
	lw $s1, 12($s1)
	#First Song
	la $a0, p4s1
	la $a1, p4s1_duration
	lw $a1, 0($a1)
	jal createSong
	move $a0, $s1
	move $a1, $v0
	jal putElementToLinkedList
	move $a0, $s7
	li $v0, 4
	syscall
	#Second Song
	la $a0, p4s2
	la $a1, p4s2_duration
	lw $a1, 0($a1)
	jal createSong
	move $a0, $s1
	move $a1, $v0
	jal putElementToLinkedList
	move $a0, $s7
	li $v0, 4
	syscall
	#Third Song
	la $a0, p4s3
	la $a1, p4s3_duration
	lw $a1, 0($a1)
	jal createSong
	move $a0, $s1
	move $a1, $v0
	jal putElementToLinkedList
	move $a0, $s7
	li $v0, 4
	syscall
	#Fourth Song
	la $a0, p4s4
	la $a1, p4s4_duration
	lw $a1, 0($a1)
	jal createSong
	move $a0, $s1
	move $a1, $v0
	jal putElementToLinkedList
	move $a0, $s7
	li $v0, 4
	syscall
	
	#Fifth playlist
	lw $s1, 0($s0)
	lw $s1, 16($s1)
	#First Song
	la $a0, p5s1
	la $a1, p5s1_duration
	lw $a1, 0($a1)
	jal createSong
	move $a0, $s1
	move $a1, $v0
	jal putElementToLinkedList
	move $a0, $s7
	li $v0, 4
	syscall
	#Second Song
	la $a0, p5s2
	la $a1, p5s2_duration
	lw $a1, 0($a1)
	jal createSong
	move $a0, $s1
	move $a1, $v0
	jal putElementToLinkedList
	move $a0, $s7
	li $v0, 4
	syscall
	#Third Song
	la $a0, p5s3
	la $a1, p5s3_duration
	lw $a1, 0($a1)
	jal createSong
	move $a0, $s1
	move $a1, $v0
	jal putElementToLinkedList
	move $a0, $s7
	li $v0, 4
	syscall
	#Fourth Song
	la $a0, p5s4
	la $a1, p5s4_duration
	lw $a1, 0($a1)
	jal createSong
	move $a0, $s1
	move $a1, $v0
	jal putElementToLinkedList
	move $a0, $s7
	li $v0, 4
	syscall
	
	#Print all the songs.
	la $a0, newLine
	li $v0, 4
	syscall
	la $a0, printSong
	move $a1, $s0
	jal traverseArray
	la $a0, newLine
	li $v0, 4
	syscall
	
	#Remove the second song of each playlist.
	lw $s1, 0($s0) #Address of data of array
	lw $s2, 4($s0) #Number of playlists
	li $s3, 0 #Index
secondSongRemovalLoop:
	sll $s4, $s3, 2
	add $s4, $s1, $s4
	lw $a0, 0($s4)
	li $a1, 1
	jal removeElementFromTheLinkedList
	addi $s3, $s3, 1
	bne $s2, $s3, secondSongRemovalLoop
	
	#Print all the songs.
	
	la $a0, newLine
	li $v0, 4
	syscall
	la $a0, printSong
	move $a1, $s0
	jal traverseArray
	la $a0, newLine
	li $v0, 4
	syscall
	
	#Add 1 more song to each playlist.
	#First playlist
	lw $s1, 0($s0)
	lw $s1, 0($s1)
	la $a0, p1s5
	la $a1, p1s5_duration
	lw $a1, 0($a1)
	jal createSong
	move $a0, $s1
	move $a1, $v0
	jal putElementToLinkedList
	move $a0, $s7
	li $v0, 4
	syscall
	
	#Second playlist
	lw $s1, 0($s0)
	lw $s1, 4($s1)
	la $a0, p2s5
	la $a1, p2s5_duration
	lw $a1, 0($a1)
	jal createSong
	move $a0, $s1
	move $a1, $v0
	jal putElementToLinkedList
	move $a0, $s7
	li $v0, 4
	syscall
	
	#Third playlist
	lw $s1, 0($s0)
	lw $s1, 8($s1)
	la $a0, p3s5
	la $a1, p3s5_duration
	lw $a1, 0($a1)
	jal createSong
	move $a0, $s1
	move $a1, $v0
	jal putElementToLinkedList
	move $a0, $s7
	li $v0, 4
	syscall
	
	#Fourth playlist
	lw $s1, 0($s0)
	lw $s1, 12($s1)
	la $a0, p4s5
	la $a1, p4s5_duration
	lw $a1, 0($a1)
	jal createSong
	move $a0, $s1
	move $a1, $v0
	jal putElementToLinkedList
	move $a0, $s7
	li $v0, 4
	syscall
	
	#Fifth playlist
	lw $s1, 0($s0)
	lw $s1, 16($s1)
	la $a0, p5s5
	la $a1, p5s5_duration
	lw $a1, 0($a1)
	jal createSong
	move $a0, $s1
	move $a1, $v0
	jal putElementToLinkedList
	move $a0, $s7
	li $v0, 4
	syscall
	
	#Print all the songs.
	
	la $a0, newLine
	li $v0, 4
	syscall
	la $a0, printSong
	move $a1, $s0
	jal traverseArray
	la $a0, newLine
	li $v0, 4
	syscall
	
	#Remove the fourth playlist.
	move $a0, $s0
	li $a1, 3
	jal removeElementFromArray
	
	#Print all the songs.
	
	la $a0, newLine
	li $v0, 4
	syscall
	la $a0, printSong
	move $a1, $s0
	jal traverseArray
	la $a0, newLine
	li $v0, 4
	syscall
	
	#Search for given two songs, print the result.
	la $a0, isSong
	move $a1, $s0
	jal traverseArray

	#Loading all s registers
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	lw $s7, 28($sp)
	addi $sp, $sp, 32
	
mainTerminate:
	la $a0, newLine		
	li $v0, 4
	syscall
	syscall
	
	li $v0, 1
	move $a0, $s0
	syscall
	move $a0, $s1
	syscall
	move $a0, $s2
	syscall
	move $a0, $s3
	syscall
	move $a0, $s4
	syscall
	move $a0, $s5
	syscall
	move $a0, $s6
	syscall
	move $a0, $s7
	syscall
	
	li $v0, 10
	syscall


createArray:
	move $t0, $a0 #Size of array
	li $a0, 8
	li $v0, 9
	syscall
	move $t1, $v0 #Address of array variable
	sll $a0, $t0, 2
	li $v0, 9
	syscall
	sw $v0, 0($t1) #Address of data is stored in first 4 bytes of array variable
	sw $t0, 4($t1) #Size of array is stored in second 4 bytes of array variable
	move $v0, $t1
	jr $ra

resizeArray:
	lw $t0, 0($a0) #Address of data
	move $t1, $a1 #Old Size
	move $t2, $a2 #New Size
	
	addi $sp, $sp, -16
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t2, 8($sp)
	sw $ra, 12($sp)
	
	move $a0, $t2
	jal createArray
	
	lw $t0, 0($sp)
	lw $t1, 4($sp)
	lw $t2, 8($sp)
	lw $ra, 12($sp)
	addi $sp, $sp, 16
	move $t3, $v0 #Address of the new array with the size of New Size
	lw $t4, 0($t3) #Address of data of new array
	li $t5, 0 #Start index
	
resizeArrayLoop:
	beq $t1,$t5, resizeArrayTerminate
	sll $t2, $t5, 2
	add $t6, $t2, $t0
	lw $t7, 0($t6)
	add $t6, $t2, $t4
	sw $t7, 0($t6)
	addi $t5, $t5, 1
	j resizeArrayLoop
	
resizeArrayTerminate:
	move $v0, $t3
	jr $ra

putElementToArray:
	lw $a0, 0($a0)
	sll $a1, $a1, 2
	add $a1, $a0, $a1
	sw $a2, 0($a1)
	jr $ra
	
removeElementFromArray:
	move $t0, $a0 #Address of the array variable
	move $t1, $a1 #Index of the removed elem
	lw $t2, 0($t0) #Address of data
	lw $t3, 4($t0) #Size of array
	
	sll $t4, $t1, 2
	add $t4, $t4, $t2
	sll $t5, $t3, 2
	add $t5, $t5, $t2
	addi $t5, $t5, -4
removeElementFromArrayLoop:
	beq $t4, $t5, removeElementFromArrayTerminate
	lw $t6, 4($t4)
	sw $t6, 0($t4)
	addi $t4, $t4, 4
	j removeElementFromArrayLoop
	
removeElementFromArrayTerminate:
	addi $t3, $t3, -1 #New Size
	sw $t3, 4($t0)
	jr $ra

createLinkedList:
	li $a0, 8
	li $v0, 9
	syscall
	jr $ra

putElementToLinkedList:
	move $t0, $a0 #Address of first node
	move $t1, $a1
putElementToLinkedListLoop:
	lw $t2, 0($t0) #Address of data of current
	beq $t2, $zero, putElementToLinkedListAddToCurrent
	lw $t2, 4($t0) #Address of current.next 
	beq $t2, $zero, putElementToLinkedListAddToNext
	move $t0, $t2 # current = current.next
	j putElementToLinkedListLoop
putElementToLinkedListAddToNext:
	li $a0, 8
	li $v0, 9
	syscall
	sw $v0, 4($t0)
	sw $t1, 0($v0)
	jr $ra
putElementToLinkedListAddToCurrent:
	sw $t1, 0($t0)
	jr $ra

removeElementFromTheLinkedList:
	move $t0, $a0 #Address of head
	move $t1, $a1 #Index
	lw $t2, 4($t0) # first.next
	beq $t1, $zero, removeElementFromTheLinkedListRemoveHead
	addi $t1, $t1, -1
	beq $t1, $zero, removeElementFromTheLinkedListRemove
	
removeElementFromTheLinkedListLoop:
	lw $t0, 4($t0) #current = current.next
	lw $t2, 4($t0) #next = current.next
	addi $t1, $t1, -1
	beq $t1, $zero, removeElementFromTheLinkedListRemove
	j removeElementFromTheLinkedListLoop
	
removeElementFromTheLinkedListRemove:
	lw $t3, 4($t2) #next.next
	sw $t3, 4($t0) #current.next = next.next
	jr $ra

removeElementFromTheLinkedListRemoveHead:
	lw $t2, 4($t0) #first.next
	beq $t2, $zero, removeElementFromTheLinkedListRemoveHeadData
	lw $t3, 4($t2) #first.next.next
	lw $t4, 0($t2) #first.next.data
	sw $t4, 0($t0) #first.data = first.next.data
	sw $t3, 4($t0) #first.next = first.next.next
	jr $ra
	
removeElementFromTheLinkedListRemoveHeadData:
	sw $zero, 0($t0)
	jr $ra

traverseArray:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	move $t0, $a0 #Address of the function
	move $t1, $a1 #Address of the array
	lw $t2, 4($t1) #Size of array
	lw $t1, 0($t1) #Address of data
	li $t3, 0 #Index
traverseArrayLoop:
	beq $t2, $t3, traverseArrayTerminate
	sll $t4, $t3, 2
	add $t4, $t4, $t1
	
	addi $sp, $sp, -16
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t2, 8($sp)
	sw $t3, 12($sp)
	
	move $a0, $t0
	lw $a1, 0($t4)
	jal traverseLinkedList
	
	lw $t0, 0($sp)
	lw $t1, 4($sp)
	lw $t2, 8($sp)
	lw $t3, 12($sp)
	addi $sp, $sp, 16
	
	addi $t3, $t3, 1
	j traverseArrayLoop
	
	
traverseArrayTerminate:
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra

traverseLinkedList:
	move $t0, $a0 #Address of the function
	move $t1, $a1 #Address of the head
	addi $sp, $sp, -4
	sw $ra, 0($sp)
traverseLinkedListLoop:
	beq $t1, $zero, traverseLinkedListTerminate
	addi $sp, $sp, -8
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	
	lw $a0, 0($t1)
	jalr $t0

	lw $t0, 0($sp)
	lw $t1, 4($sp)
	addi $sp, $sp, 8
	lw $t1, 4($t1)
	j traverseLinkedListLoop
		
traverseLinkedListTerminate:
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra

createSong:
	move $t0, $a0 #Address of the song name
	move $t1, $a1#Duration of the song
	li $a0, 8
	li $v0, 9
	syscall
	sw $t0, 0($v0)
	sw $t1, 4($v0)
	jr $ra

isSong:
	lw $t0, 0($a0) #Name of the song
isSearch1:
	addi $sp, $sp, -8
	sw $t0, 0($sp)
	sw $ra, 4($sp)
	la $a0, search1
	move $a1, $t0
	li $a2, 17 #The length of the search1
	jal compareString
	lw $t0,  0($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 8
	beq $v0, 1, found

isSearch2:
	addi $sp, $sp, -8
	sw $t0, 0($sp)
	sw $ra, 4($sp)
	la $a0, search2
	move $a1, $t0
	li $a2, 17 #The length of the search2
	jal compareString
	lw $t0,  0($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 8
	beq $v0, 1, found
	
notFound:
	li $v0, 4
	la $a0, noSong
	syscall
	jr $ra
found:
	li $v0, 4
	move $a0, $t0
	syscall
	la $a0, foundSong
	syscall
	jr $ra

compareString:
	li $t0, 0
compareStringLoop:
	add $t1, $a0, $t0 
	add $t2, $a1, $t0 
	lb $t3, 0($t1)
	lb $t4, 0($t2)
	bne $t3, $t4, compareStringFalse
	addi $t0, $t0, 1
	beq $t0, $a2, compareStringTrue
	j compareStringLoop

compareStringTrue:
	li $v0, 1
	jr $ra
compareStringFalse:
	li $v0, 0
	jr $ra

printSong:
	li $v0, 4 #Code for printString
	move $t0, $a0 #Address of song
	la $t1, name #Song Name: 
	la $t2, duration #Song Duration: 
	la $t3, newLine
	lw $t4, 0($t0) #Name of the song
	lw $t5, 4($t0) #Duration of the song
	
	move $a0, $t1
	syscall
	move $a0, $t4
	syscall
	move $a0, $t3
	syscall
	
	move $a0, $t2
	syscall
	li $v0, 1
	move $a0, $t5
	syscall
	li $v0, 4
	move $a0, $t3
	syscall
	
	jr $ra



