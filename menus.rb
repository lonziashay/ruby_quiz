module Menus  
def Menus.title
puts <<TITLE
                                     ,,                                                ,,          
              `7MM"""Mq.            *MM                       .g8""8q.                 db          
                MM   `MM.            MM                     .dP'    `YM.                           
                MM   ,M9 `7MM  `7MM  MM,dMMb.`7M'   `MF'    dM'      `MM `7MM  `7MM  `7MM  M"""MMV 
                MMmmdM9    MM    MM  MM    `Mb VA   ,V      MM        MM   MM    MM    MM  '  AMV  
                MM  YM.    MM    MM  MM     M8  VA ,V       MM.      ,MP   MM    MM    MM    AMV   
                MM   `Mb.  MM    MM  MM.   ,M9   VVV        `Mb.    ,dP'   MM    MM    MM   AMV  , 
              .JMML. .JMM. `Mbod"YML.P^YbmdP'    ,V           `"bmmd"'     `Mbod"YML..JMML.AMMmmmM 
                                                ,V                MMb                              
                                             OOb"                  `bood'                          



TITLE
end

def Menus.show_options
  puts ''
  puts "Please select one of the available tests or options".center(100)
  puts ''
puts <<TESTS
                                      ____________________________
                                     |1.) Keywords                |                                 
                                     |2.) Data Types              |
                                     |3.) String Escape Sequences |
                                     |4.) Operators               |
                                     |5.) Leaderboards            |
                                     |6.) Profile                 |
                                     |7.) Exit                    |
                                      ---------------------------- 
TESTS
end

def Menus.leaderboards
puts <<SCORE      
                                                                     :                                    
                                                       .      .,    t#,                       ,;         .
 .    .      t           .Gt .    .                    ;W     ,Wt   ;##W.   j.               f#i         ;W
 Di   Dt     Ej         j#W: Di   Dt                  f#E    i#D.  :#L:WE   EW,            .E#t         f#E
 E#i  E#i    E#,      ;K#f   E#i  E#i               .E#f    f#f   .KG  ,#D  E##j          i#W,        .E#f 
 E#t  E#t    E#t    .G#D.    E#t  E#t              iWW;   .D#i    EE    ;#f E###D.       L#D.        iWW;  
 E#t  E#t    E#t   j#K;      E#t  E#t             L##Lffi:KW,    f#.     t#iE#jG#W;    :K#Wfff;     L##Lffi
 E########f. E#t ,K#f   ,GD; E########f.         tLLG##L t#f     :#G     GK E#t t##f   i##WLLLLt   tLLG##L 
 E#j..K#j... E#t  j#Wi   E#t E#j..K#j...           ,W#i   ;#G     ;#L   LW. E#t  :K#E:  .E#L         ,W#i  
 E#t  E#t    E#t   .G#D: E#t E#t  E#t             j#E.     :KE.    t#f f#:  E#KDDDD###i   f#E:      j#E.   
 E#t  E#t    E#t     ,K#fK#t E#t  E#t           .D#j        .DW:    f#D#;   E#f,t#Wi,,,    ,WW;   .D#j     
 f#t  f#t    E#t       j###t f#t  f#t          ,WK,           L#,    G#t    E#t  ;#W:       .D#; ,WK,      
  ii   ii    E#t        .G#t  ii   ii          EG.             jt     t     DWi   ,KK:        tt EG.       
             ,;.          ;;                   ,                                                 ,         
                                                                                                          
                 

SCORE
end
    
end