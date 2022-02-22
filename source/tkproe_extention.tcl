#====================================================
#    tkproextention.tcl for tkproe.tcl
# Vladimir Orlov, 04/02/2022, email: vorlov@lissi.ru
#====================================================

global macos
set macos 0
switch [tk windowingsystem] {
    classic - aqua {
	    set macos 1
    }
}


global TPpressLab
set TPpressLab ""
proc TP_saveOneImage {type} {
    global TPtoolpath
    global TPbboxL
    set cur [$TPtoolpath find withtag current]
#    puts "TP_saveOneImage: $TPbboxL Current=$cur type=$type"
    TP_saveGroupToFileOrImage $type $cur
}
# Procedure: TP_DTsaveoneimage_bind
proc TP_DTsaveoneimage_bind { cname} {
    global TPB1_press_list
    global TPB1_release_list

    if {[lsearch $TPB1_press_list group] == -1} {lappend TPB1_press_list saveoneimage}
    if {[lsearch $TPB1_release_list move] == -1} {lappend TPB1_release_list endsaveoneimage}
}
proc TP_DTsaveonefile_bind { cname} {
    global TPB1_press_list
    global TPB1_release_list

    if {[lsearch $TPB1_press_list group] == -1} {lappend TPB1_press_list saveoneimage}
    if {[lsearch $TPB1_release_list move] == -1} {lappend TPB1_release_list endsaveonefile}
}
#Всплывающая подсказка
proc TP_popupHint {wname msg {anchor nw}} {
# Create the necessary bindings for pop-up help on the specified widget.
    if {[winfo exists $wname]} {
	bind $wname <Enter> [list TP_hintShow %W $msg $anchor]
	bind $wname <Leave> [list TP_hintHide %W]
   }
    return {}
}
proc TP_hintHide {wname} {
    set wtop $wname
    while {1} {
	if {[TP_ClassGet $wtop] == "Toplevel"} {break}   
	set wtop [winfo parent $wtop]
    }
# Hide the help windows.
    if {[winfo exists $wtop.tppopuphelp]} {
	destroy $wtop.tppopuphelp
    }
    return
}
proc TP_hintShow {wname msg anchor} {
# Hide the help windows.
    global TPhelpmsg
    global tcl_platform
    set fmsg {Helvertica 8}
    set Xpos [winfo pointerx $wname]
    set Ypos [winfo pointery $wname]
    set curwin [winfo containing $Xpos $Ypos]
    if {$curwin eq $wname} {
	set TPhelpmsg $msg
	set wtop $wname
	while {1} {
	    if {[TP_ClassGet $wtop] == "Toplevel"} {break}   
	    set wtop [winfo parent $wtop]
	}
        if {![winfo exists $wtop.tppopuphelp]} {
#Ширина оконтовки
    	    set bdl 1
#	    regexp {(\d*)x(\d*)\+(\d*)\+(\d*)} [winfo geometry $wtop] -> w h x y
	    regexp {(\d*)x(\d*)\+(\d*)\+(\d*)} [wm geometry $wtop] -> w h x y
	    set lenmsg [font measure $fmsg $msg]
	    set Xpos [winfo rootx $wname]
	    if {[expr {$Xpos + $lenmsg + 4 * $bdl}] > [expr {$x + $w}]} {
		set Xpos [expr {($x + $w) - ($Xpos + $lenmsg + 4 * $bdl)}]
	    } else {
		set Xpos 0
	    }
    	    set Ypos [winfo rooty $wname]

#    	    label $wtop.tppopuphelp -font $fmsg -bg cornsilk -fg black -borderwidth 1 -relief solid -textvariable TPhelpmsg
    	    label $wtop.tppopuphelp -font $fmsg -bg cyan1 -fg black -borderwidth $bdl -relief solid -textvariable TPhelpmsg
	    set Ypos [expr {[font metrics $fmsg -ascent] + [font metrics $fmsg -descent]}]
	    place $wtop.tppopuphelp -in $wname -x $Xpos -y -$Ypos
        }
   }
    return {}
}



#Для всех платформ одинаково!!!
#	    set macos 1
proc TP_ShowContextMenuOSX {w } {
    global TPpressLab
    if {$TPpressLab != ""} {
#	catch {$TPpressLab.m unpost}
	$TPpressLab configure -background blue4 -foreground white
    }
    set TPpressLab $w
    set x1 [winfo rootx $w]
    set y1 [winfo rooty $w]
    incr y1 [winfo height $w]
    tk_popup $w.m $x1 $y1
#	$w.m post $x1 $y1
#	update idletasks
    unset x1
    unset y1
}
set TP_History     {}

set Graphics(arrowshape) {8 10 4}
set Graphics(fill,color) {}
set Graphics(fill,style) {}
set Graphics(font,bold) 0
set Graphics(font,color) black
set Graphics(font,italic) 0
set Graphics(font,normal) 0
set Graphics(font,overstrike) 0
set Graphics(font,roman) 0
set Graphics(font,size) 10
set Graphics(font,stipple) {}
set Graphics(font,style) {}
set Graphics(font,type) Helvetica
set Graphics(font,underline) 0
set Graphics(grid,on) 0
set Graphics(grid,size) 10m
set Graphics(grid,snap) 1
set Graphics(line,arrow) none
set Graphics(line,capstyle) butt
set Graphics(line,color) black
set Graphics(line,joinstyle) miter
set Graphics(line,smooth) 0
set Graphics(line,style) {}
set Graphics(line,width) 2
set Graphics(mode) NULL
set Graphics(shape) polygon
set Graphics(snap,on) 0
set Graphics(snap,size) 1
set Graphics(splinesteps) 20
set Graphics(text,anchor) c
set Graphics(ticks,on) 0
set Graphics(mode) NULL
### End of Graphics parameters


set Zoom(button,text) 100%
set Zoom(caller) {}
set Zoom(factor) 1
set Zoom(font,size) 10
set Zoom(selected,button) 1
set utagCounter 2


set Image(ctr) 0


set Canv(H) 366
set Canv(W) 707
set Canv(SH) 1500
set Canv(SW) 1500
set Canv(bg) #ffff8e

set TPFile(progress) 0
global TPrectRound
set TPrectRound 0
##############TPMessage############################
   set TPMessage(1) "Copyright 1998 Samy Zafrany, all rights reserved"
   set TPMessage(2) "Netanya Academic College, Israel"
   set TPMessage(3) "Copyright 1998 Samy Zafrany, all rights reserved"
   set TPMessage(4) "samy@netanya.ac.il"
   set TPMessage(5) "Copyright 1998 Samy Zafrany, all rights reserved"
   set TPMessage(6) "New releases: www.netanya.ac.il/~samy/tkpaint.html"
   set TPMessage(7) "http://www.netanya.ac.il/~samy/tkpaint.html"
   set TPMessage(8) "Copyright 1998 Samy Zafrany, all rights reserved"
   set TPMessage(9) "ftp.neosoft.com/pub/tcl/sorted/graphics/tkpaint"
   set TPMessage(10) "www.neosoft.com/tcl/ftparchive/sorted/graphics/tkpaint"
   set TPMessage(last) 10
   set TPMessage(ctr) 1
   set TPMessage(text) $TPMessage(1)


##############################################ЭТО ОСНОВНОЕ===========================
############## GROUP SECTION:
# DELETE, MOVE, COPY, RAISE, LOWER, ...
# OPERATIONS ON GROUPS OF OBJECTS
# HERE WE DEFINE PROCEDURES FOR SELECTING A GROUP OF OBJECTS,
# DELETING, COPYING, RESIZING, ... A GROUP OF OBJECTS


proc TP_SelectGroupMode {} {
#LISSI
  global TPtoolpath
  global TPcurCanvas
  $TPtoolpath delete reshapeHandle
  TPdelUtagReshape

  global TPselectBox
  $TPtoolpath delete graybox
  $TPtoolpath dtag obj Selected
  $TPtoolpath configure -cursor ""
  bind $TPtoolpath <Button-1> {
        catch {unset TPselectBox}
        $TPtoolpath delete graybox
        $TPtoolpath dtag obj Selected
        set TPselectBox(x1) [$TPtoolpath canvasx %x]
        set TPselectBox(y1) [$TPtoolpath canvasy %y]
        set TPselectBox(x2) [$TPtoolpath canvasx %x]
        set TPselectBox(y2) [$TPtoolpath canvasy %y]
  }
  bind $TPtoolpath <B1-Motion> {TP_drawSelectionBox [$TPtoolpath canvasx %x] [$TPtoolpath canvasy %y]}
if {1} {
  bind $TPtoolpath <B1-ButtonRelease> {
      TP_setBoundingBox
      TP_setEditGroupMode
  }
}
  bind $TPtoolpath <Button-3> {
	global TPgroup
puts "TP_SelectGroupMode: TPgroup=$TPgroup"
        catch {unset TPselectBox}
        $TPtoolpath delete graybox
        TPdelUtagGrp
        TP_CanvasObjListFill $TPcurCanvas
  }
  TP_Message "Draw a rectangle arround the objects you want to edit"
}
proc TPdelUtagGrp {} {
#    global TPgroup
    global TPtoolpath
#    $TPtoolpath dtag obj Selected

    set req "utag\[0-9\]+ obj"
    set objInfo [TP_CanvasObjListGet $TPtoolpath]
    foreach obj $objInfo {
	foreach {ID tags type} $obj {}
	regsub $req $tags "" tagsNew
	regsub Selected $tagsNew "" tagsNew
	$TPtoolpath itemconfigure $ID -tags $tagsNew
    }
}

proc TP_drawSelectionBox {x y} {
  global TPtoolpath
  global TPselectBox
  set TPselectBox(x2) $x
  set TPselectBox(y2) $y
  catch {$TPtoolpath delete $TPselectBox(id)}
  set TPselectBox(id) [$TPtoolpath create rectangle $TPselectBox(x1) $TPselectBox(y1) \
                                        $TPselectBox(x2) $TPselectBox(y2) \
                -width 1 \
                -tags TPselectBox ]
}

proc TP_setBoundingBox {} {
#LISSI
  global TPtoolpath

  global TPselectBox

  set enclosed [$TPtoolpath find enclosed $TPselectBox(x1) $TPselectBox(y1) \
                              $TPselectBox(x2) $TPselectBox(y2)]

#puts "TP_setBoundingBox: $TPselectBox(x1) $TPselectBox(y1) $TPselectBox(x2) $TPselectBox(y2)"
#puts "TP_setBoundingBox: enclosed=$enclosed"
  set TPgroup {}
#Список объектов в canvas
if {1} {
  set objInfo [TP_CanvasObjListGet $TPtoolpath]
  foreach obj $objInfo {
	foreach {ID tags type} $obj {}
	if {[lsearch [$TPtoolpath itemcget $ID -tags] obj]<0} {
    	    set utag [TP_Utag assign $ID]
    	}
#	puts "TP_setBoundingBox: type=<$type> ID=$ID tags=$tags"
  }
}

  foreach id $enclosed {
     if {[lsearch [$TPtoolpath itemcget $id -tags] obj]<0} {continue}
     lappend TPgroup $id
  }
  $TPtoolpath delete TPselectBox
  unset TPselectBox

  if {[llength $TPgroup]==0} {
    TP_Message "No objects selected. Try again."
    return
  }
  
  foreach id $TPgroup {
     $TPtoolpath addtag Selected withtag $id
  }
  TP_drawBoundingBox
}


proc TP_drawBoundingBox {} {
#LISSI
  global TPtoolpath
  global macos

  global TP_BBox

  $TPtoolpath delete graybox
  set bbox [$TPtoolpath bbox Selected]
  set TP_BBox(x1) [lindex $bbox 0]
  set TP_BBox(y1) [lindex $bbox 1]
  set TP_BBox(x2) [lindex $bbox 2]
  set TP_BBox(y2) [lindex $bbox 3]

  set x1 $TP_BBox(x1)
  set y1 $TP_BBox(y1)
  set x2 $TP_BBox(x2)
  set y2 $TP_BBox(y2)
  if {$macos} {
    TP_drawGrayBox $x1 $y1 $x2 $y2 "" gray12 mainTP_BBox
  } else {
    TP_drawGrayBox $x1 $y1 $x2 $y2 gray60 gray12 mainTP_BBox
  }
  
# Now we create the 8 small rectangles (handles) around the main TP_BBox.
# Naming the boxes is based on:
#    NW   North NE
#           *
#    West * * * East
#           *
#    SW   South SE
  set a 14
  set midx [expr ($x1+$x2-$a)/2]
  set midy [expr ($y1+$y2-$a)/2]
  foreach {X1 Y1 X2 Y2 tag} "
      [expr $x1-$a] [expr $y1-$a] $x1 $y1       nwHandle
      $x2 $y2 [expr $x2+$a] [expr $y2+$a]       seHandle
      $x2 $y1 [expr $x2+$a] [expr $y1-$a]       neHandle
      [expr $x1-$a] [expr $y2+$a] $x1 $y2       swHandle
      $midx $y1 [expr $midx+$a] [expr $y1-$a]   nHandle
      $midx [expr $y2+$a] [expr $midx+$a] $y2   sHandle
      [expr $x1-$a] $midy $x1 [expr $midy+$a]   wHandle
      $x2 $midy [expr $x2+$a] [expr $midy+$a]   eHandle
  " {
     TP_drawGrayBox $X1 $Y1 $X2 $Y2 black gray50 $tag
  }
  $TPtoolpath raise graybox
  $TPtoolpath raise mainTP_BBox
#  $TPtoolpath raise gridObject
  TP_Message "Use mouse to drag, resize. More acts click \"Group\"."
}


proc TP_setEditGroupMode {} {
   global TPtoolpath
   global TPgroup
   set TPgroup [$TPtoolpath find withtag Selected]
   if {0==[llength $TPgroup]} {return}
   global TP_BBox Graphics TPlastX TPlastY
   set TP_BBox(action) none

   foreach {tag curs side} {
      nHandle   top_side             n
      sHandle   bottom_side          s
      wHandle   left_side            w
      eHandle   right_side           e
      nwHandle  top_left_corner      nw
      neHandle  top_right_corner     ne
      swHandle  bottom_left_corner   sw
      seHandle  bottom_right_corner  se
   } {
       $TPtoolpath bind $tag <Enter> "%W configure -cursor $curs"

       $TPtoolpath bind $tag <Leave> {
            %W configure -cursor ""
        }

       $TPtoolpath bind $tag <Button-1> "TP_HandlesButton1-bind $side $curs"
   }

   $TPtoolpath bind mainTP_BBox <Enter> {%W configure -cursor fleur}
   $TPtoolpath bind mainTP_BBox <Leave> {%W configure -cursor ""}
   $TPtoolpath bind mainTP_BBox <Button-1> {
           set TP_BBox(action) move
           %W configure -cursor fleur
           set TP_BBox(undo) [TP_getGroupCommand 1]
   }
   $TPtoolpath bind mainTP_BBox <B1-ButtonRelease> {catch {unset TPlastX TPlastY}}

   bind $TPtoolpath <Button-1> {
      set TPlastX [$TPtoolpath canvasx %x $Graphics(grid,snap)]
      set TPlastY [$TPtoolpath canvasy %y $Graphics(grid,snap)]
   }

   bind $TPtoolpath <B1-Motion> {
      switch -exact -- $TP_BBox(action) {
           move {
#             set x [$TPtoolpath canvasx %x $Graphics(grid,snap)]
#             set y [$TPtoolpath canvasy %y $Graphics(grid,snap)]
#             TP_moveGroup $x $y
             TP_moveGroup [$TPtoolpath canvasx %x $Graphics(grid,snap)] [$TPtoolpath canvasy %y $Graphics(grid,snap)]
           }
           none {
             set TPselectBox(x1) [$TPtoolpath canvasx %x]
             set TPselectBox(y1) [$TPtoolpath canvasy %y]
             set TPselectBox(x2) [$TPtoolpath canvasx %x]
             set TPselectBox(y2) [$TPtoolpath canvasy %y]
             TP_SelectGroupMode
           }
           default {
             TP_scaleGroup [$TPtoolpath canvasx %x] [$TPtoolpath canvasy %y]
           }
      }
   }

   bind $TPtoolpath <B1-ButtonRelease> {
       set TP_BBox(action) none
       catch {unset TPlastX TPlastY}
       %W configure -cursor ""
#LISSI
if {0} {
       set cmd [TP_getGroupCommand 1]
       global TP_History
       if {$cmd!="[lindex $TP_History end]"} {
            TP_History add [TP_getGroupCommand 1]
            Undo add $TP_BBox(undo)
       }
}
   }
}


proc TP_drawGrayBox { x1 y1 x2 y2 col stip tag} {
  global TPtoolpath
  return [$TPtoolpath create rectangle $x1 $y1 $x2 $y2 \
                -outline {} \
                -fill $col \
                -stipple $stip \
                -tags "graybox $tag"]
#  .c raise gridObject
}


proc TP_HandlesButton1-bind { side cursor} {
  global TPtoolpath
  global TP_BBox
  set TP_BBox(action) $side
  $TPtoolpath configure -cursor $cursor
  set TP_BBox(undo) [TP_getGroupCommand 1]
  set TP_BBox(xscale) 1
  foreach id [$TPtoolpath find withtag Selected] {
      if {[catch {$TPtoolpath itemcget $id -font} result]==0} {
            set u [TP_Utag find $id]
            set TP_BBox($u,fontsize) [lindex $result 1]
      }
  }
}



proc TP_scaleGroup { x y} {
   global TPtoolpath
   global TP_BBox TPlastX1 TPlastY1 TPlastX2 TPlastY2
   switch -exact -- $TP_BBox(action) {
      none  { return }
      n    { if {abs($y-$TP_BBox(y1))<2} {return} }
      s    { if {abs($y-$TP_BBox(y2))<2} {return} }
      w    { if {abs($x-$TP_BBox(x1))<2} {return} }
      e    { if {abs($x-$TP_BBox(x2))<2} {return} }
      ne   { if {abs($x-$TP_BBox(x2))<2 || abs($y-$TP_BBox(y1))<2} {return} }
      nw   { if {abs($x-$TP_BBox(x1))<2 || abs($y-$TP_BBox(y1))<2} {return} }
      se   { if {abs($x-$TP_BBox(x2))<2 || abs($y-$TP_BBox(y2))<2} {return} }
      sw   { if {abs($x-$TP_BBox(x1))<2 || abs($y-$TP_BBox(y2))<2} {return} }
   }

   set TPlastX1 $TP_BBox(x1)
   set TPlastY1 $TP_BBox(y1)
   set TPlastX2 $TP_BBox(x2)
   set TPlastY2 $TP_BBox(y2)

   switch -exact -- $TP_BBox(action) {
      none  { return }
      n    { set TP_BBox(y1) $y
             set xOrigin $TP_BBox(x1)
             set yOrigin $TP_BBox(y2)
             set xScale  1.0
             set yScale  [TP_getRatio $TPlastY2 $TPlastY1 $TP_BBox(y2) $TP_BBox(y1)]
      }

      s    { set TP_BBox(y2) $y
             set xOrigin $TP_BBox(x1)
             set yOrigin $TP_BBox(y1)
             set xScale  1.0
             set yScale  [TP_getRatio $TPlastY2 $TPlastY1 $TP_BBox(y2) $TP_BBox(y1)]
      }

      w    { set TP_BBox(x1) $x
             set xOrigin $TP_BBox(x2)
             set yOrigin $TP_BBox(y1)
             set xScale  [TP_getRatio $TPlastX2 $TPlastX1 $TP_BBox(x2) $TP_BBox(x1)]
             set yScale  1.0
      }

      e    { set TP_BBox(x2) $x
             set xOrigin $TP_BBox(x1)
             set yOrigin $TP_BBox(y1)
             set xScale  [TP_getRatio $TPlastX2 $TPlastX1 $TP_BBox(x2) $TP_BBox(x1)]
             set yScale  1.0
      }

      ne   { set TP_BBox(y1) $y
             set xOrigin $TP_BBox(x1)
             set yOrigin $TP_BBox(y2)
             set xScale  [TP_getRatio $TPlastY2 $TPlastY1 $TP_BBox(y2) $TP_BBox(y1)]
             set yScale  $xScale
             set TP_BBox(x2) [expr $TPlastX1+($TPlastX2-$TPlastX1)*$xScale]
      }

      nw   { set TP_BBox(y1) $y
             set xOrigin $TP_BBox(x2)
             set yOrigin $TP_BBox(y2)
             set xScale  [TP_getRatio $TPlastY2 $TPlastY1 $TP_BBox(y2) $TP_BBox(y1)]
             set yScale  $xScale
             set TP_BBox(x1) [expr $TPlastX2-($TPlastX2-$TPlastX1)*$xScale]
      }

      se   { set TP_BBox(y2) $y
             set xOrigin $TP_BBox(x1)
             set yOrigin $TP_BBox(y1)
             set xScale  [TP_getRatio $TPlastY2 $TPlastY1 $TP_BBox(y2) $TP_BBox(y1)]
             set yScale  $xScale
             set TP_BBox(x2) [expr $TPlastX1+($TPlastX2-$TPlastX1)*$xScale]
      }

      sw   { set TP_BBox(y2) $y
             set xOrigin $TP_BBox(x2)
             set yOrigin $TP_BBox(y1)
             set xScale  [TP_getRatio $TPlastY2 $TPlastY1 $TP_BBox(y2) $TP_BBox(y1)]
             set yScale  $xScale
             set TP_BBox(x1) [expr $TPlastX2-($TPlastX2-$TPlastX1)*$xScale]
      }
   }

   $TPtoolpath scale Selected $xOrigin $yOrigin $xScale $yScale
   set TP_BBox(xscale) [expr $xScale*$TP_BBox(xscale)]

   foreach id [$TPtoolpath find withtag Selected] {
      if {[catch {$TPtoolpath itemcget $id -font} result]==0} {
        set u [TP_Utag find $id]
        set fsize [expr round($TP_BBox($u,fontsize)*$TP_BBox(xscale))]
        if {$fsize != [lindex $result 1]} {
            $TPtoolpath itemconfig $id -font [lreplace $result 1 1 $fsize]
        }
      }
   }
   TP_drawBoundingBox
}

proc TP_getRatio {a b c d} {
  set ratio [expr ($c-$d+0.0)/($a-$b+0.0)]
  if {$ratio==0} {
    return 0.01
  }
  return $ratio
}

proc TP_Message {msg} {
puts "$msg"
#return
   global TPMessage
   if [info exists TPMessage(jobid)] {
        after cancel $TPMessage(jobid)
   }
   set TPMessage(text) $msg
   set TPMessage(jobid) [after 5000 {
       if {$TPMessage(ctr)==$TPMessage(last)} {
            set TPMessage(ctr) 1
       } else {
            incr TPMessage(ctr)
       }
       set i $TPMessage(ctr)
       set TPMessage(text) $TPMessage($i)
       unset TPMessage(jobid)
       unset i
   }]
}

# LOOK AT THE getObjectOptions proc for an explanation about the "flag" arg.
# FIXME
proc TP_getGroupCommand { flag} {
   global TPtoolpath
   set TPgroup [$TPtoolpath find withtag Selected]
   if {[llength $TPgroup]==0} {
       Message "BUG! TP_getGroupCommand: group is empty!! report"
       return
   }
   foreach id $TPgroup {
      set utag [TP_Utag find $id]
      append cmd "$TPtoolpath delete $utag\;"
      append cmd [TP_getObjectCommand $utag $flag]\;
   }
   set TPbelow [TP_getObjectBelow Selected]
   set TPabove [TP_getObjectAbove Selected]
   set n [llength $TPgroup]
   if { $TPbelow != "" } {
     set first [TP_Utag find [lindex $TPgroup 0]]
     append cmd "$TPtoolpath raise $first $TPbelow\;"
     
     for {set i 0} {$i<[expr $n-1]} {incr i} {
        set current [TP_Utag find [lindex $TPgroup $i]]
        set next [TP_Utag find [lindex $TPgroup [expr $i+1]]]
        append cmd "$TPtoolpath raise $next $current\;"
     }
   } 

   if { $TPabove != "" } {
     set TPlast [TP_Utag find [lindex $TPgroup [expr $n-1]]]
     append cmd "$TPtoolpath lower $TPlast $TPabove\;"
     for {set i [expr $n-1]} {$i>0} {incr i -1} {
        set current [TP_Utag find [lindex $TPgroup $i]]
        set previous [TP_Utag find [lindex $TPgroup [expr $i-1]]]
        append cmd "$TPtoolpath lower $previous $current\;"
     }
   }

   append cmd "$TPtoolpath delete graybox\;"
   append cmd "$TPtoolpath delete rotateLine rotateBox rotateText rotateTextBox\;"
   return $cmd
}

############################# PROCEDURES ###############################

# WE START WITH A PROCEDURE THAT ASSIGNS A UNIQUE TAG TO EACH
# OBJECT THAT WE CREATE ON THE CANVAS. THIS KIND OF TAG IS USEFUL,
# FOR EXAMPLE, FOR THE UNDO ACTION, WHERE AN OBJECT MAY BE CREATED AND DELETED
# SEVERAL TIMES (HENCE ITS NORMAL ID MAY CHANGE) RETAINING ITS UTAG.
# THE PROCEDURE ALSO FINDS THE UTAG OF A GIVEN ID.

proc TP_Utag { mode id} {
  global TPtoolpath
  global utagCounter
  if ![regexp {^[1-9][0-9]*$} $id] {
    return ""
  }
  switch $mode {
     assign {
        incr utagCounter
        set utag utag$utagCounter
        $TPtoolpath addtag $utag withtag $id
#LISSI
#puts "TP_Utag assign: utag=$utag, id=$id"
        $TPtoolpath addtag "obj" withtag $id

        return $utag
     }
     find {
        set tags [$TPtoolpath gettags $id]
        set n [lsearch -regexp $tags {utag[0-9]+}]
#LISSI
#puts "TP_Utag find: tags=$tags , n=$n, id=$id"

        if {-1==$n} {error "utag trouble! Report bug!!"}
        return [lindex $tags $n]
     }
  }
}

#LOOK AT THE "getObjectOptions" proc for an explanation about the "flag" arg.
proc TP_getObjectCommand { utagORid flag} {
  global TPtoolpath
  lappend command $TPtoolpath create
  lappend command [$TPtoolpath type $utagORid]
  eval lappend command [$TPtoolpath coords $utagORid]
  eval lappend command [TP_getObjectOptions $utagORid $flag]
  return $command
}

# THE NEXT PROC ACCEPTS AN OBJECT UTAG AND RETURNS A COMMAND TO CREATE AN
# IDENTICAL COPY OF THIS OBJECT.
# THE "flag" ARGUMENT IS AN INTEGER VALUE THAT INDICATES IF WE WANT TO KEEP
# THE ORIGINAL UTAG (1), DELETE IT (0), KEEP THE "Selected" tag (2).
# NEW: if flag==2 then keep the "Selected" tag

proc TP_getObjectOptions { utagORid flag} {
  global TPtoolpath
  foreach conf [$TPtoolpath itemconfigure $utagORid] {
    if {[lindex $conf 0]=="-tags"} {continue}
    set default [lindex $conf 3]
    set value [lindex $conf 4]
    if {[string compare $default $value] != 0} {
      lappend options [lindex $conf 0] $value
    }
  }
  set tags [$TPtoolpath gettags $utagORid]
  if {[lsearch $tags current]>=0} {
    regsub current $tags "" tags
  }
  if {[lsearch $tags Selected]>=0 && $flag!=2} {
    regsub Selected $tags "" tags
  }
  # next, we strip out the utag (if exists) if flag=0
  if {$flag==0} {
    regsub {utag[0-9]+} $tags "" tags
  } 
#LISSI 1 for move/resize
puts "TP_getObjectOptions: flag=$flag"
bind $TPtoolpath <B1-ButtonRelease>

  lappend options -tags $tags
  return $options
}

proc TP_getObjectBelow {utag} {
   global TPtoolpath
   set i $utag
   set previ ""
   while { $i != "" } {
     set i [$TPtoolpath find below $i]
     if {$i==""||$i=="$previ"} {return ""}
     set previ $i
     set tags [$TPtoolpath gettags $i]
     if {[lsearch $tags obj] >= 0} {
       return [TP_Utag find $i]
     }
   }
   return ""
}

proc TP_getObjectAbove {utag} {
   global TPtoolpath
   set i $utag
   set previ ""
   while { $i != "" } {
     set i [$TPtoolpath find above $i]
     if {$i==""||$i=="$previ"} {return ""}
     set previ $i
     set tags [$TPtoolpath gettags $i]
     if {[lsearch $tags obj] >= 0} {
       return [TP_Utag find $i]
     }
   }
   return ""
}

proc TP_moveGroup {x y} {
   global TPtoolpath
    global TPlastX TPlastY BBox
    set dx [expr $x-$TPlastX]
    set dy [expr $y-$TPlastY]
    $TPtoolpath move Selected $dx $dy
    TP_drawBoundingBox
    set TPlastX $x
    set TPlastY $y
}

#LISSI
if {0} {
## UNDO AND HISTORY PROCS
# A VERY IMPORTANT NOTE ABOUT THESE PROCS!!!!
# WHEN USING THEM, THEY ALWAYS GO TOGETHER,
# THE HISTORY COMMAND MUST ALWAYS COME BEFORE
# THE UNDO PROC!!!! OR ELESE YOU ARE INTO REAL TROUBLE!

proc TP_Undo {mode {cmd ""}} {
  global undoStack undoMode histPtr TPFile

  switch -exact -- $mode {
     exec {
        set undoMode 1
        if {[llength $undoStack]==0 || $histPtr==0} {
             TP_Message "Reached bottom of undo stack"
             return
        }
        incr histPtr -1
        set cmd [lindex $undoStack $histPtr]
        eval $cmd
        if {$TPFile(progress)!="dead"} {
          incr TPFile(progress) -1
        }
        if {$TPFile(progress)<0} {
          set TPFile(progress) dead
          set TPFile(saved) 0
        }
        if {$TPFile(progress)==0} {
          set TPFile(saved) 1
        }
        TP_Message "History counter=$histPtr"
     }
     add {
        lappend undoStack $cmd
     }
  }
}

proc TP_History {mode {cmd ""}} {
  global TP_History histPtr undoStack TPFile
  switch -exact -- $mode {
     add {
        if {$TPFile(progress)!="dead"} {
          incr TPFile(progress)
        }
        set TPFile(saved) 0
        set TPFile(new) 0

        if {$histPtr < [llength $TP_History]} {
             set TP_History [lrange $TP_History 0 [expr $histPtr-1]]
             set undoStack [lrange $undoStack 0 [expr $histPtr-1]]
        } elseif {[llength $TP_History]==50} {
             set TP_History [lreplace $TP_History 0 0]
             set undoStack [lreplace $undoStack 0 0]
        }
        lappend TP_History $cmd
        set histPtr [llength $TP_History]
     }
     repeat {
        if {$histPtr==[llength $TP_History]} {
             Message "Reached History end ($histPtr)"
             return
        }
        set cmd [lindex $TP_History $histPtr]
        incr histPtr
        if {$TPFile(progress)!="dead"} {
          incr TPFile(progress)
        }
        set TPFile(saved) 0
        set TPFile(new) 0
        eval $cmd
        TP_Message "History counter = $histPtr"
     }
  }
}
}

# RESHAPING POLYGONS AND LINES:

proc TP_reshapeMode {} {
  global TPReshape
#LISSI
  global TPcurCanvas
  global TPtoolpath
  $TPtoolpath delete graybox
  TPdelUtagGrp
    
  catch {unset TPReshape}
  bind $TPtoolpath <B1-Motion> {}
  bind $TPtoolpath <Button-1> {
      set TPReshape(utag) [TP_getNearestUtag [$TPtoolpath canvasx %x] [$TPtoolpath canvasy %y] 2 obj]
  }

  bind $TPtoolpath <B1-ButtonRelease> {
      if {$TPReshape(utag)==""} {
          TP_Message "No object under cursor!"
          return
      }
#LISSI
#puts "Сделать нормально полигон и линию!!!!"
      set tags [$TPtoolpath gettags $TPReshape(utag)]
#      set isPoly [lsearch $tags Polygon]
#      set isLine [lsearch $tags Line]
      set TPisPoly [lsearch $tags polygon]
      set TPisLine [lsearch $tags line]
      if {$TPisPoly==-1 && $TPisLine==-1} {
           TP_Message "Object under cursor is not a polygon/line! $tags"
           unset TPReshape(utag)
           return
      }

      set TPReshape(state) dragVertex
      TP_setReshapeHandles

      bind $TPtoolpath <Any-B1-ButtonRelease> {TP_reshapeButtonRelease}

      bind $TPtoolpath <Button-1> {}
  }

  bind $TPtoolpath <Button-3> {
     $TPtoolpath delete reshapeHandle
     TPdelUtagReshape	
     set TPcanvasTool "None"
     bind $TPtoolpath <Any-B1-ButtonRelease> {}
     bind $TPtoolpath <Any-Butt> {}
     bind $TPtoolpath <Button-1> {}
     bind $TPtoolpath <Button-3> {}
     TP_CanvasObjListFill $TPcurCanvas
#     TP_reshapeMode
#     set TPcanvasTool "Reshape"
  }

  TP_Message "Now click on a line or a polygon object"
}
proc TPdelUtagReshape {} {
    global TPReshape
    global TPtoolpath
    if {![info exist TPReshape(utag)]} {
	return
    }
    if {![info exist TPReshape(type)]} {
	return
    }
#parray TPReshape
     set aa "$TPReshape(type) $TPReshape(utag) obj"
     set aa1 "$TPReshape(utag) obj $TPReshape(type)"
#puts "Button-3: aa=$aa"
     set objInfo [TP_CanvasObjListGet $TPtoolpath]
    foreach obj $objInfo {
	foreach {ID tags type} $obj {}
#puts "ID=$ID tags=$tags type=$type"
	set er [string first $aa $tags]
	set tagsNew $tags
	if {$er == -1} {
	    set er [string first $aa1 $tags]
	    if {$er != -1} {
		regsub $aa1 $tags "" tagsNew
	    }
	} else {
	    regsub $aa $tags "" tagsNew
	}
        $TPtoolpath itemconfigure $ID -tags $tagsNew
     }
     catch {unset TPReshape}
}
proc TP_setReshapeHandles {} {
#LISSI
  global TPtoolpath

  global TPReshape
  TP_Message "You may drag or Ctrl-click to add vertex"
  $TPtoolpath delete reshapeHandle

  set TPReshape(type) [$TPtoolpath type $TPReshape(utag)]
  set TPReshape(options) [TP_getObjectOptions $TPReshape(utag) 1]
  set r [expr [$TPtoolpath itemcget $TPReshape(utag) -width]+4]
  set i 1
  foreach {x y} [$TPtoolpath coords $TPReshape(utag)] {
     set TPReshape($i,x) $x
     set TPReshape($i,y) $y
     set id [$TPtoolpath create rectangle \
                 [expr $x-$r] [expr $y-$r] [expr $x+$r] [expr $y+$r] \
                 -outline {} \
                 -fill black \
                 -stipple gray25 \
                 -tags reshapeHandle]
     set TPReshape($i,id) $id
     $TPtoolpath bind $id <B1-Motion> "TP_reshapeMotion $i %x %y"
     $TPtoolpath bind $id <Control-Button-1> "TP_addVertex $i"
     $TPtoolpath bind $id <Alt-Button-1> "TP_deleteVertex $i"
#     $TPtoolpath bind $id <Alt-B1-Motion> {break}
     incr i
  }

  $TPtoolpath bind reshapeHandle <Button-1> {
     if {$TPReshape(state)=="addVertex" || $TPReshape(state)=="deleteVertex"} {
       return
     }
     set TPReshape(undo) "$TPtoolpath delete $TPReshape(utag) \; "
     append TPReshape(undo) [TP_getObjectCommand $TPReshape(utag) 1]\;
     set TPabove [TP_getObjectAbove $TPReshape(utag)]
     if {$TPabove != ""} {
         append TPReshape(undo) "\; $TPtoolpath lower $TPReshape(utag) $TPabove"
     }
  }

  set TPReshape(n) [expr $i-1]
  $TPtoolpath raise reshapeHandle
}

proc TP_reshapeButtonRelease {} {
#LISSI
  global TPtoolpath

  global TPReshape

  if ![info exists TPReshape(undo)] {
       return
  }

  set cmd "$TPtoolpath delete $TPReshape(utag) \; "
  append cmd [TP_getObjectCommand $TPReshape(utag) 1]\;
  set TPabove [TP_getObjectAbove $TPReshape(utag)]
  if {$TPabove != ""} {
      append cmd "\; $TPtoolpath lower $TPReshape(utag) $TPabove"
  }
#LISSI
if {0}  {
  TP_History add $cmd
  TPUndo add $TPReshape(undo)
  unset TPReshape(undo)
}

  set TPReshape(state) dragVertex
  set z [expr round(rand()*7)]
  switch -exact $z {
      0 {TP_Message "The cursor has to be on the gray boxes!"}
      1 {TP_Message "To stop reshaping current object: Right click"}
      2 {TP_Message "After a right click you may select a new object!"}
      3 {TP_Message "To add vertex: control-click on a gray box!"}
      4 {TP_Message "To delete vertex: Alt-click on a gray box!"}
      5 {TP_Message "You can add as many vertices as you wish!"}
      6 {TP_Message "You can also delete vertices! Alt-click!"}
      7 {TP_Message "A little humor here and there never hurts"}
  }
}

proc TP_reshapeMotion {i x y} {
#LISSI
  global TPtoolpath

   global TPReshape Graphics
   set x [$TPtoolpath canvasx $x $Graphics(grid,snap)]
   set y [$TPtoolpath canvasy $y $Graphics(grid,snap)]
   set dx [expr $x-$TPReshape($i,x)]
   set dy [expr $y-$TPReshape($i,y)]
   $TPtoolpath move $TPReshape($i,id) $dx $dy
   set TPReshape($i,x) $x
   set TPReshape($i,y) $y
   set coords {}
   for {set j 1} {$j<=$TPReshape(n)} {incr j} {
        lappend coords $TPReshape($j,x) $TPReshape($j,y)
   }
   set TPabove [TP_getObjectAbove $TPReshape(utag)]
   $TPtoolpath delete $TPReshape(utag)
#puts "TP_reshapeMotion: options=$TPReshape(options)"
   eval $TPtoolpath create $TPReshape(type) $coords $TPReshape(options)
   if {$TPabove != ""} {
       $TPtoolpath lower $TPReshape(utag) $TPabove
   }

   $TPtoolpath raise reshapeHandle
}

proc TP_addVertex {i} {
#LISSI
  global TPtoolpath

   global TPReshape

   set TPReshape(state) addVertex
   set TPReshape(undo) "$TPtoolpath delete $TPReshape(utag) \; "
   append TPReshape(undo) [TP_getObjectCommand $TPReshape(utag) 1]\;
   set TPabove [TP_getObjectAbove $TPReshape(utag)]
   if {$TPabove != ""} {
       append TPReshape(undo) "\; $TPtoolpath lower $TPReshape(utag) $TPabove"
   }
 
   incr TPReshape(n)
   for {set j $TPReshape(n)} {$j>=[expr $i+2]} {incr j -1} {
      set k [expr $j-1]
      set TPReshape($j,x) $TPReshape($k,x)
      set TPReshape($j,y) $TPReshape($k,y)
   }
   set x $TPReshape($i,x)
   set y $TPReshape($i,y)
   set k [expr $i+1]
   set TPReshape($k,x) [expr $x+10]
   set TPReshape($k,y) [expr $y+10]
   set coords {}
   for {set j 1} {$j<=$TPReshape(n)} {incr j} {
        lappend coords $TPReshape($j,x) $TPReshape($j,y)
   }
   set TPabove [TP_getObjectAbove $TPReshape(utag)]
   $TPtoolpath delete $TPReshape(utag)
   eval $TPtoolpath create $TPReshape(type) $coords $TPReshape(options)
   if {$TPabove != ""} {
       $TPtoolpath lower $TPReshape(utag) $TPabove
   }
   TP_setReshapeHandles
}

proc TP_deleteVertex {i} {
#LISSI
  global TPtoolpath

   global TPReshape

   set TPReshape(state) deleteVertex

   if {$TPReshape(type)=="line" && $TPReshape(n)==2} {
     TP_Message "Cannot delete a vertex from a Line with 2 vertices!"
     catch {unset TPReshape(undo)}
     return
   }

   if {$TPReshape(type)=="polygon" && $TPReshape(n)==3} {
     TP_Message "Cannot delete a vertex from a polygon with 3 vertices!"
     catch {unset TPReshape(undo)}
     return
   }

   set TPReshape(undo) "$TPtoolpath delete $TPReshape(utag) \; "
   append TPReshape(undo) [TP_getObjectCommand $TPReshape(utag) 1]\;
   set TPabove [TP_getObjectAbove $TPReshape(utag)]
   if {$TPabove != ""} {
       append TPReshape(undo) "\; $TPtoolpath lower $TPReshape(utag) $TPabove"
   }

   set n $TPReshape(n)
   incr TPReshape(n) -1
   for {set j $i} {$j<=$TPReshape(n)} {incr j} {
      set k [expr $j+1]
      set TPReshape($j,x) $TPReshape($k,x)
      set TPReshape($j,y) $TPReshape($k,y)
   }
   unset TPReshape($n,x) TPReshape($n,y)
   set coords {}
   for {set j 1} {$j<=$TPReshape(n)} {incr j} {
        lappend coords $TPReshape($j,x) $TPReshape($j,y)
   }
   set TPabove [TP_getObjectAbove $TPReshape(utag)]
   $TPtoolpath delete $TPReshape(utag)
   eval $TPtoolpath create $TPReshape(type) $coords $TPReshape(options)
   if {$TPabove != ""} {
       $TPtoolpath lower $TPReshape(utag) $TPabove
   }
   TP_setReshapeHandles
}

############## EDIT SECTION:  DELETE, MOVE, COPY, RAISE, LOWER, 

# UTILITY PROCEDURES TO HELP US DO MOVE, DELETE, RAISE, LOWER, AND COPY
# OPERATIONS MORE NEAT.
#
# THE FOLLOWING PROCEDURE RETURNS THE UTAG of THE CLOSEST ITEM WITH TAG "tag"
# THAT OVERLAP WITH THE AREA (x-r,y-r) (x+r,y+r) IN THE CANVAS .c.
# (CLOSEST ALSO MEANS AS HIGH AS POSSIBLE IN THE DISPLAY LIST)
# THE PROCEDURE RETURNS AN EMPTY STRING IF IT FINDS NO ITEM WITH THE
# SPECIFIED REQUIREMNETS.

proc TP_getNearestUtag {x y r tag} {
#LISSI
  global TPtoolpath
#LISSI
puts "TP_getNearestUtag: r=$r tag=$tag"

  set nearObjects [$TPtoolpath find overlapping [expr $x-$r] [expr $y-$r] \
                                       [expr $x+$r] [expr $y+$r]]
  if {[llength $nearObjects]==0} {
    return ""
  }
  set n [expr [llength $nearObjects]-1]
  for {set i $n} {$i>=0} {incr i -1} {
     set id [lindex $nearObjects $i]
#LISSI
puts "TP_getNearestUtag: id=$id, type=[$TPtoolpath type $id]"
     if {[lsearch [$TPtoolpath gettags $id] $tag]>=0} {
       return [TP_Utag find $id]
     } else {
        set type [$TPtoolpath type $id] 
        if {$type == "polygon" || $type == "line"} {
    	    TP_AddTags $id "" [$TPtoolpath type $id]
    	    return [TP_Utag find $id]
        }
     }
  }
}
# Procedure: TP_DTidentify
proc TP_IdentSelectPolLine { cname xpos ypos} {
    global TPiditem
    global TPcanvasID
    global TPcurCanvas
    set ret -1
    set TPidItem [$cname find withtag current]
    if {$TPidItem != {}} {
        set TPcanvasID $TPidItem
        set wname .tpcanvas.frame30.listbox1
        if {[winfo exists $wname]} {
            set searchstr "> $TPidItem"
            set slen [expr -[string length $searchstr]]
            TP_CanvasObjListFill $TPcurCanvas
#        $wname selection clear 0 end
            set itemlist [$wname get 0 end]
#LISSI
puts "TP_DTidentify: $itemlist"

            set size [llength $itemlist]
            set idx 0
            while {$idx < $size} {
		set itemval [lindex $itemlist $idx]
		set pos [string length $itemval]
		incr pos $slen
		if {[string range $itemval $pos end] == $searchstr} {
#LISSI
		    set box [lindex $itemlist $idx]
#puts "TP_DTidentify IDX=$idx: $box"
		    set ret [lindex $box 1]
puts "TP_DTidentify IDX=$idx: $box, ret=$ret"

#	        $wname selection set $idx
	    	    set idx $size
#	        event generate $wname <<ListboxSelect>>
	        }
		incr idx
	    }
        }
    }
    return $ret
}
#LISSI
proc TP_AddTags {ID tags type } {
    global TPtoolpath
    global utagCounter
    set n [lsearch -regexp $tags {utag[0-9]+}]
#LISSI
puts "TP_AddTags: tags=$tags , n=$n, ID=$ID"

    if {-1==$n} {
        incr utagCounter
        set utag "utag$utagCounter"
#        set fulltags "$type $utag obj"
#        $TPtoolpath addtag $fulltags withtag $ID
#return
        $TPtoolpath addtag $utag withtag $ID
#LISSI
#puts "TP_AddTags: utag=$utag, id=$ID, type=$type"
        $TPtoolpath addtag "obj" withtag $ID
        $TPtoolpath addtag $type withtag $ID
    }
}


#LISSI
#Расчёт координат для прямоугольника с закругленными углами
 #----------------------------------------------------------------------
 #
 # roundRect --
 #       Draw a rounded rectangle in the canvas.
 #
 # Parameters:
 #       x0, y0 - Co-ordinates of the upper left corner, in pixels
 #       x3, y3 - Co-ordinates of the lower right corner, in pixels
 #       radius - Radius of the bend at the corners, in any form
 #                acceptable to Tk_GetPixels
 #
 # Results:
 #       Returns the coordinates for polygon.
 #
 # Side effects:
 #       Creates a rounded rectangle as a smooth polygon in the canvas.
 #
 #----------------------------------------------------------------------
proc TP_roundRect { x0 y0 x3 y3 radius} {
    set r $radius
    set d [expr { 2 * $r }]

    # Make sure that the radius of the curve is less than 3/8
    # size of the box!

    set maxr 0.75

    if { $d > $maxr * ( $x3 - $x0 ) } {
        set d [expr { $maxr * ( $x3 - $x0 ) }]
    }
    if { $d > $maxr * ( $y3 - $y0 ) } {
        set d [expr { $maxr * ( $y3 - $y0 ) }]
    }

    set x1 [expr { $x0 + $d }]
    set x2 [expr { $x3 - $d }]
    set y1 [expr { $y0 + $d }]
    set y2 [expr { $y3 - $d }]
    
    set cmd [list ]
#    set cmd [list $w create polygon]
    lappend cmd $x0 $y0
    lappend cmd $x1 $y0
    lappend cmd $x2 $y0
    lappend cmd $x3 $y0
    lappend cmd $x3 $y1
    lappend cmd $x3 $y2
    lappend cmd $x3 $y3
    lappend cmd $x2 $y3
    lappend cmd $x1 $y3
    lappend cmd $x0 $y3
    lappend cmd $x0 $y2
    lappend cmd $x0 $y1
#    lappend cmd -smooth 1
#    return [eval $cmd $args]
    return $cmd
}
#Расчёт координат для прямоугольника со скошенными углами
proc TP_bevelRect { x0 y0 x3 y3 radius} {
    set r [expr {$radius * -1 }]
    set d [expr { 2 * $r }]

    if { $d > ( $x3 - $x0 ) } {
        set d [expr { ( $x3 - $x0 ) / 2}]
    }
    if { $d > ( $y3 - $y0 ) } {
        set d [expr { ( $y3 - $y0 )/2 }]
    }
    set d [expr {$d / 2 }]
    set x1 [expr { $x0 + $d }]
    set x2 [expr { $x3 - $d }]
    set y1 [expr { $y0 + $d }]
    set y2 [expr { $y3 - $d }]
    
    set cmd [list ]
    lappend cmd $x0 $y1
    lappend cmd $x1 $y0
    lappend cmd $x2 $y0
    lappend cmd $x3 $y1
    lappend cmd $x3 $y2
    lappend cmd $x2 $y3
    lappend cmd $x1 $y3
    lappend cmd $x0 $y2
    return $cmd
}
proc TP_saveGroupToFileOrImage {type {cur ""}} {
    global macos
    set yesps 0
    if {$macos && [info exists ::freewrap::patchLevel]} {
	if {$::freewrap::patchLevel == "1.2.0"} {
	    set yesps 1
	} 
    }

#type 0 - сохранить в файле. 1 - создать image png, усли $cur!= "", то снимок одиночного объекта
    global TPbboxL
    global TPtoolpath
    set canbg [$TPtoolpath configure -background]
#    puts "Выделенный блок! \"$TPbboxL\", bg=$canbg cur=$cur"
    set canbg [lindex $canbg end]
#    puts "Выделенный блок! \"$TPbboxL\", bg=$canbg"

    if { [catch {winfo rgb . $canbg} rgb] } {
    	tk_messageBox -message "Invalid background color \"$canbg\""
    	return;
    }
    if {$macos && $yesps } {
	if { [catch {winfo rgb . "#ffffff"} rgb] } {
    	    tk_messageBox -message "Invalid white color \"#ffffff\" for PS"
    	    return;
	}
    }
    raise [winfo toplevel $TPtoolpath]
    update
	set bbox $TPbboxL
	if {$bbox == ""} {
	    puts "Нет выделенного блока!$TPbboxL"
	    return
	}
	set x1 [lindex $bbox 0]
	set y1 [lindex $bbox 1]
	set x2 [lindex $bbox 2]
	set y2 [lindex $bbox 3]
	set x2_new [expr $x2 - $x1]
	set y2_new [expr $y2 - $y1]
    if {$macos && $yesps} {
	set ps1 [$TPtoolpath postscript -x $x1 -y $y1 -width $x2_new -height $y2_new]
# -pageanchor nw  -pagex 0  -pagey $y2_new  -pagewidth $x2 -pageheight $y2
	set newimg [image create photo -format ps -data $ps1]
    } else {
# create image - пустая
	set newimg [image create photo]
	set canimg [image create photo -format window -data $TPtoolpath]
	$newimg copy $canimg -from  $x1 $y1 $x2 $y2 -to 0 0 $x2_new $y2_new
    	image delete $canimg
    }
    set rgb2 [list [expr [lindex $rgb 0]/256] [expr [lindex $rgb 1]/256] [expr [lindex $rgb 2]/256]]

	set h [image height $newimg]
	set w [image width $newimg]
#puts "Необходимо подождать! rgb2=$rgb2"
	for { set x 0 } {$x < $w} {incr x} {
	    for {set y 0} {$y < $h} {incr y} {
		if {$cur == ""} {
    		    if { [$newimg get $x $y] == $rgb2 } {
        		$newimg transparency set $x $y 1
        	    }
        	} else {
		    set over [$TPtoolpath find overlapping [expr {$x1 + $x}] [expr {$y1 + $y}] [expr {$x1 + $x}] [expr {$y1 + $y}]]
		    if {[lsearch $over $cur] < 0} {
        		$newimg transparency set $x $y 1
		    }
        	}
    	    }
	}

    if {$type == 0} {
	set File(img,types) {
		    {{img png} {.png} }
		    {{img gif} {.gif} }
		    {{img jpg} {.jpg} }
		    {{All files} * }
	}
        set type        "png"
        set title       "Select file for image group"
        set defaultName "tk_$newimg"
        set command tk_getSaveFile
        set filename [$command \
                -title "$title" \
                -filetypes $File(img,types) \
                -initialfile $defaultName \
                -defaultextension ".$type" ]
        if {$filename==""} {return 0}

    	$newimg write $filename -format "png"
#puts "file=$filename"
	image delete $newimg
    } else {
	global TPimage
#Данные сразу в проект
        set defaultName "tk_$newimg"
	set data [$newimg data -format "png"]
#set fd [open "$filename.pem" w]
#chan configure $fd -translation binary
#puts -nonewline $fd $data
#close $fd
	image delete $newimg
#	image create photo $defaultName -data $data -format png -gamma 1.0 -height 0 -width 0
	if {![winfo exists ".tpimages"]} {
	    ShowWindow.tpimages
	}
	.tpimages.propphoto.frame20.entry13 delete 0 end
	.tpimages.propphoto.frame20.entry13 insert end $defaultName
	.tpimages.propphoto.frame22.entry13 delete 0 end
	.tpimages.propphoto.frame22.entry13 insert end "png -alpha 1.0"
	.tpimages.frame5.screenshot configure -state normal
	set TPimage(screenshot) 1
	set TPimage(data) $data
	.tpimages.frame5.screenshot configure -state disabled
	.tpimages.propphoto.frame14.entry13  delete 0 end
	.tpimages.propphoto.frame14.entry13 configure -state disabled
	update
    }
     TP_ToolChoose cancel
     set TPcanvasTool "None"
}

proc TP_SaveCaptureWindow {win {baseImg ""} {px 0} {py 0}} {
    set File(img,types) {
	{{img png} {.png} }
	{{img gif} {.gif} }
	{{img jpg} {.jpg} }
	{{All files} * }
    }
    set type        "png"
    set title       "Select file for screenshot"
    set defaultName "tk_screen00"
    set command tk_getSaveFile
    set filename [$command \
             -title "$title" \
             -filetypes $File(img,types) \
             -initialfile $defaultName \
             -defaultextension ".$type" ]
    if {$filename==""} {return 0}
raise $win
update
    set newimg [TP_CaptureWindow $win]
    		$newimg write $filename -format "png"
    		image delete $newimg
puts "file=$filename"
}
proc TP_CaptureWindow {win {baseImg ""} {px 0} {py 0}} {
    global macos
    set yesps 0
    if {$macos && [info exists ::freewrap::patchLevel]} {
	if {$::freewrap::patchLevel == "1.2.0"} {
	    set yesps 1
	} 
    }
   # create the base image of win (the root of capturing process)
   if {$baseImg eq ""} {
	set classwd [winfo class $win]
	if {$macos && $yesps && $classwd == "Canvas"} {
    	    set baseImg [image create photo -format ps -data [$win postscript]]
	} else {
    	    set baseImg [image create photo -format window -data $win]
        }
   }
if {0} {
   # paste images of win's children on the base image
   foreach child [winfo children $win] {
     if {![winfo ismapped $child]} continue
     set childImg [image create photo -format window -data $child]
     regexp {\+(\d*)\+(\d*)} [winfo geometry $child] -> x y
     $baseImg copy $childImg -to [incr x $px] [incr y $py]
     image delete $childImg
     TP_CaptureWindow $child $baseImg $x $y
   }
}
   return $baseImg
}

proc TPtraceObtype {name index op} {
    global TPcurCanvasObjType
    upvar 1 $name tekname
#    puts "TPtraceObtype: TPcurCanvasObjType=$TPcurCanvasObjType, tekname=$tekname"
    if {$TPcurCanvasObjType == "Rectangle"} {
	pack configure .tpcanvas.frame2.frame4.checkbutton0  -padx {1 0} -side left
	pack configure .tpcanvas.frame2.frame4.typerect  -padx {1 1} -side left
    } else {
	pack forget .tpcanvas.frame2.frame4.checkbutton0
	pack forget .tpcanvas.frame2.frame4.typerect
    }
}

proc TPtraceTypeRect {name index op} {
    global TPrectRound
    upvar 1 $name tekname
#    puts "TPtraceObtype: TPrectRound=$TPrectRound, tekname=$tekname"
    if {$TPrectRound > 0 && [string range $TPrectRound 0 0] != "+"} {
	set TPrectRound "+$TPrectRound"
    }
}
proc TPForBuildExt {} {
    pack .tpbuild.frame5 -after .tpbuild.hseparator5 -side top -fill x
    .tpbuild.frame1.entry3 configure -textvariable {TPbuild(EXTfile)}
    .tpbuild.frame1.frame6.label2 configure -text  {Select project main file:}
    .tpbuild.frame1.frame6.label2 configure -background  "#00ffff"
    .tpbuild.frame1.entry3 configure -state normal
    pack forget .tpbuild.frame1.frame1
    pack .tpbuild.frame1.button4 -anchor e -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side right
}
proc TPForBuildInt {type} {
    .tpbuild.frame1.frame6.label2 configure -text  {Main application source code file:}
    .tpbuild.frame1.frame6.label2 configure -background  "#eff0f1"
    pack .tpbuild.frame1.entry3 -anchor n -expand 1 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left
    .tpbuild.frame1.entry3 configure -textvariable {TPbuild(MainSrc)}
    .tpbuild.frame1.entry3 configure -state disabled
    pack forget .tpbuild.frame1.button4
    pack .tpbuild.frame1.frame1 -anchor e -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side right
    if {$type == "pkg" } {
	pack forget .tpbuild.frame5
    } else {
	pack .tpbuild.frame5 -after .tpbuild.hseparator5 -side top -fill x
    }
}
proc TPwinbuild {} {
    global TPbuild
    if {![info exists ::freewrap::patchLevel]} {
	set TPbuild(wrapper) -1
	return
    }
    if {$::freewrap::patchLevel == "6.63"} {
pack .tpbuild.frame1.frame6 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left
	set TPbuild(wrapper) 1
	.tpbuild.frame5.frame3.frame3.labelwrap.radiobtn1 configure -text "tclexecomp1.0.4"
	.tpbuild.frame5.frame3.frame3.labelwrap.radiobtn0 configure -state disabled
	.tpbuild.frame5.frame3.frame3.labelwrap.radiobtn2 configure -state disabled
    } elseif {$::freewrap::patchLevel >= "6.74"} {
	set TPbuild(wrapper) 0
	.tpbuild.frame5.frame3.frame3.labelwrap.radiobtn0 configure -text "freewrap$::freewrap::patchLevel"
	.tpbuild.frame5.frame3.frame3.labelwrap.radiobtn1 configure -state disabled
	.tpbuild.frame5.frame3.frame3.labelwrap.radiobtn2 configure -state disabled
    } elseif {$::freewrap::patchLevel >= "1.2.0"} {
pack .tpbuild.frame1.frame6 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left
	set TPbuild(wrapper) 1
	.tpbuild.frame5.frame3.frame3.labelwrap.radiobtn1 configure -text "tclexecomp$::freewrap::patchLevel"
	.tpbuild.frame5.frame3.frame3.labelwrap.radiobtn0 configure -state disabled
	.tpbuild.frame5.frame3.frame3.labelwrap.radiobtn2 configure -state disabled
    } else {
	set TPbuild(wrapper) -1
    }
    if {$TPbuild(wrapper) == 1} {
	pack forget .tpbuild.frame5.frame3.frame1
	pack forget .tpbuild.frame5.frame3.frame4
	.tpbuild.frame5.frame3.frame3.label8 configure -text {Associated tclexecomp Program}
	pack .tpbuild.frame5.frame3.frameMAC -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top -after .tpbuild.frame5.frame3.frame2
    } else {
	pack .tpbuild.frame5.frame3.frame1 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top -before .tpbuild.frame5.frame3.frame2
	pack .tpbuild.frame5.frame3.frame4 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top -before .tpbuild.frame5.frame3.frame0
	.tpbuild.frame5.frame3.frame3.label8 configure -text {Associated freeWrap Program}
	pack forget .tpbuild.frame5.frame3.frameMAC
    } 
    update idletasks

}

trace variable TPcurCanvasObjType w TPtraceObtype 
trace variable TPrectRound w TPtraceTypeRect 

#================Rotate and deform==========================
if {0} {
proc rotateGroupMode {} {
   global Rotate pi Font
   set pi [expr 2*asin(1)]
   
   .c delete graybox

   set TPgroup [.c find withtag Selected]
   if {[llength $TPgroup]==0} {
     Message "First you need to select a group of objects!"
     return
   }
   Message "Choose rotation center (click)"
   set bbox [.c bbox Selected]
   set x1 [lindex $bbox 0]
   set y1 [lindex $bbox 1]
   set x2 [lindex $bbox 2]
   set y2 [lindex $bbox 3]
   .c create polygon $x1 $y1 $x2 $y1 $x2 $y2 $x1 $y2\
                -outline {} \
                -fill gray50 \
                -stipple gray12 \
                -tags {graybox rotateBox}

   set Rotate(x1) $x1
   set Rotate(x2) $x2
   set Rotate(y1) $y1
   set Rotate(y2) $y2
   set Rotate(xc) [expr ($x1+$x2)/2]
   set Rotate(yc) [expr ($y1+$y2)/2]

   .c bind rotateBox <Enter> {%W configure -cursor dot}
   .c bind rotateBox <Leave> {
        %W configure -cursor ""
        %W delete rotateText
   }

   .c bind rotateBox <Motion> {
        set x [.c canvasx %x $Graphics(grid,snap)]
        set y [.c canvasy %y $Graphics(grid,snap)]
        .c delete rotateText
        .c create text $Rotate(xc) [expr $Rotate(y1)-3] \
              -anchor s \
              -text [format "%%.1f" [expr $Rotate(yc)-$y]] \
              -tags rotateText
        .c create text [expr $Rotate(x2)+3]  $Rotate(yc) \
              -anchor w \
              -text [format "%%.1f" [expr $x-$Rotate(xc)]] \
              -tags rotateText
   }

   bind .c <Button-1> {
      set Rotate(x_orig) [.c canvasx %x]
      set Rotate(y_orig) [.c canvasy %y]
      set Rotate(last) 0
      set Rotate(ang) 0
      set Rotate(delta) 0
      set Rotate(undo) [getGroupCommand 1]
      foreach id [.c find withtag Selected] {
         shape2spline $id
      }
      Message "Now hold and drag the mouse to the desired angle"
   }

   bind .c <B1-Motion> {
     set x [.c canvasx %x]
     set y [.c canvasy %y]
     .c delete rotateLine rotateText rotateTextBox
     .c create line $Rotate(x_orig) $Rotate(y_orig) $x $y \
           -width 2 \
           -arrow last \
           -tags rotateLine
     if {abs($Rotate(x_orig) - $x) < 15 && abs($Rotate(y_orig) - $y) < 15} {
       return
     }
     .c create rectangle [expr $x+5] [expr $y-32] [expr $x+55] [expr $y-8] \
                -width 2 \
                -fill cyan \
                -tags rotateTextBox
     set Rotate(ang) [expr -atan2($y-$Rotate(y_orig),$x-$Rotate(x_orig))]
     .c create text [expr $x+30] [expr $y-20] \
           -anchor c \
           -fill red \
           -text [format "%%.1f" [expr $Rotate(ang)*180.0/$pi]] \
           -font $Font(rotateTextBox) \
           -tags rotateText
     set Rotate(delta) [expr $Rotate(ang) - $Rotate(last)]
     set Rotate(last) $Rotate(ang)
     rotateGroup
   }

   bind .c <B1-ButtonRelease> {
       .c delete rotateLine rotateBox rotateText rotateTextBox
       %W configure -cursor ""
       foreach id [.c find withtag Selected] {
          set utag [Utag find $id]
          append Rotate(cmd) "shape2spline $utag \; "
          append Rotate(cmd) "rotateObj $Rotate(x_orig) $Rotate(y_orig) \
                      $Rotate(last) $utag \; "
       }
       History add $Rotate(cmd)
       Undo add $Rotate(undo)
#       Message "Rotate action completed successfully (angle=$Rotate(ang))"
       catch {unset Rotate}
       selectGroupMode
   }
}

proc rotateGroup {} {
  global Rotate

  rotateObj $Rotate(x_orig) $Rotate(y_orig) $Rotate(delta) graybox

  foreach id [.c find withtag Selected] {
     rotateObj $Rotate(x_orig) $Rotate(y_orig) $Rotate(delta) $id
  }
  .c raise rotateLine
  .c raise rotateTextBox
  .c raise rotateText
}

##### DEFORM A GROUP

proc deformObj {side utag} {
   global deformInfo

   set xFloat $deformInfo($side,float,x)
   set yFloat $deformInfo($side,float,y)
   set x1 $deformInfo(bbox,x1)
   set x2 $deformInfo(bbox,x2)
   set y1 $deformInfo(bbox,y1)
   set y2 $deformInfo(bbox,y2)
   set h  $deformInfo(bbox,height)
   set w  $deformInfo(bbox,width)
   set new_coords {}

   switch $side {
      s  {
        if {abs($yFloat-$y1)<2} {return}
        foreach {x y} $deformInfo($utag,coords) {
           set y [expr $y1+($yFloat-$y1)*($y-$y1)/$h]
           set x [expr $x+($y-$y1)*($xFloat-$x2)/($yFloat-$y1)]
           lappend new_coords $x $y
        }
      }
      n  {
        if {abs($yFloat-$y2)<2} {return}
        foreach {x y} $deformInfo($utag,coords) {
           set y [expr $y2-($yFloat-$y2)*($y-$y2)/$h]
           set x [expr $x+($y-$y2)*($xFloat-$x1)/($yFloat-$y2)]
           lappend new_coords $x $y
        }
      }
      e  {
        if {abs($xFloat-$x1)<2} {return}
        foreach {x y} $deformInfo($utag,coords) {
           set x [expr $x1+($xFloat-$x1)*($x-$x1)/$w]
           set y [expr $y+($x-$x1)*($yFloat-$y1)/($xFloat-$x1)]
           lappend new_coords $x $y
        }
      }
      w  {
        if {abs($xFloat-$x2)<2} {return}
        foreach {x y} $deformInfo($utag,coords) {
           set x [expr $x2-($xFloat-$x2)*($x-$x2)/$w]
           set y [expr $y+($x-$x2)*($yFloat-$y2)/($xFloat-$x2)]
           lappend new_coords $x $y
        }
      }
   }

   .c delete $utag
   eval .c create $deformInfo($utag,type) $new_coords $deformInfo($utag,options)
}

proc deformGroup {side} {
  global deformInfo

  deformObj $side deformBox

  foreach id [.c find withtag Selected] {
     deformObj $side [Utag find $id]
  }
}

proc deformHandlePress {side} {
  global deformInfo
  switch $side {
      s {.c delete n-deformHandle e-deformHandle w-deformHandle}
      n {.c delete s-deformHandle e-deformHandle w-deformHandle}
      e {.c delete n-deformHandle s-deformHandle w-deformHandle}
      w {.c delete n-deformHandle s-deformHandle e-deformHandle}
  }
  set deformInfo(undo) [getGroupCommand 1]
  foreach id [.c find withtag Selected] {
     set u [Utag find [shape2spline $id]]
     set deformInfo($u,type) [.c type $u]
     set deformInfo($u,coords) [.c coords $u]
     set deformInfo($u,options) [getObjectOptions $u 2]
  }
}

proc deformHandleMotion {side x y} {
   global Graphics deformInfo
   set x [.c canvasx $x $Graphics(grid,snap)]
   set y [.c canvasy $y $Graphics(grid,snap)]
   set dx [expr $x-$deformInfo($side-handle,x)]
   set dy [expr $y-$deformInfo($side-handle,y)]
   .c move $side-deformHandle $dx $dy
   set deformInfo($side-handle,x) $x
   set deformInfo($side-handle,y) $y
   set deformInfo($side,float,x) [expr $deformInfo($side,float,x)+$dx]
   set deformInfo($side,float,y) [expr $deformInfo($side,float,y)+$dy]
   deformGroup $side
}

proc deformGroupMode {} {
   global deformInfo
   
   .c delete graybox
   .c configure -cursor ""

   set tmp [.c find withtag Selected]
   if {[llength $tmp]==0} {
     Message "First you need to select a group of objects!"
     return
   }
   unset tmp
   set bbox [.c bbox Selected]
   set x1 [lindex $bbox 0]
   set y1 [lindex $bbox 1]
   set x2 [lindex $bbox 2]
   set y2 [lindex $bbox 3]
   .c create polygon $x1 $y1 $x2 $y1 $x2 $y2 $x1 $y2\
                -outline {} \
                -fill gray50 \
                -stipple gray12 \
                -tags {graybox deformBox}
# deformHandle box width and height:
   set handWidth 16
   set Coords(s) [list \
         [expr ($x1+$x2-$handWidth)/2]  $y2 \
         [expr ($x1+$x2+$handWidth)/2]  [expr $y2+$handWidth] \
   ]
   set Coords(n) [list \
         [expr ($x1+$x2-$handWidth)/2]  [expr $y1-$handWidth] \
         [expr ($x1+$x2+$handWidth)/2]  $y1 \
   ]
   set Coords(e) [list \
         $x2  [expr ($y1+$y2-$handWidth)/2] \
         [expr $x2+$handWidth]  [expr ($y1+$y2+$handWidth)/2] \
   ]
   set Coords(w) [list \
         [expr $x1-$handWidth]  [expr ($y1+$y2-$handWidth)/2] \
         $x1   [expr ($y1+$y2+$handWidth)/2] \
   ]

   foreach a {s n e w} {
       set coords $Coords($a)
       set options [list -outline {} -fill black -stipple gray75 \
                -tags [list graybox deformHandle $a-deformHandle]]
       eval .c create rectangle $coords $options
   }
   unset Coords

   Message "Drag one of the deform handles"

   set deformInfo(bbox,x1) $x1
   set deformInfo(bbox,y1) $y1
   set deformInfo(bbox,x2) $x2
   set deformInfo(bbox,y2) $y2
   set deformInfo(bbox,height) [expr $y2-$y1]
   set deformInfo(bbox,width) [expr $x2-$x1]

   set deformInfo(s,float,x) $x2
   set deformInfo(s,float,y) $y2
   set deformInfo(s-handle,x) [expr ($x1+$x2)/2]
   set deformInfo(s-handle,y) [expr $y2+$handWidth/2]
   set deformInfo(n,float,x) $x1
   set deformInfo(n,float,y) $y1
   set deformInfo(n-handle,x) [expr ($x1+$x2)/2]
   set deformInfo(n-handle,y) [expr $y1-$handWidth/2]
   set deformInfo(e,float,x) $x2
   set deformInfo(e,float,y) $y1
   set deformInfo(e-handle,x) [expr $x2+$handWidth/2]
   set deformInfo(e-handle,y) [expr ($y1+$y2)/2]
   set deformInfo(w,float,x) $x1
   set deformInfo(w,float,y) $y2
   set deformInfo(w-handle,x) [expr $x1-$handWidth/2]
   set deformInfo(w-handle,y) [expr ($y1+$y2)/2]

   set deformInfo(deformBox,type) [.c type deformBox]
   set deformInfo(deformBox,coords) [.c coords deformBox]
   set deformInfo(deformBox,options) [getObjectOptions deformBox 0]

   .c bind deformHandle <Enter> {%W configure -cursor trek}

   .c bind deformHandle <Leave> {%W configure -cursor ""}

   bind .c <Button-1> {}
   .c bind s-deformHandle <Button-1> {deformHandlePress s}
   .c bind n-deformHandle <Button-1> {deformHandlePress n}
   .c bind e-deformHandle <Button-1> {deformHandlePress e}
   .c bind w-deformHandle <Button-1> {deformHandlePress w}

   bind .c <B1-Motion> {}
   .c bind s-deformHandle <B1-Motion> {deformHandleMotion s %x %y}
   .c bind n-deformHandle <B1-Motion> {deformHandleMotion n %x %y}
   .c bind e-deformHandle <B1-Motion> {deformHandleMotion e %x %y}
   .c bind w-deformHandle <B1-Motion> {deformHandleMotion w %x %y}

   bind .c <B1-ButtonRelease> {}
   .c bind deformHandle <B1-ButtonRelease> {
         .c delete graybox
         %W configure -cursor ""
         append deformInfo(cmd) [getGroupCommand 1]
         History add $deformInfo(cmd)
         Undo add $deformInfo(undo)
         # Message "Deform action completed successfully"
         catch {unset deformInfo}
         set selectBox(x1) [.c canvasx %x]
         set selectBox(y1) [.c canvasy %y]
         set selectBox(x2) [.c canvasx %x]
         set selectBox(y2) [.c canvasy %y]
         selectGroupMode
   }
}
}





