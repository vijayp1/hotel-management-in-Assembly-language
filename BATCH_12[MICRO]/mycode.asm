org 100h
.model small

.stack 100h

.data

menu:DB "WELCOME TO HOTEL",0Dh,0Ah
      DB 0Dh,0Ah,"1 - Room Reservation",0Dh,0Ah
      DB "2 - Food Service",0Dh,0Ah 
      DB "3 - Room Service",0Dh,0Ah
      DB "4 - Taxi Booking",0Dh,0Ah
      DB "5 - Produce Bill",0Dh,0Ah
      DB "6 - Exit",0Dh,0Ah,
      DB 0Dh,0Ah,"please choose : ",'$'
      
category:DB 0Dh,0Ah,"VIP PACKAGE(FOR 3 DAYS)  -      RS.9000: ",0Dh,0Ah
        DB 0Dh,0Ah,"1 - VIP HOTEL",0Dh,0Ah
        DB "2 - UNLIMITED FOOD FOR 3 DAYS",0Dh,0Ah
        DB "3 - ROOM SERVICE ONCE PER DAY",0Dh,0Ah
        DB "4 - FREE CAB TO TRAVEL WHILE CHECKING OUT",0Dh,0Ah
        DB 0Dh,0Ah,"NORMAL PACKAGE:",0Dh,0Ah
        DB 0Dh,0Ah,"1 - Hotel cost varies depending on days os stay",0Dh,0Ah
        DB "2 - No free food",0Dh,0Ah
        DB "3 - book room service separately",0Dh,0Ah
        DB "4 - no free cab provided",0Dh,0Ah,0Dh,0Ah
        DB "AVAILABLE ROOMS ARE:",0Dh,0Ah
        DB "1 - NORMAL ROOM",0Dh,0Ah
        DB "2 - NORMAL ROOM",0Dh,0Ah
        DB "3 - SPECIAL ROOM",0Dh,0Ah,0Dh,0Ah
        DB "SELECT YOUR CHOICE : ",'$'
        
    
Crlf DB 0Dh,0Ah,'$'

period_info: DB 0Dh,0Ah,0Dh,0Ah,"Room cost for 1 DAY - RS.3000",0Dh,0Ah
             DB "Room cost for 2 DAY - RS.5000",0Dh,0Ah
             DB "Room cost for 3 DAY - RS.7000",0Dh,0Ah
             DB 0Dh,0Ah,"Enter no.of Days of stay : ",'$'              
            
room_no DB 0Dh,0Ah,"book room number : ",'$'

food_menu: DB 0Dh,0Ah,"1 - Noodles   RS.80/-",0Dh,0Ah
           DB "2 - Biryani   RS.160/-",0Dh,0Ah
           DB "3 - Pizza     RS.110/-",0Dh,0Ah
           DB "4 - Meals      RS.60/-",0Dh,0Ah
           DB "5 - Drink     RS.30/-",0Dh,0Ah
           DB 0Dh,0Ah,"Please Choose : ",'$'
           
enter_quantity DB 0Dh,0Ah,"Enter Quantity : ",'$'

food DB 50 DUP(?)

date DB 0Dh,0Ah,"Enter DATE : ",'$' 

room_service:DB 0Dh,0Ah,"1 - Morning  RS.90/-",0Dh,0Ah
           DB "2 - Afternoon  RS.120/-",0Dh,0Ah
           DB "3 - Evening  RS.100/-",0Dh,0Ah,0Dh,0Ah
           DB 0Dh,0Ah,"Please Choose service time : ",'$' 
           
enter_room DB 0Dh,0Ah,"Enter room number : ",'$'

rooms DB 0Dh,0Ah,"Rooms available are 1-5",'$'

e_q DB 0Dh,0Ah,"Room service booked",'$'
neq DB 0Dh,0Ah,"Please enter occupied room number",'$'

invalid DB 0Dh,0Ah,"Invalid Number ",'$'          

taxi_registered DB 0Dh,0Ah,"Taxi Booked",'$'

total_bill DB 0Dh,0Ah,"Total bill : ",'$'

quantity DB 0Dh,0Ah,"Enter Quantity : ",'$'

dateofjourney DB 0Dh,0Ah,"Enter date of journey : ",'$'

visit_again DB 0Dh,0Ah,0Dh,0Ah,"THANK YOU! VISIT AGAIN",'$'

dest DB 0Dh,0Ah,"Destination : ",'$'

taxicost DB 0Dh,0Ah,"COST OF TAXI    -    RS.500/-",'$'

occupied DB 0Dh,0Ah,"ROOM IS OCCUPIED",'$'

unoccupied DB 0Dh,0Ah,"ROOM IS UNOCCUPIED",'$'
  
quan Dw 0
room_price DW 0 
days DB 0
room DB 0
sr DB 0
food_no DB 0
bill Dw 0
nor1 dw 0
nor2 dw 0
spec dw 0

temp DW 0
doj dw 10 dup(?)
destination dw 15 dup(?)

.code

begin:
    mov ax,@data
    mov ds,ax
    
start:
    
    mov dx,offset CRLF
    mov AH,9
    INT 21H
    
    
    mov dx,offset menu
    mov ah,09h
    INT 21h
    
    mov ah,1
    INT 21h
    
    cmp al,'1'
    je FIRST_CHOICE
    
    cmp al,'2'
    je SECOND_CHOICE
    
    cmp al,'3'
    je THIRD_CHOICE
    
    cmp al,'4'
    je FOURTH_CHOICE
    
    cmp al,'5'
    je FIFTH_CHOICE
    
    cmp al,'6'
    je SIXTH_CHOICE
    
    mov dx,offset invalid
    mov ah,9
    int 21h
    
    jmp start
    
   
FIRST_CHOICE:
    mov dx,offset category
    mov ah,9
    int 21h
    
    mov ah,1
    int 21h
    
    cmp al,'1'
    je normal
    
    cmp al,'2'
    je normal
    
    cmp al,'3'
    je special
    
    mov dx,offset invalid
    mov ah,9
    int 21h
    
    jmp start
    
    special:
        mov ax,spec
        
        cmp al,0
        jne filled
        
        mov spec,9000
        
        mov dx,offset e_q
        mov ah,9
        int 21h
        
        jmp start
    normal:
        cmp al,'1'
        je n1
        
        cmp al,'2'
        je n2
        
        n1:
            mov ax,nor1
            cmp ax,0
            jne filled
            mov si,offset nor1
            jmp con
        n2:
            mov ax,nor2
            cmp ax,0
            jne filled
            mov si,offset nor2
            jmp con
        con:    
        mov dx,offset period_info
        mov ah,9
        INT 21h
        
        mov ah,1
        int 21h
        
        cmp al,'1'
        je one_day
        
        cmp al,'2'
        je two_day
        
        cmp al,'3'
        je three_day
        
        one_day:
            mov ax,3000
            mov room_price,ax
            mov days,1
            mov [si],ax
            jmp ret
        two_day:
            mov ax,5000
            mov room_price,ax
            mov [si],ax
            mov days,2
            jmp ret
        three_day:
            mov ax,7000
            mov room_price,ax
            mov [si],ax
            mov days,3
            jmp ret
        
        ret:
            
             
           
            
            mov dx,offset e_q
            mov ah,9
            int 21h
            
            jmp start
            
filled:
    mov dx,offset occupied
    mov ah,9
    int 21h       
    jmp start

unfilled:
    mov dx,offset unoccupied
    mov ah,9
    int 21h
    jmp start    

SECOND_CHOICE:
    mov dx,offset enter_room
    mov ah,9
    INT 21h
    
    mov ah,1
    int 21h
    
    cmp al,'1'
    je normal1
    
    cmp al,'2'
    je normal2
    
    
    mov dx,offset invalid
    mov ah,9
    int 21h
    
    jmp start
    
    normal1:
        mov ax,nor1
        
        cmp al,0
        je unfilled
        
        mov si,offset nor1
        
        jmp scon
        
    normal2:
        mov ax,nor2
        
        cmp al,0
        je unfilled
        
        mov si,offset nor2
        
        jmp scon
    scon:
    mov dx,food_menu
    mov ah,9
    int 21h
       
    mov ah,1
    int 21h
    
    mov temp,ax
    
    mov dx,offset quantity
    mov ah,9
    int 21h
        
    mov ax,0
    mov ah,1
    int 21h
        
    and al,0fh
        
    mov ah,0
    
    mov quan,ax
    
    mov ax,temp
    
    cmp al,'1'
    je noodles
    
    cmp al,'2'
    je biryani
    
    cmp al,'3'
    je pizza
    
    cmp al,'4'
    je meals
    
    cmp al,'5'
    je drink
    
    mov dx,offset invalid
    mov ah,9
    int 21h
    
    jmp SECOND_CHOICE
    
    noodles:
        mov bx,80
        
        mov ax,quan
        
        mul bx
        
        mov bx,[si]
        
        add ax,bx
        
        mov [si],ax
        
        jmp start
    biryani:
        mov bx,160
        
        mov ax,quan
        mul bx
        
        mov bx,[si]
        
        add ax,bx
        mov [si],ax
        jmp start
    pizza:
        mov bx,110
        mov ax,quan
        mul bx
        
        mov bx,[si]
        
        add ax,bx
        mov [si],ax
        jmp start    
    meals:
        mov bx,60
        mov ax,quan
        mul bx
        
        mov bx,[si]
        
        add ax,bx
        mov [si],ax
        jmp start       
    drink:
        mov bx,30
        mov ax,quan
        mul bx
        
        mov bx,[si]
        
        add ax,bx
        mov [si],ax
        jmp start
  

THIRD_CHOICE:
    mov dx,offset enter_room
    mov ah,9
    INT 21h
    
    mov ah,1
    int 21h
    
    cmp al,'1'
    je tnormal1
    
    cmp al,'2'
    je tnormal2
    
    
    mov dx,offset invalid
    mov ah,9
    int 21h
    
    jmp start
    
    tnormal1:
        mov ax,nor1
        
        cmp al,0
        je unfilled
        
        mov si,offset nor1
        
        jmp tcon
        
    tnormal2:
        mov ax,nor2
        
        cmp al,0
        je unfilled
        
        mov si,offset nor2
        
        jmp tcon
          
    tcon: 
    mov dx,offset room_service
    mov ah,9
    int 21h
    
    mov ah,1
    int 21h
    
    cmp al,'1'
    je morning
    
    cmp al,'2'
    je afternoon
    
    cmp al,'3'
    je evening
    
    mov dx,offset invalid
    mov ah,9
    int 21h
    
    jmp start
    
    wrong_room:
        mov dx,offset invalid
        mov ah,9
        int 21h   
               
        jmp start
        
    morning:
        mov ax,90
        mov bx,[si]
        add ax,bx
        mov [si],ax
        
        jmp start
    afternoon:
        mov ax,120
        mov bx,[si]
        add ax,bx
        mov [si],ax
        
        jmp start
    evening:
        mov ax,100
        mov bx,[si]
        add ax,bx
        mov [si],ax
        
        jmp start

FOURTH_CHOICE:
    mov dx,offset enter_room
    mov ah,9
    INT 21h
    
    mov ah,1
    int 21h
    
    cmp al,'1'
    je fnormal1
    
    cmp al,'2'
    je fnormal2
    
    
    mov dx,offset invalid
    mov ah,9
    int 21h
    
    jmp start
    
    fnormal1:
        mov ax,nor1
        
        cmp al,0
        je unfilled
        
        mov si,offset nor1
        
        jmp fcon
        
    fnormal2:
        mov ax,nor2
        
        cmp al,0
        je unfilled
        
        mov si,offset nor2
        
        jmp fcon
    fcon:
    mov ax,[si]
    
    mov bx,500
    
    add ax,bx
    
    mov [si],ax
    
    mov dx,offset taxicost
    mov ah,9
    int 21h
    
    mov dx,offset dateofjourney
    mov ah,9
    int 21h
    
    mov si,offset doj
    
    
    
    input:
        mov ah,1
        int 21h
        cmp al,13
        je disp
        mov [si],al
        inc si
        jmp input
    
    disp:
        mov [si],'$'
    
    mov dx,offset dest
    mov ah,9
    int 21h
    
    mov si,offset destination
    
    input2:
        mov ah,1
        int 21h
        cmp al,13
        je disp2
        mov [si],al
        inc si
        jmp input2
    
    disp2:
        mov [si],'$'
    
    jmp start
 

FIFTH_CHOICE:
    
    mov dx,offset enter_room
    mov ah,9
    INT 21h
    
    mov ah,1
    int 21h
    
    cmp al,'1'
    je fn1
    
    cmp al,'2'
    je fn2
    
    cmp al,'3'
    je fis
    
    mov dx,offset invalid
    mov ah,9
    int 21h
    
    jmp start
    
    fn1:
        mov ax,nor1
        
        cmp al,0
        je unfilled
        
        mov si,offset nor1
        
        jmp fi
        
    fn2:
        mov ax,nor2
        
        cmp al,0
        je unfilled
        
        mov si,offset nor2
        
        jmp fi
        
    fis:
        mov ax,spec
        
        cmp al,0
        je unfilled
        
        mov si,offset spec
        jmp fi
    
    fi:
    
    mov dx,offset total_bill
    mov ah,9
    int 21h
    
    mov ax,[si]
    call printud
    
    jmp start
    
    
SIXTH_CHOICE:
    mov ax,4c00h
    int 21h
    

;--------------------------------------------

printud  proc
    push    ax  
    push    bx
    push    cx    
    push    dx

    mov     dx, 0
    mov     cx, 10
    div     cx

    cmp     ax, 0
    jne     L4

    add     dl, '0'
    mov     ah, 2
    int     21h

    jmp     L5

L4:
    call    printud
    add     dl, '0'
    mov     ah, 2
    int     21h        

L5:
    pop     dx
    pop     cx
    pop     bx
    pop     ax
    ret
printud  endp