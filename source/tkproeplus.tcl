#!/bin/sh
# This line continues for Tcl, but is a single line for 'sh' \
exec wish "$0" ${1+"$@"}
package require Tk
catch {console show}
#LISSI
set TPdirimage $env(HOME)
#Подгружаем пакет Img для работы с изображениями в форматах jpg и т.д.
#Исходники мои  для move, resize etc.
source [file join [file dirname [info script]] tkproe_extention.tcl]
if {$macos} {
    lappend auto_path  [file dirname [info script]] Img1.4.13]
}
catch {package require Img}

proc ShowWindow.tpmain {args} {
#LISSI
  global macos
  global TPpressLab

  StartupSrc.tpmain

  catch {destroy .tpmain}
  toplevel .tpmain  \
    -relief {raised} \
    -background {#dcdcdc} \
    -highlightbackground {#dcdcdc}

  # Window manager configurations
  wm positionfrom .tpmain program
  wm sizefrom .tpmain program
  wm maxsize .tpmain 1024 153
  wm minsize .tpmain 400 153
  wm protocol .tpmain WM_DELETE_WINDOW {TP_FileQuit}
  wm title .tpmain {TKproE -}

  # bindings
  bind .tpmain <ButtonRelease-1> {TP_ProcessClick %W %X %Y %x %y}
  bind .tpmain <Shift-Button-3> {TP_PropsSelWidget %W}

  menu .tpmenugeneral \
    -activebackground {#eeeeee} \
    -activeborderwidth {1} \
    -activeforeground {#000000} \
    -background {#eeeeee} \
    -borderwidth {1} \
    -font {Helvetica 10} \
    -foreground {#000000} \
    -tearoff {0}
  .tpmenugeneral add command \
    -command {TP_PathMenuCreate .} \
    -label {.}

  frame .tpmain.menubar \
    -borderwidth {2} \
    -relief {raised} \
    -background {blue4} \
    -height {32} \
    -highlightbackground {#dcdcdc} \
    -width {490}

#LISSI 
  if {$macos } {
    label .tpmain.menubar.menubutton1 \
    -activebackground {#dcdcdc} \
    -background {blue4} \
    -font {Helvetica 10} \
    -foreground {white} \
    -highlightbackground {#dcdcdc} \
    -padx {5} \
    -pady {0} \
    -text {File} \
    -underline {0}
    bind .tpmain.menubar.menubutton1 <Button-1> {TP_ShowContextMenuOSX %W }
    bind .tpmain.menubar.menubutton1 <Enter> {%W configure -background #dcdcdc -foreground black
    }
    bind .tpmain.menubar.menubutton1 <Leave> {global TPpressLab
	if { "%W" !=  "$TPpressLab" }  {
	    %W configure -background blue4 -foreground white
	}  else {
		%W configure -background red1 -foreground white
	}
	}
  } else {
  
  menubutton .tpmain.menubar.menubutton1 \
    -activebackground {#dcdcdc} \
    -background {blue4} \
    -font {Helvetica 10} \
    -foreground {white} \
    -highlightbackground {#dcdcdc} \
    -menu {.tpmain.menubar.menubutton1.m} \
    -padx {5} \
    -pady {0} \
    -text {File} \
    -underline {0}

  }
#LISSI
  option add *Menu.foreground blue4

  menu .tpmain.menubar.menubutton1.m \
    -activebackground {skyblue} \
    -activeborderwidth {1} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -font {Helvetica 10} \
    -selectcolor {#fffff0} \
    -tearoff {0}
  .tpmain.menubar.menubutton1.m add command \
    -command {TP_FileNew} \
    -label {New}
  .tpmain.menubar.menubutton1.m add command \
    -command {TP_FileOpen} \
    -label {Open}
  .tpmain.menubar.menubutton1.m add command \
    -command {TP_FileSource} \
    -label {Source}
  .tpmain.menubar.menubutton1.m add separator
  .tpmain.menubar.menubutton1.m add command \
    -command {TP_FileSave $TPprogFile} \
    -label {Save}
  .tpmain.menubar.menubutton1.m add command \
    -command {TP_FileSaveAs} \
    -label {Save As}
  .tpmain.menubar.menubutton1.m add separator
  .tpmain.menubar.menubutton1.m add command \
    -command {ShowWindow.tpnspacesave} \
    -label {Save Namespace}
  .tpmain.menubar.menubutton1.m add separator
  .tpmain.menubar.menubutton1.m add command \
    -command {TP_FileQuit} \
    -label {Quit}

#LISSI 
  if {$macos } {
    label .tpmain.menubar.menubutton0 \
    -activebackground {#dcdcdc} \
    -background {blue4} \
    -font {Helvetica 10} \
    -foreground {white} \
    -highlightbackground {#dcdcdc} \
    -padx {5} \
    -pady {0} \
    -text {Edit} \
    -underline {0}
    bind .tpmain.menubar.menubutton0 <Button-1> {TP_ShowContextMenuOSX %W }
    bind .tpmain.menubar.menubutton0 <Enter> {%W configure -background #dcdcdc -foreground black
    }
    bind .tpmain.menubar.menubutton0 <Leave> {global TPpressLab
	if { "%W" !=  "$TPpressLab" }  {
	    %W configure -background blue4 -foreground white
	}  else {
	    %W configure -background red1 -foreground white
	}
	}
  } else {

  menubutton .tpmain.menubar.menubutton0 \
    -activebackground {#dcdcdc} \
    -background {blue4} \
    -font {Helvetica 10} \
    -foreground {white} \
    -highlightbackground {#dcdcdc} \
    -menu {.tpmain.menubar.menubutton0.m} \
    -padx {5} \
    -pady {0} \
    -text {Edit} \
    -underline {0}

  }

  menu .tpmain.menubar.menubutton0.m \
    -activebackground {skyblue} \
    -activeborderwidth {1} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -font {Helvetica 10} \
    -selectcolor {#fffff0} \
    -tearoff {0}
  .tpmain.menubar.menubutton0.m add command \
    -command {TP_ActionBtnCut} \
    -label {Cut}
  .tpmain.menubar.menubutton0.m add command \
    -command {TP_ActionBtnCopy} \
    -label {Copy}
  .tpmain.menubar.menubutton0.m add command \
    -command {TP_ActionBtnPaste $TPcurPath} \
    -label {Paste}
  .tpmain.menubar.menubutton0.m add command \
    -command {TP_ActionBtnDelete} \
    -label {Delete}
  .tpmain.menubar.menubutton0.m add separator
  .tpmain.menubar.menubutton0.m add command \
    -command {set TPcutBuffer {}} \
    -label {Clear cutbuffer}
  .tpmain.menubar.menubutton0.m add command \
    -command {TP_CutBufSave} \
    -label {Save cutbuffer}
  .tpmain.menubar.menubutton0.m add separator
  .tpmain.menubar.menubutton0.m add command \
    -command {set TPtemplateAction Load
	ShowWindow.tpStdTemplates} \
    -label {Load standard template}
  .tpmain.menubar.menubutton0.m add command \
    -command {TP_CutBufLoad {Load cut buffer from template file:}} \
    -label {Load user template}
  .tpmain.menubar.menubutton0.m add command \
    -command {set TPtemplateAction Insert
	ShowWindow.tpStdTemplates} \
    -label {Insert standard template}
  .tpmain.menubar.menubutton0.m add command \
    -command {TP_CutBufLoad {Insert template from file:}
TP_ActionBtnPaste $TPcurPath} \
    -label {Insert user template}

  menu .tpmain.menubar.menubutton0.m.m \
    -activebackground {skyblue} \
    -activeborderwidth {1} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -font {Helvetica 10} \
    -selectcolor {#fffff0} \
    -tearoff {0}
  .tpmain.menubar.menubutton0.m.m add command \
    -label {System}
  .tpmain.menubar.menubutton0.m.m add command \
    -label {User}

#LISSI 
  if {$macos } {
    label .tpmain.menubar.menubutton35 \
    -activebackground {#dcdcdc} \
    -background {blue4} \
    -font {Helvetica 10} \
    -foreground {white} \
    -highlightbackground {#dcdcdc} \
    -padx {5} \
    -pady {0} \
    -text {Programming} \
    -underline {0}

    bind .tpmain.menubar.menubutton35 <Button-1> {TP_ShowContextMenuOSX %W }
    bind .tpmain.menubar.menubutton35 <Enter> {%W configure -background #dcdcdc -foreground black}
    bind .tpmain.menubar.menubutton35 <Leave> {global TPpressLab
	if { "%W" !=  "$TPpressLab" }  {
	    %W configure -background blue4 -foreground white
	}  else {
	    %W configure -background red1 -foreground white
	}}
  } else {
  
  menubutton .tpmain.menubar.menubutton35 \
    -activebackground {#dcdcdc} \
    -background {blue4} \
    -font {Helvetica 10} \
    -foreground {white} \
    -highlightbackground {#dcdcdc} \
    -menu {.tpmain.menubar.menubutton35.m} \
    -padx {5} \
    -pady {0} \
    -text {Programming} \
    -underline {0}
    
  }

  menu .tpmain.menubar.menubutton35.m \
    -activebackground {skyblue} \
    -activeborderwidth {1} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -font {Helvetica 10} \
    -selectcolor {#fffff0} \
    -tearoff {0}
  .tpmain.menubar.menubutton35.m add command \
    -command {set TPprocEdit TPstartupSrc
ShowWindow.tpprocs} \
    -label {TPstartupSrc}
  .tpmain.menubar.menubutton35.m add command \
    -command {set TPprocEdit TPendSrc
ShowWindow.tpprocs} \
    -label {TPendSrc}
    
#LISSI
  if {$macos } {
    label .tpmain.menubar.build \
     -activebackground #dcdcdc \
     -background {blue4} \
     -font {Helvetica 10} \
     -foreground {white} \
     -highlightthickness {0} \
     -padx {5} \
     -pady {0} \
     -relief {flat} \
     -text {Build} \
     -underline {0} 

    bind .tpmain.menubar.build <Button-1> { global TPpressLab
	if {$TPpressLab != ""} {
	    $TPpressLab configure -background blue4 -foreground white
	}
	set TPpressLab %W
	ShowWindow.tpbuild
    }
    bind .tpmain.menubar.build <Enter> {%W configure -background #dcdcdc -foreground black}
    bind .tpmain.menubar.build <Leave> {global TPpressLab
	if { "%W" !=  "$TPpressLab" }  {
	    %W configure -background blue4 -foreground white
	}  else {
	    %W configure -background red1 -foreground white
	}}
  } else {
 
  button .tpmain.menubar.build \
     -activebackground #dcdcdc \
     -background {blue4} \
     -font {Helvetica 10} \
     -foreground {white} \
     -highlightthickness {0} \
     -padx {5} \
     -pady {0} \
     -relief {flat} \
     -text {Build} \
     -underline {0} \
     -command {ShowWindow.tpbuild}
     
  }
  
  bind .tpmain <Alt-Key-b> ShowWindow.tpbuild

#LISSI 
  if {$macos } {
    label .tpmain.menubar.menubutton36 \
    -activebackground {#dcdcdc} \
    -background {blue4} \
    -font {Helvetica 10} \
    -foreground {white} \
    -highlightbackground {#dcdcdc} \
    -padx {5} \
    -pady {0} \
    -text {Window} \
    -underline {0}

    bind .tpmain.menubar.menubutton36 <Button-1> {TP_ShowContextMenuOSX %W }
    bind .tpmain.menubar.menubutton36 <Enter> {%W configure -background #dcdcdc -foreground black}
    bind .tpmain.menubar.menubutton36 <Leave> {global TPpressLab
	if { "%W" !=  "$TPpressLab" }  {
	    %W configure -background blue4 -foreground white
	}  else {
	    %W configure -background red1 -foreground white
	}}
  } else {
  
  menubutton .tpmain.menubar.menubutton36 \
    -activebackground {#dcdcdc} \
    -background {blue4} \
    -font {Helvetica 10} \
    -foreground {white} \
    -highlightbackground {#dcdcdc} \
    -menu {.tpmain.menubar.menubutton36.m} \
    -padx {5} \
    -pady {0} \
    -text {Window} \
    -underline {0}

  }

  menu .tpmain.menubar.menubutton36.m \
    -activebackground {skyblue} \
    -activeborderwidth {1} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -font {Helvetica 10} \
    -relief {sunken} \
    -selectcolor {#fffff0} \
    -tearoff {0}
  .tpmain.menubar.menubutton36.m add checkbutton \
    -variable {TPshowFonts} \
    -command {if {$TPshowFonts} {
   ShowWindow.tpfontselect
   after 100 {set TPselWidget(.tpfontselect) .tpnothing}
  } { DestroyWindow.tpfontselect }} \
    -label {Fonts}
  .tpmain.menubar.menubutton36.m add checkbutton \
    -variable {TPshowGlobals} \
    -command {if {$TPshowGlobals} {
   ShowWindow.tpvars
  } { DestroyWindow.tpvars }} \
    -label {Global variables}
  .tpmain.menubar.menubutton36.m add checkbutton \
    -variable {TPshowIcons} \
    -command {if {$TPshowIcons} {
   ShowWindow.tpiconlib
  } { DestroyWindow.tpiconlib }} \
    -label {Icon library}
  .tpmain.menubar.menubutton36.m add checkbutton \
    -variable {TPshowImages} \
    -command {if {$TPshowImages} {
   ShowWindow.tpimages
  } { DestroyWindow.tpimages }} \
    -label {Images}
  .tpmain.menubar.menubutton36.m add checkbutton \
    -variable {TPshowProcs} \
    -command {if {$TPshowProcs} {
   ShowWindow.tpprocs
  } { DestroyWindow.tpprocs }} \
    -label {Procedures}
  .tpmain.menubar.menubutton36.m add checkbutton \
    -variable {TPshowToplevels} \
    -command {TP_ShowToplevels} \
    -label {Toplevel windows}
  .tpmain.menubar.menubutton36.m add checkbutton \
    -variable {TPshowWatch} \
    -command {if {$TPshowWatch} {
   ShowWindow.tpwatchwin
  } { DestroyWindow.tpwatchwin }} \
    -label {Watch Window}
  .tpmain.menubar.menubutton36.m add checkbutton \
    -variable {TPshowWidgetTree} \
    -command {TP_ShowWidgetTree} \
    -label {Widget tree}
  .tpmain.menubar.menubutton36.m add separator
  .tpmain.menubar.menubutton36.m add checkbutton \
    -variable {TPshowconsole} \
    -command {if {$TPshowconsole} {
   catch {console show}
  } { catch {console hide} }} \
    -label {Console}

#LISSI 
  if {$macos } {
    label .tpmain.menubar.menubutton2 \
    -activebackground {#dcdcdc} \
    -background {blue4} \
    -font {Helvetica 10} \
    -foreground {white} \
    -highlightbackground {#dcdcdc} \
    -padx {5} \
    -pady {0} \
    -text {Options} \
    -underline {0}

    bind .tpmain.menubar.menubutton2 <Button-1> {TP_ShowContextMenuOSX %W }
    bind .tpmain.menubar.menubutton2 <Enter> {%W configure -background #dcdcdc -foreground black}
    bind .tpmain.menubar.menubutton2 <Leave> {global TPpressLab
	if { "%W" !=  "$TPpressLab" }  {
	    %W configure -background blue4 -foreground white
	}  else {
	    %W configure -background red1 -foreground white
	}}
  } else {
  
  menubutton .tpmain.menubar.menubutton2 \
    -activebackground {#dcdcdc} \
    -background {blue4} \
    -font {Helvetica 10} \
    -foreground {white} \
    -highlightbackground {#dcdcdc} \
    -menu {.tpmain.menubar.menubutton2.m} \
    -padx {5} \
    -pady {0} \
    -text {Options} \
    -underline {0}

  }

  menu .tpmain.menubar.menubutton2.m \
    -activebackground {SkyBlue} \
    -activeborderwidth {1} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -font {Helvetica 10} \
    -selectcolor {#fffff0} \
    -tearoff {0}
  .tpmain.menubar.menubutton2.m add command \
    -command {set TPnextObj 0} \
    -label {Reset widget counter}
  .tpmain.menubar.menubutton2.m add separator
  .tpmain.menubar.menubutton2.m add command \
    -command {ShowWindow.tpgenopts} \
    -label {General}

#LISSI 
  if {$macos } {
    label .tpmain.menubar.menubutton4 \
    -activebackground {#dcdcdc} \
    -background {blue4} \
    -font {Helvetica 10} \
    -foreground {white} \
    -highlightbackground {#dcdcdc} \
    -padx {5} \
    -pady {0} \
    -text {Help} \
    -underline {0}

    bind .tpmain.menubar.menubutton4 <Button-1> {TP_ShowContextMenuOSX %W }
    bind .tpmain.menubar.menubutton4 <Enter> {%W configure -background #dcdcdc -foreground black}
    bind .tpmain.menubar.menubutton4 <Leave> {global TPpressLab
	if { "%W" !=  "$TPpressLab" }  {
	    %W configure -background blue4 -foreground white
	}  else {
	    %W configure -background red1 -foreground white
	}}
  } else {
  
  menubutton .tpmain.menubar.menubutton4 \
    -activebackground {#dcdcdc} \
    -background {blue4} \
    -font {Helvetica 10} \
    -foreground {white} \
    -highlightbackground {#dcdcdc} \
    -menu {.tpmain.menubar.menubutton4.m} \
    -padx {5} \
    -pady {0} \
    -text {Help} \
    -underline {0}

  }

  menu .tpmain.menubar.menubutton4.m \
    -activebackground {skyblue} \
    -activeborderwidth {1} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -font {Helvetica 10} \
    -selectcolor {#fffff0} \
    -tearoff {0}
  .tpmain.menubar.menubutton4.m add command \
    -command {ShowWindow.tpabout} \
    -label {About}
  .tpmain.menubar.menubutton4.m add command \
    -command {TP_ShowHelp TKproEdocs.pdf} \
    -label {TKproE documentation}

  frame .tpmain.cmdbar \
    -background {#dcdcdc} \
    -height {33} \
    -highlightbackground {#dcdcdc} \
    -width {490}
#LISSI
  button .tpmain.cmdbar.buttonOpen \
    -activebackground {gray75} \
    -background {#dcdcdc} \
    -command {TP_FileOpen} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -image {tpfileopen22} -relief flat \
    -text {buttonOpen}
    TP_helpTeach .tpmain.cmdbar.buttonOpen "Open TKproE! project"

  button .tpmain.cmdbar.button1 \
    -activebackground {gray75} \
    -background {#dcdcdc} \
    -command {TP_FileSave $TPprogFile} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -image {tpfilesave} -relief flat \
    -text {button1}
#LISSI
    TP_helpTeach .tpmain.cmdbar.button1 "Save TKproE! project"

  button .tpmain.cmdbar.button2 \
    -activebackground {gray75} \
    -background {#dcdcdc} \
    -command {TP_PropsSelWidget $TPcurPath} \
    -cursor {question_arrow} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -image {tpproperties} -relief flat \
    -text {button2}
#LISSI
    TP_helpTeach .tpmain.cmdbar.button2 "Properties of the current widget"


  # bindings
  bind .tpmain.cmdbar.button2 <ButtonRelease-3> {set TPtemp [winfo containing %X %Y]
if {($TPtemp != {}) && ([string range $TPtemp 0 2] != {.tp})} { TP_PathMenuCreate $TPtemp; %W invoke }}

  button .tpmain.cmdbar.button3 \
    -activebackground {gray75} \
    -background {#dcdcdc} \
    -command {set TPpackParent $TPcurPath
if {[winfo exists .tppacker]} {
     EndSrc.tppacker
   } { ShowWindow.tppacker }} \
    -cursor {question_arrow} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -image {tppack} -relief flat \
    -text {button3}
  # bindings
  bind .tpmain.cmdbar.button3 <ButtonRelease-3> {set TPtemp [winfo containing %X %Y]
if {($TPtemp != {}) && ([string range $TPtemp 0 2] != {.tp})} { TP_PathMenuCreate $TPtemp; %W invoke }}
#LISSI
    TP_helpTeach .tpmain.cmdbar.button3 "Pack: placement in current widget"

  button .tpmain.cmdbar.button4 \
    -activebackground {gray75} \
    -background {#dcdcdc} \
    -command {set TPplaceParent $TPcurPath
if {[winfo exists .tpplacer]} {
    EndSrc.tpplacer
   } { ShowWindow.tpplacer }} \
    -cursor {question_arrow} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -image {tpplace} -relief flat \
    -text {button3}
  # bindings
  bind .tpmain.cmdbar.button4 <ButtonRelease-3> {set TPtemp [winfo containing %X %Y]
if {($TPtemp != {}) && ([string range $TPtemp 0 2] != {.tp})} { TP_PathMenuCreate $TPtemp; %W invoke }}
#LISSI
    TP_helpTeach .tpmain.cmdbar.button4 "Place: placement in current widget"

  button .tpmain.cmdbar.button5 \
    -activebackground {gray75} \
    -background {#dcdcdc} \
    -command {if {[winfo exists $TPcurPath]} {
    if {[winfo exists .tpbinding]} {
        EndSrc.tpbinding
       } { ShowWindow.tpbinding }
  }} \
    -cursor {question_arrow} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -image {tpbind} -relief flat \
    -text {button3}
  # bindings
  bind .tpmain.cmdbar.button5 <ButtonRelease-3> {set TPtemp [winfo containing %X %Y]
if {($TPtemp != {}) && ([string range $TPtemp 0 2] != {.tp})} { TP_PathMenuCreate $TPtemp; %W invoke }}
#LISSI
    TP_helpTeach .tpmain.cmdbar.button5 "Current widget bindings"

  button .tpmain.cmdbar.button6 \
    -activebackground {gray75} \
    -background {#dcdcdc} \
    -command {ShowWindow.tpprocs} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -image {tpprocs} -relief flat \
    -text {button3}
#LISSI
    TP_helpTeach .tpmain.cmdbar.button6 "User procedures"

  button .tpmain.cmdbar.button7 \
    -activebackground {gray75} \
    -background {#dcdcdc} \
    -command {ShowWindow.tpvars} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -image {tpvars} -relief flat \
    -text {button3}
#LISSI
    TP_helpTeach .tpmain.cmdbar.button7 "Global variables"

  button .tpmain.cmdbar.button8 \
    -activebackground {gray75} \
    -background {#dcdcdc} \
    -command {ShowWindow.tpTree} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -image {tptree} -relief flat \
    -text {button3}
    TP_helpTeach .tpmain.cmdbar.button8 "Widget tree"
#LISSI
    TP_helpTeach .tpmain.cmdbar.button8 "Select current widget"

  button .tpmain.cmdbar.button9 \
    -activebackground {gray75} \
    -background {#dcdcdc} \
    -command {TP_ActionBtnCut} \
    -cursor {question_arrow} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -image {tpcut} -relief flat \
    -text {button3}
  # bindings
  bind .tpmain.cmdbar.button9 <ButtonRelease-3> {set TPtemp [winfo containing %X %Y]
if {($TPtemp != "") && ([string range $TPtemp 0 2] != ".tp")} { TP_PathMenuCreate $TPtemp; %W invoke }}
#LISSI
    TP_helpTeach .tpmain.cmdbar.button9 "Cut current widget"

  button .tpmain.cmdbar.button10 \
    -activebackground {gray75} \
    -background {#dcdcdc} \
    -command {TP_ActionBtnCopy} \
    -cursor {question_arrow} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -image {tpcopy} -relief flat \
    -text {button3}
  # bindings
  bind .tpmain.cmdbar.button10 <ButtonRelease-3> {set TPtemp [winfo containing %X %Y]
if {($TPtemp != "") && ([string range $TPtemp 0 2] != ".tp")} { TP_PathMenuCreate $TPtemp; %W invoke }}
#LISSI
    TP_helpTeach .tpmain.cmdbar.button10 "Copy current widget"

  button .tpmain.cmdbar.button11 \
    -activebackground {gray75} \
    -background {#dcdcdc} \
    -command {TP_ActionBtnPaste $TPcurPath} \
    -cursor {question_arrow} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -image {tppaste} -relief flat \
    -text {button3}
  # bindings
  bind .tpmain.cmdbar.button11 <ButtonRelease-3> {set TPtemp [winfo containing %X %Y]
if {($TPtemp != "") && ([string range $TPtemp 0 2] != ".tp")} { TP_PathMenuCreate $TPtemp; %W invoke }}
#LISSI
    TP_helpTeach .tpmain.cmdbar.button11 "Paste copy/cut widget"

  button .tpmain.cmdbar.button12 \
    -activebackground {gray75} \
    -background {#dcdcdc} \
    -command {TP_ActionBtnDelete} \
    -cursor {question_arrow} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -image {tptrash} -relief flat \
    -text {button3}
  # bindings
  bind .tpmain.cmdbar.button12 <ButtonRelease-3> {set TPtemp [winfo containing %X %Y]
if {($TPtemp != "") && ([string range $TPtemp 0 2] != ".tp")} { TP_PathMenuCreate $TPtemp; %W invoke }}
#LISSI
    TP_helpTeach .tpmain.cmdbar.button12 "Delete current widget"

  button .tpmain.cmdbar.button0 \
    -activebackground {gray75} \
    -background {#dcdcdc} \
    -command {set TPgridParent $TPcurPath
if {[winfo exists .tpgridder]} {
     EndSrc.tpgridder
   } { ShowWindow.tpgridder }} \
    -cursor {question_arrow} \
    -font {Helvetica 10} \
    -height {22} \
    -highlightbackground {#dcdcdc} \
    -image {tpgrid} -relief flat \
    -text {button3} \
    -width {22}
  # bindings
  bind .tpmain.cmdbar.button0 <ButtonRelease-3> {set TPtemp [winfo containing %X %Y]
if {($TPtemp != {}) && ([string range $TPtemp 0 2] != {.tp})} { TP_PathMenuCreate $TPtemp; %W invoke }}
#LISSI
    TP_helpTeach .tpmain.cmdbar.button0 "Grid: placement in current widget"

  ttk::separator .tpmain.sep2 -orient horizontal

  label .tpmain.label32 \
    -activebackground {#dcdcdc} \
    -anchor {w} \
    -background {#dcdcdc} \
    -borderwidth {0} \
    -font {Helvetica 10} \
    -foreground {red} \
    -highlightbackground {#dcdcdc} \
    -text {Program saved to P:/tkproe/dtest.tcl} \
    -textvariable {TPstatusLine}

  frame .tpmain.pathbar \
    -borderwidth {2} \
    -relief {ridge} \
    -background {PapayaWhip} \
    -height {28} \
    -highlightbackground {#dcdcdc} \
    -width {490}

  label .tpmain.pathbar.label34 \
    -activebackground {#dcdcdc} \
    -background {PapayaWhip} \
    -cursor {question_arrow} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -relief {raised} \
    -text {Current widget path:}
  # bindings
  bind .tpmain.pathbar.label34 <ButtonRelease-1> {ShowWindow.tpToplevels}
  bind .tpmain.pathbar.label34 <ButtonRelease-3> {set TPtemp [winfo containing %X %Y]
if {($TPtemp != "") && ([string range $TPtemp 0 2] != ".tp")} { TP_PathMenuCreate $TPtemp }}
  bind .tpmain.pathbar.label34 <Enter> {set TPstatusLine {Press mouse button 3 and release over desired widget to change current path}}
  bind .tpmain.pathbar.label34 <Leave> {set TPstatusLine {}}

  frame .tpmain.pathbar.menubar \
    -borderwidth {2} \
    -background {PapayaWhip}

  button .tpmain.pathbar.menubar.dotroot \
    -activebackground {gray75} \
    -background {PapayaWhip} \
    -borderwidth {0} \
    -command {TP_PathMenuPopup  {.} [winfo rootx .tpmain.pathbar.menubar.dotroot] [winfo rooty .tpmain.pathbar.menubar.dotroot]} \
    -font {Helvetica 8} \
    -highlightthickness {0} \
    -padx {0} \
    -pady {0} \
    -relief {flat} \
    -text {.}

  ttk::separator .tpmain.sep1 -orient horizontal

  frame .tpmain.objbar \
    -relief {raised} \
    -background {#eeeeee} \
    -height {64} \
    -highlightbackground {#eeeeee} \
    -width {538}

  frame .tpmain.objbar.tk \
    -relief {raised} \
    -background {#dcdcdc} \
    -height {30} \
    -highlightbackground {#dcdcdc} \
    -width {534}

  button .tpmain.objbar.tk.button0 \
    -activebackground {gray75} \
    -background {#dcdcdc} \
    -command {TP_AddNewObj frame} \
    -cursor {arrow} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -highlightthickness {0} \
    -image {tpframe} \
    -text {button0}
    TP_helpTeach .tpmain.objbar.tk.button0 "Frame"

  button .tpmain.objbar.tk.button1 \
    -activebackground {gray75} \
    -background {#dcdcdc} \
    -command {TP_AddNewObj canvas} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -highlightthickness {0} \
    -image {tpcanvas} \
    -text {button1}
    TP_helpTeach .tpmain.objbar.tk.button1 "Canvas"

  button .tpmain.objbar.tk.button16 \
    -activebackground {gray75} \
    -background {#dcdcdc} \
    -command {TP_AddNewObj button} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -highlightthickness {0} \
    -image {tpbutton} \
    -text {button0}
    TP_helpTeach .tpmain.objbar.tk.button16 "Button"

  button .tpmain.objbar.tk.button17 \
    -activebackground {gray75} \
    -background {#dcdcdc} \
    -command {TP_AddNewObj entry} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -highlightthickness {0} \
    -image {tpentry} \
    -text {button1}
    TP_helpTeach .tpmain.objbar.tk.button17 "Entry"

  button .tpmain.objbar.tk.button18 \
    -activebackground {gray75} \
    -background {#dcdcdc} \
    -command {TP_AddNewObj label} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -highlightthickness {0} \
    -image {tplabel} \
    -text {button0}
    TP_helpTeach .tpmain.objbar.tk.button18 "Label"

  button .tpmain.objbar.tk.button19 \
    -activebackground {gray75} \
    -background {#dcdcdc} \
    -command {TP_AddNewObj message} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -highlightthickness {0} \
    -image {tpmessage} \
    -text {button1}
    TP_helpTeach .tpmain.objbar.tk.button19 "Message Box"

  button .tpmain.objbar.tk.button20 \
    -activebackground {gray75} \
    -background {#dcdcdc} \
    -command {TP_AddNewObj listbox} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -highlightthickness {0} \
    -image {tplistbox} \
    -text {button0}
    TP_helpTeach .tpmain.objbar.tk.button20 "Listbox"

  button .tpmain.objbar.tk.button21 \
    -activebackground {gray75} \
    -background {#dcdcdc} \
    -command {TP_AddNewObj text} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -highlightthickness {0} \
    -image {tptext} \
    -text {button1}
    TP_helpTeach .tpmain.objbar.tk.button21 "Text"

  button .tpmain.objbar.tk.button22 \
    -activebackground {gray75} \
    -background {#dcdcdc} \
    -command {TP_AddNewObj menubutton} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -highlightthickness {0} \
    -image {tpmenubutton} \
    -text {button0}
    TP_helpTeach .tpmain.objbar.tk.button22 "Menu Button"

  button .tpmain.objbar.tk.button23 \
    -activebackground {gray75} \
    -background {#dcdcdc} \
    -command {TP_AddNewObj menu} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -highlightthickness {0} \
    -image {tpmenu} \
    -text {button1}
    TP_helpTeach .tpmain.objbar.tk.button23 "Menu"

  button .tpmain.objbar.tk.button24 \
    -activebackground {gray75} \
    -background {#dcdcdc} \
    -command {TP_AddNewObj vscale} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -highlightthickness {0} \
    -image {tpscale_v} \
    -text {button0}
    TP_helpTeach .tpmain.objbar.tk.button24 "Vertical Scale"

  button .tpmain.objbar.tk.button25 \
    -activebackground {gray75} \
    -background {#dcdcdc} \
    -command {TP_AddNewObj hscale} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -highlightthickness {0} \
    -image {tpscale_h} \
    -text {button1}
    TP_helpTeach .tpmain.objbar.tk.button25 "Horizontal Scale"

  button .tpmain.objbar.tk.button26 \
    -activebackground {gray75} \
    -background {#dcdcdc} \
    -command {TP_AddNewObj vscrollbar} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -highlightthickness {0} \
    -image {tpscrollbar_v} \
    -text {button0}
    TP_helpTeach .tpmain.objbar.tk.button26 "Vertical Scrollbar"

  button .tpmain.objbar.tk.button27 \
    -activebackground {gray75} \
    -background {#dcdcdc} \
    -command {TP_AddNewObj hscrollbar} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -highlightthickness {0} \
    -image {tpscrollbar_h} \
    -text {button1}
    TP_helpTeach .tpmain.objbar.tk.button27 "Horizontal Scrollbar"

  button .tpmain.objbar.tk.button28 \
    -activebackground {gray75} \
    -background {#dcdcdc} \
    -command {TP_AddNewObj checkbutton} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -highlightthickness {0} \
    -image {tpcheckbutton} -width 20 -height 20\
    -text {button0}
    TP_helpTeach .tpmain.objbar.tk.button28 "Check button"

  button .tpmain.objbar.tk.button29 \
    -activebackground {gray75} \
    -background {#dcdcdc} \
    -command {TP_AddNewObj radiobutton} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -highlightthickness {0} \
    -image {tpradiobutton} -width 20 -height 20 \
    -text {button1}
    TP_helpTeach .tpmain.objbar.tk.button29 "Radio button"

  button .tpmain.objbar.tk.button30 \
    -activebackground {gray75} \
    -background {#dcdcdc} \
    -command {TP_AddNewObj toplevel} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -highlightthickness {0} \
    -image {tptoplevel} \
    -text {button0}
    TP_helpTeach .tpmain.objbar.tk.button30 "Top level"

  button .tpmain.objbar.tk.button31 -activebackground {gray75} -background {gray85} \
    -command {TP_ShowWidgets} -font {Helvetica 10} -highlightbackground {#dcdcdc} \
    -highlightthickness {0} -image {tptoolbar} -height 20 -width 20
    TP_helpTeach .tpmain.objbar.tk.button31 "Toolbar"

  button .tpmain.objbar.tk.button11 \
    -activebackground {gray75} \
    -background {#dcdcdc} \
    -command {TP_AddNewObj labelframe} \
    -cursor {arrow} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -highlightthickness {0} \
    -image {tplabelframe} \
    -text {button0}
    TP_helpTeach .tpmain.objbar.tk.button11 "Label Frame"

  button .tpmain.objbar.tk.button12 \
    -activebackground {gray75} \
    -background {#dcdcdc} \
    -command {TP_AddNewObj spinbox} \
    -cursor {arrow} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -highlightthickness {0} \
    -image {tpspinbox} \
    -text {button0}
    TP_helpTeach .tpmain.objbar.tk.button12 "Spinbox"

  button .tpmain.objbar.tk.button13 \
    -activebackground {gray75} \
    -background {#dcdcdc} \
    -command {TP_AddNewObj hpanedwindow} \
    -cursor {arrow} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -highlightthickness {0} \
    -image {tppanedwin_h} \
    -text {button0}
    TP_helpTeach .tpmain.objbar.tk.button13 "Horizontal Panedwindow"

  button .tpmain.objbar.tk.button14 \
    -activebackground {gray75} \
    -background {#dcdcdc} \
    -command {TP_AddNewObj vpanedwindow} \
    -cursor {arrow} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -highlightthickness {0} \
    -image {tppanedwin_v} \
    -text {button0}
    TP_helpTeach .tpmain.objbar.tk.button14 "Vertical Panedwindow"

  frame .tpmain.objbar.ttk \
    -relief {raised} \
    -background {#dcdcdc} \
    -height {30} \
    -highlightbackground {#dcdcdc} \
    -width {534}

  button .tpmain.objbar.ttk.frame \
    -activebackground {#8585fe} \
    -background {skyblue} \
    -command {TP_AddNewObj Tframe} \
    -cursor {arrow} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -highlightthickness {0} \
    -image {tpframeT} \
    -text {button0}
    TP_helpTeach .tpmain.objbar.ttk.frame "Frame"

  button .tpmain.objbar.ttk.notebook \
    -activebackground {#8585fe} \
    -background {skyblue} \
    -command {TP_AddNewObj Tnotebook} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -highlightthickness {0} \
    -image {tpnotebookT} \
    -text {button0}
    TP_helpTeach .tpmain.objbar.ttk.notebook "Notebook"

  button .tpmain.objbar.ttk.button \
    -activebackground {#8585fe} \
    -background {skyblue} \
    -command {TP_AddNewObj Tbutton} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -highlightthickness {0} \
    -image {tpbuttonT} \
    -text {button0}
    TP_helpTeach .tpmain.objbar.ttk.button "Button"

  button .tpmain.objbar.ttk.entry \
    -activebackground {#8585fe} \
    -background {skyblue} \
    -command {TP_AddNewObj Tentry} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -highlightthickness {0} \
    -image {tpentryT} \
    -text {button1}
    TP_helpTeach .tpmain.objbar.ttk.entry "Entry"

  button .tpmain.objbar.ttk.label \
    -activebackground {#8585fe} \
    -background {#87ceeb} \
    -command {TP_AddNewObj Tlabel} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -highlightthickness {0} \
    -image {tplabelT} \
    -text {button0}
    TP_helpTeach .tpmain.objbar.ttk.label "Label"

  button .tpmain.objbar.ttk.hseparator9 \
    -activebackground {#8585fe} \
    -background {skyblue} \
    -command {} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -highlightthickness {0} \
    -image {tpblank} \
    -text {button1}
#     TP_helpTeach .tpmain.objbar.ttk.hseparator9 ""

  button .tpmain.objbar.ttk.listbox \
    -activebackground {#8585fe} \
    -background {#87CEEB} \
    -command {} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -highlightthickness {0} \
    -image {tpblank} \
    -text {button0}
#     TP_helpTeach .tpmain.objbar.ttk.listbox ""

  button .tpmain.objbar.ttk.treeview \
    -activebackground {#8585fe} \
    -background {skyblue} \
    -command {TP_AddNewObj Ttreeview} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -highlightthickness {0} \
    -image {tptreeviewT} \
    -text {button1}
    TP_helpTeach .tpmain.objbar.ttk.treeview "Tree"

  button .tpmain.objbar.ttk.menubutton \
    -activebackground {#8585fe} \
    -background {skyblue} \
    -command {TP_AddNewObj Tmenubutton} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -highlightthickness {0} \
    -image {tpmenubuttonT} \
    -text {button0}
    TP_helpTeach .tpmain.objbar.ttk.menubutton "Menubutton"

  button .tpmain.objbar.ttk.combo \
    -activebackground {#8585fe} \
    -background {skyblue} \
    -command {TP_AddNewObj Tcombobox} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -highlightthickness {0} \
    -image {tpcomboT} -height 20 -width 20 \
    -text {button1}
    TP_helpTeach .tpmain.objbar.ttk.combo "Combobox"

  button .tpmain.objbar.ttk.vseparator \
    -activebackground {#8585fe} \
    -background {skyblue} \
    -command {TP_AddNewObj Tvseparator} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -highlightthickness {0} \
    -image {tpseparator_vT} \
    -text {button1}
    TP_helpTeach .tpmain.objbar.ttk.vseparator "Vertical Separator"

  button .tpmain.objbar.ttk.hseparator \
    -activebackground {#8585fe} \
    -background {skyblue} \
    -command {TP_AddNewObj Thseparator} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -highlightthickness {0} \
    -image {tpseparator_hT} \
    -text {button1}
    TP_helpTeach .tpmain.objbar.ttk.hseparator "Horizontal Separator"

  button .tpmain.objbar.ttk.vscrollbar \
    -activebackground {#8585fe} \
    -background {skyblue} \
    -command {TP_AddNewObj Tvscrollbar} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -highlightthickness {0} \
    -image {tpscrollbar_vT} \
    -text {button0}
    TP_helpTeach .tpmain.objbar.ttk.vscrollbar "Vertical Scrollbar"

  button .tpmain.objbar.ttk.hscrollbar \
    -activebackground {#8585fe} \
    -background {skyblue} \
    -command {TP_AddNewObj Thscrollbar} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -highlightthickness {0} \
    -image {tpscrollbar_hT} \
    -text {button1}
    TP_helpTeach .tpmain.objbar.ttk.hscrollbar "Horizontal Scrollbar"

  button .tpmain.objbar.ttk.checkbutton \
    -activebackground {#8585fe} \
    -background {skyblue} \
    -command {TP_AddNewObj Tcheckbutton} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -highlightthickness {0} \
    -image {tpcheckbutton} -width 20 -height 20 \
    -text {button0}
    TP_helpTeach .tpmain.objbar.ttk.checkbutton "Check button"

  button .tpmain.objbar.ttk.radiobutton \
    -activebackground {#8585fe} \
    -background {skyblue} \
    -command {TP_AddNewObj Tradiobutton} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -highlightthickness {0} \
    -image {tpradiobuttonT} -width 20 -height 20 \
    -text {button1}
    TP_helpTeach .tpmain.objbar.ttk.radiobutton "Radio button"

  button .tpmain.objbar.ttk.sizegrip \
    -activebackground {#8585fe} \
    -background {skyblue} \
    -command {TP_AddNewObj Tsizegrip} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -highlightthickness {0} \
    -image {tpsizegripT} -height 20 -width 20 \
    -text {button0}
    TP_helpTeach .tpmain.objbar.ttk.sizegrip "Size Grip"

  button .tpmain.objbar.ttk.labelframe \
    -activebackground {#8585fe} \
    -background {skyblue} \
    -cursor {arrow} \
    -command {TP_AddNewObj Tlabelframe} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -highlightthickness {0} \
    -image {tplabelframeT}
    TP_helpTeach .tpmain.objbar.ttk.labelframe "Labeled frame"

  button .tpmain.objbar.ttk.progress \
    -activebackground {#8585fe} \
    -background {skyblue} \
    -command {TP_AddNewObj Tprogressbar} \
    -cursor {arrow} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -highlightthickness {0} \
    -image {tpprogressbarT} \
    -text {button0}
    TP_helpTeach .tpmain.objbar.ttk.progress "Progress"

  button .tpmain.objbar.ttk.panedwin_h \
    -activebackground {#8585fe} \
    -background {skyblue} \
    -command {TP_AddNewObj Thpanedwindow} \
    -cursor {arrow} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -highlightthickness {0} \
    -image {tppanedwin_hT} \
    -text {button0}
    TP_helpTeach .tpmain.objbar.ttk.panedwin_h "Horizontal Panedwindow"

  button .tpmain.objbar.ttk.panedwin_v \
    -activebackground {#8585fe} \
    -background {skyblue} \
    -command {TP_AddNewObj Tvpanedwindow} \
    -cursor {arrow} \
    -font {Helvetica 10} \
    -highlightbackground {#dcdcdc} \
    -highlightthickness {0} \
    -image {tppanedwin_vT} \
    -text {button0}
    TP_helpTeach .tpmain.objbar.ttk.panedwin_v "Vertical Panedwindow"

  button .tpmain.objbar.ttk.toolbar -activebackground {#8585fe} -background {skyblue} -command {TP_ShowWidgets} -font {Helvetica 10} -highlightbackground {#dcdcdc} -highlightthickness {0} -image {tptoolbar} -height 20 -width 20

  # pack master .tpmain.menubar
  pack configure .tpmain.menubar.menubutton1 -side left -pady 3 -padx 3
  pack configure .tpmain.menubar.menubutton0 -side left
  pack configure .tpmain.menubar.menubutton35 -side left
  pack configure .tpmain.menubar.build -side left
  pack configure .tpmain.menubar.menubutton36 -side left
  pack configure .tpmain.menubar.menubutton2 -side left
  pack configure .tpmain.menubar.menubutton4 -side right

  # pack master .tpmain.cmdbar
#LISSI
  pack configure .tpmain.cmdbar.buttonOpen -fill y -side left

  pack configure .tpmain.cmdbar.button1 -fill y -side left
  pack configure .tpmain.cmdbar.button2 -fill y -side left
  pack configure .tpmain.cmdbar.button3 -fill y -side left
  pack configure .tpmain.cmdbar.button4 -fill y -side left
  pack configure .tpmain.cmdbar.button0 -fill y -side left
  pack configure .tpmain.cmdbar.button5 -fill y -side left
  pack configure .tpmain.cmdbar.button6 -fill y -side left
  pack configure .tpmain.cmdbar.button7 -fill y -side left
  pack configure .tpmain.cmdbar.button8 -fill y -side left
  pack configure .tpmain.cmdbar.button9 -fill y -side left
  pack configure .tpmain.cmdbar.button10 -fill y -side left
  pack configure .tpmain.cmdbar.button11 -fill y -side left
  pack configure .tpmain.cmdbar.button12 -fill y -side left

  # pack master .tpmain.pathbar
  pack configure .tpmain.pathbar.label34 -side left 
  pack configure .tpmain.pathbar.menubar -side left

  # pack master .tpmain.pathbar.menubar
  pack configure .tpmain.pathbar.menubar.dotroot -fill x -side left

  # pack master .tpmain.objbar
  pack configure .tpmain.objbar.tk -anchor w
  pack configure .tpmain.objbar.ttk -anchor w

  # pack master .tpmain.objbar.tk
  pack configure .tpmain.objbar.tk.button0 -side left
  pack configure .tpmain.objbar.tk.button1 -side left
  pack configure .tpmain.objbar.tk.button16 -side left
  pack configure .tpmain.objbar.tk.button17 -side left
  pack configure .tpmain.objbar.tk.button18 -side left
  pack configure .tpmain.objbar.tk.button19 -side left
  pack configure .tpmain.objbar.tk.button20 -side left
  pack configure .tpmain.objbar.tk.button21 -side left
  pack configure .tpmain.objbar.tk.button22 -side left
  pack configure .tpmain.objbar.tk.button23 -side left
  pack configure .tpmain.objbar.tk.button24 -side left
  pack configure .tpmain.objbar.tk.button25 -side left
  pack configure .tpmain.objbar.tk.button26 -side left
  pack configure .tpmain.objbar.tk.button27 -side left
  pack configure .tpmain.objbar.tk.button28 -side left
  pack configure .tpmain.objbar.tk.button29 -side left
  pack configure .tpmain.objbar.tk.button30 -side left
  pack configure .tpmain.objbar.tk.button11 -side left
  pack configure .tpmain.objbar.tk.button12 -side left
  pack configure .tpmain.objbar.tk.button13 -side left
  pack configure .tpmain.objbar.tk.button14 -side left
  #pack configure .tpmain.objbar.tk.button31 -side left

  # pack master .tpmain.objbar.ttk
  pack configure .tpmain.objbar.ttk.frame -side left
  pack configure .tpmain.objbar.ttk.notebook -side left
  pack configure .tpmain.objbar.ttk.button -side left
  pack configure .tpmain.objbar.ttk.entry -side left
  pack configure .tpmain.objbar.ttk.label -side left
  pack configure .tpmain.objbar.ttk.hseparator9 -side left
  pack configure .tpmain.objbar.ttk.listbox -side left
  pack configure .tpmain.objbar.ttk.treeview -side left
  pack configure .tpmain.objbar.ttk.menubutton -side left
  pack configure .tpmain.objbar.ttk.combo -side left
  pack configure .tpmain.objbar.ttk.vseparator -side left
  pack configure .tpmain.objbar.ttk.hseparator -side left
  pack configure .tpmain.objbar.ttk.vscrollbar -side left
  pack configure .tpmain.objbar.ttk.hscrollbar -side left
  pack configure .tpmain.objbar.ttk.checkbutton -side left
  pack configure .tpmain.objbar.ttk.radiobutton -side left
  pack configure .tpmain.objbar.ttk.sizegrip -side left
  pack configure .tpmain.objbar.ttk.labelframe -side left
  pack configure .tpmain.objbar.ttk.progress -side left
  pack configure .tpmain.objbar.ttk.panedwin_h -side left
  pack configure .tpmain.objbar.ttk.panedwin_v -side left
  #pack configure .tpmain.objbar.ttk.toolbar -side left

  # pack master .tpmain
  pack configure .tpmain.menubar \
    -expand 1 \
    -fill both
  pack configure .tpmain.cmdbar \
    -expand 1 \
    -fill both
  pack configure .tpmain.sep1 -side top -fill x
  pack configure .tpmain.objbar -anchor w
  pack configure .tpmain.sep2 -side top -fill x
  pack configure .tpmain.label32 \
    -expand 1 \
    -fill both
  pack configure .tpmain.pathbar \
    -expand 1 \
    -fill both

EndSrc.tpmain
}

proc DestroyWindow.tpmain {} {
     catch {destroy .tpmain}
     update
}

proc StartupSrc.tpmain {args} {
TP_InitGlobals
}

proc EndSrc.tpmain {} {
TP_Startup
}

proc ShowWindow.tpbuild {} {
# CLONEPATH = .tpbuild
# Cloned Sun Mar 07 11:55:43 EST 2021

set wname .tpbuild
if {[winfo exists $wname]} { return {} } 

toplevel .tpbuild -background {#eff0f1} -highlightbackground {#eff0f1} -highlightcolor {#31363b}

wm iconphoto .tpbuild tplogo16

bindtags .tpbuild {.tpbuild Toplevel all}
wm title .tpbuild {TKproE build program}
wm aspect .tpbuild 
wm focusmodel .tpbuild passive
wm grid .tpbuild 
wm geometry .tpbuild 657x400+100+50
wm iconmask .tpbuild 
wm iconposition .tpbuild 
wm maxsize .tpbuild 3825 1050
wm minsize .tpbuild 657 400
wm overrideredirect .tpbuild 0
wm positionfrom .tpbuild user
wm resizable .tpbuild 1 1
wm sizefrom .tpbuild 
wm state .tpbuild normal
wm transient .tpbuild 
wm protocol .tpbuild WM_DELETE_WINDOW DestroyWindow.tpbuild


frame .tpbuild.tpbuildtype -relief {ridge} -background {#eff0f1} -height {30} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -width {30}

bindtags .tpbuild.tpbuildtype {.tpbuild .tpbuild.tpbuildtype Frame all}

radiobutton .tpbuild.tpbuildtype.radiobutton0 -activebackground {#eff0f1} -activeforeground {#31363b} -background {#eff0f1} -borderwidth {0} -command {TPForBuildInt "pkg"} -compound {left} -font {Helvetica 10} -foreground {black} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -image {unchecked} -indicatoron {0} -relief {raised} -selectcolor {#eff0f1} -selectimage {checked} -text {Build freeWrap package} -value {buildPKG} -variable {TPbuild(buildType)}

bindtags .tpbuild.tpbuildtype.radiobutton0 {.tpbuild .tpbuild.tpbuildtype.radiobutton0 Radiobutton all}
pack .tpbuild.tpbuildtype.radiobutton0 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 8 -pady 0 -side left


radiobutton .tpbuild.tpbuildtype.radiobutton2 -activebackground {#eff0f1} -activeforeground {#31363b} -background {#eff0f1} -borderwidth {0} -command {TPForBuildInt "exe"} -compound {left} -font {Helvetica 10} -foreground {black} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -image {unchecked} -indicatoron {0} -padx {4} -relief {raised} -selectcolor {#eff0f1} -selectimage {checked} -text {Build executable program} -value {buildEXE} -variable {TPbuild(buildType)}

bindtags .tpbuild.tpbuildtype.radiobutton2 {.tpbuild .tpbuild.tpbuildtype.radiobutton2 Radiobutton all}
pack .tpbuild.tpbuildtype.radiobutton2 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left
#LISSI
radiobutton .tpbuild.tpbuildtype.radiobutton3 -activebackground {#eff0f1} -activeforeground {#31363b} -background {#eff0f1} -borderwidth {0} -command {TPForBuildExt} -compound {left} -font {Helvetica 10} -foreground {black} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -image {unchecked} -indicatoron {0} -padx {4} -relief {raised} -selectcolor {#eff0f1} -selectimage {checked} -text {Build executable program for external project} -value {buildEXT} -variable {TPbuild(buildType)}
bindtags .tpbuild.tpbuildtype.radiobutton3 {.tpbuild .tpbuild.tpbuildtype.radiobutton3 Radiobutton all}
pack .tpbuild.tpbuildtype.radiobutton3 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

pack .tpbuild.tpbuildtype -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
#pack .tpbuild.tpbuildtype.radiobutton2 .tpbuild.tpbuildtype.radiobutton0 -in .tpbuild.tpbuildtype


frame .tpbuild.frame0 -relief {ridge} -background {#eff0f1} -height {30} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -width {30}

bindtags .tpbuild.frame0 {.tpbuild .tpbuild.frame0 Frame all}

button .tpbuild.frame0.button4 -activebackground #eff0f1 -activeforeground #31363b -background #eff0f1 -font {Helvetica 9} -foreground #31363b -highlightbackground #eff0f1 -highlightcolor #31363b -image {tpfolder} -text button4 -command {
set TPtemp [tk_chooseDirectory -initialdir $TPbuild(IncludeDir) -parent .tpbuild -title {Select directory tree to include}]
if {$TPtemp ne {}} { 
#LISSI Несколько каталогов
#set TPbuild(IncludeDir) $TPtemp 
append TPbuild(IncludeDir) " $TPtemp"
}
unset TPtemp}

bindtags .tpbuild.frame0.button4 {.tpbuild .tpbuild.frame0.button4 Button all}
pack .tpbuild.frame0.button4 -anchor n -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left


entry .tpbuild.frame0.entry3 -background {white} -foreground {#31363b} -highlightbackground {#fcfcfc} -highlightcolor {#31363b} -selectbackground {#3daee9} -selectforeground {#eff0f1} -textvariable {TPbuild(IncludeDir)}

bindtags .tpbuild.frame0.entry3 {.tpbuild .tpbuild.frame0.entry3 Entry all}
pack .tpbuild.frame0.entry3 -anchor n -expand 1 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left


frame .tpbuild.frame0.frame6 -relief {raised} -background {#eff0f1} -height {30} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -width {30}

bindtags .tpbuild.frame0.frame6 {.tpbuild .tpbuild.frame0.frame6 Frame all}

label .tpbuild.frame0.frame6.label2 -activebackground {#eff0f1} -activeforeground {#31363b} -anchor {w} -background {#eff0f1} -borderwidth {0} -font {Helvetica 10 bold} -foreground {black} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -padx {4} -relief {raised} -text {Include files in this directory:} -width {30}

bindtags .tpbuild.frame0.frame6.label2 {.tpbuild .tpbuild.frame0.frame6.label2 Label all}
pack .tpbuild.frame0.frame6.label2 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top

pack .tpbuild.frame0.frame6 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left
pack .tpbuild.frame0.frame6.label2 -in .tpbuild.frame0.frame6

pack .tpbuild.frame0 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tpbuild.frame0.frame6 .tpbuild.frame0.entry3 .tpbuild.frame0.button4 -in .tpbuild.frame0


frame .tpbuild.frame1 -relief {ridge} -background {#eff0f1} -height {30} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -width {30}

bindtags .tpbuild.frame1 {.tpbuild .tpbuild.frame1 Frame all}
#LISSI for external progect
button .tpbuild.frame1.button4 -activebackground {#eff0f1} -activeforeground {#31363b} -background {#eff0f1} -command {set TPtemp [tk_getOpenFile -initialfile $TPbuild(EXTfile) -filetypes {{{TCL source code files} .tcl} {{All files} .*}} -multiple 0 -parent .tpbuild -title {Select external project main file}]
if {$TPtemp ne {}} { set TPbuild(EXTfile) $TPtemp }
unset TPtemp} -font {Helvetica 9} -foreground {#31363b} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -image {tpfolder} -text {button4}
bindtags .tpbuild.frame1.button4 {.tpbuild .tpbuild.frame1.button4 Button all}
#pack .tpbuild.frame1.button4 -anchor e -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side right

entry .tpbuild.frame1.entry3 -background {white} -disabledbackground {white} -foreground {#31363b} -highlightbackground {#fcfcfc} -highlightcolor {#31363b} -readonlybackground {white} -selectbackground {#3daee9} -selectforeground {#eff0f1} -state {normal} -textvariable {TPbuild(MainSrc)}

bindtags .tpbuild.frame1.entry3 {.tpbuild .tpbuild.frame1.entry3 Entry all}
pack .tpbuild.frame1.entry3 -anchor n -expand 1 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left


frame .tpbuild.frame1.frame6 -relief {raised} -background {#eff0f1} -height {30} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -width {30}

bindtags .tpbuild.frame1.frame6 {.tpbuild .tpbuild.frame1.frame6 Frame all}

label .tpbuild.frame1.frame6.label2 -activebackground {#eff0f1} -activeforeground {#31363b} -anchor {w} -background {#eff0f1} -borderwidth {0} -font {Helvetica 10 bold} -foreground {black} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -padx {4} -relief {raised} -text {Main application source code file:} -width {30}

bindtags .tpbuild.frame1.frame6.label2 {.tpbuild .tpbuild.frame1.frame6.label2 Label all}
pack .tpbuild.frame1.frame6.label2 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top

frame .tpbuild.frame1.frame1 -borderwidth 0 -background {#eff0f1} -height {10} -width {22}

pack .tpbuild.frame1.frame6 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left
pack .tpbuild.frame1.frame6.label2 -in .tpbuild.frame1.frame6
pack .tpbuild.frame1.frame1 -fill none -expand 0 -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

.tpbuild.frame1.entry3 configure -state {disabled}
pack .tpbuild.frame1 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tpbuild.frame1.frame6 .tpbuild.frame1.entry3 .tpbuild.frame1.frame1 -in .tpbuild.frame1

frame .tpbuild.frame14 -borderwidth {2} -background {#eff0f1} -height {30} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -width {30}

bindtags .tpbuild.frame14 {.tpbuild .tpbuild.frame14 Frame all}

button .tpbuild.frame14.button20 -activebackground {#eff0f1} -activeforeground {#31363b} -background {#eff0f1} -command {TP_buildResetOpt} -font {Helvetica 12 bold} -foreground {black} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -text {Reset} -width {6}

bindtags .tpbuild.frame14.button20 {.tpbuild .tpbuild.frame14.button20 Button all}
pack .tpbuild.frame14.button20 -anchor w -expand 1 -fill none -ipadx 0 -ipady 0 -padx 5 -pady 0 -side left

button .tpbuild.frame14.button0 -activebackground {#eff0f1} -activeforeground {#31363b} -background {#eff0f1} -command {DestroyWindow.tpbuild} -font {Helvetica 12 bold} -foreground {black} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -text {Done} -width {6}

bindtags .tpbuild.frame14.button0 {.tpbuild .tpbuild.frame14.button0 Button all}
pack .tpbuild.frame14.button0 -anchor center -expand 1 -fill none -ipadx 0 -ipady 0 -padx 5 -pady 0 -side left

button .tpbuild.frame14.button15 -activebackground {#eff0f1} -activeforeground {#31363b} -background {#eff0f1} -command {set TPbuild(result) {}
set TPtemp [TP_buildExec]
if {$TPtemp eq {}} {
    set TPbuild(result) Success
   } { set TPbuild(result) $TPtemp}
unset TPtemp
after 4000 {set TPbuild(result) {}}} -font {Helvetica 12 bold} -foreground {black} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -text {Build} -width {6}

bindtags .tpbuild.frame14.button15 {.tpbuild .tpbuild.frame14.button15 Button all}
pack .tpbuild.frame14.button15 -anchor e -expand 1 -fill none -ipadx 0 -ipady 0 -padx 5 -pady 0 -side left

pack .tpbuild.frame14 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side bottom
pack .tpbuild.frame14.button15 .tpbuild.frame14.button0 .tpbuild.frame14.button20 -in .tpbuild.frame14

label .tpbuild.result -font {Helvetica 10} -background {#eff0f1} -foreground blue -borderwidth 0 -pady 6 -textvariable TPbuild(result)

pack .tpbuild.result -side bottom -fill x

frame .tpbuild.frame2 -relief {ridge} -background {#eff0f1} -height {30} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -width {30}

bindtags .tpbuild.frame2 {.tpbuild .tpbuild.frame2 Frame all}

button .tpbuild.frame2.button4 -activebackground {#eff0f1} -activeforeground {#31363b} -background {#eff0f1} -command {set TPtemp [tk_chooseDirectory -initialdir $TPbuild(destDir) -parent .tpbuild -title {Select directory to store output files}]
if {$TPtemp ne {}} { set TPbuild(destDir) $TPtemp }
unset TPtemp} -font {Helvetica 9} -foreground {#31363b} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -image {tpfolder} -text {button4}

bindtags .tpbuild.frame2.button4 {.tpbuild .tpbuild.frame2.button4 Button all}
pack .tpbuild.frame2.button4 -anchor n -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left


entry .tpbuild.frame2.entry3 -background {white} -foreground {#31363b} -highlightbackground {#fcfcfc} -highlightcolor {#31363b} -selectbackground {#3daee9} -selectforeground {#eff0f1} -textvariable {TPbuild(destDir)}

bindtags .tpbuild.frame2.entry3 {.tpbuild .tpbuild.frame2.entry3 Entry all}
pack .tpbuild.frame2.entry3 -anchor n -expand 1 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

frame .tpbuild.frameapp -background {#eff0f1} -borderwidth 0
label .tpbuild.frameapp.label1 -anchor {w} -font {Helvertica 10 bold} -padx {4} -text {Application name:} -width {30} -borderwidth {0}
pack .tpbuild.frameapp.label1 -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left
entry .tpbuild.frameapp.entry1 -background {white} -font {Helvetica 10} -foreground {black} -highlightbackground {#fcfcfc} -highlightcolor {#31363b} -selectbackground {#3daee9} -selectforeground {#eff0f1} -textvariable {TPbuild(appName)}
pack .tpbuild.frameapp.entry1 -expand 1 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left
frame .tpbuild.frameapp.frame1 -borderwidth 0 -background {#eff0f1} -height {10} -width {22}
pack .tpbuild.frameapp.frame1 -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left
pack .tpbuild.frameapp -side top -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top

frame .tpbuild.frame2.frame6 -relief {raised} -background {#eff0f1} -height {30} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -width {30}

bindtags .tpbuild.frame2.frame6 {.tpbuild .tpbuild.frame2.frame6 Frame all}

label .tpbuild.frame2.frame6.label2 -activebackground {#eff0f1} -activeforeground {#31363b} -anchor {w} -background {#eff0f1} -borderwidth {0} -font {Helvetica 10 bold} -foreground {black} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -padx {4} -relief {raised} -text {Place output in this directory:} -width {30}

bindtags .tpbuild.frame2.frame6.label2 {.tpbuild .tpbuild.frame2.frame6.label2 Label all}
pack .tpbuild.frame2.frame6.label2 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top

pack .tpbuild.frame2.frame6 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left
pack .tpbuild.frame2.frame6.label2 -in .tpbuild.frame2.frame6

pack .tpbuild.frame2 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tpbuild.frame2.frame6 .tpbuild.frame2.entry3 .tpbuild.frame2.button4 -in .tpbuild.frame2


frame .tpbuild.frame3 -relief {ridge} -background {#eff0f1} -height {30} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -width {30}

bindtags .tpbuild.frame3 {.tpbuild .tpbuild.frame3 Frame all}

#LISSI включение файлов из разных каталогов
#button .tpbuild.frame3.button4 -activebackground {#eff0f1} -activeforeground {#31363b} -background {#eff0f1} -command {set TPbuild(IncludeFiles) [tk_getOpenFile -multiple 1 -parent .tpbuild -title {Select files to include}]} -font {Helvetica 9} -foreground {#31363b} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -image {tpfolder} -text {button4}
button .tpbuild.frame3.button4 -activebackground {#eff0f1} -activeforeground {#31363b} -background {#eff0f1} -command {append TPbuild(IncludeFiles) " [tk_getOpenFile -multiple 1 -parent .tpbuild -title {Select files to include}]"} -font {Helvetica 9} -foreground {#31363b} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -image {tpfolder} -text {button4}

bindtags .tpbuild.frame3.button4 {.tpbuild .tpbuild.frame3.button4 Button all}
pack .tpbuild.frame3.button4 -anchor n -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left


entry .tpbuild.frame3.entry3 -background {white} -font {Helvetica 10} -foreground {black} -highlightbackground {#fcfcfc} -highlightcolor {#31363b} -selectbackground {#3daee9} -selectforeground {#eff0f1} -textvariable {TPbuild(IncludeFiles)}

bindtags .tpbuild.frame3.entry3 {.tpbuild .tpbuild.frame3.entry3 Entry all}
pack .tpbuild.frame3.entry3 -anchor n -expand 1 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left


frame .tpbuild.frame3.frame6 -relief {raised} -background {#eff0f1} -height {30} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -width {30}

bindtags .tpbuild.frame3.frame6 {.tpbuild .tpbuild.frame3.frame6 Frame all}

label .tpbuild.frame3.frame6.label2 -activebackground {#eff0f1} -activeforeground {#31363b} -anchor {w} -background {#eff0f1} -borderwidth {0} -font {Helvetica 10 bold} -foreground {black} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -padx {4} -relief {raised} -text {Include these files:} -width {30}

bindtags .tpbuild.frame3.frame6.label2 {.tpbuild .tpbuild.frame3.frame6.label2 Label all}
pack .tpbuild.frame3.frame6.label2 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top

pack .tpbuild.frame3.frame6 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left
pack .tpbuild.frame3.frame6.label2 -in .tpbuild.frame3.frame6

pack .tpbuild.frame3 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tpbuild.frame3.frame6 .tpbuild.frame3.entry3 .tpbuild.frame3.button4 -in .tpbuild.frame3


frame .tpbuild.frame4 -relief {ridge} -background {#eff0f1} -height {30} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -width {30}

bindtags .tpbuild.frame4 {.tpbuild .tpbuild.frame4 Frame all}

button .tpbuild.frame4.button4 -activebackground {#eff0f1} -activeforeground {#31363b} -background {#eff0f1} -command {set TPtemp [tk_getOpenFile -initialfile $TPbuild(ICOfile) -multiple 0 -parent .tpbuild -title {Select ICO file containing your application icons}]
if {$TPtemp ne {}} { set TPbuild(ICOfile) $TPtemp }
unset TPtemp} -font {Helvetica 9} -foreground {#31363b} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -image {tpfolder} -text {button4}

bindtags .tpbuild.frame4.button4 {.tpbuild .tpbuild.frame4.button4 Button all}
pack .tpbuild.frame4.button4 -anchor n -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left


entry .tpbuild.frame4.entry3 -background {white} -foreground {#31363b} -highlightbackground {#fcfcfc} -highlightcolor {#31363b} -selectbackground {#3daee9} -selectforeground {#eff0f1} -textvariable {TPbuild(ICOfile)}

bindtags .tpbuild.frame4.entry3 {.tpbuild .tpbuild.frame4.entry3 Entry all}
pack .tpbuild.frame4.entry3 -anchor n -expand 1 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

frame .tpbuild.frame4.frame6 -relief {raised} -background {#eff0f1} -height {30} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -width {30}

bindtags .tpbuild.frame4.frame6 {.tpbuild .tpbuild.frame4.frame6 Frame all}

label .tpbuild.frame4.frame6.label2 -activebackground {#eff0f1} -activeforeground {#31363b} -anchor {w} -background {#eff0f1} -borderwidth {0} -font {Helvetica 10 bold} -foreground {black} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -padx {4} -relief {raised} -text {ICO file (Windows only):} -width {30}

bindtags .tpbuild.frame4.frame6.label2 {.tpbuild .tpbuild.frame4.frame6.label2 Label all}
pack .tpbuild.frame4.frame6.label2 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top

pack .tpbuild.frame4.frame6 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left
pack .tpbuild.frame4.frame6.label2 -in .tpbuild.frame4.frame6

pack .tpbuild.frame4 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tpbuild.frame4.frame6 .tpbuild.frame4.entry3 .tpbuild.frame4.button4 -in .tpbuild.frame4


frame .tpbuild.frame5 -relief {ridge} -background {#eff0f1} -height {30} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -width {30}

bindtags .tpbuild.frame5 {.tpbuild .tpbuild.frame5 Frame all}

frame .tpbuild.frame5.frame3 -relief {raised} -background {#eff0f1} -height {30} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -width {30}

bindtags .tpbuild.frame5.frame3 {.tpbuild .tpbuild.frame5.frame3 Frame all}

frame .tpbuild.frame5.frame3.frame0 -relief {raised} -background {#eff0f1} -height {30} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -width {30}

bindtags .tpbuild.frame5.frame3.frame0 {.tpbuild .tpbuild.frame5.frame3.frame0 Frame all}

button .tpbuild.frame5.frame3.frame0.button4 -activebackground {#eff0f1} -activeforeground {#31363b} -background {#eff0f1} -command {set TPtemp [tk_getOpenFile -initialfile $TPbuild(Exec_Win64) -multiple 0 -parent .tpbuild -title {Select 64 bit Windows version of freewrap}]
if {$TPtemp ne {}} { set TPbuild(Exec_Win64) $TPtemp }
unset TPtemp} -font {Helvetica 9} -foreground {#31363b} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -image {tpfolder} -text {button4}

bindtags .tpbuild.frame5.frame3.frame0.button4 {.tpbuild .tpbuild.frame5.frame3.frame0.button4 Button all}
pack .tpbuild.frame5.frame3.frame0.button4 -anchor n -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left


checkbutton .tpbuild.frame5.frame3.frame0.checkbutton6 -activebackground {#eff0f1} -activeforeground {#31363b} -anchor {w} -background {#eff0f1} -borderwidth {0} -font {Helvetica 10 bold} -foreground {black} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -relief {raised} -text {Win-64bit} -variable {TPbuild(Win64)} -width {10}

bindtags .tpbuild.frame5.frame3.frame0.checkbutton6 {.tpbuild .tpbuild.frame5.frame3.frame0.checkbutton6 Checkbutton all}
pack .tpbuild.frame5.frame3.frame0.checkbutton6 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left


entry .tpbuild.frame5.frame3.frame0.entry3 -background {white} -foreground {#31363b} -highlightbackground {#fcfcfc} -highlightcolor {#31363b} -selectbackground {#3daee9} -selectforeground {#eff0f1} -textvariable {TPbuild(Exec_Win64)}

bindtags .tpbuild.frame5.frame3.frame0.entry3 {.tpbuild .tpbuild.frame5.frame3.frame0.entry3 Entry all}
pack .tpbuild.frame5.frame3.frame0.entry3 -anchor n -expand 1 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

pack .tpbuild.frame5.frame3.frame0 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tpbuild.frame5.frame3.frame0.checkbutton6 .tpbuild.frame5.frame3.frame0.entry3 .tpbuild.frame5.frame3.frame0.button4 -in .tpbuild.frame5.frame3.frame0


frame .tpbuild.frame5.frame3.frame1 -relief {raised} -background {#eff0f1} -height {30} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -width {30}

bindtags .tpbuild.frame5.frame3.frame1 {.tpbuild .tpbuild.frame5.frame3.frame1 Frame all}

button .tpbuild.frame5.frame3.frame1.button4 -activebackground {#eff0f1} -activeforeground {#31363b} -background {#eff0f1} -command {set TPtemp [tk_getOpenFile -initialfile $TPbuild(Exec_Linux32) -multiple 0 -parent .tpbuild -title {Select 32 bit linux version of freewrap}]
if {$TPtemp ne {}} { set TPbuild(Exec_Linux32) $TPtemp }
unset TPtemp} -font {Helvetica 9} -foreground {#31363b} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -image {tpfolder} -text {button4}

bindtags .tpbuild.frame5.frame3.frame1.button4 {.tpbuild .tpbuild.frame5.frame3.frame1.button4 Button all}
pack .tpbuild.frame5.frame3.frame1.button4 -anchor n -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left


checkbutton .tpbuild.frame5.frame3.frame1.checkbutton6 -activebackground {#eff0f1} -activeforeground {#31363b} -anchor {w} -background {#eff0f1} -borderwidth {0} -font {Helvetica 10 bold} -foreground {black} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -relief {raised} -text {Linux-32bit} -variable {TPbuild(Linux32)} -width {10}

bindtags .tpbuild.frame5.frame3.frame1.checkbutton6 {.tpbuild .tpbuild.frame5.frame3.frame1.checkbutton6 Checkbutton all}
pack .tpbuild.frame5.frame3.frame1.checkbutton6 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left


entry .tpbuild.frame5.frame3.frame1.entry3 -background {white} -foreground {#31363b} -highlightbackground {#fcfcfc} -highlightcolor {#31363b} -selectbackground {#3daee9} -selectforeground {#eff0f1} -textvariable {TPbuild(Exec_Linux32)}

bindtags .tpbuild.frame5.frame3.frame1.entry3 {.tpbuild .tpbuild.frame5.frame3.frame1.entry3 Entry all}
pack .tpbuild.frame5.frame3.frame1.entry3 -anchor n -expand 1 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

pack .tpbuild.frame5.frame3.frame1 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tpbuild.frame5.frame3.frame1.checkbutton6 .tpbuild.frame5.frame3.frame1.entry3 .tpbuild.frame5.frame3.frame1.button4 -in .tpbuild.frame5.frame3.frame1


frame .tpbuild.frame5.frame3.frame2 -relief {raised} -background {#eff0f1} -height {30} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -width {30}

bindtags .tpbuild.frame5.frame3.frame2 {.tpbuild .tpbuild.frame5.frame3.frame2 Frame all}

button .tpbuild.frame5.frame3.frame2.button4 -activebackground {#eff0f1} -activeforeground {#31363b} -background {#eff0f1} -command {set TPtemp [tk_getOpenFile -initialfile $TPbuild(Exec_Linux64) -multiple 0 -parent .tpbuild -title {Select 64 bit linux version of freewrap}]
if {$TPtemp ne {}} { set TPbuild(Exec_Linux64) $TPtemp }
unset TPtemp} -font {Helvetica 9} -foreground {#31363b} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -image {tpfolder} -text {button4}

bindtags .tpbuild.frame5.frame3.frame2.button4 {.tpbuild .tpbuild.frame5.frame3.frame2.button4 Button all}
pack .tpbuild.frame5.frame3.frame2.button4 -anchor n -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left


checkbutton .tpbuild.frame5.frame3.frame2.checkbutton6 -activebackground {#eff0f1} -activeforeground {#31363b} -anchor {w} -background {#eff0f1} -borderwidth {0} -font {Helvetica 10 bold} -foreground {black} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -relief {raised} -text {Linux-64bit} -variable {TPbuild(Linux64)} -width {10}

bindtags .tpbuild.frame5.frame3.frame2.checkbutton6 {.tpbuild .tpbuild.frame5.frame3.frame2.checkbutton6 Checkbutton all}
pack .tpbuild.frame5.frame3.frame2.checkbutton6 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left


entry .tpbuild.frame5.frame3.frame2.entry3 -background {white} -foreground {#31363b} -highlightbackground {#fcfcfc} -highlightcolor {#31363b} -selectbackground {#3daee9} -selectforeground {#eff0f1} -textvariable {TPbuild(Exec_Linux64)}

bindtags .tpbuild.frame5.frame3.frame2.entry3 {.tpbuild .tpbuild.frame5.frame3.frame2.entry3 Entry all}
pack .tpbuild.frame5.frame3.frame2.entry3 -anchor n -expand 1 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

pack .tpbuild.frame5.frame3.frame2 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tpbuild.frame5.frame3.frame2.checkbutton6 .tpbuild.frame5.frame3.frame2.entry3 .tpbuild.frame5.frame3.frame2.button4 -in .tpbuild.frame5.frame3.frame2
#LISSI for MACOS
frame .tpbuild.frame5.frame3.frameMAC -relief {raised} -background {#eff0f1} -height {30} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -width {30}
bindtags .tpbuild.frame5.frame3.frameMAC {.tpbuild .tpbuild.frame5.frame3.frameMAC Frame all}
button .tpbuild.frame5.frame3.frameMAC.button4 -activebackground {#eff0f1} -activeforeground {#31363b} -background {#eff0f1} -command {set TPtemp [tk_getOpenFile -initialfile $TPbuild(Exec_MacOS) -multiple 0 -parent .tpbuild -title {Select 64 bit linux version of freewrap}]
if {$TPtemp ne {}} { set TPbuild(Exec_MacOS) $TPtemp }
unset TPtemp} -font {Helvetica 9} -foreground {#31363b} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -image {tpfolder} -text {button4}
bindtags .tpbuild.frame5.frame3.frameMAC.button4 {.tpbuild .tpbuild.frame5.frame3.frameMAC.button4 Button all}
pack .tpbuild.frame5.frame3.frameMAC.button4 -anchor n -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left
checkbutton .tpbuild.frame5.frame3.frameMAC.checkbutton6 -activebackground {#eff0f1} -activeforeground {#31363b} -anchor {w} -background {#eff0f1} -borderwidth {0} -font {Helvetica 10 bold} -foreground {black} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -relief {raised} -text {MacOS} -variable {TPbuild(MacOS)} -width {10}
bindtags .tpbuild.frame5.frame3.frameMAC.checkbutton6 {.tpbuild .tpbuild.frame5.frame3.frameMAC.checkbutton6 Checkbutton all}
pack .tpbuild.frame5.frame3.frameMAC.checkbutton6 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left
entry .tpbuild.frame5.frame3.frameMAC.entry3 -background {white} -foreground {#31363b} -highlightbackground {#fcfcfc} -highlightcolor {#31363b} -selectbackground {#3daee9} -selectforeground {#eff0f1} -textvariable {TPbuild(Exec_MacOS)}
bindtags .tpbuild.frame5.frame3.frameMAC.entry3 {.tpbuild .tpbuild.frame5.frame3.frameMAC.entry3 Entry all}
pack .tpbuild.frame5.frame3.frameMAC.entry3 -anchor n -expand 1 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left
pack .tpbuild.frame5.frame3.frameMAC.checkbutton6 .tpbuild.frame5.frame3.frameMAC.entry3 .tpbuild.frame5.frame3.frameMAC.button4 -in .tpbuild.frame5.frame3.frameMAC
###############

frame .tpbuild.frame5.frame3.frame3 -relief {raised} -background {#eff0f1} -height {30} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -width {30}

bindtags .tpbuild.frame5.frame3.frame3 {.tpbuild .tpbuild.frame5.frame3.frame3 Frame all}

label .tpbuild.frame5.frame3.frame3.label7 -activebackground {#eff0f1} -activeforeground {#31363b} -background {#eff0f1} -borderwidth {0} -font {Helvetica 10 bold} -foreground {#31363b} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -relief {raised} -width {13}

bindtags .tpbuild.frame5.frame3.frame3.label7 {.tpbuild .tpbuild.frame5.frame3.frame3.label7 Label all}
pack .tpbuild.frame5.frame3.frame3.label7 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left
#LISSI
labelframe .tpbuild.frame5.frame3.frame3.labelwrap -text {Used wrapper} -labelanchor n -background {#eff0f1} -borderwidth {2} -font {Helvetica 10 bold} -foreground {#31363b}  -relief {groove}
pack .tpbuild.frame5.frame3.frame3.labelwrap -anchor center -expand 1 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
#radiobutton .tpbuild.frame5.frame3.frame3.labelwrap.radiobtn0 -command {TPwinbuild} -background {#eff0f1} -borderwidth {0} -foreground {#31363b} -relief {raised} -font {Helvetica 10 bold} -text {freeWrap} -value {0} -variable {TPbuild(wrapper)}
radiobutton .tpbuild.frame5.frame3.frame3.labelwrap.radiobtn0 -activebackground {#eff0f1} -activeforeground {#31363b} -background {#eff0f1} -borderwidth {0} -command {TPwinbuild} -compound {left} -font {Helvetica 10} -foreground {black} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -image {unchecked} -indicatoron {0} -padx {4} -relief {raised} -selectcolor {#eff0f1} -selectimage {checked} -text {freeWrap} -value {0} -variable {TPbuild(wrapper)}
#radiobutton .tpbuild.frame5.frame3.frame3.labelwrap.radiobtn1 -command {TPwinbuild} -background {#eff0f1} -borderwidth {0} -foreground {#31363b} -relief {raised} -font {Helvetica 10 bold} -text {tclexecomp} -value {1} -variable {TPbuild(wrapper)}
radiobutton .tpbuild.frame5.frame3.frame3.labelwrap.radiobtn1 -activebackground {#eff0f1} -activeforeground {#31363b} -background {#eff0f1} -borderwidth {0} -command {TPwinbuild} -compound {left} -font {Helvetica 10} -foreground {black} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -image {unchecked} -indicatoron {0} -padx {4} -relief {raised} -selectcolor {#eff0f1} -selectimage {checked} -text {tclexecomp} -value {1} -variable {TPbuild(wrapper)}
#radiobutton .tpbuild.frame5.frame3.frame3.labelwrap.radiobtn2 -command {TPwinbuild} -background {#eff0f1} -borderwidth {0} -foreground {#31363b} -relief {raised} -font {Helvetica 10 bold} -text {unknown} -value {-1} -variable {TPbuild(wrapper)}
radiobutton .tpbuild.frame5.frame3.frame3.labelwrap.radiobtn2 -activebackground {#eff0f1} -activeforeground {#31363b} -background {#eff0f1} -borderwidth {0} -command {TPwinbuild} -compound {left} -font {Helvetica 10} -foreground {black} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -image {unchecked} -indicatoron {0} -padx {4} -relief {raised} -selectcolor {#eff0f1} -selectimage {checked} -text {unknown} -value {-1} -variable {TPbuild(wrapper)}
#bindtags .tpbuild.frame5.frame3.frame3.labelwrap.radiobtn0 {.build .tpbuild.frame5.frame3.frame3.labelwrap.radiobtn0 Radiobutton all}
pack .tpbuild.frame5.frame3.frame3.labelwrap.radiobtn0 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 10m -pady {0 3} -side left
pack .tpbuild.frame5.frame3.frame3.labelwrap.radiobtn1 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0m -pady {0 3} -side left
pack .tpbuild.frame5.frame3.frame3.labelwrap.radiobtn2 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 10m -pady {0 3} -side right

label .tpbuild.frame5.frame3.frame3.label8 -activebackground {#eff0f1} -activeforeground {#31363b} -background {#eff0f1} -borderwidth {0} -font {Helvetica 10 bold} -foreground {#31363b} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -relief {raised} -text {Associated freeWrap Program}

bindtags .tpbuild.frame5.frame3.frame3.label8 {.tpbuild .tpbuild.frame5.frame3.frame3.label8 Label all}
#LISSI
#pack .tpbuild.frame5.frame3.frame3.label8 -anchor center -expand 1 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left
pack .tpbuild.frame5.frame3.frame3.label8 -anchor center -expand 1 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top

pack .tpbuild.frame5.frame3.frame3 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tpbuild.frame5.frame3.frame3.label7 .tpbuild.frame5.frame3.frame3.label8 -in .tpbuild.frame5.frame3.frame3

frame .tpbuild.frame5.frame3.frame4 -relief {raised} -background {#eff0f1} -height {30} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -width {30}

bindtags .tpbuild.frame5.frame3.frame4 {.tpbuild .tpbuild.frame5.frame3.frame4 Frame all}

button .tpbuild.frame5.frame3.frame4.button4 -activebackground {#eff0f1} -activeforeground {#31363b} -background {#eff0f1} -command {set TPtemp [tk_getOpenFile -initialfile $TPbuild(Exec_Win32) -multiple 0 -parent .tpbuild -title {Select 32 bit Windows version of freewrap}]
if {$TPtemp ne {}} { set TPbuild(Exec_Win32) $TPtemp }
unset TPtemp} -font {Helvetica 9} -foreground {#31363b} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -image {tpfolder} -text {button4}

bindtags .tpbuild.frame5.frame3.frame4.button4 {.tpbuild .tpbuild.frame5.frame3.frame4.button4 Button all}
pack .tpbuild.frame5.frame3.frame4.button4 -anchor n -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left


checkbutton .tpbuild.frame5.frame3.frame4.checkbutton6 -activebackground {#eff0f1} -activeforeground {#31363b} -anchor {w} -background {#eff0f1} -borderwidth {0} -font {Helvetica 10 bold} -foreground {black} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -relief {raised} -text {Win-32bit} -variable {TPbuild(Win32)} -width {10}

bindtags .tpbuild.frame5.frame3.frame4.checkbutton6 {.tpbuild .tpbuild.frame5.frame3.frame4.checkbutton6 Checkbutton all}
pack .tpbuild.frame5.frame3.frame4.checkbutton6 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left


entry .tpbuild.frame5.frame3.frame4.entry3 -background {white} -foreground {#31363b} -highlightbackground {#fcfcfc} -highlightcolor {#31363b} -selectbackground {#3daee9} -selectforeground {#eff0f1} -textvariable {TPbuild(Exec_Win32)}

bindtags .tpbuild.frame5.frame3.frame4.entry3 {.tpbuild .tpbuild.frame5.frame3.frame4.entry3 Entry all}
pack .tpbuild.frame5.frame3.frame4.entry3 -anchor n -expand 1 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

pack .tpbuild.frame5.frame3.frame4 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tpbuild.frame5.frame3.frame4.checkbutton6 .tpbuild.frame5.frame3.frame4.entry3 .tpbuild.frame5.frame3.frame4.button4 -in .tpbuild.frame5.frame3.frame4

pack .tpbuild.frame5.frame3 -anchor center -expand 1 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left
pack .tpbuild.frame5.frame3.frame3 .tpbuild.frame5.frame3.frame4 .tpbuild.frame5.frame3.frame0 .tpbuild.frame5.frame3.frame1 .tpbuild.frame5.frame3.frame2 -in .tpbuild.frame5.frame3


frame .tpbuild.frame5.frame6 -relief {ridge} -background {#eff0f1} -height {30} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -width {30}

bindtags .tpbuild.frame5.frame6 {.tpbuild .tpbuild.frame5.frame6 Frame all}

label .tpbuild.frame5.frame6.label2 -activebackground {#eff0f1} -activeforeground {#31363b} -anchor {w} -background {#eff0f1} -borderwidth {0} -font {Helvetica 10 bold} -foreground {black} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -padx {4} -relief {raised} -text {Target Operating Systems:} -width {30}

bindtags .tpbuild.frame5.frame6.label2 {.tpbuild .tpbuild.frame5.frame6.label2 Label all}
pack .tpbuild.frame5.frame6.label2 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top

pack .tpbuild.frame5.frame6 -anchor center -expand 0 -fill y -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left
pack .tpbuild.frame5.frame6.label2 -in .tpbuild.frame5.frame6


ttk::separator .tpbuild.frame5.vseparator9 -orient {vertical}
.tpbuild.frame5.vseparator9 state {}
bindtags .tpbuild.frame5.vseparator9 {.tpbuild .tpbuild.frame5.vseparator9 TSeparator all}
pack .tpbuild.frame5.vseparator9 -anchor center -expand 0 -fill y -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

pack .tpbuild.frame5 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tpbuild.frame5.frame6 .tpbuild.frame5.vseparator9 .tpbuild.frame5.frame3 -in .tpbuild.frame5


frame .tpbuild.frame6 -relief {ridge} -background {#eff0f1} -height {30} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -width {30}

bindtags .tpbuild.frame6 {.build .tpbuild.frame6 Frame all}

frame .tpbuild.frame6.frame6 -relief {raised} -background {#eff0f1} -height {30} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -width {30}

bindtags .tpbuild.frame6.frame6 {.build .tpbuild.frame6.frame6 Frame all}

label .tpbuild.frame6.frame6.label2 -activebackground {#eff0f1} -activeforeground {#31363b} -anchor {w} -background {#eff0f1} -borderwidth {0} -font {Helvetica 10 bold} -foreground {black} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -padx {4} -relief {raised} -text {Compression level:} -width {30}

bindtags .tpbuild.frame6.frame6.label2 {.build .tpbuild.frame6.frame6.label2 Label all}
pack .tpbuild.frame6.frame6.label2 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top

pack .tpbuild.frame6.frame6 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left
pack .tpbuild.frame6.frame6.label2 -in .tpbuild.frame6.frame6


label .tpbuild.frame6.label0 -activebackground {#eff0f1} -activeforeground {#31363b} -background {#eff0f1} -borderwidth {0} -font {Helvetica 10} -foreground {#31363b} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -relief {raised} -text {...More}

bindtags .tpbuild.frame6.label0 {.build .tpbuild.frame6.label0 Label all}
pack .tpbuild.frame6.label0 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left


label .tpbuild.frame6.label1 -activebackground {#eff0f1} -activeforeground {#31363b} -background {#eff0f1} -borderwidth {0} -font {Helvetica 10} -foreground {#31363b} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -padx {0} -relief {raised} -text {None...}

bindtags .tpbuild.frame6.label1 {.build .tpbuild.frame6.label1 Label all}
pack .tpbuild.frame6.label1 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left


radiobutton .tpbuild.frame6.radiobtn0 -activebackground {#eff0f1} -activeforeground {#31363b} -background {#eff0f1} -borderwidth {0} -foreground {#31363b} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -relief {raised} -text {0} -value {0} -variable {TPbuild(compression)}

bindtags .tpbuild.frame6.radiobtn0 {.build .tpbuild.frame6.radiobtn0 Radiobutton all}
pack .tpbuild.frame6.radiobtn0 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left


radiobutton .tpbuild.frame6.radiobtn1 -activebackground {#eff0f1} -activeforeground {#31363b} -background {#eff0f1} -borderwidth {0} -foreground {#31363b} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -relief {raised} -text {1} -value {1} -variable {TPbuild(compression)}

bindtags .tpbuild.frame6.radiobtn1 {.build .tpbuild.frame6.radiobtn1 Radiobutton all}
pack .tpbuild.frame6.radiobtn1 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left


radiobutton .tpbuild.frame6.radiobtn2 -activebackground {#eff0f1} -activeforeground {#31363b} -background {#eff0f1} -borderwidth {0} -foreground {#31363b} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -relief {raised} -text {2} -value {2} -variable {TPbuild(compression)}

bindtags .tpbuild.frame6.radiobtn2 {.build .tpbuild.frame6.radiobtn2 Radiobutton all}
pack .tpbuild.frame6.radiobtn2 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left


radiobutton .tpbuild.frame6.radiobtn3 -activebackground {#eff0f1} -activeforeground {#31363b} -background {#eff0f1} -borderwidth {0} -foreground {#31363b} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -relief {raised} -text {3} -value {3} -variable {TPbuild(compression)}

bindtags .tpbuild.frame6.radiobtn3 {.build .tpbuild.frame6.radiobtn3 Radiobutton all}
pack .tpbuild.frame6.radiobtn3 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left


radiobutton .tpbuild.frame6.radiobtn4 -activebackground {#eff0f1} -activeforeground {#31363b} -background {#eff0f1} -borderwidth {0} -foreground {#31363b} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -relief {raised} -text {4} -value {4} -variable {TPbuild(compression)}

bindtags .tpbuild.frame6.radiobtn4 {.build .tpbuild.frame6.radiobtn4 Radiobutton all}
pack .tpbuild.frame6.radiobtn4 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left


radiobutton .tpbuild.frame6.radiobtn5 -activebackground {#eff0f1} -activeforeground {#31363b} -background {#eff0f1} -borderwidth {0} -foreground {#31363b} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -relief {raised} -text {5} -value {5} -variable {TPbuild(compression)}

bindtags .tpbuild.frame6.radiobtn5 {.build .tpbuild.frame6.radiobtn5 Radiobutton all}
pack .tpbuild.frame6.radiobtn5 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left


radiobutton .tpbuild.frame6.radiobtn6 -activebackground {#eff0f1} -activeforeground {#31363b} -background {#eff0f1} -borderwidth {0} -foreground {#31363b} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -relief {raised} -text {6} -value {6} -variable {TPbuild(compression)}

bindtags .tpbuild.frame6.radiobtn6 {.build .tpbuild.frame6.radiobtn6 Radiobutton all}
pack .tpbuild.frame6.radiobtn6 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left


radiobutton .tpbuild.frame6.radiobtn7 -activebackground {#eff0f1} -activeforeground {#31363b} -background {#eff0f1} -borderwidth {0} -foreground {#31363b} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -relief {raised} -text {7} -value {7} -variable {TPbuild(compression)}

bindtags .tpbuild.frame6.radiobtn7 {.build .tpbuild.frame6.radiobtn7 Radiobutton all}
pack .tpbuild.frame6.radiobtn7 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left


radiobutton .tpbuild.frame6.radiobtn8 -activebackground {#eff0f1} -activeforeground {#31363b} -background {#eff0f1} -borderwidth {0} -foreground {#31363b} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -relief {raised} -text {8} -value {8} -variable {TPbuild(compression)}

bindtags .tpbuild.frame6.radiobtn8 {.build .tpbuild.frame6.radiobtn8 Radiobutton all}
pack .tpbuild.frame6.radiobtn8 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left


radiobutton .tpbuild.frame6.radiobtn9 -activebackground {#eff0f1} -activeforeground {#31363b} -background {#eff0f1} -borderwidth {0} -foreground {#31363b} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -relief {raised} -text {9} -value {9} -variable {TPbuild(compression)}

bindtags .tpbuild.frame6.radiobtn9 {.build .tpbuild.frame6.radiobtn9 Radiobutton all}
pack .tpbuild.frame6.radiobtn9 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

pack .tpbuild.frame6 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tpbuild.frame6.frame6 .tpbuild.frame6.label1 .tpbuild.frame6.radiobtn0 .tpbuild.frame6.radiobtn1 .tpbuild.frame6.radiobtn2 .tpbuild.frame6.radiobtn3 .tpbuild.frame6.radiobtn4 .tpbuild.frame6.radiobtn5 .tpbuild.frame6.radiobtn6 .tpbuild.frame6.radiobtn7 .tpbuild.frame6.radiobtn8 .tpbuild.frame6.radiobtn9 .tpbuild.frame6.label0 -in .tpbuild.frame6

ttk::separator .tpbuild.hseparator0
.tpbuild.hseparator0 state {}
bindtags .tpbuild.hseparator0 {.tpbuild .tpbuild.hseparator0 TSeparator all}
pack .tpbuild.hseparator0 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top


ttk::separator .tpbuild.hseparator1
.tpbuild.hseparator1 state {}
bindtags .tpbuild.hseparator1 {.tpbuild .tpbuild.hseparator1 TSeparator all}
pack .tpbuild.hseparator1 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top


ttk::separator .tpbuild.hseparator13
.tpbuild.hseparator13 state {}
bindtags .tpbuild.hseparator13 {.tpbuild .tpbuild.hseparator13 TSeparator all}
pack .tpbuild.hseparator13 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top


ttk::separator .tpbuild.hseparator2
.tpbuild.hseparator2 state {}
bindtags .tpbuild.hseparator2 {.tpbuild .tpbuild.hseparator2 TSeparator all}
pack .tpbuild.hseparator2 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top


ttk::separator .tpbuild.hseparator3
.tpbuild.hseparator3 state {}
bindtags .tpbuild.hseparator3 {.tpbuild .tpbuild.hseparator3 TSeparator all}
pack .tpbuild.hseparator3 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top


ttk::separator .tpbuild.hseparator4
.tpbuild.hseparator4 state {}
bindtags .tpbuild.hseparator4 {.tpbuild .tpbuild.hseparator4 TSeparator all}
pack .tpbuild.hseparator4 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top


ttk::separator .tpbuild.hseparator5
.tpbuild.hseparator5 state {}
bindtags .tpbuild.hseparator5 {.tpbuild .tpbuild.hseparator5 TSeparator all}
pack .tpbuild.hseparator5 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top


ttk::separator .tpbuild.hseparator6
.tpbuild.hseparator6 state {}
bindtags .tpbuild.hseparator6 {.tpbuild .tpbuild.hseparator6 TSeparator all}
pack .tpbuild.hseparator6 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top

ttk::separator .tpbuild.hseparator7
.tpbuild.hseparator7 state {}
bindtags .tpbuild.hseparator7 {.tpbuild .tpbuild.hseparator7 TSeparator all}
pack .tpbuild.hseparator7 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top

pack .tpbuild.tpbuildtype .tpbuild.hseparator13 .tpbuild.frameapp .tpbuild.hseparator7 .tpbuild.frame2 .tpbuild.hseparator0 .tpbuild.frame1 .tpbuild.hseparator1 .tpbuild.frame3 .tpbuild.hseparator2 .tpbuild.frame0 .tpbuild.hseparator3 .tpbuild.frame4 .tpbuild.hseparator4 .tpbuild.frame6 .tpbuild.hseparator5 .tpbuild.frame5 .tpbuild.frame14 .tpbuild.result .tpbuild.hseparator6 -in .tpbuild
#LISSI
.tpbuild.frame5.frame3.frame3.labelwrap.radiobtn1 invoke

EndSrc.tpbuild
}

proc DestroyWindow.tpbuild {} {
     catch {destroy .tpbuild}
     update
return {}}

proc EndSrc.tpbuild {} {
global TPbuild
global tcl_platform
global TPprogFile

wm iconphoto .tpmain tplogo16
set TPbuild(MainSrc) $TPprogFile
if {[info exists TPbuild(firstTime)]} {
    set firstTime $TPbuild(firstTime)
  } { set firstTime 1 }
if {$firstTime} {
    TP_buildResetOpt
  }
}


proc ShowWindow.tpGetObjName { args} {

  catch {destroy .tpGetObjName}

  toplevel .tpGetObjName   -relief {sunken}  -background {#dcdcdc}  -highlightbackground {#dcdcdc}

  # Window manager configurations
  wm positionfrom .tpGetObjName program
  wm sizefrom .tpGetObjName program
  wm maxsize .tpGetObjName 2560 1024
  wm minsize .tpGetObjName 274 90
  wm protocol .tpGetObjName WM_DELETE_WINDOW {.tpGetObjName.frame4.button6 invoke}
  wm title .tpGetObjName {New widget name?}


  label .tpGetObjName.label2  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {0}  -font {Helvetica 10 bold}  -foreground {red}  -highlightbackground {#dcdcdc}  -text { Enter the new widget name }

  frame .tpGetObjName.frame4  -background {#dcdcdc}  -height {35}  -highlightbackground {#dcdcdc}  -width {126}

  button .tpGetObjName.frame4.button5  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_CreateNewObj
DestroyWindow.tpGetObjName}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {OK}  -width {6}

  button .tpGetObjName.frame4.button6  -activebackground {gray75}  -background {#dcdcdc}  -command {set TPnextObjName {}
if {$::TPnextObj} {incr ::TPnextObj -1}
DestroyWindow.tpGetObjName}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Cancel}  -width {6}

  frame .tpGetObjName.class  -borderwidth {2}  -background {#dcdcdc}  -height {26}  -highlightbackground {#dcdcdc}  -width {229}

  label .tpGetObjName.class.label2  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Class:}  -width {8}

  entry .tpGetObjName.class.entry0  -background {#eeeeee}  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -textvariable {TPpropsAtCreation(class)}

  frame .tpGetObjName.frame5  -borderwidth {2}  -background {#dcdcdc}  -height {26}  -highlightbackground {#dcdcdc}  -width {214}

  label .tpGetObjName.frame5.label2  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Name:}

  entry .tpGetObjName.frame5.entry0  -background {#eeeeee}  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -textvariable {TPnextObjName}  -width {24}

  frame .tpGetObjName.colormap  -borderwidth {2}  -background {#dcdcdc}  -height {26}  -highlightbackground {#dcdcdc}  -width {229}

  label .tpGetObjName.colormap.label2  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Colormap:}  -width {8}

  entry .tpGetObjName.colormap.entry0  -background {#eeeeee}  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -textvariable {TPpropsAtCreation(colormap)}

  frame .tpGetObjName.container  -borderwidth {2}  -background {#dcdcdc}  -height {26}  -highlightbackground {#dcdcdc}  -width {229}

  label .tpGetObjName.container.label2  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Container:}  -width {8}

  entry .tpGetObjName.container.entry0  -background {#eeeeee}  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -textvariable {TPpropsAtCreation(container)}

  frame .tpGetObjName.visual  -borderwidth {2}  -background {#dcdcdc}  -height {26}  -highlightbackground {#dcdcdc}  -width {229}

  label .tpGetObjName.visual.label2  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Visual:}  -width {8}

  entry .tpGetObjName.visual.entry0  -background {#eeeeee}  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -textvariable {TPpropsAtCreation(visual)}

  frame .tpGetObjName.screen  -borderwidth {2}  -background {#dcdcdc}  -height {26}  -highlightbackground {#dcdcdc}  -width {214}

  label .tpGetObjName.screen.label2  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Screen:}  -width {8}

  entry .tpGetObjName.screen.entry0  -background {#eeeeee}  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -textvariable {TPpropsAtCreation(screen)}

  frame .tpGetObjName.use  -borderwidth {2}  -background {#dcdcdc}  -height {26}  -highlightbackground {#dcdcdc}  -width {214}

  label .tpGetObjName.use.label2  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Use:}  -width {8}

  entry .tpGetObjName.use.entry0  -background {#eeeeee}  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -textvariable {TPpropsAtCreation(use)}

  # pack master .tpGetObjName.frame4
  pack configure .tpGetObjName.frame4.button5  -padx 2  -side left
  pack configure .tpGetObjName.frame4.button6  -padx 2  -side left

  # pack master .tpGetObjName.class
  pack configure .tpGetObjName.class.label2  -side left
  pack configure .tpGetObjName.class.entry0

  # pack master .tpGetObjName.frame5
  pack configure .tpGetObjName.frame5.label2  -side left
  pack configure .tpGetObjName.frame5.entry0  -expand 1  -fill x  -side left

  # pack master .tpGetObjName.colormap
  pack configure .tpGetObjName.colormap.label2  -side left
  pack configure .tpGetObjName.colormap.entry0

  # pack master .tpGetObjName.container
  pack configure .tpGetObjName.container.label2  -side left
  pack configure .tpGetObjName.container.entry0

  # pack master .tpGetObjName.visual
  pack configure .tpGetObjName.visual.label2  -side left
  pack configure .tpGetObjName.visual.entry0

  # pack master .tpGetObjName.screen
  pack configure .tpGetObjName.screen.label2  -side left
  pack configure .tpGetObjName.screen.entry0

  # pack master .tpGetObjName.use
  pack configure .tpGetObjName.use.label2  -side left
  pack configure .tpGetObjName.use.entry0

  # pack master .tpGetObjName
  pack configure .tpGetObjName.label2
  pack configure .tpGetObjName.frame4  -pady 4  -side bottom
  pack configure .tpGetObjName.frame5  -fill x

EndSrc.tpGetObjName

}

proc DestroyWindow.tpGetObjName {} {
     catch {destroy .tpGetObjName}
     update
}

proc EndSrc.tpGetObjName {} {
global TPnextObjType

wm iconphoto .tpGetObjName tplogo16
pack forget .tpGetObjName.class .tpGetObjName.colormap .tpGetObjName.container .tpGetObjName.visual .tpGetObjName.screen .tpGetObjName.use
switch $TPnextObjType {
	   Tframe -
           frame -
	   Tlabelframe -
           labelframe	{
		  pack .tpGetObjName.class .tpGetObjName.colormap .tpGetObjName.container .tpGetObjName.visual -after .tpGetObjName.frame5 -side top
		}
           toplevel	{
		  pack .tpGetObjName.class .tpGetObjName.colormap .tpGetObjName.container .tpGetObjName.screen .tpGetObjName.use .tpGetObjName.visual -after .tpGetObjName.frame5 -side top
		}
        }
}





proc ShowWindow.tpToplevels { args} {

  catch {destroy .tpToplevels}

  toplevel .tpToplevels   -relief {sunken}  -background {#dcdcdc}  -highlightbackground {#e6e7e6}

  # Window manager configurations
  wm positionfrom .tpToplevels program
  wm sizefrom .tpToplevels program
  wm maxsize .tpToplevels 2560 1024
  wm minsize .tpToplevels 261 162
  wm protocol .tpToplevels WM_DELETE_WINDOW {.tpToplevels.frame27.button28 invoke}
  wm title .tpToplevels {Toplevel windows}


  frame .tpToplevels.frame27  -borderwidth {2}  -background {#dcdcdc}  -height {32}  -highlightbackground {#dcdcdc}  -width {120}

  button .tpToplevels.frame27.button28  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_WindowDestroy .tpToplevels.frame2.text2
set TPshowToplevels 0
DestroyWindow.tpToplevels}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {OK}

  button .tpToplevels.frame27.button29  -activebackground {gray75}  -background {#dcdcdc}  -command {EndSrc.tpToplevels}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Rescan}

  frame .tpToplevels.frame2  -relief {raised}  -background {#e6e7e6}  -highlightbackground {#e6e7e6}

  scrollbar .tpToplevels.frame2.scrollbar1  -activebackground {#e6e7e6}  -background {#dcdcdc}  -command {.tpToplevels.frame2.text2 yview}  -cursor {left_ptr}  -highlightbackground {#e6e7e6}  -relief {raised}  -troughcolor {#e6e7e6}  -width {12}

  text .tpToplevels.frame2.text2  -background {white}  -font {Helvetica 8}  -height {8}  -highlightbackground {#ffffff}  -selectbackground {#447bcd}  -selectforeground {#ffffff}  -state {disabled}  -width {30}  -yscrollcommand {.tpToplevels.frame2.scrollbar1 set}

  checkbutton .tpToplevels.frame2.text2.top0  -activebackground {AntiqueWhite}  -background {white}  -command {catch {if {$TPtoplevels(0)} {wm state . normal} {wm state . withdrawn}}}  -font {Helvetica 8}  -highlightbackground {#eeeeee}  -highlightthickness {0}  -text {ROOT}  -variable {TPtoplevels(0)}

  # pack master .tpToplevels.frame27
  pack configure .tpToplevels.frame27.button28  -padx 2  -side left
  pack configure .tpToplevels.frame27.button29  -padx 2  -side left

  # pack master .tpToplevels.frame2
  pack configure .tpToplevels.frame2.scrollbar1  -fill y  -side right
  pack configure .tpToplevels.frame2.text2  -expand 1  -fill both

  # pack master .tpToplevels
  pack configure .tpToplevels.frame27  -side bottom
  pack configure .tpToplevels.frame2  -expand 1  -fill both

  .tpToplevels.frame2.text2 insert end {}

EndSrc.tpToplevels
}

proc DestroyWindow.tpToplevels {} {
     catch {destroy .tpToplevels}
     update
}

proc EndSrc.tpToplevels {} {
global TPtoplevels

wm iconphoto .tpToplevels tplogo16
set winlist [TP_ToplevelSearch]

# Remove currently displayed list by destroying the containing text widget.
set tbox .tpToplevels.frame2.text2
TP_WindowDestroy $tbox

# Recreate the text widget container.
text $tbox -width 30 -height 8 -background white -borderwidth 1 -relief sunken -yscrollcommand {.tpToplevels.frame2.scrollbar1 set}
pack $tbox -fill both -expand 1 -side top

# Insert a checkbox for each window found.
if {[info exists TPtoplevels]} { array unset TPtoplevels }
set winCtr 0
foreach wname $winlist {
	# Create the checkbox
	set cbname $tbox.top$winCtr
	set cmd "catch \{if \{\$TPtoplevels($winCtr)\} \{TPopenWindow.$wname\} \{TPcloseWindow.$wname\}\}"
	checkbutton $cbname -relief flat -variable TPtoplevels($winCtr) -text $wname -command $cmd  -background white -highlightthickness 0 -activebackground AntiqueWhite
	if {$wname == {ROOT}} {
	    set cmd "catch \{if \{\$TPtoplevels($winCtr)\} \{wm state . normal\} \{wm state . withdrawn\}\}"
	    $cbname configure -command $cmd
	    switch [wm state .] {
		normal -
		zoomed	{ set TPtoplevels($winCtr) 1 }
		default	{ set TPtoplevels($winCtr) 0 }
	            }
	   } { set TPtoplevels($winCtr) [winfo exists .$wname] }

	# Insert the new checkbox into the text widget.
	$tbox window create end -window $cbname
	$tbox insert end "\n"

	incr winCtr
          }

# Prevent user from modifying text widget contents
$tbox configure -state disabled
return {}
}


proc ShowWindow.tppane {} {
# CLONEPATH = .tppane
# Cloned Thu May 14 22:01:22 EDT 2009

set wname .tppane
if {[winfo exists $wname]} { return {} } 


toplevel .tppane -background {grey85} -highlightbackground {#eeeeee}
bindtags .tppane {.tppane Toplevel all}
wm title .tppane {Panedwindow children}
wm aspect .tppane 
wm focusmodel .tppane passive
wm grid .tppane 
wm geometry .tppane 334x311+141+81
wm iconmask .tppane 
wm iconposition .tppane 
wm maxsize .tppane 2545 994
wm minsize .tppane 334 311
wm overrideredirect .tppane 0
wm positionfrom .tppane user
wm resizable .tppane 1 1
wm sizefrom .tppane 
wm state .tppane normal
wm transient .tppane 
wm protocol .tppane WM_DELETE_WINDOW DestroyWindow.tppane


frame .tppane.frame1 -borderwidth {2} -relief {ridge} -background {grey85} -height {30} -highlightbackground {#eeeeee} -width {30}

label .tppane.frame1.label2 -activebackground {#eeeeee} -background {grey85} -borderwidth {2} -font {Helvetica 10} -highlightbackground {#eeeeee} -text {Widget name:}
pack .tppane.frame1.label2 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left


label .tppane.frame1.label3 -activebackground {#eeeeee} -background {grey85} -borderwidth {2} -font {Helvetica 10} -foreground {blue} -highlightbackground {#eeeeee} -text {.vpanedwindow8} -textvariable {TPpaneWidget}
pack .tppane.frame1.label3 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

pack .tppane.frame1 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tppane.frame1.label2 .tppane.frame1.label3 -in .tppane.frame1


frame .tppane.frame4 -borderwidth {2} -relief {ridge} -background {grey85} -height {30} -highlightbackground {#eeeeee} -width {30}

button .tppane.frame4.button5 -activebackground {#eeeeee} -background {grey85} -command {TP_PanewindowSet
DestroyWindow.tppane} -font {Helvetica 10} -highlightbackground {#eeeeee} -highlightthickness {0} -pady {1} -text {Done}
pack .tppane.frame4.button5 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

button .tppane.frame4.button6 -activebackground {#eeeeee} -background {grey85} -command {foreach TPtemp {after before height hide minsize padx pady sticky stretch width} {
	$TPpaneWidget paneconfigure $TPpaneconfig(window) -$TPtemp $TPpanecancel($TPtemp)
            }
DestroyWindow.tppane} -font {Helvetica 10} -highlightbackground {#eeeeee} -highlightthickness {0} -pady {1} -text {Cancel}
pack .tppane.frame4.button6 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side right

pack .tppane.frame4 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tppane.frame4.button5 .tppane.frame4.button6 -in .tppane.frame4


frame .tppane.frame8 -relief {raised} -background {grey85} -height {30} -highlightbackground {#eeeeee} -width {30}

label .tppane.frame8.label9 -activebackground {#eeeeee} -anchor {w} -background {grey85} -borderwidth {2} -font {Helvetica 10} -highlightbackground {#eeeeee} -text {configure window:} -width {15}
pack .tppane.frame8.label9 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left


ttk::combobox .tppane.frame8.combobox10 -values {.vpanedwindow8.button9 .vpanedwindow8.button10} -font {Helvetica 10} -textvariable {TPpaneconfig(window)} -takefocus {ttk::takefocus}
.tppane.frame8.combobox10 state {}
bind .tppane.frame8.combobox10 <<ComboboxSelected>> {TP_PanedwindowSel %W}

pack .tppane.frame8.combobox10 -anchor center -expand 1 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

pack .tppane.frame8 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tppane.frame8.label9 .tppane.frame8.combobox10 -in .tppane.frame8


frame .tppane.frame0 -relief {raised} -background {grey85} -height {30} -highlightbackground {#eeeeee} -width {30}

label .tppane.frame0.label9 -activebackground {#eeeeee} -anchor {w} -background {grey85} -borderwidth {2} -font {Helvetica 10} -highlightbackground {#eeeeee} -justify {left} -text {after:} -width {15}
pack .tppane.frame0.label9 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left


ttk::combobox .tppane.frame0.combobox10 -values {.hpanedwindow1.label2 .hpanedwindow1.label3} -font {Helvetica 10} -textvariable {TPpaneconfig(after)} -takefocus {ttk::takefocus}
.tppane.frame0.combobox10 state {}
bind .tppane.frame0.combobox10 <<ComboboxSelected>> {TP_PanewindowSet}

bind .tppane.frame0.combobox10 <Key-Return> {TP_PanewindowSet}

bind .tppane.frame0.combobox10 <Key-KP_Enter> {TP_PanewindowSet}

pack .tppane.frame0.combobox10 -anchor center -expand 1 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

pack .tppane.frame0 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tppane.frame0.label9 .tppane.frame0.combobox10 -in .tppane.frame0


frame .tppane.frame2 -relief {raised} -background {grey85} -height {30} -highlightbackground {#eeeeee} -width {30}

label .tppane.frame2.label9 -activebackground {#eeeeee} -anchor {w} -background {grey85} -borderwidth {2} -font {Helvetica 10} -highlightbackground {#eeeeee} -justify {left} -text {before:} -width {15}
pack .tppane.frame2.label9 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left


ttk::combobox .tppane.frame2.combobox10 -values {.hpanedwindow1.label2 .hpanedwindow1.label3} -font {Helvetica 10} -textvariable {TPpaneconfig(before)} -takefocus {ttk::takefocus}
.tppane.frame2.combobox10 state {}
bind .tppane.frame2.combobox10 <<ComboboxSelected>> {TP_PanewindowSet}

bind .tppane.frame2.combobox10 <Key-KP_Enter> {TP_PanewindowSet}

bind .tppane.frame2.combobox10 <Key-Return> {TP_PanewindowSet}

pack .tppane.frame2.combobox10 -anchor center -expand 1 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

pack .tppane.frame2 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tppane.frame2.label9 .tppane.frame2.combobox10 -in .tppane.frame2


frame .tppane.frame3 -relief {raised} -background {grey85} -height {30} -highlightbackground {#eeeeee} -width {30}

label .tppane.frame3.label9 -activebackground {#eeeeee} -anchor {w} -background {grey85} -borderwidth {2} -font {Helvetica 10} -highlightbackground {#eeeeee} -justify {left} -text {height:} -width {15}
pack .tppane.frame3.label9 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left


spinbox .tppane.frame3.spinbox0 -background {white} -buttonbackground {grey85} -command {TP_PanewindowSet} -font {Helvetica 10} -highlightthickness {0} -textvariable {TPpaneconfig(height)} -to {10000.0} -width {5}
bind .tppane.frame3.spinbox0 <Key-KP_Enter> {TP_PanewindowSet}

bind .tppane.frame3.spinbox0 <Key-Return> {TP_PanewindowSet}

pack .tppane.frame3.spinbox0 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 1 -side top

pack .tppane.frame3 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tppane.frame3.label9 .tppane.frame3.spinbox0 -in .tppane.frame3


frame .tppane.frame5 -relief {raised} -background {grey85} -height {30} -highlightbackground {#eeeeee} -width {30}

label .tppane.frame5.label9 -activebackground {#eeeeee} -anchor {w} -background {grey85} -borderwidth {2} -font {Helvetica 10} -highlightbackground {#eeeeee} -justify {left} -text {minsize:} -width {15}
pack .tppane.frame5.label9 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left


spinbox .tppane.frame5.spinbox0 -background {white} -buttonbackground {grey85} -command {TP_PanewindowSet} -font {Helvetica 10} -highlightthickness {0} -textvariable {TPpaneconfig(minsize)} -to {10000.0} -width {5}
bind .tppane.frame5.spinbox0 <Key-KP_Enter> {TP_PanewindowSet}

bind .tppane.frame5.spinbox0 <Key-Return> {TP_PanewindowSet}

pack .tppane.frame5.spinbox0 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 1 -side top

pack .tppane.frame5 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tppane.frame5.label9 .tppane.frame5.spinbox0 -in .tppane.frame5


frame .tppane.frame6 -relief {raised} -background {grey85} -height {30} -highlightbackground {#eeeeee} -width {30}

label .tppane.frame6.label9 -activebackground {#eeeeee} -anchor {w} -background {grey85} -borderwidth {2} -font {Helvetica 10} -highlightbackground {#eeeeee} -justify {left} -text {hide:} -width {15}
pack .tppane.frame6.label9 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left


ttk::combobox .tppane.frame6.combobox10 -values {0 1} -font {Helvetica 10} -textvariable {TPpaneconfig(hide)} -takefocus {ttk::takefocus}
.tppane.frame6.combobox10 state {}
bind .tppane.frame6.combobox10 <<ComboboxSelected>> {TP_PanewindowSet}

bind .tppane.frame6.combobox10 <Key-KP_Enter> {TP_PanewindowSet}

bind .tppane.frame6.combobox10 <Key-Return> {TP_PanewindowSet}

pack .tppane.frame6.combobox10 -anchor center -expand 1 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

pack .tppane.frame6 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tppane.frame6.label9 .tppane.frame6.combobox10 -in .tppane.frame6


frame .tppane.frame7 -relief {raised} -background {grey85} -height {30} -highlightbackground {#eeeeee} -width {30}

label .tppane.frame7.label9 -activebackground {#eeeeee} -anchor {w} -background {grey85} -borderwidth {2} -font {Helvetica 10} -highlightbackground {#eeeeee} -justify {left} -text {padx:} -width {15}
pack .tppane.frame7.label9 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left


ttk::combobox .tppane.frame7.combobox10 -font {Helvetica 10} -textvariable {TPpaneconfig(padx)} -takefocus {ttk::takefocus}
.tppane.frame7.combobox10 state {}
bind .tppane.frame7.combobox10 <<ComboboxSelected>> {TP_PanewindowSet}

bind .tppane.frame7.combobox10 <Key-KP_Enter> {TP_PanewindowSet}

bind .tppane.frame7.combobox10 <Key-Return> {TP_PanewindowSet}

pack .tppane.frame7.combobox10 -anchor center -expand 1 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

pack .tppane.frame7 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tppane.frame7.label9 .tppane.frame7.combobox10 -in .tppane.frame7


frame .tppane.frame9 -relief {raised} -background {grey85} -height {30} -highlightbackground {#eeeeee} -width {30}

label .tppane.frame9.label9 -activebackground {#eeeeee} -anchor {w} -background {grey85} -borderwidth {2} -font {Helvetica 10} -highlightbackground {#eeeeee} -justify {left} -text {pady:} -width {15}
pack .tppane.frame9.label9 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left


ttk::combobox .tppane.frame9.combobox10 -font {Helvetica 10} -textvariable {TPpaneconfig(pady)} -takefocus {ttk::takefocus}
.tppane.frame9.combobox10 state {focus}
bind .tppane.frame9.combobox10 <<ComboboxSelected>> {TP_PanewindowSet}

bind .tppane.frame9.combobox10 <Key-KP_Enter> {TP_PanewindowSet}

bind .tppane.frame9.combobox10 <Key-Return> {TP_PanewindowSet}

pack .tppane.frame9.combobox10 -anchor center -expand 1 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

pack .tppane.frame9 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tppane.frame9.label9 .tppane.frame9.combobox10 -in .tppane.frame9


frame .tppane.frame10 -relief {raised} -background {grey85} -height {30} -highlightbackground {#eeeeee} -width {30}

label .tppane.frame10.label9 -activebackground {#eeeeee} -anchor {w} -background {grey85} -borderwidth {2} -font {Helvetica 10} -highlightbackground {#eeeeee} -justify {left} -text {sticky:} -width {15}
pack .tppane.frame10.label9 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left


ttk::combobox .tppane.frame10.combobox10 -values {center n ne e se s sw w nw nesw} -font {Helvetica 10} -textvariable {TPpaneconfig(sticky)} -takefocus {ttk::takefocus}
.tppane.frame10.combobox10 state {focus}
bind .tppane.frame10.combobox10 <Key-Return> {TP_PanewindowSet}

bind .tppane.frame10.combobox10 <Key-KP_Enter> {TP_PanewindowSet}

bind .tppane.frame10.combobox10 <<ComboboxSelected>> {TP_PanewindowSet}

pack .tppane.frame10.combobox10 -anchor center -expand 1 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

pack .tppane.frame10 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tppane.frame10.label9 .tppane.frame10.combobox10 -in .tppane.frame10


frame .tppane.frame11 -relief {raised} -background {grey85} -height {30} -highlightbackground {#eeeeee} -width {30}

label .tppane.frame11.label9 -activebackground {#eeeeee} -anchor {w} -background {grey85} -borderwidth {2} -font {Helvetica 10} -highlightbackground {#eeeeee} -justify {left} -text {stretch:} -width {15}
pack .tppane.frame11.label9 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left


ttk::combobox .tppane.frame11.combobox10 -values {always first last middle never} -font {Helvetica 10} -textvariable {TPpaneconfig(stretch)} -takefocus {ttk::takefocus}
.tppane.frame11.combobox10 state {}
bind .tppane.frame11.combobox10 <<ComboboxSelected>> {TP_PanewindowSet}

bind .tppane.frame11.combobox10 <Key-KP_Enter> {TP_PanewindowSet}

bind .tppane.frame11.combobox10 <Key-Return> {TP_PanewindowSet}

pack .tppane.frame11.combobox10 -anchor center -expand 1 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

pack .tppane.frame11 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tppane.frame11.label9 .tppane.frame11.combobox10 -in .tppane.frame11


frame .tppane.frame12 -relief {raised} -background {grey85} -height {30} -highlightbackground {#eeeeee} -width {30}

label .tppane.frame12.label9 -activebackground {#eeeeee} -anchor {w} -background {grey85} -borderwidth {2} -font {Helvetica 10} -highlightbackground {#eeeeee} -justify {left} -text {width:} -width {15}
pack .tppane.frame12.label9 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left


spinbox .tppane.frame12.spinbox0 -background {white} -buttonbackground {grey85} -command {TP_PanewindowSet} -font {Helvetica 10} -highlightthickness {0} -textvariable {TPpaneconfig(width)} -to {10000.0} -width {5}
bind .tppane.frame12.spinbox0 <Key-KP_Enter> {TP_PanewindowSet}

bind .tppane.frame12.spinbox0 <Key-Return> {TP_PanewindowSet}

pack .tppane.frame12.spinbox0 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 1 -side top

pack .tppane.frame12 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tppane.frame12.label9 .tppane.frame12.spinbox0 -in .tppane.frame12

pack .tppane.frame1 .tppane.frame4 .tppane.frame8 .tppane.frame0 .tppane.frame2 .tppane.frame3 .tppane.frame6 .tppane.frame5 .tppane.frame7 .tppane.frame9 .tppane.frame10 .tppane.frame11 .tppane.frame12 -in .tppane
EndSrc.tppane}

proc DestroyWindow.tppane {} {
     catch {destroy .tppane}
     return {}
}

proc EndSrc.tppane {} {
global TPcurWidget
global TPpaneWidget
global TPpaneconfig

wm iconphoto .tppane tplogo16

if {[TP_ClassGet $TPcurWidget] eq {Panedwindow}} {
    set TPpaneWidget $TPcurWidget
    set TPtemp [lsort -dictionary [$TPcurWidget panes]]
    .tppane.frame8.combobox10 configure -values $TPtemp
    set TPpaneconfig(window) [lindex $TPtemp 0]
    if {[string length $TPpaneconfig(window)]} {
        TP_PanedwindowSel .tppane.frame8.combobox10
       } { DestroyWindow.tppane }
   }}

proc ShowWindow.tptpane {} {
# CLONEPATH = .tptpane
# Cloned Thu May 14 22:01:11 EDT 2009

set wname .tptpane
wm iconphoto $wname tplogo16
if {[winfo exists $wname]} { return {} } 


toplevel .tptpane -background grey85 -highlightbackground {#eeeeee}
bindtags .tptpane {.tptpane Toplevel all}
wm title .tptpane {ttk::Panedwindow children}
wm aspect .tptpane 
wm focusmodel .tptpane passive
wm grid .tptpane 
wm geometry .tptpane 268x96+345+4
wm iconmask .tptpane 
wm iconposition .tptpane 
wm maxsize .tptpane 2545 994
wm minsize .tptpane 268 96
wm overrideredirect .tptpane 0
wm positionfrom .tptpane user
wm resizable .tptpane 1 1
wm sizefrom .tptpane 
wm state .tptpane normal
wm transient .tptpane 
wm protocol .tptpane WM_DELETE_WINDOW DestroyWindow.tptpane


frame .tptpane.frame1 -borderwidth {2} -relief {ridge} -background {grey85} -height {30} -highlightbackground {#eeeeee} -width {30}

label .tptpane.frame1.label2 -activebackground {#eeeeee} -background {grey85} -borderwidth {2} -font {Helvetica 10} -highlightbackground {#eeeeee} -text {Widget name:}
pack .tptpane.frame1.label2 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left


label .tptpane.frame1.label3 -activebackground {#eeeeee} -background {grey85} -borderwidth {2} -font {Helvetica 10} -foreground {blue} -highlightbackground {#eeeeee} -text {.hpanedwindow1} -textvariable {TPtpaneWidget}
pack .tptpane.frame1.label3 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

pack .tptpane.frame1 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tptpane.frame1.label2 .tptpane.frame1.label3 -in .tptpane.frame1


frame .tptpane.frame4 -borderwidth {2} -relief {ridge} -background {grey85} -height {30} -highlightbackground {#eeeeee} -width {30}

button .tptpane.frame4.button5 -activebackground {#eeeeee} -background {grey85} -command {TP_TpanedwindowSet
DestroyWindow.tptpane} -font {Helvetica 10} -highlightbackground {#eeeeee} -highlightthickness {0} -pady {1} -state {normal} -text {Done}
pack .tptpane.frame4.button5 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left


button .tptpane.frame4.button6 -activebackground {#eeeeee} -background {grey85} -command {foreach TPtemp weight {
	$TPtpaneWidget pane $TPtpaneconfig(window) -$TPtemp $TPtpanecancel($TPtemp)
            }
DestroyWindow.tptpane} -font {Helvetica 10} -highlightbackground {#eeeeee} -highlightthickness {0} -pady {1} -text {Cancel}
pack .tptpane.frame4.button6 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side right

pack .tptpane.frame4 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tptpane.frame4.button5 .tptpane.frame4.button6 -in .tptpane.frame4


frame .tptpane.frame8 -relief {raised} -background {grey85} -height {30} -highlightbackground {#eeeeee} -width {30}

label .tptpane.frame8.label9 -activebackground {#eeeeee} -anchor {w} -background {grey85} -borderwidth {2} -font {Helvetica 10} -highlightbackground {#eeeeee} -text {configure window:} -width {15}
pack .tptpane.frame8.label9 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left


ttk::combobox .tptpane.frame8.combobox10 -values {.hpanedwindow1.label2 .hpanedwindow1.label3} -font {Helvetica 10} -textvariable {TPtpaneconfig(window)} -takefocus {ttk::takefocus}
.tptpane.frame8.combobox10 state {}
bind .tptpane.frame8.combobox10 <<ComboboxSelected>> {TP_TpanedwindowSel %W}

pack .tptpane.frame8.combobox10 -anchor center -expand 1 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

pack .tptpane.frame8 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tptpane.frame8.label9 .tptpane.frame8.combobox10 -in .tptpane.frame8


frame .tptpane.frame12 -relief {raised} -background {grey85} -height {30} -highlightbackground {#eeeeee} -width {30}

label .tptpane.frame12.label9 -activebackground {#eeeeee} -anchor {w} -background {grey85} -borderwidth {2} -font {Helvetica 10} -highlightbackground {#eeeeee} -justify {left} -text {weight:} -width {15}
pack .tptpane.frame12.label9 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left


spinbox .tptpane.frame12.spinbox0 -background {white} -buttonbackground {grey85} -command {TP_TpanedwindowSet} -font {Helvetica 10} -highlightthickness {0} -textvariable {TPtpaneconfig(weight)} -to {10000.0} -width {5}
bind .tptpane.frame12.spinbox0 <Key-KP_Enter> {TP_TpanedwindowSet}

bind .tptpane.frame12.spinbox0 <Key-Return> {TP_TpanedwindowSet}

pack .tptpane.frame12.spinbox0 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 1 -side top

pack .tptpane.frame12 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tptpane.frame12.label9 .tptpane.frame12.spinbox0 -in .tptpane.frame12

pack .tptpane.frame1 .tptpane.frame4 .tptpane.frame8 .tptpane.frame12 -in .tptpane
EndSrc.tptpane}

proc DestroyWindow.tptpane {} {
     catch {destroy .tptpane}
     return {}
}

proc EndSrc.tptpane {} {
global TPcurWidget
global TPtpaneWidget
global TPtpaneconfig

wm iconphoto .tptpane tplogo16

if {[TP_ClassGet $TPcurWidget] eq {TPanedwindow}} {
    set TPtpaneWidget $TPcurWidget
    set TPtemp [lsort -dictionary [$TPcurWidget panes]]
    .tptpane.frame8.combobox10 configure -values $TPtemp
    set TPtpaneconfig(window) [lindex $TPtemp 0]
    if {[string length $TPtpaneconfig(window)]} {
        TP_TpanedwindowSel .tptpane.frame8.combobox10
       } { DestroyWindow.tptpane }
   }
}


proc ShowWindow.tpTree { args} {

  catch "destroy .tpTree"

  toplevel .tpTree   -relief {sunken}  -background {#dcdcdc}  -highlightbackground {#dcdcdc}

  # Window manager configurations
  wm positionfrom .tpTree program
  wm sizefrom .tpTree program
  wm maxsize .tpTree 2560 1024
  wm minsize .tpTree 342 242
  wm protocol .tpTree WM_DELETE_WINDOW {.tpTree.frame.listbox1 delete 0 end
set TPshowWidgetTree 0
DestroyWindow.tpTree}
  wm title .tpTree {TKproE - Application widget tree}


  frame .tpTree.frame  -background {#dcdcdc}  -highlightbackground {#dcdcdc}

#LISSI
#  scrollbar .tpTree.frame.scrollbar3  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpTree.frame.listbox1 xview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -orient {horizontal}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}
#  scrollbar .tpTree.frame.scrollbar2  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpTree.frame.listbox1 yview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}
  ttk::scrollbar .tpTree.frame.scrollbar3 -command {.tpTree.frame.listbox1 xview} -orient {horizontal}
  ttk::scrollbar .tpTree.frame.scrollbar2 -command {.tpTree.frame.listbox1 yview} 

  listbox .tpTree.frame.listbox1  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -width {40}  -xscrollcommand {.tpTree.frame.scrollbar3 set}  -yscrollcommand {.tpTree.frame.scrollbar2 set}
  # bindings
  bind .tpTree.frame.listbox1 <Double-Button-1> {set TPtemp [%W curselection]
if {[llength $TPtemp] == 1} {
    TP_PathMenuCreate [%W get $TPtemp]
   }}

  frame .tpTree.frame27  -borderwidth {2}  -background {#dcdcdc}  -height {32}  -highlightbackground {#dcdcdc}  -width {120}

  button .tpTree.frame27.button28  -activebackground {gray75}  -background {#dcdcdc}  -command {.tpTree.frame.listbox1 delete 0 end
set TPshowWidgetTree 0
DestroyWindow.tpTree}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0} -text {OK}

  button .tpTree.frame27.button29  -activebackground {gray75}  -background {#dcdcdc}  -command {.tpTree.frame.listbox1 delete 0 end
eval ".tpTree.frame.listbox1 insert end [TP_TreeSearch .]"}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Rescan}

  label .tpTree.label0  -activebackground {#eeeeee}  -background {#dcdcdc}  -borderwidth {4}  -font {Helvetica 10 italic}  -foreground {red}  -highlightbackground {#eeeeee}  -text {Double click to set current widget path}

  # pack master .tpTree.frame
  pack configure .tpTree.frame.scrollbar2  -fill y  -side right
  pack configure .tpTree.frame.listbox1  -expand 1  -fill both
  pack configure .tpTree.frame.scrollbar3  -fill x  -side bottom

  # pack master .tpTree.frame27
  pack configure .tpTree.frame27.button28  -padx 2  -side left
  pack configure .tpTree.frame27.button29  -padx 2  -side left

  # pack master .tpTree
  pack configure .tpTree.frame  -expand 1  -fill both
  pack configure .tpTree.frame27  -pady 2  -side bottom
  pack configure .tpTree.label0  -anchor w

EndSrc.tpTree
}

proc DestroyWindow.tpTree {} {
    catch "destroy .tpTree"
    update
}

proc EndSrc.tpTree {} {
wm iconphoto .tpTree tplogo16
.tpTree.frame.listbox1 delete 0 end
eval ".tpTree.frame.listbox1 insert end [TP_TreeSearch .]"
}


proc ShowWindow.tpTreeview {} {
set wname .tpTreeview
if {[winfo exists $wname]} { return {} } 

toplevel .tpTreeview
bindtags .tpTreeview {.tpTreeview Toplevel all}
wm title .tpTreeview {Treeview properties}
wm aspect .tpTreeview 
wm focusmodel .tpTreeview passive
wm grid .tpTreeview 
wm geometry .tpTreeview 372x68+27+0
wm iconmask .tpTreeview 
wm iconposition .tpTreeview 
wm maxsize .tpTreeview 1009 738
wm minsize .tpTreeview 1 1
wm overrideredirect .tpTreeview 0
wm positionfrom .tpTreeview user
wm resizable .tpTreeview 1 1
wm sizefrom .tpTreeview 
wm state .tpTreeview normal
wm transient .tpTreeview 
wm protocol .tpTreeview WM_DELETE_WINDOW DestroyWindow.tpTreeview

frame .tpTreeview.frame2 -borderwidth {2} -relief {ridge} -height {30} -width {30}

label .tpTreeview.frame2.label3 -borderwidth {0} -font {Helvetica 10} -relief {raised} -text {Widget name:}
pack .tpTreeview.frame2.label3 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left


label .tpTreeview.frame2.label5 -borderwidth {0} -font {Helvetica 10} -foreground {blue} -relief {raised} -text {.dummy.tree} -textvariable {TPcurTree}
pack .tpTreeview.frame2.label5 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

pack .tpTreeview.frame2 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tpTreeview.frame2.label3 .tpTreeview.frame2.label5 -in .tpTreeview.frame2

frame .tpTreeview.framegen -relief {raised} -height {30} -width {30}

frame .tpTreeview.framegen.frame8 -relief {raised} -height {30} -width {30}

label .tpTreeview.framegen.frame8.label9 -anchor {w} -borderwidth {0} -font {Helvetica 12} -relief {raised} -text {cursor:} -width {16}
pack .tpTreeview.framegen.frame8.label9 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

entry .tpTreeview.framegen.frame8.entry10 -font {Helvetica 10} -textvariable {TPtree(-cursor)} -bg white
set cmd "catch \{\$TPcurTree configure -cursor \$TPtree(-cursor)\}"
bind .tpTreeview.framegen.frame8.entry10 <FocusOut> $cmd
bind .tpTreeview.framegen.frame8.entry10 <Key-KP_Enter> $cmd
bind .tpTreeview.framegen.frame8.entry10 <Key-Return> $cmd
pack .tpTreeview.framegen.frame8.entry10 -anchor center -expand 1 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

pack .tpTreeview.framegen.frame8 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tpTreeview.framegen.frame8.label9 .tpTreeview.framegen.frame8.entry10 -in .tpTreeview.framegen.frame8

frame .tpTreeview.framegen.frame0 -relief {raised} -height {30} -width {30}

label .tpTreeview.framegen.frame0.label9 -anchor {w} -borderwidth {0} -font {Helvetica 12} -relief {raised} -text {style:} -width {16}
pack .tpTreeview.framegen.frame0.label9 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

entry .tpTreeview.framegen.frame0.entry10 -font {Helvetica 10} -textvariable {TPtree(-style)} -bg white
foreach eventName {<Key-KP_Enter> <Key-Return> <FocusOut>} {
	bind .tpTreeview.framegen.frame0.entry10 $eventName {catch {$TPcurTree configure -style $TPtree(-style)}}
      }
pack .tpTreeview.framegen.frame0.entry10 -anchor center -expand 1 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

pack .tpTreeview.framegen.frame0 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tpTreeview.framegen.frame0.label9 .tpTreeview.framegen.frame0.entry10 -in .tpTreeview.framegen.frame0

frame .tpTreeview.framegen.frame1 -relief {raised} -height {30} -width {30}

label .tpTreeview.framegen.frame1.label9 -anchor {w} -borderwidth {0} -font {Helvetica 12} -relief {raised} -text {takefocus:} -width {16}
pack .tpTreeview.framegen.frame1.label9 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

entry .tpTreeview.framegen.frame1.entry10 -font {Helvetica 10} -textvariable {TPtree(-takefocus)} -bg white
foreach eventName {<Key-KP_Enter> <Key-Return> <FocusOut>} {
	bind .tpTreeview.framegen.frame1.entry10 $eventName {catch {$TPcurTree configure -takefocus $TPtree(-takefocus)}}
      }
pack .tpTreeview.framegen.frame1.entry10 -anchor center -expand 1 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

pack .tpTreeview.framegen.frame1 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tpTreeview.framegen.frame1.label9 .tpTreeview.framegen.frame1.entry10 -in .tpTreeview.framegen.frame1

frame .tpTreeview.framegen.frame3 -relief {raised} -height {30} -width {30}

label .tpTreeview.framegen.frame3.label9 -anchor {w} -borderwidth {0} -font {Helvetica 12} -relief {raised} -text {xscrollcommand:} -width {16}
pack .tpTreeview.framegen.frame3.label9 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

entry .tpTreeview.framegen.frame3.entry10 -font {Helvetica 10} -textvariable {TPtree(-xscrollcommand)} -bg white
foreach eventName {<Key-KP_Enter> <Key-Return> <FocusOut>} {
	bind .tpTreeview.framegen.frame3.entry10 $eventName {catch {$TPcurTree configure -xscrollcommand $TPtree(-xscrollcommand)}}
      }
pack .tpTreeview.framegen.frame3.entry10 -anchor center -expand 1 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

pack .tpTreeview.framegen.frame3 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tpTreeview.framegen.frame3.label9 .tpTreeview.framegen.frame3.entry10 -in .tpTreeview.framegen.frame3

frame .tpTreeview.framegen.frame4 -relief {raised} -height {30} -width {30}

label .tpTreeview.framegen.frame4.label9 -anchor {w} -borderwidth {0} -font {Helvetica 12} -relief {raised} -text {yscrollcommand:} -width {16}
pack .tpTreeview.framegen.frame4.label9 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

entry .tpTreeview.framegen.frame4.entry10 -font {Helvetica 10} -textvariable {TPtree(-yscrollcommand)} -bg white
foreach eventName {<Key-KP_Enter> <Key-Return> <FocusOut>} {
	bind .tpTreeview.framegen.frame4.entry10 $eventName {catch {$TPcurTree configure -yscrollcommand $TPtree(-yscrollcommand)}}
      }
pack .tpTreeview.framegen.frame4.entry10 -anchor center -expand 1 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

pack .tpTreeview.framegen.frame4 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tpTreeview.framegen.frame4.label9 .tpTreeview.framegen.frame4.entry10 -in .tpTreeview.framegen.frame4

frame .tpTreeview.framegen.frame5 -relief {raised} -height {30} -width {30}

label .tpTreeview.framegen.frame5.label9 -anchor {w} -borderwidth {0} -font {Helvetica 12} -text {columns:} -width {16}
pack .tpTreeview.framegen.frame5.label9 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left


entry .tpTreeview.framegen.frame5.entry10 -font {Helvetica 10} -textvariable {TPtree(-columns)} -bg white
set cmd "catch \{\$TPcurTree configure -columns \$TPtree(-columns);.tpTreeview.framecol.frame12.combobox2 configure -values \[concat #0 \$TPtree(-columns)\]\}"
bind .tpTreeview.framegen.frame5.entry10 <Key-KP_Enter> $cmd
bind .tpTreeview.framegen.frame5.entry10 <Key-Return> $cmd
bind .tpTreeview.framegen.frame5.entry10 <FocusOut> $cmd
pack .tpTreeview.framegen.frame5.entry10 -anchor center -expand 1 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

pack .tpTreeview.framegen.frame5 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tpTreeview.framegen.frame5.label9 .tpTreeview.framegen.frame5.entry10 -in .tpTreeview.framegen.frame5

frame .tpTreeview.framegen.frame6 -relief {raised} -height {30} -width {30}

label .tpTreeview.framegen.frame6.label9 -anchor {w} -borderwidth {0} -font {Helvetica 12} -relief {raised} -text {displaycolumns:} -width {16}
pack .tpTreeview.framegen.frame6.label9 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

entry .tpTreeview.framegen.frame6.entry10 -font {Helvetica 10} -textvariable {TPtree(-displaycolumns)} -bg white
foreach eventName {<Key-KP_Enter> <Key-Return> <FocusOut>} {
	bind .tpTreeview.framegen.frame6.entry10 $eventName {catch {$TPcurTree configure -displaycolumns $TPtree(-displaycolumns)}}
      }
pack .tpTreeview.framegen.frame6.entry10 -anchor center -expand 1 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

pack .tpTreeview.framegen.frame6 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tpTreeview.framegen.frame6.label9 .tpTreeview.framegen.frame6.entry10 -in .tpTreeview.framegen.frame6

frame .tpTreeview.framegen.frame7 -relief {raised} -height {30} -width {30}

label .tpTreeview.framegen.frame7.label9 -anchor {w} -borderwidth {0} -font {Helvetica 12} -relief {raised} -text {height:} -width {16}
pack .tpTreeview.framegen.frame7.label9 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

spinbox .tpTreeview.framegen.frame7.spinbox11 -background {white} -command {catch {$TPcurTree configure -height $TPtree(-height)}} -font {Helvetica 10} -from {1.0} -textvariable {TPtree(-height)} -to {1000.0} -width {5}
foreach eventName {<Key-KP_Enter> <Key-Return> <FocusOut>} {
	bind .tpTreeview.framegen.frame7.spinbox11 $eventName {catch {$TPcurTree configure -height $TPtree(-height)}}
      }
pack .tpTreeview.framegen.frame7.spinbox11 -anchor center -expand 1 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

pack .tpTreeview.framegen.frame7 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tpTreeview.framegen.frame7.label9 .tpTreeview.framegen.frame7.spinbox11 -in .tpTreeview.framegen.frame7

frame .tpTreeview.framegen.frame9 -relief {raised} -height {30} -width {30}

label .tpTreeview.framegen.frame9.label9 -anchor {w} -borderwidth {0} -font {Helvetica 12} -relief {raised} -text {padding:} -width {16}
pack .tpTreeview.framegen.frame9.label9 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

entry .tpTreeview.framegen.frame9.entry10 -font {Helvetica 10} -textvariable {TPtree(-padding)} -bg white
set cmd "catch \{\$TPcurTree configure -padding \$TPtree(-padding)\}"
bind .tpTreeview.framegen.frame9.entry10 <FocusOut> $cmd
bind .tpTreeview.framegen.frame9.entry10 <Key-Return> $cmd
bind .tpTreeview.framegen.frame9.entry10 <Key-KP_Enter> $cmd
pack .tpTreeview.framegen.frame9.entry10 -anchor center -expand 1 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

pack .tpTreeview.framegen.frame9 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tpTreeview.framegen.frame9.label9 .tpTreeview.framegen.frame9.entry10 -in .tpTreeview.framegen.frame9

frame .tpTreeview.framegen.frame10 -relief {raised} -height {30} -width {30}

label .tpTreeview.framegen.frame10.label9 -anchor {w} -borderwidth {0} -font {Helvetica 12} -relief {raised} -text {selectmode:} -width {16}
pack .tpTreeview.framegen.frame10.label9 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

ttk::combobox .tpTreeview.framegen.frame10.combobox2 -values {extended browse none} -font {Helvetica 10} -textvariable {TPtree(-selectmode)} -takefocus {ttk::takefocus}
.tpTreeview.framegen.frame10.combobox2 state {}
set cmd "catch \{\$TPcurTree configure -selectmode \$TPtree(-selectmode)\}"
bind .tpTreeview.framegen.frame10.combobox2 <<ComboboxSelected>> $cmd
bind .tpTreeview.framegen.frame10.combobox2 <Key-KP_Enter> $cmd
bind .tpTreeview.framegen.frame10.combobox2 <Key-Return> $cmd
bind .tpTreeview.framegen.frame10.combobox2 <FocusOut> $cmd
pack .tpTreeview.framegen.frame10.combobox2 -anchor w -expand 0 -fill x -ipadx 0 -ipady 0 -padx 1 -pady 0 -side top

pack .tpTreeview.framegen.frame10 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tpTreeview.framegen.frame10.label9 .tpTreeview.framegen.frame10.combobox2 -in .tpTreeview.framegen.frame10

frame .tpTreeview.framegen.frame11 -relief {raised} -height {30} -width {30}

label .tpTreeview.framegen.frame11.label9 -anchor {w} -borderwidth {0} -font {Helvetica 12} -relief {raised} -text {show:} -width {16}
pack .tpTreeview.framegen.frame11.label9 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

ttk::combobox .tpTreeview.framegen.frame11.combobox2 -values {tree headings {tree headings}} -font {Helvetica 10} -textvariable {TPtree(-show)} -takefocus {ttk::takefocus}
.tpTreeview.framegen.frame11.combobox2 state {}
foreach eventName {<Key-KP_Enter> <Key-Return> <FocusOut> <<ComboboxSelected>>} {
	bind .tpTreeview.framegen.frame11.combobox2 $eventName {catch {$TPcurTree configure -show $TPtree(-show)}}
      }
pack .tpTreeview.framegen.frame11.combobox2 -anchor w -expand 0 -fill x -ipadx 0 -ipady 0 -padx 1 -pady 0 -side top

pack .tpTreeview.framegen.frame11 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tpTreeview.framegen.frame11.label9 .tpTreeview.framegen.frame11.combobox2 -in .tpTreeview.framegen.frame11

pack .tpTreeview.framegen.frame8 .tpTreeview.framegen.frame0 .tpTreeview.framegen.frame1 .tpTreeview.framegen.frame3 .tpTreeview.framegen.frame4 .tpTreeview.framegen.frame5 .tpTreeview.framegen.frame6 .tpTreeview.framegen.frame7 .tpTreeview.framegen.frame9 .tpTreeview.framegen.frame10 .tpTreeview.framegen.frame11 -in .tpTreeview.framegen

button .tpTreeview.button9 -background {grey70} -command {if {$TPtreeGenTab eq {General (-)}} {
    pack forget .tpTreeview.framegen
    set TPtreeGenTab {General (+)}
   } {
       pack .tpTreeview.framegen -fill x -side top -after .tpTreeview.button9
       set TPtreeGenTab {General (-)}
     }
set TPtemp 0
set TPtemp2 [winfo width .tpTreeview]
wm geometry .tpTreeview ${TPtemp2}x10000
update idletasks
foreach TPwin [pack slaves .tpTreeview] {
	incr TPtemp [winfo height $TPwin]
            }
wm geometry .tpTreeview ${TPtemp2}x$TPtemp
} -font {Helvetica 12} -highlightthickness {0} -padx {0} -pady {0} -text {General (+)} -textvariable {TPtreeGenTab}
pack .tpTreeview.button9 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top


button .tpTreeview.button0 -background {grey70} -command {if {$TPtreeColTab eq {Column (-)}} {
     pack forget .tpTreeview.framecol
     set TPtreeColTab {Column (+)}
   } {
       pack .tpTreeview.framecol -side top -fill x -after .tpTreeview.button0
       set TPtreeColTab {Column (-)}
      }
update
set TPtemp 0
set TPtemp2 [winfo width .tpTreeview]
wm geometry .tpTreeview ${TPtemp2}x10000
update idletasks
foreach TPwin [pack slaves .tpTreeview] {
	incr TPtemp [winfo height $TPwin]
            }
wm geometry .tpTreeview ${TPtemp2}x$TPtemp
} -font {Helvetica 12} -highlightthickness {0} -padx {0} -pady {0} -text {Column (+)} -textvariable {TPtreeColTab}
pack .tpTreeview.button0 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top

frame .tpTreeview.framecol -relief {raised} -height {30} -width {30}

frame .tpTreeview.framecol.frame12 -relief {raised} -height {30} -width {30}

label .tpTreeview.framecol.frame12.label9 -anchor {w} -borderwidth {0} -font {Helvetica 12} -relief {raised} -text {
Modify column:} -width {16}
pack .tpTreeview.framecol.frame12.label9 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

ttk::combobox .tpTreeview.framecol.frame12.combobox2 -values {One Two {Third Col}} -font {Helvetica 10} -textvariable {TPtree(Modify column)} -takefocus {ttk::takefocus}
.tpTreeview.framecol.frame12.combobox2 state {}
foreach eventName {<FocusOut> <Key-KP_Enter> <Key-Return> <<ComboboxSelected>>} {
	bind .tpTreeview.framecol.frame12.combobox2 $eventName {set TPtemp ${TPtree(Modify column)}
if {$TPtemp in [concat #0 $TPtree(-columns)]} {
    set {TPtree(Column anchor)} [$TPcurTree column $TPtemp -anchor]
    set {TPtree(Column minwidth)} [$TPcurTree column $TPtemp -minwidth]
    set {TPtree(Column stretch)} [$TPcurTree column $TPtemp -stretch]
    set {TPtree(Column width)} [$TPcurTree column $TPtemp -width]
    set {TPtree(Heading text)} [$TPcurTree heading $TPtemp -text]
    set {TPtree(Heading image)} [$TPcurTree heading $TPtemp -image]
    set {TPtree(Heading anchor)} [$TPcurTree heading $TPtemp -anchor]
    set {TPtree(Heading command)} [$TPcurTree heading $TPtemp -command]
   }}
      }

pack .tpTreeview.framecol.frame12.combobox2 -anchor w -expand 0 -fill x -ipadx 0 -ipady 0 -padx 1 -pady 0 -side top

pack .tpTreeview.framecol.frame12 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tpTreeview.framecol.frame12.label9 .tpTreeview.framecol.frame12.combobox2 -in .tpTreeview.framecol.frame12

frame .tpTreeview.framecol.frame0 -relief {raised} -height {30} -width {30}

label .tpTreeview.framecol.frame0.label9 -anchor {w} -borderwidth {0} -font {Helvetica 12} -relief {raised} -text {Column anchor:} -width {16}
pack .tpTreeview.framecol.frame0.label9 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

ttk::combobox .tpTreeview.framecol.frame0.combobox2 -values {n ne e se s sw w nw center} -font {Helvetica 10} -textvariable {TPtree(Column anchor)} -takefocus {ttk::takefocus}
.tpTreeview.framecol.frame0.combobox2 state {}
set cmd "set TPtemp \$\{TPtree(Modify column)\};catch \{\$TPcurTree column \$TPtemp -anchor \$\{TPtree(Column anchor)\}\}"
bind .tpTreeview.framecol.frame0.combobox2 <Key-KP_Enter> $cmd
bind .tpTreeview.framecol.frame0.combobox2 <Key-Return> $cmd
bind .tpTreeview.framecol.frame0.combobox2 <FocusOut> $cmd
bind .tpTreeview.framecol.frame0.combobox2 <<ComboboxSelected>> $cmd
pack .tpTreeview.framecol.frame0.combobox2 -anchor w -expand 0 -fill x -ipadx 0 -ipady 0 -padx 1 -pady 0 -side top

pack .tpTreeview.framecol.frame0 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tpTreeview.framecol.frame0.label9 .tpTreeview.framecol.frame0.combobox2 -in .tpTreeview.framecol.frame0

frame .tpTreeview.framecol.frame1 -relief {raised} -height {30} -width {30}

label .tpTreeview.framecol.frame1.label9 -anchor {w} -borderwidth {0} -font {Helvetica 12} -relief {raised} -text {Column minwidth:} -width {16}
pack .tpTreeview.framecol.frame1.label9 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left


spinbox .tpTreeview.framecol.frame1.spinbox11 -background {white} -command {set TPtemp ${TPtree(Modify column)}
catch {$TPcurTree column $TPtemp -minwidth ${TPtree(Column minwidth)}}} -font {Helvetica 10} -from {1.0} -textvariable {TPtree(Column minwidth)} -to {100000.0} -width {5}
bind .tpTreeview.framecol.frame1.spinbox11 <Key-KP_Enter> {set TPtemp ${TPtree(Modify column)}
catch {$TPcurTree column $TPtemp -minwidth ${TPtree(Column minwidth)}}}
bind .tpTreeview.framecol.frame1.spinbox11 <Key-Return> {set TPtemp ${TPtree(Modify column)}
catch {$TPcurTree column $TPtemp -minwidth ${TPtree(Column minwidth)}}}
bind .tpTreeview.framecol.frame1.spinbox11 <FocusOut> {set TPtemp ${TPtree(Modify column)}
catch {$TPcurTree column $TPtemp -minwidth ${TPtree(Column minwidth)}}}
pack .tpTreeview.framecol.frame1.spinbox11 -anchor center -expand 1 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

pack .tpTreeview.framecol.frame1 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tpTreeview.framecol.frame1.label9 .tpTreeview.framecol.frame1.spinbox11 -in .tpTreeview.framecol.frame1

frame .tpTreeview.framecol.frame2 -relief {raised} -height {30} -width {30}

label .tpTreeview.framecol.frame2.label9 -anchor {w} -borderwidth {0} -font {Helvetica 12} -relief {raised} -text {Column stretch:} -width {15}
pack .tpTreeview.framecol.frame2.label9 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

checkbutton .tpTreeview.framecol.frame2.checkbutton12 -anchor {w} -borderwidth {0} -command {set TPtemp ${TPtree(Modify column)}
catch {$TPcurTree column $TPtemp -stretch ${TPtree(Column stretch)}}} -font {Helvetica 10} -justify {left} -padx {4} -relief {raised} -variable {TPtree(Column stretch)}
pack .tpTreeview.framecol.frame2.checkbutton12 -anchor w -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

pack .tpTreeview.framecol.frame2 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tpTreeview.framecol.frame2.label9 .tpTreeview.framecol.frame2.checkbutton12 -in .tpTreeview.framecol.frame2

frame .tpTreeview.framecol.frame3 -relief {raised} -height {30} -width {30}

label .tpTreeview.framecol.frame3.label9 -anchor {w} -borderwidth {0} -font {Helvetica 12} -relief {raised} -text {Column width:} -width {16}
pack .tpTreeview.framecol.frame3.label9 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

spinbox .tpTreeview.framecol.frame3.spinbox11 -background {white} -command {set TPtemp ${TPtree(Modify column)}
catch {$TPcurTree column $TPtemp -width ${TPtree(Column width)}}
} -font {Helvetica 10} -from {1.0} -textvariable {TPtree(Column width)} -to {100000.0} -width {5}
bind .tpTreeview.framecol.frame3.spinbox11 <FocusOut> {set TPtemp ${TPtree(Modify column)}
catch {$TPcurTree column $TPtemp -width ${TPtree(Column width)}}}
bind .tpTreeview.framecol.frame3.spinbox11 <Key-Return> {set TPtemp ${TPtree(Modify column)}
catch {$TPcurTree column $TPtemp -width ${TPtree(Column width)}}}
bind .tpTreeview.framecol.frame3.spinbox11 <Key-KP_Enter> {set TPtemp ${TPtree(Modify column)}
catch {$TPcurTree column $TPtemp -width ${TPtree(Column width)}}}
pack .tpTreeview.framecol.frame3.spinbox11 -anchor center -expand 1 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

pack .tpTreeview.framecol.frame3 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tpTreeview.framecol.frame3.label9 .tpTreeview.framecol.frame3.spinbox11 -in .tpTreeview.framecol.frame3

frame .tpTreeview.framecol.frame4 -relief {raised} -height {30} -width {30}

label .tpTreeview.framecol.frame4.label9 -anchor {w} -borderwidth {0} -font {Helvetica 12} -relief {raised} -text {Heading text:} -width {16}
pack .tpTreeview.framecol.frame4.label9 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

entry .tpTreeview.framecol.frame4.entry10 -font {Helvetica 10} -textvariable {TPtree(Heading text)} -bg white
bind .tpTreeview.framecol.frame4.entry10 <Key-KP_Enter> {set TPtemp ${TPtree(Modify column)}
catch {$TPcurTree heading $TPtemp -text ${TPtree(Heading text)}}}
bind .tpTreeview.framecol.frame4.entry10 <Key-Return> {set TPtemp ${TPtree(Modify column)}
catch {$TPcurTree heading $TPtemp -text ${TPtree(Heading text)}}}
bind .tpTreeview.framecol.frame4.entry10 <FocusOut> {set TPtemp ${TPtree(Modify column)}
catch {$TPcurTree heading $TPtemp -text ${TPtree(Heading text)}}}
pack .tpTreeview.framecol.frame4.entry10 -anchor center -expand 1 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

pack .tpTreeview.framecol.frame4 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tpTreeview.framecol.frame4.label9 .tpTreeview.framecol.frame4.entry10 -in .tpTreeview.framecol.frame4

frame .tpTreeview.framecol.frame5 -relief {raised} -height {30} -width {30}

label .tpTreeview.framecol.frame5.label9 -anchor {w} -borderwidth {0} -font {Helvetica 12} -relief {raised} -text {Heading image:} -width {16}
pack .tpTreeview.framecol.frame5.label9 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

entry .tpTreeview.framecol.frame5.entry10 -font {Helvetica 10} -textvariable {TPtree(Heading image)} -bg white
bind .tpTreeview.framecol.frame5.entry10 <FocusOut> {catch {$TPcurTree heading ${TPtree(Modify column)} -image ${TPtree(Heading image)}}}
bind .tpTreeview.framecol.frame5.entry10 <Key-KP_Enter> {catch {$TPcurTree heading ${TPtree(Modify column)} -image ${TPtree(Heading image)}}}
bind .tpTreeview.framecol.frame5.entry10 <Key-Return> {catch {$TPcurTree heading ${TPtree(Modify column)} -image ${TPtree(Heading image)}}}
bind .tpTreeview.framecol.frame5.entry10 <Button-3> {set TPpropsInfo(propname) image
set TPpropsInfo(propval) ${TPtree(Heading image)}
set TPimgCmd "set \{TPtree(Heading image)\}"
set TPcfgCmd "$TPcurTree heading \$\{TPtree(Modify column)\} -image"
ShowWindow.tpimagesel}
pack .tpTreeview.framecol.frame5.entry10 -anchor center -expand 1 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

pack .tpTreeview.framecol.frame5 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tpTreeview.framecol.frame5.label9 .tpTreeview.framecol.frame5.entry10 -in .tpTreeview.framecol.frame5

frame .tpTreeview.framecol.frame6 -relief {raised} -height {30} -width {30}

label .tpTreeview.framecol.frame6.label9 -anchor {w} -borderwidth {0} -font {Helvetica 12} -relief {raised} -text {Heading anchor:} -width {16}
pack .tpTreeview.framecol.frame6.label9 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

ttk::combobox .tpTreeview.framecol.frame6.combobox2 -values {n ne e se s sw w nw center} -font {Helvetica 10} -textvariable {TPtree(Heading anchor)} -takefocus {ttk::takefocus}
.tpTreeview.framecol.frame6.combobox2 state {}
set cmd "set TPtemp \$\{TPtree(Modify column)\};catch \{\$TPcurTree heading \$TPtemp -anchor \$\{TPtree(Heading anchor)\}\}"
bind .tpTreeview.framecol.frame6.combobox2 <Key-KP_Enter> $cmd
bind .tpTreeview.framecol.frame6.combobox2 <Key-Return> $cmd
bind .tpTreeview.framecol.frame6.combobox2 <FocusOut> $cmd
bind .tpTreeview.framecol.frame6.combobox2 <<ComboboxSelected>> $cmd
pack .tpTreeview.framecol.frame6.combobox2 -anchor w -expand 0 -fill x -ipadx 0 -ipady 0 -padx 1 -pady 0 -side top

pack .tpTreeview.framecol.frame6 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tpTreeview.framecol.frame6.label9 .tpTreeview.framecol.frame6.combobox2 -in .tpTreeview.framecol.frame6

frame .tpTreeview.framecol.frame7 -relief {raised} -height {30} -width {30}

label .tpTreeview.framecol.frame7.label9 -anchor {w} -borderwidth {0} -font {Helvetica 12} -relief {raised} -text {Heading command:} -width {16}
pack .tpTreeview.framecol.frame7.label9 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

entry .tpTreeview.framecol.frame7.entry10 -font {Helvetica 10} -textvariable {TPtree(Heading command)} -bg white
bind .tpTreeview.framecol.frame7.entry10 <Key-KP_Enter> {set TPtemp ${TPtree(Modify column)}
catch {$TPcurTree heading $TPtemp -command ${TPtree(Heading command)}}}
bind .tpTreeview.framecol.frame7.entry10 <Key-Return> {set TPtemp ${TPtree(Modify column)}
catch {$TPcurTree heading $TPtemp -command ${TPtree(Heading command)}}}
bind .tpTreeview.framecol.frame7.entry10 <FocusOut> {set TPtemp ${TPtree(Modify column)}
catch {$TPcurTree heading $TPtemp -command ${TPtree(Heading command)}}}
pack .tpTreeview.framecol.frame7.entry10 -anchor center -expand 1 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

pack .tpTreeview.framecol.frame7 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tpTreeview.framecol.frame7.label9 .tpTreeview.framecol.frame7.entry10 -in .tpTreeview.framecol.frame7

pack .tpTreeview.framecol.frame12 .tpTreeview.framecol.frame0 .tpTreeview.framecol.frame1 .tpTreeview.framecol.frame2 .tpTreeview.framecol.frame3 .tpTreeview.framecol.frame4 .tpTreeview.framecol.frame5 .tpTreeview.framecol.frame6 .tpTreeview.framecol.frame7 -in .tpTreeview.framecol

pack .tpTreeview.frame2 .tpTreeview.button9 .tpTreeview.button0 -in .tpTreeview
TPendSrc.tpTreeview}

proc DestroyWindow.tpTreeview {} {
     catch {destroy .tpTreeview}
     return {}
}

proc TPendSrc.tpTreeview {} {
global TPcurTree
global TPtree
global TPtreeColTab
global TPtreeGenTab

wm iconphoto .tpTreeview tplogo16
if {[info exists TPcurTree]} {
     if {[winfo exists $TPcurTree]} {
         if {[TP_ClassGet $TPcurTree] eq {Treeview}} {
              foreach TPtemp [$TPcurTree configure] {
	           set TPtree([lindex $TPtemp 0]) [lindex $TPtemp end]
	       }
	      set {TPtree(Modify column)} {}
              .tpTreeview.framecol.frame12.combobox2 configure -values [concat {#0} $TPtree(-columns)]
              .tpTreeview.framecol.frame12.combobox2 set {}
              set TPtreeGenTab {General (+)}
              set TPtreeColTab {Column (+)}
            }
        }
   }}


proc ShowWindow.tpabout { args} {

  catch "destroy .tpabout"

  toplevel .tpabout   -borderwidth {2}  -background {black}  -highlightbackground {#dcdcdc}

  # Window manager configurations
  wm positionfrom .tpabout program
  wm sizefrom .tpabout program
  wm maxsize .tpabout 236 222
  wm minsize .tpabout 236 222
  wm protocol .tpabout WM_DELETE_WINDOW {DestroyWindow.tpabout}
  wm title .tpabout {About TKproE}


  frame .tpabout.frame1  -background {slategray2}  -height {26}  -highlightbackground {#dcdcdc}  -width {232}

  label .tpabout.frame1.label2  -activebackground {#dcdcdc}  -anchor {e}  -background {slategray2}  -borderwidth {2}  -font {Helvetica 12 bold}  -highlightbackground {#dcdcdc}  -text {Revision}

  label .tpabout.frame1.label0  -activebackground {#dcdcdc}  -anchor {w}  -background {slategray2}  -borderwidth {2}  -font {Helvetica 12 bold}  -highlightbackground {#dcdcdc}  -text {1.2}  -textvariable {TPinfo(revision)}

  label .tpabout.label4  -activebackground {#dcdcdc}  -background {slategray2}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {05/19/06}  -textvariable {TPinfo(revdate)}

  frame .tpabout.frame0  -relief {raised}  -background {slategray2}  -height {61}  -highlightbackground {#e6e7e6}  -width {287}

  canvas .tpabout.frame0.canvas44  -background {slategray2}  -height {128}  -highlightbackground {#ffffff}  -highlightthickness {0}  -relief {raised}  -width {240}

  frame .tpabout.frame2  -relief {raised}  -background {slategray2}  -height {43}  -highlightbackground {#e6e7e6}  -width {287}

  label .tpabout.frame2.label3  -activebackground {#dcdcdc}  -background {slategray2}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {by Dennis R. LaBelle}  -textvariable {TPinfo(credits)}
#LISSI
  label .tpabout.frame2.label_add1  -activebackground {#dcdcdc}  -anchor {center}  -background {slategray2}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {with additions by Vladimir Orlov}

  # pack master .tpabout.frame1
  pack configure .tpabout.frame1.label2  -expand 1  -fill x  -side left
  pack configure .tpabout.frame1.label0  -expand 1  -fill x  -side right

  # pack master .tpabout.frame0
  pack configure .tpabout.frame0.canvas44  -side bottom

  # pack master .tpabout.frame2
  pack configure .tpabout.frame2.label3  -fill x
#LISSI
  pack configure .tpabout.frame2.label_add1  -fill x

  # pack master .tpabout
  pack configure .tpabout.frame0  -anchor s  -expand 1  -fill both
  pack configure .tpabout.frame1  -fill x  -ipady 2
  pack configure .tpabout.label4  -fill x
  pack configure .tpabout.frame2  -expand 1  -fill both

  # build canvas items .tpabout.frame0.canvas44
  set xfTmpTag [.tpabout.frame0.canvas44 create image 120 0]
  .tpabout.frame0.canvas44 itemconfigure $xfTmpTag  -anchor {n}  -image {tplogo128}

EndSrc.tpabout
}

proc DestroyWindow.tpabout {} {
     catch "destroy .tpabout"
     update
}

proc EndSrc.tpabout {} {
wm iconphoto .tpabout tplogo16
wm title .tpabout "About [TP_GetConfig progname]"
.tpabout.frame0.canvas44 itemconfigure progname -text [TP_GetConfig progname]
}


proc ShowWindow.tpautosave { args} {

  catch "destroy .tpautosave"

  toplevel .tpautosave   -relief {raised}  -background {#e6e7e6}  -highlightbackground {#e6e7e6}

  # Window manager configurations
  wm positionfrom .tpautosave program
  wm sizefrom .tpautosave program
  wm maxsize .tpautosave 2560 1024
  wm minsize .tpautosave 436 48
  wm protocol .tpautosave WM_DELETE_WINDOW {DestroyWindow.tpautosave}
  wm title .tpautosave {TKproE - Automatic backup}


  label .tpautosave.label11  -activebackground {#e6e7e6}  -background {#e6e7e6}  -font {Helvetica 12 bold}  -foreground {blue}  -highlightbackground {#e6e7e6}  -text {Saving current application to temporary storage directory:}

  label .tpautosave.label12  -activebackground {#e6e7e6}  -background {#e6e7e6}  -font {Helvetica 10}  -highlightbackground {#e6e7e6}  -text {P:/tkproe/autosave}  -textvariable {TPsaveDir}

  # pack master .tpautosave
  pack configure .tpautosave.label11
  pack configure .tpautosave.label12

  wm iconphoto .tpautosave tplogo16
}

proc DestroyWindow.tpautosave {} {
     catch "destroy .tpautosave"
     update
}


proc ShowWindow.tpbindcv { args} {

  catch "destroy .tpbindcv"

  toplevel .tpbindcv   -relief {raised}  -background {#dcdcdc}  -highlightbackground {#dcdcdc}

  # Window manager configurations
  wm positionfrom .tpbindcv program
  wm sizefrom .tpbindcv program
  wm maxsize .tpbindcv 2560 1024
  wm minsize .tpbindcv 576 478
  wm protocol .tpbindcv WM_DELETE_WINDOW {.tpbindcv.frame.listbox1 delete 0 end
.tpbindcv.frame23.frame.text2 delete 1.0 end
set TPcvbindEvent {}
DestroyWindow.tpbindcv}
  wm title .tpbindcv {TKproE canvas object bindings}


  frame .tpbindcv.frame  -borderwidth {3}  -relief {ridge}  -background {steelblue4}  -height {150}  -highlightbackground {#dcdcdc}  -width {544}

  scrollbar .tpbindcv.frame.scrollbar3  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpbindcv.frame.listbox1 xview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -orient {horizontal}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}

  scrollbar .tpbindcv.frame.scrollbar2  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpbindcv.frame.listbox1 yview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}

  listbox .tpbindcv.frame.listbox1  -background {white}  -exportselection {0}  -font {Helvetica 10}  -height {4}  -highlightbackground {#ffffff}  -selectbackground {#547098}  -selectforeground {#ffffff}  -width {40}  -xscrollcommand {.tpbindcv.frame.scrollbar3 set}  -yscrollcommand {.tpbindcv.frame.scrollbar2 set}
  # bindings
  bind .tpbindcv.frame.listbox1 <<ListboxSelect>> {if {[%W curselection] != {}} {
    set TPcvbindEvent [%W get [%W curselection]]
    .tpbindcv.frame23.frame.text2 delete 1.0 end
    .tpbindcv.frame23.frame.text2 insert end [$TPcurCanvas bind $TPcanvasID $TPcvbindEvent]
   }}

  frame .tpbindcv.frame.frame23  -relief {raised}  -background {#dcdcdc}  -height {26}  -highlightbackground {#dcdcdc}  -width {538}

  label .tpbindcv.frame.frame23.label1  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 12 bold italic}  -highlightbackground {#dcdcdc}  -text {Currently bound events for:}

  label .tpbindcv.frame.frame23.label22  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {0}  -font {Helvetica 12}  -foreground {blue}  -highlightbackground {#dcdcdc}  -relief {raised}  -text {.toplevel3.frame0.canvas2}  -textvariable {TPcurCanvas}

  label .tpbindcv.frame.frame23.label0  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 12 bold italic}  -highlightbackground {#dcdcdc}  -text {ID =}

  label .tpbindcv.frame.frame23.label2  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {0}  -font {Helvetica 12}  -foreground {blue}  -highlightbackground {#dcdcdc}  -relief {raised}  -text {1}  -textvariable {TPcvbindID}

  frame .tpbindcv.frame23  -borderwidth {2}  -relief {ridge}  -background {#dcdcdc}  -height {368}  -highlightbackground {#dcdcdc}  -width {544}

  frame .tpbindcv.frame23.frame2  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {552}

  label .tpbindcv.frame23.frame2.label3  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Event description:}

  entry .tpbindcv.frame23.frame2.entry4  -background {OldLace}  -font {Helvetica 10}  -highlightbackground {#ffffff}  -insertbackground {black}  -relief {ridge}  -selectbackground {black}  -selectforeground {#ffffff}  -textvariable {TPcvbindEvent}

  button .tpbindcv.frame23.frame2.button1  -activebackground {gray75}  -background {#dcdcdc}  -command {set TPcvbindEvent {}}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -padx {5}  -pady {0}  -text {Clear}

  frame .tpbindcv.frame23.frame18  -borderwidth {2}  -relief {ridge}  -background {#dcdcdc}  -height {30}  -highlightbackground {#dcdcdc}  -width {483}

  frame .tpbindcv.frame23.frame18.frame  -background {#dcdcdc}  -highlightbackground {#dcdcdc}

  scrollbar .tpbindcv.frame23.frame18.frame.scrollbar2  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpbindcv.frame23.frame18.frame.listbox1 yview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}

  listbox .tpbindcv.frame23.frame18.frame.listbox1  -background {lightblue}  -font {Helvetica 10}  -height {4}  -highlightbackground {#ffffff}  -selectbackground {#547098}  -selectforeground {#ffffff}  -width {15}  -yscrollcommand {.tpbindcv.frame23.frame18.frame.scrollbar2 set}
  # bindings
  bind .tpbindcv.frame23.frame18.frame.listbox1 <<ListboxSelect>> {set TPcvbindEvent [TP_BindEventAdd $TPcvbindEvent [%W get [%W curselection]]]}

  label .tpbindcv.frame23.frame18.frame.label19  -activebackground {#dcdcdc}  -background {DarkSlateGray3}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -relief {raised}  -text {Modifier}

  frame .tpbindcv.frame23.frame18.frame20  -background {#dcdcdc}  -highlightbackground {#dcdcdc}

  scrollbar .tpbindcv.frame23.frame18.frame20.scrollbar2  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpbindcv.frame23.frame18.frame20.listbox1 yview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}

  listbox .tpbindcv.frame23.frame18.frame20.listbox1  -background {lightblue}  -font {Helvetica 10}  -height {4}  -highlightbackground {#ffffff}  -selectbackground {#547098}  -selectforeground {#ffffff}  -width {15}  -yscrollcommand {.tpbindcv.frame23.frame18.frame20.scrollbar2 set}
  # bindings
  bind .tpbindcv.frame23.frame18.frame20.listbox1 <<ListboxSelect>> {set TPcvbindEvent [TP_BindEventAdd $TPcvbindEvent [%W get [%W curselection]]]}

  label .tpbindcv.frame23.frame18.frame20.label19  -activebackground {#dcdcdc}  -background {DarkSlateGray3}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -relief {raised}  -text {Mouse Type}

  frame .tpbindcv.frame23.frame18.frame21  -background {#dcdcdc}  -highlightbackground {#dcdcdc}

  scrollbar .tpbindcv.frame23.frame18.frame21.scrollbar2  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpbindcv.frame23.frame18.frame21.listbox1 yview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}

  listbox .tpbindcv.frame23.frame18.frame21.listbox1  -background {lightblue}  -font {Helvetica 10}  -height {4}  -highlightbackground {#ffffff}  -selectbackground {#547098}  -selectforeground {#ffffff}  -width {15}  -yscrollcommand {.tpbindcv.frame23.frame18.frame21.scrollbar2 set}
  # bindings
  bind .tpbindcv.frame23.frame18.frame21.listbox1 <<ListboxSelect>> {set TPcvbindEvent [TP_BindEventAdd $TPcvbindEvent [%W get [%W curselection]]]}

  label .tpbindcv.frame23.frame18.frame21.label19  -activebackground {#dcdcdc}  -background {DarkSlateGray3}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -relief {raised}  -text {Key Type}

  frame .tpbindcv.frame23.frame18.frame22  -background {#dcdcdc}  -highlightbackground {#dcdcdc}

  scrollbar .tpbindcv.frame23.frame18.frame22.scrollbar2  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpbindcv.frame23.frame18.frame22.listbox1 yview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}

  listbox .tpbindcv.frame23.frame18.frame22.listbox1  -background {lightblue}  -font {Helvetica 10}  -height {4}  -highlightbackground {#ffffff}  -selectbackground {#547098}  -selectforeground {#ffffff}  -width {15}  -yscrollcommand {.tpbindcv.frame23.frame18.frame22.scrollbar2 set}
  # bindings
  bind .tpbindcv.frame23.frame18.frame22.listbox1 <<ListboxSelect>> {set TPcvbindEvent [TP_BindEventAdd $TPcvbindEvent [%W get [%W curselection]]]}

  label .tpbindcv.frame23.frame18.frame22.label19  -activebackground {#dcdcdc}  -background {DarkSlateGray3}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -relief {raised}  -text {Window Type}

  frame .tpbindcv.frame23.frame6  -relief {raised}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {620}

  button .tpbindcv.frame23.frame6.button9  -activebackground {gray75}  -background {#dcdcdc}  -command {if {[winfo exists $TPcurCanvas]} {
    if {[catch {$TPcurCanvas bind $TPcanvasID $TPcvbindEvent [.tpbindcv.frame23.frame.text2 get 1.0 end]} TPmessage]} {
        ShowWindow.tpmsgbox
        after 100 bell
       } { TP_BindListFill $::TPcurCanvas .tpbindcv.frame.listbox1 1 }
    }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Insert event}  -width {9}

  button .tpbindcv.frame23.frame6.button10  -activebackground {gray75}  -background {#dcdcdc}  -command {if {[winfo exists $TPcurCanvas]} {
    set TPtemp [.tpbindcv.frame.listbox1 curselection]
    if {[llength $TPtemp] == 1} {
        # Remove binding for currently selected event.
        $TPcurCanvas bind $TPcvbindID [.tpbindcv.frame.listbox1 get $TPtemp] {}
        TP_BindListFill $::TPcurCanvas .tpbindcv.frame.listbox1 1
        .tpbindcv.frame23.frame.text2 delete 1.0 end
        set TPcvbindEvent {}
       }
   }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Delete event}  -width {9}

  label .tpbindcv.frame23.label24  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 12 bold italic}  -highlightbackground {#dcdcdc}  -text {Current event:}

  frame .tpbindcv.frame23.frame  -borderwidth {3}  -relief {groove}  -background {black}  -height {136}  -highlightbackground {#dcdcdc}  -width {540}

  scrollbar .tpbindcv.frame23.frame.scrollbar1  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpbindcv.frame23.frame.text2 yview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}

  text .tpbindcv.frame23.frame.text2  -font {Helvetica 10}  -height {4}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -width {20}  -wrap {none}  -xscrollcommand {.tpbindcv.frame23.frame.scrollbar3 set}  -yscrollcommand {.tpbindcv.frame23.frame.scrollbar1 set}

  scrollbar .tpbindcv.frame23.frame.scrollbar3  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpbindcv.frame23.frame.text2 xview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -orient {horizontal}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}

  label .tpbindcv.frame23.frame.label1  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -relief {raised}  -text {The actions of the current event}

  entry .tpbindcv.frame23.entry45  -background {PeachPuff}  -disabledbackground {PeachPuff}  -disabledforeground {black}  -font {Helvetica 10}  -highlightbackground {#ffffff}  -justify {center}  -readonlybackground {PeachPuff}  -relief {ridge}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -state {readonly}  -textvariable {TPbindKeyMsg}
  # bindings
  bind .tpbindcv.frame23.entry45 <Enter> {focus %W}
  bind .tpbindcv.frame23.entry45 <Key> {set TPcvbindEvent [TP_BindEventAdd $TPcvbindEvent "Key-%K"]}
  bind .tpbindcv.frame23.entry45 <Leave> {focus .tpbindcv.frame23.frame2.entry4}

  frame .tpbindcv.frame32  -relief {ridge}  -background {#dcdcdc}  -height {30}  -highlightbackground {#dcdcdc}  -width {364}

  button .tpbindcv.frame32.button33  -activebackground {gray75}  -background {#dcdcdc}  -command {.tpbindcv.frame.listbox1 delete 0 end
.tpbindcv.frame23.frame.text2 delete 1.0 end
set TPbindEvent {}
DestroyWindow.tpbindcv}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Done}

  button .tpbindcv.frame32.button34  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_CVbindSnapshotRestore $TPcurCanvas $TPcvbindID
TP_BindListFill $::TPcurCanvas .tpbindcv.frame.listbox1 1}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Undo}

  button .tpbindcv.frame32.button35  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_CVbindSnapshotRestore $TPcurCanvas $TPcvbindID
.tpbindcv.frame23.frame.text2 delete 1.0 end
.tpbindcv.frame.listbox1 delete 0 end
DestroyWindow.tpbindcv}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Cancel}

  button .tpbindcv.frame32.button4  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_BindListFill $::TPcurCanvas .tpbindcv.frame.listbox1 1
.tpbindcv.frame23.frame.text2 delete 1.0 end
set TPcvbindEvent {}
TP_CVbindSnapshot $::TPcurCanvas $TPcvbindID}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {ReScan}

  # pack master .tpbindcv.frame
  pack configure .tpbindcv.frame.frame23  -fill x
  pack configure .tpbindcv.frame.scrollbar2  -fill y  -side left
  pack configure .tpbindcv.frame.listbox1  -expand 1  -fill both
  pack configure .tpbindcv.frame.scrollbar3  -fill x  -side bottom

  # pack master .tpbindcv.frame.frame23
  pack configure .tpbindcv.frame.frame23.label1  -fill x  -side left
  pack configure .tpbindcv.frame.frame23.label22  -side left
  pack configure .tpbindcv.frame.frame23.label2  -padx 2  -side right
  pack configure .tpbindcv.frame.frame23.label0  -side right

  # pack master .tpbindcv.frame23
  pack configure .tpbindcv.frame23.label24  -fill x
  pack configure .tpbindcv.frame23.frame2  -fill x
  pack configure .tpbindcv.frame23.frame18  -fill x
  pack configure .tpbindcv.frame23.entry45  -fill x
  pack configure .tpbindcv.frame23.frame  -fill both
  pack configure .tpbindcv.frame23.frame6  -fill x

  # pack master .tpbindcv.frame23.frame2
  pack configure .tpbindcv.frame23.frame2.label3  -side left
  pack configure .tpbindcv.frame23.frame2.entry4  -expand 1  -fill x  -side left
  pack configure .tpbindcv.frame23.frame2.button1

  # pack master .tpbindcv.frame23.frame18
  pack configure .tpbindcv.frame23.frame18.frame  -expand 1  -fill both  -side left
  pack configure .tpbindcv.frame23.frame18.frame20  -expand 1  -fill both  -side left
  pack configure .tpbindcv.frame23.frame18.frame21  -expand 1  -fill both  -side left
  pack configure .tpbindcv.frame23.frame18.frame22  -expand 1  -fill both  -side left

  # pack master .tpbindcv.frame23.frame18.frame
  pack configure .tpbindcv.frame23.frame18.frame.label19  -fill x
  pack configure .tpbindcv.frame23.frame18.frame.scrollbar2  -fill y  -side right
  pack configure .tpbindcv.frame23.frame18.frame.listbox1  -expand 1  -fill both

  # pack master .tpbindcv.frame23.frame18.frame20
  pack configure .tpbindcv.frame23.frame18.frame20.label19  -fill x
  pack configure .tpbindcv.frame23.frame18.frame20.scrollbar2  -fill y  -side right
  pack configure .tpbindcv.frame23.frame18.frame20.listbox1  -expand 1  -fill both

  # pack master .tpbindcv.frame23.frame18.frame21
  pack configure .tpbindcv.frame23.frame18.frame21.label19  -fill x
  pack configure .tpbindcv.frame23.frame18.frame21.scrollbar2  -fill y  -side right
  pack configure .tpbindcv.frame23.frame18.frame21.listbox1  -expand 1  -fill both

  # pack master .tpbindcv.frame23.frame18.frame22
  pack configure .tpbindcv.frame23.frame18.frame22.label19  -fill x
  pack configure .tpbindcv.frame23.frame18.frame22.scrollbar2  -fill y  -side right
  pack configure .tpbindcv.frame23.frame18.frame22.listbox1  -expand 1  -fill both

  # pack master .tpbindcv.frame23.frame6
  pack configure .tpbindcv.frame23.frame6.button9  -side left
  pack configure .tpbindcv.frame23.frame6.button10  -side right

  # pack master .tpbindcv.frame23.frame
  pack configure .tpbindcv.frame23.frame.label1  -fill x
  pack configure .tpbindcv.frame23.frame.scrollbar1  -fill y  -side left
  pack configure .tpbindcv.frame23.frame.text2  -expand 1  -fill both
  pack configure .tpbindcv.frame23.frame.scrollbar3  -fill x  -side bottom

  # pack master .tpbindcv.frame32
  pack configure .tpbindcv.frame32.button33  -side left
  pack configure .tpbindcv.frame32.button35  -side right
  pack configure .tpbindcv.frame32.button34  -side right
  pack configure .tpbindcv.frame32.button4  -side left

  # pack master .tpbindcv
  pack configure .tpbindcv.frame  -fill both
  pack configure .tpbindcv.frame23  -fill x  -pady 4
  pack configure .tpbindcv.frame32  -fill x  -side bottom

  .tpbindcv.frame23.frame18.frame.listbox1 insert end {Alt}
  .tpbindcv.frame23.frame18.frame.listbox1 insert end {B1}
  .tpbindcv.frame23.frame18.frame.listbox1 insert end {B2}
  .tpbindcv.frame23.frame18.frame.listbox1 insert end {B3}
  .tpbindcv.frame23.frame18.frame.listbox1 insert end {B4}
  .tpbindcv.frame23.frame18.frame.listbox1 insert end {B5}
  .tpbindcv.frame23.frame18.frame.listbox1 insert end {Control}
  .tpbindcv.frame23.frame18.frame.listbox1 insert end {Double}
  .tpbindcv.frame23.frame18.frame.listbox1 insert end {Lock}
  .tpbindcv.frame23.frame18.frame.listbox1 insert end {Meta}
  .tpbindcv.frame23.frame18.frame.listbox1 insert end {M1}
  .tpbindcv.frame23.frame18.frame.listbox1 insert end {M2}
  .tpbindcv.frame23.frame18.frame.listbox1 insert end {M3}
  .tpbindcv.frame23.frame18.frame.listbox1 insert end {M4}
  .tpbindcv.frame23.frame18.frame.listbox1 insert end {M5}
  .tpbindcv.frame23.frame18.frame.listbox1 insert end {Quadruple}
  .tpbindcv.frame23.frame18.frame.listbox1 insert end {Shift}
  .tpbindcv.frame23.frame18.frame.listbox1 insert end {Triple}
  .tpbindcv.frame23.frame18.frame20.listbox1 insert end {ButtonPress}
  .tpbindcv.frame23.frame18.frame20.listbox1 insert end {ButtonPress-1}
  .tpbindcv.frame23.frame18.frame20.listbox1 insert end {ButtonPress-2}
  .tpbindcv.frame23.frame18.frame20.listbox1 insert end {ButtonPress-3}
  .tpbindcv.frame23.frame18.frame20.listbox1 insert end {ButtonPress-4}
  .tpbindcv.frame23.frame18.frame20.listbox1 insert end {ButtonPress-5}
  .tpbindcv.frame23.frame18.frame20.listbox1 insert end {ButtonRelease}
  .tpbindcv.frame23.frame18.frame20.listbox1 insert end {ButtonRelease-1}
  .tpbindcv.frame23.frame18.frame20.listbox1 insert end {ButtonRelease-2}
  .tpbindcv.frame23.frame18.frame20.listbox1 insert end {ButtonRelease-3}
  .tpbindcv.frame23.frame18.frame20.listbox1 insert end {ButtonRelease-4}
  .tpbindcv.frame23.frame18.frame20.listbox1 insert end {ButtonRelease-5}
  .tpbindcv.frame23.frame18.frame20.listbox1 insert end {Motion}
  .tpbindcv.frame23.frame18.frame20.listbox1 insert end {MouseWheel}
  .tpbindcv.frame23.frame18.frame21.listbox1 insert end {KeyPress}
  .tpbindcv.frame23.frame18.frame21.listbox1 insert end {KeyRelease}
  .tpbindcv.frame23.frame18.frame22.listbox1 insert end {Activate}
  .tpbindcv.frame23.frame18.frame22.listbox1 insert end {Circulate}
  .tpbindcv.frame23.frame18.frame22.listbox1 insert end {CirculateRequest}
  .tpbindcv.frame23.frame18.frame22.listbox1 insert end {Colormap}
  .tpbindcv.frame23.frame18.frame22.listbox1 insert end {Configure}
  .tpbindcv.frame23.frame18.frame22.listbox1 insert end {ConfigureRequest}
  .tpbindcv.frame23.frame18.frame22.listbox1 insert end {Create}
  .tpbindcv.frame23.frame18.frame22.listbox1 insert end {Deactivate}
  .tpbindcv.frame23.frame18.frame22.listbox1 insert end {Destroy}
  .tpbindcv.frame23.frame18.frame22.listbox1 insert end {Enter}
  .tpbindcv.frame23.frame18.frame22.listbox1 insert end {Expose}
  .tpbindcv.frame23.frame18.frame22.listbox1 insert end {FocusIn}
  .tpbindcv.frame23.frame18.frame22.listbox1 insert end {FocusOut}
  .tpbindcv.frame23.frame18.frame22.listbox1 insert end {Gravity}
  .tpbindcv.frame23.frame18.frame22.listbox1 insert end {Leave}
  .tpbindcv.frame23.frame18.frame22.listbox1 insert end {Map}
  .tpbindcv.frame23.frame18.frame22.listbox1 insert end {MapRequest}
  .tpbindcv.frame23.frame18.frame22.listbox1 insert end {Property}
  .tpbindcv.frame23.frame18.frame22.listbox1 insert end {Reparent}
  .tpbindcv.frame23.frame18.frame22.listbox1 insert end {ResizeRequest}
  .tpbindcv.frame23.frame18.frame22.listbox1 insert end {Unmap}
  .tpbindcv.frame23.frame18.frame22.listbox1 insert end {Visibility}
  .tpbindcv.frame23.frame.text2 insert end {}



EndSrc.tpbindcv
}

proc DestroyWindow.tpbindcv {} {
    catch "destroy .tpbindcv"
    update
}

proc EndSrc.tpbindcv {} {
wm iconphoto .tpbindcv tplogo16
.tpbindcv.frame32.button4 invoke
}

proc ShowWindow.tpbinding { args} {

  catch "destroy .tpbinding"

  toplevel .tpbinding   -background {#dcdcdc}  -highlightbackground {#dcdcdc}

  # Window manager configurations
  wm positionfrom .tpbinding program
  wm sizefrom .tpbinding program
  wm maxsize .tpbinding 1000 1000
  wm minsize .tpbinding 576 478
  wm protocol .tpbinding WM_DELETE_WINDOW {.tpbinding.frame.listbox1 delete 0 end
.tpbinding.frame23.frame.text2 delete 1.0 end
DestroyWindow.tpbinding}
  wm title .tpbinding {TKproE widget bindings}


  frame .tpbinding.frame  -borderwidth {3}  -relief {ridge}  -background {steelblue4}  -height {150}  -highlightbackground {#dcdcdc}  -width {544}

  scrollbar .tpbinding.frame.scrollbar3  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpbinding.frame.listbox1 xview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -orient {horizontal}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}

  scrollbar .tpbinding.frame.scrollbar2  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpbinding.frame.listbox1 yview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}

  listbox .tpbinding.frame.listbox1  -background {white}  -exportselection {0}  -font {Helvetica 10}  -height {4}  -highlightbackground {#ffffff}  -selectbackground {#547098}  -selectforeground {#ffffff}  -width {40}  -xscrollcommand {.tpbinding.frame.scrollbar3 set}  -yscrollcommand {.tpbinding.frame.scrollbar2 set}
  # bindings
  bind .tpbinding.frame.listbox1 <<ListboxSelect>> {if {[%W curselection] != {}} {
    set TPbindEvent [%W get [%W curselection]]
    .tpbinding.frame23.frame.text2 delete 1.0 end
    .tpbinding.frame23.frame.text2 insert end [bind $TPcurWidget $TPbindEvent]
   }}

  frame .tpbinding.frame.frame23  -relief {raised}  -background {#dcdcdc}  -height {26}  -highlightbackground {#dcdcdc}  -width {538}

  label .tpbinding.frame.frame23.label1  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 12 bold italic}  -highlightbackground {#dcdcdc}  -text {Currently bound events for:}

  label .tpbinding.frame.frame23.label22  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {0}  -font {Helvetica 12}  -foreground {blue}  -highlightbackground {#dcdcdc}  -relief {raised}  -text {.}  -textvariable {TPcurWidget}

  frame .tpbinding.frame23  -borderwidth {2}  -relief {ridge}  -background {#dcdcdc}  -height {368}  -highlightbackground {#dcdcdc}  -width {544}

  frame .tpbinding.frame23.frame2  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {552}

  label .tpbinding.frame23.frame2.label3  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Event description:}

  entry .tpbinding.frame23.frame2.entry4  -background {OldLace}  -font {Helvetica 10}  -highlightbackground {#ffffff}  -insertbackground {black}  -relief {ridge}  -selectbackground {black}  -selectforeground {#ffffff}  -textvariable {TPbindEvent}

  button .tpbinding.frame23.frame2.button1  -activebackground {gray75}  -background {#dcdcdc}  -command {set TPbindEvent {}}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -padx {5}  -pady {0}  -text {Clear}

  frame .tpbinding.frame23.frame18  -borderwidth {2}  -relief {ridge}  -background {#dcdcdc}  -height {30}  -highlightbackground {#dcdcdc}  -width {483}

  frame .tpbinding.frame23.frame18.frame  -background {#dcdcdc}  -highlightbackground {#dcdcdc}

  scrollbar .tpbinding.frame23.frame18.frame.scrollbar2  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpbinding.frame23.frame18.frame.listbox1 yview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}

  listbox .tpbinding.frame23.frame18.frame.listbox1  -background {lightblue}  -font {Helvetica 10}  -height {4}  -highlightbackground {#ffffff}  -selectbackground {#547098}  -selectforeground {#ffffff}  -width {15}  -yscrollcommand {.tpbinding.frame23.frame18.frame.scrollbar2 set}
  # bindings
  bind .tpbinding.frame23.frame18.frame.listbox1 <<ListboxSelect>> {set TPbindEvent [TP_BindEventAdd $TPbindEvent [%W get [%W curselection]]]}

  label .tpbinding.frame23.frame18.frame.label19  -activebackground {#dcdcdc}  -background {DarkSlateGray3}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -relief {raised}  -text {Modifier}

  frame .tpbinding.frame23.frame18.frame20  -background {#dcdcdc}  -highlightbackground {#dcdcdc}

  scrollbar .tpbinding.frame23.frame18.frame20.scrollbar2  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpbinding.frame23.frame18.frame20.listbox1 yview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}

  listbox .tpbinding.frame23.frame18.frame20.listbox1  -background {lightblue}  -font {Helvetica 10}  -height {4}  -highlightbackground {#ffffff}  -selectbackground {#547098}  -selectforeground {#ffffff}  -width {15}  -yscrollcommand {.tpbinding.frame23.frame18.frame20.scrollbar2 set}
  # bindings
  bind .tpbinding.frame23.frame18.frame20.listbox1 <<ListboxSelect>> {set TPbindEvent [TP_BindEventAdd $TPbindEvent [%W get [%W curselection]]]}

  label .tpbinding.frame23.frame18.frame20.label19  -activebackground {#dcdcdc}  -background {DarkSlateGray3}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -relief {raised}  -text {Mouse Type}

  frame .tpbinding.frame23.frame18.frame21  -background {#dcdcdc}  -highlightbackground {#dcdcdc}

  scrollbar .tpbinding.frame23.frame18.frame21.scrollbar2  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpbinding.frame23.frame18.frame21.listbox1 yview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}

  listbox .tpbinding.frame23.frame18.frame21.listbox1  -background {lightblue}  -font {Helvetica 10}  -height {4}  -highlightbackground {#ffffff}  -selectbackground {#547098}  -selectforeground {#ffffff}  -width {15}  -yscrollcommand {.tpbinding.frame23.frame18.frame21.scrollbar2 set}
  # bindings
  bind .tpbinding.frame23.frame18.frame21.listbox1 <<ListboxSelect>> {set TPbindEvent [TP_BindEventAdd $TPbindEvent [%W get [%W curselection]]]}

  label .tpbinding.frame23.frame18.frame21.label19  -activebackground {#dcdcdc}  -background {DarkSlateGray3}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -relief {raised}  -text {Key Type}

  frame .tpbinding.frame23.frame18.frame22  -background {#dcdcdc}  -highlightbackground {#dcdcdc}

  scrollbar .tpbinding.frame23.frame18.frame22.scrollbar2  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpbinding.frame23.frame18.frame22.listbox1 yview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}

  listbox .tpbinding.frame23.frame18.frame22.listbox1  -background {lightblue}  -font {Helvetica 10}  -height {4}  -highlightbackground {#ffffff}  -selectbackground {#547098}  -selectforeground {#ffffff}  -width {15}  -yscrollcommand {.tpbinding.frame23.frame18.frame22.scrollbar2 set}
  # bindings
  bind .tpbinding.frame23.frame18.frame22.listbox1 <<ListboxSelect>> {set TPbindEvent [TP_BindEventAdd $TPbindEvent [%W get [%W curselection]]]}

  label .tpbinding.frame23.frame18.frame22.label19  -activebackground {#dcdcdc}  -background {DarkSlateGray3}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -relief {raised}  -text {Window Type}

  frame .tpbinding.frame23.frame6  -relief {raised}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {620}

  button .tpbinding.frame23.frame6.button9  -activebackground {gray75}  -background {#dcdcdc}  -command {if {[winfo exists $TPcurWidget]} {
    if {[catch {bind $TPcurWidget $TPbindEvent [.tpbinding.frame23.frame.text2 get 1.0 end]} TPmessage]} {
	ShowWindow.tpmsgbox
	after 100 bell
       } {
	  TP_BindListFill $::TPcurWidget .tpbinding.frame.listbox1
         }
   }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Insert event}  -width {9}

  button .tpbinding.frame23.frame6.button10  -activebackground {gray75}  -background {#dcdcdc}  -command {set TPtemp [.tpbinding.frame.listbox1 curselection]
if {[llength $TPtemp] == 1} {
    # Remove binding for currently selected event.
    if {[winfo exists $TPcurWidget]} {
        bind $TPcurWidget [.tpbinding.frame.listbox1 get $TPtemp] {}
        TP_BindListFill $::TPcurWidget .tpbinding.frame.listbox1
      }
   }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Delete event}  -width {9}

  label .tpbinding.frame23.label24  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 12 bold italic}  -highlightbackground {#dcdcdc}  -text {Current event:}

  frame .tpbinding.frame23.frame  -borderwidth {3}  -relief {ridge}  -background {#dcdcdc}  -height {136}  -highlightbackground {#dcdcdc}  -width {540}

  scrollbar .tpbinding.frame23.frame.scrollbar1  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpbinding.frame23.frame.text2 yview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}

  text .tpbinding.frame23.frame.text2  -font {Helvetica 10}  -height {4}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -width {20}  -wrap {none}  -xscrollcommand {.tpbinding.frame23.frame.scrollbar3 set}  -yscrollcommand {.tpbinding.frame23.frame.scrollbar1 set}

  scrollbar .tpbinding.frame23.frame.scrollbar3  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpbinding.frame23.frame.text2 xview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -orient {horizontal}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}

  label .tpbinding.frame23.frame.label1  -activebackground {#dcdcdc}  -background {#dcdcdc}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -relief {raised}  -text {The actions of the current event}

  entry .tpbinding.frame23.entry45  -background {PeachPuff}  -disabledbackground {PeachPuff}  -disabledforeground {black}  -font {Helvetica 10}  -highlightbackground {#ffffff}  -justify {center}  -readonlybackground {PeachPuff}  -relief {ridge}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -state {readonly}  -textvariable {TPbindKeyMsg}
  # bindings
  bind .tpbinding.frame23.entry45 <Enter> {focus %W}
  bind .tpbinding.frame23.entry45 <Key> {set TPbindEvent [TP_BindEventAdd $TPbindEvent "Key-%K"]}
  bind .tpbinding.frame23.entry45 <Leave> {focus .tpbinding.frame23.frame2.entry4}

  frame .tpbinding.frame32  -relief {ridge}  -background {#dcdcdc}  -height {30}  -highlightbackground {#dcdcdc}  -width {364}

  button .tpbinding.frame32.button33  -activebackground {gray75}  -background {#dcdcdc}  -command {.tpbinding.frame.listbox1 delete 0 end
.tpbinding.frame23.frame.text2 delete 1.0 end
set TPbindEvent {}
DestroyWindow.tpbinding}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Done}

  button .tpbinding.frame32.button34  -activebackground {gray75}  -background {#dcdcdc}  -command {if {[winfo exists $TPcurWidget]} {
    TP_BindSnapshotRestore $TPcurWidget
    TP_BindListFill $::TPcurWidget .tpbinding.frame.listbox1
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Undo}

  button .tpbinding.frame32.button35  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_BindSnapshotRestore $TPcurWidget
.tpbinding.frame23.frame.text2 delete 1.0 end
.tpbinding.frame.listbox1 delete 0 end
DestroyWindow.tpbinding}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Cancel}

  button .tpbinding.frame32.button4  -activebackground {gray75}  -background {#dcdcdc}  -command {if {[winfo exists $TPcurWidget]} {
   TP_BindListFill $::TPcurWidget .tpbinding.frame.listbox1
   TP_BindSnapshot $::TPcurWidget
   }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {ReScan}

  # pack master .tpbinding.frame
  pack configure .tpbinding.frame.frame23  -fill x
  pack configure .tpbinding.frame.scrollbar2  -fill y  -side left
  pack configure .tpbinding.frame.listbox1  -expand 1  -fill both
  pack configure .tpbinding.frame.scrollbar3  -fill x  -side bottom

  # pack master .tpbinding.frame.frame23
  pack configure .tpbinding.frame.frame23.label1  -fill x  -side left
  pack configure .tpbinding.frame.frame23.label22  -side left

  # pack master .tpbinding.frame23
  pack configure .tpbinding.frame23.label24  -fill x
  pack configure .tpbinding.frame23.frame2  -fill x
  pack configure .tpbinding.frame23.frame18  -fill x
  pack configure .tpbinding.frame23.entry45  -fill x
  pack configure .tpbinding.frame23.frame  -expand 1  -fill both
  pack configure .tpbinding.frame23.frame6  -fill x

  # pack master .tpbinding.frame23.frame2
  pack configure .tpbinding.frame23.frame2.label3  -side left
  pack configure .tpbinding.frame23.frame2.entry4  -expand 1  -fill x  -side left
  pack configure .tpbinding.frame23.frame2.button1

  # pack master .tpbinding.frame23.frame18
  pack configure .tpbinding.frame23.frame18.frame  -expand 1  -fill both  -side left
  pack configure .tpbinding.frame23.frame18.frame20  -expand 1  -fill both  -side left
  pack configure .tpbinding.frame23.frame18.frame21  -expand 1  -fill both  -side left
  pack configure .tpbinding.frame23.frame18.frame22  -expand 1  -fill both  -side left

  # pack master .tpbinding.frame23.frame18.frame
  pack configure .tpbinding.frame23.frame18.frame.label19  -fill x
  pack configure .tpbinding.frame23.frame18.frame.scrollbar2  -fill y  -side right
  pack configure .tpbinding.frame23.frame18.frame.listbox1  -expand 1  -fill both

  # pack master .tpbinding.frame23.frame18.frame20
  pack configure .tpbinding.frame23.frame18.frame20.label19  -fill x
  pack configure .tpbinding.frame23.frame18.frame20.scrollbar2  -fill y  -side right
  pack configure .tpbinding.frame23.frame18.frame20.listbox1  -expand 1  -fill both

  # pack master .tpbinding.frame23.frame18.frame21
  pack configure .tpbinding.frame23.frame18.frame21.label19  -fill x
  pack configure .tpbinding.frame23.frame18.frame21.scrollbar2  -fill y  -side right
  pack configure .tpbinding.frame23.frame18.frame21.listbox1  -expand 1  -fill both

  # pack master .tpbinding.frame23.frame18.frame22
  pack configure .tpbinding.frame23.frame18.frame22.label19  -fill x
  pack configure .tpbinding.frame23.frame18.frame22.scrollbar2  -fill y  -side right
  pack configure .tpbinding.frame23.frame18.frame22.listbox1  -expand 1  -fill both

  # pack master .tpbinding.frame23.frame6
  pack configure .tpbinding.frame23.frame6.button9  -side left
  pack configure .tpbinding.frame23.frame6.button10  -side right

  # pack master .tpbinding.frame23.frame
  pack configure .tpbinding.frame23.frame.label1  -fill x
  pack configure .tpbinding.frame23.frame.scrollbar1  -fill y  -side left
  pack configure .tpbinding.frame23.frame.text2  -expand 1  -fill both
  pack configure .tpbinding.frame23.frame.scrollbar3  -fill x  -side bottom

  # pack master .tpbinding.frame32
  pack configure .tpbinding.frame32.button33  -side left
  pack configure .tpbinding.frame32.button35  -side right
  pack configure .tpbinding.frame32.button34  -side right
  pack configure .tpbinding.frame32.button4  -side left

  # pack master .tpbinding
  pack configure .tpbinding.frame  -fill both
  pack configure .tpbinding.frame23  -expand 1  -fill both  -pady 4
  pack configure .tpbinding.frame32  -fill x  -side bottom

  .tpbinding.frame23.frame18.frame.listbox1 insert end {Alt}
  .tpbinding.frame23.frame18.frame.listbox1 insert end {B1}
  .tpbinding.frame23.frame18.frame.listbox1 insert end {B2}
  .tpbinding.frame23.frame18.frame.listbox1 insert end {B3}
  .tpbinding.frame23.frame18.frame.listbox1 insert end {B4}
  .tpbinding.frame23.frame18.frame.listbox1 insert end {B5}
  .tpbinding.frame23.frame18.frame.listbox1 insert end {Control}
  .tpbinding.frame23.frame18.frame.listbox1 insert end {Double}
  .tpbinding.frame23.frame18.frame.listbox1 insert end {Lock}
  .tpbinding.frame23.frame18.frame.listbox1 insert end {Meta}
  .tpbinding.frame23.frame18.frame.listbox1 insert end {M1}
  .tpbinding.frame23.frame18.frame.listbox1 insert end {M2}
  .tpbinding.frame23.frame18.frame.listbox1 insert end {M3}
  .tpbinding.frame23.frame18.frame.listbox1 insert end {M4}
  .tpbinding.frame23.frame18.frame.listbox1 insert end {M5}
  .tpbinding.frame23.frame18.frame.listbox1 insert end {Quadruple}
  .tpbinding.frame23.frame18.frame.listbox1 insert end {Shift}
  .tpbinding.frame23.frame18.frame.listbox1 insert end {Triple}
  .tpbinding.frame23.frame18.frame20.listbox1 insert end {ButtonPress}
  .tpbinding.frame23.frame18.frame20.listbox1 insert end {ButtonPress-1}
  .tpbinding.frame23.frame18.frame20.listbox1 insert end {ButtonPress-2}
  .tpbinding.frame23.frame18.frame20.listbox1 insert end {ButtonPress-3}
  .tpbinding.frame23.frame18.frame20.listbox1 insert end {ButtonPress-4}
  .tpbinding.frame23.frame18.frame20.listbox1 insert end {ButtonPress-5}
  .tpbinding.frame23.frame18.frame20.listbox1 insert end {ButtonRelease}
  .tpbinding.frame23.frame18.frame20.listbox1 insert end {ButtonRelease-1}
  .tpbinding.frame23.frame18.frame20.listbox1 insert end {ButtonRelease-2}
  .tpbinding.frame23.frame18.frame20.listbox1 insert end {ButtonRelease-3}
  .tpbinding.frame23.frame18.frame20.listbox1 insert end {ButtonRelease-4}
  .tpbinding.frame23.frame18.frame20.listbox1 insert end {ButtonRelease-5}
  .tpbinding.frame23.frame18.frame20.listbox1 insert end {Motion}
  .tpbinding.frame23.frame18.frame20.listbox1 insert end {MouseWheel}
  .tpbinding.frame23.frame18.frame21.listbox1 insert end {KeyPress}
  .tpbinding.frame23.frame18.frame21.listbox1 insert end {KeyRelease}
  .tpbinding.frame23.frame18.frame22.listbox1 insert end {Activate}
  .tpbinding.frame23.frame18.frame22.listbox1 insert end {Circulate}
  .tpbinding.frame23.frame18.frame22.listbox1 insert end {CirculateRequest}
  .tpbinding.frame23.frame18.frame22.listbox1 insert end {Colormap}
  .tpbinding.frame23.frame18.frame22.listbox1 insert end {Configure}
  .tpbinding.frame23.frame18.frame22.listbox1 insert end {ConfigureRequest}
  .tpbinding.frame23.frame18.frame22.listbox1 insert end {Create}
  .tpbinding.frame23.frame18.frame22.listbox1 insert end {Deactivate}
  .tpbinding.frame23.frame18.frame22.listbox1 insert end {Destroy}
  .tpbinding.frame23.frame18.frame22.listbox1 insert end {Enter}
  .tpbinding.frame23.frame18.frame22.listbox1 insert end {Expose}
  .tpbinding.frame23.frame18.frame22.listbox1 insert end {FocusIn}
  .tpbinding.frame23.frame18.frame22.listbox1 insert end {FocusOut}
  .tpbinding.frame23.frame18.frame22.listbox1 insert end {Gravity}
  .tpbinding.frame23.frame18.frame22.listbox1 insert end {Leave}
  .tpbinding.frame23.frame18.frame22.listbox1 insert end {Map}
  .tpbinding.frame23.frame18.frame22.listbox1 insert end {MapRequest}
  .tpbinding.frame23.frame18.frame22.listbox1 insert end {Property}
  .tpbinding.frame23.frame18.frame22.listbox1 insert end {Reparent}
  .tpbinding.frame23.frame18.frame22.listbox1 insert end {ResizeRequest}
  .tpbinding.frame23.frame18.frame22.listbox1 insert end {Unmap}
  .tpbinding.frame23.frame18.frame22.listbox1 insert end {Visibility}
  .tpbinding.frame23.frame.text2 insert end {}



EndSrc.tpbinding
}

proc DestroyWindow.tpbinding {} {
     catch "destroy .tpbinding"
     update
}

proc EndSrc.tpbinding {} {
wm iconphoto .tpbinding tplogo16
if {[winfo exists $::TPcurPath]} {
    set ::TPcurWidget $::TPcurPath
    TP_BindListFill $::TPcurPath .tpbinding.frame.listbox1
    TP_BindSnapshot $::TPcurWidget
  } { after 100 DestroyWindow.tpbinding }
}


proc ShowWindow.tpcanvas { args} {

  catch "destroy .tpcanvas"

  toplevel .tpcanvas   -background {#dcdcdc}  -highlightbackground {#dcdcdc}

  # Window manager configurations
  wm positionfrom .tpcanvas program
  wm sizefrom .tpcanvas program
  wm maxsize .tpcanvas 2560 1024
  wm minsize .tpcanvas 675 364
  wm geometry .tpcanvas 680x500+130+60
  wm protocol .tpcanvas WM_DELETE_WINDOW {.tpcanvas.frame30.listbox1 delete 0 end
.tpcanvas.frame2.frame21.frame.text2 delete 1.0 end
TP_ToolChoose cancel
set TPcurCanvasPoint 0
DestroyWindow.tpcanvas}
  wm title .tpcanvas {TKproE canvas configuration}

  # bindings
  bind .tpcanvas <ButtonRelease-1> {TP_ProcessClick %W %X %Y %x %y}
  bind .tpcanvas <Shift-Button-3> {TP_PropsSelWidget %W}

  frame .tpcanvas.frame0  -borderwidth {2}  -relief {ridge}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {364}

  label .tpcanvas.frame0.label1  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {2}  -cursor {question_arrow}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Canvas name:}
  # bindings
  bind .tpcanvas.frame0.label1 <ButtonRelease-3> {set TPtemp [winfo containing %X %Y]
if {($TPtemp != "") && ([string range $TPtemp 0 2] != ".tp")} {
    if {[TP_ClassGet $TPtemp] == {Canvas}} {
        TP_CanvasSelect $TPtemp
        EndSrc.tpcanvas
       }
   }}

  label .tpcanvas.frame0.label2  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -foreground {blue}  -highlightbackground {#dcdcdc}  -text {.toplevel3.frame0.canvas2}  -textvariable {TPcurCanvas}
#LISSI
button .tpcanvas.frame0.buttonSCR -activebackground {#eeeeee} -background {grey85} -command {TP_SaveCaptureWindow $TPcurCanvas} -font {Helvetica 10} -highlightbackground {#eeeeee} -highlightthickness {0} -pady {1} -text {Screenshot}
pack .tpcanvas.frame0.buttonSCR -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

  button .tpcanvas.frame0.button1  -activebackground {gray75}  -background {#dcdcdc}  -command {if {[winfo exists $TPcurCanvas]} {
    set TPcurWidget $TPcurCanvas
    ShowWindow.tpproperties
   }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {More}  -width {5}

  frame .tpcanvas.frame2  -borderwidth {2}  -relief {ridge}  -background {#dcdcdc}  -height {144}  -highlightbackground {#dcdcdc}  -width {155}

  label .tpcanvas.frame2.label3  -activebackground {#dcdcdc}  -background {slategray3}  -font {Helvetica 10 bold}  -highlightbackground {#dcdcdc}  -relief {raised}  -text {Current object}

  frame .tpcanvas.frame2.frame4  -borderwidth {2}  -background {#dcdcdc}  -height {28}  -highlightbackground {#dcdcdc}  -width {147}

  label .tpcanvas.frame2.frame4.label5  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10 bold}  -highlightbackground {#dcdcdc}  -text {Type: }  -width {11}

  menubutton .tpcanvas.frame2.frame4.menubutton6  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -indicatoron {1}  -menu {.tpcanvas.frame2.frame4.menubutton6.m}  -padx {5}  -pady {4}  -relief {raised}  -text {Arc}  -textvariable {TPcurCanvasObjType}  -width {8}

  menu .tpcanvas.frame2.frame4.menubutton6.m  -activebackground {#dcdcdc}  -background {#dcdcdc}  -font {Helvetica 10}  -tearoff {0}
  .tpcanvas.frame2.frame4.menubutton6.m add command  -command {TP_CanvasTypeSel Arc
.tpcanvas.frame30.listbox1 selection clear 0 end}  -label {Arc}
  .tpcanvas.frame2.frame4.menubutton6.m add command  -command {TP_CanvasTypeSel Bitmap
.tpcanvas.frame30.listbox1 selection clear 0 end}  -label {Bitmap}
  .tpcanvas.frame2.frame4.menubutton6.m add command  -command {TP_CanvasTypeSel Image
.tpcanvas.frame30.listbox1 selection clear 0 end}  -label {Image}
  .tpcanvas.frame2.frame4.menubutton6.m add command  -command {TP_CanvasTypeSel Line
.tpcanvas.frame30.listbox1 selection clear 0 end}  -label {Line}
  .tpcanvas.frame2.frame4.menubutton6.m add command  -command {TP_CanvasTypeSel Oval
.tpcanvas.frame30.listbox1 selection clear 0 end}  -label {Oval}
  .tpcanvas.frame2.frame4.menubutton6.m add command  -command {TP_CanvasTypeSel Polygon
.tpcanvas.frame30.listbox1 selection clear 0 end}  -label {Polygon}
  .tpcanvas.frame2.frame4.menubutton6.m add command  -command {TP_CanvasTypeSel Rectangle
.tpcanvas.frame30.listbox1 selection clear 0 end}  -label {Rectangle}
  .tpcanvas.frame2.frame4.menubutton6.m add command  -command {TP_CanvasTypeSel Text
.tpcanvas.frame30.listbox1 selection clear 0 end}  -label {Text}
  .tpcanvas.frame2.frame4.menubutton6.m add command  -command {TP_CanvasTypeSel Window
.tpcanvas.frame30.listbox1 selection clear 0 end}  -label {Window}
#LISSI
#  checkbutton .tpcanvas.frame2.frame4.checkbutton0  -activebackground {#dcdcdc}  -background {#dcdcdc}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {rounded}  -variable {TPrectRound}
  spinbox .tpcanvas.frame2.frame4.checkbutton0 -from -25 -to +25 -state normal  -textvariable {TPrectRound} -justify right -width 3
  label .tpcanvas.frame2.frame4.typerect -text {+round/-bavel}

  frame .tpcanvas.frame2.frame15  -borderwidth {2}  -background {#dcdcdc}  -height {26}  -highlightbackground {#dcdcdc}  -width {221}

  label .tpcanvas.frame2.frame15.label5  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10 bold}  -highlightbackground {#dcdcdc}  -text {Tags: }  -width {11}

  entry .tpcanvas.frame2.frame15.entry13  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -textvariable {TPcurCanvasObjTags}  -width {31}
  # bindings
  bind .tpcanvas.frame2.frame15.entry13 <FocusOut> {if {[winfo exists $TPcurCanvas]} {
    if {$TPcanvasID != {}} {
    
         $TPcurCanvas itemconfigure $TPcanvasID -tags $TPcurCanvasObjTags
       }
   }}
  bind .tpcanvas.frame2.frame15.entry13 <Key-KP_Enter> {if {[winfo exists $TPcurCanvas]} {
    if {$TPcanvasID != {}} {
         $TPcurCanvas itemconfigure $TPcanvasID -tags $TPcurCanvasObjTags
       }
   }}
  bind .tpcanvas.frame2.frame15.entry13 <Key-Return> {if {[winfo exists $TPcurCanvas]} {
    if {$TPcanvasID != {}} {
         $TPcurCanvas itemconfigure $TPcanvasID -tags $TPcurCanvasObjTags
       }
   }}

  frame .tpcanvas.frame2.frame21  -borderwidth {2}  -relief {ridge}  -background {#dcdcdc}  -height {128}  -highlightbackground {#dcdcdc}  -width {345}

  frame .tpcanvas.frame2.frame21.frame  -borderwidth {1}  -relief {raised}  -background {#dcdcdc}  -height {100}  -highlightbackground {#dcdcdc}  -width {190}

#LISSI
#  scrollbar .tpcanvas.frame2.frame21.frame.scrollbar1  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpcanvas.frame2.frame21.frame.text2 yview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}
  ttk::scrollbar .tpcanvas.frame2.frame21.frame.scrollbar1 -command {.tpcanvas.frame2.frame21.frame.text2 yview}

  text .tpcanvas.frame2.frame21.frame.text2  -font {Helvetica 10}  -height {5}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -width {24}  -wrap {word}  -yscrollcommand {.tpcanvas.frame2.frame21.frame.scrollbar1 set}

  frame .tpcanvas.frame2.frame21.frame.frame21  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {190}

  label .tpcanvas.frame2.frame21.frame.frame21.label23  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {X}

  spinbox .tpcanvas.frame2.frame21.frame.frame21.spinbox1

  .tpcanvas.frame2.frame21.frame.frame21.spinbox1 config  -background {linen}  -buttonbackground {#dcdcdc}  -font {Helvetica 10}  -from {-10000.0}  -textvariable {TPcurCanvasObjXpos}  -to {10000.0}  -width {4}

  label .tpcanvas.frame2.frame21.frame.frame21.label24  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Y}

  spinbox .tpcanvas.frame2.frame21.frame.frame21.spinbox25

  .tpcanvas.frame2.frame21.frame.frame21.spinbox25 config  -background {linen}  -buttonbackground {#dcdcdc}  -font {Helvetica 10}  -from {-10000.0}  -textvariable {TPcurCanvasObjYpos}  -to {10000.0}  -width {4}

  button .tpcanvas.frame2.frame21.frame.frame21.button26  -activebackground {gray75}  -background {#dcdcdc}  -command {.tpcanvas.frame2.frame21.frame.text2 insert insert " $TPcurCanvasObjXpos $TPcurCanvasObjYpos "}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -padx {4}  -text {Add}

  checkbutton .tpcanvas.frame2.frame21.frame.frame21.checkbutton0  -activebackground {#dcdcdc}  -background {#dcdcdc}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Point}  -variable {TPcurCanvasPoint}

  frame .tpcanvas.frame2.frame21.frame0  -background {#dcdcdc}  -height {124}  -highlightbackground {#e6e7e6}  -width {109}

  label .tpcanvas.frame2.frame21.frame0.label5  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10 bold}  -highlightbackground {#dcdcdc}  -text {Coord:}

  button .tpcanvas.frame2.frame21.frame0.button2  -activebackground {gray75}  -background {#e6e7e6}  -command {TP_CVcoordAdjust up .tpcanvas.frame2.frame21.frame.text2}  -font {Helvetica 10}  -highlightbackground {#e6e7e6}  -image {tparrow_up}  -repeatdelay {500}  -repeatinterval {100}  -text {button2}

  frame .tpcanvas.frame2.frame21.frame0.frame3  -relief {raised}  -background {#e6e7e6}  -height {31}  -highlightbackground {#e6e7e6}  -width {109}

  button .tpcanvas.frame2.frame21.frame0.frame3.button2  -activebackground {gray75}  -background {#e6e7e6}  -command {TP_CVcoordAdjust left .tpcanvas.frame2.frame21.frame.text2}  -font {Helvetica 10}  -highlightbackground {#e6e7e6}  -image {tparrow_left}  -repeatdelay {500}  -repeatinterval {100}  -text {button2}

  button .tpcanvas.frame2.frame21.frame0.frame3.button5  -activebackground {gray75}  -background {#e6e7e6}  -command {TP_CVcoordAdjust right .tpcanvas.frame2.frame21.frame.text2}  -font {Helvetica 10}  -highlightbackground {#e6e7e6}  -image {tparrow_right}  -repeatdelay {500}  -repeatinterval {100}  -text {button2}

  button .tpcanvas.frame2.frame21.frame0.frame3.button6  -activebackground {gray75}  -background {#e6e7e6}  -command {TP_CVcoordAdjust accept .tpcanvas.frame2.frame21.frame.text2}  -font {Helvetica 10}  -highlightbackground {#e6e7e6}  -padx {1m}  -pady {0}  -text {Accept}

  button .tpcanvas.frame2.frame21.frame0.button7  -activebackground {gray75}  -background {#e6e7e6}  -command {TP_CVcoordAdjust down .tpcanvas.frame2.frame21.frame.text2}  -font {Helvetica 10}  -highlightbackground {#e6e7e6}  -image {tparrow_down}  -repeatdelay {500}  -repeatinterval {100}  -text {button2}

  frame .tpcanvas.frame2.frame36  -borderwidth {2}  -relief {ridge}  -background {#dcdcdc}  -height {30}  -highlightbackground {#dcdcdc}  -width {249}

  button .tpcanvas.frame2.frame36.button1  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_CanvasObjInsert
after 100 "set TPcanvasID $TPcanvasID"

TP_CanvasObjListFill $TPcurCanvas}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Insert}  -width {5}

  frame .tpcanvas.frame2.frame6  -borderwidth {2}  -relief {ridge}  -background {#dcdcdc}  -height {228}  -highlightbackground {#dcdcdc}  -width {488}

#LISSI
#  scrollbar .tpcanvas.frame2.frame6.scrollbar1  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpcanvas.frame2.frame6.canvas2 yview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -relief {raised}  -troughcolor {#dcdcdc}
  ttk::scrollbar .tpcanvas.frame2.frame6.scrollbar1 -command {.tpcanvas.frame2.frame6.canvas2 yview}

  canvas .tpcanvas.frame2.frame6.canvas2  -background {#dcdcdc}  -height {80}  -highlightbackground {#ffffff}  -highlightthickness {0}  -scrollregion {0c 0c 20c 40c}  -width {1}  -yscrollcommand {.tpcanvas.frame2.frame6.scrollbar1 set}

  frame .tpcanvas.frame2.frame6.canvas2.frame5  -background {#dcdcdc}  -height {84}  -highlightbackground {#dcdcdc}  -width {296}

  label .tpcanvas.frame2.frame6.canvas2.frame5.hdrspecific  -activebackground {#dcdcdc}  -background {grey70}  -font {Helvetica 12}  -highlightbackground {#dcdcdc}  -relief {raised}  -text {Specific Options (+)}  -width {41}
  # bindings
  bind .tpcanvas.frame2.frame6.canvas2.frame5.hdrspecific <ButtonRelease-1> {TP_CVpropsShowHide %W}

  label .tpcanvas.frame2.frame6.canvas2.frame5.hdrstandard  -activebackground {#dcdcdc}  -background {gray70}  -font {Helvetica 12}  -highlightbackground {#dcdcdc}  -relief {raised}  -text {Standard Options (+)}  -width {41}
  # bindings
  bind .tpcanvas.frame2.frame6.canvas2.frame5.hdrstandard <ButtonRelease-1> {TP_CVpropsShowHide %W}

  frame .tpcanvas.frame2.frame6.canvas2.frame5.propswidget  -background {#dcdcdc}  -height {82}  -highlightbackground {#dcdcdc}  -width {242}

  frame .tpcanvas.frame2.frame6.canvas2.frame5.propswidget.frame21  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {282}

  entry .tpcanvas.frame2.frame6.canvas2.frame5.propswidget.frame21.entry23  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -state {readonly}  -textvariable {TPpropsWidget(name)}

  label .tpcanvas.frame2.frame6.canvas2.frame5.propswidget.frame21.label22  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 12}  -highlightbackground {#dcdcdc}  -text {Name}  -width {16}

  frame .tpcanvas.frame2.frame6.canvas2.frame5.propswidget.frame24  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {282}

  label .tpcanvas.frame2.frame6.canvas2.frame5.propswidget.frame24.label22  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 12}  -highlightbackground {#dcdcdc}  -text {Class}  -width {16}

  entry .tpcanvas.frame2.frame6.canvas2.frame5.propswidget.frame24.entry23  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -state {readonly}  -textvariable {TPpropsWidget(class)}

  frame .tpcanvas.frame2.frame6.canvas2.frame5.propswidget.frame25  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {282}

  label .tpcanvas.frame2.frame6.canvas2.frame5.propswidget.frame25.label22  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 12}  -highlightbackground {#dcdcdc}  -text {Parent}  -width {16}

  entry .tpcanvas.frame2.frame6.canvas2.frame5.propswidget.frame25.entry23  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -state {readonly}  -textvariable {TPpropsWidget(parent)}

  frame .tpcanvas.frame30  -borderwidth {2}  -relief {ridge}  -background {#dcdcdc}  -height {334}  -highlightbackground {#dcdcdc}  -width {260}

#LISSI
#  scrollbar .tpcanvas.frame30.scrollbar3  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpcanvas.frame30.listbox1 xview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -orient {horizontal}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}
#  scrollbar .tpcanvas.frame30.scrollbar2  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpcanvas.frame30.listbox1 yview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}
  ttk::scrollbar .tpcanvas.frame30.scrollbar3 -command {.tpcanvas.frame30.listbox1 xview} -orient {horizontal}
  ttk::scrollbar .tpcanvas.frame30.scrollbar2 -command {.tpcanvas.frame30.listbox1 yview}

  listbox .tpcanvas.frame30.listbox1  -exportselection {0}  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -width {22}  -xscrollcommand {.tpcanvas.frame30.scrollbar3 set}  -yscrollcommand {.tpcanvas.frame30.scrollbar2 set}
  # bindings
  bind .tpcanvas.frame30.listbox1 <<ListboxSelect>> {set TPtemp [%W curselection]

  if {$TPtemp != {}} {TP_CanvasTypeSel [%W get $TPtemp]}}

  label .tpcanvas.frame30.label29  -activebackground {#dcdcdc}  -background {slategray3}  -font {Helvetica 10 bold}  -highlightbackground {#dcdcdc}  -relief {raised}  -text {Tags}

  frame .tpcanvas.frame30.frame36  -borderwidth {2}  -relief {ridge}  -background {#dcdcdc}  -height {30}  -highlightbackground {#dcdcdc}  -width {249}

  button .tpcanvas.frame30.frame36.button38  -activebackground {gray75}  -background {#dcdcdc}  -command {set TPtemp [.tpcanvas.frame30.listbox1 curselection]
if {$TPtemp != {}} {
    if {[winfo exists $TPcurCanvas]} {
        set TPcvbindID $TPcanvasID
        if {[winfo exists .tpbindcv]} {
            # The desired form is already displayed.
            # We just need to force a rescan of the the current object's bindings.
            .tpbindcv.frame32.button4 invoke
           } { ShowWindow.tpbindcv }
       }
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Binding}  -width {5}

  button .tpcanvas.frame30.frame36.button5  -activebackground {gray75}  -background {#dcdcdc}  -command {if {[winfo exists $TPcurCanvas]} {
    if {$TPcanvasID != {}} {
        $TPcurCanvas delete $TPcanvasID
        TP_CanvasObjListFill $TPcurCanvas
       }
   }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Delete}  -width {5}

  frame .tpcanvas.frame30.frame28  -relief {raised}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {260}

  label .tpcanvas.frame30.frame28.label29  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {sort by: }

  radiobutton .tpcanvas.frame30.frame28.radiobutton30  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {TP_CanvasObjListFill $TPcurCanvas}  -font {Helvetica 8}  -highlightbackground {#dcdcdc}  -text {ID}  -value {ID}  -variable {TPcurCanvasTagSort}

  radiobutton .tpcanvas.frame30.frame28.radiobutton31  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {TP_CanvasObjListFill $TPcurCanvas}  -font {Helvetica 8}  -highlightbackground {#dcdcdc}  -text {Tag}  -value {Tag}  -variable {TPcurCanvasTagSort}

  radiobutton .tpcanvas.frame30.frame28.radiobutton32  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {TP_CanvasObjListFill $TPcurCanvas}  -font {Helvetica 8}  -highlightbackground {#dcdcdc}  -text {Type}  -value {Type}  -variable {TPcurCanvasTagSort}

  frame .tpcanvas.frame9  -borderwidth {2}  -relief {ridge}  -background {#eaead6}  -height {334}  -highlightbackground {#dcdcdc}  -width {99}

  frame .tpcanvas.frame9.frame10  -relief {raised}  -background {#dcdcdc}  -height {20}  -highlightbackground {#dcdcdc}  -width {42}

  label .tpcanvas.frame9.frame10.label11  -activebackground {#dcdcdc}  -background {#eaead6}  -borderwidth {0}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -relief {raised}  -text { ID = }

  label .tpcanvas.frame9.frame10.label12  -activebackground {#dcdcdc}  -anchor {w}  -background {#eaead6}  -borderwidth {0}  -font {Helvetica 10}  -foreground {blue}  -highlightbackground {#dcdcdc}  -relief {raised}  -text {1}  -textvariable {TPcanvasID}

  radiobutton .tpcanvas.frame9.radiobutton13  -activebackground {#dcdcdc}  -anchor {w}  -background {#eaead6}  -command {TP_ToolChoose move}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -text {GrpMove}  -value {GrpMove}  -variable {TPcanvasTool}
#LISSI
TP_popupHint .tpcanvas.frame9.radiobutton13 "Select group and move it or save to file or create image"

  radiobutton .tpcanvas.frame9.radiobutton14  -activebackground {#dcdcdc}  -anchor {w}  -background {#eaead6}  -command {TP_ToolChoose stretch}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -text {Stretch}  -value {Stretch}  -variable {TPcanvasTool}

  radiobutton .tpcanvas.frame9.radiobutton15  -activebackground {#dcdcdc}  -anchor {w}  -background {#eaead6}  -command {TP_ToolChoose delete}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -text {Cut}  -value {Cut}  -variable {TPcanvasTool}
#LISSI
TP_popupHint .tpcanvas.frame9.radiobutton15 "Select group and cut it"

  radiobutton .tpcanvas.frame9.radiobutton16  -activebackground {#dcdcdc}  -anchor {w}  -background {#eaead6}  -command {TP_ToolChoose copy}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -text {Copy}  -value {Copy}  -variable {TPcanvasTool}
#LISSI
TP_popupHint .tpcanvas.frame9.radiobutton16 "Select group and copy it"

  radiobutton .tpcanvas.frame9.radiobutton17  -activebackground {#dcdcdc}  -anchor {w}  -background {#eaead6}  -command {TP_ToolChoose onemove}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -text {OneMove}  -value {OneMove}  -variable {TPcanvasTool}
#LISSI
TP_popupHint .tpcanvas.frame9.radiobutton17 "Move single object "

  radiobutton .tpcanvas.frame9.radiobutton18  -activebackground {#dcdcdc}  -anchor {w}  -background {#eaead6}  -command {TP_ToolChoose objmove}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -text {ObjMove}  -value {ObjMove}  -variable {TPcanvasTool}
#LISSI
TP_popupHint .tpcanvas.frame9.radiobutton18 "Move compound object"

  radiobutton .tpcanvas.frame9.radiobutton19  -activebackground {#dcdcdc}  -anchor {w}  -background {#eaead6}  -command {TP_ToolChoose objadd}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -text {Attach}  -value {Attach}  -variable {TPcanvasTool}
#LISSI
TP_popupHint .tpcanvas.frame9.radiobutton19 "Attach to compound object"

  radiobutton .tpcanvas.frame9.radiobutton20  -activebackground {#dcdcdc}  -anchor {w}  -background {#eaead6}  -command {TP_ToolChoose objdel}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -text {Detach}  -value {Detach}  -variable {TPcanvasTool}
#LISSI
TP_popupHint .tpcanvas.frame9.radiobutton20 "Detach from compound object"

  radiobutton .tpcanvas.frame9.radiobutton21  -activebackground {#dcdcdc}  -anchor {w}  -background {#eaead6}  -command {TP_ToolChoose ID}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -text {ID}  -value {ID}  -variable {TPcanvasTool}
#LISSI
TP_popupHint .tpcanvas.frame9.radiobutton21 "Set current object"

  radiobutton .tpcanvas.frame9.radiobutton22  -activebackground {#dcdcdc}  -anchor {w}  -background {#eaead6}  -command {TP_ToolChoose cancel}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -text {None}  -value {None}  -variable {TPcanvasTool}
#LISSI
TP_popupHint .tpcanvas.frame9.radiobutton22 "Disable all features"
  frame .tpcanvas.frame9.sepOldNew -borderwidth {2} -relief {groove} -background {#87CEEB} -height {2} -highlightbackground {#eff0f1} -highlightcolor {#232627}
  radiobutton .tpcanvas.frame9.radiobutton23  -activebackground {#dcdcdc}  -anchor {w}  -background {#eaead6}  -command {TP_ToolChoose grpresize}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -text {GrpResizeMove}  -value {GrpMoveNew}  -variable {TPcanvasTool}
  radiobutton .tpcanvas.frame9.radiobutton24  -activebackground {#dcdcdc}  -anchor {w}  -background {#eaead6}  -command {TP_ToolChoose reshape}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -text {Reshape polygon/line}  -value {Reshape}  -variable {TPcanvasTool}
  radiobutton .tpcanvas.frame9.radiobutton25  -activebackground {#dcdcdc}  -anchor {w}  -background {#eaead6}  -command {TP_ToolChoose savefile}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -text {SaveGroupToFile}  -value {saveFile}  -variable {TPcanvasTool}
  radiobutton .tpcanvas.frame9.radiobutton26  -activebackground {#dcdcdc}  -anchor {w}  -background {#eaead6}  -command {TP_ToolChoose saveimage}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -text {SaveGroupToImage}  -value {saveImage}  -variable {TPcanvasTool}
  radiobutton .tpcanvas.frame9.radiobutton27  -activebackground {#dcdcdc}  -anchor {w}  -background {#eaead6}  -command {TP_ToolChoose saveoneimage}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -text {SaveOneToImage}  -value {saveOneImage}  -variable {TPcanvasTool}
  TP_popupHint .tpcanvas.frame9.radiobutton27 "Save one object to image"
  radiobutton .tpcanvas.frame9.radiobutton28  -activebackground {#dcdcdc}  -anchor {w}  -background {#eaead6}  -command {TP_ToolChoose saveonefile}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -text {SaveOneToFile}  -value {saveOneFile}  -variable {TPcanvasTool}
  TP_popupHint .tpcanvas.frame9.radiobutton28 "Save image one object to file"

  label .tpcanvas.frame9.label23  -activebackground {#dcdcdc}  -background {slategray3}  -font {Helvetica 10 bold}  -highlightbackground {#dcdcdc}  -relief {raised}  -text {Tools}

  button .tpcanvas.frame9.button1  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_DTundelete $TPcurCanvas
TP_CanvasObjListFill $TPcurCanvas}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Paste}  -width {5}
#LISSI
TP_popupHint .tpcanvas.frame9.button1 "Paste last group cut"

  radiobutton .tpcanvas.frame9.radiobutton5  -activebackground {#dcdcdc}  -anchor {w}  -background {#eaead6}  -command {TP_ToolChoose pop}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -text {Raise}  -value {Pop}  -variable {TPcanvasTool}

  radiobutton .tpcanvas.frame9.radiobutton7  -activebackground {#dcdcdc}  -anchor {w}  -background {#eaead6}  -command {TP_ToolChoose push}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -text {Lower}  -value {Push}  -variable {TPcanvasTool}

  # pack master .tpcanvas.frame0
  pack configure .tpcanvas.frame0.label1  -side left
  pack configure .tpcanvas.frame0.label2  -side left
  pack configure .tpcanvas.frame0.button1  -side right

  # pack master .tpcanvas.frame2
  pack configure .tpcanvas.frame2.label3  -fill x
  pack configure .tpcanvas.frame2.frame4  -anchor w
  pack configure .tpcanvas.frame2.frame15  -anchor w
  pack configure .tpcanvas.frame2.frame21  -anchor w
  pack configure .tpcanvas.frame2.frame6  -expand 1  -fill both
  pack configure .tpcanvas.frame2.frame36  -fill x  -side bottom

  # pack master .tpcanvas.frame2.frame4
  pack configure .tpcanvas.frame2.frame4.label5  -side left
  pack configure .tpcanvas.frame2.frame4.menubutton6  -padx 3  -side left

  # pack master .tpcanvas.frame2.frame15
  pack configure .tpcanvas.frame2.frame15.label5  -side left
  pack configure .tpcanvas.frame2.frame15.entry13  -padx 2

  # pack master .tpcanvas.frame2.frame21
  pack configure .tpcanvas.frame2.frame21.frame0  -fill y  -side left
  pack configure .tpcanvas.frame2.frame21.frame  -fill both  -side left

  # pack master .tpcanvas.frame2.frame21.frame
  pack configure .tpcanvas.frame2.frame21.frame.frame21  -fill x
  pack configure .tpcanvas.frame2.frame21.frame.scrollbar1  -fill y  -side left
  pack configure .tpcanvas.frame2.frame21.frame.text2  -expand 1  -fill both

  # pack master .tpcanvas.frame2.frame21.frame.frame21
  pack configure .tpcanvas.frame2.frame21.frame.frame21.label23  -side left
  pack configure .tpcanvas.frame2.frame21.frame.frame21.spinbox1  -side left
  pack configure .tpcanvas.frame2.frame21.frame.frame21.label24  -side left
  pack configure .tpcanvas.frame2.frame21.frame.frame21.spinbox25  -side left
  pack configure .tpcanvas.frame2.frame21.frame.frame21.button26  -side left
  pack configure .tpcanvas.frame2.frame21.frame.frame21.checkbutton0  -side left

  # pack master .tpcanvas.frame2.frame21.frame0
  pack configure .tpcanvas.frame2.frame21.frame0.label5  -anchor w
  pack configure .tpcanvas.frame2.frame21.frame0.button2
  pack configure .tpcanvas.frame2.frame21.frame0.frame3
  pack configure .tpcanvas.frame2.frame21.frame0.button7

  # pack master .tpcanvas.frame2.frame21.frame0.frame3
  pack configure .tpcanvas.frame2.frame21.frame0.frame3.button2  -side left
  pack configure .tpcanvas.frame2.frame21.frame0.frame3.button6  -fill y  -side left
  pack configure .tpcanvas.frame2.frame21.frame0.frame3.button5  -side left

  # pack master .tpcanvas.frame2.frame36
  pack configure .tpcanvas.frame2.frame36.button1  -side left

  # pack master .tpcanvas.frame2.frame6
  pack configure .tpcanvas.frame2.frame6.scrollbar1  -fill y  -side right
  pack configure .tpcanvas.frame2.frame6.canvas2  -expand 1  -fill both

  # pack master .tpcanvas.frame2.frame6.canvas2.frame5
  pack configure .tpcanvas.frame2.frame6.canvas2.frame5.hdrstandard  -anchor w
  pack configure .tpcanvas.frame2.frame6.canvas2.frame5.hdrspecific  -anchor w

  # pack master .tpcanvas.frame2.frame6.canvas2.frame5.propswidget
  pack configure .tpcanvas.frame2.frame6.canvas2.frame5.propswidget.frame21  -fill x
  pack configure .tpcanvas.frame2.frame6.canvas2.frame5.propswidget.frame24  -fill x
  pack configure .tpcanvas.frame2.frame6.canvas2.frame5.propswidget.frame25  -fill x

  # pack master .tpcanvas.frame2.frame6.canvas2.frame5.propswidget.frame21
  pack configure .tpcanvas.frame2.frame6.canvas2.frame5.propswidget.frame21.label22  -anchor w  -side left
  pack configure .tpcanvas.frame2.frame6.canvas2.frame5.propswidget.frame21.entry23  -expand 1  -fill x  -ipadx 3  -side left

  # pack master .tpcanvas.frame2.frame6.canvas2.frame5.propswidget.frame24
  pack configure .tpcanvas.frame2.frame6.canvas2.frame5.propswidget.frame24.label22  -anchor w  -side left
  pack configure .tpcanvas.frame2.frame6.canvas2.frame5.propswidget.frame24.entry23  -expand 1  -fill x  -side left

  # pack master .tpcanvas.frame2.frame6.canvas2.frame5.propswidget.frame25
  pack configure .tpcanvas.frame2.frame6.canvas2.frame5.propswidget.frame25.label22  -anchor w  -side left
  pack configure .tpcanvas.frame2.frame6.canvas2.frame5.propswidget.frame25.entry23  -expand 1  -fill x  -side left

  # pack master .tpcanvas.frame30
  pack configure .tpcanvas.frame30.label29  -fill x
  pack configure .tpcanvas.frame30.frame28  -fill x
  pack configure .tpcanvas.frame30.frame36  -fill x  -side bottom
  pack configure .tpcanvas.frame30.scrollbar2  -fill y  -side left
  pack configure .tpcanvas.frame30.listbox1  -expand 1  -fill both
  pack configure .tpcanvas.frame30.scrollbar3  -fill x  -side bottom

  # pack master .tpcanvas.frame30.frame36
  pack configure .tpcanvas.frame30.frame36.button38  -side right
  pack configure .tpcanvas.frame30.frame36.button5  -side left

  # pack master .tpcanvas.frame30.frame28
  pack configure .tpcanvas.frame30.frame28.label29  -side left
  pack configure .tpcanvas.frame30.frame28.radiobutton30  -side left
  pack configure .tpcanvas.frame30.frame28.radiobutton31  -side left
  pack configure .tpcanvas.frame30.frame28.radiobutton32  -side left

  # pack master .tpcanvas.frame9
  pack configure .tpcanvas.frame9.label23  -fill x
  pack configure .tpcanvas.frame9.frame10  -anchor w
  pack configure .tpcanvas.frame9.radiobutton19  -anchor w  -fill x
  pack configure .tpcanvas.frame9.radiobutton16  -anchor w  -fill x
  pack configure .tpcanvas.frame9.radiobutton15  -anchor w  -fill x
  pack configure .tpcanvas.frame9.radiobutton20  -anchor w  -fill x
  pack configure .tpcanvas.frame9.radiobutton13  -anchor w  -fill x
  pack configure .tpcanvas.frame9.radiobutton21  -anchor w  -fill x
  pack configure .tpcanvas.frame9.radiobutton7  -anchor w  -fill x
  pack configure .tpcanvas.frame9.radiobutton18  -anchor w  -fill x
  pack configure .tpcanvas.frame9.radiobutton17  -anchor w  -fill x
  pack configure .tpcanvas.frame9.radiobutton5  -anchor w  -fill x
  pack configure .tpcanvas.frame9.radiobutton14  -anchor w  -fill x
#LISSI
  pack .tpcanvas.frame9.sepOldNew -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0
  pack configure .tpcanvas.frame9.radiobutton23  -anchor w  -fill x
  pack configure .tpcanvas.frame9.radiobutton24  -anchor w  -fill x
  pack configure .tpcanvas.frame9.radiobutton25  -anchor w  -fill x
  pack configure .tpcanvas.frame9.radiobutton26  -anchor w  -fill x
  pack configure .tpcanvas.frame9.radiobutton27  -anchor w  -fill x
  pack configure .tpcanvas.frame9.radiobutton28  -anchor w  -fill x
  frame .tpcanvas.frame9.sepNewNone -borderwidth {2} -relief {groove} -background {#87CEEB} -height {2} -highlightbackground {#eff0f1} -highlightcolor {#232627}
  pack .tpcanvas.frame9.sepNewNone -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0

  pack configure .tpcanvas.frame9.radiobutton22  -anchor w  -fill x
  pack configure .tpcanvas.frame9.button1  -expand 1  -pady 3

  # pack master .tpcanvas.frame9.frame10
  pack configure .tpcanvas.frame9.frame10.label11  -side left
  pack configure .tpcanvas.frame9.frame10.label12  -side left

  # pack master .tpcanvas
  pack configure .tpcanvas.frame0  -fill x
  pack configure .tpcanvas.frame2  -anchor n  -fill y  -side left
  pack configure .tpcanvas.frame30  -expand 1  -fill both  -side left
  pack configure .tpcanvas.frame9  -expand 1  -fill y

  .tpcanvas.frame2.frame21.frame.text2 insert end {}
  # build canvas items .tpcanvas.frame2.frame6.canvas2
  set xfTmpTag [.tpcanvas.frame2.frame6.canvas2 create window 0.0 0.0]
  .tpcanvas.frame2.frame6.canvas2 itemconfigure $xfTmpTag  -anchor {nw}  -window {.tpcanvas.frame2.frame6.canvas2.frame5}

EndSrc.tpcanvas
}

proc DestroyWindow.tpcanvas {} {
     catch "destroy .tpcanvas"
     update
}

proc EndSrc.tpcanvas {} {
global TPcanvasTool
global TPcurCanvasObjXpos
global TPcurCanvasObjYpos
global TPcurCanvas
global TPcurPath

wm iconphoto .tpcanvas tplogo16
TP_CanvasObjListFill $TPcurCanvas
set TPcurCanvasObjXpos 0
set TPcurCanvasObjYpos 0
set TPcanvasTool None
TP_ToolChoose cancel
}


proc ShowWindow.tpcmdedit { args} {

  catch "destroy .tpcmdedit"

  toplevel .tpcmdedit   -background {#dcdcdc}  -highlightbackground {#dcdcdc}

  # Window manager configurations
  wm positionfrom .tpcmdedit program
  wm sizefrom .tpcmdedit program
  wm maxsize .tpcmdedit 2560 1024
  wm minsize .tpcmdedit 424 210
  wm protocol .tpcmdedit WM_DELETE_WINDOW {DestroyWindow.tpcmdedit}
  wm title .tpcmdedit {TKproE: Edit command property}

  # bindings
  bind .tpcmdedit <ButtonRelease-1> {TP_ProcessClick %W %X %Y %x %y}
  bind .tpcmdedit <Shift-Button-3> {TP_PropsSelWidget %W}

  frame .tpcmdedit.frame0  -borderwidth {2}  -relief {ridge}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {364}

  label .tpcmdedit.frame0.label1  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Widget name: }

  label .tpcmdedit.frame0.label2  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -foreground {blue}  -highlightbackground {#dcdcdc}  -text {.}  -textvariable {TPcurWidget}

  frame .tpcmdedit.frame3  -borderwidth {2}  -relief {ridge}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {364}

  button .tpcmdedit.frame3.button4  -activebackground {gray75}  -background {#dcdcdc}  -command {if {[winfo exists $TPcurWidget]} {
   set TPtemp [.tpcmdedit.frame.text2 get 1.0 end-1chars]
    if {[catch "$TPtxtCmd \{$TPtemp\}" TPtemp]} {
        set TPmessage $TPtemp
        set TPmsgButtons OK
        ShowWindow.tpmsgbox
      } {
          if {[string length $TPvarCmd] > 0} {
	      catch "$TPvarCmd \{[.tpcmdedit.frame.text2 get 1.0 end-1chars]\}"
             }
        DestroyWindow.tpcmdedit
        }
  } { DestroyWindow.tpcmdedit }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -padx {4}  -pady {2}  -text {Done}  -width {6}

  button .tpcmdedit.frame3.button8  -activebackground {gray75}  -background {#dcdcdc}  -command {DestroyWindow.tpcmdedit}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -padx {4}  -pady {2}  -text {Cancel}  -width {6}

  frame .tpcmdedit.frame  -relief {raised}  -background {#dcdcdc}  -highlightbackground {#dcdcdc}

  scrollbar .tpcmdedit.frame.scrollbar1  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpcmdedit.frame.text2 yview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}

  text .tpcmdedit.frame.text2  -font {Helvetica 10}  -height {8}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -width {50}  -wrap {none}  -xscrollcommand {.tpcmdedit.frame.scrollbar3 set}  -yscrollcommand {.tpcmdedit.frame.scrollbar1 set}

  scrollbar .tpcmdedit.frame.scrollbar3  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpcmdedit.frame.text2 xview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -orient {horizontal}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}

  # pack master .tpcmdedit.frame0
  pack configure .tpcmdedit.frame0.label1  -side left
  pack configure .tpcmdedit.frame0.label2  -side left

  # pack master .tpcmdedit.frame3
  pack configure .tpcmdedit.frame3.button4  -side left
  pack configure .tpcmdedit.frame3.button8  -side right

  # pack master .tpcmdedit.frame
  pack configure .tpcmdedit.frame.scrollbar1  -fill y  -side left
  pack configure .tpcmdedit.frame.text2  -expand 1  -fill both
  pack configure .tpcmdedit.frame.scrollbar3  -fill x

  # pack master .tpcmdedit
  pack configure .tpcmdedit.frame0  -fill x
  pack configure .tpcmdedit.frame3  -fill x
  pack configure .tpcmdedit.frame  -expand 1  -fill both

  wm iconphoto .tpcmdedit tplogo16
}

proc DestroyWindow.tpcmdedit {} {
     catch "destroy .tpcmdedit"
     update
}


proc ShowWindow.tpcolorsel { args} {

  catch "destroy .tpcolorsel"

  toplevel .tpcolorsel   -background {#dcdcdc}  -highlightbackground {#dcdcdc}

  # Window manager configurations
  wm positionfrom .tpcolorsel ""
  wm sizefrom .tpcolorsel ""
  wm maxsize .tpcolorsel 280 994
  wm minsize .tpcolorsel 280 340
  wm geometry .tpcolorsel 280x650
  wm protocol .tpcolorsel WM_DELETE_WINDOW {.tpcolorsel.frame0.button2 invoke}
  wm title .tpcolorsel {TKproE color selection}

  # bindings
  bind .tpcolorsel <ButtonRelease-1> {TP_ProcessClick %W %X %Y %x %y}
  bind .tpcolorsel <Shift-Button-3> {TP_PropsSelWidget %W}
  
  frame .tpcolorsel.top  -background {#dcdcdc}  -highlightbackground {#dcdcdc}

  frame .tpcolorsel.top.left  -background {#dcdcdc}  -highlightbackground {#dcdcdc}

  scale .tpcolorsel.top.left.red  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {TP_ColorSetSample {}}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -label {RED:}  -length {120}  -orient {horizontal}  -to {255.0}  -troughcolor {red}  -variable {TPcolor(red)}

  scale .tpcolorsel.top.left.green  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {TP_ColorSetSample {}}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -label {GREEN:}  -length {120}  -orient {horizontal}  -to {255.0}  -troughcolor {green}  -variable {TPcolor(green)}

  scale .tpcolorsel.top.left.blue  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {TP_ColorSetSample {}}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -label {BLUE:}  -length {120}  -orient {horizontal}  -to {255.0}  -troughcolor {blue}  -variable {TPcolor(blue)}

  frame .tpcolorsel.top.right  -background {#dcdcdc}  -highlightbackground {#dcdcdc}

  label .tpcolorsel.top.right.color  -activebackground {#dcdcdc}  -background {#000000}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -relief {groove}

  label .tpcolorsel.top.right.label0  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 12 bold}  -foreground {red}  -highlightbackground {#dcdcdc}  -text {#000000}  -textvariable {TPcolor(rgb)}  -width {17}

  frame .tpcolorsel.c  -borderwidth {2}  -relief {ridge}  -background {#dcdcdc}  -highlightbackground {#dcdcdc}

  canvas .tpcolorsel.c.canvas  -background {#ffffff}  -borderwidth {2}  -height {100}  -highlightbackground {#ffffff}  -relief {raised}  -scrollregion {0 0 200 19500}  -width {200}  -yscrollcommand {.tpcolorsel.c.sy set}

  scrollbar .tpcolorsel.c.sy  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {2}  -command {.tpcolorsel.c.canvas yview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -troughcolor {#dcdcdc}  -width {15}
  

  frame .tpcolorsel.frame0  -borderwidth {2}  -relief {ridge}  -background {#dcdcdc}  -height {34}  -highlightbackground {#dcdcdc}  -width {280}

  button .tpcolorsel.frame0.button1  -activebackground {gray75}  -background {#dcdcdc}  -command {if {![catch {winfo rgb . $TPcolor(rgb)}]} {
    set $TPcolor(varname) $TPcolor(rgb)
   }
.tpcolorsel.c.canvas delete all
DestroyWindow.tpcolorsel}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {OK}  -width {5}

  button .tpcolorsel.frame0.button2  -activebackground {gray75}  -background {#dcdcdc}  -command {if {![catch "set $TPcolor(varname)" TPtemp]} {
   TP_ColorSetSample $TPtemp
  }
.tpcolorsel.c.canvas delete all
DestroyWindow.tpcolorsel}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Cancel}

  # pack master .tpcolorsel.top
  pack configure .tpcolorsel.top.left  -fill both  -side left
  pack configure .tpcolorsel.top.right  -expand 1  -fill both  -side left

  # pack master .tpcolorsel.top.left
  pack configure .tpcolorsel.top.left.red  -expand 1  -fill y
  pack configure .tpcolorsel.top.left.green  -expand 1  -fill y
  pack configure .tpcolorsel.top.left.blue  -expand 1  -fill y

  # pack master .tpcolorsel.top.right
  pack configure .tpcolorsel.top.right.color  -expand 1  -fill both
  pack configure .tpcolorsel.top.right.label0

  # pack master .tpcolorsel.c
  pack configure .tpcolorsel.c.sy  -fill y  -side right
  pack configure .tpcolorsel.c.canvas  -expand 1  -fill both

  # pack master .tpcolorsel.frame0
  pack configure .tpcolorsel.frame0.button1  -expand 1  -side left
  pack configure .tpcolorsel.frame0.button2  -expand 1  -side left

  # pack master .tpcolorsel
  pack configure .tpcolorsel.top  -fill x
  pack configure .tpcolorsel.c  -expand 1  -fill both
  pack configure .tpcolorsel.frame0  -fill x  -side bottom

EndSrc.tpcolorsel
}

proc DestroyWindow.tpcolorsel {} {
     catch "destroy .tpcolorsel"
     update
}

proc EndSrc.tpcolorsel {} {
global TPcolor

wm iconphoto .tpcolorsel tplogo16
TP_ColorCanvasFill .tpcolorsel.c.canvas
TP_ColorSetSample [set ::$TPcolor(varname)]
}


proc ShowWindow.tpexclusions { args} {

  catch "destroy .tpexclusions"

  toplevel .tpexclusions   -relief {raised}  -background {#dcdcdc}  -highlightbackground {#dcdcdc}

  # Window manager configurations
  wm positionfrom .tpexclusions program
  wm sizefrom .tpexclusions program
  wm maxsize .tpexclusions 2560 1024
  wm minsize .tpexclusions 380 330
  wm protocol .tpexclusions WM_DELETE_WINDOW {DestroyWindow.tpexclusions}
  wm title .tpexclusions {TKproE - Namespace Exclusion List}


  frame .tpexclusions.frame  -background {#dcdcdc}  -highlightbackground {#dcdcdc}

  scrollbar .tpexclusions.frame.scrollbar2  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpexclusions.frame.listbox1 yview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}

  listbox .tpexclusions.frame.listbox1  -font {Helvetica 10}  -height {14}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -yscrollcommand {.tpexclusions.frame.scrollbar2 set}
  # bindings
  bind .tpexclusions.frame.listbox1 <Button-3> {%W selection clear 0 end
%W selection set [%W nearest %y]
if {[%W itemcget [%W curselection] -foreground] == {black}} {
   tk_popup .tpexclusions.frame.listbox1.menu6 %X %Y
  }}

  menu .tpexclusions.frame.listbox1.menu6  -activebackground {#dcdcdc}  -background {#dcdcdc}  -font {Helvetica 10}  -tearoff {0}
  .tpexclusions.frame.listbox1.menu6 add command  -command {set TPidx [lindex [.tpexclusions.frame.listbox1 curselection] 0]
if {$TPidx != {}} {
    TP_ExcludeNamespaceDel [.tpexclusions.frame.listbox1 get $TPidx]
   }}  -label {Remove selected item}

  label .tpexclusions.frame.label1  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10 italic bold}  -highlightbackground {#dcdcdc}  -text {Do not save the following namespaces}

  frame .tpexclusions.frame2  -borderwidth {2}  -relief {ridge}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {351}

  label .tpexclusions.frame2.label4  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Exclude Namespace:}

  menubutton .tpexclusions.frame2.menubutton5  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -indicatoron {1}  -menu {.tpexclusions.frame2.menubutton5.m}  -padx {5}  -pady {4}  -relief {raised}  -textvariable {TPcurExcludedNamespace}  -width {20}

  menu .tpexclusions.frame2.menubutton5.m  -activebackground {#dcdcdc}  -background {#dcdcdc}  -font {Helvetica 10}  -tearoff {0}
  .tpexclusions.frame2.menubutton5.m add command  -command {TP_ExcludeNamespaceAdd ::}  -label {::}
  .tpexclusions.frame2.menubutton5.m add command  -command {TP_ExcludeNamespaceAdd ::auto_mkindex_parser}  -label {::auto_mkindex_parser}
  .tpexclusions.frame2.menubutton5.m add command  -command {TP_ExcludeNamespaceAdd ::freewrap}  -label {::freewrap}
  .tpexclusions.frame2.menubutton5.m add command  -command {TP_ExcludeNamespaceAdd ::msgcat}  -label {::msgcat}
  .tpexclusions.frame2.menubutton5.m add command  -command {TP_ExcludeNamespaceAdd ::pkg}  -label {::pkg}
  .tpexclusions.frame2.menubutton5.m add command  -command {TP_ExcludeNamespaceAdd ::tcl}  -label {::tcl}
  .tpexclusions.frame2.menubutton5.m add command  -command {TP_ExcludeNamespaceAdd ::tcl::Pkg}  -label {::tcl::Pkg}
  .tpexclusions.frame2.menubutton5.m add command  -command {TP_ExcludeNamespaceAdd ::tcl::chan}  -label {::tcl::chan}
  .tpexclusions.frame2.menubutton5.m add command  -command {TP_ExcludeNamespaceAdd ::tcl::clock}  -label {::tcl::clock}
  .tpexclusions.frame2.menubutton5.m add command  -command {TP_ExcludeNamespaceAdd ::tcl::dict}  -label {::tcl::dict}
  .tpexclusions.frame2.menubutton5.m add command  -command {TP_ExcludeNamespaceAdd ::tcl::info}  -label {::tcl::info}
  .tpexclusions.frame2.menubutton5.m add command  -command {TP_ExcludeNamespaceAdd ::tcl::mathfunc}  -label {::tcl::mathfunc}
  .tpexclusions.frame2.menubutton5.m add command  -command {TP_ExcludeNamespaceAdd ::tcl::mathop}  -label {::tcl::mathop}
  .tpexclusions.frame2.menubutton5.m add command  -command {TP_ExcludeNamespaceAdd ::tcl::string}  -label {::tcl::string}
  .tpexclusions.frame2.menubutton5.m add command  -command {TP_ExcludeNamespaceAdd ::tcl::tm}  -label {::tcl::tm}
  .tpexclusions.frame2.menubutton5.m add command  -command {TP_ExcludeNamespaceAdd ::tcl::unsupported}  -label {::tcl::unsupported}
  .tpexclusions.frame2.menubutton5.m add command  -command {TP_ExcludeNamespaceAdd ::tk}  -label {::tk}
  .tpexclusions.frame2.menubutton5.m add command  -command {TP_ExcludeNamespaceAdd ::tk::dialog}  -label {::tk::dialog}
  .tpexclusions.frame2.menubutton5.m add command  -command {TP_ExcludeNamespaceAdd ::tk::dialog::error}  -label {::tk::dialog::error}
  .tpexclusions.frame2.menubutton5.m add command  -command {TP_ExcludeNamespaceAdd ::tk::msgcat}  -label {::tk::msgcat}
  .tpexclusions.frame2.menubutton5.m add command  -command {TP_ExcludeNamespaceAdd ::tk::panedwindow}  -label {::tk::panedwindow}
  .tpexclusions.frame2.menubutton5.m add command  -command {TP_ExcludeNamespaceAdd ::tk::spinbox}  -label {::tk::spinbox}
  .tpexclusions.frame2.menubutton5.m add command  -command {TP_ExcludeNamespaceAdd ::ttk}  -label {::ttk}
  .tpexclusions.frame2.menubutton5.m add command  -command {TP_ExcludeNamespaceAdd ::ttk::button}  -label {::ttk::button}
  .tpexclusions.frame2.menubutton5.m add command  -command {TP_ExcludeNamespaceAdd ::ttk::combobox}  -label {::ttk::combobox}
  .tpexclusions.frame2.menubutton5.m add command  -command {TP_ExcludeNamespaceAdd ::ttk::entry}  -label {::ttk::entry}
  .tpexclusions.frame2.menubutton5.m add command  -command {TP_ExcludeNamespaceAdd ::ttk::menubutton}  -label {::ttk::menubutton}
  .tpexclusions.frame2.menubutton5.m add command  -command {TP_ExcludeNamespaceAdd ::ttk::notebook}  -label {::ttk::notebook}
  .tpexclusions.frame2.menubutton5.m add command  -command {TP_ExcludeNamespaceAdd ::ttk::panedwindow}  -label {::ttk::panedwindow}
  .tpexclusions.frame2.menubutton5.m add command  -command {TP_ExcludeNamespaceAdd ::ttk::progressbar}  -label {::ttk::progressbar}
  .tpexclusions.frame2.menubutton5.m add command  -command {TP_ExcludeNamespaceAdd ::ttk::scale}  -label {::ttk::scale}
  .tpexclusions.frame2.menubutton5.m add command  -command {TP_ExcludeNamespaceAdd ::ttk::scrollbar}  -label {::ttk::scrollbar}
  .tpexclusions.frame2.menubutton5.m add command  -command {TP_ExcludeNamespaceAdd ::ttk::sizegrip}  -label {::ttk::sizegrip}
  .tpexclusions.frame2.menubutton5.m add command  -command {TP_ExcludeNamespaceAdd ::ttk::theme}  -label {::ttk::theme}
  .tpexclusions.frame2.menubutton5.m add command  -command {TP_ExcludeNamespaceAdd ::ttk::theme::alt}  -label {::ttk::theme::alt}
  .tpexclusions.frame2.menubutton5.m add command  -command {TP_ExcludeNamespaceAdd ::ttk::theme::clam}  -label {::ttk::theme::clam}
  .tpexclusions.frame2.menubutton5.m add command  -command {TP_ExcludeNamespaceAdd ::ttk::theme::classic}  -label {::ttk::theme::classic}
  .tpexclusions.frame2.menubutton5.m add command  -command {TP_ExcludeNamespaceAdd ::ttk::theme::default}  -label {::ttk::theme::default}
  .tpexclusions.frame2.menubutton5.m add command  -command {TP_ExcludeNamespaceAdd ::ttk::treeview}  -label {::ttk::treeview}
  .tpexclusions.frame2.menubutton5.m add command  -command {TP_ExcludeNamespaceAdd ::zvfs}  -label {::zvfs}

  # pack master .tpexclusions.frame
  pack configure .tpexclusions.frame.scrollbar2  -fill y  -side right
  pack configure .tpexclusions.frame.label1  -fill x
  pack configure .tpexclusions.frame.listbox1  -expand 1  -fill both

  # pack master .tpexclusions.frame2
  pack configure .tpexclusions.frame2.label4  -side left
  pack configure .tpexclusions.frame2.menubutton5  -side left

  # pack master .tpexclusions
  pack configure .tpexclusions.frame  -expand 1  -fill both
  pack configure .tpexclusions.frame2  -fill x

  .tpexclusions.frame.listbox1 insert end {::auto_mkindex_parser}
  .tpexclusions.frame.listbox1 insert end {::freewrap}
  .tpexclusions.frame.listbox1 insert end {::msgcat}
  .tpexclusions.frame.listbox1 insert end {::pkg}
  .tpexclusions.frame.listbox1 insert end {::tcl}
  .tpexclusions.frame.listbox1 insert end {::tcl::Pkg}
  .tpexclusions.frame.listbox1 insert end {::tcl::chan}
  .tpexclusions.frame.listbox1 insert end {::tcl::clock}
  .tpexclusions.frame.listbox1 insert end {::tcl::dict}
  .tpexclusions.frame.listbox1 insert end {::tcl::info}
  .tpexclusions.frame.listbox1 insert end {::tcl::mathfunc}
  .tpexclusions.frame.listbox1 insert end {::tcl::mathop}
  .tpexclusions.frame.listbox1 insert end {::tcl::string}
  .tpexclusions.frame.listbox1 insert end {::tcl::tm}
  .tpexclusions.frame.listbox1 insert end {::tcl::unsupported}
  .tpexclusions.frame.listbox1 insert end {::tk}
  .tpexclusions.frame.listbox1 insert end {::tk::dialog}
  .tpexclusions.frame.listbox1 insert end {::tk::msgcat}
  .tpexclusions.frame.listbox1 insert end {::tk::panedwindow}
  .tpexclusions.frame.listbox1 insert end {::tk::spinbox}
  .tpexclusions.frame.listbox1 insert end {::ttk}
  .tpexclusions.frame.listbox1 insert end {::ttk::button}
  .tpexclusions.frame.listbox1 insert end {::ttk::combobox}
  .tpexclusions.frame.listbox1 insert end {::ttk::entry}
  .tpexclusions.frame.listbox1 insert end {::ttk::menubutton}
  .tpexclusions.frame.listbox1 insert end {::ttk::notebook}
  .tpexclusions.frame.listbox1 insert end {::ttk::panedwindow}
  .tpexclusions.frame.listbox1 insert end {::ttk::progressbar}
  .tpexclusions.frame.listbox1 insert end {::ttk::scale}
  .tpexclusions.frame.listbox1 insert end {::ttk::scrollbar}
  .tpexclusions.frame.listbox1 insert end {::ttk::sizegrip}
  .tpexclusions.frame.listbox1 insert end {::ttk::theme}
  .tpexclusions.frame.listbox1 insert end {::ttk::theme::alt}
  .tpexclusions.frame.listbox1 insert end {::ttk::theme::clam}
  .tpexclusions.frame.listbox1 insert end {::ttk::theme::classic}
  .tpexclusions.frame.listbox1 insert end {::ttk::theme::default}
  .tpexclusions.frame.listbox1 insert end {::ttk::treeview}
  .tpexclusions.frame.listbox1 insert end {::zvfs}

EndSrc.tpexclusions
}

proc DestroyWindow.tpexclusions {} {
     catch "destroy .tpexclusions"
     update
}

proc EndSrc.tpexclusions {} {
   global TPexclusions

   wm iconphoto .tpexclusions tplogo16
   TP_MenuFromList2 .tpexclusions.frame2.menubutton5.m [concat :: [TP_NamespaceList ::]]
   .tpexclusions.frame.listbox1 delete 0 end
   set nslist [lsort $TPexclusions(namespace)]
   set idx 0
   foreach ns $nslist {
	 .tpexclusions.frame.listbox1 insert end $ns
	 if {[lsearch $TPexclusions(cantsave_namespace) $ns] < 0} {
	     .tpexclusions.frame.listbox1 itemconfigure $idx -foreground black
	    } {
	        .tpexclusions.frame.listbox1 itemconfigure $idx -foreground grey60
	      }
	 incr idx
            }
}


proc ShowWindow.tpfontselect { args} {

  catch "destroy .tpfontselect"

  toplevel .tpfontselect   -relief {raised}  -background {#dcdcdc}  -highlightbackground {#dcdcdc}

  # Window manager configurations
  wm positionfrom .tpfontselect program
  wm sizefrom .tpfontselect program
  wm maxsize .tpfontselect 2560 1024
  wm minsize .tpfontselect 600 285
  wm protocol .tpfontselect WM_DELETE_WINDOW {global TPfontCmd
global TPshowFonts

set TPfontCmd {}
.tpfontselect.frame1.frame.listbox1 delete 0 end
catch {$TPcurWidget configure -$TPpropsInfo(propname) $TPpropsInfo(propval)}
set TPshowFonts 0
DestroyWindow.tpfontselect}
  wm title .tpfontselect {TKproE font selection}

  # bindings
  bind .tpfontselect <ButtonRelease-1> {TP_ProcessClick %W %X %Y %x %y}
  bind .tpfontselect <Shift-Button-3> {TP_PropsSelWidget %W}

  frame .tpfontselect.frame1  -borderwidth {2}  -background {#dcdcdc}  -height {224}  -highlightbackground {#dcdcdc}  -width {166}

  label .tpfontselect.frame1.label3  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {0}  -font {Helvetica 10 bold}  -highlightbackground {#dcdcdc}  -text {Font:}

  entry .tpfontselect.frame1.entry4  -background {#eeeeee}  -disabledbackground {white}  -disabledforeground {black}  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -state {disabled}  -textvariable {TPfontFamily}

  frame .tpfontselect.frame1.frame  -background {#dcdcdc}  -highlightbackground {#dcdcdc}

#LISSI
#  scrollbar .tpfontselect.frame1.frame.scrollbar2  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {2}  -command {.tpfontselect.frame1.frame.listbox1 yview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}
  ttk::scrollbar .tpfontselect.frame1.frame.scrollbar2 -command {.tpfontselect.frame1.frame.listbox1 yview} 

  listbox .tpfontselect.frame1.frame.listbox1  -background {#eeeeee}  -font {Helvetica 10}  -height {6}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -width {34}  -yscrollcommand {.tpfontselect.frame1.frame.scrollbar2 set}
  # bindings
  bind .tpfontselect.frame1.frame.listbox1 <<ListboxSelect>> {set TPtemp [%W curselection]
  if {$TPtemp ne {}} {set TPfontFamily [%W get $TPtemp]}
.tpfontselect.frame1.frame5.canvas0 itemconfigure sample -font  [TP_FontGetSelected]
#LISSI
.tpfontselect.frameSample.canvas0 itemconfigure sample -font  [TP_FontGetSelected]

catch $TPfontCmd}

  frame .tpfontselect.frame1.frame5  -borderwidth {2}  -relief {groove}  -background {#dcdcdc}  -height {26}  -highlightbackground {#dcdcdc}  -width {302}

  label .tpfontselect.frame1.frame5.label6  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10 bold}  -highlightbackground {#dcdcdc}  -text {Sample}

  canvas .tpfontselect.frame1.frame5.canvas0  -background {#dcdcdc}  -height {53}  -highlightbackground {#ffffff}  -relief {raised}  -width {271}

  frame .tpfontselect.frame2  -borderwidth {2}  -background {#dcdcdc}  -height {224}  -highlightbackground {#dcdcdc}  -width {130}

  frame .tpfontselect.frame2.frame9  -background {#dcdcdc}  -height {126}  -highlightbackground {#dcdcdc}  -width {76}

  entry .tpfontselect.frame2.frame9.entry11  -background {#eeeeee}  -disabledbackground {white}  -disabledforeground {black}  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -state {disabled}  -textvariable {TPfontStyle}  -width {10}

  listbox .tpfontselect.frame2.frame9.listbox12  -background {#eeeeee}  -font {Helvetica 10}  -height {6}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -width {10}
  # bindings
  bind .tpfontselect.frame2.frame9.listbox12 <<ListboxSelect>> {set TPtemp [%W curselection]
  if {$TPtemp ne {}} {set TPfontStyle [%W get $TPtemp]}
.tpfontselect.frame1.frame5.canvas0 itemconfigure sample -font [TP_FontGetSelected]
#LISSI
.tpfontselect.frameSample.canvas0 itemconfigure sample -font [TP_FontGetSelected]

if {[string length $TPfontCmd] > 0} {
     catch $TPfontCmd
   }}

  frame .tpfontselect.frame2.frame  -background {#dcdcdc}  -height {126}  -highlightbackground {#dcdcdc}  -width {50}

#LISSI
#  scrollbar .tpfontselect.frame2.frame.scrollbar2  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {2}  -command {.tpfontselect.frame2.frame.listbox1 yview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}
  ttk::scrollbar .tpfontselect.frame2.frame.scrollbar2 -command {.tpfontselect.frame2.frame.listbox1 yview}

  listbox .tpfontselect.frame2.frame.listbox1  -background {#eeeeee}  -font {Helvetica 10}  -height {6}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -width {4}  -yscrollcommand {.tpfontselect.frame2.frame.scrollbar2 set}
  # bindings
  bind .tpfontselect.frame2.frame.listbox1 <<ListboxSelect>> {set TPtemp [%W curselection]
  if {$TPtemp ne {}} {set TPfontSize [%W get $TPtemp]}
.tpfontselect.frame1.frame5.canvas0 itemconfigure sample -font  [TP_FontGetSelected]
#LISSI
.tpfontselect.frameSample.canvas0 itemconfigure sample -font  [TP_FontGetSelected]

catch $TPfontCmd}

  entry .tpfontselect.frame2.frame.entry11  -background {#eeeeee}  -disabledbackground {white}  -disabledforeground {black}  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -state {disabled}  -textvariable {TPfontSize}  -width {6}

  frame .tpfontselect.frame2.frame13  -borderwidth {2}  -relief {groove}  -background {#dcdcdc}  -height {86}  -highlightbackground {#dcdcdc}  -width {140}

  label .tpfontselect.frame2.frame13.label14  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10 bold}  -highlightbackground {#dcdcdc}  -text {Effects}

#LISSI
#  checkbutton .tpfontselect.frame2.frame13.checkbutton15  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpfontselect.frame1.frame5.canvas0 itemconfigure sample -font  [TP_FontGetSelected]}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Strikeout}  -variable {TPfontStrikeout}
  checkbutton .tpfontselect.frame2.frame13.checkbutton15  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpfontselect.frameSample.canvas0 itemconfigure sample -font  [TP_FontGetSelected]}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Strikeout}  -variable {TPfontStrikeout}
  checkbutton .tpfontselect.frame2.frame13.checkbutton16  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpfontselect.frameSample.canvas0 itemconfigure sample -font  [TP_FontGetSelected]}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Underline}  -variable {TPfontUnderline}
#  checkbutton .tpfontselect.frame2.frame13.checkbutton16  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpfontselect.frame1.frame5.canvas0 itemconfigure sample -font  [TP_FontGetSelected]}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Underline}  -variable {TPfontUnderline}

  label .tpfontselect.frame2.label3  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {0}  -font {Helvetica 10 bold}  -highlightbackground {#dcdcdc}  -text {FontStyle:   Size:}

  frame .tpfontselect.frame  -borderwidth {2}  -background {#dcdcdc}  -height {247}  -highlightbackground {#e6e7e6}  -width {158}

  label .tpfontselect.frame.label0  -activebackground {#e6e7e6}  -anchor {w}  -background {#dcdcdc}  -borderwidth {0}  -font {Helvetica 10 bold}  -highlightbackground {#e6e7e6}  -text {Named fonts:}

  frame .tpfontselect.frame.frame3  -borderwidth {2}  -relief {groove}  -background {#eeeeee}  -height {58}  -highlightbackground {#eeeeee}  -width {150}

  button .tpfontselect.frame.frame3.button1  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_FontCreate $TPnamedFont
TP_FontNameFill .tpfontselect.frame.frame4.listbox1}  -font {Helvetica 10 bold}  -highlightbackground {#dcdcdc}  -padx {2}  -pady {0}  -text {Name font as:}

  entry .tpfontselect.frame.frame3.entry3  -background {lightblue}  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#21449c}  -selectforeground {#ffffff}  -textvariable {TPnamedFont}  -width {16}

  button .tpfontselect.frame.frame3.button4  -activebackground {gray75}  -background {#dcdcdc}  -command {set TPtemp [.tpfontselect.frame.frame4.listbox1 curselection]
if {[llength $TPtemp] == 1} {
     catch {font delete [.tpfontselect.frame.frame4.listbox1 get $TPtemp]}
     TP_FontNameFill .tpfontselect.frame.frame4.listbox1
   }}  -font {Helvetica 10 bold}  -highlightbackground {#dcdcdc}  -padx {2}  -pady {0}  -text {Delete named}

  frame .tpfontselect.frame.frame4  -borderwidth {2}  -relief {groove}  -background {#eeeeee}  -height {138}  -highlightbackground {#eeeeee}  -width {154}

  listbox .tpfontselect.frame.frame4.listbox1  -background {white}  -font {Helvetica 10}  -height {5}  -highlightbackground {#ffffff}  -selectbackground {#21449c}  -selectforeground {#ffffff}  -width {16}  -xscrollcommand {.tpfontselect.frame.frame4.scrollbar3 set}  -yscrollcommand {.tpfontselect.frame.frame4.scrollbar2 set}
  # bindings
  bind .tpfontselect.frame.frame4.listbox1 <<ListboxSelect>> {set TPtemp [%W curselection]
if {[llength $TPtemp] == 1} {
     TP_FontSelect [%W get $TPtemp]
   }}

#LISSI
#  scrollbar .tpfontselect.frame.frame4.scrollbar3  -activebackground {#e6e7e6}  -background {#e6e7e6}  -borderwidth {2}  -command {.tpfontselect.frame.frame4.listbox1 xview}  -cursor {left_ptr}  -highlightbackground {#e6e7e6}  -orient {horizontal}  -relief {raised}  -troughcolor {#e6e7e6}  -width {12}
#  scrollbar .tpfontselect.frame.frame4.scrollbar2  -activebackground {#e6e7e6}  -background {#e6e7e6}  -borderwidth {2}  -command {.tpfontselect.frame.frame4.listbox1 yview}  -cursor {left_ptr}  -highlightbackground {#e6e7e6}  -relief {raised}  -troughcolor {#e6e7e6}  -width {12}
  ttk::scrollbar .tpfontselect.frame.frame4.scrollbar3  -command {.tpfontselect.frame.frame4.listbox1 xview} -orient {horizontal}
  ttk::scrollbar .tpfontselect.frame.frame4.scrollbar2  -command {.tpfontselect.frame.frame4.listbox1 yview}

  frame .tpfontselect.frame0  -borderwidth {2}  -relief {ridge}  -background {#eeeeee}  -height {36}  -highlightbackground {#eeeeee}  -width {734}

  button .tpfontselect.frame0.button5  -activebackground {gray75}  -background {#dcdcdc}  -command {if {[winfo exists $TPselWidget(.tpfontselect)]} {
    if {[string length $TPfontCmd] > 0} { catch $TPfontCmd }
    set TPfontCmd {}
    .tpfontselect.frame1.frame.listbox1 delete 0 end
    set TPshowFonts 0
  }
set TPshowFonts 0
DestroyWindow.tpfontselect}  -font {Helvetica 10 bold}  -highlightbackground {#dcdcdc}  -text {OK}  -width {5}

  button .tpfontselect.frame0.button6  -activebackground {gray75}  -background {#dcdcdc}  -command {set TPfontCmd {}
.tpfontselect.frame1.frame.listbox1 delete 0 end
if {[winfo exists $TPselWidget(.tpfontselect)]} {
    $TPcurWidget configure -$TPpropsInfo(propname) $TPpropsInfo(propval)
  }
set TPshowFonts 0
DestroyWindow.tpfontselect}  -font {Helvetica 10 bold}  -highlightbackground {#dcdcdc}  -text {Cancel}  -width {5}

  # pack master .tpfontselect.frame1
  pack configure .tpfontselect.frame1.label3  -anchor w
  pack configure .tpfontselect.frame1.entry4  -fill x
  pack configure .tpfontselect.frame1.frame  -expand 1  -fill both
#LISSI
#  pack configure .tpfontselect.frame1.frame5  -anchor w  -fill x

  # pack master .tpfontselect.frame1.frame
  pack configure .tpfontselect.frame1.frame.scrollbar2  -fill y  -side right
  pack configure .tpfontselect.frame1.frame.listbox1  -expand 1  -fill both

  # pack master .tpfontselect.frame1.frame5
#LISSI
#  pack configure .tpfontselect.frame1.frame5.label6  -anchor w
#  pack configure .tpfontselect.frame1.frame5.canvas0

  # pack master .tpfontselect.frame2
  pack configure .tpfontselect.frame2.label3  -anchor w
  pack configure .tpfontselect.frame2.frame13  -fill x  -ipady 3  -side bottom
  pack configure .tpfontselect.frame2.frame9  -anchor n  -expand 1  -fill y  -side left
  pack configure .tpfontselect.frame2.frame  -anchor n  -expand 1  -fill y

  # pack master .tpfontselect.frame2.frame9
  pack configure .tpfontselect.frame2.frame9.entry11
  pack configure .tpfontselect.frame2.frame9.listbox12  -expand 1  -fill y

  # pack master .tpfontselect.frame2.frame
  pack configure .tpfontselect.frame2.frame.entry11  -fill x
  pack configure .tpfontselect.frame2.frame.scrollbar2  -fill y  -side right
  pack configure .tpfontselect.frame2.frame.listbox1  -expand 1  -fill y

  # pack master .tpfontselect.frame2.frame13
  pack configure .tpfontselect.frame2.frame13.label14  -anchor w
  pack configure .tpfontselect.frame2.frame13.checkbutton15  -anchor w
  pack configure .tpfontselect.frame2.frame13.checkbutton16  -anchor w

  # pack master .tpfontselect.frame
  pack configure .tpfontselect.frame.label0  -fill x
  pack configure .tpfontselect.frame.frame4  -expand 1  -fill both  -ipady 8
  pack configure .tpfontselect.frame.frame3  -fill x  -ipady 5

  # pack master .tpfontselect.frame.frame3
  pack configure .tpfontselect.frame.frame3.button4  -expand 1
  pack configure .tpfontselect.frame.frame3.button1
  pack configure .tpfontselect.frame.frame3.entry3

  # pack master .tpfontselect.frame.frame4
  pack configure .tpfontselect.frame.frame4.scrollbar2  -fill y  -side right
  pack configure .tpfontselect.frame.frame4.listbox1  -expand 1  -fill both  -ipady 3
  pack configure .tpfontselect.frame.frame4.scrollbar3  -fill x

  # pack master .tpfontselect.frame0
  pack configure .tpfontselect.frame0.button5  -anchor e  -expand 1  -padx 2  -side left
  pack configure .tpfontselect.frame0.button6  -anchor w  -expand 1  -padx 2  -side left

  pack configure .tpfontselect.frame0  -fill x  -side bottom
#LISSI
  labelframe .tpfontselect.frameSample  -borderwidth {2} -text {Sample} -font {Helvetica 10 bold}  -relief {ridge}  -background {#eeeeee}  -height {36}  -highlightbackground {#eeeeee}
#    -width {734}
  pack configure .tpfontselect.frameSample  -fill x  -side bottom
  canvas .tpfontselect.frameSample.canvas0  -background {#dcdcdc}  -height {53}  -highlightbackground {#ffffff}  -relief {raised} 
  # -width {770}
  pack configure .tpfontselect.frameSample.canvas0  -fill x -expand 1
  set xfTmpTag1 [.tpfontselect.frameSample.canvas0 create text 40.0 28.0]
  .tpfontselect.frameSample.canvas0 itemconfigure $xfTmpTag1 -anchor w  -font {{arial} 16 bold  underline}  -tags {sample}  -text {ABCabcXYZxyz0123456789АБВабвЭЮЯэюя}


  # pack master .tpfontselect
  pack configure .tpfontselect.frame1  -anchor n  -fill y  -ipady 3  -side left
  pack configure .tpfontselect.frame2  -anchor n  -fill y  -ipady 3  -side left
  pack configure .tpfontselect.frame  -anchor n  -expand 1  -fill both  -side left

  # build canvas items .tpfontselect.frame1.frame5.canvas0
  set xfTmpTag [.tpfontselect.frame1.frame5.canvas0 create text 132.0 28.0]
  .tpfontselect.frame1.frame5.canvas0 itemconfigure $xfTmpTag  -font {{arial} 16 bold  underline}  -tags {sample}  -text {0123456789abcdefghij}
  .tpfontselect.frame2.frame9.listbox12 insert end {Regular}
  .tpfontselect.frame2.frame9.listbox12 insert end {Bold}
  .tpfontselect.frame2.frame9.listbox12 insert end {Italic}
  .tpfontselect.frame2.frame9.listbox12 insert end {Bold Italic}
  .tpfontselect.frame2.frame.listbox1 insert end {6}
  .tpfontselect.frame2.frame.listbox1 insert end {8}
  .tpfontselect.frame2.frame.listbox1 insert end {10}
  .tpfontselect.frame2.frame.listbox1 insert end {12}
  .tpfontselect.frame2.frame.listbox1 insert end {14}
  .tpfontselect.frame2.frame.listbox1 insert end {16}
  .tpfontselect.frame2.frame.listbox1 insert end {18}
  .tpfontselect.frame2.frame.listbox1 insert end {20}
  .tpfontselect.frame2.frame.listbox1 insert end {22}
  .tpfontselect.frame2.frame.listbox1 insert end {24}
  .tpfontselect.frame2.frame.listbox1 insert end {26}
  .tpfontselect.frame2.frame.listbox1 insert end {28}
  .tpfontselect.frame2.frame.listbox1 insert end {30}
  .tpfontselect.frame2.frame.listbox1 insert end {32}
  .tpfontselect.frame2.frame.listbox1 insert end {34}
  .tpfontselect.frame2.frame.listbox1 insert end {36}
  .tpfontselect.frame2.frame.listbox1 insert end {38}
  .tpfontselect.frame2.frame.listbox1 insert end {40}
  .tpfontselect.frame2.frame.listbox1 insert end {42}
  .tpfontselect.frame2.frame.listbox1 insert end {44}
  .tpfontselect.frame2.frame.listbox1 insert end {46}
  .tpfontselect.frame2.frame.listbox1 insert end {48}
  .tpfontselect.frame2.frame.listbox1 insert end {50}
  .tpfontselect.frame2.frame.listbox1 insert end {52}
  .tpfontselect.frame2.frame.listbox1 insert end {54}
  .tpfontselect.frame2.frame.listbox1 insert end {56}
  .tpfontselect.frame2.frame.listbox1 insert end {58}
  .tpfontselect.frame2.frame.listbox1 insert end {60}
  .tpfontselect.frame2.frame.listbox1 insert end {62}
  .tpfontselect.frame2.frame.listbox1 insert end {64}
  .tpfontselect.frame2.frame.listbox1 insert end {68}
  .tpfontselect.frame2.frame.listbox1 insert end {70}
  .tpfontselect.frame2.frame.listbox1 insert end {72}

EndSrc.tpfontselect
}

proc DestroyWindow.tpfontselect {} {
     catch "destroy .tpfontselect"
     update
}

proc EndSrc.tpfontselect {} {
global TPshowFonts

wm iconphoto .tpfontselect tplogo16
set ::TPselWidget(.tpfontselect) $::TPcurWidget
.tpfontselect.frame1.frame.listbox1 delete 0 end
eval ".tpfontselect.frame1.frame.listbox1 insert end [lsort [font families]]"
TP_FontNameFill .tpfontselect.frame.frame4.listbox1
set TPshowFonts 1
}


proc ShowWindow.tpgenopts { args} {

  catch "destroy .tpgenopts"

  toplevel .tpgenopts   -relief {raised}  -background {#dcdcdc}  -highlightbackground {#dcdcdc}

  # Window manager configurations
  wm positionfrom .tpgenopts program
  wm sizefrom .tpgenopts program
  wm maxsize .tpgenopts 2560 1024
  wm minsize .tpgenopts 546 270
  wm protocol .tpgenopts WM_DELETE_WINDOW {DestroyWindow.tpgenopts}
  wm title .tpgenopts {TKproE general options}


  frame .tpgenopts.frame0  -borderwidth {2}  -relief {groove}  -background {#dcdcdc}  -height {27}  -highlightbackground {#dcdcdc}  -width {481}

  label .tpgenopts.frame0.label1  -activebackground {#dcdcdc}  -anchor {e}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10 bold}  -highlightbackground {#dcdcdc}  -text {Auto save interval:}  -width {32}

  spinbox .tpgenopts.frame0.spinbox1

  .tpgenopts.frame0.spinbox1 config  -background {linen}  -buttonbackground {#dcdcdc}  -command {set TPautosaveInterval [string trim $TPautosaveInterval]
if {[string is double -strict $TPautosaveInterval]} {
     if {$TPautosaveInterval < 0.0} { set TPautosaveInterval 0 }
     if {$TPautosaveInterval > 480.0} { set TPautosaveInterval 480 }
   } {

     }}  -font {Helvetica 10}  -textvariable {TPautosaveInterval}  -to {480.0}  -width {4}

  label .tpgenopts.frame0.label0  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10 bold}  -highlightbackground {#dcdcdc}  -text {minutes}  -width {32}

  frame .tpgenopts.frame2  -borderwidth {2}  -relief {groove}  -background {#dcdcdc}  -height {28}  -highlightbackground {#dcdcdc}  -width {481}

  label .tpgenopts.frame2.label3  -activebackground {#dcdcdc}  -anchor {e}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10 bold}  -highlightbackground {#dcdcdc}  -text {Ask for widget name on insertion:}  -width {32}

  checkbutton .tpgenopts.frame2.checkbutton4  -activebackground {#dcdcdc}  -background {#dcdcdc}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -variable {TPnewObjNameAsk}

  frame .tpgenopts.frame5  -borderwidth {2}  -relief {groove}  -background {#dcdcdc}  -height {28}  -highlightbackground {#dcdcdc}  -width {481}

  label .tpgenopts.frame5.label3  -activebackground {#dcdcdc}  -anchor {e}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10 bold}  -highlightbackground {#dcdcdc}  -text {Default geometry manager:}  -width {32}

  radiobutton .tpgenopts.frame5.radiobutton6  -activebackground {#dcdcdc}  -background {#dcdcdc}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {packer}  -value {pack}  -variable {TPgeoMgr}

  radiobutton .tpgenopts.frame5.radiobutton7  -activebackground {#dcdcdc}  -background {#dcdcdc}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {placer}  -value {place}  -variable {TPgeoMgr}

  radiobutton .tpgenopts.frame5.radiobutton8  -activebackground {#dcdcdc}  -background {#dcdcdc}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {gridder}  -value {grid}  -variable {TPgeoMgr}

  frame .tpgenopts.frame8  -borderwidth {2}  -relief {groove}  -background {#dcdcdc}  -height {28}  -highlightbackground {#dcdcdc}  -width {481}

  label .tpgenopts.frame8.label3  -activebackground {#dcdcdc}  -anchor {e}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10 bold}  -highlightbackground {#dcdcdc}  -text {Project type:}  -width {32}

  radiobutton .tpgenopts.frame8.radiobutton6  -activebackground {#dcdcdc}  -background {#dcdcdc}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {TCL only}  -value {TCL}  -variable {TPprojType}

  radiobutton .tpgenopts.frame8.radiobutton7  -activebackground {#dcdcdc}  -background {#dcdcdc}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {TCL/TK}  -value {TCL_TK}  -variable {TPprojType}

  frame .tpgenopts.frame4  -borderwidth {2}  -relief {groove}  -background {#dcdcdc}  -height {28}  -highlightbackground {#dcdcdc}  -width {481}

  label .tpgenopts.frame4.savelabel  -activebackground {#dcdcdc}  -anchor {e}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10 bold}  -highlightbackground {#dcdcdc}  -text {Save global variable values:}  -width {32}

  radiobutton .tpgenopts.frame4.savevaryes  -activebackground {#dcdcdc}  -background {#dcdcdc}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Yes}  -value {1}  -variable {TPsaveValues}

  radiobutton .tpgenopts.frame4.savevarno  -activebackground {#dcdcdc}  -background {#dcdcdc}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {No}  -value {0}  -variable {TPsaveValues}

  frame .tpgenopts.frame1  -borderwidth {2}  -relief {groove}  -background {#dcdcdc}  -height {28}  -highlightbackground {#dcdcdc}  -width {481}

  label .tpgenopts.frame1.label1  -activebackground {#dcdcdc}  -anchor {e}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10 bold}  -highlightbackground {#dcdcdc}  -text {Editor:}  -width {32}

  entry .tpgenopts.frame1.entry2  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -textvariable {TPeditor}

  frame .tpgenopts.frame3  -borderwidth {2}  -relief {groove}  -background {#dcdcdc}  -height {28}  -highlightbackground {#dcdcdc}  -width {481}

  label .tpgenopts.frame3.label1  -activebackground {#dcdcdc}  -anchor {e}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10 bold}  -highlightbackground {#dcdcdc}  -text {Auto save directory:}  -width {32}

  entry .tpgenopts.frame3.entry2  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -textvariable {TPautosaveDir}

  button .tpgenopts.frame3.button4  -activebackground {gray75}  -background {#e6e7e6}  -command {set TPautosaveDir [tk_chooseDirectory -initialdir $TPautosaveDir -parent . -title {Select TKproE Autosave directory}]}  -font {Helvetica 9}  -highlightbackground {#e6e7e6}  -highlightthickness {0}  -padx {3}  -text {Browse}

  frame .tpgenopts.frame9  -borderwidth {2}  -relief {groove}  -background {#dcdcdc}  -height {28}  -highlightbackground {#dcdcdc}  -width {481}

  label .tpgenopts.frame9.label1  -activebackground {#dcdcdc}  -anchor {e}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10 bold}  -highlightbackground {#dcdcdc}  -text {Default template directory:}  -width {32}

  entry .tpgenopts.frame9.entry2  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -textvariable {TPtemplateDir}

  button .tpgenopts.frame9.button4  -activebackground {gray75}  -background {#e6e7e6}  -command {set TPtemplateDir [tk_chooseDirectory -initialdir $TPtemplateDir -parent . -title {Select TKproE default template directory}]}  -font {Helvetica 9}  -highlightbackground {#e6e7e6}  -highlightthickness {0}  -padx {3}  -text {Browse}


  frame .tpgenopts.frame6  -borderwidth {2}  -background {#dcdcdc}  -height {28}  -highlightbackground {#dcdcdc}  -width {492}

  button .tpgenopts.frame6.button4  -activebackground {gray75}  -background {#dcdcdc}  -command {DestroyWindow.tpgenopts}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -padx {4}  -pady {0}  -text {Done}  -width {6}

  button .tpgenopts.frame6.button8  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_OptionsSave}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -padx {4}  -pady {0}  -text {Save}  -width {6}

  frame .tpgenopts.frame7  -borderwidth {2}  -relief {groove}  -background {#dcdcdc}  -height {28}  -highlightbackground {#dcdcdc}  -width {481}

  label .tpgenopts.frame7.label1  -activebackground {#dcdcdc}  -anchor {e}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10 bold}  -highlightbackground {#dcdcdc}  -text {PDF viewer:}  -width {32}

  entry .tpgenopts.frame7.entry2  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -textvariable {TPpdfViewer}
  
  # pack master .tpgenopts.frame0
  pack configure .tpgenopts.frame0.label1  -side left
  pack configure .tpgenopts.frame0.spinbox1  -side left
  pack configure .tpgenopts.frame0.label0  -side left

  # pack master .tpgenopts.frame2
  pack configure .tpgenopts.frame2.label3  -side left
  pack configure .tpgenopts.frame2.checkbutton4  -side left

  # pack master .tpgenopts.frame5
  pack configure .tpgenopts.frame5.label3  -side left
  pack configure .tpgenopts.frame5.radiobutton6  -side left
  pack configure .tpgenopts.frame5.radiobutton7  -side left
  pack configure .tpgenopts.frame5.radiobutton8  -side left

  # pack master .tpgenopts.frame8
  pack configure .tpgenopts.frame8.label3  -side left
  pack configure .tpgenopts.frame8.radiobutton6  -side left
  pack configure .tpgenopts.frame8.radiobutton7  -side left

  # pack master .tpgenopts.frame1
  pack configure .tpgenopts.frame1.label1  -side left
  pack configure .tpgenopts.frame1.entry2  -expand 1  -fill x  -side left

  # pack master .tpgenopts.frame3
  pack configure .tpgenopts.frame3.label1  -side left
  pack configure .tpgenopts.frame3.entry2  -expand 1  -fill x  -side left
  pack configure .tpgenopts.frame3.button4  -padx 3  -side right

  # pack master .tpgenopts.frame9
  pack configure .tpgenopts.frame9.label1  -side left
  pack configure .tpgenopts.frame9.entry2  -expand 1  -fill x  -side left
  pack configure .tpgenopts.frame9.button4  -padx 3  -side right

  # pack master .tpgenopts.frame6
  pack configure .tpgenopts.frame6.button4  -expand 1  -side left
  pack configure .tpgenopts.frame6.button8  -expand 1  -side left

  # pack master .tpgenopts.frame7
  pack configure .tpgenopts.frame7.label1  -side left
  pack configure .tpgenopts.frame7.entry2  -expand 1  -fill x  -side left

  # pack master .tpgenopts.frame4
  pack configure .tpgenopts.frame4.savelabel -side left
  pack configure .tpgenopts.frame4.savevaryes -side left
  pack configure .tpgenopts.frame4.savevarno -side left
  
  # pack master .tpgenopts
  pack configure .tpgenopts.frame0  -fill x
  pack configure .tpgenopts.frame3  -fill x
  pack configure .tpgenopts.frame9  -fill x
  pack configure .tpgenopts.frame2  -fill x
  pack configure .tpgenopts.frame5  -fill x
  pack configure .tpgenopts.frame8  -fill x
  pack configure .tpgenopts.frame1  -fill x
  pack configure .tpgenopts.frame6  -fill x  -side bottom
  pack configure .tpgenopts.frame7  -fill x
  pack configure .tpgenopts.frame4  -fill x

EndSrc.tpgenopts
}

proc DestroyWindow.tpgenopts {} {
     catch "destroy .tpgenopts"
     update
}

proc EndSrc.tpgenopts {} {
global TPautosaveInterval
global TPautosaveDir
global TPsaveInterval
global TPsaveDir

wm iconphoto .tpgenopts tplogo16
set TPautosaveInterval [expr int($TPsaveInterval / 60000)]
set TPautosaveDir $TPsaveDir
}


proc ShowWindow.tpgridder { args} {

  catch "destroy .tpgridder"

  toplevel .tpgridder   -background {#dcdcdc}  -highlightbackground {#dcdcdc}

  # Window manager configurations
  wm positionfrom .tpgridder program
  wm sizefrom .tpgridder program
  wm maxsize .tpgridder 2560 1024
  wm minsize .tpgridder 468 465
  wm protocol .tpgridder WM_DELETE_WINDOW {DestroyWindow.tpgridder}
  wm title .tpgridder {TKproE gridder}


  frame .tpgridder.frame28  -borderwidth {2}  -background {#dcdcdc}  -height {321}  -highlightbackground {#dcdcdc}  -width {562}

  frame .tpgridder.frame28.frame  -background {#dcdcdc}  -highlightbackground {#dcdcdc}

  scrollbar .tpgridder.frame28.frame.scrollbar3  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpgridder.frame28.frame.listbox1 xview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -orient {horizontal}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}

  scrollbar .tpgridder.frame28.frame.scrollbar2  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpgridder.frame28.frame.listbox1 yview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}

  listbox .tpgridder.frame28.frame.listbox1  -exportselection {0}  -font {Helvetica 10}  -height {5}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -xscrollcommand {.tpgridder.frame28.frame.scrollbar3 set}  -yscrollcommand {.tpgridder.frame28.frame.scrollbar2 set}
  # bindings
  bind .tpgridder.frame28.frame.listbox1 <Double-Button-1> {.tpgridder.frame28.frame30.listbox1 delete 0 end
set TPtemp  [%W get [%W curselection] ]
if {[winfo exists $TPtemp]} {
    eval ".tpgridder.frame28.frame30.listbox1 insert end [grid slaves $TPtemp]"
    set TPgrid(-columnconfigure) 0
    set TPgrid(-rowconfigure) 0
    TP_SnapshotChildren $TPtemp TPoptionsGrid grid
    .tpgridder.frame42.frame12.frame5.frame2.spinbox1 invoke buttondown
    .tpgridder.frame42.frame12.frame2.frame2.spinbox1 invoke buttondown
  } { .tpgridder.frame32.button4 invoke }}

  label .tpgridder.frame28.frame.label29  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Widgets}

  frame .tpgridder.frame28.frame.frame36  -borderwidth {2}  -relief {ridge}  -background {#dcdcdc}  -height {30}  -highlightbackground {#dcdcdc}  -width {249}

  button .tpgridder.frame28.frame.frame36.button37  -activebackground {gray75}  -background {#dcdcdc}  -command {set TPtemp [.tpgridder.frame28.frame.listbox1 curselection]
if {$TPtemp != {}} {
    set TPtemp [.tpgridder.frame28.frame.listbox1 get $TPtemp]
    if {[winfo exists $TPtemp]} {
        if {[catch {grid [.tpgridder.frame28.frame.listbox1 get [.tpgridder.frame28.frame.listbox1 curselection]]} TPresult]} {
	    tk_messageBox -icon error -message $TPresult -parent . -title {TKproE error} -type ok
	   }
        .tpgridder.frame32.button4 invoke
      } { .tpgridder.frame32.button4 invoke }
   }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Grid}  -width {5}

  frame .tpgridder.frame28.frame30  -background {#dcdcdc}  -highlightbackground {#dcdcdc}

  scrollbar .tpgridder.frame28.frame30.scrollbar3  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpgridder.frame28.frame30.listbox1 xview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -orient {horizontal}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}

  scrollbar .tpgridder.frame28.frame30.scrollbar2  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpgridder.frame28.frame30.listbox1 yview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}

  listbox .tpgridder.frame28.frame30.listbox1  -exportselection {0}  -font {Helvetica 10}  -height {5}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -xscrollcommand {.tpgridder.frame28.frame30.scrollbar3 set}  -yscrollcommand {.tpgridder.frame28.frame30.scrollbar2 set}
  # bindings
  bind .tpgridder.frame28.frame30.listbox1 <<ListboxSelect>> {set TPgridChild [%W get [%W curselection]]
if {[winfo exists $TPgridChild]} {
    foreach {TPidx TPvalue} [grid info $TPgridChild] {
	  set TPgrid($TPidx) $TPvalue
               }
    set TPgrid(stickyN) 0
    set TPgrid(stickyE) 0
    set TPgrid(stickyW) 0
    set TPgrid(stickyS) 0
    foreach TPtemp [split $TPgrid(-sticky) {}] {
	  set TPgrid(sticky[string toupper $TPtemp]) 1
               }
    TP_GridShowSticky {}
   } { .tpgridder.frame32.button4 invoke }}

  label .tpgridder.frame28.frame30.label29  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Children}

  frame .tpgridder.frame28.frame30.frame36  -borderwidth {2}  -relief {ridge}  -background {#dcdcdc}  -height {30}  -highlightbackground {#dcdcdc}  -width {249}

  button .tpgridder.frame28.frame30.frame36.button38  -activebackground {gray75}  -background {#dcdcdc}  -command {set TPtemp [.tpgridder.frame28.frame30.listbox1 curselection]
if {$TPtemp != {}} {
    set TPtemp [.tpgridder.frame28.frame30.listbox1 get $TPtemp]
    if {[winfo exists $TPtemp]} {
       grid remove [.tpgridder.frame28.frame30.listbox1 get [.tpgridder.frame28.frame30.listbox1 curselection]]
      }
    .tpgridder.frame32.button4 invoke
   }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {UnGrid}  -width {5}

  frame .tpgridder.frame28.frame40  -borderwidth {2}  -background {#dcdcdc}  -height {30}  -highlightbackground {#dcdcdc}  -width {8}

  frame .tpgridder.frame32  -relief {ridge}  -background {#dcdcdc}  -height {30}  -highlightbackground {#dcdcdc}  -width {364}

  button .tpgridder.frame32.button33  -activebackground {gray75}  -background {#dcdcdc}  -command {DestroyWindow.tpgridder}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Done}

  button .tpgridder.frame32.button34  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_SnapshotRestoreChildren TPoptionsGrid grid
.tpgridder.frame32.button4 invoke}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Undo}

  button .tpgridder.frame32.button35  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_SnapshotRestoreChildren TPoptionsGrid grid
DestroyWindow.tpgridder}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Cancel}

  button .tpgridder.frame32.button4  -activebackground {gray75}  -background {#dcdcdc}  -command {.tpgridder.frame28.frame.listbox1 delete 0 end
set TPidx -1
set TPcursel -1
set TPgrid(-padx) 0
set TPgrid(-pady) 0
set TPgrid(-ipadx) 0
set TPgrid(-ipady) 0
foreach TPtemp [TP_TreeSearch .] {
	.tpgridder.frame28.frame.listbox1 insert end $TPtemp
	incr TPidx
	if {$TPtemp == $TPgridParent} { set TPcursel $TPidx }
          }
if {$TPcursel > -1} {
   .tpgridder.frame28.frame.listbox1 selection set $TPcursel $TPcursel
   .tpgridder.frame28.frame30.listbox1 delete 0 end
   eval ".tpgridder.frame28.frame30.listbox1 insert end [grid slaves $TPgridParent]"
   .tpgridder.frame28.frame.listbox1 yview $TPcursel
   TP_SnapshotChildren $TPgridParent TPoptionsGrid grid
  } {
      set TPgridChild {}
      set TPgridParent {}
    }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {ReScan}

  frame .tpgridder.frame42  -relief {raised}  -background {#dcdcdc}  -height {96}  -highlightbackground {#dcdcdc}  -width {441}

  frame .tpgridder.frame42.frame1  -borderwidth {2}  -relief {raised}  -background {#dcdcdc}  -height {90}  -highlightbackground {#dcdcdc}  -width {182}

  label .tpgridder.frame42.frame1.label2  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {0}  -font {Helvetica 10 bold}  -highlightbackground {#dcdcdc}  -text {Cell Configure}  -width {25}

  frame .tpgridder.frame42.frame1.frame2  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#eeeeee}  -width {254}

  label .tpgridder.frame42.frame1.frame2.label6  -activebackground {#dcdcdc}  -anchor {e}  -background {#dcdcdc}  -borderwidth {0}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -relief {raised}  -text {column:}  -width {10}

  spinbox .tpgridder.frame42.frame1.frame2.spinbox1

  .tpgridder.frame42.frame1.frame2.spinbox1 config  -background {linen}  -buttonbackground {#dcdcdc}  -command {if {[string length $TPgridChild] > 0} {
   if {[winfo exists $TPgridChild]} { grid configure $TPgridChild -column $TPgrid(-column) }
  }}  -font {Helvetica 10}  -textvariable {TPgrid(-column)}  -to {40.0}  -width {4}
  # bindings
  bind .tpgridder.frame42.frame1.frame2.spinbox1 <FocusOut> {catch [%W cget -command]}
  bind .tpgridder.frame42.frame1.frame2.spinbox1 <Key-KP_Enter> {catch [%W cget -command]}
  bind .tpgridder.frame42.frame1.frame2.spinbox1 <Key-Return> {catch [%W cget -command]}

  label .tpgridder.frame42.frame1.frame2.label19  -activebackground {#dcdcdc}  -anchor {e}  -background {#dcdcdc}  -borderwidth {0}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -relief {raised}  -text {row:}  -width {10}

  spinbox .tpgridder.frame42.frame1.frame2.spinbox20

  .tpgridder.frame42.frame1.frame2.spinbox20 config  -background {linen}  -buttonbackground {#dcdcdc}  -command {if {[string length $TPgridChild] > 0} {
   if {[winfo exists $TPgridChild]} { grid configure $TPgridChild -row $TPgrid(-row) }
  }}  -font {Helvetica 10}  -textvariable {TPgrid(-row)}  -to {40.0}  -width {4}
  # bindings
  bind .tpgridder.frame42.frame1.frame2.spinbox20 <FocusOut> {catch [%W cget -command]}
  bind .tpgridder.frame42.frame1.frame2.spinbox20 <Key-KP_Enter> {catch [%W cget -command]}
  bind .tpgridder.frame42.frame1.frame2.spinbox20 <Key-Return> {catch [%W cget -command]}

  frame .tpgridder.frame42.frame1.frame17  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#eeeeee}  -width {188}

  label .tpgridder.frame42.frame1.frame17.label6  -activebackground {#dcdcdc}  -anchor {e}  -background {#dcdcdc}  -borderwidth {0}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -relief {raised}  -text {columnspan:}  -width {10}

  spinbox .tpgridder.frame42.frame1.frame17.spinbox1

  .tpgridder.frame42.frame1.frame17.spinbox1 config  -background {linen}  -buttonbackground {#dcdcdc}  -command {if {[string length $TPgridChild] > 0} {
   if {[winfo exists $TPgridChild]} { grid configure $TPgridChild -columnspan $TPgrid(-columnspan) }
  }}  -font {Helvetica 10}  -from {1.0}  -textvariable {TPgrid(-columnspan)}  -to {40.0}  -width {4}
  # bindings
  bind .tpgridder.frame42.frame1.frame17.spinbox1 <FocusOut> {catch [%W cget -command]}
  bind .tpgridder.frame42.frame1.frame17.spinbox1 <Key-KP_Enter> {catch [%W cget -command]}
  bind .tpgridder.frame42.frame1.frame17.spinbox1 <Key-Return> {catch [%W cget -command]}

  label .tpgridder.frame42.frame1.frame17.label21  -activebackground {#dcdcdc}  -anchor {e}  -background {#dcdcdc}  -borderwidth {0}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -relief {raised}  -text {rowspan:}  -width {10}

  spinbox .tpgridder.frame42.frame1.frame17.spinbox22

  .tpgridder.frame42.frame1.frame17.spinbox22 config  -background {linen}  -buttonbackground {#dcdcdc}  -command {if {[string length $TPgridChild] > 0} {
   if {[winfo exists $TPgridChild]} { grid configure $TPgridChild -rowspan $TPgrid(-rowspan) }
  }}  -font {Helvetica 10}  -from {1.0}  -textvariable {TPgrid(-rowspan)}  -to {40.0}  -width {4}
  # bindings
  bind .tpgridder.frame42.frame1.frame17.spinbox22 <FocusOut> {catch [%W cget -command]}
  bind .tpgridder.frame42.frame1.frame17.spinbox22 <Key-KP_Enter> {catch [%W cget -command]}
  bind .tpgridder.frame42.frame1.frame17.spinbox22 <Key-Return> {catch [%W cget -command]}

  frame .tpgridder.frame42.frame1.frame18  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#eeeeee}  -width {188}

  label .tpgridder.frame42.frame1.frame18.label6  -activebackground {#dcdcdc}  -anchor {e}  -background {#dcdcdc}  -borderwidth {0}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -relief {raised}  -text {in:}  -width {10}

  label .tpgridder.frame42.frame1.frame18.label0  -activebackground {#eeeeee}  -background {#dcdcdc}  -borderwidth {0}  -font {Helvetica 10}  -foreground {blue}  -highlightbackground {#eeeeee}  -text {.toplevel10.frameA}  -textvariable {TPgrid(-in)}

  frame .tpgridder.frame42.frame1.frame21  -borderwidth {2}  -background {#dcdcdc}  -height {20}  -highlightbackground {#dcdcdc}  -width {254}

  label .tpgridder.frame42.frame1.frame21.label22  -activebackground {#dcdcdc}  -anchor {e}  -background {#dcdcdc}  -borderwidth {0}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {ipadx:}  -width {10}

  spinbox .tpgridder.frame42.frame1.frame21.spinbox1

  .tpgridder.frame42.frame1.frame21.spinbox1 config  -background {linen}  -buttonbackground {#dcdcdc}  -command {if {[string length $TPpackChild] > 0} {
   if {[winfo exists $TPpackChild]} { pack configure $TPpackChild -ipadx $TPpack(-ipadx) }
  }}  -font {Helvetica 10}  -textvariable {TPgrid(-ipadx)}  -to {40.0}  -width {4}
  # bindings
  bind .tpgridder.frame42.frame1.frame21.spinbox1 <FocusOut> {catch [%W cget -command]}
  bind .tpgridder.frame42.frame1.frame21.spinbox1 <Key-KP_Enter> {catch [%W cget -command]}
  bind .tpgridder.frame42.frame1.frame21.spinbox1 <Key-Return> {catch [%W cget -command]}

  label .tpgridder.frame42.frame1.frame21.label24  -activebackground {#dcdcdc}  -anchor {e}  -background {#dcdcdc}  -borderwidth {0}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {ipady:}  -width {10}

  spinbox .tpgridder.frame42.frame1.frame21.spinbox25

  .tpgridder.frame42.frame1.frame21.spinbox25 config  -background {linen}  -buttonbackground {#dcdcdc}  -command {if {[string length $TPpackChild] > 0} {
   if {[winfo exists $TPpackChild]} { pack configure $TPpackChild -ipady $TPpack(-ipady) }
  }}  -font {Helvetica 10}  -textvariable {TPgrid(-ipady)}  -to {40.0}  -width {4}
  # bindings
  bind .tpgridder.frame42.frame1.frame21.spinbox25 <FocusOut> {catch [%W cget -command]}
  bind .tpgridder.frame42.frame1.frame21.spinbox25 <Key-KP_Enter> {catch [%W cget -command]}
  bind .tpgridder.frame42.frame1.frame21.spinbox25 <Key-Return> {catch [%W cget -command]}

  frame .tpgridder.frame42.frame1.frame26  -borderwidth {2}  -background {#dcdcdc}  -height {20}  -highlightbackground {#dcdcdc}  -width {254}

  label .tpgridder.frame42.frame1.frame26.label22  -activebackground {#dcdcdc}  -anchor {e}  -background {#dcdcdc}  -borderwidth {0}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {padx:}  -width {10}

  spinbox .tpgridder.frame42.frame1.frame26.spinbox1

  .tpgridder.frame42.frame1.frame26.spinbox1 config  -background {linen}  -buttonbackground {#dcdcdc}  -command {if {[string length $TPpackChild] > 0} {
   if {[winfo exists $TPpackChild]} { pack configure $TPpackChild -padx $TPpack(-padx) }
  }}  -font {Helvetica 10}  -textvariable {TPgrid(-padx)}  -to {40.0}  -width {4}
  # bindings
  bind .tpgridder.frame42.frame1.frame26.spinbox1 <FocusOut> {catch [%W cget -command]}
  bind .tpgridder.frame42.frame1.frame26.spinbox1 <Key-KP_Enter> {catch [%W cget -command]}
  bind .tpgridder.frame42.frame1.frame26.spinbox1 <Key-Return> {catch [%W cget -command]}

  label .tpgridder.frame42.frame1.frame26.label24  -activebackground {#dcdcdc}  -anchor {e}  -background {#dcdcdc}  -borderwidth {0}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {pady:}  -width {10}

  spinbox .tpgridder.frame42.frame1.frame26.spinbox25

  .tpgridder.frame42.frame1.frame26.spinbox25 config  -background {linen}  -buttonbackground {#dcdcdc}  -command {if {[string length $TPpackChild] > 0} {
   if {[winfo exists $TPpackChild]} { pack configure $TPpackChild -pady $TPpack(-pady) }
  }}  -font {Helvetica 10}  -textvariable {TPgrid(-pady)}  -to {40.0}  -width {4}
  # bindings
  bind .tpgridder.frame42.frame1.frame26.spinbox25 <FocusOut> {catch [%W cget -command]}
  bind .tpgridder.frame42.frame1.frame26.spinbox25 <Key-KP_Enter> {catch [%W cget -command]}
  bind .tpgridder.frame42.frame1.frame26.spinbox25 <Key-Return> {catch [%W cget -command]}

  frame .tpgridder.frame42.frame1.frame30  -borderwidth {2}  -background {#dcdcdc}  -height {77}  -highlightbackground {#eeeeee}  -width {182}

  frame .tpgridder.frame42.frame1.frame30.frame23  -relief {raised}  -background {#eeeeee}  -height {15}  -highlightbackground {#eeeeee}  -width {106}

  button .tpgridder.frame42.frame1.frame30.frame23.button24  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_GridShowSticky N}  -font {Helvetica 4}  -foreground {black}  -height {6}  -highlightbackground {#eeeeee}  -highlightthickness {0}  -image {tpblank}  -width {60}

  button .tpgridder.frame42.frame1.frame30.frame23.button25  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_GridShowSticky {N W}}  -font {Helvetica 4}  -foreground {black}  -height {6}  -highlightbackground {#eeeeee}  -highlightthickness {0}  -image {tpblank}  -width {6}

  button .tpgridder.frame42.frame1.frame30.frame23.button29  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_GridShowSticky {N E}}  -font {Helvetica 4}  -foreground {black}  -height {6}  -highlightbackground {#eeeeee}  -highlightthickness {0}  -image {tpblank}  -width {6}

  frame .tpgridder.frame42.frame1.frame30.frame32  -relief {raised}  -background {#dcdcdc}  -height {15}  -highlightbackground {#eeeeee}  -width {106}

  button .tpgridder.frame42.frame1.frame30.frame32.button25  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_GridShowSticky W}  -font {Helvetica 2}  -foreground {black}  -height {60}  -highlightbackground {#eeeeee}  -highlightthickness {0}  -image {tpblank}  -width {6}

  button .tpgridder.frame42.frame1.frame30.frame32.button29  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_GridShowSticky E}  -font {Helvetica 2}  -foreground {black}  -height {60}  -highlightbackground {#eeeeee}  -highlightthickness {0}  -image {tpblank}  -width {6}

  frame .tpgridder.frame42.frame1.frame30.frame32.frame0  -borderwidth {2}  -relief {raised}  -background {skyblue}  -height {20}  -highlightbackground {#eeeeee}  -width {20}

  frame .tpgridder.frame42.frame1.frame30.frame33  -relief {raised}  -background {#eeeeee}  -height {15}  -highlightbackground {#eeeeee}  -width {106}

  button .tpgridder.frame42.frame1.frame30.frame33.button24  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_GridShowSticky S}  -font {Helvetica 4}  -foreground {black}  -height {6}  -highlightbackground {#eeeeee}  -highlightthickness {0}  -image {tpblank}  -width {60}

  button .tpgridder.frame42.frame1.frame30.frame33.button25  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_GridShowSticky {S W}}  -font {Helvetica 4}  -foreground {black}  -height {6}  -highlightbackground {#eeeeee}  -highlightthickness {0}  -image {tpblank}  -width {6}

  button .tpgridder.frame42.frame1.frame30.frame33.button29  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_GridShowSticky {S E}}  -font {Helvetica 4}  -foreground {black}  -height {6}  -highlightbackground {#eeeeee}  -highlightthickness {0}  -image {tpblank}  -width {6}

  label .tpgridder.frame42.frame1.frame30.label13  -activebackground {#dcdcdc}  -anchor {e}  -background {#dcdcdc}  -borderwidth {0}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {sticky:}  -width {10}

  frame .tpgridder.frame42.frame12  -relief {raised}  -background {#dcdcdc}  -height {256}  -highlightbackground {#dcdcdc}  -width {236}

  frame .tpgridder.frame42.frame12.frame5  -borderwidth {2}  -relief {raised}  -background {#dcdcdc}  -height {124}  -highlightbackground {#dcdcdc}  -width {192}

  frame .tpgridder.frame42.frame12.frame5.frame2  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#eeeeee}  -width {188}

  label .tpgridder.frame42.frame12.frame5.frame2.label6  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {0}  -font {Helvetica 10 bold}  -highlightbackground {#dcdcdc}  -relief {raised}  -text {Column Configure: }  -width {17}

  spinbox .tpgridder.frame42.frame12.frame5.frame2.spinbox1

  .tpgridder.frame42.frame12.frame5.frame2.spinbox1 config  -background {linen}  -buttonbackground {#dcdcdc}  -command {if {[string length $TPgridParent] > 0} {
   if {[winfo exists $TPgridParent]} {
       set TPtemp [lindex [grid size $TPgridParent] 0]
       if {$TPgrid(-columnconfigure) >= $TPtemp} {
          set TPgrid(-columnconfigure) $TPtemp
          incr TPgrid(-columnconfigure) -1
         }
       foreach {TPtemp1 TPtemp2} [grid columnconfigure $TPgridParent $TPgrid(-columnconfigure)] {
	      set TPgrid($TPtemp1) $TPtemp2
	     }
    }
  }}  -font {Helvetica 10}  -textvariable {TPgrid(-columnconfigure)}  -to {40.0}  -width {4}
  # bindings
  bind .tpgridder.frame42.frame12.frame5.frame2.spinbox1 <FocusOut> {catch [%W cget -command]}
  bind .tpgridder.frame42.frame12.frame5.frame2.spinbox1 <Key-KP_Enter> {catch [%W cget -command]}
  bind .tpgridder.frame42.frame12.frame5.frame2.spinbox1 <Key-Return> {catch [%W cget -command]}

  frame .tpgridder.frame42.frame12.frame5.frame4  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#eeeeee}  -width {188}

  label .tpgridder.frame42.frame12.frame5.frame4.label6  -activebackground {#dcdcdc}  -anchor {e}  -background {#dcdcdc}  -borderwidth {0}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -relief {raised}  -text {minsize:}  -width {9}

  spinbox .tpgridder.frame42.frame12.frame5.frame4.spinbox1

  .tpgridder.frame42.frame12.frame5.frame4.spinbox1 config  -background {linen}  -buttonbackground {#dcdcdc}  -command {if {[string length $TPgridParent] > 0} {
   if {[winfo exists $TPgridParent]} { grid columnconfigure $TPgridParent $TPgrid(-columnconfigure) -minsize $TPgrid(-minsize) }
  }}  -font {Helvetica 10}  -textvariable {TPgrid(-minsize)}  -to {40.0}  -width {4}
  # bindings
  bind .tpgridder.frame42.frame12.frame5.frame4.spinbox1 <FocusOut> {catch [%W cget -command]}
  bind .tpgridder.frame42.frame12.frame5.frame4.spinbox1 <Key-KP_Enter> {catch [%W cget -command]}
  bind .tpgridder.frame42.frame12.frame5.frame4.spinbox1 <Key-Return> {catch [%W cget -command]}

  frame .tpgridder.frame42.frame12.frame5.frame7  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#eeeeee}  -width {188}

  label .tpgridder.frame42.frame12.frame5.frame7.label6  -activebackground {#dcdcdc}  -anchor {e}  -background {#dcdcdc}  -borderwidth {0}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -relief {raised}  -text {weight:}  -width {9}

  spinbox .tpgridder.frame42.frame12.frame5.frame7.spinbox1

  .tpgridder.frame42.frame12.frame5.frame7.spinbox1 config  -background {linen}  -buttonbackground {#dcdcdc}  -command {if {[string length $TPgridParent] > 0} {
   if {[winfo exists $TPgridParent]} { grid columnconfigure $TPgridParent $TPgrid(-columnconfigure) -weight $TPgrid(-weight) }
  }}  -font {Helvetica 10}  -textvariable {TPgrid(-weight)}  -to {40.0}  -width {4}
  # bindings
  bind .tpgridder.frame42.frame12.frame5.frame7.spinbox1 <FocusOut> {catch [%W cget -command]}
  bind .tpgridder.frame42.frame12.frame5.frame7.spinbox1 <Key-KP_Enter> {catch [%W cget -command]}
  bind .tpgridder.frame42.frame12.frame5.frame7.spinbox1 <Key-Return> {catch [%W cget -command]}

  frame .tpgridder.frame42.frame12.frame5.frame8  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#eeeeee}  -width {188}

  label .tpgridder.frame42.frame12.frame5.frame8.label6  -activebackground {#dcdcdc}  -anchor {e}  -background {#dcdcdc}  -borderwidth {0}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -relief {raised}  -text {pad:}  -width {9}

  spinbox .tpgridder.frame42.frame12.frame5.frame8.spinbox1

  .tpgridder.frame42.frame12.frame5.frame8.spinbox1 config  -background {linen}  -buttonbackground {#dcdcdc}  -command {if {[string length $TPgridParent] > 0} {
   if {[winfo exists $TPgridParent]} { grid columnconfigure $TPgridParent $TPgrid(-columnconfigure) -pad $TPgrid(-pad) }
  }}  -font {Helvetica 10}  -textvariable {TPgrid(-pad)}  -to {40.0}  -width {4}
  # bindings
  bind .tpgridder.frame42.frame12.frame5.frame8.spinbox1 <FocusOut> {catch [%W cget -command]}
  bind .tpgridder.frame42.frame12.frame5.frame8.spinbox1 <Key-KP_Enter> {catch [%W cget -command]}
  bind .tpgridder.frame42.frame12.frame5.frame8.spinbox1 <Key-Return> {catch [%W cget -command]}

  frame .tpgridder.frame42.frame12.frame5.frame11  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#eeeeee}  -width {188}

  label .tpgridder.frame42.frame12.frame5.frame11.label6  -activebackground {#dcdcdc}  -anchor {e}  -background {#dcdcdc}  -borderwidth {0}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -relief {raised}  -text {uniform:}  -width {9}

  entry .tpgridder.frame42.frame12.frame5.frame11.entry12  -background {#eeeeee}  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#447bcd}  -selectforeground {#ffffff}  -textvariable {TPgrid(-uniform)}  -width {10}
  # bindings
  bind .tpgridder.frame42.frame12.frame5.frame11.entry12 <FocusOut> {if {[string length $TPgridParent] > 0} {
    if {[winfo exists $TPgridParent]} { grid columnconfigure $TPgridParent $TPgrid(-columnconfigure) -uniform $TPgrid(-uniform) }
   }}
  bind .tpgridder.frame42.frame12.frame5.frame11.entry12 <Key-Return> {if {[string length $TPgridParent] > 0} {
    if {[winfo exists $TPgridParent]} { grid columnconfigure $TPgridParent $TPgrid(-columnconfigure) -uniform $TPgrid(-uniform) }
   }}

  frame .tpgridder.frame42.frame12.frame2  -borderwidth {2}  -relief {raised}  -background {#dcdcdc}  -height {124}  -highlightbackground {#dcdcdc}  -width {192}

  frame .tpgridder.frame42.frame12.frame2.frame2  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#eeeeee}  -width {188}

  label .tpgridder.frame42.frame12.frame2.frame2.label6  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {0}  -font {Helvetica 10 bold}  -highlightbackground {#dcdcdc}  -relief {raised}  -text {Row Configure: }  -width {17}

  spinbox .tpgridder.frame42.frame12.frame2.frame2.spinbox1

  .tpgridder.frame42.frame12.frame2.frame2.spinbox1 config  -background {linen}  -buttonbackground {#dcdcdc}  -command {if {[string length $TPgridParent] > 0} {
   if {[winfo exists $TPgridParent]} {
       set TPtemp [lindex [grid size $TPgridParent] 1]
       if {$TPgrid(-rowconfigure) >= $TPtemp} {
          set TPgrid(-rowconfigure) $TPtemp
          incr TPgrid(-rowconfigure) -1
         }
       foreach {TPtemp1 TPtemp2} [grid rowconfigure $TPgridParent $TPgrid(-rowconfigure)] {
	      set TPgrid(${TPtemp1}R) $TPtemp2
	     }
    }
  }}  -font {Helvetica 10}  -textvariable {TPgrid(-rowconfigure)}  -to {40.0}  -width {4}
  # bindings
  bind .tpgridder.frame42.frame12.frame2.frame2.spinbox1 <FocusOut> {catch [%W cget -command]}
  bind .tpgridder.frame42.frame12.frame2.frame2.spinbox1 <Key-KP_Enter> {catch [%W cget -command]}
  bind .tpgridder.frame42.frame12.frame2.frame2.spinbox1 <Key-Return> {catch [%W cget -command]}

  frame .tpgridder.frame42.frame12.frame2.frame4  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#eeeeee}  -width {188}

  label .tpgridder.frame42.frame12.frame2.frame4.label6  -activebackground {#dcdcdc}  -anchor {e}  -background {#dcdcdc}  -borderwidth {0}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -relief {raised}  -text {minsize:}  -width {9}

  spinbox .tpgridder.frame42.frame12.frame2.frame4.spinbox1

  .tpgridder.frame42.frame12.frame2.frame4.spinbox1 config  -background {linen}  -buttonbackground {#dcdcdc}  -command {if {[string length $TPgridParent] > 0} {
   if {[winfo exists $TPgridParent]} { grid rowconfigure $TPgridParent $TPgrid(-rowconfigure) -minsize $TPgrid(-minsizeR) }
  }}  -font {Helvetica 10}  -textvariable {TPgrid(-minsizeR)}  -to {40.0}  -width {4}
  # bindings
  bind .tpgridder.frame42.frame12.frame2.frame4.spinbox1 <FocusOut> {catch [%W cget -command]}
  bind .tpgridder.frame42.frame12.frame2.frame4.spinbox1 <Key-KP_Enter> {catch [%W cget -command]}
  bind .tpgridder.frame42.frame12.frame2.frame4.spinbox1 <Key-Return> {catch [%W cget -command]}

  frame .tpgridder.frame42.frame12.frame2.frame7  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#eeeeee}  -width {188}

  label .tpgridder.frame42.frame12.frame2.frame7.label6  -activebackground {#dcdcdc}  -anchor {e}  -background {#dcdcdc}  -borderwidth {0}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -relief {raised}  -text {weight:}  -width {9}

  spinbox .tpgridder.frame42.frame12.frame2.frame7.spinbox1

  .tpgridder.frame42.frame12.frame2.frame7.spinbox1 config  -background {linen}  -buttonbackground {#dcdcdc}  -command {if {[string length $TPgridParent] > 0} {
   if {[winfo exists $TPgridParent]} { grid rowconfigure $TPgridParent $TPgrid(-rowconfigure) -weight $TPgrid(-weightR) }
  }}  -font {Helvetica 10}  -textvariable {TPgrid(-weightR)}  -to {40.0}  -width {4}
  # bindings
  bind .tpgridder.frame42.frame12.frame2.frame7.spinbox1 <FocusOut> {catch [%W cget -command]}
  bind .tpgridder.frame42.frame12.frame2.frame7.spinbox1 <Key-KP_Enter> {catch [%W cget -command]}
  bind .tpgridder.frame42.frame12.frame2.frame7.spinbox1 <Key-Return> {catch [%W cget -command]}

  frame .tpgridder.frame42.frame12.frame2.frame8  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#eeeeee}  -width {188}

  label .tpgridder.frame42.frame12.frame2.frame8.label6  -activebackground {#dcdcdc}  -anchor {e}  -background {#dcdcdc}  -borderwidth {0}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -relief {raised}  -text {pad:}  -width {9}

  spinbox .tpgridder.frame42.frame12.frame2.frame8.spinbox1

  .tpgridder.frame42.frame12.frame2.frame8.spinbox1 config  -background {linen}  -buttonbackground {#dcdcdc}  -command {if {[string length $TPgridParent] > 0} {
   if {[winfo exists $TPgridParent]} { grid rowconfigure $TPgridParent $TPgrid(-rowconfigure) -pad $TPgrid(-padR) }
  }}  -font {Helvetica 10}  -textvariable {TPgrid(-padR)}  -to {40.0}  -width {4}
  # bindings
  bind .tpgridder.frame42.frame12.frame2.frame8.spinbox1 <FocusOut> {catch [%W cget -command]}
  bind .tpgridder.frame42.frame12.frame2.frame8.spinbox1 <Key-KP_Enter> {catch [%W cget -command]}
  bind .tpgridder.frame42.frame12.frame2.frame8.spinbox1 <Key-Return> {catch [%W cget -command]}

  frame .tpgridder.frame42.frame12.frame2.frame11  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#eeeeee}  -width {188}

  label .tpgridder.frame42.frame12.frame2.frame11.label6  -activebackground {#dcdcdc}  -anchor {e}  -background {#dcdcdc}  -borderwidth {0}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -relief {raised}  -text {uniform:}  -width {9}

  entry .tpgridder.frame42.frame12.frame2.frame11.entry12  -background {#eeeeee}  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#447bcd}  -selectforeground {#ffffff}  -textvariable {TPgrid(-uniformR)}  -width {10}
  # bindings
  bind .tpgridder.frame42.frame12.frame2.frame11.entry12 <FocusOut> {if {[string length $TPgridParent] > 0} {
    if {[winfo exists $TPgridParent]} { grid columnconfigure $TPgridParent $TPgrid(-columnconfigure) -uniform $TPgrid(-uniform) }
   }}
  bind .tpgridder.frame42.frame12.frame2.frame11.entry12 <Key-Return> {if {[string length $TPgridParent] > 0} {
    if {[winfo exists $TPgridParent]} { grid columnconfigure $TPgridParent $TPgrid(-columnconfigure) -uniform $TPgrid(-uniform) }
   }}

  # pack master .tpgridder.frame28
  pack configure .tpgridder.frame28.frame  -expand 1  -fill both  -side left
  pack configure .tpgridder.frame28.frame40  -side left
  pack configure .tpgridder.frame28.frame30  -expand 1  -fill both  -side left

  # pack master .tpgridder.frame28.frame
  pack configure .tpgridder.frame28.frame.label29
  pack configure .tpgridder.frame28.frame.frame36  -fill x  -side bottom
  pack configure .tpgridder.frame28.frame.scrollbar2  -fill y  -side left
  pack configure .tpgridder.frame28.frame.listbox1  -expand 1  -fill both
  pack configure .tpgridder.frame28.frame.scrollbar3  -fill x  -side bottom

  # pack master .tpgridder.frame28.frame.frame36
  pack configure .tpgridder.frame28.frame.frame36.button37  -side left

  # pack master .tpgridder.frame28.frame30
  pack configure .tpgridder.frame28.frame30.label29
  pack configure .tpgridder.frame28.frame30.frame36  -fill x  -side bottom
  pack configure .tpgridder.frame28.frame30.scrollbar2  -fill y  -side left
  pack configure .tpgridder.frame28.frame30.listbox1  -expand 1  -fill both
  pack configure .tpgridder.frame28.frame30.scrollbar3  -fill x  -side bottom

  # pack master .tpgridder.frame28.frame30.frame36
  pack configure .tpgridder.frame28.frame30.frame36.button38  -side right

  # pack master .tpgridder.frame32
  pack configure .tpgridder.frame32.button33  -side left
  pack configure .tpgridder.frame32.button35  -side right
  pack configure .tpgridder.frame32.button34  -side right
  pack configure .tpgridder.frame32.button4  -side left

  # pack master .tpgridder.frame42
  pack configure .tpgridder.frame42.frame1  -expand 1  -fill both  -side left
  pack configure .tpgridder.frame42.frame12  -expand 1  -fill both  -side left

  # pack master .tpgridder.frame42.frame1
  pack configure .tpgridder.frame42.frame1.label2
  pack configure .tpgridder.frame42.frame1.frame2  -fill x
  pack configure .tpgridder.frame42.frame1.frame17  -fill x
  pack configure .tpgridder.frame42.frame1.frame21  -fill x
  pack configure .tpgridder.frame42.frame1.frame26  -fill x
  pack configure .tpgridder.frame42.frame1.frame30  -anchor w  -pady 3
  pack configure .tpgridder.frame42.frame1.frame18  -fill x

  # pack master .tpgridder.frame42.frame1.frame2
  pack configure .tpgridder.frame42.frame1.frame2.label6  -side left
  pack configure .tpgridder.frame42.frame1.frame2.spinbox1  -side left
  pack configure .tpgridder.frame42.frame1.frame2.label19  -side left
  pack configure .tpgridder.frame42.frame1.frame2.spinbox20  -side left

  # pack master .tpgridder.frame42.frame1.frame17
  pack configure .tpgridder.frame42.frame1.frame17.label6  -side left
  pack configure .tpgridder.frame42.frame1.frame17.spinbox1  -side left
  pack configure .tpgridder.frame42.frame1.frame17.label21  -side left
  pack configure .tpgridder.frame42.frame1.frame17.spinbox22  -side left

  # pack master .tpgridder.frame42.frame1.frame18
  pack configure .tpgridder.frame42.frame1.frame18.label6  -side left
  pack configure .tpgridder.frame42.frame1.frame18.label0  -side left

  # pack master .tpgridder.frame42.frame1.frame21
  pack configure .tpgridder.frame42.frame1.frame21.label22  -side left
  pack configure .tpgridder.frame42.frame1.frame21.spinbox1  -side left
  pack configure .tpgridder.frame42.frame1.frame21.label24  -side left
  pack configure .tpgridder.frame42.frame1.frame21.spinbox25  -side left

  # pack master .tpgridder.frame42.frame1.frame26
  pack configure .tpgridder.frame42.frame1.frame26.label22  -side left
  pack configure .tpgridder.frame42.frame1.frame26.spinbox1  -side left
  pack configure .tpgridder.frame42.frame1.frame26.label24  -side left
  pack configure .tpgridder.frame42.frame1.frame26.spinbox25  -side left

  # pack master .tpgridder.frame42.frame1.frame30
  pack configure .tpgridder.frame42.frame1.frame30.label13  -side left
  pack configure .tpgridder.frame42.frame1.frame30.frame23
  pack configure .tpgridder.frame42.frame1.frame30.frame32  -fill x
  pack configure .tpgridder.frame42.frame1.frame30.frame33

  # pack master .tpgridder.frame42.frame1.frame30.frame23
  pack configure .tpgridder.frame42.frame1.frame30.frame23.button29  -side right
  pack configure .tpgridder.frame42.frame1.frame30.frame23.button25  -side left
  pack configure .tpgridder.frame42.frame1.frame30.frame23.button24

  # pack master .tpgridder.frame42.frame1.frame30.frame32
  pack configure .tpgridder.frame42.frame1.frame30.frame32.button25  -anchor w  -side left
  pack configure .tpgridder.frame42.frame1.frame30.frame32.button29  -anchor e  -side right
  pack configure .tpgridder.frame42.frame1.frame30.frame32.frame0  -expand 1  -side left

  # pack master .tpgridder.frame42.frame1.frame30.frame33
  pack configure .tpgridder.frame42.frame1.frame30.frame33.button29  -side right
  pack configure .tpgridder.frame42.frame1.frame30.frame33.button25  -side left
  pack configure .tpgridder.frame42.frame1.frame30.frame33.button24

  # pack master .tpgridder.frame42.frame12
  pack configure .tpgridder.frame42.frame12.frame5  -fill x
  pack configure .tpgridder.frame42.frame12.frame2  -fill x

  # pack master .tpgridder.frame42.frame12.frame5
  pack configure .tpgridder.frame42.frame12.frame5.frame2  -fill x
  pack configure .tpgridder.frame42.frame12.frame5.frame4  -fill x
  pack configure .tpgridder.frame42.frame12.frame5.frame7  -fill x
  pack configure .tpgridder.frame42.frame12.frame5.frame8  -fill x
  pack configure .tpgridder.frame42.frame12.frame5.frame11  -fill x

  # pack master .tpgridder.frame42.frame12.frame5.frame2
  pack configure .tpgridder.frame42.frame12.frame5.frame2.label6  -side left
  pack configure .tpgridder.frame42.frame12.frame5.frame2.spinbox1  -side left

  # pack master .tpgridder.frame42.frame12.frame5.frame4
  pack configure .tpgridder.frame42.frame12.frame5.frame4.label6  -side left
  pack configure .tpgridder.frame42.frame12.frame5.frame4.spinbox1  -side left

  # pack master .tpgridder.frame42.frame12.frame5.frame7
  pack configure .tpgridder.frame42.frame12.frame5.frame7.label6  -side left
  pack configure .tpgridder.frame42.frame12.frame5.frame7.spinbox1  -side left

  # pack master .tpgridder.frame42.frame12.frame5.frame8
  pack configure .tpgridder.frame42.frame12.frame5.frame8.label6  -side left
  pack configure .tpgridder.frame42.frame12.frame5.frame8.spinbox1  -side left

  # pack master .tpgridder.frame42.frame12.frame5.frame11
  pack configure .tpgridder.frame42.frame12.frame5.frame11.label6  -side left
  pack configure .tpgridder.frame42.frame12.frame5.frame11.entry12  -expand 1  -fill x  -side left

  # pack master .tpgridder.frame42.frame12.frame2
  pack configure .tpgridder.frame42.frame12.frame2.frame2  -fill x
  pack configure .tpgridder.frame42.frame12.frame2.frame4  -fill x
  pack configure .tpgridder.frame42.frame12.frame2.frame7  -fill x
  pack configure .tpgridder.frame42.frame12.frame2.frame8  -fill x
  pack configure .tpgridder.frame42.frame12.frame2.frame11  -fill x

  # pack master .tpgridder.frame42.frame12.frame2.frame2
  pack configure .tpgridder.frame42.frame12.frame2.frame2.label6  -side left
  pack configure .tpgridder.frame42.frame12.frame2.frame2.spinbox1  -side left

  # pack master .tpgridder.frame42.frame12.frame2.frame4
  pack configure .tpgridder.frame42.frame12.frame2.frame4.label6  -side left
  pack configure .tpgridder.frame42.frame12.frame2.frame4.spinbox1  -side left

  # pack master .tpgridder.frame42.frame12.frame2.frame7
  pack configure .tpgridder.frame42.frame12.frame2.frame7.label6  -side left
  pack configure .tpgridder.frame42.frame12.frame2.frame7.spinbox1  -side left

  # pack master .tpgridder.frame42.frame12.frame2.frame8
  pack configure .tpgridder.frame42.frame12.frame2.frame8.label6  -side left
  pack configure .tpgridder.frame42.frame12.frame2.frame8.spinbox1  -side left

  # pack master .tpgridder.frame42.frame12.frame2.frame11
  pack configure .tpgridder.frame42.frame12.frame2.frame11.label6  -side left
  pack configure .tpgridder.frame42.frame12.frame2.frame11.entry12  -expand 1  -fill x  -side left

  # pack master .tpgridder
  pack configure .tpgridder.frame42  -fill x
  pack configure .tpgridder.frame28  -expand 1  -fill both
  pack configure .tpgridder.frame32  -fill x  -side bottom

  .tpgridder.frame28.frame.listbox1 insert end {.}



EndSrc.tpgridder
}

proc DestroyWindow.tpgridder {} {
     catch "destroy .tpgridder"
     update
}

proc EndSrc.tpgridder {} {
wm iconphoto .tpgridder tplogo16
.tpgridder.frame32.button4 invoke
}


proc ShowWindow.tpiconlib { args} {

  catch "destroy .tpiconlib"

  toplevel .tpiconlib   -relief {raised}  -background {#eeeeee}  -highlightbackground {#eeeeee}

  # Window manager configurations
  wm positionfrom .tpiconlib program
  wm sizefrom .tpiconlib program
  wm maxsize .tpiconlib 2560 1024
  wm minsize .tpiconlib 550 322
  wm protocol .tpiconlib WM_DELETE_WINDOW {.tpiconlib.frame10.button11 invoke}
  wm title .tpiconlib {TKproE icon library}


  frame .tpiconlib.frame1  -borderwidth {2}  -background {#eeeeee}  -height {28}  -highlightbackground {#eeeeee}  -width {851}

  label .tpiconlib.frame1.label2  -activebackground {#eeeeee}  -anchor {w}  -background {#eeeeee}  -borderwidth {0}  -font {Helvetica 10 bold}  -highlightbackground {#eeeeee}  -relief {raised}  -text { Standard Library:}  -width {16}

  radiobutton .tpiconlib.frame1.radiobutton2  -activebackground {#eeeeee}  -background {#eeeeee}  -command {TP_IconLibShow}  -font {Helvetica 10}  -highlightbackground {#eeeeee}  -text {Crystal}  -value {.crystal}  -variable {TPselTheme}

  radiobutton .tpiconlib.frame1.radiobutton3  -activebackground {#eeeeee}  -background {#eeeeee}  -command {TP_IconLibShow}  -font {Helvetica 10}  -highlightbackground {#eeeeee}  -text {EDA}  -value {.eda}  -variable {TPselTheme}

  radiobutton .tpiconlib.frame1.radiobutton4  -activebackground {#eeeeee}  -background {#eeeeee}  -command {TP_IconLibShow}  -font {Helvetica 10}  -highlightbackground {#eeeeee}  -text {Ikons}  -value {.ikons}  -variable {TPselTheme}

  radiobutton .tpiconlib.frame1.radiobutton5  -activebackground {#eeeeee}  -background {#eeeeee}  -command {TP_IconLibShow}  -font {Helvetica 10}  -highlightbackground {#eeeeee}  -text {KDE}  -value {.kde}  -variable {TPselTheme}

  radiobutton .tpiconlib.frame1.radiobutton6  -activebackground {#eeeeee}  -background {#eeeeee}  -command {TP_IconLibShow}  -font {Helvetica 10}  -highlightbackground {#eeeeee}  -text {Klassic}  -value {.klassic}  -variable {TPselTheme}

  radiobutton .tpiconlib.frame1.radiobutton7  -activebackground {#eeeeee}  -background {#eeeeee}  -command {TP_IconLibShow}  -font {Helvetica 10}  -highlightbackground {#eeeeee}  -text {SAT}  -value {.sat}  -variable {TPselTheme}

  radiobutton .tpiconlib.frame1.radiobutton8  -activebackground {#eeeeee}  -background {#eeeeee}  -command {TP_IconLibShow}  -font {Helvetica 10}  -highlightbackground {#eeeeee}  -text {Slick}  -value {.slick}  -variable {TPselTheme}

  frame .tpiconlib.frame9  -borderwidth {2}  -background {#eeeeee}  -height {28}  -highlightbackground {#eeeeee}  -width {851}

  label .tpiconlib.frame9.label2  -activebackground {#eeeeee}  -anchor {w}  -background {#eeeeee}  -borderwidth {0}  -font {Helvetica 10 bold}  -highlightbackground {#eeeeee}  -relief {raised}  -text { Full Library:}  -width {16}

  radiobutton .tpiconlib.frame9.radiobutton3  -activebackground {#eeeeee}  -background {#eeeeee}  -command {TP_IconLibShow}  -font {Helvetica 10}  -highlightbackground {#eeeeee}  -text {Crystal}  -value {-sample.crystal}  -variable {TPselTheme}

  radiobutton .tpiconlib.frame9.radiobutton4  -activebackground {#eeeeee}  -background {#eeeeee}  -command {TP_IconLibShow}  -font {Helvetica 10}  -highlightbackground {#eeeeee}  -text {Ikons}  -value {-sample.ikons}  -variable {TPselTheme}

  radiobutton .tpiconlib.frame9.radiobutton5  -activebackground {#eeeeee}  -background {#eeeeee}  -command {TP_IconLibShow}  -font {Helvetica 10}  -highlightbackground {#eeeeee}  -text {KDE}  -value {-sample.kde}  -variable {TPselTheme}

  radiobutton .tpiconlib.frame9.radiobutton6  -activebackground {#eeeeee}  -background {#eeeeee}  -command {TP_IconLibShow}  -font {Helvetica 10}  -highlightbackground {#eeeeee}  -text {Klassic}  -value {-sample.klassic}  -variable {TPselTheme}

  radiobutton .tpiconlib.frame9.radiobutton8  -activebackground {#eeeeee}  -background {#eeeeee}  -command {TP_IconLibShow}  -font {Helvetica 10}  -highlightbackground {#eeeeee}  -text {Slick}  -value {-sample.slick}  -variable {TPselTheme}

  radiobutton .tpiconlib.frame9.radiobutton9  -activebackground {#eeeeee}  -background {#eeeeee}  -command {TP_IconLibShow}  -font {Helvetica 10}  -highlightbackground {#eeeeee}  -text {Silk}  -value {-sample.silk}  -variable {TPselTheme}

  frame .tpiconlib.frame10  -borderwidth {2}  -background {#eeeeee}  -height {36}  -highlightbackground {#eeeeee}  -width {70}

  button .tpiconlib.frame10.button11  -activebackground {gray75}  -background {#eeeeee}  -command {.tpiconlib.frame0.canvas2 delete all
catch "image delete $TPimglibList"
set TPshowIcons 0
DestroyWindow.tpiconlib}  -font {Helvetica 10}  -highlightbackground {#eeeeee}  -text {Done}

  frame .tpiconlib.frame0  -relief {raised}  -background {#eeeeee}  -highlightbackground {#eeeeee}

  scrollbar .tpiconlib.frame0.scrollbar1  -activebackground {#eeeeee}  -background {#eeeeee}  -borderwidth {2}  -command {.tpiconlib.frame0.canvas2 yview}  -cursor {left_ptr}  -highlightbackground {#eeeeee}  -relief {raised}  -troughcolor {#eeeeee}  -width {12}

  canvas .tpiconlib.frame0.canvas2  -background {grey78}  -borderwidth {1}  -height {207}  -highlightbackground {#ffffff}  -relief {sunken}  -scrollregion {0c 0c 20c 60c}  -width {550}  -yscrollcommand {.tpiconlib.frame0.scrollbar1 set}
  # bindings
  bind .tpiconlib.frame0.canvas2 <Button-1> {TP_IconMake [%W itemcget current -image]}

  frame .tpiconlib.frame12  -relief {ridge}  -background {black}  -height {2}  -highlightbackground {#eeeeee}  -width {50}

  # pack master .tpiconlib.frame1
  pack configure .tpiconlib.frame1.label2  -side left
  pack configure .tpiconlib.frame1.radiobutton2  -side left
  pack configure .tpiconlib.frame1.radiobutton3  -side left
  pack configure .tpiconlib.frame1.radiobutton4  -side left
  pack configure .tpiconlib.frame1.radiobutton5  -side left
  pack configure .tpiconlib.frame1.radiobutton6  -side left
  pack configure .tpiconlib.frame1.radiobutton7  -side left
  pack configure .tpiconlib.frame1.radiobutton8  -side left

  # pack master .tpiconlib.frame9
  pack configure .tpiconlib.frame9.label2  -side left
  pack configure .tpiconlib.frame9.radiobutton3  -side left
  pack configure .tpiconlib.frame9.radiobutton4  -side left
  pack configure .tpiconlib.frame9.radiobutton5  -side left
  pack configure .tpiconlib.frame9.radiobutton6  -side left
  pack configure .tpiconlib.frame9.radiobutton8  -side left
  pack configure .tpiconlib.frame9.radiobutton9  -side left

  # pack master .tpiconlib.frame10
  pack configure .tpiconlib.frame10.button11

  # pack master .tpiconlib.frame0
  pack configure .tpiconlib.frame0.scrollbar1  -fill y  -side right
  pack configure .tpiconlib.frame0.canvas2  -expand 1  -fill both

  # pack master .tpiconlib
  pack configure .tpiconlib.frame1  -fill x
  pack configure .tpiconlib.frame12  -fill x
  pack configure .tpiconlib.frame9  -fill x
  pack configure .tpiconlib.frame10  -side bottom
  pack configure .tpiconlib.frame0  -expand 1  -fill both

  # build canvas items .tpiconlib.frame0.canvas2



EndSrc.tpiconlib
}

proc DestroyWindow.tpiconlib {} {
     catch "destroy .tpiconlib"
     update
}

proc EndSrc.tpiconlib {} {
global TPshowIcons
global TPselTheme

wm iconphoto .tpiconlib tplogo16
set TPshowIcons 1
set TPselTheme {.kde}
TP_IconLibShow
}


proc ShowWindow.tpimages { args} {

  catch "destroy .tpimages"

  toplevel .tpimages   -relief {ridge}  -background {#dcdcdc}  -highlightbackground {#dcdcdc}

  # Window manager configurations
  wm positionfrom .tpimages program
  wm sizefrom .tpimages program
  wm maxsize .tpimages 2560 1024
  wm minsize .tpimages 388 472
  wm protocol .tpimages WM_DELETE_WINDOW {.tpimages.frame30.button35 invoke}
  wm title .tpimages {TKproE image management}


  frame .tpimages.frame  -borderwidth {2}  -relief {ridge}  -background {#dcdcdc}  -height {230}  -highlightbackground {#dcdcdc}  -width {416}

#LISSI
#  scrollbar .tpimages.frame.scrollbar3  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpimages.frame.listbox1 xview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -orient {horizontal}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}
#  scrollbar .tpimages.frame.scrollbar2  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpimages.frame.listbox1 yview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}
  ttk::scrollbar .tpimages.frame.scrollbar3 -command {.tpimages.frame.listbox1 xview} -orient {horizontal}
  ttk::scrollbar .tpimages.frame.scrollbar2 -command {.tpimages.frame.listbox1 yview}

  listbox .tpimages.frame.listbox1  -font {Helvetica 10}  -height {5}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -width {25}  -xscrollcommand {.tpimages.frame.scrollbar3 set}  -yscrollcommand {.tpimages.frame.scrollbar2 set}
  # bindings
#LISSI
#  bind .tpimages.frame.listbox1 <<ListboxSelect>> {TP_ImageSelect [%W get [%W curselection]]}
  bind .tpimages.frame.listbox1 <<ListboxSelect>> {if {[%W curselection] == ""} { return}; TP_ImageSelect [%W get [%W curselection]]}

  label .tpimages.frame.label4  -activebackground {#dcdcdc}  -background {slategray3}  -font {Helvetica 10}  -foreground {black}  -highlightbackground {#dcdcdc}  -relief {raised}  -text {Currently defined images}

  frame .tpimages.frame.frame27  -background {#dcdcdc}  -height {26}  -highlightbackground {#dcdcdc}  -width {416}

  label .tpimages.frame.frame27.label28  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Display image names containing:}

  entry .tpimages.frame.frame27.entry29  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -textvariable {TPimage(findstr)}
  # bindings
  bind .tpimages.frame.frame27.entry29 <Key-KP_Enter> {.tpimages.frame.listbox1 delete 0 end
if {[string trim $TPimage(findstr)] == {}} {
   eval ".tpimages.frame.listbox1 insert end [lsort [image names]]"
  } {
      foreach TPidx [lsort [image names]] {
	    if {[string first $TPimage(findstr) $TPidx] > -1} {
	        .tpimages.frame.listbox1 insert end $TPidx
	      }
	 }
    }}
  bind .tpimages.frame.frame27.entry29 <Key-Return> {.tpimages.frame.listbox1 delete 0 end
if {[string trim $TPimage(findstr)] == {}} {
   eval ".tpimages.frame.listbox1 insert end [lsort [image names]]"
  } {
      foreach TPidx [lsort [image names]] {
	    if {[string first $TPimage(findstr) $TPidx] > -1} {
	        .tpimages.frame.listbox1 insert end $TPidx
	      }
	 }
    }}

  label .tpimages.frame.label5  -activebackground {#e6e7e6}  -background {#e6e7e6}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#e6e7e6}  -relief {ridge}  -text {Preview}

  frame .tpimages.frame5  -borderwidth {2}  -background {#dcdcdc}  -height {26}  -highlightbackground {#dcdcdc}  -width {416}

  label .tpimages.frame5.label6  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10 bold}  -highlightbackground {#dcdcdc}  -text {Image type:}

  radiobutton .tpimages.frame5.radiobutton7  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {pack forget .tpimages.propphoto
pack .tpimages.propbitmap -after .tpimages.frame5 -side top -fill x}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {bitmap}  -value {bitmap}  -variable {TPimage(type)}

  radiobutton .tpimages.frame5.radiobutton8  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {pack forget .tpimages.propbitmap
pack .tpimages.propphoto -after .tpimages.frame5 -side top -fill x}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {photo}  -value {photo}  -variable {TPimage(type)}

  checkbutton .tpimages.frame5.embed  -activebackground {#dcdcdc}  -background {#dcdcdc}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Embed image}  -variable {TPimage(embed)}
#LISSI
  checkbutton .tpimages.frame5.screenshot  -activebackground {#dcdcdc}  -background {#dcdcdc}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Screenshot}  -variable {TPimage(screenshot)}


  frame .tpimages.propbitmap  -borderwidth {2}  -background {#dcdcdc}  -height {50}  -highlightbackground {#dcdcdc}  -width {337}

  frame .tpimages.propbitmap.frame11  -borderwidth {2}  -background {#dcdcdc}  -height {26}  -highlightbackground {#dcdcdc}  -width {333}

  label .tpimages.propbitmap.frame11.label12  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Name:}  -width {10}

  entry .tpimages.propbitmap.frame11.entry13  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -textvariable {TPimage(name)}

  frame .tpimages.propbitmap.frame14  -borderwidth {2}  -background {#dcdcdc}  -height {26}  -highlightbackground {#dcdcdc}  -width {333}

  label .tpimages.propbitmap.frame14.label12  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {File:}  -width {10}

  entry .tpimages.propbitmap.frame14.entry13  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -textvariable {TPimage(file)}
#LISSI
  # bindings
  bind  .tpimages.propbitmap.frame14.entry13 <Button-3> {global TPdirimage;set TPimage(file) [TP_RealOpenFile -parent ".tpimages" \
  -title "Select file with Bitmap" -filetypes {{{Bitmap files}  {.xbm}} {{All files} {*}} } -initialdir $TPdirimage]; \
    if {$TPimage(file) != ""} { set TPdirimage "[file dirname $TPimage(file) ]"} \
  }

  frame .tpimages.propbitmap.frame16  -borderwidth {2}  -background {#dcdcdc}  -height {26}  -highlightbackground {#dcdcdc}  -width {333}

  label .tpimages.propbitmap.frame16.label12  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Background:}  -width {10}

  entry .tpimages.propbitmap.frame16.entry13  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -textvariable {TPimage(background)}

  frame .tpimages.propbitmap.frame17  -borderwidth {2}  -background {#dcdcdc}  -height {26}  -highlightbackground {#dcdcdc}  -width {333}

  label .tpimages.propbitmap.frame17.label12  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Foreground:}  -width {10}

  entry .tpimages.propbitmap.frame17.entry13  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -textvariable {TPimage(foreground)}

  frame .tpimages.propbitmap.frame18  -borderwidth {2}  -background {#dcdcdc}  -height {26}  -highlightbackground {#dcdcdc}  -width {333}

  label .tpimages.propbitmap.frame18.label12  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Maskdata:}  -width {10}

  entry .tpimages.propbitmap.frame18.entry13  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -textvariable {TPimage(maskdata)}

  frame .tpimages.propbitmap.frame19  -borderwidth {2}  -background {#dcdcdc}  -height {26}  -highlightbackground {#dcdcdc}  -width {333}

  label .tpimages.propbitmap.frame19.label12  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Maskfile:}  -width {10}

  entry .tpimages.propbitmap.frame19.entry13  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -textvariable {TPimage(maskfile)}

  frame .tpimages.propbitmap.frame15  -borderwidth {2}  -background {#dcdcdc}  -height {26}  -highlightbackground {#dcdcdc}  -width {333}

  label .tpimages.propbitmap.frame15.label12  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {3}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -width {10}

  frame .tpimages.propphoto  -borderwidth {2}  -background {#dcdcdc}  -height {1}  -highlightbackground {#dcdcdc}  -width {1}

  frame .tpimages.propphoto.frame20  -borderwidth {2}  -background {#dcdcdc}  -height {26}  -highlightbackground {#dcdcdc}  -width {333}

  label .tpimages.propphoto.frame20.label12  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Name:}  -width {10}

  entry .tpimages.propphoto.frame20.entry13  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -textvariable {TPimage(name)}

  frame .tpimages.propphoto.frame14  -borderwidth {2}  -background {#dcdcdc}  -height {26}  -highlightbackground {#dcdcdc}  -width {333}

  label .tpimages.propphoto.frame14.label12  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {File:}  -width {10}

  entry .tpimages.propphoto.frame14.entry13  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -textvariable {TPimage(file)}
#LISSI
  # bindings
  bind  .tpimages.propphoto.frame14.entry13 <Button-3> {global TPdirimage;set TPimage(file) [tk_getOpenFile -parent ".tpimages" \
  -title "Select file with Image" -filetypes {{{Photo files}  {.png .gif .jpg .jpeg}} {{All files} {*}} } -initialdir $TPdirimage]; \
    if {$TPimage(file) != ""} { set TPdirimage [file dirname $TPimage(file) ]} \
  }

  frame .tpimages.propphoto.frame22  -borderwidth {2}  -background {#dcdcdc}  -height {26}  -highlightbackground {#dcdcdc}  -width {333}

  label .tpimages.propphoto.frame22.label12  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Format:}  -width {10}

  entry .tpimages.propphoto.frame22.entry13  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -textvariable {TPimage(format)}

  frame .tpimages.propphoto.frame23  -borderwidth {2}  -background {#dcdcdc}  -height {26}  -highlightbackground {#dcdcdc}  -width {333}

  label .tpimages.propphoto.frame23.label12  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Gamma:}  -width {10}

  entry .tpimages.propphoto.frame23.entry13  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -textvariable {TPimage(gamma)}

  frame .tpimages.propphoto.frame24  -borderwidth {2}  -background {#dcdcdc}  -height {26}  -highlightbackground {#dcdcdc}  -width {333}

  label .tpimages.propphoto.frame24.label12  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Height:}  -width {10}

  entry .tpimages.propphoto.frame24.entry13  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -textvariable {TPimage(height)}

  frame .tpimages.propphoto.frame25  -borderwidth {2}  -background {#dcdcdc}  -height {26}  -highlightbackground {#dcdcdc}  -width {333}

  label .tpimages.propphoto.frame25.label12  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Palette:}  -width {10}

  entry .tpimages.propphoto.frame25.entry13  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -textvariable {TPimage(palette)}

  frame .tpimages.propphoto.frame26  -borderwidth {2}  -background {#dcdcdc}  -height {26}  -highlightbackground {#dcdcdc}  -width {333}

  label .tpimages.propphoto.frame26.label12  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Width:}  -width {10}

  entry .tpimages.propphoto.frame26.entry13  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -textvariable {TPimage(width)}

  frame .tpimages.frame30  -borderwidth {2}  -background {#dcdcdc}  -height {32}  -highlightbackground {#dcdcdc}  -width {416}

  button .tpimages.frame30.button31  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_ImageInsert
TP_ImgListFill}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Insert}

  button .tpimages.frame30.button32  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_ImageMod}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Modify}

  button .tpimages.frame30.button33  -activebackground {gray75}  -background {#dcdcdc}  -command {set TPidx [.tpimages.frame.listbox1 curselection]
if {$TPidx != {}} {
   .tpimages.frame.label5 configure -image {}
   if {$TPimgNamespace == {::} } {
       set TPtemp [.tpimages.frame.listbox1 get $TPidx]
      } { set TPtemp ${TPimgNamespace}::[.tpimages.frame.listbox1 get $TPidx] }
   if {[image inuse $TPtemp]} {
       .tpimages.frame.label5 configure -image $TPtemp
       TP_ShowMsg "Can't delete image \"$TPtemp\". It is still in use."
      } {
          # Only try to delete the image if it is not in use.
           catch {image delete $TPtemp} 
          TP_ImgListFill
     }
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Delete}

  button .tpimages.frame30.button34  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_ImgListFill}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Rescan}

  button .tpimages.frame30.button35  -activebackground {gray75}  -background {#dcdcdc}  -command {.tpimages.frame.listbox1 delete 0 end
.tpimages.frame.label5 configure -image {}
foreach TPtemp [array names TPimage] { set TPimage($TPtemp) {} }
set TPimage(embed) 1
set TPimage(foreground) black
set TPimage(gamma) 1.0
set TPimage(height) 0
set TPimage(type) photo
set TPimage(width) 0
set TPshowImages 0
#LISS
set TPimage(screenshot) 0

DestroyWindow.tpimages}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Done}

  frame .tpimages.frame0  -borderwidth {2}  -relief {raised}  -background {#dcdcdc}  -height {30}  -highlightbackground {#dcdcdc}  -width {30}

  frame .tpimages.frame0.frame4  -borderwidth {2}  -relief {groove}  -background {#eeeeee}  -height {24}  -highlightbackground {#eeeeee}  -width {136}

  label .tpimages.frame0.frame4.label2  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10 bold}  -highlightbackground {#dcdcdc}  -text {Show Namespace:}  -width {18}

  label .tpimages.frame0.frame4.label3  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {0}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {::}  -textvariable {TPimgNamespace}

  menubutton .tpimages.frame0.frame4.menubutton1  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -font {Helvetica 12}  -foreground {red}  -highlightbackground {#dcdcdc}  -image {tparrowcombo}  -menu {.tpimages.frame0.frame4.menubutton1.m}  -padx {2}  -pady {1}  -relief {raised}  -text {::}  -textvariable {TPimgNamespace}

  menu .tpimages.frame0.frame4.menubutton1.m  -activebackground {#dcdcdc}  -background {#dcdcdc}  -font {Helvetica 10}  -tearoff {0}
  .tpimages.frame0.frame4.menubutton1.m add command  -command {set TPimgNamespace ::; TP_ImgListFill}  -label {::}
  .tpimages.frame0.frame4.menubutton1.m add command  -command {set TPimgNamespace ::auto_mkindex_parser; TP_ImgListFill}  -label {::auto_mkindex_parser}
  .tpimages.frame0.frame4.menubutton1.m add command  -command {set TPimgNamespace ::freewrap; TP_ImgListFill}  -label {::freewrap}
  .tpimages.frame0.frame4.menubutton1.m add command  -command {set TPimgNamespace ::msgcat; TP_ImgListFill}  -label {::msgcat}
  .tpimages.frame0.frame4.menubutton1.m add command  -command {set TPimgNamespace ::pkg; TP_ImgListFill}  -label {::pkg}
  .tpimages.frame0.frame4.menubutton1.m add command  -command {set TPimgNamespace ::tcl; TP_ImgListFill}  -label {::tcl}
  .tpimages.frame0.frame4.menubutton1.m add command  -command {set TPimgNamespace ::tcl::Pkg; TP_ImgListFill}  -label {::tcl::Pkg}
  .tpimages.frame0.frame4.menubutton1.m add command  -command {set TPimgNamespace ::tcl::chan; TP_ImgListFill}  -label {::tcl::chan}
  .tpimages.frame0.frame4.menubutton1.m add command  -command {set TPimgNamespace ::tcl::clock; TP_ImgListFill}  -label {::tcl::clock}
  .tpimages.frame0.frame4.menubutton1.m add command  -command {set TPimgNamespace ::tcl::dict; TP_ImgListFill}  -label {::tcl::dict}
  .tpimages.frame0.frame4.menubutton1.m add command  -command {set TPimgNamespace ::tcl::info; TP_ImgListFill}  -label {::tcl::info}
  .tpimages.frame0.frame4.menubutton1.m add command  -command {set TPimgNamespace ::tcl::mathfunc; TP_ImgListFill}  -label {::tcl::mathfunc}
  .tpimages.frame0.frame4.menubutton1.m add command  -command {set TPimgNamespace ::tcl::mathop; TP_ImgListFill}  -label {::tcl::mathop}
  .tpimages.frame0.frame4.menubutton1.m add command  -command {set TPimgNamespace ::tcl::string; TP_ImgListFill}  -label {::tcl::string}
  .tpimages.frame0.frame4.menubutton1.m add command  -command {set TPimgNamespace ::tcl::tm; TP_ImgListFill}  -label {::tcl::tm}
  .tpimages.frame0.frame4.menubutton1.m add command  -command {set TPimgNamespace ::tcl::unsupported; TP_ImgListFill}  -label {::tcl::unsupported}
  .tpimages.frame0.frame4.menubutton1.m add command  -command {set TPimgNamespace ::tk; TP_ImgListFill}  -label {::tk}
  .tpimages.frame0.frame4.menubutton1.m add command  -command {set TPimgNamespace ::tk::dialog; TP_ImgListFill}  -label {::tk::dialog}
  .tpimages.frame0.frame4.menubutton1.m add command  -command {set TPimgNamespace ::tk::dialog::error; TP_ImgListFill}  -label {::tk::dialog::error}
  .tpimages.frame0.frame4.menubutton1.m add command  -command {set TPimgNamespace ::tk::msgcat; TP_ImgListFill}  -label {::tk::msgcat}
  .tpimages.frame0.frame4.menubutton1.m add command  -command {set TPimgNamespace ::tk::panedwindow; TP_ImgListFill}  -label {::tk::panedwindow}
  .tpimages.frame0.frame4.menubutton1.m add command  -command {set TPimgNamespace ::tk::spinbox; TP_ImgListFill}  -label {::tk::spinbox}
  .tpimages.frame0.frame4.menubutton1.m add command  -command {set TPimgNamespace ::ttk; TP_ImgListFill}  -label {::ttk}
  .tpimages.frame0.frame4.menubutton1.m add command  -command {set TPimgNamespace ::ttk::button; TP_ImgListFill}  -label {::ttk::button}
  .tpimages.frame0.frame4.menubutton1.m add command  -command {set TPimgNamespace ::ttk::combobox; TP_ImgListFill}  -label {::ttk::combobox}
  .tpimages.frame0.frame4.menubutton1.m add command  -command {set TPimgNamespace ::ttk::entry; TP_ImgListFill}  -label {::ttk::entry}
  .tpimages.frame0.frame4.menubutton1.m add command  -command {set TPimgNamespace ::ttk::menubutton; TP_ImgListFill}  -label {::ttk::menubutton}
  .tpimages.frame0.frame4.menubutton1.m add command  -command {set TPimgNamespace ::ttk::notebook; TP_ImgListFill}  -label {::ttk::notebook}
  .tpimages.frame0.frame4.menubutton1.m add command  -command {set TPimgNamespace ::ttk::panedwindow; TP_ImgListFill}  -label {::ttk::panedwindow}
  .tpimages.frame0.frame4.menubutton1.m add command  -command {set TPimgNamespace ::ttk::progressbar; TP_ImgListFill}  -label {::ttk::progressbar}
  .tpimages.frame0.frame4.menubutton1.m add command  -command {set TPimgNamespace ::ttk::scale; TP_ImgListFill}  -label {::ttk::scale}
  .tpimages.frame0.frame4.menubutton1.m add command  -command {set TPimgNamespace ::ttk::scrollbar; TP_ImgListFill}  -label {::ttk::scrollbar}
  .tpimages.frame0.frame4.menubutton1.m add command  -command {set TPimgNamespace ::ttk::sizegrip; TP_ImgListFill}  -label {::ttk::sizegrip}
  .tpimages.frame0.frame4.menubutton1.m add command  -command {set TPimgNamespace ::ttk::theme; TP_ImgListFill}  -label {::ttk::theme}
  .tpimages.frame0.frame4.menubutton1.m add command  -command {set TPimgNamespace ::ttk::theme::alt; TP_ImgListFill}  -label {::ttk::theme::alt}
  .tpimages.frame0.frame4.menubutton1.m add command  -command {set TPimgNamespace ::ttk::theme::clam; TP_ImgListFill}  -label {::ttk::theme::clam}
  .tpimages.frame0.frame4.menubutton1.m add command  -command {set TPimgNamespace ::ttk::theme::classic; TP_ImgListFill}  -label {::ttk::theme::classic}
  .tpimages.frame0.frame4.menubutton1.m add command  -command {set TPimgNamespace ::ttk::theme::default; TP_ImgListFill}  -label {::ttk::theme::default}
  .tpimages.frame0.frame4.menubutton1.m add command  -command {set TPimgNamespace ::ttk::treeview; TP_ImgListFill}  -label {::ttk::treeview}
  .tpimages.frame0.frame4.menubutton1.m add command  -command {set TPimgNamespace ::zvfs; TP_ImgListFill}  -label {::zvfs}

  frame .tpimages.frame0.frame5  -borderwidth {2}  -relief {groove}  -background {#dcdcdc}  -height {46}  -highlightbackground {#eeeeee}  -width {98}

  button .tpimages.frame0.frame5.button3  -activebackground {gray75}  -background {#dcdcdc}  -command {ShowWindow.tpexclusions}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -pady {0}  -text {Exclusion List}

  button .tpimages.frame0.frame5.button5  -activebackground {gray75}  -background {#dcdcdc}  -command {ShowWindow.tpnewspace}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -pady {0}  -text {New Namespace}

  # pack master .tpimages.frame
  pack configure .tpimages.frame.label4  -fill x
  pack configure .tpimages.frame.frame27  -fill x  -side bottom
  pack configure .tpimages.frame.label5  -expand 1  -fill both  -side right
  pack configure .tpimages.frame.scrollbar2  -fill y  -side left
  pack configure .tpimages.frame.listbox1  -expand 1  -fill both
  pack configure .tpimages.frame.scrollbar3  -fill x  -side bottom

  # pack master .tpimages.frame.frame27
  pack configure .tpimages.frame.frame27.label28  -side left
  pack configure .tpimages.frame.frame27.entry29  -expand 1  -fill x  -side left

  # pack master .tpimages.frame5
  pack configure .tpimages.frame5.label6  -anchor w  -side left
  pack configure .tpimages.frame5.radiobutton7  -side left
  pack configure .tpimages.frame5.radiobutton8  -side left
  pack configure .tpimages.frame5.embed  -side right
#LISSI
  pack configure .tpimages.frame5.screenshot  -side right
  .tpimages.frame5.screenshot configure -state disabled

  # pack master .tpimages.propbitmap
  pack configure .tpimages.propbitmap.frame11  -fill x
  pack configure .tpimages.propbitmap.frame14  -fill x
  pack configure .tpimages.propbitmap.frame16  -fill x
  pack configure .tpimages.propbitmap.frame17  -fill x
  pack configure .tpimages.propbitmap.frame18  -fill x
  pack configure .tpimages.propbitmap.frame19  -fill x
  pack configure .tpimages.propbitmap.frame15  -fill x

  # pack master .tpimages.propbitmap.frame11
  pack configure .tpimages.propbitmap.frame11.label12  -side left
  pack configure .tpimages.propbitmap.frame11.entry13  -expand 1  -fill x  -side left

  # pack master .tpimages.propbitmap.frame14
  pack configure .tpimages.propbitmap.frame14.label12  -side left
  pack configure .tpimages.propbitmap.frame14.entry13  -expand 1  -fill x  -side left

  # pack master .tpimages.propbitmap.frame16
  pack configure .tpimages.propbitmap.frame16.label12  -side left
  pack configure .tpimages.propbitmap.frame16.entry13  -expand 1  -fill x  -side left

  # pack master .tpimages.propbitmap.frame17
  pack configure .tpimages.propbitmap.frame17.label12  -side left
  pack configure .tpimages.propbitmap.frame17.entry13  -expand 1  -fill x  -side left

  # pack master .tpimages.propbitmap.frame18
  pack configure .tpimages.propbitmap.frame18.label12  -side left
  pack configure .tpimages.propbitmap.frame18.entry13  -expand 1  -fill x  -side left

  # pack master .tpimages.propbitmap.frame19
  pack configure .tpimages.propbitmap.frame19.label12  -side left
  pack configure .tpimages.propbitmap.frame19.entry13  -expand 1  -fill x  -side left

  # pack master .tpimages.propbitmap.frame15
  pack configure .tpimages.propbitmap.frame15.label12  -side left

  # pack master .tpimages.propphoto
  pack configure .tpimages.propphoto.frame20  -fill x
  pack configure .tpimages.propphoto.frame14  -fill x
  pack configure .tpimages.propphoto.frame22  -fill x
  pack configure .tpimages.propphoto.frame23  -fill x
  pack configure .tpimages.propphoto.frame24  -fill x
  pack configure .tpimages.propphoto.frame25  -fill x
  pack configure .tpimages.propphoto.frame26  -fill x

  # pack master .tpimages.propphoto.frame20
  pack configure .tpimages.propphoto.frame20.label12  -side left
  pack configure .tpimages.propphoto.frame20.entry13  -expand 1  -fill x  -side left

  # pack master .tpimages.propphoto.frame14
  pack configure .tpimages.propphoto.frame14.label12  -side left
  pack configure .tpimages.propphoto.frame14.entry13  -expand 1  -fill x  -side left

  # pack master .tpimages.propphoto.frame22
  pack configure .tpimages.propphoto.frame22.label12  -side left
  pack configure .tpimages.propphoto.frame22.entry13  -expand 1  -fill x  -side left

  # pack master .tpimages.propphoto.frame23
  pack configure .tpimages.propphoto.frame23.label12  -side left
  pack configure .tpimages.propphoto.frame23.entry13  -expand 1  -fill x  -side left

  # pack master .tpimages.propphoto.frame24
  pack configure .tpimages.propphoto.frame24.label12  -side left
  pack configure .tpimages.propphoto.frame24.entry13  -expand 1  -fill x  -side left

  # pack master .tpimages.propphoto.frame25
  pack configure .tpimages.propphoto.frame25.label12  -side left
  pack configure .tpimages.propphoto.frame25.entry13  -expand 1  -fill x  -side left

  # pack master .tpimages.propphoto.frame26
  pack configure .tpimages.propphoto.frame26.label12  -side left
  pack configure .tpimages.propphoto.frame26.entry13  -expand 1  -fill x  -side left

  # pack master .tpimages.frame30
  pack configure .tpimages.frame30.button31  -expand 1  -fill x  -side left
  pack configure .tpimages.frame30.button32  -expand 1  -fill x  -side left
  pack configure .tpimages.frame30.button33  -expand 1  -fill x  -side left
  pack configure .tpimages.frame30.button34  -expand 1  -fill x  -side left
  pack configure .tpimages.frame30.button35  -expand 1  -fill x  -side left

  # pack master .tpimages.frame0
  pack configure .tpimages.frame0.frame4  -side left
  pack configure .tpimages.frame0.frame5  -fill y  -side right

  # pack master .tpimages.frame0.frame4
  pack configure .tpimages.frame0.frame4.label2  -fill x
  pack configure .tpimages.frame0.frame4.menubutton1  -side right
  pack configure .tpimages.frame0.frame4.label3  -fill x  -ipadx 3

  # pack master .tpimages.frame0.frame5
  pack configure .tpimages.frame0.frame5.button3  -fill x  -padx 3  -pady 1
  pack configure .tpimages.frame0.frame5.button5  -fill x  -padx 3  -pady 1

  # pack master .tpimages
  pack configure .tpimages.frame0  -fill x
  pack configure .tpimages.frame  -expand 1  -fill both
  pack configure .tpimages.frame5  -fill x
  pack configure .tpimages.propphoto  -fill x
  pack configure .tpimages.frame30  -fill x

  bind .tpimages.frame0.frame4.menubutton1.m <MouseWheel> {
    %W yview scroll [expr {- (%D / 120) * 4}] units
  }

EndSrc.tpimages
}

proc DestroyWindow.tpimages {} {
     catch "destroy .tpimages"
     update
}

proc EndSrc.tpimages {} {
global TPshowImages

wm iconphoto .tpimages tplogo16
TP_MenuFromList4 .tpimages.frame0.frame4.menubutton1.m [concat :: [TP_NamespaceList ::]]
TP_ImgListFill
set TPshowImages 1
}


proc ShowWindow.tpimagesel { args} {

  catch "destroy .tpimagesel"

  toplevel .tpimagesel   -relief {raised}  -background {#dcdcdc}  -highlightbackground {#dcdcdc}

  # Window manager configurations
  wm positionfrom .tpimagesel program
  wm sizefrom .tpimagesel program
  wm maxsize .tpimagesel 2560 1024
  wm minsize .tpimagesel 400 300
  wm protocol .tpimagesel WM_DELETE_WINDOW {.tpimagesel.frame.listbox1 delete 0 end
DestroyWindow.tpimagesel}
  wm title .tpimagesel {TKproE image selection}


  frame .tpimagesel.frame0  -borderwidth {2}  -relief {raised}  -background {#dcdcdc}  -height {30}  -highlightbackground {#dcdcdc}  -width {30}

  menubutton .tpimagesel.frame0.menubutton1  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -font {Helvetica 12}  -foreground {red}  -highlightbackground {#dcdcdc}  -indicatoron {1}  -menu {.tpimagesel.frame0.menubutton1.m}  -padx {2}  -pady {2}  -relief {raised}  -compound {right}  -text {::}  -textvariable {TPimgSelNamespace}  -width {20}

  menu .tpimagesel.frame0.menubutton1.m  -activebackground {#dcdcdc}  -background {#dcdcdc}  -font {Helvetica 10}  -tearoff {0}
  .tpimagesel.frame0.menubutton1.m add command  -command {set TPimgSelNamespace ::; TP_ImgListFill2}  -label {::}
  .tpimagesel.frame0.menubutton1.m add command  -command {set TPimgSelNamespace ::auto_mkindex_parser; TP_ImgListFill2}  -label {::auto_mkindex_parser}
  .tpimagesel.frame0.menubutton1.m add command  -command {set TPimgSelNamespace ::freewrap; TP_ImgListFill2}  -label {::freewrap}
  .tpimagesel.frame0.menubutton1.m add command  -command {set TPimgSelNamespace ::msgcat; TP_ImgListFill2}  -label {::msgcat}
  .tpimagesel.frame0.menubutton1.m add command  -command {set TPimgSelNamespace ::pkg; TP_ImgListFill2}  -label {::pkg}
  .tpimagesel.frame0.menubutton1.m add command  -command {set TPimgSelNamespace ::tcl; TP_ImgListFill2}  -label {::tcl}
  .tpimagesel.frame0.menubutton1.m add command  -command {set TPimgSelNamespace ::tcl::Pkg; TP_ImgListFill2}  -label {::tcl::Pkg}
  .tpimagesel.frame0.menubutton1.m add command  -command {set TPimgSelNamespace ::tcl::chan; TP_ImgListFill2}  -label {::tcl::chan}
  .tpimagesel.frame0.menubutton1.m add command  -command {set TPimgSelNamespace ::tcl::clock; TP_ImgListFill2}  -label {::tcl::clock}
  .tpimagesel.frame0.menubutton1.m add command  -command {set TPimgSelNamespace ::tcl::dict; TP_ImgListFill2}  -label {::tcl::dict}
  .tpimagesel.frame0.menubutton1.m add command  -command {set TPimgSelNamespace ::tcl::info; TP_ImgListFill2}  -label {::tcl::info}
  .tpimagesel.frame0.menubutton1.m add command  -command {set TPimgSelNamespace ::tcl::mathfunc; TP_ImgListFill2}  -label {::tcl::mathfunc}
  .tpimagesel.frame0.menubutton1.m add command  -command {set TPimgSelNamespace ::tcl::mathop; TP_ImgListFill2}  -label {::tcl::mathop}
  .tpimagesel.frame0.menubutton1.m add command  -command {set TPimgSelNamespace ::tcl::string; TP_ImgListFill2}  -label {::tcl::string}
  .tpimagesel.frame0.menubutton1.m add command  -command {set TPimgSelNamespace ::tcl::tm; TP_ImgListFill2}  -label {::tcl::tm}
  .tpimagesel.frame0.menubutton1.m add command  -command {set TPimgSelNamespace ::tcl::unsupported; TP_ImgListFill2}  -label {::tcl::unsupported}
  .tpimagesel.frame0.menubutton1.m add command  -command {set TPimgSelNamespace ::tk; TP_ImgListFill2}  -label {::tk}
  .tpimagesel.frame0.menubutton1.m add command  -command {set TPimgSelNamespace ::tk::dialog; TP_ImgListFill2}  -label {::tk::dialog}
  .tpimagesel.frame0.menubutton1.m add command  -command {set TPimgSelNamespace ::tk::dialog::error; TP_ImgListFill2}  -label {::tk::dialog::error}
  .tpimagesel.frame0.menubutton1.m add command  -command {set TPimgSelNamespace ::tk::msgcat; TP_ImgListFill2}  -label {::tk::msgcat}
  .tpimagesel.frame0.menubutton1.m add command  -command {set TPimgSelNamespace ::tk::panedwindow; TP_ImgListFill2}  -label {::tk::panedwindow}
  .tpimagesel.frame0.menubutton1.m add command  -command {set TPimgSelNamespace ::tk::spinbox; TP_ImgListFill2}  -label {::tk::spinbox}
  .tpimagesel.frame0.menubutton1.m add command  -command {set TPimgSelNamespace ::ttk; TP_ImgListFill2}  -label {::ttk}
  .tpimagesel.frame0.menubutton1.m add command  -command {set TPimgSelNamespace ::ttk::button; TP_ImgListFill2}  -label {::ttk::button}
  .tpimagesel.frame0.menubutton1.m add command  -command {set TPimgSelNamespace ::ttk::combobox; TP_ImgListFill2}  -label {::ttk::combobox}
  .tpimagesel.frame0.menubutton1.m add command  -command {set TPimgSelNamespace ::ttk::entry; TP_ImgListFill2}  -label {::ttk::entry}
  .tpimagesel.frame0.menubutton1.m add command  -command {set TPimgSelNamespace ::ttk::menubutton; TP_ImgListFill2}  -label {::ttk::menubutton}
  .tpimagesel.frame0.menubutton1.m add command  -command {set TPimgSelNamespace ::ttk::notebook; TP_ImgListFill2}  -label {::ttk::notebook}
  .tpimagesel.frame0.menubutton1.m add command  -command {set TPimgSelNamespace ::ttk::panedwindow; TP_ImgListFill2}  -label {::ttk::panedwindow}
  .tpimagesel.frame0.menubutton1.m add command  -command {set TPimgSelNamespace ::ttk::progressbar; TP_ImgListFill2}  -label {::ttk::progressbar}
  .tpimagesel.frame0.menubutton1.m add command  -command {set TPimgSelNamespace ::ttk::scale; TP_ImgListFill2}  -label {::ttk::scale}
  .tpimagesel.frame0.menubutton1.m add command  -command {set TPimgSelNamespace ::ttk::scrollbar; TP_ImgListFill2}  -label {::ttk::scrollbar}
  .tpimagesel.frame0.menubutton1.m add command  -command {set TPimgSelNamespace ::ttk::sizegrip; TP_ImgListFill2}  -label {::ttk::sizegrip}
  .tpimagesel.frame0.menubutton1.m add command  -command {set TPimgSelNamespace ::ttk::theme; TP_ImgListFill2}  -label {::ttk::theme}
  .tpimagesel.frame0.menubutton1.m add command  -command {set TPimgSelNamespace ::ttk::theme::alt; TP_ImgListFill2}  -label {::ttk::theme::alt}
  .tpimagesel.frame0.menubutton1.m add command  -command {set TPimgSelNamespace ::ttk::theme::clam; TP_ImgListFill2}  -label {::ttk::theme::clam}
  .tpimagesel.frame0.menubutton1.m add command  -command {set TPimgSelNamespace ::ttk::theme::classic; TP_ImgListFill2}  -label {::ttk::theme::classic}
  .tpimagesel.frame0.menubutton1.m add command  -command {set TPimgSelNamespace ::ttk::theme::default; TP_ImgListFill2}  -label {::ttk::theme::default}
  .tpimagesel.frame0.menubutton1.m add command  -command {set TPimgSelNamespace ::ttk::treeview; TP_ImgListFill2}  -label {::ttk::treeview}
  .tpimagesel.frame0.menubutton1.m add command  -command {set TPimgSelNamespace ::zvfs; TP_ImgListFill2}  -label {::zvfs}

  label .tpimagesel.frame0.label2  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10 bold}  -highlightbackground {#dcdcdc}  -text {Show Namespace:}

  frame .tpimagesel.frame  -borderwidth {2}  -relief {ridge}  -background {#dcdcdc}  -height {230}  -highlightbackground {#dcdcdc}  -width {416}

  scrollbar .tpimagesel.frame.scrollbar3  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpimagesel.frame.listbox1 xview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -orient {horizontal}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}

  scrollbar .tpimagesel.frame.scrollbar2  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpimagesel.frame.listbox1 yview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}

  listbox .tpimagesel.frame.listbox1  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -xscrollcommand {.tpimagesel.frame.scrollbar3 set}  -yscrollcommand {.tpimagesel.frame.scrollbar2 set}
  # bindings
  bind .tpimagesel.frame.listbox1 <<ListboxSelect>> {if {[string length $TPimgCmd] > 0} {
   set TPtemp [%W curselection]
   if {$TPtemp != {}} {
       set TPtemp [%W get $TPtemp]
       if {$TPimgSelNamespacePrefix != {::}} {
          set TPtemp $TPimgSelNamespacePrefix$TPtemp
         }
       eval "$TPimgCmd \{$TPtemp\}"
       catch "$TPcfgCmd \{$TPtemp\}"
      }
  }}

  label .tpimagesel.frame.label4  -activebackground {#dcdcdc}  -background {slategray3}  -font {Helvetica 10}  -foreground {black}  -highlightbackground {#dcdcdc}  -relief {raised}  -text {Currently defined images}

  frame .tpimagesel.frame.frame27  -background {#dcdcdc}  -height {26}  -highlightbackground {#dcdcdc}  -width {416}

  label .tpimagesel.frame.frame27.label28  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Display image names containing:}

  entry .tpimagesel.frame.frame27.entry29  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -textvariable {TPimageSel(findstr)}
  # bindings
  bind .tpimagesel.frame.frame27.entry29 <Key-KP_Enter> {TP_ImgListFill2}
  bind .tpimagesel.frame.frame27.entry29 <Key-Return> {TP_ImgListFill2}

  # pack master .tpimagesel.frame0
  pack configure .tpimagesel.frame0.label2  -side left
  pack configure .tpimagesel.frame0.menubutton1  -side left

  # pack master .tpimagesel.frame
  pack configure .tpimagesel.frame.label4  -fill x
  pack configure .tpimagesel.frame.frame27  -fill x  -side bottom
  pack configure .tpimagesel.frame.scrollbar2  -fill y  -side left
  pack configure .tpimagesel.frame.listbox1  -expand 1  -fill both
  pack configure .tpimagesel.frame.scrollbar3  -fill x  -side bottom

  # pack master .tpimagesel.frame.frame27
  pack configure .tpimagesel.frame.frame27.label28  -side left
  pack configure .tpimagesel.frame.frame27.entry29  -expand 1  -fill x  -side left

  # pack master .tpimagesel
  pack configure .tpimagesel.frame0  -fill x
  pack configure .tpimagesel.frame  -expand 1  -fill both

EndSrc.tpimagesel
}

proc DestroyWindow.tpimagesel {} {
     catch "destroy .tpimagesel"
     update
}

proc EndSrc.tpimagesel {} {
wm iconphoto .tpimagesel tplogo16
TP_MenuFromList5 .tpimagesel.frame0.menubutton1.m [concat :: [TP_NamespaceList ::]]
TP_ImgListFill2
}


proc ShowWindow.tpinputbox { args} {

  catch "destroy .tpinputbox"

  toplevel .tpinputbox   -relief {raised}  -background {#eeeeee}  -highlightbackground {#eeeeee}

  # Window manager configurations
  wm positionfrom .tpinputbox program
  wm sizefrom .tpinputbox program
  wm maxsize .tpinputbox 2560 100
  wm minsize .tpinputbox 338 100
  wm protocol .tpinputbox WM_DELETE_WINDOW {.tpinputbox.frame4.button6 invoke}
  wm title .tpinputbox {TKproE - Create directory}


  label .tpinputbox.label2  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {0}  -font {Helvetica 10 bold}  -foreground {red}  -highlightbackground {#dcdcdc}  -text {Enter name for new subdirectory}  -textvariable {TPinput(msg)}

  frame .tpinputbox.frame5  -borderwidth {2}  -background {#dcdcdc}  -height {28}  -highlightbackground {#dcdcdc}  -width {250}

  label .tpinputbox.frame5.label2  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Name:}  -textvariable {TPinput(label)}

  entry .tpinputbox.frame5.entry0  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -textvariable {TPinput(value)}  -width {24}

  frame .tpinputbox.frame4  -background {#dcdcdc}  -height {35}  -highlightbackground {#dcdcdc}  -width {126}

  button .tpinputbox.frame4.button5  -activebackground {gray75}  -background {#dcdcdc}  -command {if {[string length $TPinput(cmd)] > 0} {
    catch $TPinput(cmd)
    set TPinput(cmd) {}
  }
DestroyWindow.tpinputbox}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {OK}  -width {6}

  button .tpinputbox.frame4.button6  -activebackground {gray75}  -background {#dcdcdc}  -command {set TPinput(cmd) {}
DestroyWindow.tpinputbox}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Cancel}  -width {6}

  # pack master .tpinputbox.frame5
  pack configure .tpinputbox.frame5.label2  -side left
  pack configure .tpinputbox.frame5.entry0  -expand 1  -fill x  -side left

  # pack master .tpinputbox.frame4
  pack configure .tpinputbox.frame4.button5  -padx 2  -side left
  pack configure .tpinputbox.frame4.button6  -padx 2  -side left

  # pack master .tpinputbox
  pack configure .tpinputbox.label2
  pack configure .tpinputbox.frame5  -fill x
  pack configure .tpinputbox.frame4  -pady 4  -side bottom

  wm iconphoto .tpinputbox tplogo16
}

proc DestroyWindow.tpinputbox {} {
     catch "destroy .tpinputbox"
     update
}


proc ShowWindow.tpmenu { args} {

  catch "destroy .tpmenu"

  toplevel .tpmenu   -relief {raised}  -background {#dcdcdc}  -highlightbackground {#dcdcdc}

  # Window manager configurations
  wm positionfrom .tpmenu program
  wm sizefrom .tpmenu program
  wm maxsize .tpmenu 2560 1024
  wm minsize .tpmenu 560 510
  wm protocol .tpmenu WM_DELETE_WINDOW {DestroyWindow.tpmenu}
  wm title .tpmenu {TKproE menu editor}


  frame .tpmenu.frame0  -borderwidth {2}  -relief {ridge}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {364}

  label .tpmenu.frame0.label1  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Widget name: }

  label .tpmenu.frame0.label2  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -foreground {blue}  -highlightbackground {#dcdcdc}  -text {.top2.menubutton2.m}  -textvariable {TPcurMenu}

  button .tpmenu.frame0.button35  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_PathMenuCreate $TPcurMenu
DestroyWindow.tpproperties
after 10
update
set TPcurWidget $TPcurMenu
ShowWindow.tpproperties}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {More}

  checkbutton .tpmenu.frame0.checkbutton1  -activebackground {#e6e7e6}  -background {#dcdcdc}  -command {catch {$TPcurMenu configure -tearoff $TPtearoff}}  -font {Helvetica 10}  -highlightbackground {#e6e7e6}  -highlightthickness {0}  -text {Tear Off menu}  -variable {TPtearoff}

  frame .tpmenu.frame2  -borderwidth {2}  -background {#dcdcdc}  -height {484}  -highlightbackground {#dcdcdc}  -width {489}

  frame .tpmenu.frame2.frame30  -borderwidth {2}  -relief {ridge}  -background {#dcdcdc}  -height {658}  -highlightbackground {#dcdcdc}  -width {232}

  scrollbar .tpmenu.frame2.frame30.scrollbar3  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpmenu.frame2.frame30.listbox1 xview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -orient {horizontal}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}

  scrollbar .tpmenu.frame2.frame30.scrollbar2  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpmenu.frame2.frame30.listbox1 yview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}

  listbox .tpmenu.frame2.frame30.listbox1  -exportselection {0}  -font {Helvetica 10}  -height {16}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -width {22}  -xscrollcommand {.tpmenu.frame2.frame30.scrollbar3 set}  -yscrollcommand {.tpmenu.frame2.frame30.scrollbar2 set}
  # bindings
  bind .tpmenu.frame2.frame30.listbox1 <<ListboxSelect>> {set TPtemp [%W curselection]
if {$TPtemp != {}} {
    if {[winfo exists $TPcurMenu]} {
        if {[TP_ClassGet $TPcurMenu] == {Menu}} {
	# Adjust index for tearoff menus
	if {[$TPcurMenu cget -tearoff]} { incr TPtemp }

	set TPmenuItemType [$TPcurMenu type $TPtemp]
	foreach TPtemp [$TPcurMenu entryconfigure $TPtemp] {
		set TPmenuItem([string range [lindex $TPtemp 0] 1 end]) [lindex $TPtemp 4]
	          }
	.tpmenu.frame2.frame7.frame.text2 delete 1.0 end
	.tpmenu.frame2.frame7.frame.text2 insert end $TPmenuItem(command)
	TP_MenuForm_Config $TPmenuItemType

	if {$TPmenuItemType == {cascade}} {
	    .tpmenu.frame31.button0 configure -state normal
	   } { .tpmenu.frame31.button0 configure -state disabled }
           }
       }
   }}

  label .tpmenu.frame2.frame30.label29  -activebackground {#dcdcdc}  -background {#96968c}  -borderwidth {2}  -font {Helvetica 10}  -foreground {black}  -highlightbackground {#dcdcdc}  -text {Menu items}

  frame .tpmenu.frame2.frame30.frame4  -background {#96968C}  -height {45}  -highlightbackground {#e6e7e6}  -width {232}

  button .tpmenu.frame2.frame30.frame4.button5  -activebackground {gray75}  -background {#dcdcdc}  -command {set TPtemp [.tpmenu.frame2.frame30.listbox1 curselection]
if {$TPtemp != {}} {
    if {$TPtemp > 0} {
        if {[winfo exists $TPcurMenu]} {
            if {[TP_ClassGet $TPcurMenu] == {Menu}} {
	  # Adjust index for tearoff menus.
	  if {[$TPcurMenu cget -tearoff]} { incr TPtemp }

	  set TPidx1 $TPtemp
	  incr TPidx1
	  set TPidx2 [expr {$TPtemp - 1}]
	  TP_MenuCopy_Item $TPcurMenu $TPtemp $TPidx2
	  $TPcurMenu delete $TPidx1
	  .tpmenu.frame32.button4 invoke
	  .tpmenu.frame2.frame30.listbox1 selection clear 0 end
	  .tpmenu.frame2.frame30.listbox1 selection set $TPidx2
	  .tpmenu.frame2.frame30.listbox1 see $TPidx2
	  event generate .tpmenu.frame2.frame30.listbox1 <<ListboxSelect>>
  	 }
           }
       }
   }}  -compound {right}  -font {Helvetica 10}  -highlightbackground {#e6e7e6}  -highlightthickness {0}  -image {tparrow_up}  -pady {0}  -text {Up}  -width {50}

  button .tpmenu.frame2.frame30.frame4.button6  -activebackground {gray75}  -background {#dcdcdc}  -command {set TPtemp [.tpmenu.frame2.frame30.listbox1 curselection]
if {$TPtemp != {}} {
    if {($TPtemp + 1) < [.tpmenu.frame2.frame30.listbox1 size]} {
        if {[winfo exists $TPcurMenu]} {
            if {[TP_ClassGet $TPcurMenu] == {Menu}} {
	  # Adjust index for tearoff menus.
	  if {[$TPcurMenu cget -tearoff]} { incr TPtemp }

	  set TPidx1 $TPtemp
	  set TPidx2 $TPtemp
	  incr TPidx2
	  TP_MenuCopy_Item $TPcurMenu $TPidx1 $TPidx2
	  $TPcurMenu delete $TPidx1
	  .tpmenu.frame32.button4 invoke
	  .tpmenu.frame2.frame30.listbox1 selection clear 0 end
	  .tpmenu.frame2.frame30.listbox1 selection set $TPidx2
	  .tpmenu.frame2.frame30.listbox1 see $TPidx2
	  event generate .tpmenu.frame2.frame30.listbox1 <<ListboxSelect>>
  	 }
           }
       }
   }}  -compound {left}  -font {Helvetica 10}  -highlightbackground {#e6e7e6}  -highlightthickness {0}  -image {tparrow_down}  -pady {0}  -text {Down}  -width {50}

  label .tpmenu.frame2.frame30.frame4.label7  -activebackground {#e6e7e6}  -background {#96968C}  -borderwidth {0}  -font {Helvetica 12 italic}  -foreground {white}  -highlightbackground {#e6e7e6}  -text {Move selected item}

  frame .tpmenu.frame2.frame7  -borderwidth {2}  -relief {ridge}  -background {#dcdcdc}  -height {701}  -highlightbackground {#dcdcdc}  -width {305}

  frame .tpmenu.frame2.frame7.frame8  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {233}

  label .tpmenu.frame2.frame7.frame8.label9  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Label:}  -width {10}

  entry .tpmenu.frame2.frame7.frame8.entry10  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -textvariable {TPmenuItem(label)}

  frame .tpmenu.frame2.frame7.frame  -relief {raised}  -background {#dcdcdc}  -highlightbackground {#dcdcdc}

  scrollbar .tpmenu.frame2.frame7.frame.scrollbar1  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpmenu.frame2.frame7.frame.text2 yview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}

  text .tpmenu.frame2.frame7.frame.text2  -font {Helvetica 10}  -height {4}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -width {30}  -wrap {none}  -xscrollcommand {.tpmenu.frame2.frame7.frame.scrollbar3 set}  -yscrollcommand {.tpmenu.frame2.frame7.frame.scrollbar1 set}

  scrollbar .tpmenu.frame2.frame7.frame.scrollbar3  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpmenu.frame2.frame7.frame.text2 xview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -orient {horizontal}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}

  label .tpmenu.frame2.frame7.frame.label28  -activebackground {#dcdcdc}  -background {BlanchedAlmond}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -relief {raised}  -text {Command:}

  frame .tpmenu.frame2.frame7.frame11  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {233}

  label .tpmenu.frame2.frame7.frame11.label9  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Accelerator:}  -width {10}

  entry .tpmenu.frame2.frame7.frame11.entry10  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -textvariable {TPmenuItem(accelerator)}
  # bindings
  bind .tpmenu.frame2.frame7.frame11.entry10 <Button-3> {TP_PropsValueSel %W %X %Y accelerator TPmenuItem}

  frame .tpmenu.frame2.frame7.frame12  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {233}

  label .tpmenu.frame2.frame7.frame12.label9  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Background:}  -width {10}

  entry .tpmenu.frame2.frame7.frame12.entry10  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -textvariable {TPmenuItem(background)}
  # bindings
  bind .tpmenu.frame2.frame7.frame12.entry10 <Button-3> {TP_PropsValueSel %W %X %Y background TPmenuItem}

  frame .tpmenu.frame2.frame7.frame13  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {233}

  label .tpmenu.frame2.frame7.frame13.label9  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Active bg:}  -width {10}

  entry .tpmenu.frame2.frame7.frame13.entry10  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -textvariable {TPmenuItem(activebackground)}
  # bindings
  bind .tpmenu.frame2.frame7.frame13.entry10 <Button-3> {TP_PropsValueSel %W %X %Y activebackground TPmenuItem}

  frame .tpmenu.frame2.frame7.frame14  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {233}

  label .tpmenu.frame2.frame7.frame14.label9  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Bitmap:}  -width {10}

  entry .tpmenu.frame2.frame7.frame14.entry10  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -textvariable {TPmenuItem(bitmap)}
  # bindings
  bind .tpmenu.frame2.frame7.frame14.entry10 <Button-3> {TP_PropsValueSel %W %X %Y bitmap TPmenuItem}

  frame .tpmenu.frame2.frame7.frame15  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {233}

  label .tpmenu.frame2.frame7.frame15.label9  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Image:}  -width {10}

  entry .tpmenu.frame2.frame7.frame15.entry10  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -textvariable {TPmenuItem(image)}
  # bindings
  bind .tpmenu.frame2.frame7.frame15.entry10 <Button-3> {TP_PropsValueSel %W %X %Y image TPmenuItem}

  frame .tpmenu.frame2.frame7.frame16  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {233}

  label .tpmenu.frame2.frame7.frame16.label9  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Font:}  -width {10}

  entry .tpmenu.frame2.frame7.frame16.entry10  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -textvariable {TPmenuItem(font)}
  # bindings
  bind .tpmenu.frame2.frame7.frame16.entry10 <Button-3> {TP_PropsValueSel %W %X %Y font TPmenuItem}

  frame .tpmenu.frame2.frame7.frame17  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {233}

  label .tpmenu.frame2.frame7.frame17.label9  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Menu:}  -width {10}

  entry .tpmenu.frame2.frame7.frame17.entry10  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -textvariable {TPmenuItem(menu)}

  frame .tpmenu.frame2.frame7.frame18  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {233}

  label .tpmenu.frame2.frame7.frame18.label9  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {OFF value:}  -width {10}

  entry .tpmenu.frame2.frame7.frame18.entry10  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -textvariable {TPmenuItem(offvalue)}
  # bindings
  bind .tpmenu.frame2.frame7.frame18.entry10 <Button-3> {TP_PropsValueSel %W %X %Y onvalue TPmenuItem}

  frame .tpmenu.frame2.frame7.frame19  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {233}

  label .tpmenu.frame2.frame7.frame19.label9  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {ON value:}  -width {10}

  entry .tpmenu.frame2.frame7.frame19.entry10  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -textvariable {TPmenuItem(onvalue)}

  frame .tpmenu.frame2.frame7.frame20  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {233}

  label .tpmenu.frame2.frame7.frame20.label9  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Variable:}  -width {10}

  entry .tpmenu.frame2.frame7.frame20.entry10  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -textvariable {TPmenuItem(variable)}
  # bindings
  bind .tpmenu.frame2.frame7.frame20.entry10 <Button-3> {TP_PropsValueSel %W %X %Y variable TPmenuItem}

  frame .tpmenu.frame2.frame7.frame21  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {233}

  label .tpmenu.frame2.frame7.frame21.label9  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Value:}  -width {10}

  entry .tpmenu.frame2.frame7.frame21.entry10  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -textvariable {TPmenuItem(value)}
  # bindings
  bind .tpmenu.frame2.frame7.frame21.entry10 <Button-3> {TP_PropsValueSel %W %X %Y value TPmenuItem}

  frame .tpmenu.frame2.frame7.frame22  -borderwidth {2}  -background {#dcdcdc}  -height {26}  -highlightbackground {#dcdcdc}  -width {232}

  label .tpmenu.frame2.frame7.frame22.label9  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {State:}  -width {10}

  radiobutton .tpmenu.frame2.frame7.frame22.radiobutton23  -activebackground {#dcdcdc}  -background {#dcdcdc}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Normal}  -value {normal}  -variable {TPmenuItem(state)}

  radiobutton .tpmenu.frame2.frame7.frame22.radiobutton24  -activebackground {#dcdcdc}  -background {#dcdcdc}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Active}  -value {active}  -variable {TPmenuItem(state)}

  radiobutton .tpmenu.frame2.frame7.frame22.radiobutton25  -activebackground {#dcdcdc}  -background {#dcdcdc}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Disabled}  -value {disabled}  -variable {TPmenuItem(state)}

  label .tpmenu.frame2.frame7.label29  -activebackground {#dcdcdc}  -background {BlanchedAlmond}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -relief {raised}  -text {Item properties}  -width {43}

  frame .tpmenu.frame2.frame7.frame0  -borderwidth {2}  -background {#dcdcdc}  -height {26}  -highlightbackground {#dcdcdc}  -width {232}

  label .tpmenu.frame2.frame7.frame0.label9  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Underline:}  -width {10}

  scale .tpmenu.frame2.frame7.frame0.scale2  -activebackground {#dcdcdc}  -background {#dcdcdc}  -font {Helvetica 10}  -from {-1.0}  -highlightbackground {#dcdcdc}  -orient {horizontal}  -sliderlength {16}  -troughcolor {#dcdcdc}  -variable {TPmenuItem(underline)}  -width {8}

  frame .tpmenu.frame2.frame7.frame1  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {233}

  label .tpmenu.frame2.frame7.frame1.label9  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Entry type:}  -width {10}

  menubutton .tpmenu.frame2.frame7.frame1.menubutton3  -activebackground {#e6e7e6}  -background {#dcdcdc}  -font {Helvetica 10}  -highlightbackground {#e6e7e6}  -image {tparrowcombo}  -menu {.tpmenu.frame2.frame7.frame1.menubutton3.m}  -padx {5}  -pady {1}  -relief {raised}  -compound {right}  -text {command}  -textvariable {TPmenuItemType}  -width {88}

  menu .tpmenu.frame2.frame7.frame1.menubutton3.m  -activebackground {#e6e7e6}  -background {#e6e7e6}  -font {Helvetica 10}  -tearoff {0}
  .tpmenu.frame2.frame7.frame1.menubutton3.m add command  -command {set TPmenuItemType cascade
TP_MenuForm_Config $TPmenuItemType
.tpmenu.frame2.frame30.listbox1 selection clear 0 end
.tpmenu.frame2.frame7.frame.text2 delete 1.0 end
set TPtemp 1
while {$TPtemp < 100} {
          if {[winfo exists $TPcurMenu.m$TPtemp]} {
              incr TPtemp
             } {
                  set TPmenuItem(menu) $TPcurMenu.m$TPtemp
                  set TPtemp 100
               }
        }}  -label {cascade}
  .tpmenu.frame2.frame7.frame1.menubutton3.m add command  -command {set TPmenuItemType checkbutton
TP_MenuForm_Config $TPmenuItemType
.tpmenu.frame2.frame30.listbox1 selection clear 0 end
.tpmenu.frame2.frame7.frame.text2 delete 1.0 end
set TPmenuItem(menu) {}}  -label {checkbutton}
  .tpmenu.frame2.frame7.frame1.menubutton3.m add command  -command {set TPmenuItemType command
TP_MenuForm_Config $TPmenuItemType
.tpmenu.frame2.frame30.listbox1 selection clear 0 end
.tpmenu.frame2.frame7.frame.text2 delete 1.0 end
set TPmenuItem(menu) {}}  -label {command}
  .tpmenu.frame2.frame7.frame1.menubutton3.m add command  -command {set TPmenuItemType radiobutton
TP_MenuForm_Config $TPmenuItemType
.tpmenu.frame2.frame30.listbox1 selection clear 0 end
.tpmenu.frame2.frame7.frame.text2 delete 1.0 end
set TPmenuItem(menu) {}}  -label {radiobutton}
  .tpmenu.frame2.frame7.frame1.menubutton3.m add command  -command {set TPmenuItemType separator
TP_MenuForm_Config $TPmenuItemType
.tpmenu.frame2.frame30.listbox1 selection clear 0 end
.tpmenu.frame2.frame7.frame.text2 delete 1.0 end
set TPmenuItem(menu) {}}  -label {separator}

  frame .tpmenu.frame32  -relief {ridge}  -background {#dcdcdc}  -height {30}  -highlightbackground {#dcdcdc}  -width {364}

  button .tpmenu.frame32.button33  -activebackground {gray75}  -background {#dcdcdc}  -command {DestroyWindow.tpmenu}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Done}

  button .tpmenu.frame32.button34  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_SnapshotRestoreMenu $TPcurMenu
.tpmenu.frame32.button4 invoke}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Undo}

  button .tpmenu.frame32.button35  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_SnapshotRestoreMenu $TPcurMenu
DestroyWindow.tpmenu}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Cancel}

  button .tpmenu.frame32.button4  -activebackground {gray75}  -background {#dcdcdc}  -command {.tpmenu.frame2.frame30.listbox1 delete 0 end
.tpmenu.frame2.frame7.frame.text2 delete 1.0 end
.tpmenu.frame31.button0 configure -state disabled
if {[winfo exists $TPcurMenu]} {
    if {[TP_ClassGet [winfo parent $TPcurMenu]] == {Menu}} {
        # The menu's parent is also a menu. Enable the Cascade Up button.
        .tpmenu.frame31.button2 configure -state normal
       } { .tpmenu.frame31.button2 configure -state disabled }

    # Clear out the options array.
    foreach TPidx [array names TPmenuItem] {
	  switch $TPidx {
		columnbreak -
		underline		{ set TPmenuItem($TPidx) 0 }
		default		{ set TPmenuItem($TPidx) {} }
	          }
	}

    # Fill the menu items list box.
    TP_MenuTreeFill .tpmenu.frame2.frame30.listbox1 [TP_MenuTree $TPcurMenu]
   }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {ReScan}

  frame .tpmenu.frame31  -borderwidth {2}  -relief {ridge}  -background {#dcdcdc}  -height {30}  -highlightbackground {#dcdcdc}  -width {249}

  button .tpmenu.frame31.button38  -activebackground {gray75}  -background {#dcdcdc}  -command {if {[winfo exists $TPcurMenu]} {
     set TPidx [.tpmenu.frame2.frame30.listbox1 curselection]
     set TPmenuItem(command) [.tpmenu.frame2.frame7.frame.text2 get 1.0 end]
     $TPcurMenu add $TPmenuItemType
     foreach TPidx [array names TPmenuItem] {
	   if {[catch {$TPcurMenu entryconfigure end -$TPidx $TPmenuItem($TPidx)} TPresult]} {
	       #puts $TPresult
	      }
	 }
     if {$TPmenuItemType == {cascade}} {
          catch {menu $TPmenuItem(menu)}
        }
     .tpmenu.frame32.button4 invoke
   }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Add}  -width {5}

  button .tpmenu.frame31.button29  -activebackground {gray75}  -background {#dcdcdc}  -command {set TPtemp [.tpmenu.frame2.frame30.listbox1 curselection]
if {$TPtemp != {}} {
    if {[winfo exists $TPcurMenu]} {
        # Copy the current menu entry information to the menu cut buffer.
        array set TPmenuBuf [array get TPmenuItem]

        # Adjust the entry index for tearoff menus.
        if {[$TPcurMenu cget -tearoff]} { incr TPtemp }

        # Delete the current menu entry.
        $TPcurMenu delete $TPtemp
        .tpmenu.frame32.button4 invoke
       }
   }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Delete}  -width {5}

  button .tpmenu.frame31.button0  -activebackground {gray75}  -background {#dcdcdc}  -command {if {[winfo exists $TPmenuItem(menu)]} {
     set TPcurMenu $TPmenuItem(menu)
     TP_SnapshotMenu $TPcurMenu
     .tpmenu.frame32.button4 invoke
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -state {disabled}  -text {Cascade Down}

  button .tpmenu.frame31.button2  -activebackground {gray75}  -background {#dcdcdc}  -command {if {[winfo exists $TPcurMenu]} {
     set TPcurMenu [winfo parent $TPcurMenu]
     TP_SnapshotMenu $TPcurMenu
     .tpmenu.frame32.button4 invoke
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -state {disabled}  -text {Cascade Up}

  button .tpmenu.frame31.button3  -activebackground {gray75}  -background {#dcdcdc}  -command {if {[winfo exists $TPcurMenu]} {
    set TPidx2 [.tpmenu.frame2.frame30.listbox1 curselection]
    if {$TPidx2 != {}} {
        # Account for tearoff menu entry.
        set TPidx1 $TPidx2
        if {[$TPcurMenu cget -tearoff]} { incr TPidx2 }

       # Retrieve command string
       set TPmenuItem(command) [.tpmenu.frame2.frame7.frame.text2 get 1.0 end]

       # Update the currently selected menu item to the modified property values.
        foreach TPidx [array names TPmenuItem] {
	      switch $TPidx {
		  command {
			      if {[catch "$TPcurMenu entryconfigure $TPidx2 -command \{$TPmenuItem(command)\}" TPresult]} {
				DestroyWindow.tpmsgbox
				after 100
				update
				set TPmessage "The following error occured while setting command for the $TPcurMenu menu item:\n\n$TPresult"
				set TPmsgButtons {OK}
				ShowWindow.tpmsgbox
   			         }
			    }
		  label	{
			  .tpmenu.frame2.frame30.listbox1 insert $TPidx1 $TPmenuItem(label)
			  incr TPidx1
			  .tpmenu.frame2.frame30.listbox1 delete $TPidx1 $TPidx1
			  incr TPidx1 -1
			  .tpmenu.frame2.frame30.listbox1 selection set $TPidx1 $TPidx1
			  catch {$TPcurMenu entryconfigure $TPidx2 -$TPidx $TPmenuItem($TPidx)} TPresult
			}
		  menu	{
			  if {$TPmenuItemType == {cascade}} {
			      # Update the assigned menu.
			      set TPmenuItem(menu) [string trim $TPmenuItem(menu)]
			      if {$TPmenuItem(menu) == {}} {
			          # Empty string
			          $TPcurMenu entryconfigure $TPidx2 -menu {}
			          set TPtemp 0
			         } {
				if {[winfo exists $TPmenuItem(menu)]} {
				    set TPtemp 1
				   } {
				       # The submenu doesn't yet exist. Try to create it.
				       if {[catch {menu $TPmenuItem(menu) -tearoff 0}]} { set TPtemp 0 } { set TPtemp 1}
				     }
			           }
			      if {$TPtemp} {
			          if {[lsearch [winfo children $TPcurMenu] $TPmenuItem(menu)] != -1} {
				# The submenu is a proper child of the current menu
				$TPcurMenu entryconfigure $TPidx2 -menu $TPmenuItem(menu)
			             }
			         }
			     }
			}
		  default	{
			  catch {$TPcurMenu entryconfigure $TPidx2 -$TPidx $TPmenuItem($TPidx)} TPresult
			}
		}
	    }
       }
   }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Modify}  -width {5}

  # pack master .tpmenu.frame0
  pack configure .tpmenu.frame0.label1  -side left
  pack configure .tpmenu.frame0.label2  -side left
  pack configure .tpmenu.frame0.button35  -side right
  pack configure .tpmenu.frame0.checkbutton1  -expand 1  -fill y

  # pack master .tpmenu.frame2
  pack configure .tpmenu.frame2.frame30  -expand 1  -fill both  -side left
  pack configure .tpmenu.frame2.frame7  -anchor n  -expand 1  -fill both  -side left

  # pack master .tpmenu.frame2.frame30
  pack configure .tpmenu.frame2.frame30.label29  -fill x
  pack configure .tpmenu.frame2.frame30.frame4  -fill x  -side bottom
  pack configure .tpmenu.frame2.frame30.scrollbar2  -fill y  -side left
  pack configure .tpmenu.frame2.frame30.listbox1  -expand 1  -fill both
  pack configure .tpmenu.frame2.frame30.scrollbar3  -fill x  -side bottom

  # pack master .tpmenu.frame2.frame30.frame4
  pack configure .tpmenu.frame2.frame30.frame4.label7  -side bottom
  pack configure .tpmenu.frame2.frame30.frame4.button5  -padx 2  -pady 2  -side left
  pack configure .tpmenu.frame2.frame30.frame4.button6  -padx 2  -pady 2  -side right

  # pack master .tpmenu.frame2.frame7
  pack configure .tpmenu.frame2.frame7.label29  -fill x
  pack configure .tpmenu.frame2.frame7.frame1  -fill x
  pack configure .tpmenu.frame2.frame7.frame8  -fill x
  pack configure .tpmenu.frame2.frame7.frame13  -fill x
  pack configure .tpmenu.frame2.frame7.frame11  -fill x
  pack configure .tpmenu.frame2.frame7.frame12  -fill x
  pack configure .tpmenu.frame2.frame7.frame14  -fill x
  pack configure .tpmenu.frame2.frame7.frame15  -fill x
  pack configure .tpmenu.frame2.frame7.frame16  -fill x
  pack configure .tpmenu.frame2.frame7.frame17  -fill x
  pack configure .tpmenu.frame2.frame7.frame22  -fill x
  pack configure .tpmenu.frame2.frame7.frame0  -fill x
  pack configure .tpmenu.frame2.frame7.frame  -expand 1  -fill both

  # pack master .tpmenu.frame2.frame7.frame8
  pack configure .tpmenu.frame2.frame7.frame8.label9  -side left
  pack configure .tpmenu.frame2.frame7.frame8.entry10  -expand 1  -fill x  -side left

  # pack master .tpmenu.frame2.frame7.frame
  pack configure .tpmenu.frame2.frame7.frame.label28  -fill x
  pack configure .tpmenu.frame2.frame7.frame.scrollbar1  -fill y  -side left
  pack configure .tpmenu.frame2.frame7.frame.text2  -expand 1  -fill both
  pack configure .tpmenu.frame2.frame7.frame.scrollbar3  -fill x  -side bottom

  # pack master .tpmenu.frame2.frame7.frame11
  pack configure .tpmenu.frame2.frame7.frame11.label9  -side left
  pack configure .tpmenu.frame2.frame7.frame11.entry10  -expand 1  -fill x  -side left

  # pack master .tpmenu.frame2.frame7.frame12
  pack configure .tpmenu.frame2.frame7.frame12.label9  -side left
  pack configure .tpmenu.frame2.frame7.frame12.entry10  -expand 1  -fill x  -side left

  # pack master .tpmenu.frame2.frame7.frame13
  pack configure .tpmenu.frame2.frame7.frame13.label9  -side left
  pack configure .tpmenu.frame2.frame7.frame13.entry10  -expand 1  -fill x  -side left

  # pack master .tpmenu.frame2.frame7.frame14
  pack configure .tpmenu.frame2.frame7.frame14.label9  -side left
  pack configure .tpmenu.frame2.frame7.frame14.entry10  -expand 1  -fill x  -side left

  # pack master .tpmenu.frame2.frame7.frame15
  pack configure .tpmenu.frame2.frame7.frame15.label9  -side left
  pack configure .tpmenu.frame2.frame7.frame15.entry10  -expand 1  -fill x  -side left

  # pack master .tpmenu.frame2.frame7.frame16
  pack configure .tpmenu.frame2.frame7.frame16.label9  -side left
  pack configure .tpmenu.frame2.frame7.frame16.entry10  -expand 1  -fill x  -side left

  # pack master .tpmenu.frame2.frame7.frame17
  pack configure .tpmenu.frame2.frame7.frame17.label9  -side left
  pack configure .tpmenu.frame2.frame7.frame17.entry10  -expand 1  -fill x  -side left

  # pack master .tpmenu.frame2.frame7.frame18
  pack configure .tpmenu.frame2.frame7.frame18.label9  -side left
  pack configure .tpmenu.frame2.frame7.frame18.entry10  -expand 1  -fill x  -side left

  # pack master .tpmenu.frame2.frame7.frame19
  pack configure .tpmenu.frame2.frame7.frame19.label9  -side left
  pack configure .tpmenu.frame2.frame7.frame19.entry10  -expand 1  -fill x  -side left

  # pack master .tpmenu.frame2.frame7.frame20
  pack configure .tpmenu.frame2.frame7.frame20.label9  -side left
  pack configure .tpmenu.frame2.frame7.frame20.entry10  -expand 1  -fill x  -side left

  # pack master .tpmenu.frame2.frame7.frame21
  pack configure .tpmenu.frame2.frame7.frame21.label9  -side left
  pack configure .tpmenu.frame2.frame7.frame21.entry10  -expand 1  -fill x  -side left

  # pack master .tpmenu.frame2.frame7.frame22
  pack configure .tpmenu.frame2.frame7.frame22.label9  -side left
  pack configure .tpmenu.frame2.frame7.frame22.radiobutton23  -side left
  pack configure .tpmenu.frame2.frame7.frame22.radiobutton24  -side left
  pack configure .tpmenu.frame2.frame7.frame22.radiobutton25  -side left

  # pack master .tpmenu.frame2.frame7.frame0
  pack configure .tpmenu.frame2.frame7.frame0.label9  -side left
  pack configure .tpmenu.frame2.frame7.frame0.scale2  -fill x

  # pack master .tpmenu.frame2.frame7.frame1
  pack configure .tpmenu.frame2.frame7.frame1.label9  -side left
  pack configure .tpmenu.frame2.frame7.frame1.menubutton3  -side left

  # pack master .tpmenu.frame32
  pack configure .tpmenu.frame32.button33  -side left
  pack configure .tpmenu.frame32.button35  -side right
  pack configure .tpmenu.frame32.button34  -side right
  pack configure .tpmenu.frame32.button4  -side left

  # pack master .tpmenu.frame31
  pack configure .tpmenu.frame31.button38  -side left
  pack configure .tpmenu.frame31.button3  -side left
  pack configure .tpmenu.frame31.button2  -anchor e  -expand 1  -side left
  pack configure .tpmenu.frame31.button29  -side right
  pack configure .tpmenu.frame31.button0  -anchor w  -expand 1  -side left

  # pack master .tpmenu
  pack configure .tpmenu.frame0  -fill x
  pack configure .tpmenu.frame2  -expand 1  -fill both
  pack configure .tpmenu.frame32  -fill x  -side bottom
  pack configure .tpmenu.frame31  -fill x  -side bottom

  .tpmenu.frame2.frame7.frame.text2 insert end {}

EndSrc.tpmenu
}

proc DestroyWindow.tpmenu {} {
     catch "destroy .tpmenu"
     update
}

proc EndSrc.tpmenu {} {
global TPcurMenu

wm iconphoto .tpmenu tplogo16
.tpmenu.frame2.frame30.listbox1 delete 0 end
TP_MenuTreeFill .tpmenu.frame2.frame30.listbox1 [TP_MenuTree $TPcurMenu]
}


proc ShowWindow.tpmsgbox { args} {

  catch "destroy .tpmsgbox"

  toplevel .tpmsgbox   -relief {raised}  -background {#dcdcdc}  -highlightbackground {#dcdcdc}

  # Window manager configurations
  wm positionfrom .tpmsgbox program
  wm sizefrom .tpmsgbox program
  wm maxsize .tpmsgbox 1000 1000
  wm minsize .tpmsgbox 300 90
  wm protocol .tpmsgbox WM_DELETE_WINDOW {set TPmessage {}
DestroyWindow.tpmsgbox}
  wm title .tpmsgbox {TKproE message}

  # bindings
  bind .tpmsgbox <ButtonRelease-1> {TP_ProcessClick %W %X %Y %x %y}
  bind .tpmsgbox <Shift-Button-3> {TP_PropsSelWidget %W}

  frame .tpmsgbox.frame1  -borderwidth {2}  -background {#dcdcdc}  -height {30}  -highlightbackground {#dcdcdc}  -width {230}

  button .tpmsgbox.frame1.button5  -activebackground {gray75}  -background {#dcdcdc}  -command {set TPmessage {}
DestroyWindow.tpmsgbox}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -padx {4}  -text {OK}  -width {4}

  button .tpmsgbox.frame1.button4  -activebackground {gray75}  -background {#dcdcdc}  -command {set TPmessage {}
DestroyWindow.tpmsgbox
if {[string length $TPmsgCmd(Yes)] > 0} {
   catch $TPmsgCmd(Yes)
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -padx {4}  -text {Yes}  -width {4}

  button .tpmsgbox.frame1.button6  -activebackground {gray75}  -background {#dcdcdc}  -command {set TPmessage {}
DestroyWindow.tpmsgbox
if {[string length $TPmsgCmd(No)] > 0} {
   catch $TPmsgCmd(No)
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -padx {4}  -text {No}  -width {4}

  button .tpmsgbox.frame1.button1  -activebackground {gray75}  -background {#dcdcdc}  -command {set TPmessage {}
DestroyWindow.tpmsgbox
if {[string length $TPmsgCmd(Accept)] > 0} {
   catch $TPmsgCmd(Accept)
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -padx {4}  -text {Accept}  -width {6}

  button .tpmsgbox.frame1.button3  -activebackground {gray75}  -background {#dcdcdc}  -command {set TPmessage {}
DestroyWindow.tpmsgbox
if {[string length $TPmsgCmd(Cancel)] > 0} {
   catch $TPmsgCmd(Cancel)
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -padx {4}  -text {Cancel}  -width {6}

  message .tpmsgbox.message7  -aspect {1500}  -background {#ffad99}  -font {Helvetica 12 bold}  -justify {center}  -relief {groove}  -textvariable {TPmessage}

  entry .tpmsgbox.entry0  -background {oldlace}  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -textvariable {TPglobalVarNew}

  # pack master .tpmsgbox.frame1
  pack configure .tpmsgbox.frame1.button5  -expand 1  -side left

  # pack master .tpmsgbox
  pack configure .tpmsgbox.message7  -expand 1  -fill both
  pack configure .tpmsgbox.frame1  -fill x

EndSrc.tpmsgbox
}

proc DestroyWindow.tpmsgbox {} {
     catch "destroy .tpmsgbox"
     update
}

proc EndSrc.tpmsgbox {} {
global TPmsgButtons

wm iconphoto .tpmsgbox tplogo16

pack forget .tpmsgbox.frame1.button1
pack forget .tpmsgbox.frame1.button3
pack forget .tpmsgbox.frame1.button4
pack forget .tpmsgbox.frame1.button5
pack forget .tpmsgbox.frame1.button6

if {[lsearch $TPmsgButtons Input] < 0} {
    pack forget .tpmsgbox.entry0
  } {
      pack .tpmsgbox.entry0 -side top -fill x -after .tpmsgbox.message7
    }

if {[string length $TPmsgButtons] == 0} { set TPmsgButtons OK }
if {[lsearch $TPmsgButtons OK] > -1} { pack .tpmsgbox.frame1.button5 -side left -expand 1 }
if {[lsearch $TPmsgButtons Yes] > -1} { pack .tpmsgbox.frame1.button4 -side left -expand 1 }
if {[lsearch $TPmsgButtons No] > -1} { pack .tpmsgbox.frame1.button6 -side left -expand 1 }
if {[lsearch $TPmsgButtons Accept] > -1} { pack .tpmsgbox.frame1.button1 -side left -expand 1 }
if {[lsearch $TPmsgButtons Cancel] > -1} { pack .tpmsgbox.frame1.button3 -side left -expand 1 }
}


proc ShowWindow.tpnewspace { args} {

  catch "destroy .tpnewspace"

  toplevel .tpnewspace   -relief {raised}  -background {#dcdcdc}  -highlightbackground {#eeeeee}

  # Window manager configurations
  wm positionfrom .tpnewspace program
  wm sizefrom .tpnewspace program
  wm maxsize .tpnewspace 224 78
  wm minsize .tpnewspace 250 78
  wm protocol .tpnewspace WM_DELETE_WINDOW {DestroyWindow.tpnewspace}
  wm title .tpnewspace {Add new namespace}


  label .tpnewspace.label7  -activebackground {#eeeeee}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -foreground {red}  -highlightbackground {#eeeeee}  -text {Enter name for new namespace}

  entry .tpnewspace.entry8  -background {white}  -font {Helvetica 10}  -foreground {black}  -highlightbackground {#ffffff}  -selectbackground {#447bcd}  -selectforeground {#ffffff}  -textvariable {TPnewspace}

  frame .tpnewspace.frame9  -borderwidth {2}  -background {#dcdcdc}  -height {32}  -highlightbackground {#eeeeee}  -width {136}

  button .tpnewspace.frame9.button10  -activebackground {gray75}  -background {#dcdcdc}  -command {DestroyWindow.tpnewspace
namespace eval $TPnewspace {}}  -font {Helvetica 10}  -foreground {black}  -highlightbackground {#eeeeee}  -highlightthickness {0}  -pady {0}  -text {Accept}

  button .tpnewspace.frame9.button12  -activebackground {gray75}  -background {#dcdcdc}  -command {DestroyWindow.tpnewspace}  -font {Helvetica 10}  -foreground {black}  -highlightbackground {#eeeeee}  -highlightthickness {0}  -pady {0}  -text {Cancel}

  # pack master .tpnewspace.frame9
  pack configure .tpnewspace.frame9.button10  -padx 2  -side left
  pack configure .tpnewspace.frame9.button12  -padx 2  -side left

  # pack master .tpnewspace
  pack configure .tpnewspace.label7
  pack configure .tpnewspace.entry8  -fill x
  pack configure .tpnewspace.frame9  -side bottom

EndSrc.tpnewspace
}

proc DestroyWindow.tpnewspace {} {
     catch "destroy .tpnewspace"
     update
}

proc EndSrc.tpnewspace {} {
global TPnewspace

wm iconphoto .tpnewspace tplogo16
set TPnewspace {}
}

proc ShowWindow.tptabs {} {
# Display configuration dialog for notebook tabs.
set wname .tptabs
set ::TPcurWidget $::TPcurNotebook
if {[winfo exists $wname]} { return {} } 

toplevel .tptabs

wm title .tptabs {Notebook tab properties}
wm geometry .tptabs 350x430+0+0
wm maxsize .tptabs 2560 410
wm minsize .tptabs 350 430
wm protocol .tptabs WM_DELETE_WINDOW {.tptabs.frame11.button12 invoke}

frame .tptabs.frame8 -relief {ridge} -height {30} -width {30}
#LISSI
button .tptabs.frame8.buttonSCR -activebackground {#eeeeee} -background {grey85} -command {TP_SaveCaptureWindow $TPcurNotebook} -font {Helvetica 10} -highlightbackground {#eeeeee} -highlightthickness {0} -pady {1} -text {Screenshot}
pack .tptabs.frame8.buttonSCR -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

label .tptabs.frame8.label9 -borderwidth {0} -font {Helvetica 10} -relief {raised} -text { Widget name:}
pack .tptabs.frame8.label9 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

label .tptabs.frame8.label10 -borderwidth {0} -font {Helvetica 10} -foreground {blue} -relief {raised} -text {.nb} -textvariable TPcurNotebook
pack .tptabs.frame8.label10 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

button .tptabs.frame8.button14 -command {set TPcurWidget $TPcurNotebook
if {[winfo exists .tpproperties]} {
     EndSrc.tpproperties
   } { ShowWindow.tpproperties }} -font {Helvetica 10} -padx {4} -pady {0} -text {More}
pack .tptabs.frame8.button14 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side right

pack .tptabs.frame8 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tptabs.frame8.label9 .tptabs.frame8.label10 .tptabs.frame8.button14 -in .tptabs.frame8

frame .tptabs.frame11 -relief {groove} -height {30} -width {30}

button .tptabs.frame11.button12 -command {.tptabs.frame.listbox1 delete 0 end
DestroyWindow.tptabs} -font {Helvetica 10} -highlightthickness {0} -padx {4} -pady {1} -text {Done}
pack .tptabs.frame11.button12 -anchor center -expand 1 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

button .tptabs.frame11.button14 -command {.tptabs.frame.listbox1 delete 0 end
if {[TP_ClassGet $TPcurNotebook] eq {TNotebook}} {
    set TPtemp [$TPcurNotebook tabs]
    eval ".tptabs.frame.listbox1 insert end $TPtemp"
    foreach TPtabwin [winfo children $TPcurNotebook] {
	 if {[lsearch $TPtemp $TPtabwin] == -1} {
	     .tptabs.frame.listbox1 insert end $TPtabwin
	     .tptabs.frame.listbox1 itemconfigure end -background salmon
	    }
                }
    TP_NotebookSelect .tptabs.frame.listbox1
   }
} -font {Helvetica 10} -padx {4} -pady {1} -text {Refresh}
pack .tptabs.frame11.button14 -anchor center -expand 1 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

pack .tptabs.frame11 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side bottom
pack .tptabs.frame11.button12 .tptabs.frame11.button14 -in .tptabs.frame11

frame .tptabs.frame

scrollbar .tptabs.frame.scrollbar2 -command {.tptabs.frame.listbox1 yview} -relief {raised} -width {10}
pack .tptabs.frame.scrollbar2 -anchor center -expand 0 -fill y -ipadx 0 -ipady 0 -padx 0 -pady 0 -side right

listbox .tptabs.frame.listbox1 -background {white} -borderwidth {2} -exportselection {0} -height {6} -relief {ridge} -selectmode {single} -yscrollcommand {.tptabs.frame.scrollbar2 set}
bind .tptabs.frame.listbox1 <<ListboxSelect>> {TP_NotebookSelect %W}
pack .tptabs.frame.listbox1 -anchor center -expand 1 -fill both -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top

pack .tptabs.frame -anchor center -expand 1 -fill both -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tptabs.frame.scrollbar2 .tptabs.frame.listbox1 -in .tptabs.frame

frame .tptabs.frame0 -relief {ridge} -height {30} -width {30}

button .tptabs.frame0.button12 -command {set TPtemp [.tptabs.frame.listbox1 curselection]
if {[llength $TPtemp]} {
     if {$TPtemp > 0} {
          set TPpos $TPtemp
          incr TPpos -1
          set TPtemp [.tptabs.frame.listbox1 get $TPtemp]
          set TPwin [winfo parent $TPtemp]
          $TPwin insert $TPpos $TPtemp
          .tptabs.frame11.button14 invoke
          .tptabs.frame.listbox1 selection set $TPpos
          TP_NotebookSelect .tptabs.frame.listbox1
        }
   }} -compound {right} -font {Helvetica 10} -highlightthickness {0} -image {tpnavup} -padx {2} -pady {0} -text {Up}
pack .tptabs.frame0.button12 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 2 -pady 0 -side left

button .tptabs.frame0.button13 -command {set TPtemp [.tptabs.frame.listbox1 curselection]
if {[llength $TPtemp]} {
          set TPpos $TPtemp
          incr TPpos 
          if {$TPpos < [.tptabs.frame.listbox1 size]} {
              set TPtemp [.tptabs.frame.listbox1 get $TPtemp]
              set TPwin [winfo parent $TPtemp]
              $TPwin insert $TPpos $TPtemp
              .tptabs.frame11.button14 invoke
              .tptabs.frame.listbox1 selection set $TPpos
              TP_NotebookSelect .tptabs.frame.listbox1
             }
   }} -compound {left} -font {Helvetica 10} -image {tpnavdown} -padx {2} -pady {0} -text {Down}
pack .tptabs.frame0.button13 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

pack .tptabs.frame0 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tptabs.frame0.button12 .tptabs.frame0.button13 -in .tptabs.frame0

frame .tptabs.frame17 -relief {ridge} -height {30} -width {30}

label .tptabs.frame17.label18 -anchor {w} -borderwidth {0} -font {Helvetica 10 bold} -relief {raised} -text { State:} -width {9}
pack .tptabs.frame17.label18 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

radiobutton .tptabs.frame17.radiobutton4 -anchor {w} -borderwidth {0} -command {if {[TP_ClassGet $TPcurNotebook] eq {TNotebook}} {
     $TPcurNotebook tab $TPnotebookChild -state $TPtabprop(state)
   }
} -font {Helvetica 10} -justify {left} -text {Normal} -value {normal} -variable {TPtabprop(state)}

pack .tptabs.frame17.radiobutton4 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

radiobutton .tptabs.frame17.radiobutton0 -anchor {w} -borderwidth {0} -command {if {[TP_ClassGet $TPcurNotebook] eq {TNotebook}} {
     $TPcurNotebook tab $TPnotebookChild -state $TPtabprop(state)
   }
} -font {Helvetica 10} -text {Disabled} -value {disabled} -variable {TPtabprop(state)}
pack .tptabs.frame17.radiobutton0 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

radiobutton .tptabs.frame17.radiobutton1 -anchor {w} -borderwidth {0} -command {if {[TP_ClassGet $TPcurNotebook] eq {TNotebook}} {
     $TPcurNotebook tab $TPnotebookChild -state $TPtabprop(state)
   }
} -font {Helvetica 10} -text {Hidden} -value {hidden} -variable {TPtabprop(state)}
pack .tptabs.frame17.radiobutton1 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

pack .tptabs.frame17 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tptabs.frame17.label18 .tptabs.frame17.radiobutton4 .tptabs.frame17.radiobutton0 .tptabs.frame17.radiobutton1 -in .tptabs.frame17

frame .tptabs.frame21 -relief {ridge} -height {30} -width {30}

label .tptabs.frame21.label18 -anchor {w} -borderwidth {0} -font {Helvetica 10 bold} -relief {raised} -text { Padding:} -width {10}
pack .tptabs.frame21.label18 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

spinbox .tptabs.frame21.spinbox22 -background {white} -command {if {[TP_ClassGet $TPcurNotebook] eq {TNotebook}} {
     $TPcurNotebook tab $TPnotebookChild -padding $TPtabprop(padding)
   }
} -textvariable {TPtabprop(padding)} -to {10.0} -width {5}
pack .tptabs.frame21.spinbox22 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 2 -pady 0 -side left

pack .tptabs.frame21 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tptabs.frame21.label18 .tptabs.frame21.spinbox22 -in .tptabs.frame21

frame .tptabs.frame30 -borderwidth {2} -height {77} -highlightbackground {#eeeeee} -width {182}

frame .tptabs.frame30.frame23 -relief {raised} -background {#eeeeee} -height {15} -highlightbackground {#eeeeee} -width {106}

button .tptabs.frame30.frame23.button24 -activebackground {gray75} -background {#dcdcdc} -command {TP_NotebookShowSticky N} -font {Helvetica 4} -foreground {black} -height {6} -highlightbackground {#eeeeee} -highlightthickness {0} -image {tpblank} -width {50}

pack .tptabs.frame30.frame23.button24 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top

button .tptabs.frame30.frame23.button25 -activebackground {gray75} -background {#dcdcdc} -command {TP_NotebookShowSticky {N W}} -font {Helvetica 4} -foreground {black} -height {6} -highlightbackground {#eeeeee} -highlightthickness {0} -image {tpblank} -width {6}
pack .tptabs.frame30.frame23.button25 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

button .tptabs.frame30.frame23.button29 -activebackground {gray75} -background {#dcdcdc} -command {TP_NotebookShowSticky {N E}} -font {Helvetica 4} -foreground {black} -height {6} -highlightbackground {#eeeeee} -highlightthickness {0} -image {tpblank} -width {6}
pack .tptabs.frame30.frame23.button29 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side right

pack .tptabs.frame30.frame23 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 4 -pady 0 -side top
pack .tptabs.frame30.frame23.button29 .tptabs.frame30.frame23.button25 .tptabs.frame30.frame23.button24 -in .tptabs.frame30.frame23

frame .tptabs.frame30.frame32 -relief {raised} -height {15} -highlightbackground {#eeeeee} -width {106}

button .tptabs.frame30.frame32.button25 -activebackground {gray75} -background {#dcdcdc} -command {TP_NotebookShowSticky W} -font {Helvetica 2} -foreground {black} -height {50} -highlightbackground {#eeeeee} -highlightthickness {0} -image {tpblank} -width {6}
pack .tptabs.frame30.frame32.button25 -anchor w -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

button .tptabs.frame30.frame32.button29 -activebackground {gray75} -background {#dcdcdc} -command {TP_NotebookShowSticky E} -font {Helvetica 2} -foreground {black} -height {50} -highlightbackground {#eeeeee} -highlightthickness {0} -image {tpblank} -width {6}
pack .tptabs.frame30.frame32.button29 -anchor e -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side right

frame .tptabs.frame30.frame32.frame0 -borderwidth {2} -relief {raised} -background {skyblue} -height {20} -highlightbackground {#eeeeee} -width {20}
pack .tptabs.frame30.frame32.frame0 -anchor center -expand 1 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

pack .tptabs.frame30.frame32 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 4 -pady 0 -side top
pack .tptabs.frame30.frame32.button25 .tptabs.frame30.frame32.button29 .tptabs.frame30.frame32.frame0 -in .tptabs.frame30.frame32

frame .tptabs.frame30.frame33 -relief {raised} -background {#eeeeee} -height {15} -highlightbackground {#eeeeee} -width {106}

button .tptabs.frame30.frame33.button24 -activebackground {gray75} -background {#dcdcdc} -command {TP_NotebookShowSticky S} -font {Helvetica 4} -foreground {black} -height {6} -highlightbackground {#eeeeee} -highlightthickness {0} -image {tpblank} -width {50}
pack .tptabs.frame30.frame33.button24 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top

button .tptabs.frame30.frame33.button25 -activebackground {gray75} -background {#dcdcdc} -command {TP_NotebookShowSticky {S W}} -font {Helvetica 4} -foreground {black} -height {6} -highlightbackground {#eeeeee} -highlightthickness {0} -image {tpblank} -width {6}
pack .tptabs.frame30.frame33.button25 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

button .tptabs.frame30.frame33.button29 -activebackground {gray75} -background {#dcdcdc} -command {TP_NotebookShowSticky {S E}} -font {Helvetica 4} -foreground {black} -height {6} -highlightbackground {#eeeeee} -highlightthickness {0} -image {tpblank} -width {6}
pack .tptabs.frame30.frame33.button29 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side right

pack .tptabs.frame30.frame33 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 4 -pady 0 -side top
pack .tptabs.frame30.frame33.button29 .tptabs.frame30.frame33.button25 .tptabs.frame30.frame33.button24 -in .tptabs.frame30.frame33

label .tptabs.frame30.label13 -anchor {w} -borderwidth {0} -font {Helvetica 10 bold} -text { Sticky:} -width {12}
pack .tptabs.frame30.label13 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

pack .tptabs.frame30 -anchor w -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tptabs.frame30.label13 .tptabs.frame30.frame23 .tptabs.frame30.frame32 .tptabs.frame30.frame33 -in .tptabs.frame30

frame .tptabs.frame19 -relief {ridge} -height {30} -width {30}

entry .tptabs.frame19.entry20 -textvariable {TPnewtab} -width {8}
bind .tptabs.frame19.entry20 <FocusOut> {set TPnewtab [string trim $TPnewtab]
set TPwin [winfo parent $TPnotebookChild]
if {[lsearch [$TPwin tabs] $TPnotebookChild] == -1} {
    $TPwin add $TPnotebookChild -text $TPnewtab
   } {
       $TPwin tab $TPnotebookChild -text $TPnewtab
     }
}

bind .tptabs.frame19.entry20 <Key-KP_Enter> {set TPnewtab [string trim $TPnewtab]
set TPwin [winfo parent $TPnotebookChild]
if {[lsearch [$TPwin tabs] $TPnotebookChild] == -1} {
    $TPwin add $TPnotebookChild -text $TPnewtab
   } {
       $TPwin tab $TPnotebookChild -text $TPnewtab
     }
}

bind .tptabs.frame19.entry20 <Key-Return> {set TPnewtab [string trim $TPnewtab]
set TPwin [winfo parent $TPnotebookChild]
if {[lsearch [$TPwin tabs] $TPnotebookChild] == -1} {
    $TPwin add $TPnotebookChild -text $TPnewtab
   } {
       $TPwin tab $TPnotebookChild -text $TPnewtab
     }
}

pack .tptabs.frame19.entry20 -anchor center -expand 1 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

label .tptabs.frame19.label3 -anchor {w} -font {Helvetica 10 bold} -text { Tab text:} -width {10}
pack .tptabs.frame19.label3 -anchor center -expand 0 -fill y -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

pack .tptabs.frame19 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tptabs.frame19.label3 .tptabs.frame19.entry20 -in .tptabs.frame19

frame .tptabs.frame1 -relief {ridge} -height {30} -width {30}

entry .tptabs.frame1.entry20 -textvariable {TPtabprop(image)} -width {8}
bind .tptabs.frame1.entry20 <Button-3> {TP_PropsValueSel %W %X %Y image TPtabprop}
bind .tptabs.frame1.entry20 <FocusOut> {TP_PropsValueSet %W image TPtabprop}
bind .tptabs.frame1.entry20 <Key-KP_Enter> {TP_PropsValueSet %W image TPtabprop}
bind .tptabs.frame1.entry20 <Key-Return> {TP_PropsValueSet %W image TPtabprop}
pack .tptabs.frame1.entry20 -anchor center -expand 1 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

label .tptabs.frame1.label3 -anchor {w} -font {Helvetica 10 bold} -text { Image:} -width {12}
pack .tptabs.frame1.label3 -anchor center -expand 0 -fill y -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

pack .tptabs.frame1 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tptabs.frame1.label3 .tptabs.frame1.entry20 -in .tptabs.frame1

frame .tptabs.frame2 -relief {ridge} -height {30} -width {30}

entry .tptabs.frame2.entry20 -textvariable {TPtabprop(compound)} -width {8}
bind .tptabs.frame2.entry20 <Button-3> {TP_PropsValueSel %W %X %Y compound TPtabprop}
bind .tptabs.frame2.entry20 <FocusOut> {TP_PropsValueSet %W compound TPtabprop}
bind .tptabs.frame2.entry20 <Key-KP_Enter> {TP_PropsValueSet %W compound TPtabprop}
bind .tptabs.frame2.entry20 <Key-Return> {TP_PropsValueSet %W compound TPtabprop}
pack .tptabs.frame2.entry20 -anchor center -expand 1 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

label .tptabs.frame2.label3 -anchor {w} -font {Helvetica 10 bold} -text { Compound:} -width {12}
pack .tptabs.frame2.label3 -anchor center -expand 0 -fill y -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

pack .tptabs.frame2 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tptabs.frame2.label3 .tptabs.frame2.entry20 -in .tptabs.frame2

frame .tptabs.frame5 -relief {ridge} -height {30} -width {30}

label .tptabs.frame5.label18 -anchor {w} -borderwidth {0} -font {Helvetica 10 bold} -relief {raised} -text { Managed:} -width {9}
pack .tptabs.frame5.label18 -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

checkbutton .tptabs.frame5.checkbutton0 -borderwidth {0} -command {set TPwin [winfo parent $TPnotebookChild]
if {$TPtabprop(Managed)} {
    $TPwin add $TPnotebookChild -text NewTab
   } {
        $TPwin forget $TPnotebookChild
     }
.tptabs.frame11.button14 invoke} -padx {3} -relief {raised} -variable {TPtabprop(Managed)}

bind .tptabs.frame5.checkbutton0 <<ListboxSelect>> {set TPtemp [%W curselection]
if {[llength $TPtemp]} {
     if {[%W itemcget $TPtemp -background] eq {salmon}} {
         set TPtabprop(Managed) 0
        } { set TPtabprop(Managed) 1 }
   }
}
pack .tptabs.frame5.checkbutton0 -anchor w -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top

pack .tptabs.frame5 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
pack .tptabs.frame5.label18 .tptabs.frame5.checkbutton0 -in .tptabs.frame5

label .tptabs.label7 -borderwidth {0} -font {Times 12 italic bold} -padx {3} -pady {0} -relief {raised} -text {Tabs}
pack .tptabs.label7 -anchor w -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top

frame .tptabs.line1 -borderwidth {2} -relief {ridge} -height {2} -width {30}
pack .tptabs.line1 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top

frame .tptabs.line2 -borderwidth {2} -relief {ridge} -height {2} -width {30}
pack .tptabs.line2 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side bottom

pack .tptabs.frame8 .tptabs.line1 .tptabs.label7 .tptabs.frame11 .tptabs.line2 .tptabs.frame .tptabs.frame0 .tptabs.frame5 .tptabs.frame19 .tptabs.frame17 .tptabs.frame21 .tptabs.frame1 .tptabs.frame2 .tptabs.frame30 -in .tptabs

EndSrc.tptabs
}

proc DestroyWindow.tptabs {} {
     catch {destroy .tptabs}
     update
     return {}
}

proc EndSrc.tptabs {} {
     wm iconphoto .tptabs tplogo16
     .tptabs.frame11.button14 invoke
}

proc ShowWindow.tpnspacesave { args} {

  catch "destroy .tpnspacesave"

  toplevel .tpnspacesave   -relief {sunken}  -background {#dcdcdc}  -highlightbackground {#eeeeee}

  # Window manager configurations
  wm positionfrom .tpnspacesave program
  wm sizefrom .tpnspacesave program
  wm maxsize .tpnspacesave 2560 1024
  wm minsize .tpnspacesave 342 144
  wm protocol .tpnspacesave WM_DELETE_WINDOW {DestroyWindow.tpnspacesave}
  wm title .tpnspacesave {Select namespace to save}


  frame .tpnspacesave.frame  -background {#dcdcdc}  -highlightbackground {#dcdcdc}

  scrollbar .tpnspacesave.frame.scrollbar2  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpnspacesave.frame.listbox1 yview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}

  listbox .tpnspacesave.frame.listbox1  -font {Helvetica 10}  -height {4}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -width {40}  -yscrollcommand {.tpnspacesave.frame.scrollbar2 set}

  menu .tpnspacesave.frame.listbox1.menu6  -activebackground {#dcdcdc}  -background {#dcdcdc}  -font {Helvetica 10}  -tearoff {0}
  .tpnspacesave.frame.listbox1.menu6 add command  -command {set TPidx [lindex [.tpnspacesave.frame.listbox1 curselection] 0]
if {$TPidx != {}} {
    TP_ExcludeNamespaceDel [.tpnspacesave.frame.listbox1 get $TPidx]
   }}  -label {Remove selected item}

  frame .tpnspacesave.frame2  -borderwidth {2}  -background {#dcdcdc}  -height {32}  -highlightbackground {#dcdcdc}  -width {364}

  button .tpnspacesave.frame2.button2  -activebackground {gray75}  -background {#dcdcdc}  -command {set TPtemp [.tpnspacesave.frame.listbox1 curselection]
if {$TPtemp != {} } {
    TP_FileSaveNspace [.tpnspacesave.frame.listbox1 get $TPtemp]
    DestroyWindow.tpnspacesave
  }}  -font {Helvetica 10}  -foreground {black}  -highlightbackground {#eeeeee}  -text {Save}  -width {6}

  button .tpnspacesave.frame2.button3  -activebackground {gray75}  -background {#dcdcdc}  -command {DestroyWindow.tpnspacesave}  -font {Helvetica 10}  -foreground {black}  -highlightbackground {#eeeeee}  -text {Cancel}  -width {6}

  frame .tpnspacesave.frame0  -borderwidth {2}  -background {#dcdcdc}  -height {26}  -highlightbackground {#eeeeee}  -width {294}

  label .tpnspacesave.frame0.label1  -activebackground {#eeeeee}  -background {#dcdcdc}  -borderwidth {0}  -font {Helvetica 10}  -foreground {black}  -highlightbackground {#eeeeee}  -relief {raised}  -text {Save to:}

  entry .tpnspacesave.frame0.entry2  -background {white}  -font {Helvetica 10}  -foreground {black}  -highlightbackground {#ffffff}  -selectbackground {#447bcd}  -selectforeground {#ffffff}  -textvariable {TPnspaceFile}

  button .tpnspacesave.frame0.button3  -activebackground {gray75}  -background {#dcdcdc}  -command {set TPtitle "[TP_GetConfig progname]: Save namespace as..."
if {[string length $TPnspaceFile] == 0} {
    set TPtemp [pwd]
   } { set TPtemp [file dirname $TPnspaceFile] }
set TPfname [tk_getSaveFile -title $TPtitle -initialdir $TPtemp -filetypes {{{TCL source code files} .tcl} {{All files} .*}} -initialfile [file tail $TPnspaceFile]]
if {[string length $TPfname] > 0} {
    set TPnspaceFile $TPfname
   }}  -font {Helvetica 10}  -foreground {black}  -highlightbackground {#eeeeee}  -highlightthickness {0}  -pady {0}  -text {Browse}

  # pack master .tpnspacesave.frame
  pack configure .tpnspacesave.frame.scrollbar2  -fill y  -side right
  pack configure .tpnspacesave.frame.listbox1  -expand 1  -fill both

  # pack master .tpnspacesave.frame2
  pack configure .tpnspacesave.frame2.button2  -padx 2  -side left
  pack configure .tpnspacesave.frame2.button3  -padx 2  -side left

  # pack master .tpnspacesave.frame0
  pack configure .tpnspacesave.frame0.label1  -side left
  pack configure .tpnspacesave.frame0.entry2  -expand 1  -fill x  -padx 4  -side left
  pack configure .tpnspacesave.frame0.button3  -side left

  # pack master .tpnspacesave
  pack configure .tpnspacesave.frame  -expand 1  -fill both
  pack configure .tpnspacesave.frame2  -side bottom
  pack configure .tpnspacesave.frame0  -fill x  -side bottom

  .tpnspacesave.frame.listbox1 insert end {::tk::dialog::error}

EndSrc.tpnspacesave
}

proc DestroyWindow.tpnspacesave {} {
     catch "destroy .tpnspacesave"
     update
}

proc EndSrc.tpnspacesave {} {
   global TPexclusions

   wm iconphoto .tpnspacesave tplogo16
   .tpnspacesave.frame.listbox1 delete 0 end
   set nslist [TP_NamespaceList ::]
   set idx 0
   foreach ns $nslist {
	 if {[lsearch $TPexclusions(cantsave_namespace) $ns] < 0} {
	     .tpnspacesave.frame.listbox1 insert end $ns
	    }
	 incr idx
            }
}


proc ShowWindow.tppacker { args} {

  catch "destroy .tppacker"

  toplevel .tppacker   -background {#dcdcdc}  -highlightbackground {#dcdcdc}

  # Window manager configurations
  wm positionfrom .tppacker program
  wm sizefrom .tppacker program
  wm maxsize .tppacker 2560 1024
  wm minsize .tppacker 412 446
  wm protocol .tppacker WM_DELETE_WINDOW {DestroyWindow.tppacker}
  wm title .tppacker {TKproE packer}


  frame .tppacker.frame28  -borderwidth {2}  -background {#dcdcdc}  -height {321}  -highlightbackground {#dcdcdc}  -width {562}

  frame .tppacker.frame28.frame  -background {#dcdcdc}  -highlightbackground {#dcdcdc}

  scrollbar .tppacker.frame28.frame.scrollbar3  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tppacker.frame28.frame.listbox1 xview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -orient {horizontal}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}

  scrollbar .tppacker.frame28.frame.scrollbar2  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tppacker.frame28.frame.listbox1 yview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}

  listbox .tppacker.frame28.frame.listbox1  -exportselection {0}  -font {Helvetica 10}  -height {8}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -xscrollcommand {.tppacker.frame28.frame.scrollbar3 set}  -yscrollcommand {.tppacker.frame28.frame.scrollbar2 set}
  # bindings
  bind .tppacker.frame28.frame.listbox1 <Double-Button-1> {.tppacker.frame28.frame30.listbox1 delete 0 end
set TPtemp  [%W get [%W curselection] ]
if {[winfo exists $TPtemp]} {
    eval ".tppacker.frame28.frame30.listbox1 insert end [pack slaves $TPtemp]"
    TP_SnapshotChildren $TPtemp TPoptionsPack pack
   } {
        .tppacker.frame32.button4 invoke
     }}

  label .tppacker.frame28.frame.label29  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Widgets}

  frame .tppacker.frame28.frame.frame36  -borderwidth {2}  -relief {ridge}  -background {#dcdcdc}  -height {30}  -highlightbackground {#dcdcdc}  -width {249}

  button .tppacker.frame28.frame.frame36.button37  -activebackground {gray75}  -background {#dcdcdc}  -command {set TPtemp [.tppacker.frame28.frame.listbox1 curselection]
if {$TPtemp != {}} {
    set TPtemp [.tppacker.frame28.frame.listbox1 get $TPtemp]
    if {[winfo exists $TPtemp]} {
        if {[catch {pack $TPtemp} TPresult]} {
	    tk_messageBox -icon error -message $TPresult -parent . -title {TKproE error} -type ok
	   }
      }
    .tppacker.frame32.button4 invoke
   }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Pack}  -width {5}

  frame .tppacker.frame28.frame30  -background {#dcdcdc}  -highlightbackground {#dcdcdc}

  scrollbar .tppacker.frame28.frame30.scrollbar3  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tppacker.frame28.frame30.listbox1 xview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -orient {horizontal}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}

  scrollbar .tppacker.frame28.frame30.scrollbar2  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tppacker.frame28.frame30.listbox1 yview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}

  listbox .tppacker.frame28.frame30.listbox1  -exportselection {0}  -font {Helvetica 10}  -height {8}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -xscrollcommand {.tppacker.frame28.frame30.scrollbar3 set}  -yscrollcommand {.tppacker.frame28.frame30.scrollbar2 set}
  # bindings
  bind .tppacker.frame28.frame30.listbox1 <<ListboxSelect>> {set TPpackChild [%W get [%W curselection]]
if {[winfo exists $TPpackChild]} {
    foreach {TPidx TPvalue} [pack info $TPpackChild] {
	  set TPpack($TPidx) $TPvalue
               }
   } {
        # The child no longer exists so let's rescan.
        .tppacker.frame32.button4 invoke
     }}

  label .tppacker.frame28.frame30.label29  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Children}

  scale .tppacker.frame28.frame30.scale31  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {TP_PackSetOrder}  -font {Helvetica 8}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -sliderlength {16}  -to {20.0}  -troughcolor {skyblue}  -width {8}

  frame .tppacker.frame28.frame30.frame36  -borderwidth {2}  -relief {ridge}  -background {#dcdcdc}  -height {30}  -highlightbackground {#dcdcdc}  -width {249}

  button .tppacker.frame28.frame30.frame36.button38  -activebackground {gray75}  -background {#dcdcdc}  -command {set TPtemp [.tppacker.frame28.frame30.listbox1 curselection]
if {$TPtemp != {}} {
    set TPtemp [.tppacker.frame28.frame30.listbox1 get $TPtemp]
    if {[winfo exists $TPtemp]} {
       pack forget $TPtemp
       .tppacker.frame32.button4 invoke
      }
   }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Unpack}  -width {5}

  frame .tppacker.frame28.frame40  -borderwidth {2}  -background {#dcdcdc}  -height {30}  -highlightbackground {#dcdcdc}  -width {8}

  frame .tppacker.frame32  -relief {ridge}  -background {#dcdcdc}  -height {30}  -highlightbackground {#dcdcdc}  -width {364}

  button .tppacker.frame32.button33  -activebackground {gray75}  -background {#dcdcdc}  -command {DestroyWindow.tppacker}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Done}

  button .tppacker.frame32.button34  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_SnapshotRestoreChildren TPoptionsPack pack
.tppacker.frame32.button4 invoke}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Undo}

  button .tppacker.frame32.button35  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_SnapshotRestoreChildren TPoptionsPack pack
DestroyWindow.tppacker}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Cancel}

  button .tppacker.frame32.button4  -activebackground {gray75}  -background {#dcdcdc}  -command {.tppacker.frame28.frame.listbox1 delete 0 end
set TPidx -1
set TPcursel -1
set TPpack(-padx) 0
set TPpack(-pady) 0
set TPpack(-ipadx) 0
set TPpack(-ipady) 0
foreach TPtemp [TP_TreeSearch .] {
	.tppacker.frame28.frame.listbox1 insert end $TPtemp
	incr TPidx
	if {$TPtemp == $TPpackParent} { set TPcursel $TPidx }
          }
if {$TPcursel > -1} {
   .tppacker.frame28.frame.listbox1 selection set $TPcursel $TPcursel
   .tppacker.frame28.frame30.listbox1 delete 0 end
   eval ".tppacker.frame28.frame30.listbox1 insert end [pack slaves $TPpackParent]"
   .tppacker.frame28.frame.listbox1 yview $TPcursel
   TP_SnapshotChildren $TPpackParent TPoptionsPack pack
  } {
      .tppacker.frame28.frame30.listbox1 delete 0 end
      set TPpackChild {}
      set TPpackParent {}
    }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {ReScan}

  frame .tppacker.frame41  -relief {raised}  -background {#dcdcdc}  -height {100}  -highlightbackground {#dcdcdc}  -width {441}

  frame .tppacker.frame41.frame5  -borderwidth {2}  -relief {raised}  -background {#dcdcdc}  -height {100}  -highlightbackground {#dcdcdc}  -width {218}

  label .tppacker.frame41.frame5.label6  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {0}  -font {Helvetica 10 bold}  -highlightbackground {#dcdcdc}  -relief {raised}  -text {Fill}  -width {25}

  checkbutton .tppacker.frame41.frame5.checkbutton27  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {if {[string length $TPpackChild] > 0} {
   if {[winfo exists $TPpackChild]} { pack configure $TPpackChild -expand $TPpack(-expand) }
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Expand}  -variable {TPpack(-expand)}

  frame .tppacker.frame41.frame5.frame9  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {118}

  radiobutton .tppacker.frame41.frame5.frame9.radiobutton7  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -command {if {[string length $TPpackChild] > 0} {
   if {[winfo exists $TPpackChild]} { pack configure $TPpackChild -fill $TPpack(-fill) }
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {X}  -value {x}  -variable {TPpack(-fill)}  -width {4}

  radiobutton .tppacker.frame41.frame5.frame9.radiobutton11  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -command {if {[string length $TPpackChild] > 0} {
   if {[winfo exists $TPpackChild]} { pack configure $TPpackChild -fill $TPpack(-fill) }
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Y}  -value {y}  -variable {TPpack(-fill)}  -width {4}

  frame .tppacker.frame41.frame5.frame10  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {118}

  radiobutton .tppacker.frame41.frame5.frame10.radiobutton11  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -command {if {[string length $TPpackChild] > 0} {
   if {[winfo exists $TPpackChild]} { pack configure $TPpackChild -fill $TPpack(-fill) }
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Both}  -value {both}  -variable {TPpack(-fill)}  -width {4}

  radiobutton .tppacker.frame41.frame5.frame10.radiobutton8  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -command {if {[string length $TPpackChild] > 0} {
   if {[winfo exists $TPpackChild]} { pack configure $TPpackChild -fill $TPpack(-fill) }
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {None}  -value {none}  -variable {TPpack(-fill)}  -width {4}

  frame .tppacker.frame41.frame19  -borderwidth {2}  -relief {raised}  -background {#dcdcdc}  -height {72}  -highlightbackground {#dcdcdc}  -width {183}

  label .tppacker.frame41.frame19.label20  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {0}  -font {Helvetica 10 bold}  -highlightbackground {#dcdcdc}  -text {Padding}  -width {25}

  frame .tppacker.frame41.frame19.frame21  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {174}

  label .tppacker.frame41.frame19.frame21.label22  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Internal:}  -width {7}

  spinbox .tppacker.frame41.frame19.frame21.spinbox1

  .tppacker.frame41.frame19.frame21.spinbox1 config  -background {linen}  -buttonbackground {#dcdcdc}  -command {if {[string length $TPpackChild] > 0} {
   if {[winfo exists $TPpackChild]} { pack configure $TPpackChild -ipadx $TPpack(-ipadx) }
  }}  -font {Helvetica 10}  -textvariable {TPpack(-ipadx)}  -to {40.0}  -width {4}
  # bindings
  bind .tppacker.frame41.frame19.frame21.spinbox1 <FocusOut> {catch [%W cget -command]}
  bind .tppacker.frame41.frame19.frame21.spinbox1 <Key-KP_Enter> {catch [%W cget -command]}
  bind .tppacker.frame41.frame19.frame21.spinbox1 <Key-Return> {catch [%W cget -command]}

  label .tppacker.frame41.frame19.frame21.label23  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {X}

  label .tppacker.frame41.frame19.frame21.label24  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Y}

  spinbox .tppacker.frame41.frame19.frame21.spinbox25

  .tppacker.frame41.frame19.frame21.spinbox25 config  -background {linen}  -buttonbackground {#dcdcdc}  -command {if {[string length $TPpackChild] > 0} {
   if {[winfo exists $TPpackChild]} { pack configure $TPpackChild -ipady $TPpack(-ipady) }
  }}  -font {Helvetica 10}  -textvariable {TPpack(-ipady)}  -to {40.0}  -width {4}
  # bindings
  bind .tppacker.frame41.frame19.frame21.spinbox25 <FocusOut> {catch [%W cget -command]}
  bind .tppacker.frame41.frame19.frame21.spinbox25 <Key-KP_Enter> {catch [%W cget -command]}
  bind .tppacker.frame41.frame19.frame21.spinbox25 <Key-Return> {catch [%W cget -command]}

  frame .tppacker.frame41.frame19.frame26  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {179}

  label .tppacker.frame41.frame19.frame26.label22  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {External:}  -width {7}

  spinbox .tppacker.frame41.frame19.frame26.spinbox1

  .tppacker.frame41.frame19.frame26.spinbox1 config  -background {linen}  -buttonbackground {#dcdcdc}  -command {if {[string length $TPpackChild] > 0} {
   if {[winfo exists $TPpackChild]} { pack configure $TPpackChild -padx $TPpack(-padx) }
  }}  -font {Helvetica 10}  -textvariable {TPpack(-padx)}  -to {40.0}  -width {4}
  # bindings
  bind .tppacker.frame41.frame19.frame26.spinbox1 <FocusOut> {catch [%W cget -command]}
  bind .tppacker.frame41.frame19.frame26.spinbox1 <Key-KP_Enter> {catch [%W cget -command]}
  bind .tppacker.frame41.frame19.frame26.spinbox1 <Key-Return> {catch [%W cget -command]}

  label .tppacker.frame41.frame19.frame26.label23  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {X}

  label .tppacker.frame41.frame19.frame26.label24  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Y}

  spinbox .tppacker.frame41.frame19.frame26.spinbox25

  .tppacker.frame41.frame19.frame26.spinbox25 config  -background {linen}  -buttonbackground {#dcdcdc}  -command {if {[string length $TPpackChild] > 0} {
   if {[winfo exists $TPpackChild]} { pack configure $TPpackChild -pady $TPpack(-pady) }
  }}  -font {Helvetica 10}  -textvariable {TPpack(-pady)}  -to {40.0}  -width {4}
  # bindings
  bind .tppacker.frame41.frame19.frame26.spinbox25 <FocusOut> {catch [%W cget -command]}
  bind .tppacker.frame41.frame19.frame26.spinbox25 <Key-KP_Enter> {catch [%W cget -command]}
  bind .tppacker.frame41.frame19.frame26.spinbox25 <Key-Return> {catch [%W cget -command]}

  frame .tppacker.frame42  -relief {raised}  -background {#dcdcdc}  -height {96}  -highlightbackground {#dcdcdc}  -width {441}

  frame .tppacker.frame42.frame1  -borderwidth {2}  -relief {raised}  -background {#dcdcdc}  -height {90}  -highlightbackground {#dcdcdc}  -width {182}

  label .tppacker.frame42.frame1.label2  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {0}  -font {Helvetica 10 bold}  -highlightbackground {#dcdcdc}  -text {Side}  -width {25}

  frame .tppacker.frame42.frame1.frame3  -relief {raised}  -background {#dcdcdc}  -height {72}  -highlightbackground {#dcdcdc}  -width {127}

  radiobutton .tppacker.frame42.frame1.frame3.radiobutton4  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -command {if {[string length $TPpackChild] > 0} {
   if {[winfo exists $TPpackChild]} { pack configure $TPpackChild -side $TPpack(-side) }
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Top}  -value {top}  -variable {TPpack(-side)}  -width {7}

  radiobutton .tppacker.frame42.frame1.frame3.radiobutton6  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -command {if {[string length $TPpackChild] > 0} {
   if {[winfo exists $TPpackChild]} { pack configure $TPpackChild -side $TPpack(-side) }
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Bottom}  -value {bottom}  -variable {TPpack(-side)}  -width {7}

  frame .tppacker.frame42.frame1.frame3.frame0  -borderwidth {2}  -background {#dcdcdc}  -height {26}  -highlightbackground {#dcdcdc}  -width {59}

  label .tppacker.frame42.frame1.frame3.frame0.label9  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Left}

  radiobutton .tppacker.frame42.frame1.frame3.frame0.radiobutton7  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {if {[string length $TPpackChild] > 0} {
   if {[winfo exists $TPpackChild]} { pack configure $TPpackChild -side $TPpack(-side) }
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -value {left}  -variable {TPpack(-side)}

  radiobutton .tppacker.frame42.frame1.frame3.radiobutton8  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {if {[string length $TPpackChild] > 0} {
   if {[winfo exists $TPpackChild]} { pack configure $TPpackChild -side $TPpack(-side) }
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Right}  -value {right}  -variable {TPpack(-side)}  -width {5}

  frame .tppacker.frame42.frame12  -borderwidth {2}  -relief {raised}  -background {#dcdcdc}  -height {92}  -highlightbackground {#dcdcdc}  -width {182}

  label .tppacker.frame42.frame12.label13  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {0}  -font {Helvetica 10 bold}  -highlightbackground {#dcdcdc}  -text {Anchor}  -width {25}

  frame .tppacker.frame42.frame12.frame14  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {154}

  radiobutton .tppacker.frame42.frame12.frame14.radiobutton7  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -command {if {[string length $TPpackChild] > 0} {
   if {[winfo exists $TPpackChild]} { pack configure $TPpackChild -anchor $TPpack(-anchor) }
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {NW}  -value {nw}  -variable {TPpack(-anchor)}  -width {3}

  radiobutton .tppacker.frame42.frame12.frame14.radiobutton15  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -command {if {[string length $TPpackChild] > 0} {
   if {[winfo exists $TPpackChild]} { pack configure $TPpackChild -anchor $TPpack(-anchor) }
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {N}  -value {n}  -variable {TPpack(-anchor)}  -width {2}

  radiobutton .tppacker.frame42.frame12.frame14.radiobutton16  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -command {if {[string length $TPpackChild] > 0} {
   if {[winfo exists $TPpackChild]} { pack configure $TPpackChild -anchor $TPpack(-anchor) }
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {NE}  -value {ne}  -variable {TPpack(-anchor)}  -width {3}

  frame .tppacker.frame42.frame12.frame17  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {154}

  radiobutton .tppacker.frame42.frame12.frame17.radiobutton7  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -command {if {[string length $TPpackChild] > 0} {
   if {[winfo exists $TPpackChild]} { pack configure $TPpackChild -anchor $TPpack(-anchor) }
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {W}  -value {w}  -variable {TPpack(-anchor)}  -width {3}

  radiobutton .tppacker.frame42.frame12.frame17.radiobutton15  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -command {if {[string length $TPpackChild] > 0} {
   if {[winfo exists $TPpackChild]} { pack configure $TPpackChild -anchor $TPpack(-anchor) }
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {C}  -value {center}  -variable {TPpack(-anchor)}  -width {2}

  radiobutton .tppacker.frame42.frame12.frame17.radiobutton16  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -command {if {[string length $TPpackChild] > 0} {
   if {[winfo exists $TPpackChild]} { pack configure $TPpackChild -anchor $TPpack(-anchor) }
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {E}  -value {e}  -variable {TPpack(-anchor)}  -width {3}

  frame .tppacker.frame42.frame12.frame18  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {154}

  radiobutton .tppacker.frame42.frame12.frame18.radiobutton7  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -command {if {[string length $TPpackChild] > 0} {
   if {[winfo exists $TPpackChild]} { pack configure $TPpackChild -anchor $TPpack(-anchor) }
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {SW}  -value {sw}  -variable {TPpack(-anchor)}  -width {3}

  radiobutton .tppacker.frame42.frame12.frame18.radiobutton15  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -command {if {[string length $TPpackChild] > 0} {
   if {[winfo exists $TPpackChild]} { pack configure $TPpackChild -anchor $TPpack(-anchor) }
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {S}  -value {s}  -variable {TPpack(-anchor)}  -width {2}

  radiobutton .tppacker.frame42.frame12.frame18.radiobutton16  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -command {if {[string length $TPpackChild] > 0} {
   if {[winfo exists $TPpackChild]} { pack configure $TPpackChild -anchor $TPpack(-anchor) }
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {SE}  -value {se}  -variable {TPpack(-anchor)}  -width {3}

  # pack master .tppacker.frame28
  pack configure .tppacker.frame28.frame  -expand 1  -fill both  -side left
  pack configure .tppacker.frame28.frame40  -side left
  pack configure .tppacker.frame28.frame30  -expand 1  -fill both  -side left

  # pack master .tppacker.frame28.frame
  pack configure .tppacker.frame28.frame.label29
  pack configure .tppacker.frame28.frame.frame36  -fill x  -side bottom
  pack configure .tppacker.frame28.frame.scrollbar2  -fill y  -side left
  pack configure .tppacker.frame28.frame.listbox1  -expand 1  -fill both
  pack configure .tppacker.frame28.frame.scrollbar3  -fill x  -side bottom

  # pack master .tppacker.frame28.frame.frame36
  pack configure .tppacker.frame28.frame.frame36.button37  -side left

  # pack master .tppacker.frame28.frame30
  pack configure .tppacker.frame28.frame30.label29
  pack configure .tppacker.frame28.frame30.frame36  -fill x  -side bottom
  pack configure .tppacker.frame28.frame30.scale31  -fill y  -side right
  pack configure .tppacker.frame28.frame30.scrollbar2  -fill y  -side left
  pack configure .tppacker.frame28.frame30.listbox1  -expand 1  -fill both
  pack configure .tppacker.frame28.frame30.scrollbar3  -fill x  -side bottom

  # pack master .tppacker.frame28.frame30.frame36
  pack configure .tppacker.frame28.frame30.frame36.button38  -side right

  # pack master .tppacker.frame32
  pack configure .tppacker.frame32.button33  -side left
  pack configure .tppacker.frame32.button35  -side right
  pack configure .tppacker.frame32.button34  -side right
  pack configure .tppacker.frame32.button4  -side left

  # pack master .tppacker.frame41
  pack configure .tppacker.frame41.frame5  -expand 1  -fill both  -side left
  pack configure .tppacker.frame41.frame19  -expand 1  -fill both  -side left

  # pack master .tppacker.frame41.frame5
  pack configure .tppacker.frame41.frame5.label6
  pack configure .tppacker.frame41.frame5.checkbutton27  -side bottom
  pack configure .tppacker.frame41.frame5.frame9
  pack configure .tppacker.frame41.frame5.frame10

  # pack master .tppacker.frame41.frame5.frame9
  pack configure .tppacker.frame41.frame5.frame9.radiobutton7  -side left
  pack configure .tppacker.frame41.frame5.frame9.radiobutton11  -side left

  # pack master .tppacker.frame41.frame5.frame10
  pack configure .tppacker.frame41.frame5.frame10.radiobutton11  -side left
  pack configure .tppacker.frame41.frame5.frame10.radiobutton8  -side left

  # pack master .tppacker.frame41.frame19
  pack configure .tppacker.frame41.frame19.label20
  pack configure .tppacker.frame41.frame19.frame21
  pack configure .tppacker.frame41.frame19.frame26

  # pack master .tppacker.frame41.frame19.frame21
  pack configure .tppacker.frame41.frame19.frame21.label22  -side left
  pack configure .tppacker.frame41.frame19.frame21.label23  -side left
  pack configure .tppacker.frame41.frame19.frame21.spinbox1  -side left
  pack configure .tppacker.frame41.frame19.frame21.label24  -side left
  pack configure .tppacker.frame41.frame19.frame21.spinbox25  -side left

  # pack master .tppacker.frame41.frame19.frame26
  pack configure .tppacker.frame41.frame19.frame26.label22  -side left
  pack configure .tppacker.frame41.frame19.frame26.label23  -side left
  pack configure .tppacker.frame41.frame19.frame26.spinbox1  -side left
  pack configure .tppacker.frame41.frame19.frame26.label24  -side left
  pack configure .tppacker.frame41.frame19.frame26.spinbox25  -side left

  # pack master .tppacker.frame42
  pack configure .tppacker.frame42.frame1  -expand 1  -fill both  -side left
  pack configure .tppacker.frame42.frame12  -expand 1  -fill both  -side left

  # pack master .tppacker.frame42.frame1
  pack configure .tppacker.frame42.frame1.label2
  pack configure .tppacker.frame42.frame1.frame3

  # pack master .tppacker.frame42.frame1.frame3
  pack configure .tppacker.frame42.frame1.frame3.radiobutton4  -anchor e
  pack configure .tppacker.frame42.frame1.frame3.radiobutton6  -anchor e  -side bottom
  pack configure .tppacker.frame42.frame1.frame3.frame0  -side left
  pack configure .tppacker.frame42.frame1.frame3.radiobutton8  -side right

  # pack master .tppacker.frame42.frame1.frame3.frame0
  pack configure .tppacker.frame42.frame1.frame3.frame0.label9  -side left
  pack configure .tppacker.frame42.frame1.frame3.frame0.radiobutton7  -side left

  # pack master .tppacker.frame42.frame12
  pack configure .tppacker.frame42.frame12.label13
  pack configure .tppacker.frame42.frame12.frame14
  pack configure .tppacker.frame42.frame12.frame17
  pack configure .tppacker.frame42.frame12.frame18

  # pack master .tppacker.frame42.frame12.frame14
  pack configure .tppacker.frame42.frame12.frame14.radiobutton7  -side left
  pack configure .tppacker.frame42.frame12.frame14.radiobutton15  -side left
  pack configure .tppacker.frame42.frame12.frame14.radiobutton16  -side left

  # pack master .tppacker.frame42.frame12.frame17
  pack configure .tppacker.frame42.frame12.frame17.radiobutton7  -side left
  pack configure .tppacker.frame42.frame12.frame17.radiobutton15  -side left
  pack configure .tppacker.frame42.frame12.frame17.radiobutton16  -side left

  # pack master .tppacker.frame42.frame12.frame18
  pack configure .tppacker.frame42.frame12.frame18.radiobutton7  -side left
  pack configure .tppacker.frame42.frame12.frame18.radiobutton15  -side left
  pack configure .tppacker.frame42.frame12.frame18.radiobutton16  -side left

  # pack master .tppacker
  pack configure .tppacker.frame41  -fill x
  pack configure .tppacker.frame42  -fill x
  pack configure .tppacker.frame28  -expand 1  -fill both
  pack configure .tppacker.frame32  -fill x  -side bottom

  .tppacker.frame28.frame.listbox1 insert end {.}

EndSrc.tppacker
}

proc DestroyWindow.tppacker {} {
     catch "destroy .tppacker"
     update
}

proc EndSrc.tppacker {} {
# Scan the widget tree using the procedure attached to the ReScan button
wm iconphoto .tppacker tplogo16
.tppacker.frame32.button4 invoke
}


proc ShowWindow.tpplacer { args} {

  catch "destroy .tpplacer"

  toplevel .tpplacer   -relief {raised}  -background {#dcdcdc}  -highlightbackground {#dcdcdc}

  # Window manager configurations
  wm positionfrom .tpplacer program
  wm sizefrom .tpplacer program
  wm maxsize .tpplacer 2560 1024
  wm minsize .tpplacer 370 500
  wm protocol .tpplacer WM_DELETE_WINDOW {DestroyWindow.tpplacer}
  wm title .tpplacer {TKproE placer}


  frame .tpplacer.frame19  -background {#dcdcdc}  -height {96}  -highlightbackground {#dcdcdc}  -width {267}

  frame .tpplacer.frame19.frame12  -borderwidth {2}  -relief {raised}  -background {#dcdcdc}  -height {92}  -highlightbackground {#dcdcdc}  -width {182}

  label .tpplacer.frame19.frame12.label13  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {0}  -font {Helvetica 10 bold}  -highlightbackground {#dcdcdc}  -text {Anchor}  -width {20}

  frame .tpplacer.frame19.frame12.frame14  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {154}

  radiobutton .tpplacer.frame19.frame12.frame14.radiobutton7  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -command {if {[string length $TPplaceChild] > 0} {
   if {[winfo exists $TPplaceChild]} { place configure $TPplaceChild -anchor $TPplace(-anchor) }
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {NW}  -value {nw}  -variable {TPplace(-anchor)}  -width {3}

  radiobutton .tpplacer.frame19.frame12.frame14.radiobutton15  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -command {if {[string length $TPplaceChild] > 0} {
   if {[winfo exists $TPplaceChild]} { place configure $TPplaceChild -anchor $TPplace(-anchor) }
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {N}  -value {n}  -variable {TPplace(-anchor)}  -width {2}

  radiobutton .tpplacer.frame19.frame12.frame14.radiobutton16  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -command {if {[string length $TPplaceChild] > 0} {
   if {[winfo exists $TPplaceChild]} { place configure $TPplaceChild -anchor $TPplace(-anchor) }
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {NE}  -value {ne}  -variable {TPplace(-anchor)}  -width {3}

  frame .tpplacer.frame19.frame12.frame17  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {154}

  radiobutton .tpplacer.frame19.frame12.frame17.radiobutton7  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -command {if {[string length $TPplaceChild] > 0} {
   if {[winfo exists $TPplaceChild]} { place configure $TPplaceChild -anchor $TPplace(-anchor) }
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {W}  -value {w}  -variable {TPplace(-anchor)}  -width {3}

  radiobutton .tpplacer.frame19.frame12.frame17.radiobutton15  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -command {if {[string length $TPplaceChild] > 0} {
   if {[winfo exists $TPplaceChild]} { place configure $TPplaceChild -anchor $TPplace(-anchor) }
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {C}  -value {c}  -variable {TPplace(-anchor)}  -width {2}

  radiobutton .tpplacer.frame19.frame12.frame17.radiobutton16  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -command {if {[string length $TPplaceChild] > 0} {
   if {[winfo exists $TPplaceChild]} { place configure $TPplaceChild -anchor $TPplace(-anchor) }
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {E}  -value {e}  -variable {TPplace(-anchor)}  -width {3}

  frame .tpplacer.frame19.frame12.frame18  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {154}

  radiobutton .tpplacer.frame19.frame12.frame18.radiobutton7  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -command {if {[string length $TPplaceChild] > 0} {
   if {[winfo exists $TPplaceChild]} { place configure $TPplaceChild -anchor $TPplace(-anchor) }
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {SW}  -value {sw}  -variable {TPplace(-anchor)}  -width {3}

  radiobutton .tpplacer.frame19.frame12.frame18.radiobutton15  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -command {if {[string length $TPplaceChild] > 0} {
   if {[winfo exists $TPplaceChild]} { place configure $TPplaceChild -anchor $TPplace(-anchor) }
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {S}  -value {s}  -variable {TPplace(-anchor)}  -width {2}

  radiobutton .tpplacer.frame19.frame12.frame18.radiobutton16  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -command {if {[string length $TPplaceChild] > 0} {
   if {[winfo exists $TPplaceChild]} { place configure $TPplaceChild -anchor $TPplace(-anchor) }
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {SE}  -value {se}  -variable {TPplace(-anchor)}  -width {3}

  frame .tpplacer.frame19.frame13  -borderwidth {2}  -relief {raised}  -background {#dcdcdc}  -height {30}  -highlightbackground {#dcdcdc}  -width {30}

  radiobutton .tpplacer.frame19.frame13.radiobutton7  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -command {if {[string length $TPplaceChild] > 0} {
   if {[winfo exists $TPplaceChild]} { place configure $TPplaceChild -bordermode $TPplace(-bordermode) }
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Inside}  -value {inside}  -variable {TPplace(-bordermode)}  -width {6}

  radiobutton .tpplacer.frame19.frame13.radiobutton15  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -command {if {[string length $TPplaceChild] > 0} {
   if {[winfo exists $TPplaceChild]} { place configure $TPplaceChild -bordermode $TPplace(-bordermode) }
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Outside}  -value {outside}  -variable {TPplace(-bordermode)}  -width {6}

  radiobutton .tpplacer.frame19.frame13.radiobutton16  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -command {if {[string length $TPplaceChild] > 0} {
   if {[winfo exists $TPplaceChild]} { place configure $TPplaceChild -bordermode $TPplace(-bordermode) }
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Ignore}  -value {ignore}  -variable {TPplace(-bordermode)}  -width {6}

  label .tpplacer.frame19.frame13.label18  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {0}  -font {Helvetica 10 bold}  -highlightbackground {#dcdcdc}  -text {Border mode}  -width {20}

  frame .tpplacer.frame28  -borderwidth {2}  -background {#dcdcdc}  -height {321}  -highlightbackground {#dcdcdc}  -width {562}

  frame .tpplacer.frame28.frame  -background {#dcdcdc}  -highlightbackground {#dcdcdc}

  scrollbar .tpplacer.frame28.frame.scrollbar3  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpplacer.frame28.frame.listbox1 xview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -orient {horizontal}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}

  scrollbar .tpplacer.frame28.frame.scrollbar2  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpplacer.frame28.frame.listbox1 yview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}

  listbox .tpplacer.frame28.frame.listbox1  -exportselection {0}  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -xscrollcommand {.tpplacer.frame28.frame.scrollbar3 set}  -yscrollcommand {.tpplacer.frame28.frame.scrollbar2 set}
  # bindings
  bind .tpplacer.frame28.frame.listbox1 <Double-Button-1> {.tpplacer.frame28.frame30.listbox1 delete 0 end
set TPtemp  [%W get [%W curselection] ]
if {[winfo exists $TPtemp]} {
    eval ".tpplacer.frame28.frame30.listbox1 insert end [place slaves $TPtemp]"
    TP_SnapshotChildren $TPtemp TPoptionsPlace place
   } { .tpplacer.frame32.button0 invoke }}

  label .tpplacer.frame28.frame.label29  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Widgets}

  frame .tpplacer.frame28.frame.frame36  -borderwidth {2}  -relief {ridge}  -background {#dcdcdc}  -height {30}  -highlightbackground {#dcdcdc}  -width {249}

  button .tpplacer.frame28.frame.frame36.button37  -activebackground {gray75}  -background {#dcdcdc}  -command {set TPtemp [.tpplacer.frame28.frame.listbox1 curselection]
if {$TPtemp != {}} {
    set TPtemp [.tpplacer.frame28.frame.listbox1 get $TPtemp]
    if {[winfo exists $TPtemp]} {
        if {$TPtemp != {.}} {
            if {[lsearch [place slaves [winfo parent $TPtemp]] $TPtemp] == -1} {
	 if {[catch {place $TPtemp -x 0 -y 0} TPresult]} {
	     tk_messageBox -icon error -message $TPresult -parent . -title {TKproE error} -type ok
	    }
	.tpplacer.frame32.button0 invoke
              }
          }
      } { .tpplacer.frame32.button0 invoke }
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Place}  -width {5}

  frame .tpplacer.frame28.frame30  -background {#dcdcdc}  -highlightbackground {#dcdcdc}

  scrollbar .tpplacer.frame28.frame30.scrollbar3  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpplacer.frame28.frame30.listbox1 xview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -orient {horizontal}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}

  scrollbar .tpplacer.frame28.frame30.scrollbar2  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpplacer.frame28.frame30.listbox1 yview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}

  listbox .tpplacer.frame28.frame30.listbox1  -exportselection {0}  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -xscrollcommand {.tpplacer.frame28.frame30.scrollbar3 set}  -yscrollcommand {.tpplacer.frame28.frame30.scrollbar2 set}
  # bindings
  bind .tpplacer.frame28.frame30.listbox1 <<ListboxSelect>> {set TPplaceChild [%W get [%W curselection]]
if {[winfo exists $TPplaceChild]} {
    foreach {TPidx TPvalue} [place info $TPplaceChild] {
	  set TPplace($TPidx) $TPvalue
               }
    set TPplace(-bordermode) [lindex [place configure $TPplaceChild -bordermode] 4]
   } { .tpplacer.frame32.button0 invoke }}

  label .tpplacer.frame28.frame30.label29  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Children}

  frame .tpplacer.frame28.frame30.frame36  -borderwidth {2}  -relief {ridge}  -background {#dcdcdc}  -height {30}  -highlightbackground {#dcdcdc}  -width {249}

  button .tpplacer.frame28.frame30.frame36.button38  -activebackground {gray75}  -background {#dcdcdc}  -command {set TPtemp [.tpplacer.frame28.frame30.listbox1 curselection]
if {$TPtemp != {}} {
    set TPtemp [.tpplacer.frame28.frame30.listbox1 get $TPtemp]
    if {[winfo exists $TPtemp]} {
        place forget $TPtemp
      }
   .tpplacer.frame32.button0 invoke
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Forget}  -width {5}

  frame .tpplacer.frame32  -relief {ridge}  -background {#dcdcdc}  -height {32}  -highlightbackground {#dcdcdc}  -width {562}

  button .tpplacer.frame32.button33  -activebackground {gray75}  -background {#dcdcdc}  -command {DestroyWindow.tpplacer}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Done}

  button .tpplacer.frame32.button34  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_SnapshotRestoreChildren TPoptionsPlace place
.tpplacer.frame32.button0 invoke}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Undo}

  button .tpplacer.frame32.button35  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_SnapshotRestoreChildren TPoptionsPlace place
DestroyWindow.tpplacer}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Cancel}

  button .tpplacer.frame32.button0  -activebackground {gray75}  -background {#dcdcdc}  -command {set TPplaceChild {}
.tpplacer.frame28.frame.listbox1 delete 0 end
set TPplace(-width) {}
set TPplace(-height) {}
set TPplace(-relwidth) {}
set TPplace(-relheight) {}
set TPplace(-x) 0
set TPplace(-y) 0
set TPplace(-relx) 0
set TPplace(-rely) 0
set TPidx -1
set TPcursel -1
foreach TPtemp [TP_TreeSearch .] {
	.tpplacer.frame28.frame.listbox1 insert end $TPtemp
	incr TPidx
	if {$TPtemp == $TPplaceParent} {
	    set TPcursel $TPidx
	  }
          }
if {$TPcursel > -1} {
   .tpplacer.frame28.frame.listbox1 selection set $TPcursel $TPcursel
   .tpplacer.frame28.frame30.listbox1 delete 0 end
   eval ".tpplacer.frame28.frame30.listbox1 insert end [place slaves $TPplaceParent]"
   .tpplacer.frame28.frame.listbox1 yview $TPcursel
   TP_SnapshotChildren $TPplaceParent TPoptionsPlace place
  } {
      set TPplaceChild {}
      set TPplaceParent {}
    }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {ReScan}

  frame .tpplacer.frame8  -borderwidth {2}  -relief {raised}  -background {#dcdcdc}  -height {72}  -highlightbackground {#dcdcdc}  -width {183}

  label .tpplacer.frame8.label20  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {0}  -font {Helvetica 10 bold}  -highlightbackground {#dcdcdc}  -text {Geometry:}  -width {10}

  frame .tpplacer.frame8.frame21  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {174}

  label .tpplacer.frame8.frame21.label22  -activebackground {#dcdcdc}  -anchor {e}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Height:}  -width {6}

  spinbox .tpplacer.frame8.frame21.spinbox1

  .tpplacer.frame8.frame21.spinbox1 config  -background {linen}  -buttonbackground {#dcdcdc}  -command {if {[string length $TPplaceChild] > 0} {
   if {[winfo exists $TPplaceChild]} { place configure $TPplaceChild -height $TPplace(-height) }
  }}  -font {Helvetica 10}  -repeatinterval {50}  -textvariable {TPplace(-height)}  -to {40.0}  -width {4}
  # bindings
  bind .tpplacer.frame8.frame21.spinbox1 <FocusOut> {catch [%W cget -command]}
  bind .tpplacer.frame8.frame21.spinbox1 <Key-KP_Enter> {catch [%W cget -command]}
  bind .tpplacer.frame8.frame21.spinbox1 <Key-Return> {catch [%W cget -command]}

  spinbox .tpplacer.frame8.frame21.spinbox25

  .tpplacer.frame8.frame21.spinbox25 config  -background {linen}  -buttonbackground {#dcdcdc}  -command {if {[string length $TPplaceChild] > 0} {
   if {[winfo exists $TPplaceChild]} { place configure $TPplaceChild -relheight $TPplace(-relheight) }
  }}  -font {Helvetica 10}  -increment {0.01}  -repeatinterval {50}  -textvariable {TPplace(-relheight)}  -to {1.0}  -width {4}
  # bindings
  bind .tpplacer.frame8.frame21.spinbox25 <FocusOut> {catch [%W cget -command]}
  bind .tpplacer.frame8.frame21.spinbox25 <Key-KP_Enter> {catch [%W cget -command]}
  bind .tpplacer.frame8.frame21.spinbox25 <Key-Return> {catch [%W cget -command]}

  label .tpplacer.frame8.frame21.label4  -activebackground {#dcdcdc}  -anchor {e}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Relative height:}  -width {13}

  frame .tpplacer.frame8.frame26  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {179}

  label .tpplacer.frame8.frame26.label22  -activebackground {#dcdcdc}  -anchor {e}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Width:}  -width {6}

  spinbox .tpplacer.frame8.frame26.spinbox1

  .tpplacer.frame8.frame26.spinbox1 config  -background {linen}  -buttonbackground {#dcdcdc}  -command {if {[string length $TPplaceChild] > 0} {
   if {[winfo exists $TPplaceChild]} { place configure $TPplaceChild -width $TPplace(-width) }
  }}  -font {Helvetica 10}  -repeatinterval {50}  -textvariable {TPplace(-width)}  -to {10000.0}  -width {4}
  # bindings
  bind .tpplacer.frame8.frame26.spinbox1 <FocusOut> {catch [%W cget -command]}
  bind .tpplacer.frame8.frame26.spinbox1 <Key-KP_Enter> {catch [%W cget -command]}
  bind .tpplacer.frame8.frame26.spinbox1 <Key-Return> {catch [%W cget -command]}

  spinbox .tpplacer.frame8.frame26.spinbox25

  .tpplacer.frame8.frame26.spinbox25 config  -background {linen}  -buttonbackground {#dcdcdc}  -command {if {[string length $TPplaceChild] > 0} {
   if {[winfo exists $TPplaceChild]} { place configure $TPplaceChild -relwidth $TPplace(-relwidth) }
  }}  -font {Helvetica 10}  -increment {0.01}  -repeatinterval {50}  -textvariable {TPplace(-relwidth)}  -to {1.0}  -width {4}
  # bindings
  bind .tpplacer.frame8.frame26.spinbox25 <FocusOut> {catch [%W cget -command]}
  bind .tpplacer.frame8.frame26.spinbox25 <Key-KP_Enter> {catch [%W cget -command]}
  bind .tpplacer.frame8.frame26.spinbox25 <Key-Return> {catch [%W cget -command]}

  label .tpplacer.frame8.frame26.label6  -activebackground {#dcdcdc}  -anchor {e}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Relative width:}  -width {13}

  frame .tpplacer.frame0  -borderwidth {2}  -relief {raised}  -background {#dcdcdc}  -height {72}  -highlightbackground {#dcdcdc}  -width {183}

  label .tpplacer.frame0.label20  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {0}  -font {Helvetica 10 bold}  -highlightbackground {#dcdcdc}  -text {Position:}  -width {10}

  frame .tpplacer.frame0.frame21  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {174}

  label .tpplacer.frame0.frame21.label22  -activebackground {#dcdcdc}  -anchor {e}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {X:}  -width {6}

  spinbox .tpplacer.frame0.frame21.spinbox1

  .tpplacer.frame0.frame21.spinbox1 config  -background {linen}  -buttonbackground {#dcdcdc}  -command {if {[string length $TPplaceChild] > 0} {
   if {[winfo exists $TPplaceChild]} { place configure $TPplaceChild -x $TPplace(-x) }
  }}  -font {Helvetica 10}  -repeatinterval {50}  -textvariable {TPplace(-x)}  -to {10000.0}  -width {4}
  # bindings
  bind .tpplacer.frame0.frame21.spinbox1 <FocusOut> {catch [%W cget -command]}
  bind .tpplacer.frame0.frame21.spinbox1 <Key-KP_Enter> {catch [%W cget -command]}
  bind .tpplacer.frame0.frame21.spinbox1 <Key-Return> {catch [%W cget -command]}

  spinbox .tpplacer.frame0.frame21.spinbox25

  .tpplacer.frame0.frame21.spinbox25 config  -background {linen}  -buttonbackground {#dcdcdc}  -command {if {[string length $TPplaceChild] > 0} {
   if {[winfo exists $TPplaceChild]} { place configure $TPplaceChild -relx $TPplace(-relx) }
  }}  -font {Helvetica 10}  -increment {0.01}  -repeatinterval {50}  -textvariable {TPplace(-relx)}  -to {1.0}  -width {4}
  # bindings
  bind .tpplacer.frame0.frame21.spinbox25 <FocusOut> {catch [%W cget -command]}
  bind .tpplacer.frame0.frame21.spinbox25 <Key-KP_Enter> {catch [%W cget -command]}
  bind .tpplacer.frame0.frame21.spinbox25 <Key-Return> {catch [%W cget -command]}

  label .tpplacer.frame0.frame21.label4  -activebackground {#dcdcdc}  -anchor {e}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Relative X:}  -width {13}

  frame .tpplacer.frame0.frame26  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {179}

  label .tpplacer.frame0.frame26.label22  -activebackground {#dcdcdc}  -anchor {e}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Y:}  -width {6}

  spinbox .tpplacer.frame0.frame26.spinbox1

  .tpplacer.frame0.frame26.spinbox1 config  -background {linen}  -buttonbackground {#dcdcdc}  -command {if {[string length $TPplaceChild] > 0} {
   if {[winfo exists $TPplaceChild]} { place configure $TPplaceChild -y $TPplace(-y) }
  }}  -font {Helvetica 10}  -repeatinterval {50}  -textvariable {TPplace(-y)}  -to {10000.0}  -width {4}
  # bindings
  bind .tpplacer.frame0.frame26.spinbox1 <FocusOut> {catch [%W cget -command]}
  bind .tpplacer.frame0.frame26.spinbox1 <Key-KP_Enter> {catch [%W cget -command]}
  bind .tpplacer.frame0.frame26.spinbox1 <Key-Return> {catch [%W cget -command]}

  spinbox .tpplacer.frame0.frame26.spinbox25

  .tpplacer.frame0.frame26.spinbox25 config  -background {linen}  -buttonbackground {#dcdcdc}  -command {if {[string length $TPplaceChild] > 0} {
   if {[winfo exists $TPplaceChild]} { place configure $TPplaceChild -rely $TPplace(-rely) }
  }}  -font {Helvetica 10}  -increment {0.01}  -repeatinterval {50}  -textvariable {TPplace(-rely)}  -to {1.0}  -width {4}
  # bindings
  bind .tpplacer.frame0.frame26.spinbox25 <FocusOut> {catch [%W cget -command]}
  bind .tpplacer.frame0.frame26.spinbox25 <Key-KP_Enter> {catch [%W cget -command]}
  bind .tpplacer.frame0.frame26.spinbox25 <Key-Return> {catch [%W cget -command]}

  label .tpplacer.frame0.frame26.label6  -activebackground {#dcdcdc}  -anchor {e}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Relative Y:}  -width {13}

  # pack master .tpplacer.frame19
  pack configure .tpplacer.frame19.frame12  -expand 1  -fill x  -side left
  pack configure .tpplacer.frame19.frame13  -expand 1  -fill both  -side left

  # pack master .tpplacer.frame19.frame12
  pack configure .tpplacer.frame19.frame12.label13
  pack configure .tpplacer.frame19.frame12.frame14
  pack configure .tpplacer.frame19.frame12.frame17
  pack configure .tpplacer.frame19.frame12.frame18

  # pack master .tpplacer.frame19.frame12.frame14
  pack configure .tpplacer.frame19.frame12.frame14.radiobutton7  -side left
  pack configure .tpplacer.frame19.frame12.frame14.radiobutton15  -side left
  pack configure .tpplacer.frame19.frame12.frame14.radiobutton16  -side left

  # pack master .tpplacer.frame19.frame12.frame17
  pack configure .tpplacer.frame19.frame12.frame17.radiobutton7  -side left
  pack configure .tpplacer.frame19.frame12.frame17.radiobutton15  -side left
  pack configure .tpplacer.frame19.frame12.frame17.radiobutton16  -side left

  # pack master .tpplacer.frame19.frame12.frame18
  pack configure .tpplacer.frame19.frame12.frame18.radiobutton7  -side left
  pack configure .tpplacer.frame19.frame12.frame18.radiobutton15  -side left
  pack configure .tpplacer.frame19.frame12.frame18.radiobutton16  -side left

  # pack master .tpplacer.frame19.frame13
  pack configure .tpplacer.frame19.frame13.label18
  pack configure .tpplacer.frame19.frame13.radiobutton7
  pack configure .tpplacer.frame19.frame13.radiobutton15
  pack configure .tpplacer.frame19.frame13.radiobutton16

  # pack master .tpplacer.frame28
  pack configure .tpplacer.frame28.frame  -expand 1  -fill both  -side left
  pack configure .tpplacer.frame28.frame30  -expand 1  -fill both  -side left

  # pack master .tpplacer.frame28.frame
  pack configure .tpplacer.frame28.frame.label29
  pack configure .tpplacer.frame28.frame.frame36  -fill x  -side bottom
  pack configure .tpplacer.frame28.frame.scrollbar2  -fill y  -side left
  pack configure .tpplacer.frame28.frame.listbox1  -expand 1  -fill both
  pack configure .tpplacer.frame28.frame.scrollbar3  -fill x  -side bottom

  # pack master .tpplacer.frame28.frame.frame36
  pack configure .tpplacer.frame28.frame.frame36.button37  -side left

  # pack master .tpplacer.frame28.frame30
  pack configure .tpplacer.frame28.frame30.label29
  pack configure .tpplacer.frame28.frame30.frame36  -fill x  -side bottom
  pack configure .tpplacer.frame28.frame30.scrollbar2  -fill y  -side left
  pack configure .tpplacer.frame28.frame30.listbox1  -expand 1  -fill both
  pack configure .tpplacer.frame28.frame30.scrollbar3  -fill x  -side bottom

  # pack master .tpplacer.frame28.frame30.frame36
  pack configure .tpplacer.frame28.frame30.frame36.button38  -side right

  # pack master .tpplacer.frame32
  pack configure .tpplacer.frame32.button33  -side left
  pack configure .tpplacer.frame32.button35  -side right
  pack configure .tpplacer.frame32.button34  -side right
  pack configure .tpplacer.frame32.button0  -side left

  # pack master .tpplacer.frame8
  pack configure .tpplacer.frame8.label20  -side left
  pack configure .tpplacer.frame8.frame26  -anchor w
  pack configure .tpplacer.frame8.frame21  -anchor w

  # pack master .tpplacer.frame8.frame21
  pack configure .tpplacer.frame8.frame21.label22  -side left
  pack configure .tpplacer.frame8.frame21.spinbox1  -side left
  pack configure .tpplacer.frame8.frame21.label4  -side left
  pack configure .tpplacer.frame8.frame21.spinbox25  -side left

  # pack master .tpplacer.frame8.frame26
  pack configure .tpplacer.frame8.frame26.label22  -side left
  pack configure .tpplacer.frame8.frame26.spinbox1  -side left
  pack configure .tpplacer.frame8.frame26.label6  -side left
  pack configure .tpplacer.frame8.frame26.spinbox25  -side left

  # pack master .tpplacer.frame0
  pack configure .tpplacer.frame0.label20  -side left
  pack configure .tpplacer.frame0.frame21  -anchor w  -expand 1
  pack configure .tpplacer.frame0.frame26  -anchor w  -expand 1

  # pack master .tpplacer.frame0.frame21
  pack configure .tpplacer.frame0.frame21.label22  -side left
  pack configure .tpplacer.frame0.frame21.spinbox1  -side left
  pack configure .tpplacer.frame0.frame21.label4  -side left
  pack configure .tpplacer.frame0.frame21.spinbox25  -side left

  # pack master .tpplacer.frame0.frame26
  pack configure .tpplacer.frame0.frame26.label22  -side left
  pack configure .tpplacer.frame0.frame26.spinbox1  -side left
  pack configure .tpplacer.frame0.frame26.label6  -side left
  pack configure .tpplacer.frame0.frame26.spinbox25  -side left

  # pack master .tpplacer
  pack configure .tpplacer.frame8  -fill x
  pack configure .tpplacer.frame0  -fill x
  pack configure .tpplacer.frame19  -fill x
  pack configure .tpplacer.frame28  -expand 1  -fill both
  pack configure .tpplacer.frame32  -fill x  -side bottom

  .tpplacer.frame28.frame.listbox1 insert end {.}

EndSrc.tpplacer
}

proc DestroyWindow.tpplacer {} {
     catch "destroy .tpplacer"
     update
}

proc EndSrc.tpplacer {} {
# Rescan widget placement using the procedure tied to the ReScan button
wm iconphoto .tpplacer tplogo16
.tpplacer.frame32.button0 invoke
}


proc ShowWindow.tpprocs { args} {

  if {[winfo exists .tpprocs]} {
      raise .tpprocs
      EndSrc.tpprocs
      return
     }

  toplevel .tpprocs   -relief {raised}  -background {#dcdcdc}  -highlightbackground {#dcdcdc}

  # Window manager configurations
  wm positionfrom .tpprocs program
  wm sizefrom .tpprocs program
  wm maxsize .tpprocs 2560 1024
  wm minsize .tpprocs 422 466
  wm protocol .tpprocs WM_DELETE_WINDOW {.tpprocs.frame.proclist delete 0 end
.tpprocs.frame2.proctext delete 1.0 end
set TPshowProcs 0
DestroyWindow.tpprocs}
  wm title .tpprocs {TKproE - procedures}


  frame .tpprocs.frame  -relief {raised}  -background {#dcdcdc}  -height {30}  -highlightbackground {#dcdcdc}  -width {30}

  listbox .tpprocs.frame.proclist  -background {white}  -exportselection {0}  -font {Helvetica 10}  -height {5}  -highlightbackground {#ffffff}  -highlightthickness {0}  -selectbackground {#547098}  -selectborderwidth {2}  -selectforeground {#ffffff}  -width {10}  -xscrollcommand {.tpprocs.frame.scrollbar5 set}  -yscrollcommand {.tpprocs.frame.scrollbar4 set}
  # bindings
  bind .tpprocs.frame.proclist <<ListboxSelect>> {set TPtemp [%W curselection]
if {[llength $TPtemp] == 1} {
    if {$TPcurNamespace == {::}} {
        set TPprefix {}
      } { set TPprefix $TPcurNamespace }
    set TPselProc [%W get $TPtemp]
    TP_ProcEditFill ${TPprefix}::$TPselProc
    set TPeditProcName $TPselProc
   }}

  scrollbar .tpprocs.frame.scrollbar4  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpprocs.frame.proclist yview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}

  scrollbar .tpprocs.frame.scrollbar5  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpprocs.frame.proclist xview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -orient {horizontal}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}

  frame .tpprocs.frame6  -borderwidth {2}  -relief {ridge}  -background {#dcdcdc}  -height {26}  -highlightbackground {#dcdcdc}  -width {433}

  label .tpprocs.frame6.label7  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Name:}  -width {10}

  entry .tpprocs.frame6.entry8  -background {OldLace}  -font {Helvetica 10}  -highlightbackground {#ffffff}  -insertbackground {black}  -selectbackground {black}  -selectforeground {#ffffff}  -textvariable {TPeditProcName}

  frame .tpprocs.frame9  -borderwidth {2}  -relief {ridge}  -background {#dcdcdc}  -height {26}  -highlightbackground {#dcdcdc}  -width {433}

  label .tpprocs.frame9.label7  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Parameters:}  -width {10}

  entry .tpprocs.frame9.entry8  -background {OldLace}  -font {Helvetica 10}  -highlightbackground {#ffffff}  -insertbackground {black}  -selectbackground {black}  -selectforeground {#ffffff}  -textvariable {TPeditProcParameters}

  frame .tpprocs.frame2  -background {#dcdcdc}  -height {233}  -highlightbackground {#dcdcdc}  -width {433}

  scrollbar .tpprocs.frame2.scrollbar4  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpprocs.frame2.proctext yview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}

  scrollbar .tpprocs.frame2.scrollbar5  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpprocs.frame2.proctext xview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -orient {horizontal}  -troughcolor {#dcdcdc}  -width {12}

  text .tpprocs.frame2.proctext  -background {white}  -font {Helvetica 10}  -height {15}  -highlightbackground {#ffffff}  -insertbackground {black}  -selectbackground {#547098}  -selectforeground {#ffffff}  -width {50}  -wrap {none}  -xscrollcommand {.tpprocs.frame2.scrollbar5 set}  -yscrollcommand {.tpprocs.frame2.scrollbar4 set}

  frame .tpprocs.frame14  -borderwidth {2}  -relief {ridge}  -background {#dcdcdc}  -height {32}  -highlightbackground {#dcdcdc}  -width {626}

  label .tpprocs.frame14.label15  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Find:}  -width {10}

  entry .tpprocs.frame14.entry16  -background {OldLace}  -font {Helvetica 10}  -highlightbackground {#ffffff}  -insertbackground {black}  -selectbackground {black}  -selectforeground {#ffffff}  -textvariable {TPeditProcFindString}
  # bindings
  bind .tpprocs.frame14.entry16 <Key-KP_Enter> {.tpprocs.frame14.button17 invoke}
  bind .tpprocs.frame14.entry16 <Key-Return> {.tpprocs.frame14.button17 invoke}

  button .tpprocs.frame14.button17  -activebackground {gray75}  -background {#dcdcdc}  -command {focus .tpprocs.frame2.proctext
set TPtemp [.tpprocs.frame2.proctext search -forwards $TPeditProcFindString "insert + 1 chars"]
if {$TPtemp != {}} {
    .tpprocs.frame2.proctext mark set insert $TPtemp
    .tpprocs.frame2.proctext see $TPtemp
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {->>}

  button .tpprocs.frame14.button18  -activebackground {gray75}  -background {#dcdcdc}  -command {focus .tpprocs.frame2.proctext
set TPtemp [.tpprocs.frame2.proctext search -backwards $TPeditProcFindString insert]
if {$TPtemp != {}} {
    .tpprocs.frame2.proctext mark set insert $TPtemp
    .tpprocs.frame2.proctext see $TPtemp
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {<<-}

  frame .tpprocs.frame19  -borderwidth {2}  -relief {ridge}  -background {#dcdcdc}  -height {32}  -highlightbackground {#dcdcdc}  -width {461}

  button .tpprocs.frame19.button20  -activebackground {gray75}  -background {#dcdcdc}  -command {set TPtemp [.tpprocs.frame2.proctext get 1.0 end-1chars]
if {$TPcurNamespace == {::}} {
    set TPprefix {}
   } { set TPprefix $TPcurNamespace }
if {[catch "proc ${TPprefix}::$TPeditProcName \{$TPeditProcParameters\} \{$TPtemp\}" TPtemp]} {
    set TPmessage $TPtemp
    set TPmsgButtons OK
    ShowWindow.tpmsgbox
  } {
      TP_ProcListFill
    }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Insert}

  button .tpprocs.frame19.button22  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_RenameProcAsk}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Rename}

  button .tpprocs.frame19.button23  -activebackground {gray75}  -background {#dcdcdc}  -command {set TPtemp [.tpprocs.frame.proclist curselection]
if {[string length $TPtemp] > 0} {
    set TPtemp [.tpprocs.frame.proclist get $TPtemp]
    set TPmessage "Do you really want to delete\n${TPcurNamespace}::$TPtemp\n?"
    set TPmsgCmd(Yes) "rename $TPcurNamespace$TPtemp {};TP_ProcListFill; set TPmsgCmd(Yes) {}; set TPmsgCmd(No) {}; set TPmsgButtons {}"
    set TPmsgCmd(No) "set TPmsgCmd(Yes) {}; set TPmsgCmd(No) {}; set TPmsgButtons {}"
    set TPmsgButtons {Yes No}
    ShowWindow.tpmsgbox
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Remove}

  button .tpprocs.frame19.button25  -activebackground {gray75}  -background {#dcdcdc}  -command {set TPeditProcName {}
set TPeditProcParameters {}
.tpprocs.frame2.proctext delete 1.0 end}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Clear}

  button .tpprocs.frame19.button1  -activebackground {gray75}  -background {#dcdcdc}  -command {if {$TPeditor != {} && [.tpprocs.frame2.proctext cget -state] == {normal} } {
    # Try opening the procedure with the user-specified editor.
    set TPtemp [open TPtemp_$tcl_platform(user) w]
    puts -nonewline $TPtemp [.tpprocs.frame2.proctext get 1.0 {end - 1 chars}]
    close $TPtemp
    catch "exec [regsub -all {FILENAME} $TPeditor TPtemp_$tcl_platform(user)]" TPtemp
    .tpprocs.frame2.proctext delete 1.0 end
    set TPtemp [open TPtemp_$tcl_platform(user) r]
    .tpprocs.frame2.proctext insert end [read $TPtemp]
    close $TPtemp
   }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Edit}

  frame .tpprocs.frame27  -borderwidth {2}  -background {#dcdcdc}  -height {32}  -highlightbackground {#dcdcdc}  -width {120}

  button .tpprocs.frame27.button28  -activebackground {gray75}  -background {#dcdcdc}  -command {.tpprocs.frame.proclist delete 0 end
set TPeditProcName {}
set TPeditProcParameters {}
.tpprocs.frame2.proctext delete 1.0 end
set TPshowProcs 0
DestroyWindow.tpprocs}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {OK}

  button .tpprocs.frame27.button29  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_ProcListFill}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Rescan}

  frame .tpprocs.frame0  -borderwidth {2}  -relief {raised}  -background {#dcdcdc}  -height {30}  -highlightbackground {#dcdcdc}  -width {30}

  frame .tpprocs.frame0.frame1  -borderwidth {2}  -relief {groove}  -background {#dcdcdc}  -height {38}  -highlightbackground {#eeeeee}  -width {111}

  menubutton .tpprocs.frame0.frame1.menubutton1  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -font {Helvetica 12}  -foreground {red}  -highlightbackground {#dcdcdc}  -image {tparrowcombo}  -menu {.tpprocs.frame0.frame1.menubutton1.m}  -padx {2}  -pady {1}  -relief {raised}  -text {::}  -textvariable {TPcurNamespace}

  menu .tpprocs.frame0.frame1.menubutton1.m  -activebackground {#dcdcdc}  -background {#dcdcdc}  -font {Helvetica 10}  -tearoff {0}
  .tpprocs.frame0.frame1.menubutton1.m add command  -command {set TPcurNamespace ::; TP_ProcListFill}  -label {::}
  .tpprocs.frame0.frame1.menubutton1.m add command  -command {set TPcurNamespace ::auto_mkindex_parser; TP_ProcListFill}  -label {::auto_mkindex_parser}
  .tpprocs.frame0.frame1.menubutton1.m add command  -command {set TPcurNamespace ::freewrap; TP_ProcListFill}  -label {::freewrap}
  .tpprocs.frame0.frame1.menubutton1.m add command  -command {set TPcurNamespace ::msgcat; TP_ProcListFill}  -label {::msgcat}
  .tpprocs.frame0.frame1.menubutton1.m add command  -command {set TPcurNamespace ::pkg; TP_ProcListFill}  -label {::pkg}
  .tpprocs.frame0.frame1.menubutton1.m add command  -command {set TPcurNamespace ::tcl; TP_ProcListFill}  -label {::tcl}
  .tpprocs.frame0.frame1.menubutton1.m add command  -command {set TPcurNamespace ::tcl::Pkg; TP_ProcListFill}  -label {::tcl::Pkg}
  .tpprocs.frame0.frame1.menubutton1.m add command  -command {set TPcurNamespace ::tcl::chan; TP_ProcListFill}  -label {::tcl::chan}
  .tpprocs.frame0.frame1.menubutton1.m add command  -command {set TPcurNamespace ::tcl::clock; TP_ProcListFill}  -label {::tcl::clock}
  .tpprocs.frame0.frame1.menubutton1.m add command  -command {set TPcurNamespace ::tcl::dict; TP_ProcListFill}  -label {::tcl::dict}
  .tpprocs.frame0.frame1.menubutton1.m add command  -command {set TPcurNamespace ::tcl::info; TP_ProcListFill}  -label {::tcl::info}
  .tpprocs.frame0.frame1.menubutton1.m add command  -command {set TPcurNamespace ::tcl::mathfunc; TP_ProcListFill}  -label {::tcl::mathfunc}
  .tpprocs.frame0.frame1.menubutton1.m add command  -command {set TPcurNamespace ::tcl::mathop; TP_ProcListFill}  -label {::tcl::mathop}
  .tpprocs.frame0.frame1.menubutton1.m add command  -command {set TPcurNamespace ::tcl::string; TP_ProcListFill}  -label {::tcl::string}
  .tpprocs.frame0.frame1.menubutton1.m add command  -command {set TPcurNamespace ::tcl::tm; TP_ProcListFill}  -label {::tcl::tm}
  .tpprocs.frame0.frame1.menubutton1.m add command  -command {set TPcurNamespace ::tcl::unsupported; TP_ProcListFill}  -label {::tcl::unsupported}
  .tpprocs.frame0.frame1.menubutton1.m add command  -command {set TPcurNamespace ::tk; TP_ProcListFill}  -label {::tk}
  .tpprocs.frame0.frame1.menubutton1.m add command  -command {set TPcurNamespace ::tk::dialog; TP_ProcListFill}  -label {::tk::dialog}
  .tpprocs.frame0.frame1.menubutton1.m add command  -command {set TPcurNamespace ::tk::dialog::error; TP_ProcListFill}  -label {::tk::dialog::error}
  .tpprocs.frame0.frame1.menubutton1.m add command  -command {set TPcurNamespace ::tk::msgcat; TP_ProcListFill}  -label {::tk::msgcat}
  .tpprocs.frame0.frame1.menubutton1.m add command  -command {set TPcurNamespace ::tk::panedwindow; TP_ProcListFill}  -label {::tk::panedwindow}
  .tpprocs.frame0.frame1.menubutton1.m add command  -command {set TPcurNamespace ::tk::spinbox; TP_ProcListFill}  -label {::tk::spinbox}
  .tpprocs.frame0.frame1.menubutton1.m add command  -command {set TPcurNamespace ::ttk; TP_ProcListFill}  -label {::ttk}
  .tpprocs.frame0.frame1.menubutton1.m add command  -command {set TPcurNamespace ::ttk::button; TP_ProcListFill}  -label {::ttk::button}
  .tpprocs.frame0.frame1.menubutton1.m add command  -command {set TPcurNamespace ::ttk::combobox; TP_ProcListFill}  -label {::ttk::combobox}
  .tpprocs.frame0.frame1.menubutton1.m add command  -command {set TPcurNamespace ::ttk::entry; TP_ProcListFill}  -label {::ttk::entry}
  .tpprocs.frame0.frame1.menubutton1.m add command  -command {set TPcurNamespace ::ttk::menubutton; TP_ProcListFill}  -label {::ttk::menubutton}
  .tpprocs.frame0.frame1.menubutton1.m add command  -command {set TPcurNamespace ::ttk::notebook; TP_ProcListFill}  -label {::ttk::notebook}
  .tpprocs.frame0.frame1.menubutton1.m add command  -command {set TPcurNamespace ::ttk::panedwindow; TP_ProcListFill}  -label {::ttk::panedwindow}
  .tpprocs.frame0.frame1.menubutton1.m add command  -command {set TPcurNamespace ::ttk::progressbar; TP_ProcListFill}  -label {::ttk::progressbar}
  .tpprocs.frame0.frame1.menubutton1.m add command  -command {set TPcurNamespace ::ttk::scale; TP_ProcListFill}  -label {::ttk::scale}
  .tpprocs.frame0.frame1.menubutton1.m add command  -command {set TPcurNamespace ::ttk::scrollbar; TP_ProcListFill}  -label {::ttk::scrollbar}
  .tpprocs.frame0.frame1.menubutton1.m add command  -command {set TPcurNamespace ::ttk::sizegrip; TP_ProcListFill}  -label {::ttk::sizegrip}
  .tpprocs.frame0.frame1.menubutton1.m add command  -command {set TPcurNamespace ::ttk::theme; TP_ProcListFill}  -label {::ttk::theme}
  .tpprocs.frame0.frame1.menubutton1.m add command  -command {set TPcurNamespace ::ttk::theme::alt; TP_ProcListFill}  -label {::ttk::theme::alt}
  .tpprocs.frame0.frame1.menubutton1.m add command  -command {set TPcurNamespace ::ttk::theme::clam; TP_ProcListFill}  -label {::ttk::theme::clam}
  .tpprocs.frame0.frame1.menubutton1.m add command  -command {set TPcurNamespace ::ttk::theme::classic; TP_ProcListFill}  -label {::ttk::theme::classic}
  .tpprocs.frame0.frame1.menubutton1.m add command  -command {set TPcurNamespace ::ttk::theme::default; TP_ProcListFill}  -label {::ttk::theme::default}
  .tpprocs.frame0.frame1.menubutton1.m add command  -command {set TPcurNamespace ::ttk::treeview; TP_ProcListFill}  -label {::ttk::treeview}
  .tpprocs.frame0.frame1.menubutton1.m add command  -command {set TPcurNamespace ::zvfs; TP_ProcListFill}  -label {::zvfs}

  label .tpprocs.frame0.frame1.label2  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10 bold}  -highlightbackground {#dcdcdc}  -text {Show Namespace:}  -width {18}

  label .tpprocs.frame0.frame1.label3  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {0}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {::}  -textvariable {TPcurNamespace}

  frame .tpprocs.frame0.frame4  -borderwidth {2}  -relief {groove}  -background {#dcdcdc}  -height {46}  -highlightbackground {#eeeeee}  -width {98}

  button .tpprocs.frame0.frame4.button3  -activebackground {gray75}  -background {#dcdcdc}  -command {ShowWindow.tpexclusions}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -pady {0}  -text {Exclusion List}

  button .tpprocs.frame0.frame4.button5  -activebackground {gray75}  -background {#dcdcdc}  -command {ShowWindow.tpnewspace}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -pady {0}  -text {New Namespace}

  # pack master .tpprocs.frame
  pack configure .tpprocs.frame.scrollbar4  -fill y  -side left
  pack configure .tpprocs.frame.proclist  -expand 0  -fill both
  pack configure .tpprocs.frame.scrollbar5  -fill x  -side bottom

  # pack master .tpprocs.frame6
  pack configure .tpprocs.frame6.label7  -side left
  pack configure .tpprocs.frame6.entry8  -expand 1  -fill x  -side left

  # pack master .tpprocs.frame9
  pack configure .tpprocs.frame9.label7  -side left
  pack configure .tpprocs.frame9.entry8  -expand 1  -fill x  -side left

  # pack master .tpprocs.frame2
  pack configure .tpprocs.frame2.scrollbar4  -fill y  -side left
  pack configure .tpprocs.frame2.scrollbar5  -fill x  -side bottom
  pack configure .tpprocs.frame2.proctext  -expand 1  -fill both

  # pack master .tpprocs.frame14
  pack configure .tpprocs.frame14.label15  -side left
  pack configure .tpprocs.frame14.entry16  -expand 1  -fill x  -side left
  pack configure .tpprocs.frame14.button17  -side right
  pack configure .tpprocs.frame14.button18  -side right

  # pack master .tpprocs.frame19
  pack configure .tpprocs.frame19.button20  -expand 1  -fill x  -side left
  pack configure .tpprocs.frame19.button1  -expand 1  -fill x  -side left
  pack configure .tpprocs.frame19.button22  -expand 1  -fill x  -side left
  pack configure .tpprocs.frame19.button23  -expand 1  -fill x  -side left
  pack configure .tpprocs.frame19.button25  -expand 1  -fill x  -side left

  # pack master .tpprocs.frame27
  pack configure .tpprocs.frame27.button28  -padx 3  -side left
  pack configure .tpprocs.frame27.button29  -padx 2  -side right

  # pack master .tpprocs.frame0
  pack configure .tpprocs.frame0.frame1  -fill y  -side left
  pack configure .tpprocs.frame0.frame4  -fill y  -side right

  # pack master .tpprocs.frame0.frame1
  pack configure .tpprocs.frame0.frame1.label2  -fill x
  pack configure .tpprocs.frame0.frame1.menubutton1  -side right
  pack configure .tpprocs.frame0.frame1.label3  -fill x  -ipadx 3

  # pack master .tpprocs.frame0.frame4
  pack configure .tpprocs.frame0.frame4.button3  -fill x  -padx 3  -pady 1
  pack configure .tpprocs.frame0.frame4.button5  -fill x  -padx 3  -pady 1

  # pack master .tpprocs
  pack configure .tpprocs.frame0  -fill x
  pack configure .tpprocs.frame  -expand 0  -fill both
  pack configure .tpprocs.frame6  -fill x
  pack configure .tpprocs.frame9  -fill x
  pack configure .tpprocs.frame2  -expand 1  -fill both
  pack configure .tpprocs.frame14  -fill x
  pack configure .tpprocs.frame19  -fill x
  pack configure .tpprocs.frame27  -side bottom

  .tpprocs.frame.proclist insert end {Alias}
  .tpprocs.frame.proclist insert end {Cat}
  .tpprocs.frame.proclist insert end {Chmod}
  .tpprocs.frame.proclist insert end {Cp}
  .tpprocs.frame.proclist insert end {GetSelection}
  .tpprocs.frame.proclist insert end {Ls}
  .tpprocs.frame.proclist insert end {NoFunction}
  .tpprocs.frame.proclist insert end {Rm}
  .tpprocs.frame.proclist insert end {SN}
  .tpprocs.frame.proclist insert end {SymbolicName}
  .tpprocs.frame.proclist insert end {Unalias}
  .tpprocs.frame2.proctext insert end {}

    bind .tpprocs.frame0.frame1.menubutton1.m <MouseWheel> {
        %W yview scroll [expr {- (%D / 120) * 4}] units
    }


EndSrc.tpprocs
}

proc DestroyWindow.tpprocs {} {
     catch "destroy .tpprocs"
     update
}

proc EndSrc.tpprocs {} {
global TPprocEdit

wm iconphoto .tpprocs tplogo16
TP_MenuFromList .tpprocs.frame0.frame1.menubutton1.m [concat :: [TP_NamespaceList ::]]
TP_ProcListFill
if {[string length $TPprocEdit] > 0} {
    # Jump to the procedure specified by TPprocEdit
    TP_ProcEditFill $TPprocEdit
    set TPprocEdit {}
   }
}


proc ShowWindow.tpproperties { args} {

  catch "destroy .tpproperties"

  toplevel .tpproperties   -relief {raised}  -background {#dcdcdc}  -highlightbackground {#dcdcdc}

  # Window manager configurations
  wm positionfrom .tpproperties program
  wm sizefrom .tpproperties program
  wm maxsize .tpproperties 355 1024
  wm minsize .tpproperties 355 180
  wm protocol .tpproperties WM_DELETE_WINDOW {DestroyWindow.tpproperties}
  wm title .tpproperties {Widget properties}

  # bindings
  bind .tpproperties <ButtonRelease-1> {TP_ProcessClick %W %X %Y %x %y}
  bind .tpproperties <Shift-Button-3> {TP_PropsSelWidget %W}
  

  frame .tpproperties.frame0  -borderwidth {2}  -relief {ridge}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {364}

  label .tpproperties.frame0.label1  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {2}  -cursor {question_arrow}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Widget name: }
  # bindings
  bind .tpproperties.frame0.label1 <ButtonRelease-3> {set TPtemp [winfo containing %X %Y]
if {($TPtemp != {}) && ([string range $TPtemp 0 2] != {.tp})} {
    # Collapse all sections
    if {[string first {+} [.tpproperties.frame6.canvas2.frame5.hdrwidget cget -text]] < 0} { TP_PropsShowHide .tpproperties.frame6.canvas2.frame5.hdrwidget }
    if {[string first {+} [.tpproperties.frame6.canvas2.frame5.hdrgeometry cget -text]] < 0} { TP_PropsShowHide .tpproperties.frame6.canvas2.frame5.hdrgeometry }
    if {[string first {+} [.tpproperties.frame6.canvas2.frame5.hdrstandard cget -text]] < 0} { TP_PropsShowHide .tpproperties.frame6.canvas2.frame5.hdrstandard }
    if {[string first {+} [.tpproperties.frame6.canvas2.frame5.hdrspecific cget -text]] < 0} { TP_PropsShowHide .tpproperties.frame6.canvas2.frame5.hdrspecific }
    if {[string first {+} [.tpproperties.frame6.canvas2.frame5.hdrstates cget -text]] < 0} { TP_PropsShowHide .tpproperties.frame6.canvas2.frame5.hdrstates }

    # Configure newly selected widget
    TP_PropsSelWidget $TPtemp
   }}

  label .tpproperties.frame0.label2  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -foreground {blue}  -highlightbackground {#dcdcdc}  -text {}  -textvariable {TPcurWidget}

  button .tpproperties.frame0.button0  -activebackground {gray75}  -background {#dcdcdc}  -command {
    switch [TP_ClassGet $TPcurWidget] {
	   Toplevel	{
			  set TPcurToplevel $TPcurWidget
			  if {[winfo exists .tpwm]} {
			      EndSrc.tpwm
			     } { ShowWindow.tpwm }
			}
	   TPanedwindow	{
			  if {[winfo exists .tptpane]} {
			      EndSrc.tptpane
			     } { ShowWindow.tptpane } 
			}
	   Panedwindow	{
			  if {[winfo exists .tppane]} {
			      EndSrc.tppane
			     } { ShowWindow.tppane } 
			}
	 }
   }  -font {Helvetica 10}  -highlightbackground {#e6e7e6}  -padx {4}  -pady {0}  -text {More}

  frame .tpproperties.frame3  -borderwidth {2}  -relief {ridge}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {364}

  button .tpproperties.frame3.button4  -activebackground {gray75}  -background {#dcdcdc}  -command {set TPtemp [focus -lastfor .tpproperties]
if {[TP_ClassGet $TPtemp] == {Entry}} {
    event generate $TPtemp <Key-Return>
  }
DestroyWindow.tpproperties}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -padx {4}  -pady {0}  -text {Done}  -width {6}
#LISSI
button .tpproperties.frame3.buttonSCR -activebackground {#eeeeee} -background {grey85} -command {TP_SaveCaptureWindow $TPcurWidget} -font {Helvetica 10} -highlightbackground {#eeeeee} -highlightthickness {0} -pady {1} -text {Screenshot}
pack .tpproperties.frame3.buttonSCR -anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side left

  button .tpproperties.frame3.button8  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_SnapshotRestore $TPcurWidget
DestroyWindow.tpproperties}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -padx {4}  -pady {0}  -text {Cancel}  -width {6}

  frame .tpproperties.frame6  -borderwidth {2}  -relief {ridge}  -background {#dcdcdc}  -height {228}  -highlightbackground {#dcdcdc}  -width {488}

#LISSI
#  scrollbar .tpproperties.frame6.scrollbar1  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {2}  -command {.tpproperties.frame6.canvas2 yview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -relief {raised}  -troughcolor {#dcdcdc}  -width {15}
  ttk::scrollbar .tpproperties.frame6.scrollbar1 -command {.tpproperties.frame6.canvas2 yview}

  canvas .tpproperties.frame6.canvas2  -background {#dcdcdc}  -height {80}  -highlightbackground {#ffffff}  -highlightthickness {0}  -scrollregion {0c 0c 20c 40c}  -width {1}  -yscrollcommand {.tpproperties.frame6.scrollbar1 set}

  frame .tpproperties.frame6.canvas2.frame5  -background {#dcdcdc}  -height {84}  -highlightbackground {#dcdcdc}  -width {296}

  label .tpproperties.frame6.canvas2.frame5.hdrstates  -activebackground {#dcdcdc}  -background {grey70}  -borderwidth {1}  -font {Helvetica 12}  -highlightbackground {#dcdcdc}  -relief {raised}  -text {States (+)}  -width {39}
  # bindings
  bind .tpproperties.frame6.canvas2.frame5.hdrstates <ButtonRelease-1> {TP_PropsShowHide %W}

  label .tpproperties.frame6.canvas2.frame5.hdrspecific  -activebackground {#dcdcdc}  -background {grey70}  -borderwidth {1}  -font {Helvetica 12}  -highlightbackground {#dcdcdc}  -relief {raised}  -text {Specific Options (+)}  -width {39}
  # bindings
  bind .tpproperties.frame6.canvas2.frame5.hdrspecific <ButtonRelease-1> {TP_PropsShowHide %W}

  label .tpproperties.frame6.canvas2.frame5.hdrstandard  -activebackground {#dcdcdc}  -background {gray70}  -borderwidth {1}  -font {Helvetica 12}  -highlightbackground {#dcdcdc}  -relief {raised}  -text {Standard Options (+)}  -width {39}
  # bindings
  bind .tpproperties.frame6.canvas2.frame5.hdrstandard <ButtonRelease-1> {TP_PropsShowHide %W}

  label .tpproperties.frame6.canvas2.frame5.hdrgeometry  -activebackground {#dcdcdc}  -background {grey70}  -borderwidth {1}  -font {Helvetica 12}  -highlightbackground {#dcdcdc}  -relief {raised}  -text {Geometry (+)}  -width {39}
  # bindings
  bind .tpproperties.frame6.canvas2.frame5.hdrgeometry <ButtonRelease-1> {TP_PropsShowHide %W}

  label .tpproperties.frame6.canvas2.frame5.hdrwidget  -activebackground {#dcdcdc}  -background {grey70}  -borderwidth {1}  -font {Helvetica 12}  -highlightbackground {#dcdcdc}  -relief {raised}  -text {Widget (+)}  -width {39}
  # bindings
  bind .tpproperties.frame6.canvas2.frame5.hdrwidget <ButtonRelease-1> {TP_PropsShowHide %W}

  frame .tpproperties.frame6.canvas2.frame5.propswidget  -background {#dcdcdc}  -height {82}  -highlightbackground {#dcdcdc}  -width {242}

  frame .tpproperties.frame6.canvas2.frame5.propswidget.frame21  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {282}

  entry .tpproperties.frame6.canvas2.frame5.propswidget.frame21.entry23  -background {white}  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -state {readonly}  -textvariable {TPpropsWidget(name)}

  label .tpproperties.frame6.canvas2.frame5.propswidget.frame21.label22  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 12}  -highlightbackground {#dcdcdc}  -text {Name}  -width {16}

  frame .tpproperties.frame6.canvas2.frame5.propswidget.frame24  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {282}

  label .tpproperties.frame6.canvas2.frame5.propswidget.frame24.label22  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 12}  -highlightbackground {#dcdcdc}  -text {Class}  -width {16}

  entry .tpproperties.frame6.canvas2.frame5.propswidget.frame24.entry23  -background {#eeeeee}  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -state {readonly}  -textvariable {TPpropsWidget(class)}

  frame .tpproperties.frame6.canvas2.frame5.propswidget.frame25  -borderwidth {2}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {282}

  label .tpproperties.frame6.canvas2.frame5.propswidget.frame25.label22  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 12}  -highlightbackground {#dcdcdc}  -text {Parent}  -width {16}

  entry .tpproperties.frame6.canvas2.frame5.propswidget.frame25.entry23  -background {#eeeeee}  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -state {readonly}  -textvariable {TPpropsWidget(parent)}

  # pack master .tpproperties.frame0
  pack configure .tpproperties.frame0.label1  -side left
  pack configure .tpproperties.frame0.label2  -side left

  # pack master .tpproperties.frame3
  pack configure .tpproperties.frame3.button4  -side left
  pack configure .tpproperties.frame3.button8  -side right

  # pack master .tpproperties.frame6
  pack configure .tpproperties.frame6.scrollbar1  -fill y  -side right
  pack configure .tpproperties.frame6.canvas2  -expand 1  -fill both

  # pack master .tpproperties.frame6.canvas2.frame5
  pack configure .tpproperties.frame6.canvas2.frame5.hdrwidget -anchor w
  pack configure .tpproperties.frame6.canvas2.frame5.hdrgeometry -anchor w
  pack configure .tpproperties.frame6.canvas2.frame5.hdrstandard -anchor w
  pack configure .tpproperties.frame6.canvas2.frame5.hdrspecific -anchor w
  pack configure .tpproperties.frame6.canvas2.frame5.hdrstates -anchor w

  # pack master .tpproperties.frame6.canvas2.frame5.propswidget
  pack configure .tpproperties.frame6.canvas2.frame5.propswidget.frame21  -fill x
  pack configure .tpproperties.frame6.canvas2.frame5.propswidget.frame24  -fill x
  pack configure .tpproperties.frame6.canvas2.frame5.propswidget.frame25  -fill x

  # pack master .tpproperties.frame6.canvas2.frame5.propswidget.frame21
  pack configure .tpproperties.frame6.canvas2.frame5.propswidget.frame21.label22  -anchor w  -side left
  pack configure .tpproperties.frame6.canvas2.frame5.propswidget.frame21.entry23  -expand 1  -fill x  -ipadx 3  -side left

  # pack master .tpproperties.frame6.canvas2.frame5.propswidget.frame24
  pack configure .tpproperties.frame6.canvas2.frame5.propswidget.frame24.label22  -anchor w  -side left
  pack configure .tpproperties.frame6.canvas2.frame5.propswidget.frame24.entry23  -expand 1  -fill x  -side left

  # pack master .tpproperties.frame6.canvas2.frame5.propswidget.frame25
  pack configure .tpproperties.frame6.canvas2.frame5.propswidget.frame25.label22  -anchor w  -side left
  pack configure .tpproperties.frame6.canvas2.frame5.propswidget.frame25.entry23  -expand 1  -fill x  -side left

  # pack master .tpproperties
  pack configure .tpproperties.frame0  -fill x
  pack configure .tpproperties.frame3  -fill x
  pack configure .tpproperties.frame6  -expand 1  -fill both

  # build canvas items .tpproperties.frame6.canvas2
  set xfTmpTag [.tpproperties.frame6.canvas2 create window 0.0 0.0]
  .tpproperties.frame6.canvas2 itemconfigure $xfTmpTag  -anchor {nw}  -window {.tpproperties.frame6.canvas2.frame5}

EndSrc.tpproperties
}

proc DestroyWindow.tpproperties {} {
     catch "destroy .tpproperties"
     update
}

proc EndSrc.tpproperties {} {
global TPcurWidget

wm iconphoto .tpproperties tplogo16
set wclass [TP_ClassGet $TPcurWidget]
switch $wclass {
	Toplevel -
	Panedwindow -
	TPanedwindow	{
			  pack .tpproperties.frame0.button0 -after .tpproperties.frame0.label2 -side right
			}
	default		{
			  pack forget .tpproperties.frame0.button0
			}
     }

set slavelist [pack slaves .tpproperties.frame6.canvas2.frame5]
if {$wclass ni {Table Text Toplevel} && [string index $wclass 0] eq {T}} {
    # We are dealing with a TTK widget.
    if {{.tpproperties.frame6.canvas2.frame5.hdrstates} ni $slavelist} {
	# We need to pack the States header
	set lastslave [lindex $slavelist end]
        pack configure .tpproperties.frame6.canvas2.frame5.hdrstates -anchor w -after $lastslave -fill x
       }
   } {
	if {{.tpproperties.frame6.canvas2.frame5.hdrstates} in $slavelist} {
	    # The States section is currently showing. We need to hide it.
	    if {[string first {(-)} [.tpproperties.frame6.canvas2.frame5.hdrstates cget -text]] != -1} {
		# The States section is currently expanded. Shrink it.
		TP_PropsShowHide .tpproperties.frame6.canvas2.frame5.hdrstates
	       }
	    pack forget .tpproperties.frame6.canvas2.frame5.hdrstates
	   }
     }

foreach TPtemp2 {hdrwidget hdrgeometry hdrstandard hdrspecific hdrstates} {
	if {[string first {(-)} [.tpproperties.frame6.canvas2.frame5.$TPtemp2 cget -text]] != -1} {
	    # The section is currently expanded. Close it and then re-open it to fill it properly.
	    TP_PropsShowHide .tpproperties.frame6.canvas2.frame5.$TPtemp2
	    TP_PropsShowHide .tpproperties.frame6.canvas2.frame5.$TPtemp2
	   }
      }
}


proc ShowWindow.tptkwidgets { args} {

  catch "destroy .tptkwidgets"

  toplevel .tptkwidgets   -relief {raised}  -background {#dcdcdc}  -highlightbackground {#dcdcdc}

  # Window manager configurations
  wm positionfrom .tptkwidgets user
  wm sizefrom .tptkwidgets program
  wm maxsize .tptkwidgets 144 288
  wm minsize .tptkwidgets 0 288
  wm overrideredirect .tptkwidgets 1
  wm protocol .tptkwidgets WM_DELETE_WINDOW {TP_ShowWidgets}
  wm title .tptkwidgets {TKwidgets}


  frame .tptkwidgets.frame1  -relief {raised}  -background {#dcdcdc}  -height {27}  -highlightbackground {#dcdcdc}  -width {50}

  button .tptkwidgets.frame1.button0  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_AddNewObj frame}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -image {tpframe}  -text {button0}

  button .tptkwidgets.frame1.button1  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_AddNewObj labelframe}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -image {tplabelframe}  -text {button1}

  frame .tptkwidgets.frame2  -relief {raised}  -background {#dcdcdc}  -height {27}  -highlightbackground {#dcdcdc}  -width {50}

  button .tptkwidgets.frame2.button0  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_AddNewObj button}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -image {tpbutton}  -text {button0}

  button .tptkwidgets.frame2.button1  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_AddNewObj entry}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -image {tpentry}  -text {button1}

  frame .tptkwidgets.frame3  -relief {raised}  -background {#dcdcdc}  -height {27}  -highlightbackground {#dcdcdc}  -width {50}

  button .tptkwidgets.frame3.button0  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_AddNewObj label}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -image {tplabel}  -text {button0}

  button .tptkwidgets.frame3.button1  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_AddNewObj message}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -image {tpmessage}  -text {button1}

  frame .tptkwidgets.frame4  -relief {raised}  -background {#dcdcdc}  -height {27}  -highlightbackground {#dcdcdc}  -width {50}

  button .tptkwidgets.frame4.button0  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_AddNewObj listbox}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -image {tplistbox}  -text {button0}

  button .tptkwidgets.frame4.button1  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_AddNewObj text}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -image {tptext}  -text {button1}

  frame .tptkwidgets.frame5  -relief {raised}  -background {#dcdcdc}  -height {27}  -highlightbackground {#dcdcdc}  -width {50}

  button .tptkwidgets.frame5.button0  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_AddNewObj menubutton}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -image {tpmenubutton}  -text {button0}

  button .tptkwidgets.frame5.button1  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_AddNewObj menu}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -image {tpmenu}  -text {button1}

  frame .tptkwidgets.frame6  -relief {raised}  -background {#dcdcdc}  -height {27}  -highlightbackground {#dcdcdc}  -width {50}

  button .tptkwidgets.frame6.button0  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_AddNewObj vscale}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -image {tpscale_v}  -text {button0}

  button .tptkwidgets.frame6.button1  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_AddNewObj hscale}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -image {tpscale_h}  -text {button1}

  frame .tptkwidgets.frame7  -relief {raised}  -background {#dcdcdc}  -height {27}  -highlightbackground {#dcdcdc}  -width {50}

  button .tptkwidgets.frame7.button0  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_AddNewObj vscrollbar}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -image {tpscrollbar_v}  -text {button0}

  button .tptkwidgets.frame7.button1  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_AddNewObj hscrollbar}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -image {tpscrollbar_h}  -text {button1}

  frame .tptkwidgets.frame8  -relief {raised}  -background {#dcdcdc}  -height {27}  -highlightbackground {#dcdcdc}  -width {50}

  button .tptkwidgets.frame8.button0  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_AddNewObj vcheckbutton}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -image {tpcheckbutton}  -text {button0}

  button .tptkwidgets.frame8.button1  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_AddNewObj radiobutton}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -image {tpradiobutton}  -text {button1}

  frame .tptkwidgets.frame0  -relief {raised}  -background {#dcdcdc}  -height {27}  -highlightbackground {#dcdcdc}  -width {50}

  button .tptkwidgets.frame0.button0  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_AddNewObj toplevel}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -image {tptoplevel}  -text {button0}

  button .tptkwidgets.frame0.button1  -activebackground {gray75}  -background {gray85}  -command {TP_ShowWidgets}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -image {tptoolbar}

  frame .tptkwidgets.frame9  -relief {raised}  -background {#dcdcdc}  -height {27}  -highlightbackground {#dcdcdc}  -width {50}

  button .tptkwidgets.frame9.button0  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_AddNewObj vpanedwindow}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -image {tppanedwin_v}  -text {button0}

  button .tptkwidgets.frame9.button1  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_AddNewObj hpanedwindow}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -image {tppanedwin_h}  -text {button1}

  frame .tptkwidgets.frame10  -relief {raised}  -background {#dcdcdc}  -height {27}  -highlightbackground {#dcdcdc}  -width {50}

  button .tptkwidgets.frame10.button0  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_AddNewObj spinbox}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -image {tpspinbox}  -text {button0}

  button .tptkwidgets.frame10.button1  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_AddNewObj canvas}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -image {tpcanvas}  -text {button1}

  label .tptkwidgets.label0  -activebackground {#eeeeee}  -background {SteelBlue3}  -borderwidth {2}  -font {Helvetica 9}  -foreground {black}  -highlightbackground {#eeeeee}  -relief {raised}  -text { Widgets }
  # bindings
  bind .tptkwidgets.label0 <B1-Motion> {if {$TPtoolMove} {
   wm geometry .tptkwidgets +[expr %X - $TPtoolX]+[expr %Y - $TPtoolY]
  }}
  bind .tptkwidgets.label0 <Button-1> {set TPtoolMove 1
set TPtoolX %x
set TPtoolY %y}
  bind .tptkwidgets.label0 <ButtonRelease-1> {set TPtoolMove 0}

  # pack master .tptkwidgets.frame1
  pack configure .tptkwidgets.frame1.button0  -side left
  pack configure .tptkwidgets.frame1.button1  -side left

  # pack master .tptkwidgets.frame2
  pack configure .tptkwidgets.frame2.button0  -side left
  pack configure .tptkwidgets.frame2.button1  -side left

  # pack master .tptkwidgets.frame3
  pack configure .tptkwidgets.frame3.button0  -side left
  pack configure .tptkwidgets.frame3.button1  -side left

  # pack master .tptkwidgets.frame4
  pack configure .tptkwidgets.frame4.button0  -side left
  pack configure .tptkwidgets.frame4.button1  -side left

  # pack master .tptkwidgets.frame5
  pack configure .tptkwidgets.frame5.button0  -side left
  pack configure .tptkwidgets.frame5.button1  -side left

  # pack master .tptkwidgets.frame6
  pack configure .tptkwidgets.frame6.button0  -side left
  pack configure .tptkwidgets.frame6.button1  -side left

  # pack master .tptkwidgets.frame7
  pack configure .tptkwidgets.frame7.button0  -side left
  pack configure .tptkwidgets.frame7.button1  -side left

  # pack master .tptkwidgets.frame8
  pack configure .tptkwidgets.frame8.button0  -side left
  pack configure .tptkwidgets.frame8.button1  -side left

  # pack master .tptkwidgets.frame0
  pack configure .tptkwidgets.frame0.button0  -side left
  pack configure .tptkwidgets.frame0.button1  -side left

  # pack master .tptkwidgets.frame9
  pack configure .tptkwidgets.frame9.button0  -side left
  pack configure .tptkwidgets.frame9.button1  -side left

  # pack master .tptkwidgets.frame10
  pack configure .tptkwidgets.frame10.button0  -side left
  pack configure .tptkwidgets.frame10.button1  -side left

  # pack master .tptkwidgets
  pack configure .tptkwidgets.label0  -fill x
  pack configure .tptkwidgets.frame1
  pack configure .tptkwidgets.frame2
  pack configure .tptkwidgets.frame3
  pack configure .tptkwidgets.frame4
  pack configure .tptkwidgets.frame5
  pack configure .tptkwidgets.frame6
  pack configure .tptkwidgets.frame7
  pack configure .tptkwidgets.frame8
  pack configure .tptkwidgets.frame9
  pack configure .tptkwidgets.frame10
  pack configure .tptkwidgets.frame0

EndSrc.tptkwidgets
}

proc DestroyWindow.tptkwidgets {} {
     catch "destroy .tptkwidgets"
     update
}

proc EndSrc.tptkwidgets {} {
wm iconphoto .tptkwidgets tplogo16
wm overrideredirect .tptkwidgets 1
}


proc ShowWindow.tpvars { args} {

  catch "destroy .tpvars"

  toplevel .tpvars   -relief {raised}  -background {#dcdcdc}  -highlightbackground {#dcdcdc}

  # Window manager configurations
  wm positionfrom .tpvars program
  wm sizefrom .tpvars program
  wm maxsize .tpvars 2560 1024
  wm minsize .tpvars 400 470
  wm protocol .tpvars WM_DELETE_WINDOW {.tpvars.frame1.varlist delete 0 end
.tpvars.frame8.varvalue delete 1.0 end
set TPshowGlobals 0
DestroyWindow.tpvars}
  wm title .tpvars {TKproE - global variables}

  # bindings
  bind .tpvars <ButtonRelease-1> {TP_ProcessClick %W %X %Y %x %y}
  bind .tpvars <Shift-Button-3> {TP_PropsSelWidget %W}

  frame .tpvars.frame1  -background {#dcdcdc}  -height {65}  -highlightbackground {#dcdcdc}  -width {289}

  scrollbar .tpvars.frame1.scrollbar2  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {2}  -command {.tpvars.frame1.varlist yview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -troughcolor {#dcdcdc}  -width {12}

  scrollbar .tpvars.frame1.scrollbar3  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {2}  -command {.tpvars.frame1.varlist xview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -orient {horizontal}  -troughcolor {#dcdcdc}  -width {12}

  listbox .tpvars.frame1.varlist  -background {white}  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#547098}  -selectforeground {#ffffff}  -width {10}  -xscrollcommand {.tpvars.frame1.scrollbar3 set}  -yscrollcommand {.tpvars.frame1.scrollbar2 set}
  # bindings
  bind .tpvars.frame1.varlist <<ListboxSelect>> {.tpvars.frame8.varvalue delete 1.0 end
set TPtemp [%W curselection]
if {$TPtemp != {}} {
    set TPglobalVar [%W get $TPtemp]
    set TPtemp [.tpvars.frame8.varvalue cget -state]
    .tpvars.frame8.varvalue configure -state normal
    .tpvars.frame8.varvalue delete 1.0 end
    if {[catch "set \{$TPvarNamespacePrefix$TPglobalVar\}" TPtemp2]} { set TPtemp2 {} }
    .tpvars.frame8.varvalue insert end $TPtemp2
    .tpvars.frame8.varvalue configure -state $TPtemp
   }}

  frame .tpvars.frame5  -borderwidth {2}  -relief {ridge}  -background {#dcdcdc}  -height {30}  -highlightbackground {#dcdcdc}  -width {395}

  label .tpvars.frame5.label6  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Name:}

  entry .tpvars.frame5.entry7  -background {oldlace}  -font {Helvetica 10}  -highlightbackground {#ffffff}  -insertbackground {black}  -selectbackground {black}  -selectforeground {#ffffff}  -textvariable {TPglobalVar}

  frame .tpvars.frame8  -borderwidth {2}  -relief {raised}  -background {#dcdcdc}  -height {30}  -highlightbackground {#dcdcdc}  -width {30}

  scrollbar .tpvars.frame8.scrollbar2  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {2}  -command {.tpvars.frame8.varvalue yview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -troughcolor {#dcdcdc}  -width {12}

  scrollbar .tpvars.frame8.scrollbar3  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {2}  -command {.tpvars.frame8.varvalue xview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -orient {horizontal}  -troughcolor {#dcdcdc}  -width {12}

  text .tpvars.frame8.varvalue  -background {white}  -font {Helvetica 10}  -height {6}  -highlightbackground {#ffffff}  -insertbackground {black}  -selectbackground {#547098}  -selectforeground {#ffffff}  -width {40}  -wrap {none}  -xscrollcommand {.tpvars.frame8.scrollbar3 set}  -yscrollcommand {.tpvars.frame8.scrollbar2 set}

  frame .tpvars.frame11  -borderwidth {2}  -background {#dcdcdc}  -height {32}  -highlightbackground {#dcdcdc}  -width {450}

  button .tpvars.frame11.button12  -activebackground {gray75}  -background {#dcdcdc}  -command {set TPtemp [.tpvars.frame8.varvalue get 1.0 end-1chars]
if {$TPvarNamespace == {::}} {
    set TPprefix {}
  } { set TPprefix $TPvarNamespace }
if {[catch "set \{${TPprefix}::$TPglobalVar\} \{$TPtemp\}" TPtemp]} {
    set TPmessage $TPtemp
    set TPmsgButtons OK
    ShowWindow.tpmsgbox
  } {
      TP_ProcListFill3
    }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Insert}

  button .tpvars.frame11.button13  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_RenameVarAsk}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Rename}

  button .tpvars.frame11.button14  -activebackground {gray75}  -background {#dcdcdc}  -command {set TPtemp [.tpvars.frame1.varlist curselection]
if {[string length $TPtemp] > 0} {
    set TPtemp [.tpvars.frame1.varlist get $TPtemp]
    if {$TPvarNamespace == {::}} {
        set TPprefix {}
      } { set TPprefix $TPvarNamespace }
    set TPmessage "Do you really want to delete\n${TPprefix}::$TPtemp\n?"
    set TPmsgCmd(Yes) "TP_WatchList delete ${TPprefix}::$TPtemp; TP_WatchListFill .tpwatchwin.frame.text2;unset \{${TPprefix}::$TPtemp\};TP_ProcListFill3; set TPmsgCmd(Yes) {}; set TPmsgCmd(No) {}; set TPmsgButtons {}"
    set TPmsgCmd(No) "set TPmsgCmd(Yes) {}; set TPmsgCmd(No) {}; set TPmsgButtons {}"
    set TPmsgButtons {Yes No}
    ShowWindow.tpmsgbox
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Remove}

  button .tpvars.frame11.button15  -activebackground {gray75}  -background {#dcdcdc}  -command {set TPglobalVar {}
.tpvars.frame8.varvalue delete 1.0 end}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Clear}

  button .tpvars.frame11.button11  -activebackground {gray75}  -background {#dcdcdc}  -command {set TPtemp [.tpvars.frame1.varlist curselection]
if {[llength $TPtemp] == 1} {
    if {$TPvarNamespace == {::}} {
        set TPtemp ::[.tpvars.frame1.varlist get $TPtemp]
      } { set TPtemp ${TPvarNamespace}::[.tpvars.frame1.varlist get $TPtemp] }
    TP_WatchList add $TPtemp
    if {[winfo exists .tpwatchwin]} { EndSrc.tpwatchwin } { ShowWindow.tpwatchwin }
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Watch}

  frame .tpvars.frame16  -borderwidth {2}  -background {#dcdcdc}  -height {32}  -highlightbackground {#dcdcdc}  -width {120}

  button .tpvars.frame16.button12  -activebackground {gray75}  -background {#dcdcdc}  -command {.tpvars.frame1.varlist delete 0 end
.tpvars.frame8.varvalue delete 1.0 end
set TPshowGlobals 0
DestroyWindow.tpvars}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {OK}

  button .tpvars.frame16.button17  -activebackground {gray75}  -background {#dcdcdc}  -command {TP_ProcListFill3}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {Rescan}

  frame .tpvars.frame0  -borderwidth {2}  -relief {raised}  -background {#dcdcdc}  -height {30}  -highlightbackground {#dcdcdc}  -width {30}

  frame .tpvars.frame0.frame1  -borderwidth {2}  -relief {groove}  -background {#dcdcdc}  -height {38}  -highlightbackground {#eeeeee}  -width {111}

  menubutton .tpvars.frame0.frame1.menubutton1  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -font {Helvetica 12}  -foreground {red}  -highlightbackground {#dcdcdc}  -image {tparrowcombo}  -menu {.tpvars.frame0.frame1.menubutton1.m}  -padx {2}  -pady {1}  -relief {raised}  -text {::}  -textvariable {TPvarNamespace}

  menu .tpvars.frame0.frame1.menubutton1.m  -activebackground {#dcdcdc}  -background {#dcdcdc}  -font {Helvetica 10}  -tearoff {0}
  .tpvars.frame0.frame1.menubutton1.m add command  -command {set TPvarNamespace ::; TP_ProcListFill3}  -label {::}
  .tpvars.frame0.frame1.menubutton1.m add command  -command {set TPvarNamespace ::auto_mkindex_parser; TP_ProcListFill3}  -label {::auto_mkindex_parser}
  .tpvars.frame0.frame1.menubutton1.m add command  -command {set TPvarNamespace ::freewrap; TP_ProcListFill3}  -label {::freewrap}
  .tpvars.frame0.frame1.menubutton1.m add command  -command {set TPvarNamespace ::msgcat; TP_ProcListFill3}  -label {::msgcat}
  .tpvars.frame0.frame1.menubutton1.m add command  -command {set TPvarNamespace ::pkg; TP_ProcListFill3}  -label {::pkg}
  .tpvars.frame0.frame1.menubutton1.m add command  -command {set TPvarNamespace ::tcl; TP_ProcListFill3}  -label {::tcl}
  .tpvars.frame0.frame1.menubutton1.m add command  -command {set TPvarNamespace ::tcl::Pkg; TP_ProcListFill3}  -label {::tcl::Pkg}
  .tpvars.frame0.frame1.menubutton1.m add command  -command {set TPvarNamespace ::tcl::chan; TP_ProcListFill3}  -label {::tcl::chan}
  .tpvars.frame0.frame1.menubutton1.m add command  -command {set TPvarNamespace ::tcl::clock; TP_ProcListFill3}  -label {::tcl::clock}
  .tpvars.frame0.frame1.menubutton1.m add command  -command {set TPvarNamespace ::tcl::dict; TP_ProcListFill3}  -label {::tcl::dict}
  .tpvars.frame0.frame1.menubutton1.m add command  -command {set TPvarNamespace ::tcl::info; TP_ProcListFill3}  -label {::tcl::info}
  .tpvars.frame0.frame1.menubutton1.m add command  -command {set TPvarNamespace ::tcl::mathfunc; TP_ProcListFill3}  -label {::tcl::mathfunc}
  .tpvars.frame0.frame1.menubutton1.m add command  -command {set TPvarNamespace ::tcl::mathop; TP_ProcListFill3}  -label {::tcl::mathop}
  .tpvars.frame0.frame1.menubutton1.m add command  -command {set TPvarNamespace ::tcl::string; TP_ProcListFill3}  -label {::tcl::string}
  .tpvars.frame0.frame1.menubutton1.m add command  -command {set TPvarNamespace ::tcl::tm; TP_ProcListFill3}  -label {::tcl::tm}
  .tpvars.frame0.frame1.menubutton1.m add command  -command {set TPvarNamespace ::tcl::unsupported; TP_ProcListFill3}  -label {::tcl::unsupported}
  .tpvars.frame0.frame1.menubutton1.m add command  -command {set TPvarNamespace ::tk; TP_ProcListFill3}  -label {::tk}
  .tpvars.frame0.frame1.menubutton1.m add command  -command {set TPvarNamespace ::tk::dialog; TP_ProcListFill3}  -label {::tk::dialog}
  .tpvars.frame0.frame1.menubutton1.m add command  -command {set TPvarNamespace ::tk::dialog::error; TP_ProcListFill3}  -label {::tk::dialog::error}
  .tpvars.frame0.frame1.menubutton1.m add command  -command {set TPvarNamespace ::tk::msgcat; TP_ProcListFill3}  -label {::tk::msgcat}
  .tpvars.frame0.frame1.menubutton1.m add command  -command {set TPvarNamespace ::tk::panedwindow; TP_ProcListFill3}  -label {::tk::panedwindow}
  .tpvars.frame0.frame1.menubutton1.m add command  -command {set TPvarNamespace ::tk::spinbox; TP_ProcListFill3}  -label {::tk::spinbox}
  .tpvars.frame0.frame1.menubutton1.m add command  -command {set TPvarNamespace ::ttk; TP_ProcListFill3}  -label {::ttk}
  .tpvars.frame0.frame1.menubutton1.m add command  -command {set TPvarNamespace ::ttk::button; TP_ProcListFill3}  -label {::ttk::button}
  .tpvars.frame0.frame1.menubutton1.m add command  -command {set TPvarNamespace ::ttk::combobox; TP_ProcListFill3}  -label {::ttk::combobox}
  .tpvars.frame0.frame1.menubutton1.m add command  -command {set TPvarNamespace ::ttk::entry; TP_ProcListFill3}  -label {::ttk::entry}
  .tpvars.frame0.frame1.menubutton1.m add command  -command {set TPvarNamespace ::ttk::menubutton; TP_ProcListFill3}  -label {::ttk::menubutton}
  .tpvars.frame0.frame1.menubutton1.m add command  -command {set TPvarNamespace ::ttk::notebook; TP_ProcListFill3}  -label {::ttk::notebook}
  .tpvars.frame0.frame1.menubutton1.m add command  -command {set TPvarNamespace ::ttk::panedwindow; TP_ProcListFill3}  -label {::ttk::panedwindow}
  .tpvars.frame0.frame1.menubutton1.m add command  -command {set TPvarNamespace ::ttk::progressbar; TP_ProcListFill3}  -label {::ttk::progressbar}
  .tpvars.frame0.frame1.menubutton1.m add command  -command {set TPvarNamespace ::ttk::scale; TP_ProcListFill3}  -label {::ttk::scale}
  .tpvars.frame0.frame1.menubutton1.m add command  -command {set TPvarNamespace ::ttk::scrollbar; TP_ProcListFill3}  -label {::ttk::scrollbar}
  .tpvars.frame0.frame1.menubutton1.m add command  -command {set TPvarNamespace ::ttk::sizegrip; TP_ProcListFill3}  -label {::ttk::sizegrip}
  .tpvars.frame0.frame1.menubutton1.m add command  -command {set TPvarNamespace ::ttk::theme; TP_ProcListFill3}  -label {::ttk::theme}
  .tpvars.frame0.frame1.menubutton1.m add command  -command {set TPvarNamespace ::ttk::theme::alt; TP_ProcListFill3}  -label {::ttk::theme::alt}
  .tpvars.frame0.frame1.menubutton1.m add command  -command {set TPvarNamespace ::ttk::theme::clam; TP_ProcListFill3}  -label {::ttk::theme::clam}
  .tpvars.frame0.frame1.menubutton1.m add command  -command {set TPvarNamespace ::ttk::theme::classic; TP_ProcListFill3}  -label {::ttk::theme::classic}
  .tpvars.frame0.frame1.menubutton1.m add command  -command {set TPvarNamespace ::ttk::theme::default; TP_ProcListFill3}  -label {::ttk::theme::default}
  .tpvars.frame0.frame1.menubutton1.m add command  -command {set TPvarNamespace ::ttk::treeview; TP_ProcListFill3}  -label {::ttk::treeview}
  .tpvars.frame0.frame1.menubutton1.m add command  -command {set TPvarNamespace ::zvfs; TP_ProcListFill3}  -label {::zvfs}

  label .tpvars.frame0.frame1.label2  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10 bold}  -highlightbackground {#dcdcdc}  -text {Show Namespace:}  -width {18}

  label .tpvars.frame0.frame1.label3  -activebackground {#dcdcdc}  -anchor {w}  -background {#dcdcdc}  -borderwidth {0}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -pady {0}  -text {::}  -textvariable {TPvarNamespace}

  frame .tpvars.frame0.frame4  -borderwidth {2}  -relief {groove}  -background {#dcdcdc}  -height {46}  -highlightbackground {#eeeeee}  -width {98}

  button .tpvars.frame0.frame4.button3  -activebackground {gray75}  -background {#dcdcdc}  -command {ShowWindow.tpexclusions}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -pady {0}  -text {Exclusion List}

  button .tpvars.frame0.frame4.button5  -activebackground {gray75}  -background {#dcdcdc}  -command {ShowWindow.tpnewspace}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -pady {0}  -text {New Namespace}

  button .tpvars.frame0.frame4.button13  -activebackground {gray75}  -background {#dcdcdc}  -command {ShowWindow.tpwatchwin}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -highlightthickness {0}  -pady {0}  -text {Watch Window}

  # pack master .tpvars.frame1
  pack configure .tpvars.frame1.scrollbar2  -fill y  -side left
  pack configure .tpvars.frame1.scrollbar3  -fill x  -side bottom
  pack configure .tpvars.frame1.varlist  -expand 1  -fill both

  # pack master .tpvars.frame5
  pack configure .tpvars.frame5.label6  -side left
  pack configure .tpvars.frame5.entry7  -expand 1  -fill x  -side left

  # pack master .tpvars.frame8
  pack configure .tpvars.frame8.scrollbar2  -fill y  -side left
  pack configure .tpvars.frame8.scrollbar3  -fill x  -side bottom
  pack configure .tpvars.frame8.varvalue  -expand 1  -fill both

  # pack master .tpvars.frame11
  pack configure .tpvars.frame11.button12  -expand 1  -fill x  -side left
  pack configure .tpvars.frame11.button13  -expand 1  -fill x  -side left
  pack configure .tpvars.frame11.button14  -expand 1  -fill x  -side left
  pack configure .tpvars.frame11.button11  -expand 1  -fill x  -side left
  pack configure .tpvars.frame11.button15  -expand 1  -fill x  -side left

  # pack master .tpvars.frame16
  pack configure .tpvars.frame16.button12  -expand 1  -fill x  -padx 2  -side left
  pack configure .tpvars.frame16.button17  -expand 1  -fill x  -padx 2  -side left

  # pack master .tpvars.frame0
  pack configure .tpvars.frame0.frame1  -fill y  -side left
  pack configure .tpvars.frame0.frame4  -fill y  -side right

  # pack master .tpvars.frame0.frame1
  pack configure .tpvars.frame0.frame1.menubutton1  -side right
  pack configure .tpvars.frame0.frame1.label2  -fill x
  pack configure .tpvars.frame0.frame1.label3  -fill x  -ipadx 3

  # pack master .tpvars.frame0.frame4
  pack configure .tpvars.frame0.frame4.button3  -fill x  -padx 3  -pady 1
  pack configure .tpvars.frame0.frame4.button5  -fill x  -padx 3  -pady 1
  pack configure .tpvars.frame0.frame4.button13  -fill x  -padx 3  -pady 1

  # pack master .tpvars
  pack configure .tpvars.frame0  -fill x
  pack configure .tpvars.frame1  -expand 1  -fill both
  pack configure .tpvars.frame5  -fill x
  pack configure .tpvars.frame8  -fill x
  pack configure .tpvars.frame11  -fill x
  pack configure .tpvars.frame16

  .tpvars.frame1.varlist insert end {fin}
  .tpvars.frame1.varlist insert end {pname}
  .tpvars.frame8.varvalue insert end {}

EndSrc.tpvars
}

proc DestroyWindow.tpvars {} {
     catch "destroy .tpvars"
     update
}

proc EndSrc.tpvars {} {
wm iconphoto .tpvars tplogo16
TP_MenuFromList3 .tpvars.frame0.frame1.menubutton1.m [concat :: [TP_NamespaceList ::]]
TP_ProcListFill3
}


proc ShowWindow.tpwatchwin { args} {

  catch "destroy .tpwatchwin"

  toplevel .tpwatchwin   -relief {raised}  -background {#eeeeee}  -highlightbackground {#eeeeee}

  # Window manager configurations
  wm positionfrom .tpwatchwin program
  wm sizefrom .tpwatchwin program
  wm maxsize .tpwatchwin 2560 1024
  wm minsize .tpwatchwin 400 120
  wm protocol .tpwatchwin WM_DELETE_WINDOW {.tpwatchwin.frame14.button15 invoke}
  wm title .tpwatchwin {TKproE - parameter watch}


  frame .tpwatchwin.frame1  -relief {raised}  -background {#eeeeee}  -height {26}  -highlightbackground {#eeeeee}  -width {419}

  label .tpwatchwin.frame1.label2  -activebackground {#eeeeee}  -background {#d5c9c1}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#eeeeee}  -relief {raised}  -text {Parameter}  -width {9}

  label .tpwatchwin.frame1.label3  -activebackground {#eeeeee}  -background {#d5c9c1}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#eeeeee}  -relief {raised}  -text {Value}

  label .tpwatchwin.frame1.label8  -activebackground {#eeeeee}  -background {#eeeeee}  -borderwidth {2}  -font {Helvetica 10}  -highlightbackground {#eeeeee}  -width {1}

  label .tpwatchwin.frame1.label9  -activebackground {#eeeeee}  -background {#eeeeee}  -borderwidth {0}  -font {Helvetica 10}  -highlightbackground {#eeeeee}  -width {4}

  frame .tpwatchwin.frame  -relief {raised}  -background {#eeeeee}  -highlightbackground {#eeeeee}

  scrollbar .tpwatchwin.frame.scrollbar1  -activebackground {#eeeeee}  -background {#eeeeee}  -command {.tpwatchwin.frame.text2 yview}  -cursor {left_ptr}  -highlightbackground {#eeeeee}  -relief {raised}  -troughcolor {#eeeeee}  -width {12}

  text .tpwatchwin.frame.text2  -background {white}  -font {Helvetica 10}  -height {4}  -highlightbackground {#ffffff}  -selectbackground {#447bcd}  -selectforeground {#ffffff}  -width {65}  -wrap {none}  -yscrollcommand {.tpwatchwin.frame.scrollbar1 set}

  frame .tpwatchwin.frame14  -borderwidth {2}  -background {#eeeeee}  -height {28}  -highlightbackground {#eeeeee}  -width {87}

  button .tpwatchwin.frame14.button15  -activebackground {gray75}  -background {#eeeeee}  -command {# Remove any existing watch items.
foreach widget [.tpwatchwin.frame.text2 window names] {
	TP_WindowDestroy $widget
           }
.tpwatchwin.frame.text2 delete 1.0 end
set TPwatchParameter {}
set TPshowWatch 0
DestroyWindow.tpwatchwin}  -font {Helvetica 10}  -highlightbackground {#eeeeee}  -pady {0}  -text {Dismiss}

  frame .tpwatchwin.frame10  -borderwidth {2}  -relief {ridge}  -background {#eeeeee}  -height {30}  -highlightbackground {#eeeeee}  -width {609}

  label .tpwatchwin.frame10.label11  -activebackground {#eeeeee}  -background {#eeeeee}  -borderwidth {0}  -font {Helvetica 10 bold}  -highlightbackground {#eeeeee}  -relief {raised}  -text {Add parameter:}

  entry .tpwatchwin.frame10.entry12  -background {white}  -font {Helvetica 10}  -highlightbackground {#ffffff}  -selectbackground {#447bcd}  -selectforeground {#ffffff}  -textvariable {TPwatchParameter}
  # bindings
  bind .tpwatchwin.frame10.entry12 <Key-KP_Enter> {TP_WatchList add $TPwatchParameter
TP_WatchListFill .tpwatchwin.frame.text2}
  bind .tpwatchwin.frame10.entry12 <Key-Return> {TP_WatchList add $TPwatchParameter
TP_WatchListFill .tpwatchwin.frame.text2}

  # pack master .tpwatchwin.frame1
  pack configure .tpwatchwin.frame1.label9  -side left
  pack configure .tpwatchwin.frame1.label2  -ipadx 2  -side left
  pack configure .tpwatchwin.frame1.label3  -expand 1  -fill x  -side left
  pack configure .tpwatchwin.frame1.label8  -side left

  # pack master .tpwatchwin.frame
  pack configure .tpwatchwin.frame.scrollbar1  -fill y  -side right
  pack configure .tpwatchwin.frame.text2  -expand 1  -fill both

  # pack master .tpwatchwin.frame14
  pack configure .tpwatchwin.frame14.button15

  # pack master .tpwatchwin.frame10
  pack configure .tpwatchwin.frame10.label11  -ipadx 4  -side left
  pack configure .tpwatchwin.frame10.entry12  -expand 1  -fill x  -side left

  # pack master .tpwatchwin
  pack configure .tpwatchwin.frame1  -fill x
  pack configure .tpwatchwin.frame  -expand 1  -fill both
  pack configure .tpwatchwin.frame14  -side bottom
  pack configure .tpwatchwin.frame10  -fill x

  .tpwatchwin.frame.text2 insert end {}

EndSrc.tpwatchwin
}

proc DestroyWindow.tpwatchwin {} {
     catch "destroy .tpwatchwin"
     update
}

proc EndSrc.tpwatchwin {} {
wm iconphoto .tpwatchwin tplogo16
TP_WatchListFill .tpwatchwin.frame.text2
}

proc ShowWindow.tpwm { args} {

  catch "destroy .tpwm"

  toplevel .tpwm   -relief {sunken}  -background {#dcdcdc}  -highlightbackground {#e6e7e6}

  # Window manager configurations
  wm positionfrom .tpwm program
  wm sizefrom .tpwm program
  wm maxsize .tpwm 2560 1024
  wm minsize .tpwm 632 374
  wm protocol .tpwm WM_DELETE_WINDOW {DestroyWindow.tpwm}
  wm title .tpwm {TKproE toplevel window properties}


  frame .tpwm.frame0  -borderwidth {2}  -relief {ridge}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {364}

  label .tpwm.frame0.label1  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {2}  -cursor {question_arrow}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -text {Toplevel window: }
  # bindings
  bind .tpwm.frame0.label1 <ButtonRelease-3> {set TPtemp [winfo containing %X %Y]
if {($TPtemp != {}) && ([string range $TPtemp 0 2] != {.tp})} {
    # Collapse all sections
    if {[string first {+} [.tpwm.frame6.canvas2.frame5.hdrwidget cget -text]] < 0} { TP_PropsShowHide .tpwm.frame6.canvas2.frame5.hdrwidget }
    if {[string first {+} [.tpwm.frame6.canvas2.frame5.hdrgeometry cget -text]] < 0} { TP_PropsShowHide .tpwm.frame6.canvas2.frame5.hdrgeometry }
    if {[string first {+} [.tpwm.frame6.canvas2.frame5.hdrstandard cget -text]] < 0} { TP_PropsShowHide .tpwm.frame6.canvas2.frame5.hdrstandard }
    if {[string first {+} [.tpwm.frame6.canvas2.frame5.hdrspecific cget -text]] < 0} { TP_PropsShowHide .tpwm.frame6.canvas2.frame5.hdrspecific }

    # Configure newly selected widget
    TP_PropsSelWidget $TPtemp
   }}

  label .tpwm.frame0.label2  -activebackground {#dcdcdc}  -background {#dcdcdc}  -borderwidth {2}  -font {Helvetica 10}  -foreground {blue}  -highlightbackground {#dcdcdc}  -text {.toplevel1}  -textvariable {TPcurToplevel}

  frame .tpwm.frame12  -borderwidth {2}  -relief {raised}  -background {#e6e7e6}  -height {218}  -highlightbackground {#e6e7e6}  -width {600}

  frame .tpwm.frame12.frame  -relief {raised}  -background {#dcdcdc}  -highlightbackground {#dcdcdc}

  scrollbar .tpwm.frame12.frame.scrollbar1  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpwm.frame12.frame.text2 yview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}

  text .tpwm.frame12.frame.text2  -font {Helvetica 10}  -height {6}  -highlightbackground {#ffffff}  -selectbackground {#7783bd}  -selectforeground {#ffffff}  -wrap {none}  -xscrollcommand {.tpwm.frame12.frame.scrollbar3 set}  -yscrollcommand {.tpwm.frame12.frame.scrollbar1 set}

  scrollbar .tpwm.frame12.frame.scrollbar3  -activebackground {#dcdcdc}  -background {#dcdcdc}  -command {.tpwm.frame12.frame.text2 xview}  -cursor {left_ptr}  -highlightbackground {#dcdcdc}  -orient {horizontal}  -relief {raised}  -troughcolor {#dcdcdc}  -width {12}

  frame .tpwm.frame12.frame19  -background {#e6e7e6}  -height {28}  -highlightbackground {#e6e7e6}  -width {538}

  radiobutton .tpwm.frame12.frame19.radiobutton14  -activebackground {#e6e7e6}  -anchor {w}  -background {#e6e7e6}  -command {set TPtopMsg {Startup: code executed before toplevel window creation}
.tpwm.frame12.frame.text2 delete 1.0 end
set TPtemp $TPselBoundProc$TPcurToplevel
if {[info proc $TPtemp] != {}} {
    .tpwm.frame12.frame.text2 insert end [string trimleft [info body $TPtemp] \n]
   }}  -font {Helvetica 10}  -highlightbackground {#e6e7e6}  -text {Startup}  -value {TPstartupSrc}  -variable {TPselBoundProc}

  radiobutton .tpwm.frame12.frame19.radiobutton15  -activebackground {#e6e7e6}  -anchor {w}  -background {#e6e7e6}  -command {set TPtopMsg {End: code executed after toplevel window is drawn}
.tpwm.frame12.frame.text2 delete 1.0 end
set TPtemp $TPselBoundProc$TPcurToplevel
if {[info proc $TPtemp] != {}} {
    .tpwm.frame12.frame.text2 insert end [string trimleft [info body $TPtemp] \n]
   }}  -font {Helvetica 10}  -highlightbackground {#e6e7e6}  -text {End}  -value {TPendSrc}  -variable {TPselBoundProc}

  radiobutton .tpwm.frame12.frame19.radiobutton16  -activebackground {#e6e7e6}  -anchor {w}  -background {#e6e7e6}  -command {set TPtopMsg {Executed when window receives WM_DELETE_WINDOW message}
.tpwm.frame12.frame.text2 delete 1.0 end
if {[winfo exists $TPcurToplevel]} {
    .tpwm.frame12.frame.text2 insert end [wm protocol $TPcurToplevel WM_DELETE_WINDOW]
   } { .tpwm.frame12.frame.text2 insert end "# Toplevel window $TPcurToplevel doesn't exists" }}  -font {Helvetica 10}  -highlightbackground {#e6e7e6}  -text {DELETE_WINDOW}  -value {WM_DELETE_WINDOW}  -variable {TPselBoundProc}

  radiobutton .tpwm.frame12.frame19.radiobutton17  -activebackground {#e6e7e6}  -anchor {w}  -background {#e6e7e6}  -command {set TPtopMsg {Executed when window receives WM_SAVE_YOURSELF message}
.tpwm.frame12.frame.text2 delete 1.0 end
if {[winfo exists $TPcurToplevel]} {
    .tpwm.frame12.frame.text2 insert end [wm protocol $TPcurToplevel WM_SAVE_YOURSELF]
   } { .tpwm.frame12.frame.text2 insert end "# Toplevel window $TPcurToplevel doesn't exists" }}  -font {Helvetica 10}  -highlightbackground {#e6e7e6}  -text {SAVE_YOURSELF}  -value {WM_SAVE_YOURSELF}  -variable {TPselBoundProc}

  radiobutton .tpwm.frame12.frame19.radiobutton18  -activebackground {#e6e7e6}  -anchor {w}  -background {#e6e7e6}  -command {set TPtopMsg {Executed when window receives WM_TAKE_FOCUS message}
.tpwm.frame12.frame.text2 delete 1.0 end
if {[winfo exists $TPcurToplevel]} {
    .tpwm.frame12.frame.text2 insert end [wm protocol $TPcurToplevel WM_TAKE_FOCUS]
   } { .tpwm.frame12.frame.text2 insert end "# Toplevel window $TPcurToplevel doesn't exists" }}  -font {Helvetica 10}  -highlightbackground {#e6e7e6}  -text {TAKE_FOCUS}  -value {WM_TAKE_FOCUS}  -variable {TPselBoundProc}

  frame .tpwm.frame12.frame20  -background {#e6e7e6}  -height {30}  -highlightbackground {#e6e7e6}  -width {534}

  label .tpwm.frame12.frame20.label13  -activebackground {#e6e7e6}  -background {#e6e7e6}  -borderwidth {2}  -font {Helvetica 12 italic bold}  -highlightbackground {#e6e7e6}  -text {Bound procedures:}

  label .tpwm.frame12.frame20.label21  -activebackground {#e6e7e6}  -background {#e6e7e6}  -borderwidth {2}  -font {Helvetica 10}  -foreground {blue}  -highlightbackground {#e6e7e6}  -text {End: code executed after toplevel window is drawn}  -textvariable {TPtopMsg}

  button .tpwm.frame12.frame20.button0  -activebackground {gray75}  -background {#dcdcdc}  -command {if {[TP_ClassGet $TPcurToplevel] == {Toplevel}} {
   switch $TPselBoundProc {
              TPendSrc -
              TPstartupSrc {
		  if {[catch "proc $TPselBoundProc$TPcurToplevel {} \{[.tpwm.frame12.frame.text2 get 1.0 {end - 1 chars}]\}" TPtemp]} {
		         TP_ShowMsg $TPtemp
		        }
		}
              default	{
		  if {[catch "wm protocol $TPcurToplevel $TPselBoundProc \{[.tpwm.frame12.frame.text2 get 1.0 {end - 1 chars}]\}" TPtemp]} {
		         TP_ShowMsg $TPtemp
		     }
		}
           }
  }}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -padx {4}  -pady {0}  -text {Save}  -width {6}

  frame .tpwm.frame23  -borderwidth {2}  -relief {ridge}  -background {#dcdcdc}  -height {24}  -highlightbackground {#dcdcdc}  -width {364}

  button .tpwm.frame23.button4  -activebackground {gray75}  -background {#dcdcdc}  -command {foreach TPtemp [array names TPpropsToplevel] {
            set TPpropsToplevel($TPtemp) {}
          }
 DestroyWindow.tpwm}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -padx {4}  -pady {0}  -text {Done}  -width {6}

  button .tpwm.frame23.button8  -activebackground {gray75}  -background {#dcdcdc}  -command {if {[TP_ClassGet $TPcurToplevel] == {Toplevel}} {
    TP_SnapshotRestoreToplevel $TPcurToplevel
   }
DestroyWindow.tpwm}  -font {Helvetica 10}  -highlightbackground {#dcdcdc}  -padx {4}  -pady {0}  -text {Cancel}  -width {6}

  frame .tpwm.frame13  -relief {ridge}  -background {#dcdcdc}  -height {34}  -highlightbackground {#e6e7e6}  -width {609}

  frame .tpwm.frame13.frame16  -borderwidth {2}  -relief {raised}  -background {#dcdcdc}  -height {148}  -highlightbackground {#e6e7e6}  -width {300}

  frame .tpwm.frame13.frame16.frame1  -background {#dcdcdc}  -height {24}  -highlightbackground {#e6e7e6}  -width {312}

  label .tpwm.frame13.frame16.frame1.propname  -activebackground {#e6e7e6}  -anchor {w}  -background {grey85}  -borderwidth {2}  -font {Helvetica 12}  -foreground {black}  -highlightbackground {#e6e7e6}  -text {Title:}  -width {16}

  entry .tpwm.frame13.frame16.frame1.propentry  -background {white}  -font {Helvetica 10}  -foreground {black}  -highlightbackground {#ffffff}  -selectbackground {#21449c}  -selectforeground {#ffffff}  -textvariable {TPpropsToplevel(title)}  -width {21}
  # bindings
  bind .tpwm.frame13.frame16.frame1.propentry <Button-3> {TP_PropsValueSel %W %X %Y title TPpropsToplevel}
  bind .tpwm.frame13.frame16.frame1.propentry <FocusOut> {TP_PropsToplevelSet %W title TPpropsToplevel}
  bind .tpwm.frame13.frame16.frame1.propentry <Key-KP_Enter> {TP_PropsToplevelSet %W title TPpropsToplevel}
  bind .tpwm.frame13.frame16.frame1.propentry <Key-Return> {TP_PropsToplevelSet %W title TPpropsToplevel}

  frame .tpwm.frame13.frame16.frame2  -background {#dcdcdc}  -height {24}  -highlightbackground {#e6e7e6}  -width {312}

  label .tpwm.frame13.frame16.frame2.propname  -activebackground {#e6e7e6}  -anchor {w}  -background {grey85}  -borderwidth {2}  -font {Helvetica 12}  -foreground {black}  -highlightbackground {#e6e7e6}  -text {Focus model:}  -width {16}

  entry .tpwm.frame13.frame16.frame2.propentry  -background {white}  -font {Helvetica 10}  -foreground {black}  -highlightbackground {#ffffff}  -selectbackground {#21449c}  -selectforeground {#ffffff}  -textvariable {TPpropsToplevel(focusmodel)}  -width {21}
  # bindings
  bind .tpwm.frame13.frame16.frame2.propentry <Button-3> {TP_PropsValueSel %W %X %Y focusmodel TPpropsToplevel}
  bind .tpwm.frame13.frame16.frame2.propentry <FocusOut> {TP_PropsToplevelSet %W focusmodel TPpropsToplevel}
  bind .tpwm.frame13.frame16.frame2.propentry <Key-KP_Enter> {TP_PropsToplevelSet %W focusmodel TPpropsToplevel}
  bind .tpwm.frame13.frame16.frame2.propentry <Key-Return> {TP_PropsToplevelSet %W focusmodel TPpropsToplevel}

  frame .tpwm.frame13.frame16.frame8  -background {#dcdcdc}  -height {24}  -highlightbackground {#e6e7e6}  -width {312}

  label .tpwm.frame13.frame16.frame8.propname  -activebackground {#e6e7e6}  -anchor {w}  -background {grey85}  -borderwidth {2}  -font {Helvetica 12}  -foreground {black}  -highlightbackground {#e6e7e6}  -text {Client:}  -width {16}

  entry .tpwm.frame13.frame16.frame8.propentry  -background {white}  -font {Helvetica 10}  -foreground {black}  -highlightbackground {#ffffff}  -selectbackground {#21449c}  -selectforeground {#ffffff}  -textvariable {TPpropsToplevel(client)}  -width {21}
  # bindings
  bind .tpwm.frame13.frame16.frame8.propentry <Button-3> {TP_PropsValueSel %W %X %Y client TPpropsToplevel}
  bind .tpwm.frame13.frame16.frame8.propentry <FocusOut> {TP_PropsToplevelSet %W client TPpropsToplevel}
  bind .tpwm.frame13.frame16.frame8.propentry <Key-KP_Enter> {TP_PropsToplevelSet %W client TPpropsToplevel}
  bind .tpwm.frame13.frame16.frame8.propentry <Key-Return> {TP_PropsToplevelSet %W client TPpropsToplevel}

  frame .tpwm.frame13.frame16.frame9  -background {#dcdcdc}  -height {24}  -highlightbackground {#e6e7e6}  -width {312}

  label .tpwm.frame13.frame16.frame9.propname  -activebackground {#e6e7e6}  -anchor {w}  -background {grey85}  -borderwidth {2}  -font {Helvetica 12}  -foreground {black}  -highlightbackground {#e6e7e6}  -text {Command:}  -width {16}

  entry .tpwm.frame13.frame16.frame9.propentry  -background {white}  -font {Helvetica 10}  -foreground {black}  -highlightbackground {#ffffff}  -selectbackground {#21449c}  -selectforeground {#ffffff}  -textvariable {TPpropsToplevel(wm_command)}  -width {21}
  # bindings
  bind .tpwm.frame13.frame16.frame9.propentry <Button-3> {TP_PropsValueSel %W %X %Y wm_command TPpropsToplevel}
  bind .tpwm.frame13.frame16.frame9.propentry <FocusOut> {TP_PropsToplevelSet %W wm_command TPpropsToplevel}
  bind .tpwm.frame13.frame16.frame9.propentry <Key-KP_Enter> {TP_PropsToplevelSet %W wm_command TPpropsToplevel}
  bind .tpwm.frame13.frame16.frame9.propentry <Key-Return> {TP_PropsToplevelSet %W wm_command TPpropsToplevel}

  frame .tpwm.frame13.frame16.frame10  -background {#dcdcdc}  -height {24}  -highlightbackground {#e6e7e6}  -width {312}

  label .tpwm.frame13.frame16.frame10.propname  -activebackground {#e6e7e6}  -anchor {w}  -background {grey85}  -borderwidth {2}  -font {Helvetica 12}  -foreground {black}  -highlightbackground {#e6e7e6}  -text {Group:}  -width {16}

  entry .tpwm.frame13.frame16.frame10.propentry  -background {white}  -font {Helvetica 10}  -foreground {black}  -highlightbackground {#ffffff}  -selectbackground {#21449c}  -selectforeground {#ffffff}  -textvariable {TPpropsToplevel(group)}  -width {21}
  # bindings
  bind .tpwm.frame13.frame16.frame10.propentry <Button-3> {TP_PropsValueSel %W %X %Y group TPpropsToplevel}
  bind .tpwm.frame13.frame16.frame10.propentry <FocusOut> {TP_PropsToplevelSet %W group TPpropsToplevel}
  bind .tpwm.frame13.frame16.frame10.propentry <Key-KP_Enter> {TP_PropsToplevelSet %W group TPpropsToplevel}
  bind .tpwm.frame13.frame16.frame10.propentry <Key-Return> {TP_PropsToplevelSet %W group TPpropsToplevel}

  frame .tpwm.frame13.frame16.frame18  -background {#dcdcdc}  -height {24}  -highlightbackground {#e6e7e6}  -width {312}

  label .tpwm.frame13.frame16.frame18.propname  -activebackground {#e6e7e6}  -anchor {w}  -background {grey85}  -borderwidth {2}  -font {Helvetica 12}  -foreground {black}  -highlightbackground {#e6e7e6}  -text {Transient:}  -width {16}

  entry .tpwm.frame13.frame16.frame18.propentry  -background {white}  -font {Helvetica 10}  -foreground {black}  -highlightbackground {#ffffff}  -selectbackground {#21449c}  -selectforeground {#ffffff}  -textvariable {TPpropsToplevel(transient)}  -width {21}
  # bindings
  bind .tpwm.frame13.frame16.frame18.propentry <Button-3> {TP_PropsValueSel %W %X %Y transient TPpropsToplevel}
  bind .tpwm.frame13.frame16.frame18.propentry <FocusOut> {TP_PropsToplevelSet %W transient TPpropsToplevel}
  bind .tpwm.frame13.frame16.frame18.propentry <Key-KP_Enter> {TP_PropsToplevelSet %W transient TPpropsToplevel}
  bind .tpwm.frame13.frame16.frame18.propentry <Key-Return> {TP_PropsToplevelSet %W transient TPpropsToplevel}

  frame .tpwm.frame13.frame17  -borderwidth {2}  -relief {raised}  -background {#dcdcdc}  -height {148}  -highlightbackground {#e6e7e6}  -width {300}

  frame .tpwm.frame13.frame17.frame3  -background {#dcdcdc}  -height {24}  -highlightbackground {#e6e7e6}  -width {310}

  label .tpwm.frame13.frame17.frame3.propname  -activebackground {#e6e7e6}  -anchor {w}  -background {grey85}  -borderwidth {2}  -font {Helvetica 12}  -foreground {black}  -highlightbackground {#e6e7e6}  -text {Icon bitmap:}  -width {16}

  entry .tpwm.frame13.frame17.frame3.propentry  -background {white}  -font {Helvetica 10}  -foreground {black}  -highlightbackground {#ffffff}  -selectbackground {#21449c}  -selectforeground {#ffffff}  -textvariable {TPpropsToplevel(iconbitmap)}  -width {21}
  # bindings
  bind .tpwm.frame13.frame17.frame3.propentry <Button-3> {TP_PropsValueSel %W %X %Y iconbitmap TPpropsToplevel}
  bind .tpwm.frame13.frame17.frame3.propentry <FocusOut> {TP_PropsToplevelSet %W iconbitmap TPpropsToplevel}
  bind .tpwm.frame13.frame17.frame3.propentry <Key-KP_Enter> {TP_PropsToplevelSet %W iconbitmap TPpropsToplevel}
  bind .tpwm.frame13.frame17.frame3.propentry <Key-Return> {TP_PropsToplevelSet %W iconbitmap TPpropsToplevel}

  frame .tpwm.frame13.frame17.frame4  -background {#dcdcdc}  -height {24}  -highlightbackground {#e6e7e6}  -width {310}

  label .tpwm.frame13.frame17.frame4.propname  -activebackground {#e6e7e6}  -anchor {w}  -background {grey85}  -borderwidth {2}  -font {Helvetica 12}  -foreground {black}  -highlightbackground {#e6e7e6}  -text {Icon mask:}  -width {16}

  entry .tpwm.frame13.frame17.frame4.propentry  -background {white}  -font {Helvetica 10}  -foreground {black}  -highlightbackground {#ffffff}  -selectbackground {#21449c}  -selectforeground {#ffffff}  -textvariable {TPpropsToplevel(iconmask)}  -width {21}
  # bindings
  bind .tpwm.frame13.frame17.frame4.propentry <Button-3> {TP_PropsValueSel %W %X %Y iconmask TPpropsToplevel}
  bind .tpwm.frame13.frame17.frame4.propentry <FocusOut> {TP_PropsToplevelSet %W iconmask TPpropsToplevel}
  bind .tpwm.frame13.frame17.frame4.propentry <Key-KP_Enter> {TP_PropsToplevelSet %W iconmask TPpropsToplevel}
  bind .tpwm.frame13.frame17.frame4.propentry <Key-Return> {TP_PropsToplevelSet %W iconmask TPpropsToplevel}

  frame .tpwm.frame13.frame17.frame5  -background {#dcdcdc}  -height {24}  -highlightbackground {#e6e7e6}  -width {310}

  label .tpwm.frame13.frame17.frame5.propname  -activebackground {#e6e7e6}  -anchor {w}  -background {grey85}  -borderwidth {2}  -font {Helvetica 12}  -foreground {black}  -highlightbackground {#e6e7e6}  -text {Icon name:}  -width {16}

  entry .tpwm.frame13.frame17.frame5.propentry  -background {white}  -font {Helvetica 10}  -foreground {black}  -highlightbackground {#ffffff}  -selectbackground {#21449c}  -selectforeground {#ffffff}  -textvariable {TPpropsToplevel(iconname)}  -width {21}
  # bindings
  bind .tpwm.frame13.frame17.frame5.propentry <Button-3> {TP_PropsValueSel %W %X %Y iconname TPpropsToplevel}
  bind .tpwm.frame13.frame17.frame5.propentry <FocusOut> {TP_PropsToplevelSet %W iconname TPpropsToplevel}
  bind .tpwm.frame13.frame17.frame5.propentry <Key-KP_Enter> {TP_PropsToplevelSet %W iconname TPpropsToplevel}
  bind .tpwm.frame13.frame17.frame5.propentry <Key-Return> {TP_PropsToplevelSet %W iconname TPpropsToplevel}

  frame .tpwm.frame13.frame17.frame6  -background {#dcdcdc}  -highlightbackground {#e6e7e6}

  label .tpwm.frame13.frame17.frame6.propname  -activebackground {#e6e7e6}  -anchor {w}  -background {grey85}  -borderwidth {2}  -font {Helvetica 12}  -foreground {black}  -highlightbackground {#e6e7e6}  -text {Icon position:}  -width {16}

  entry .tpwm.frame13.frame17.frame6.propentry  -background {white}  -font {Helvetica 10}  -foreground {black}  -highlightbackground {#ffffff}  -selectbackground {#21449c}  -selectforeground {#ffffff}  -textvariable {TPpropsToplevel(iconposition)}  -width {21}
  # bindings
  bind .tpwm.frame13.frame17.frame6.propentry <Button-3> {TP_PropsValueSel %W %X %Y iconposition TPpropsToplevel}
  bind .tpwm.frame13.frame17.frame6.propentry <FocusOut> {TP_PropsToplevelSet %W iconposition TPpropsToplevel}
  bind .tpwm.frame13.frame17.frame6.propentry <Key-KP_Enter> {TP_PropsToplevelSet %W iconposition TPpropsToplevel}
  bind .tpwm.frame13.frame17.frame6.propentry <Key-Return> {TP_PropsToplevelSet %W iconposition TPpropsToplevel}

  frame .tpwm.frame13.frame17.frame7  -background {#dcdcdc}  -height {24}  -highlightbackground {#e6e7e6}  -width {310}

  label .tpwm.frame13.frame17.frame7.propname  -activebackground {#e6e7e6}  -anchor {w}  -background {grey85}  -borderwidth {2}  -font {Helvetica 12}  -foreground {black}  -highlightbackground {#e6e7e6}  -text {Icon window:}  -width {16}

  entry .tpwm.frame13.frame17.frame7.propentry  -background {white}  -font {Helvetica 10}  -foreground {black}  -highlightbackground {#ffffff}  -selectbackground {#21449c}  -selectforeground {#ffffff}  -textvariable {TPpropsToplevel(iconwindow)}  -width {21}
  # bindings
  bind .tpwm.frame13.frame17.frame7.propentry <Button-3> {TP_PropsValueSel %W %X %Y iconwindow TPpropsToplevel}
  bind .tpwm.frame13.frame17.frame7.propentry <FocusOut> {TP_PropsToplevelSet %W iconwindow TPpropsToplevel}
  bind .tpwm.frame13.frame17.frame7.propentry <Key-KP_Enter> {TP_PropsToplevelSet %W iconwindow TPpropsToplevel}
  bind .tpwm.frame13.frame17.frame7.propentry <Key-Return> {TP_PropsToplevelSet %W iconwindow TPpropsToplevel}

  # pack master .tpwm.frame0
  pack configure .tpwm.frame0.label1  -side left
  pack configure .tpwm.frame0.label2  -side left

  # pack master .tpwm.frame12
  pack configure .tpwm.frame12.frame20  -fill x
  pack configure .tpwm.frame12.frame19  -fill x
  pack configure .tpwm.frame12.frame  -expand 1  -fill both

  # pack master .tpwm.frame12.frame
  pack configure .tpwm.frame12.frame.scrollbar1  -fill y  -side left
  pack configure .tpwm.frame12.frame.text2  -expand 1  -fill both
  pack configure .tpwm.frame12.frame.scrollbar3  -fill x

  # pack master .tpwm.frame12.frame19
  pack configure .tpwm.frame12.frame19.radiobutton14  -anchor w  -side left
  pack configure .tpwm.frame12.frame19.radiobutton15  -anchor w  -side left
  pack configure .tpwm.frame12.frame19.radiobutton16  -anchor w  -side left
  pack configure .tpwm.frame12.frame19.radiobutton17  -anchor w  -side left
  pack configure .tpwm.frame12.frame19.radiobutton18  -anchor w  -side left

  # pack master .tpwm.frame12.frame20
  pack configure .tpwm.frame12.frame20.label13  -anchor w  -side left
  pack configure .tpwm.frame12.frame20.label21  -side left
  pack configure .tpwm.frame12.frame20.button0  -side right

  # pack master .tpwm.frame23
  pack configure .tpwm.frame23.button4  -side left
  pack configure .tpwm.frame23.button8  -side right

  # pack master .tpwm.frame13
  pack configure .tpwm.frame13.frame16  -expand 1  -fill x  -side left
  pack configure .tpwm.frame13.frame17  -anchor n  -expand 1  -fill both  -side left

  # pack master .tpwm.frame13.frame16
  pack configure .tpwm.frame13.frame16.frame1  -anchor w
  pack configure .tpwm.frame13.frame16.frame2  -anchor w
  pack configure .tpwm.frame13.frame16.frame8  -anchor w
  pack configure .tpwm.frame13.frame16.frame9  -anchor w
  pack configure .tpwm.frame13.frame16.frame10  -anchor w
  pack configure .tpwm.frame13.frame16.frame18  -anchor w

  # pack master .tpwm.frame13.frame16.frame1
  pack configure .tpwm.frame13.frame16.frame1.propname  -side left
  pack configure .tpwm.frame13.frame16.frame1.propentry  -fill x  -padx 1  -side left

  # pack master .tpwm.frame13.frame16.frame2
  pack configure .tpwm.frame13.frame16.frame2.propname  -side left
  pack configure .tpwm.frame13.frame16.frame2.propentry  -fill x  -padx 1  -side left

  # pack master .tpwm.frame13.frame16.frame8
  pack configure .tpwm.frame13.frame16.frame8.propname  -side left
  pack configure .tpwm.frame13.frame16.frame8.propentry  -fill x  -padx 1  -side left

  # pack master .tpwm.frame13.frame16.frame9
  pack configure .tpwm.frame13.frame16.frame9.propname  -side left
  pack configure .tpwm.frame13.frame16.frame9.propentry  -fill x  -padx 1  -side left

  # pack master .tpwm.frame13.frame16.frame10
  pack configure .tpwm.frame13.frame16.frame10.propname  -side left
  pack configure .tpwm.frame13.frame16.frame10.propentry  -fill x  -padx 1  -side left

  # pack master .tpwm.frame13.frame16.frame18
  pack configure .tpwm.frame13.frame16.frame18.propname  -side left
  pack configure .tpwm.frame13.frame16.frame18.propentry  -fill x  -padx 1  -side left

  # pack master .tpwm.frame13.frame17
  pack configure .tpwm.frame13.frame17.frame3  -anchor w
  pack configure .tpwm.frame13.frame17.frame4  -anchor w
  pack configure .tpwm.frame13.frame17.frame5  -anchor w
  pack configure .tpwm.frame13.frame17.frame6  -anchor w
  pack configure .tpwm.frame13.frame17.frame7  -anchor w

  # pack master .tpwm.frame13.frame17.frame3
  pack configure .tpwm.frame13.frame17.frame3.propname  -side left
  pack configure .tpwm.frame13.frame17.frame3.propentry  -fill x  -padx 1  -side left

  # pack master .tpwm.frame13.frame17.frame4
  pack configure .tpwm.frame13.frame17.frame4.propname  -side left
  pack configure .tpwm.frame13.frame17.frame4.propentry  -fill x  -padx 1  -side left

  # pack master .tpwm.frame13.frame17.frame5
  pack configure .tpwm.frame13.frame17.frame5.propname  -side left
  pack configure .tpwm.frame13.frame17.frame5.propentry  -fill x  -padx 1  -side left

  # pack master .tpwm.frame13.frame17.frame6
  pack configure .tpwm.frame13.frame17.frame6.propname  -side left
  pack configure .tpwm.frame13.frame17.frame6.propentry  -fill x  -padx 1  -side left

  # pack master .tpwm.frame13.frame17.frame7
  pack configure .tpwm.frame13.frame17.frame7.propname  -side left
  pack configure .tpwm.frame13.frame17.frame7.propentry  -fill x  -padx 1  -side left

  # pack master .tpwm
  pack configure .tpwm.frame0  -fill x
  pack configure .tpwm.frame13  -fill x
  pack configure .tpwm.frame12  -expand 1  -fill both
  pack configure .tpwm.frame23  -fill x

  .tpwm.frame12.frame.text2 insert end {}

EndSrc.tpwm
}

proc DestroyWindow.tpwm {} {
     catch "destroy .tpwm"
     update
}

proc EndSrc.tpwm {} {
# Fill in the current values
global TPpropsToplevel
global TPcurToplevel

wm iconphoto .tpwm tplogo16
set TPtopMsg {}
set TPselBoundProc TPendSrc
.tpwm.frame12.frame19.radiobutton15 invoke
if {[TP_ClassGet $TPcurToplevel] == {Toplevel}} {
    foreach propname {title focusmodel client group transient iconbitmap iconmask iconname iconposition iconwindow} {
	  set TPpropsToplevel($propname) [wm $propname $TPcurToplevel]
	}
    set TPpropsToplevel(wm_command) [wm command $TPcurToplevel]
    TP_SnapshotToplevel $TPcurToplevel
  }
}


proc ShowWindow.tpStdTemplates {} {
	StartupSrc.tpStdTemplates
	set wname .tpStdTemplates
	if {[winfo exists $wname]} { return {} } 

	toplevel .tpStdTemplates -background {#eff0f1} -highlightbackground {#eff0f1} -highlightcolor {#31363b}
    wm iconphoto .tpStdTemplates tplogo16

	bindtags .tpStdTemplates {.tpStdTemplates Toplevel all}
	wm title .tpStdTemplates {Standard TKproE Templates}
	wm aspect .tpStdTemplates 
	wm focusmodel .tpStdTemplates passive
	wm grid .tpStdTemplates 
	wm geometry .tpStdTemplates 305x256+160+43
	wm iconmask .tpStdTemplates 
	wm iconposition .tpStdTemplates 
	wm maxsize .tpStdTemplates 3825 1050
	wm minsize .tpStdTemplates 350 242
	wm overrideredirect .tpStdTemplates 0
	wm positionfrom .tpStdTemplates user
	wm resizable .tpStdTemplates 1 1
	wm sizefrom .tpStdTemplates 
	wm state .tpStdTemplates normal
	wm transient .tpStdTemplates 
	wm protocol .tpStdTemplates WM_DELETE_WINDOW {set ::TPtemplateList {}
	DestroyWindow.tpStdTemplates}


	frame .tpStdTemplates.frame -background {#eff0f1} -highlightbackground {#eff0f1} -highlightcolor {#31363b}

	bindtags .tpStdTemplates.frame {.tpStdTemplates .tpStdTemplates.frame Frame all}

	listbox .tpStdTemplates.frame.listbox1 -background {white} -borderwidth {2} -font {Helvetica 10} -foreground {#31363b} -highlightbackground {#fcfcfc} -highlightcolor {#31363b} -relief {ridge} -selectbackground {#3daee9} -selectforeground {#eff0f1} -yscrollcommand {.tpStdTemplates.frame.scrollbar2 set} -listvariable {TPtemplateList}

	bindtags .tpStdTemplates.frame.listbox1 {.tpStdTemplates .tpStdTemplates.frame.listbox1 Listbox all}
	.tpStdTemplates.frame.listbox1 insert end calendar.tcl CanvasLS.tcl CanvasRS.tcl EntryL.tcl EntryLLS.tcl EntryLS.tcl EntryS.tcl ListboxLS.tcl ListboxRS.tcl TextLS.tcl TextRO.tcl TextROLS.tcl TextRORS.tcl TextRS.tcl Tktable.tcl calendar.tcl CanvasLS.tcl CanvasRS.tcl EntryL.tcl EntryLLS.tcl EntryLS.tcl EntryS.tcl ListboxLS.tcl ListboxRS.tcl TextLS.tcl TextRO.tcl TextROLS.tcl TextRORS.tcl TextRS.tcl Tktable.tcl
	pack .tpStdTemplates.frame.listbox1 -anchor center -expand 1 -fill both -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top


	scrollbar .tpStdTemplates.frame.scrollbar2 -activebackground {#eff0f1} -background {#eff0f1} -command {.tpStdTemplates.frame.listbox1 yview} -cursor {left_ptr} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -relief {raised} -troughcolor {#eff0f1} -width {12}

	bindtags .tpStdTemplates.frame.scrollbar2 {.tpStdTemplates .tpStdTemplates.frame.scrollbar2 Scrollbar all}
	pack .tpStdTemplates.frame.scrollbar2 -anchor center -expand 0 -fill y -ipadx 0 -ipady 0 -padx 0 -pady 0 -side right

	pack .tpStdTemplates.frame -anchor center -expand 1 -fill both -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
	pack .tpStdTemplates.frame.scrollbar2 .tpStdTemplates.frame.listbox1 -in .tpStdTemplates.frame


	frame .tpStdTemplates.frame1 -borderwidth {2} -background {#eff0f1} -height {30} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -width {30}

	bindtags .tpStdTemplates.frame1 {.tpStdTemplates .tpStdTemplates.frame1 Frame all}

	button .tpStdTemplates.frame1.button0 -activebackground {#eff0f1} -activeforeground {#31363b} -background {#eff0f1} -command {DestroyWindow.tpStdTemplates} -font {Helvetica 10 bold} -foreground {#31363b} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -state {normal} -text {Done} -width {8}

	bindtags .tpStdTemplates.frame1.button0 {.tpStdTemplates .tpStdTemplates.frame1.button0 Button all}
	pack .tpStdTemplates.frame1.button0 -anchor w -expand 1 -fill none -ipadx 0 -ipady 0 -padx 5 -pady 0 -side left


	button .tpStdTemplates.frame1.button2 -activebackground {#eff0f1} -activeforeground {#31363b} -background {#eff0f1} -command {set TPtemp [.tpStdTemplates.frame.listbox1 curselection]
	if {$TPtemp ne {}} {
		set TPtemp [.tpStdTemplates.frame.listbox1 get $TPtemp]
		if {[info exists TPtemplate($TPtemp)]} {
		   set TPcutBuffer $TPtemplate($TPtemp)
		   if {$TPtemplateAction eq {Insert}} {
			   TP_ActionBtnPaste $TPcurPath
			  }
		  }
	  }} -font {Helvetica 10 bold} -foreground {#31363b} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -text {Insert} -textvariable {TPtemplateAction} -width {8}

	bindtags .tpStdTemplates.frame1.button2 {.tpStdTemplates .tpStdTemplates.frame1.button2 Button all}
	pack .tpStdTemplates.frame1.button2 -anchor e -expand 1 -fill none -ipadx 0 -ipady 0 -padx 5 -pady 0 -side left


	.tpStdTemplates.frame1.button0 configure -state {active}
	pack .tpStdTemplates.frame1 -anchor center -expand 0 -fill x -ipadx 0 -ipady 0 -padx 0 -pady 0 -side bottom
	pack .tpStdTemplates.frame1.button2 .tpStdTemplates.frame1.button0 -in .tpStdTemplates.frame1


	label .tpStdTemplates.label0 -activebackground {#eff0f1} -activeforeground {#31363b} -background {#eff0f1} -borderwidth {2} -font {times 12 bold} -foreground {black} -highlightbackground {#eff0f1} -highlightcolor {#31363b} -text {Select template to insert into current widget path} -textvariable {TPselectTemplateTitle}

	bindtags .tpStdTemplates.label0 {.tpStdTemplates .tpStdTemplates.label0 Label all}
	pack .tpStdTemplates.label0 -anchor w -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top

	pack .tpStdTemplates.label0 .tpStdTemplates.frame .tpStdTemplates.frame1 -in .tpStdTemplates
   }
   
proc DestroyWindow.tpStdTemplates {} {
     set ::TPtemplateList {}
     catch {destroy .tpStdTemplates}
     update
   }

proc StartupSrc.tpStdTemplates {} {
set ::TPtemplateList [lsort -dictionary [array names ::TPtemplate]]
if {[info exists ::TPtemplateAction]} {
    set action $::TPtemplateAction
   } { set action Load }
if {$::TPtemplateAction  eq {Insert}} {
    set ::TPselectTemplateTitle {Select template to insert into current widget path}
  } { set ::TPselectTemplateTitle {Select template to load into cut buffer} }
}

# Procedure: TP_ActionBtnCopy
proc TP_ActionBtnCopy {} {
global TPcutBuffer
global TPcurPath

if {$TPcurPath != {.}} {
    set TPcutBuffer [TP_Clone_TKwidget $TPcurPath]
    if {[TP_ClassGet $TPcurPath] ==  {Toplevel}} {
        # Add special procedures for toplevels
        foreach prefix {TPcloseWindow TPstartupSrc TPendSrc} {
	       set procname $prefix$TPcurPath
	       if {[string length [info proc $procname]] > 0} {
		append TPcutBuffer "\nproc $procname \{\} \{\n"
		append TPcutBuffer [string trimleft [info body $procname] \n]
		append TPcutBuffer "\n\}\n\n"
	          }
	    }
       }
   }
}


# Procedure: TP_ActionBtnCut
proc TP_ActionBtnCut {} {
global TPcutBuffer
global TPcurPath

if {$TPcurPath != {.}} {
    set TPcutBuffer [TP_Clone_TKwidget $TPcurPath]
    if {[TP_ClassGet $TPcurPath] ==  {Toplevel}} {
        # Add special procedures for toplevels
        foreach prefix {TPcloseWindow TPstartupSrc TPendSrc} {
	       set procname $prefix$TPcurPath
	       if {[string length [info proc $procname]] > 0} {
		append TPcutBuffer "\nproc $procname \{\} \{\n"
		append TPcutBuffer [string trimleft [info body $procname] \n]
		append TPcutBuffer "\n\}\n\n"
	          }
	    }
      }
    if {[string length $TPcutBuffer] > 0} {
        after 100 "TP_WindowDestroy $TPcurPath"
        TP_PathMenuCreate [winfo parent $TPcurPath]
      }
   }
}


# Procedure: TP_ActionBtnDelete
proc TP_ActionBtnDelete {} {
global TPcurPath
global TPmessage
global TPmsgCmd
global TPmsgButtons

if {$TPcurPath != {.}} {
    set TPtemp [TP_Clone_TKwidget $TPcurPath]
    if {[string length $TPtemp] > 0} {
        set TPtemp $TPcurPath
        set TPmessage "Do you really want to delete widget\n$TPtemp\nand all of its children?"
        set TPmsgCmd(Yes) "after 100 \{TP_WindowDestroy $TPtemp\}; set TPmsgCmd(Yes) {}; set TPmsgCmd(No) {}; set TPmsgButtons {}; TP_PathMenuCreate [winfo parent $TPtemp]"
        set TPmsgCmd(No) "set TPmsgCmd(Yes) {}; set TPmsgCmd(No) {}; set TPmsgButtons {}"
        set TPmsgButtons {Yes No}
        ShowWindow.tpmsgbox
      }
   }
}


# Procedure: TP_ActionBtnPaste
proc TP_ActionBtnPaste { wname} {
# Paste the widget found in the cutbuffer into the specified window.
global TPpasteBuffer
global TPcutBuffer

if {[winfo exists $wname]} {
    # Verify that the cutbuffer contains a widget definition.
    set orgPath {}
    set isToplevel 0
    # Check for a non-toplevel window definition.
    regexp {(# ClonePath = )([[:graph:]]*)} $TPcutBuffer result result1 orgPath
    if {[string length $orgPath] == 0} {
        # The cutbuffer may contain a toplevel window definition.
        regexp {(# CLONEPATH = )([[:graph:]]*)} $TPcutBuffer result result1 orgPath
        set isToplevel 1
       }
    if {[string length $orgPath] > 1} {
        # Determine base widget name.
        # Use "file extension" command for something not originally intended. Pretty tricky, yes?
        set baseWidget [file extension $orgPath]

        # Create new pasted widget path.
        if {$wname == {.} || $isToplevel} {
            set newPath $baseWidget
          } { set newPath $wname$baseWidget }

        # Determine whether new path already exists.
        if {[winfo exists $newPath]} {
            # The widget path already exists. We need to come up with a new base path.
#LISSI
            set trialPath [string trimright $newPath 0123456789]
#            set trialPath [string trimright $newPath ABCabcXYZx]

            set ctr 0
            while {$ctr < 100} {
                      set newPath $trialPath$ctr
                      if {[winfo exists $newPath]} {
                          incr ctr
                         } { set ctr 200 }
                    }
             if {$ctr < 200} { return {} }
          }

        # Replace original widget parent with new destination parent.
        set orgPath [regsub -all {[.]} $orgPath {\.}]
        set TPpasteBuffer [regsub -all "(\[^a-zA-Z0-9_.\])($orgPath)" $TPcutBuffer "\\1$newPath"]

        # Rename any special procedures
        foreach prefix {TPopenWindow TPcloseWindow TPstartupSrc TPendSrc} {
	      set TPpasteBuffer [regsub -all "($prefix$orgPath)" $TPpasteBuffer "$prefix$newPath"]
	   }

        # Create the new widget.
        if {[catch {uplevel #0 $TPpasteBuffer} result]} {
	puts $result
	puts $TPpasteBuffer
          } {
		switch [TP_ClassGet $wname] {
			TPanedwindow -
			Panedwindow	{
					  # Add the new widget to the pane.
					  $wname add $newPath
					}
			Text		{
					  # Create a window object for the new widget if pasting into a Text object.
					  $wname window create insert -window $newPath
					}
	    }	       }
      }
  }
}


# Procedure: TP_AddNewObj
proc TP_AddNewObj { objtype} {
global TPnextObjType
global TPnextObjName
global TPnextObj
global TPcurPath
global TPnewObjNameAsk

set TPnextObjType $objtype
if {$objtype == {}} {
    set TPnextObjName {}
  } {
      if {[string index $objtype 0] eq {T}} {
          set prefix [string range $objtype 1 end]
         } { set prefix $objtype }
      set TPnextObjName ${prefix}$TPnextObj
      incr TPnextObj
      if {$TPcurPath == {.}} {
          set prefix .
         } { set prefix $TPcurPath. }

      # Check to see whether a widget with the auto-selected name already exists. 
      while {[winfo exists $prefix$TPnextObjName]} {
	 set TPnextObjName ${prefix}$TPnextObj
	 incr TPnextObj
            }

      if {$TPnewObjNameAsk} {
          ShowWindow.tpGetObjName
         } { TP_CreateNewObj }
    }
}


# Procedure: TP_AutoSave
proc TP_AutoSave {} {
# Save the current application status to temporary storage.
global TPsaveInterval
global TPsaveDir
global TPinfo

ShowWindow.tpautosave
after 100
update

# Write the application to file.
set filename [file join $TPsaveDir TPsave[clock seconds].tcl]
set outstr [TP_Clone_app]
if {[string length $outstr] > 0} {
    if {[catch {open $filename w} fout]} {
         set fout {}
         set TPstatusLine "Automatic backup to $filename failed"
       } {
           puts $fout "# TKproE $TPinfo(revision) Auto-save"
           puts -nonewline $fout $outstr
           close $fout
         }
   }

DestroyWindow.tpautosave
after $TPsaveInterval TP_AutoSave
}


# Procedure: TP_B1_motion
proc TP_B1_motion { cname xpos ypos} {
global TPB1_motion_list
global TPtoolpath

#if {$cname != $TPtoolpath} {return}
foreach tool $TPB1_motion_list {
	switch $tool {
		conpipe	{TP_DTconnect_resize $cname $xpos $ypos}
		group	{TP_DTgroup_resize   $cname $xpos $ypos}
		move	{TP_move_group   $cname $xpos $ypos}
		objmove	{TP_DTobj_move     $cname $xpos $ypos}
		stretch	{TP_stretch_move $cname $xpos $ypos}
	     }
      }
}


# Procedure: TP_B1_press
proc TP_B1_press { cname xpos ypos} {
global TPB1_press_list
global TPgroupboxid
global TPtoolpath
global TPobjaddfirst
global TPobjdelfirst

#if {$cname != $TPtoolpath} {return}
foreach tool $TPB1_press_list {
	switch $tool {
		copy	{
		#LISSI
		    global TPMove
		    set TPMove(firstX) $xpos
		    set TPMove(firstY) $ypos
		    set TPMove(lastX) $xpos
		    set TPMove(lastY) $ypos

			  TP_copy_group    $cname $xpos $ypos
			  $cname delete $TPgroupboxid
			}
		conpipe	{TP_DTconnect_start $cname $xpos $ypos}
		ID	{ TP_DTidentify $cname $xpos $ypos }
		group	{TP_DTgroup_start   $cname $xpos $ypos}
		move	{
		#LISSI
		    global TPMove
		    set TPMove(firstX) $xpos
		    set TPMove(firstY) $ypos
		    set TPMove(lastX) $xpos
		    set TPMove(lastY) $ypos

		TP_move_group    $cname $xpos $ypos
		}
		onemove {
			 TP_DTone_start $cname $xpos $ypos
			 TP_move_group $cname $xpos $ypos
			}
		objadd	{
			  if {$TPobjaddfirst} {
			      TP_DTobj_select $cname
			      set TPobjaddfirst 0
			     }
			  TP_DTobj_add $cname
			}
		objmove	{ TP_DTobj_start $cname $xpos $ypos }
		objdel	{
			  if {$TPobjdelfirst} {
			      TP_DTobj_select $cname
			      set TPobjdelfirst 0
			     }
			  TP_DTobj_delete    $cname
			}
		pop	{ TP_DTpop $cname $xpos $ypos }
		push	{ TP_DTpush $cname $xpos $ypos }
		stretch	{TP_stretch_start $cname $xpos $ypos}
		saveoneimage {
		#LISSI
			 TP_DTone_start $cname $xpos $ypos
		}
		saveonefile {
		#LISSI
			 TP_DTone_start $cname $xpos $ypos
		}
	     }
      }
}


# Procedure: TP_B1_release
proc TP_B1_release { cname xpos ypos} {
global TPB1_press_list
global TPB1_motion_list
global TPB1_release_list
global TPgroupboxid
global TPtoolpath
global TPcurCanvas

#if {$cname != $TPtoolpath} {return}
foreach tool $TPB1_release_list {
	switch $tool {
		conpipe	{ TP_DTconnect_stop $cname $xpos $ypos}
		copy	{
			  set TPgroupboxid [$cname find withtag groupbox]
			  TP_DTgroup_stop $cname $xpos $ypos
			  set TPB1_press_list [TP_DTldelete $TPB1_press_list group]
			  set TPB1_motion_list [TP_DTldelete $TPB1_motion_list group]
			  set TPB1_release_list [TP_DTldelete $TPB1_release_list copy]
			  if {[lsearch $TPB1_press_list copy] == -1} {lappend TPB1_press_list copy}
			  if {[lsearch $TPB1_motion_list move] == -1} {lappend TPB1_motion_list move}
			  if {[lsearch $TPB1_release_list endcopy] == -1} {lappend TPB1_release_list endcopy}
			}
		endcopy	{
			  $cname delete groupbox
			  set TPB1_press_list [TP_DTldelete $TPB1_press_list copy]
			  set TPB1_motion_list [TP_DTldelete $TPB1_motion_list move]
			  set TPB1_release_list [TP_DTldelete $TPB1_release_list endcopy]
			  TP_copy_bind $cname
			  TP_CanvasObjListFill $TPcurCanvas
			}
		endmove {
			  $cname delete groupbox
			  set TPB1_press_list [TP_DTldelete $TPB1_press_list move]
			  set TPB1_motion_list [TP_DTldelete $TPB1_motion_list move]
			  set TPB1_release_list [TP_DTldelete $TPB1_release_list endmove]
			  TP_move_bind $cname
			}
		endonemove {
			  $cname delete groupbox
			  set TPB1_press_list [TP_DTldelete $TPB1_press_list onemove]
			  set TPB1_motion_list [TP_DTldelete $TPB1_motion_list move]
			  set TPB1_release_list [TP_DTldelete $TPB1_release_list endonemove]
			  TP_DTonemove_bind $cname
			}
		delete	{
			  TP_DTgroup_stop $cname $xpos $ypos
			  TP_delete_group $cname
			  #TP_move_bind $cname
			  TP_CanvasObjListFill $TPcurCanvas
			}
		move	{
			  TP_DTgroup_stop $cname $xpos $ypos
			  set TPB1_press_list [TP_DTldelete $TPB1_press_list group]
			  set TPB1_motion_list [TP_DTldelete $TPB1_motion_list group]
			  set TPB1_release_list [TP_DTldelete $TPB1_release_list move]
			  if {[lsearch $TPB1_press_list move] == -1} {lappend TPB1_press_list move}
			  if {[lsearch $TPB1_motion_list move] == -1} {lappend TPB1_motion_list move}
			  if {[lsearch $TPB1_release_list endmove] == -1} {lappend TPB1_release_list endmove}
			}
		objmove	{TP_DTobj_move     $cname $xpos $ypos}
		stretch	{TP_stretch_stop}
		endsaveoneimage {
		    #LISSI
			  global TPbboxL
			  set TPbboxL [$TPtoolpath bbox groupbox]
			  #Здесь вызов функции
			  TP_saveOneImage 1
			  $cname delete groupbox
			  set TPB1_press_list [TP_DTldelete $TPB1_press_list saveoneimage]
			  set TPB1_motion_list [TP_DTldelete $TPB1_motion_list move]
			  set TPB1_release_list [TP_DTldelete $TPB1_release_list endsaveoneimage]
			  TP_DTsaveoneimage_bind $cname
			}
		endsaveonefile {
		    #LISSI
			  global TPbboxL
			  set TPbboxL [$TPtoolpath bbox groupbox]
			  #Здесь вызов функции
			  TP_saveOneImage 0
			  $cname delete groupbox
			  set TPB1_press_list [TP_DTldelete $TPB1_press_list saveoneimage]
			  set TPB1_motion_list [TP_DTldelete $TPB1_motion_list move]
			  set TPB1_release_list [TP_DTldelete $TPB1_release_list endsaveonefile]
			  TP_DTsaveoneimage_bind $cname
			}


	     }
      }
}


# Procedure: TP_BindEventAdd
proc TP_BindEventAdd { tag newevent} {
# Add the new event to the specified tag and return the new tag.
set rtnval $tag
if {[string length $tag] == 0} {
    set rtnval "<$newevent>"
  } elseif {[regexp {\A<.*>\Z} $tag]} {
	set rtnval [string replace $tag end end "-$newevent>"]
            }

return $rtnval
}


# Procedure: TP_BindListFill
proc TP_BindListFill { wname lname {isCanvasItem "0"}} {
# Fill the specified listbox (lname) with the list of current bindings for the specified widget (wname).
global TPcvbindID

if {[winfo exists $lname]} {
    if {[TP_ClassGet $lname] eq {Listbox}} {
        $lname delete 0 end
        if {$isCanvasItem} {
	if {[winfo exists $wname]} {
	    set tagID [$wname find withtag $TPcvbindID]
	    if {$tagID != {}} {
	        set bindlist [lsort [$wname bind $TPcvbindID]]
	        foreach sequence $bindlist {
		      set cmd [$wname bind $TPcvbindID $sequence]
		      $lname insert end $sequence
		   }
	       }
	   }
           } {
	 set bindlist [lsort [bind $wname]]
	 foreach sequence $bindlist {
		set cmd [bind $wname $sequence]
		$lname insert end $sequence
	       }
	}
      }
  }
}


# Procedure: TP_BindSnapshot
proc TP_BindSnapshot { wname} {
# Take a snapshot of the bindings assigned to the specified widget.
global TPbindSnapshot

if {[winfo exists $wname]} {
   array unset TPbindSnapshot
   set taglist [bind $wname]
   foreach tag $taglist {
	 set TPbindSnapshot($tag) [bind $wname $tag]
            }
  }
}


# Procedure: TP_BindSnapshotRestore
proc TP_BindSnapshotRestore { wname} {
# Restore the event bindings for the specified widget (wname) to those stored in TPbindSnapshot
global TPbindSnapshot

if {[winfo exists $wname]} {
    # Remove current bindings.
    set bindlist [lsort [bind $wname]]
    foreach tag $bindlist {
	    bind $wname $tag {}
          }

    # Re-create original bindings.
    set bindlist [array names TPbindSnapshot]
    foreach tag $bindlist {
	  bind $wname $tag $TPbindSnapshot($tag)
	}
  }
}


# Procedure: TP_CVbindSnapshot
proc TP_CVbindSnapshot { wname objID} {
# Take a snapshot of the bindings assigned to the specified canvas object.
global TPcvBindSnapshot

if {[winfo exists $wname]} {
   array unset TPcvBindSnapshot
   set taglist [$wname bind $objID]
   foreach tag $taglist {
	 set TPcvBindSnapshot($tag) [$wname bind $objID $tag]
            }
  }
}


# Procedure: TP_CVbindSnapshotRestore
proc TP_CVbindSnapshotRestore { wname objID} {
# Restore the event bindings for the specified canvas object to those stored in TPcvBindSnapshot
global TPcvBindSnapshot

if {[winfo exists $wname]} {
    # Remove current bindings.
    set bindlist [lsort [$wname bind $objID]]
    foreach tag $bindlist {
	    $wname bind $objID $tag {}
          }

    # Re-create original bindings.
    set bindlist [array names TPcvBindSnapshot]
    foreach tag $bindlist {
	  $wname bind $objID $tag $TPcvBindSnapshot($tag)
	}
  }
}


# Procedure: TP_CVcoordAdjust
proc TP_CVcoordAdjust { direction wname} {
# Adjust the provided X,Y coordinates by one pixel in the specified direction.
global TPcurCanvas
global TPcanvasID

set newCoords {}
if {[winfo exists $wname]} {
    set coords [$wname get 1.0 end]
    foreach {xpos ypos} $coords {
	    if {[string is double -strict $xpos] && [string is double -strict $ypos]} {
	         switch $direction {
		      up		{ set ypos [expr $ypos - 1] }
		      down		{ set ypos [expr $ypos + 1] }
		      left		{ set xpos [expr $xpos - 1] }
		      right		{ set xpos [expr $xpos + 1] }
		      accept	{}
		      default	{ return {} }
		    }
	          lappend newCoords $xpos $ypos
	       }
              }
     $wname delete 1.0 end
     $wname insert end $newCoords

     if {[winfo exists $TPcurCanvas] && ($TPcanvasID != {})} {
          $TPcurCanvas coords $TPcanvasID $newCoords
        }
   }
return {}
}


# Procedure: TP_CVpropsGetList
proc TP_CVpropsGetList { wname objID {listType "standard"}} {
# This proc returns a list of the standard properties associated with the specified canvas object
global TPcvPropsStandardList

set standardList {}
set specificList {}
set exclusionList {tags}
if {[winfo exists $wname]} {
    set proplist [$wname itemconfigure $objID]
    foreach propinfo $proplist {
	  if {[llength $propinfo] == 5} {
	      set propname [string range [lindex $propinfo 0] 1 end]
	       if {[lsearch $TPcvPropsStandardList $propname] < 0} {
		if {[lsearch $exclusionList $propname] < 0} {
		    lappend specificList $propname
		   }
	          } {
		lappend standardList $propname
	            }
	     }
	}
   }
switch $listType {
	standard	{ set rtnval $standardList }
	specific	{ set rtnval $specificList }
	default	{ set rtnval $standardList }
        }

return $rtnval
}


# Procedure: TP_CVpropsShowHide
proc TP_CVpropsShowHide { wname} {
# Expand or shrink the canvas properties display of the specified section
global TPcurCanvas
global TPcvPropsStandard
global TPcvPropsSpecific
global TPcvPropsInfo
global TPcanvasID

if {[winfo exists $TPcurCanvas] == 0} { return }
set labeltext [$wname cget -text]
set Usection [lindex $labeltext 0]
set section [string tolower $Usection]
set parent [winfo parent $wname]
switch $section {
	standard	{
		  set action [string index $labeltext 18]
		  set fname $parent.props$section
		  if {$action == {+}} {
		        if {$TPcanvasID == {}} { return }
		        frame $fname -borderwidth 0
		        pack $fname -after $wname -side top -anchor w
		        set proplist [lsort [TP_CVpropsGetList $TPcurCanvas $TPcanvasID]]
		        set ctr 0
		        if {$proplist != {}} {
			foreach propname $proplist {
				incr ctr
				set rowname $fname.stdframe$ctr
				frame $rowname
				pack $rowname -side top -anchor w
				set proplabel $rowname.propname
				label $proplabel -text $propname -relief flat -anchor w -width 16 -font {Helvetica 12} -background grey85 -foreground black
				pack $proplabel -side left
				set propentry $rowname.propentry
				set action [lindex $TPcvPropsInfo($propname) 0]
				if {$action == {int}} {
				       foreach {action fromvalue tovalue} $TPcvPropsInfo($propname) {}
				       spinbox $propentry -textvariable TPcvPropsStandard($propname) -command "TP_CVpropsValueSet $propentry $propname TPcvProps$Usection" -to $tovalue -from $fromvalue -relief sunken -width 19 -font {Helvetica 10} -background white -foreground black
				       pack $propentry -side left -fill x -ipadx 3
				   } {
				       entry $propentry -textvariable TPcvPropsStandard($propname) -relief sunken -width 21 -font {Helvetica 10} -background white -foreground black
				       pack $propentry -side left -fill x -padx 1
				     }
				set TPcvPropsStandard($propname) [$TPcurCanvas itemcget $TPcanvasID -$propname]
				bind $propentry <Button-3> "TP_CVpropsValueSel %W %X %Y $propname TPcvProps$Usection"
				bind $propentry <FocusOut> "TP_CVpropsValueSet %W $propname TPcvProps$Usection"
				bind $propentry <Key-Return> "TP_CVpropsValueSet %W $propname TPcvProps$Usection"
				bind $propentry <Key-KP_Enter> "TP_CVpropsValueSet %W $propname TPcvProps$Usection"
			         }
		           }
		        $wname configure -text {Standard Options (-)}
		    } {
		        # Contract the Standard Options display
		        TP_WindowDestroy $fname
		        catch {unset TPcvPropsStandard}
		        $wname configure -text {Standard Options (+)}
		      }
		}
	specific	{
		  set action [string index $labeltext 18]
		  set fname $parent.props$section
		  if {$action == {+}} {
		        if {$TPcanvasID == {}} { return }
		        frame $fname -borderwidth 0
		        pack $fname -after $wname -side top -anchor w
		        set proplist [lsort [TP_CVpropsGetList $TPcurCanvas $TPcanvasID specific]]
		        set ctr 0
		        if {$proplist != {}} {
			foreach propname $proplist {
				incr ctr
				set rowname $fname.specframe$ctr
				frame $rowname
				pack $rowname -side top -anchor w
				set proplabel $rowname.propname
				label $proplabel -text $propname -relief flat -anchor w -width 16 -font {Helvetica 12} -background grey85 -foreground black
				pack $proplabel -side left
				set propentry $rowname.propentry
				if {[catch {lindex $TPcvPropsInfo($propname) 0} action]} { set action {} }
				if {$action == {int}} {
				       foreach {action fromvalue tovalue} $TPcvPropsInfo($propname) {}
				       spinbox $propentry -textvariable TPcvPropsSpecific($propname) -command "TP_CVpropsValueSet $propentry $propname TPcvProps$Usection" -to $tovalue -from $fromvalue -relief sunken -width 19 -font {Helvetica 10} -background white -foreground black
				       pack $propentry -side left -fill x -ipadx 3
				   } {
				       entry $propentry -textvariable TPcvPropsSpecific($propname) -relief sunken -width 21 -font {Helvetica 10} -background white -foreground black
				       pack $propentry -side left -fill x -padx 1
				     }
				set TPcvPropsSpecific($propname) [$TPcurCanvas itemcget $TPcanvasID -$propname]
				bind $propentry <Button-3> "TP_CVpropsValueSel %W %X %Y $propname TPcvProps$Usection"
				bind $propentry <FocusOut> "TP_CVpropsValueSet %W $propname TPcvProps$Usection"
				bind $propentry <Key-Return> "TP_CVpropsValueSet %W $propname TPcvProps$Usection"
				bind $propentry <Key-KP_Enter> "TP_CVpropsValueSet %W $propname TPcvProps$Usection"
			         }
		           }
		        $wname configure -text {Specific Options (-)}
		    } {
		        # Contract the Specific Options display
		        TP_WindowDestroy $fname
#LISSI
#		        unset TPcvPropsSpecific
		        catch {unset TPcvPropsSpecific}

		        $wname configure -text {Specific Options (+)}
		      }
		}
        }
}


# Procedure: TP_CVpropsValueSel
proc TP_CVpropsValueSel { wname xpos ypos propname Arrayvar} {
global TPcvPropsInfo
global TPcolor
global TPcvPropsStandard
global TPcvPropsSpecific
global TPfontCmd
global TPcurCanvas
global TPcanvasID
global TPcolorCmd
global TPimgCmd
global TPcurMenu
global TPcurWidget
global TPcfgCmd
global TPtxtCmd
global TPvarCmd

if {[winfo exists $wname]} { focus $wname }
set TPcfgCmd {$TPcurCanvas itemconfigure $TPcanvasID}
if {[info exists TPcvPropsInfo($propname)]} {
    set action [lindex $TPcvPropsInfo($propname) 0]
    switch $action {
	color	{
		  set TPcolor(varname) "$Arrayvar\($propname\)"
		  set TPcolorCmd "$TPcurCanvas itemconfigure $TPcanvasID -$propname"
		  ShowWindow.tpcolorsel
		  upvar #0 $TPcolor(varname) colorval
		  catch "TP_ColorSetSample $colorval"
		}
	bool -
	enum	{
		  TP_MenuEnum $wname $xpos $ypos $propname "$Arrayvar\($propname\)" [lrange $TPcvPropsInfo($propname) 1 end]
		}
	file	{
		  set filename [tk_getOpenFile -title "Select file for $propname property" -initialdir [pwd]]
		  if {$filename != {}} {
		      set vname "$Arrayvar\($propname\)"
		      switch $propname {
			  bitmap	{
				  set $vname "@$filename"
				  $TPcurCanvas itemconfigure $TPcanvasID -$propname "@$filename"
				}
			}
		    }
		}
	font	{
		  set TPcvPropsInfo(propname) $propname
		  set vname "$Arrayvar\($propname\)"
		  set TPcvPropsInfo(propval) [set $vname]
		  set TPfontCmd "set $Arrayvar\($propname\) \[TP_FontGetSelected\]; $TPcurCanvas itemconfigure $TPcanvasID -$propname \[TP_FontGetSelected\]"
		  ShowWindow.tpfontselect
		}
	image	{
		  set TPcvPropsInfo(propname) $propname
		  set vname "$Arrayvar\($propname\)"
		  set TPcvPropsInfo(propval) [set $vname]
		  set TPimgCmd "set $Arrayvar\($propname\)"
 		  set TPcfgCmd "$TPcurCanvas itemconfigure $TPcanvasID -$propname"
		  ShowWindow.tpimagesel
		}
	int	{
		}
	menu	{
		  set TPcurMenu [$TPcurCanvas itemcget $TPcanvasID -menu]
		  if {[winfo exists .tpmenu]} {
		       EndSrc.tpmenu
		     } { ShowWindow.tpmenu }
		}
	cursor -
	text	{
		}
	textedit	{
		   if {[winfo exists $TPcurCanvas]} {
		       if {![catch {$TPcurCanvas itemcget $TPcanvasID -$propname} cmd]} {
			   set TPcurWidget $TPcurCanvas
		           set TPcvPropsInfo(propname) $propname
		           set TPvarCmd "set $Arrayvar\($propname\)"
		           set TPtxtCmd "$TPcurCanvas itemconfigure $TPcanvasID -$propname"
		           ShowWindow.tpcmdedit
		           after 60
		           update
		           wm title .tpcmdedit "TKproE: Edit $propname property"
		           .tpcmdedit.frame.text2 delete 1.0 end
		           .tpcmdedit.frame.text2 insert end $cmd
		         }
		     }
		}
           }
  }
}


# Procedure: TP_CVpropsValueSet
proc TP_CVpropsValueSet { wname propname Arrayvar} {
# Configure specified property of the current object on the current canvas.
global TPcvPropsInfo
global TPcolor
global TPcvPropsSpecific
global TPcvPropsStandard
global TPfontCmd
global TPcanvasID
global TPcurCanvas

if {[info exists TPcvPropsInfo($propname)]} {
    set action [lindex $TPcvPropsInfo($propname) 0]
    set vname "$Arrayvar\($propname\)"
    switch $action {
	color	{
		  catch {$TPcurCanvas itemconfigure $TPcanvasID -$propname [set $vname]}
		}
	enum	{
		  catch {$TPcurCanvas itemconfigure $TPcanvasID -$propname [set $vname]}
		}
	file	{
		  catch {$TPcurCanvas itemconfigure $TPcanvasID -$propname "[set $vname]"}
		}
	font	{
		 catch { $TPcurCanvas itemconfigure $TPcanvasID -$propname [set $vname]}
		}
	image	{
		  catch {$TPcurCanvas itemconfigure $TPcanvasID -$propname [set $vname]}
		}
	int	{
		  catch {$TPcurCanvas itemconfigure $TPcanvasID -$propname [set $vname]}
		}
	angle -
	text	{
		  catch {$TPcurCanvas itemconfigure $TPcanvasID -$propname [set $vname]}
		}
	textedit	{
		  catch {$TPcurCanvas itemconfigure $TPcanvasID -$propname [set $vname]}
		}
           }
  }
}


# Procedure: TP_CanvasObjInsert
proc TP_CanvasObjInsert {} {
# Insert a new object into the current canvas.

global TPcurCanvasObjType
global TPCanvasObj
global TPcurCanvas
global TPcurCanvasObjXpos
global TPcurCanvasObjYpos
global TPmessage
global TPcanvasID
global TPcurCanvasObjTags
#LISSI
global TPrectRound

if {[winfo exists $TPcurCanvas]} {
    set objType [string tolower $TPcurCanvasObjType]
    set coords [string trim [.tpcanvas.frame2.frame21.frame.text2 get 1.0 end] "\n"]
    if {$TPcanvasID == {}} {
        # Create a new object from scratch
        set options {-tags}
        append options " \{$TPcurCanvasObjTags\}"
        if {$objType == {text}} { append options { -text text} }
       } {
           # Make a copy of the currently selected object.
           set proplist [$TPcurCanvas itemconfigure $TPcanvasID]
           if {$proplist != {}} {
               set options {}
                foreach propinfo $proplist {
		lappend options [lindex $propinfo 0]
		lappend options [lindex $propinfo end]
                          }
              }
         }
#LISSI
    if {$objType == {polygon}} { append options { -fill "" -outline black} }
    if {$objType == "rectangle" && $TPrectRound} {
	if {[llength $coords] != 4} {
	    set TPmessage "wrong # coordinates: expexted 4, got $coords"
    	    ShowWindow.tpmsgbox
	    after 100 bell
	    return
	} {
	    append options { -fill "" -outline black}
	    global TPrectRound
	    if {$TPrectRound > 0} {
		set coords [TP_roundRect [lindex $coords 0] [lindex $coords 1] [lindex $coords 2] [lindex $coords 3] [lindex $TPrectRound]]
		set {TPCanvasObj(-smooth)} {1}
	    } else {
		set coords [TP_bevelRect [lindex $coords 0] [lindex $coords 1] [lindex $coords 2] [lindex $coords 3] [lindex $TPrectRound]]
		set {TPCanvasObj(-smooth)} {0}
	    }
	    set objType "polygon"
	    lappend options "-smooth"
	    lappend options $TPCanvasObj(-smooth)
	}
    }

   if {[catch "$TPcurCanvas create $objType $coords $options" TPmessage]} {
        ShowWindow.tpmsgbox
        after 100 bell
       } {
           set TPcanvasID $TPmessage
           set TPmessage {}
         }
   }
}


# Procedure: TP_CanvasObjListFill
proc TP_CanvasObjListFill { cvname} {
# Fill in the list of objects for the specified canvas
global TPcurCanvasTagSort
global TPcanvasID

if {[winfo exists $cvname]} {
    if {[TP_ClassGet $cvname] == {Canvas}} {
        set objInfo [TP_CanvasObjListGet $cvname]
        set wname .tpcanvas.frame30.listbox1
        $wname delete 0 end
        foreach obj $objInfo {
	      foreach {ID tags type} $obj {}
	      $wname insert end "<$type> $ID"
	   }
      }
    set TPcanvasID {}
    TP_CanvasOptionsShrink
  }
}


# Procedure: TP_CanvasObjListGet
proc TP_CanvasObjListGet { cvname} {
# Retrieve list of all objects on the specified canvas
global TPcurCanvasTagSort

if {[winfo exists $cvname]} {
    if {[TP_ClassGet $cvname] == {Canvas}} {
        set objlist [$cvname find all]
        set IDList {}
        set TagList {}
        set TypeList {}
        set objInfo {}
        foreach ID $objlist {
	      set curInfo [list $ID [$cvname itemcget $ID -tags] [$cvname type $ID]]
	      lappend objInfo $curInfo
	   }
        switch $TPcurCanvasTagSort {
	    ID	{ set options {-integer -index 0} }
	    Tag	{ set options {-index 1} }
	    Type	{ set options {-index 2} }
	    default	{ set options {-integer -index 0} }
	  }

        catch "lsort $options \$objInfo" objinfo
        return $objinfo
      }
  }
}


# Procedure: TP_CanvasOptionsShrink
proc TP_CanvasOptionsShrink {} {
# Shrink the standard and specific options sections

if {[winfo exists .tpcanvas]} {
            set wname .tpcanvas.frame2.frame6.canvas2.frame5.hdrstandard
            set caption [$wname cget -text]
            if {[string first {+} $caption] < 0} {
                # We need to shrink the standard options section
	  TP_CVpropsShowHide $wname
               }

            set wname .tpcanvas.frame2.frame6.canvas2.frame5.hdrspecific
            set caption [$wname cget -text]
            if {[string first {+} $caption] < 0} {
                # We need to shrink the specific options section
	  TP_CVpropsShowHide $wname
               }

            # Move the section headers into view
            .tpcanvas.frame2.frame6.canvas2 yview moveto 0.0
   }
}


# Procedure: TP_CanvasSelect
proc TP_CanvasSelect { cvname} {
global TPcurCanvas
global TPtoolpath
global TPcurPath

if {[winfo exists $cvname]} {
    set TPcurCanvas $cvname
    TP_cancel_bind $TPcurCanvas
    TP_ToolChoose cancel
    set TPtoolpath $TPcurCanvas
    TP_DTcolor_stretch_set $TPcurCanvas
   }
}


# Procedure: TP_CanvasTypeSel
proc TP_CanvasTypeSel { objInfo} {
# Update the current object information on the canvas configuration form to reflect the specified object.
global TPcurCanvasObjType
global TPCanvasObj
global TPcurCanvas
global TPcurCanvasObjXpos
global TPcurCanvasObjYpos
global TPcanvasID
global TPcurCanvasObjTags
#LISSI
global TPcanvasTool
TP_ToolChoose cancel
set TPcanvasTool None

if {[winfo exists $TPcurCanvas]} {
    set objTypeStr [lindex $objInfo 0]
    set objID [lindex $objInfo 1]
    set TPcanvasID $objID
    switch $objTypeStr {
	Arc -
	<arc>		{ set objType Arc }
	Bitmap -
	<bitmap>		{ set objType Bitmap }
	Image -
	<image>		{ set objType Image }
	Line -
	<line>		{ set objType Line }
	Oval -
	<oval>		{ set objType Oval }
	Polygon -
	<polygon>	{ set objType Polygon }
	Rectangle -
	<rectangle>	{ set objType Rectangle }
	Text -
	<text>		{ set objType Text }
	Window -
	<window>	{ set objType Window }
  	default		{ set objType {} }
          }
	
    if {[string length $objType] > 0} {
            # Display the proper set of properties for the object type.
            set TPcurCanvasObjType $objType
            set TPcurCanvasObjTags [$TPcurCanvas itemcget $objID -tags]
            set pos [lsearch $TPcurCanvasObjTags current]
            if {$pos != -1} {
                set TPcurCanvasObjTags [lreplace $TPcurCanvasObjTags $pos $pos]
               }
            set coords [$TPcurCanvas coords $objID]
            .tpcanvas.frame2.frame21.frame.text2 delete 1.0 end
            .tpcanvas.frame2.frame21.frame.text2  insert end $coords
            set TPcurCanvasObjXpos [lindex $coords 0]
            set TPcurCanvasObjYpos [lindex $coords 1]

            TP_CanvasOptionsShrink
       }
   }
}


# Procedure: TP_ClassCmd
proc TP_ClassCmd { wclass} {
# Return the widget creation command for the specified widget class.


if {$wclass in {toplevel text table}} {
    set isTTK 0
   } {
       if {[string index $wclass 0] eq {t}} {
	   set isTTK 1
	  } { set isTTK 0 }
     }
if {$isTTK} {
    if {$wclass eq {treeview}} {
	set winclass $wclass
       } { set winclass [string range $wclass 1 end] }
    set nslist {::ttk}
   } {
       set winclass $wclass
       set nslist "{} [namespace children ::]"
     }

foreach ns $nslist {
	  set cmdpath [string range ${ns}::$winclass 2 end]
	  set cmd [info command $cmdpath]
	  if {[string length $cmd]} {
		return $cmdpath
	      }
	  set cmd [info proc $cmdpath]
	  if {[string length $cmd]} {
		return $cmdpath
	      }
	}
}


# Procedure: TP_ClassGet
proc TP_ClassGet { wname} {
global TPrealClass

set rtnval {}
if {$wname eq {.}} {
    set rtnval Toplevel
   } {
      if {[winfo exists $wname]} {
          set rtnval [winfo class $wname]
          if {[info exists TPrealClass($rtnval)]} { set rtnval $TPrealClass($rtnval) }
         }
     }
return $rtnval
}


# Procedure: TP_Clear_app
proc TP_Clear_app {} {
;# This procedure clears out the current application.
#
# The TKproE procedures, bindings, variables and widgets themselves are ignored
#
global TP_Clone_bindtagslist
global TPinfo
global TPexclusions
global TPprogFile

# clear current application name.
set TPprogFile {}

# clear main application TPstartupSrc and TPendSrc procedures
foreach procname {TPstartupSrc TPendSrc} {
	if {[info proc $procname] == $procname} {
	    rename $procname  {}
	  }
          }

# clear all Toplevel windows and their associated procedures
set namelist [lreplace [TP_ToplevelSearch] 0 0]
foreach name $namelist {
            # remove toplevel procedures
            foreach prefix {TPstartupSrc. TPopenWindow. TPcloseWindow. TPendSrc.} {
	          set procname $prefix$name
	          if {[string length [info proc $procname]] > 0} {
		rename $procname {}
	             }
	       }
            # destroy the window
            TP_WindowDestroy .$name
          }

# clear the root window
foreach wname [winfo children .] {
	if {$wname != {.tpmenugeneral}} {
	    if {[TP_ClassGet $wname] != {Toplevel}} {
		 TP_WindowDestroy $wname
	       }
           }
      }
if {[string length [info proc TPopenWindow.]] > 0} {
    rename TPopenWindow. {}
   }
wm title . {}

# clear all bindings on the root window
foreach seq [bind .] {
	set bindval [bind . $seq]
	set checkstr [string range $bindval 0 3]
	if {$checkstr != {# xf}} {
	    # Remove the binding, if not created by XF
	    bind . $seq {}
	  }
          }

# clear all image definitions
foreach picture [image names] {
	set remove 1
	set nspace [namespace qualifiers $picture]
	if {[string length $nspace] == 0} {
	    # Image is in global namespace
	    if {[lsearch $TPexclusions(images) $picture] != -1} {
	        # The image name is on the exclusion list and will not be saved.
	        # No need to worry it might get saved.
	        set remove 0
	       }
	   } {
	       if {[lsearch $TPexclusions(namespace) $nspace] != -1} {
	           # The image is part of a namespace that is not normally saved.
	           # No need to worry it might get saved.
	           set remove 0
	          }
	     }
	if {$remove} {
	    image delete $picture
	   }
         }

# clear all named fonts
foreach fontname [font names] {
	if {$fontname ni $TPexclusions(fonts)} {
		font delete $fontname
	   }
          }

# clear all loaded namespaces other than ::
set nspacelist [namespace children ::]
foreach nspace $nspacelist {
	if {[lsearch $TPexclusions(namespace) $nspace] == -1} {
	    namespace delete $nspace
	  }
          }

# clear all variables in :: namespace
set varlist [TP_VarListGet {::}]
foreach varname $varlist {
	  unset ::$varname
        }

# clear all user created procedures in :: namespace
foreach procname [TP_ProcListGet {::}] {
	set pname ::$procname
	rename $pname {}
       }

# set current widget path to root window
TP_PathMenuCreate .

return {}
}


# Procedure: TP_Clone_TKwidget
proc TP_Clone_TKwidget { wname {depth "0"}} {
# This procedure returns a string that consists of the TCL/TK source code necessary for duplicating
# the specified widget.
global TPexclusions
global TP_Clone_bindtagslist

# The widget must exist.
if {![winfo exists $wname]} { return {} }

# Do not save the TKproE generic pop-up menu.
if {$wname == {.tpmenugeneral}} { return {} }

set rtnval {}
if {$depth} {
    set widgetList {}
    foreach widget [lsort [winfo children $wname]] {
            if {[winfo class $widget] ne {Toplevel}} {
                lappend widgetList $widget
               }
          }
   } {
       # This is the first pass through the possibly recursive call.
       if {[TP_ClassGet $wname] == {Toplevel}} {
          set rtnval "# CLONEPATH = $wname\n"
          append rtnval "# Cloned [clock format [clock seconds]]\n\n"
          if {$wname != {.}} {
              append rtnval "set wname $wname\n"
              append rtnval {if {[winfo exists $wname]} { return {} } }
              append rtnval "\n"
             }
          } {
             set rtnval "# ClonePath = $wname\n"
             append rtnval "# Cloned [clock format [clock seconds]]\n"
            }
       set widgetList $wname
     }

incr depth
set cvcmd {}
set txtcmd {}
set delayedcmd {}
set tbltagscmd {}
set tblwincmd {}
set TP_Clone_bindtagslist {}

foreach widget $widgetList {
	  # save all children in window
      
	  # Do not save the TKproE generic pop-up menu.
	  if {$widget == {.tpmenugeneral}} { continue }

	  # perform generic actions
	  set Wclass [TP_ClassGet $widget]
	  set wclass [string tolower $Wclass]
	  switch $wclass {
		   tkchoosedir -
		   tkfdialog {
			   # Ignore TK built-in toplevel windows.
			   continue
			}
		   default {
			   # Don't save TKproE toplevels
			   set checkstr [string tolower [string range $widget 1 2]]
			   set nlist tp
			   if {[lsearch $nlist $checkstr] > -1} {
			        continue
			      }
			   # save basic widget configuration

			   # Widget creation command
			   if {$widget == {.}} {
			       set cmd "\n. configure "
			      } { set cmd "\n[TP_ClassCmd $wclass] $widget" }

			   # Configure the widget
			   foreach option [$widget configure] {
				   set optcmd [string range [lindex $option 0] 1 end]
				   if {($widget == {.}) && ([lsearch $TPexclusions(reconfig) $optcmd] != -1)} {
				          # skip non-configurable option
				      } {				       
				          set optval [lindex $option 4]
				          if {$optval != [lindex $option 3]} {
					      if {$optcmd == {state} && $optval != {normal}} {
						  # A widget state must be set to normal in order to do the initial configuration.
						  # Create a command to set the state to the correct value later then set the state to normal.
						  append delayedcmd "\n$widget configure -state \{$optval\}"
						  set optval normal
						 }
					      if {$optcmd == {labelwidget}} {
						  # Delay setting the labelwidget option to ensure the referenced widget is created first.
						  append delayedcmd "\n$widget configure -labelwidget \{$optval\}"
						  set optval {}
						 }

					      append cmd " -$optcmd \{$optval\}"
				             }
				        }
				 }
			   #append cmd "\n"

			   if {[string index $wclass 0] eq {t} && $wclass ni {toplevel text table}} {
			       # Save the states of the ttk widget.
				   if {[string index $wclass 1] ne {k}} {
						append cmd "\n$widget state \{[$widget state]\}"
					  }
			      } { append cmd \n }

			   # save widget bindings
			   set defbind [list $widget $Wclass [winfo toplevel $widget] all]
			   set bindlist [lsort [bindtags $widget]]
			   if {$bindlist ne $defbind} { append cmd "\nbindtags $widget \{$bindlist\}" }
			   foreach seq [lsort [bind $widget]] {
				   set bindval [string trimright [bind $widget $seq]]
				   set checkstr [string range $bindval 0 3]
				   if {$checkstr != {# xf}} {
				       append cmd "\nbind $widget $seq \{$bindval\}\n"
				      }
				 }
			  }
		 }
	  # perform widget class specific actions
	  switch $wclass {
		   canvas	{
			 # save individual canvas items
			 foreach item [$widget find all] {
				set type [$widget type $item]
				set coords [$widget coords $item]
			 	set cmd2 "$widget create $type $coords"
				# add item options
				foreach options [$widget itemconfigure $item] {
					set optcmd [lindex $options 0]
					set optval [lindex $options 4]
#LISSI
					if {($type == "polygon"  || $type == "text") && $optcmd == "-fill"} {
					    lappend cmd2 $optcmd $optval
					    continue
					}

					if {$optval != {}} {
					    lappend cmd2 $optcmd $optval
					} 
				}
				set cmd2 "set TPtemp \[$cmd2\]"
				if {$type == {window}} {
				   append cvcmd \n$cmd2
				  } { append cmd \n$cmd2 }

				# Establish item bindings
				set taglist [lsort [$widget bind $item]]
				foreach tag $taglist {
					set cmd2 "$widget bind \$TPtemp $tag \{[$widget bind $item $tag]\}"
					append cmd \n$cmd2
				         }
			           }
			}
		   listbox {
			 # save list box contents
			 set cmd2 "$widget insert end [$widget get 0 end]"
			 append cmd \n$cmd2
			}
		   menu	{
			  # save menu entries
			  set totEntries [$widget index last]
			  if {$totEntries != {none}} {
			      append cmd "\n"
			      # check whether item is a tear-off entry
			      set options [$widget entryconfigure 0]
			      if {[llength $options] > 3} {
			         set mtype [$widget type 0]
			         set cmd2 "$widget add $mtype"
			         foreach option $options {
				       set optval [lindex $option 4]
				       if {$optval != {}} { lappend cmd2 [lindex $option 0] $optval }
				    }
			         append cmd \n$cmd2
			        }
			      # process remaining entries
			      for {set ctr 1} {$ctr <= $totEntries} {incr ctr} {
				set options [$widget entryconfigure $ctr]
				set mtype [$widget type $ctr]
				set cmd2 "$widget add $mtype"
				foreach option $options {
				       set optval [lindex $option 4]
				       if {$optval != {}} { lappend cmd2 [lindex $option 0] $optval }
				    }
				append cmd \n$cmd2
			          }
			    }
			}
		   table {
			   # Clear out all tags
			   append cmd "$widget clear all origin bottomright\n"

			   # Save table span information
			   set spaninfo [$widget spans]
			   if {[string length $spaninfo] > 0} {
				set cmd2 "$widget spans $spaninfo"
				append cmd \n$cmd2
			      }

			   # Command to adjust row heights
			   set rowheights [$widget height]
			   if {[string length $rowheights] > 0} {
			  	append cmd "\n$widget height [string map {\{ {} \} {}} $rowheights]"
			      }

			   # Command to adjust column widths
			   set colwidths [$widget width]
			   if {[string length $colwidths] > 0} {
			  	append cmd "\n$widget width [string map {\{ {} \} {}} $colwidths]"
			      }

			   # Command to position first column into view
			   append cmd "\n$widget xview moveto [lindex [$widget xview] 0]"

			   # Command to position first row into view
			   append cmd "\n$widget yview moveto [lindex [$widget yview] 0]"

			   # Save table tag information
			   set taglist {}
			   foreach tagname [$widget tag names] {
				     if {[lsearch {active sel} $tagname] < 0} { lappend taglist $tagname }
				   }
			   foreach tagname $taglist {
				   set cmd2 "$widget tag configure $tagname"
				   foreach options [$widget tag configure $tagname] {
					set optcmd [lindex $options 0]
					set optval [lindex $options 4]
					if {[string range $optval 0 6] == {unknown}} { set optval {} }
					if {$optval != {}} {
					    append cmd2 " $optcmd \{$optval\}"
					   }
				         }
				  # Command to create the tag
				  append tbltagscmd \n$cmd2

				  # Command to assign the tag to a list of columns
				  set col_list [$widget tag col $tagname]
				  if {[string length $col_list] > 0} {
				  	append tbltagscmd "\n$widget tag col $tagname $col_list"
				     }

				  # Command to assign the tag to a list of rows
				  set row_list [$widget tag row $tagname]
				  if {[string length $row_list] > 0} {
				  	append tbltagscmd "\n$widget tag row $tagname $row_list"
				     }

				  # Command to assign the tag to a list of cells
				  set cell_list [$widget tag cell $tagname]
				  if {[string length $cell_list] > 0} {
				  	append tbltagscmd "\n$widget tag cell $tagname $cell_list"
				     }
				 }

			   # Save table window information
			   foreach wname [$widget window names] {
				set cmd2 "$widget window configure $wname"
				foreach options [$widget window configure $wname] {
					set optcmd [lindex $options 0]
					set optval [lindex $options 4]
					if {$optval != {}} {
					    append cmd2 " $optcmd \{$optval\}"
					  }
				      }
				  append tblwincmd \n$cmd2
			   	}
		   	 }
		   text	{
			  # save contents of text widget
			  set txtcmd [TP_Clone_Text_GetCmds $widget]
			}
		   tnotebook	{
				  # Save tab information.
				  # We need to delay these commands until after the contained widgets are created.
				  foreach tabwin [$widget tabs] {
					  append delayedcmd "\n$widget add $tabwin [$widget tab $tabwin]"
					}
				}
		   treeview	{
				  # Save column and heading information
				  set cols [concat #0 [$widget cget -columns]]
				  foreach column $cols {
					  set colOpts [$widget column $column]
					  set pos [string first { -id } $colOpts]
					  if {$pos < 0} {
						set cOpts $colOpts
					     } {
						incr $pos -1
						set cOpts [string range $colOpts 0 $pos]
					       }
					  append delayedcmd "\n$widget column $column $cOpts"

					  set headingOpts [$widget heading $column]
					  set pos [string first { state {}} $headingOpts]
					  if {$pos < 0} {
					      set hOpts $headingOpts
					     } {
						 set pos2 $pos
						 incr pos2 8
						 set hOpts [string replace $headingOpts $pos $pos2]
					       }
					  append delayedcmd "\n$widget heading $column $hOpts"
					}
				}
		   toplevel {
			  # Save window manager configurations
			  append cmd \n[TP_Clone_wm_info $widget]
			 }
		 }

	  #append cmd "\n"

	  set notMega {tbutton button tcheckbutton checkbutton tradiobuttion radiobutton tmenubutton menubutton menu canvas tlabel label tentry entry message listbox text tscrollbar scrollbar scale tseparator tframe frame toplevel spinbox tpanedwindow panedwindow table tlabelframe labelframe tnotebook}

	  if {$wclass in $notMega} {
	      # Descend the widget tree
	       append cmd [TP_Clone_TKwidget $widget $depth]
	     }

	  # Save geometry management information

	  # save paned window configuration
	  switch $wclass {
		 panedwindow	{
				  set paneList [$widget panes]
				  foreach pane $paneList {
					  append cmd "\n$widget add $paneList"
					  append cmd "\n$widget paneconfigure $pane"
					  foreach option [$widget paneconfigure $pane] {
						  set optcmd [lindex $option 0]
						  set optval [lindex $option end]
						  if {$optval != {}} {
							append cmd " $optcmd \{$optval\}"
						     }
						}
					}
				  append cmd "\n"
				}
		 tpanedwindow	{
				  # Save children information for paned windows.
				  # We need to delay these commands until after the contained widgets are created.
				  foreach panewin [$widget panes] {
					  append cmd "\n$widget add $panewin [$widget pane $panewin]"
					}
				}
	       } 

	  # save packing configuration
	  if {![catch {pack info $widget} pinfo]} {
	      if {[string length $pinfo]} { append cmd "\npack $widget [lrange $pinfo 2 end]" }
	    }
	  set slavelist [pack slaves $widget]
	  if {[string length $slavelist]} { append cmd "\npack $slavelist -in $widget" }
	  if {![pack propagate $widget]} { append cmd "\npack propagate $widget 0" }

	  # save placing configuration
	  if {![catch {place info $widget} pinfo]} {
	      if {[string length $pinfo]} { append cmd "\nplace $widget [lrange $pinfo 2 end]" }
	    }
	  set slavelist [place slaves $widget]
	  if {[string length $slavelist]} {
               foreach slave $slavelist {
                         append cmd "\nplace configure $slave -in $widget"
                       }
             }
	  append cmd \n

	  # save gridding configuration
	  if {![catch {grid info $widget} pinfo]} {
	      if {[string length $pinfo] } { append cmd "\ngrid $widget [lrange $pinfo 2 end]" }
	    }
	  set gridsize [grid size $widget]
	  if {$gridsize != {0 0}} {
	      foreach {totcols totrows} $gridsize {}
	      for {set col 0} {$col < $totcols} {incr col} {
                   append cmd "\ngrid columnconfigure $widget $col [grid columnconfigure $widget $col]"
	          }
	      for {set row 0} {$row < $totrows} {incr row} {
                   append cmd "\ngrid rowconfigure $widget $row [grid rowconfigure $widget $row]"
	          }
	     }
 	  if {![grid propagate $widget]} { append cmd "\ngrid propagate $widget 0" }

	  if {[string length $cmd]} { append rtnval \n$cmd }
	}

# Add the collected code for any table windows.
if {[string length $tblwincmd]} { append rtnval \n$tblwincmd }

# Add the collected code for any table tags.
if {[string length $tbltagscmd]} { append rtnval \n$tbltagscmd }

# Add the collected code for any canvas window items.
if {[string length $cvcmd]} { append rtnval \n$cvcmd }

# Add the collected code for any text window items.
if {[string length $txtcmd]} { append rtnval \n$txtcmd }

# Write out delayed commands, if necessary.
if {[string length $delayedcmd]} { append rtnval \n$delayedcmd }

return $rtnval
}


# Procedure: TP_Clone_Text_GetCmds
proc TP_Clone_Text_GetCmds { w} {
# Produce the necessary commands for recreating the content of the specified text widget.
# Return the results in a string.

set cmd {}
if {[winfo exists $w]} {
    if {[TP_ClassGet $w] == {Text}} {
        set save [TP_Clone_Text_GetInfo $w]

        # create items, restoring their attributes
        foreach {key value index} $save  {
	      switch $key  {
		  exec	{ append cmd $value\n }
		  image	{ append cmd "$w image create $index -name \{$value\}\n" }
		  text	{ append cmd "$w insert $index \{$value\}\n" }
		  mark	{
			  if {$value == {current}} { set current $index }
			  append cmd "$w mark set $value $index\n"
			}
		  tagon	{ set tag($value) $index }
		  tagoff	{ append cmd "$w tag add $value $tag($value) $index\n" }
		  window	{ append cmd "$w window create $index -window $value\n" }
		 }
	    }

        # restore the "current" index
        append cmd "$w mark set current $current\n"
       }
   }

return $cmd
}


# Procedure: TP_Clone_Text_GetInfo
proc TP_Clone_Text_GetInfo { w} {
# Extract all content from the specified text widget and return the information
# as a specially formatted string.
    set save {}
    # get the state of the widget
    set dump [$w dump -mark 1.0 end]
    append dump " "
    append dump [$w dump -all 1.0 {end -1 ch}]
    # add more details
    foreach {key value index} $dump  {
      switch $key  {
        image    {
          # add attributes of an image
          set exec "$w image create $index"
          foreach k {-align -image -name -padx -pady}  {
            set v [$w image cget $index $k]
            if {$v != ""} { append exec " $k \{$v\}" }
          }
          lappend save exec $exec {}
        }
        mark     {
          # add attributes of a mark
          lappend save $key $value $index
          set exec "$w mark gravity $value [$w mark gravity $value]"
          lappend save exec $exec {}
        }
        tagoff   {
          # add attributes of a tag
          set exec "$w tag configure $value"
          set keys {}
          lappend keys -background -bgstipple -borderwidth -elide -fgstipple
          lappend keys -font -foreground -justify -lmargin1 -lmargin2 -offset
          lappend keys -overstrike -relief -rmargin -spacing1 -spacing2
          lappend keys -spacing3 -tabs -underline -wrap
          foreach k $keys  {
            set v [$w tag cget $value $k]
            if {$v != ""} { append exec " $k \{$v\}" }
          }
          lappend save exec $exec {}
          lappend save $key $value $index
        }
        window   {
          # add attributes of a window
          lappend save $key $value $index
          set exec "$w window configure $index"
          foreach k {-align -create -padx -pady -stretch}  {
            set v [$w window cget $index $k]
            if {$v != ""} { append exec " $k \{$v\}" }
          }
          lappend save exec $exec {}
        }
        default  {
          lappend save $key $value $index
        }
      }
    }
    # return the serialized widget
    return $save
}


# Procedure: TP_Clone_app
proc TP_Clone_app {} {
# This procedure returns a string that consists of the TCL/TK source code necessary for duplicating
# the current application.
#
# The TKproE procedures, bindings, variables and widgets themselves are ignored and not copied.
#
global TPinfo
global TPexclusions
global TPprojType
global TPsaveValues

set outstr "# Generated by TKproE $TPinfo(revision) - [clock format [clock seconds]]\n\n"

# save main application TPstartupSrc and TPendSrc procedures
foreach procname {TPstartupSrc TPendSrc} {
	if {[info proc $procname] == $procname} {
	    append outstr "proc $procname \{\} \{\n"
	    append outstr [string trim [info body $procname] \n]
	    append outstr "\n\}\n\n"
	   }
          }

# save all image definitions
append outstr "proc TPinitImages \{\} \{\n"
append outstr "# Load all images\n"
append outstr [TP_Clone_images]
append outstr "\n\}\n\n"

# save all named fonts
append outstr "# Define named fonts\n"
append outstr [TP_Clone_namedFonts]
append outstr "\n"

# save all variables
append outstr "# Global variable initialization\n"
append outstr "proc TPinitVars \{\} \{\n"
append outstr "# Initialize global variables\n"
if {$TPsaveValues} {
    append outstr [TP_Clone_variables {::}]
   }
append outstr "set ::TPexclusions(user_namespace) [list [TP_ExcludeNamespaceGet]]\n"
append outstr "set ::TPprojType $TPprojType\n"
append outstr "set ::TPsaveValues $TPsaveValues\n"
append outstr "array set ::TPbuild \{[array get ::TPbuild]\}\n"
append outstr "\}\n\n"

if {$TPprojType ne {TCL}} {
    # save all Toplevel window procedures, including the root window
    append outstr "# Toplevel window procedures\n"
    set namelist [lreplace [TP_ToplevelSearch] 0 0 {}]
    foreach name $namelist {
            # save toplevel procedures
            foreach prefix {TPstartupSrc. TPopenWindow. TPcloseWindow. TPendSrc.} {
	          set procname $prefix$name
	          if {[string length [info proc $procname]] > 0} {
                  append outstr "proc $procname \{\} \{\n"
                  append outstr [string trim [info body $procname] \n]
                  append outstr "\}\n\n"
	             }
	       }
          }
   }

# save all user created procedures
append outstr "# User created procedures\n"
append outstr [TP_Clone_procs]
append outstr "\n"

# save code to start and display the application
append outstr "# Display and start the application\n"
if {$TPprojType ne {TCL}} {
    append outstr "TPinitImages\n"
   }
append outstr "if \{\[info proc TPstartupSrc\] != \{\}\} \{ TPstartupSrc \}\n"
append outstr "TPinitVars\n"

if {$TPprojType ne {TCL}} {
    foreach procname [info proc TPopenWindow.*] {
	    set wname [string range $procname 12 end]
	    if {[winfo exists $wname]} {
		append outstr "TPopenWindow$wname\n"
	       }
          }
   }

append outstr "if \{\[info proc TPendSrc\] != \{\}\} \{ TPendSrc \}\n"
append outstr "\n# End of TKproE generated code\n"

return $outstr
}


# Procedure: TP_Clone_bindings
proc TP_Clone_bindings {} {
# Generate and return code to reproduce all bindings associated with the application
global TP_Clone_bindtagslist

set rtnval {}
foreach tag $TP_Clone_bindtagslist {
	if {[string tolower [string range $tag 0 2]] != {.xf}} {
	   foreach binding [bind $tag] {
		    set cmd "bind $tag $binding"
		    set bindval [eval $cmd]
		    set checkstr [string range $bindval 0 3]
		    if {$checkstr != {# xf}} {
		       lappend cmd $bindval
		       append rtnval $cmd\n
		      }
	            }
	  }
	}
append rtnval "\n"
return $rtnval
}


# Procedure: TP_Clone_images
proc TP_Clone_images { {nspace "::"}} {
# Generate and return image loading code
global TPexclusions

set rtnval {}
foreach picture [lsort [image names]] {
	set saveit 1
	set nspc [namespace qualifiers $picture]
	if {[string length $nspc] == 0} {
	    # Image is in global namespace
	    if {$nspace == {::}} {
	        # We are cloning the global namespace
	        if {[lsearch $TPexclusions(images) $picture] != -1} {
	            # The image name is on the exclusion list. Don't save it.
	            set saveit 0
	           }
	       } { set saveit 0 }
	   } {
	       if {[lsearch $TPexclusions(namespace) $nspc] != -1} {
	           # The image is part of a namespace that should not be saved.
	           set saveit 0
	          } {
		if {$nspace != {::}} {
		      # We are cloning a specific namespace.
		      if {$nspc != $nspace} {
		          set saveit 0
		         }
		    }
	            }
	     }
	if {$saveit} {
	    set type [image type $picture]
	    set cmd "image create $type $picture"
	    foreach option [$picture configure] {
		  set optval [lindex $option 4]
		  if {$optval != {}} {
		      lappend cmd [lindex $option 0] $optval
		    }
		}
	    append rtnval $cmd\n
	   }
         }
append rtnval "\n"
return $rtnval
}


# Procedure: TP_Clone_namedFonts
proc TP_Clone_namedFonts {} {
# Generate and return font creation code
global TPstandardFonts
set rtnval {}
foreach fontname [lsort [font names]] {
	if {[lsearch $TPstandardFonts $fontname] == -1} {
	    # Save the font if not one of the TK standard fonts.
	    append rtnval "font create \{$fontname\} [font configure $fontname]\n"
	   }
          }
return $rtnval
}


# Procedure: TP_Clone_procs
proc TP_Clone_procs { {nspace "::"}} {
# Return code to reproduce all procedures
global TPexclusions

if {$nspace == {::}} {
    set prefix $nspace
  } { set prefix ${nspace}:: }
set rtnval "namespace eval $nspace \{\n#Creating namespace $nspace\n\}\n"
foreach procname [TP_ProcListGet $nspace] {
	set pname $prefix$procname
	set procbody [string trimleft [info body $pname] \n]
	set procargs {}
	foreach argname [info args $pname] {
		if {[info default $pname $argname defval]} {
		    lappend procargs "$argname \{$defval\}"
		   } { lappend procargs $argname }
	      }
	append rtnval "proc $pname \{$procargs\} \{\n$procbody\}\n\n"
        }

foreach childspace [namespace children $nspace] {
	if {[lsearch $TPexclusions(namespace) $childspace] == -1} {
	    append rtnval [TP_Clone_procs $childspace]
	  }
          }

return $rtnval
}


# Procedure: TP_Clone_save
proc TP_Clone_save {} {
# Save a clone to disk
set fout [open cloned.txt w]
puts $fout [TP_Clone_app]
close $fout
}


# Procedure: TP_Clone_variables
proc TP_Clone_variables { {nspace "::"}} {
# Generate and return code to reproduce all variables
global TPexclusions

if {$nspace == {::}} {
    set prefix $nspace
  } { set prefix ${nspace}:: }
set varlist [TP_VarListGet $nspace 0]
set rtnval "namespace eval $nspace \{;#Creating namespace $nspace;\}\n"
foreach varname $varlist {
	if {[array exists $prefix$varname]} {
	    # Output full array with a single command
	    set cmd "array set \{$prefix$varname\} \{[array get $prefix$varname]\}"
	   } {
		if {[catch "set $prefix$varname" curval]} {
		    set cmd "variable \{$prefix$varname\}"
		   } {
			if {[string first \0 $curval] != -1} {
		    	# Don't save values containing NULL characters.
			    set curval {}
			   }
			set cmd "set \{$prefix$varname\} \{$curval\}"
		     }
	     }
	append rtnval $cmd\n
         }
append rtnval "\n"

foreach childspace [namespace children $nspace] {
	if {[lsearch $TPexclusions(namespace) $childspace] == -1} {
	    append rtnval [TP_Clone_variables $childspace]
	    append rtnval "\n"
	  }
          }

return $rtnval
}


# Procedure: TP_Clone_wm_info
proc TP_Clone_wm_info { widget} {
# Generate and return code to reprodue window manager configurations

set cmd "wm geometry $widget [wm geometry $widget]\n"
set cmd {}

set attributes [wm attributes $widget]
set attribvals {}
foreach {option optval} $attributes {
	  set value [wm attributes $widget $option]
	  if {[string length $value]} {
		append atribvals " $option $value"
	      }
	}
if {[string length $attribvals]} {
     append $cmd "wm attributes $widget $attribvals\n"
   }

set optList {client colormapwindows command group iconbitmap iconname iconwindow title}
foreach option $optList {
	set value [wm $option $widget]
	if {[string length $value]} {
	     set cmd2 "wm $option $widget "
	     lappend cmd2 $value
	     append cmd $cmd2\n
	    }
         }

set optList {aspect focusmodel grid geometry iconmask iconposition maxsize minsize overrideredirect positionfrom resizable sizefrom state transient}
foreach option $optList {
	append cmd "wm $option $widget [wm $option $widget]\n"
         }
set plist [wm protocol $widget]
foreach protocol $plist {
	set cmd2 "wm protocol $widget $protocol"
	lappend cmd2 [eval $cmd2]
	append cmd $cmd2\n
         }

return $cmd
}


# Procedure: TP_ColorCanvasFill
proc TP_ColorCanvasFill { cvname} {
# Fill the specified canvas with color samples
global TPcolorList

if {[winfo exists $cvname]} {
    $cvname delete all
    set ypos1 0
    foreach colorinfo $TPcolorList {
	 foreach {name red green blue} $colorinfo {}
	 set ypos2 $ypos1
	 incr ypos2 30
	 set textpos $ypos1
	 incr textpos 15
	 set fillcolor [format "#%02X%02X%02X" $red $green $blue]
	 set xred [expr {$red^255}]
	 set xgreen [expr {$green^255}]
	 set xblue [expr {$blue^255}]
	 set textcolor [format "#%02X%02X%02X" $xred $xgreen $xblue]
	 set tmptag [$cvname create rectangle 0.0 $ypos1 400 $ypos2]
 	 $cvname itemconfigure $tmptag  -fill $fillcolor  -outline {}
 	 $cvname bind $tmptag <Button-1> "TP_ColorSetSample $fillcolor"
	 set tmptag [$cvname create text 100 $textpos]
	 $cvname itemconfigure $tmptag  -text $name -fill $textcolor
	 $cvname bind $tmptag <Button-1> "TP_ColorSetSample $fillcolor" 
	 incr ypos1 30
               }
        $cvname conf -scrollregion [$cvname bbox all]
  }
}


# Procedure: TP_ColorListMake
proc TP_ColorListMake {} {
global TPfin
global TPcolorList

set TPcolorList {}
set TPfin [open colors.txt r]
while {![eof $TPfin]} {
	gets $TPfin line
	if {[llength $line] == 4} {
	    foreach {red green blue name} $line {}
	    set colorinfo [list $name $red $green $blue]
	    lappend TPcolorList $colorinfo
	  }
        }
close $TPfin
return {}
}


# Procedure: TP_ColorSetSample
proc TP_ColorSetSample { {rgb ""} args} {
global TPcolor
global TPcurWidget
global TPmessage
global TPcolorCmd
global TPcanvasID
global TPcurCanvas

if {[string length $rgb] > 0} {
    if {[string index $rgb 0] != {#}} {
         # Need to convert from color name to RGB format
         if {[catch {winfo rgb . $rgb} color16]} {
              set TPmessage $color16
              ShowWindow.tpmsgbox
              after 100 bell
	update
              return {}
            }
         set TPcolor(red) [expr int([lindex $color16 0] / 256)]
         set TPcolor(green) [expr int([lindex $color16 1] / 256)]
         set TPcolor(blue) [expr int([lindex $color16 2] / 256)]
      } {
           scan $rgb "\#%2x%2x%2x" red green blue
           foreach c {red green blue} { set TPcolor($c) [format %d [set $c]] }
         }
  } {
      set rgb \#[format "%.2X%.2X%.2X" $TPcolor(red) $TPcolor(green) $TPcolor(blue)]
    }
if {![catch {winfo rgb . $rgb}]} {
    $TPcolor(label) config -bg $rgb
    if {[string length $TPcolorCmd] > 0} { catch "$TPcolorCmd $rgb" }
    set TPcolor(rgb) [string toupper $rgb]
   }
update
}


# Procedure: TP_CreateNewObj
proc TP_CreateNewObj {} {
global TPnextObjName
global TPnextObjType
global TPcurPath
global TPgeoMgr

set TPnextObjName [string trim $TPnextObjName]
if {$TPnextObjName != {}} {
   if {$TPnextObjType != {}} {
       if {$TPnextObjType eq {toplevel}} {
           # Ensure toplevels are children of root window.
           set newpath .
          } {
	# Add current path as prefix to new widget name
	set newpath $TPcurPath
            }
       if {[string index $newpath end] != {.}} {
          append newpath .
         }
       append newpath $TPnextObjName

       # Add default option values
       set optstr {}
       set fillType {}
       switch $TPnextObjType {
	   Tbutton -
	   button	{ set optstr { -text $TPnextObjName} }
	   canvas	{  }
	   Tcheckbutton { set optstr { -text $TPnextObjName} }
	   checkbutton	{ set optstr { -text $TPnextObjName -relief raised} }
	   Tentry -
	   entry	{  }
	   Tframe -
	   frame	{ set optstr { -width 30 -height 30 -borderwidth 2 -relief raised} }
	   Thpanedwindow {
			   set TPnextObjType Tpanedwindow
			   set optstr { -orient horizontal -height 100 -width 100}
			}
	   hpanedwindow	{
			   set TPnextObjType panedwindow
			   set optstr { -orient horizontal -relief sunken -background white -height 100 -width 100}
			}
	   hscale	{
			   set TPnextObjType scale
			   set optstr { -orient horizontal -relief raised}
			}
	   Thscrollbar	{
			   set TPnextObjType Tscrollbar
			   set optstr { -orient horizontal}
			}
	   hscrollbar	{
			   set TPnextObjType scrollbar
			   set optstr { -orient horizontal}
			}
	   Thseparator	{
			  set TPnextObjType Tseparator
			  set optstr { -orient horizontal}
			  set fillType x
			}
	   Tlabel -
	   label	{ set optstr { -text $TPnextObjName -relief raised} }
	   Tlabelframe -
	   labelframe	{ set optstr { -width 100 -height 100 -borderwidth 2 -relief groove -text $TPnextObjName} }
	   listbox	{ set optstr { -width 20 -height 4} }
	   menu		{
			  set optstr { -tearoff 0}
			}
	   Tmenubutton -
	   menubutton	{
			  set menuName $newpath.m
			  set optstr { -text $TPnextObjName -menu $menuName}
			}
	   message	{ set optstr { -text $TPnextObjName -relief raised -width 64} }
	   Tnotebook	{ set optstr { -width 30 -height 30} }
	   Tradiobutton	{ set optstr { -text $TPnextObjName} }
	   radiobutton	{ set optstr { -text $TPnextObjName -relief raised} }
	   spinbox	{ set optstr { -from 0.0 -to 10.0 -width 5 -background white} }
	   text		{  }
	   toplevel	{  }
	   Tvpanedwindow {
			   set TPnextObjType Tpanedwindow
			   set optstr { -orient vertical -height 100 -width 100}
			}
	   vpanedwindow	{
			   set TPnextObjType panedwindow
			   set optstr { -orient vertical -relief sunken -background white -height 100 -width 100}
			}
	   vscale		{
			   set TPnextObjType scale
			   set optstr { -orient vertical -relief raised}
			}
	   Tvscrollbar	{
			   set TPnextObjType Tscrollbar
			   set optstr { -orient vertical}
			}
	   vscrollbar	{
			   set TPnextObjType scrollbar
			   set optstr { -orient vertical}
			}
	   Tvseparator	{
			  set TPnextObjType Tseparator
			  set optstr { -orient vertical}
			  set fillType y
			}
	 }

       # Create new widget
       if {[string index $TPnextObjType 0] eq {T}} {
	   set objcmd ttk::[string range $TPnextObjType 1 end]
	  } { set objcmd $TPnextObjType }
       if {[catch "$objcmd $newpath$optstr" result]} {
              tk_messageBox -icon error -message $result -parent . -title {TKproE error} -type ok
          } {
	      set manageGeometry 1
              switch $TPnextObjType {
		  Tmenubutton -
	          menubutton	{
				  if {[catch "menu $menuName -tearoff 0" result]} { puts $result }
				}
	          listbox	{ $newpath insert end $TPnextObjName }
	          text		{ $newpath insert end $TPnextObjName }
	          menu		{ set manageGeometry 0 }
	          toplevel	{
				 set manageGeometry 0
				 TP_ToplevelCreateProcs $newpath
				 wm protocol $newpath WM_DELETE_WINDOW TPcloseWindow$newpath
				}
		  Tseparator	{
				  switch $TPgeoMgr {
					 pack { pack $newpath -fill $fillType }
				       }
				}
		  }
	if {$manageGeometry} {
	    set parentObjType [TP_ClassGet $TPcurPath]
	    switch $parentObjType {
		Canvas		{
				  $TPcurPath create window {0 0} -window $newpath -anchor nw
				}
		TNotebook	{
				  set tabno [llength [$TPcurPath tabs]]
				  $TPcurPath add $newpath -text tab$tabno
				  $TPcurPath select $tabno
				}
		TPanedwindow -
		Panedwindow	{
				  $TPcurPath add $newpath
				}
		Text		{
				  $TPcurPath window create insert -window $newpath
				}
		default		{
				  switch $TPgeoMgr {
					pack	{ pack $newpath }
					place	{ place $newpath -anchor nw }
					grid	{ grid $newpath }
				     }
				}
	           }
	  }
             }
    }
   set TPnextObjName {}
  }
}


# Procedure: TP_CutBufLoad
proc TP_CutBufLoad { title} {
# Load the cut buffer from a file.
global TPcutBuffer
global TPgetfile
global TPtemplateDir

set TPgetfile(chgdir) 2
if {[file isdirectory $TPtemplateDir]} {
    set startDir $TPtemplateDir
   } { set startDir [pwd] }
set filename [tk_getOpenFile -title $title -initialdir $startDir -filetypes {{{TCL source code files} .tcl} {{All files} .*}}]
if {[string length $filename] > 0} {
    if {[catch {open $filename r} fin]} {
        puts $fin
        set fin {}
      } {
          set TPcutBuffer [read $fin]
          close $fin
        }
  }
}


# Procedure: TP_CutBufSave
proc TP_CutBufSave {} {
# Save the cut buffer to a file.
global TPcutBuffer
global TPgetfile

if {[string length $TPcutBuffer] == 0} {
    set msg "Nothing to save.\n\nThe cut buffer is currently empty."
    tk_messageBox -icon info -message $msg -parent . -title [TP_GetConfig progname] -type ok
   } {
       set TPgetfile(chgdir) 2
       set title {Save cut buffer as template file:}
       set filename [tk_getSaveFile -title $title -initialdir [TP_GetConfig dirTemplates] -filetypes {{{TCL source code files} .tcl} {{All files} .*}}]
       if {[string length $filename] > 0} {
          if {[catch {open $filename w} fout]} {
              puts $fout
              set fout {}
            } {
                puts -nonewline $fout $TPcutBuffer
                close $fout
              }
        }
      }
}


# Procedure: TP_DTcolor_stretch_set
proc TP_DTcolor_stretch_set { cname} {
global TP_DTcolor_stretch

set TP_DTcolor_stretch yellow; return
if {$cname == ""} {return}
set clist [winfo rgb $cname [$cname cget -bg]]
set xlist "#"
foreach color $clist {
	set delta [expr abs(255 - ($color >> 8))]
	set xlist "${xlist}[format "%02X" $delta]"
      }
set TP_DTcolor_stretch $xlist
}


# Procedure: TP_DTconnect_resize
proc TP_DTconnect_resize { window xpos ypos} {
global tether_startx
global tether_starty
global tether_endx
global tether_endy

if {[$window find withtag tether] != ""} {
	$window coords tether $tether_startx $tether_starty $xpos $ypos
	set tether_endx $xpos
	set tether_endy $ypos
   }
}


# Procedure: TP_DTconnect_start
proc TP_DTconnect_start { window xpos ypos} {
global tether_startx
global tether_starty
global TP_DTcolor_stretch

set taglist [$window gettags current]
if {[lsearch $taglist output] != -1} {
	set bbox [$window bbox current]
	set tether_startx [expr ([lindex $bbox 2] + [lindex $bbox 0]) / 2]
	set tether_starty [expr ([lindex $bbox 3] + [lindex $bbox 1]) / 2]
	$window create line $tether_startx $tether_starty $tether_startx $tether_starty -tags tether -fill $TP_DTcolor_stretch
   }
}


# Procedure: TP_DTconnect_stop
proc TP_DTconnect_stop { window xpos ypos} {
global tether_startx
global tether_starty
global tether_endx
global tether_endy
global color_pipe
global pipe_start
global pipe_end

if {[$window find withtag tether] != ""} {
	$window delete tether
	set hitlist [$window find overlapping $xpos $ypos $xpos $ypos]
	foreach curid $hitlist {
		if {$curid != ""} {
		    if {[lsearch [$window gettags $curid] input] != -1} {
			set bbox [$window bbox $curid]
			set tether_endx [expr ([lindex $bbox 2] + [lindex $bbox 0]) / 2]
			set tether_endy [expr ([lindex $bbox 3] + [lindex $bbox 1]) / 2]
			set newtag pipe_[pipe_getnew $window]
			$window create line $tether_startx $tether_starty $tether_endx $tether_endy -tags $newtag -width 2 -fill $color_pipe
			set obj_id [TP_DTobj_getobj $window $curid]
			if {[info exists pipe_end($obj_id)]} {
			      lappend pipe_end($obj_id) $newtag
			   } {set pipe_end([TP_DTobj_getobj $window $curid]) $newtag}
			break
		       }
		   }
	            }
   }
}


# Procedure: TP_DTconpipe_bind
proc TP_DTconpipe_bind { cname} {
global TPB1_press_list
global TPB1_motion_list
global TPB1_release_list

if {[lsearch $TPB1_press_list conpipe] == -1} {lappend TPB1_press_list conpipe}
if {[lsearch $TPB1_motion_list conpipe] == -1} {lappend TPB1_motion_list conpipe}
if {[lsearch $TPB1_release_list conpipe] == -1} {lappend TPB1_release_list conpipe}
}


# Procedure: TP_DTgroup_resize
proc TP_DTgroup_resize { window xpos ypos} {
global TPgroupulx
global TPgroupuly
global TPgrouplrx
global TPgrouplry

$window coords groupbox $TPgroupulx $TPgroupuly $xpos $ypos

set TPgrouplrx $xpos
set TPgrouplry $ypos
#LISSI
global TPMove
    set aa [$window bbox groupbox]
    set TPMove(firstX) [lindex $aa 0]
    set TPMove(firstY) [lindex $aa 1]
    set TPMove(lastX) [lindex $aa 1]
    set TPMove(lastY) [lindex $aa 3]
    unset aa
}


# Procedure: TP_DTgroup_start
proc TP_DTgroup_start { window xpos ypos} {
global TPgroupulx
global TPgroupuly
global TP_DTcolor_stretch
#LISSI
global TPMove
    set TPMove(firstX) $xpos
    set TPMove(firstY) $ypos
    set TPMove(lastX) $xpos
    set TPMove(lastY) $ypos


$window create rectangle $xpos $ypos $xpos $ypos -tags groupbox -outline $TP_DTcolor_stretch
set TPgroupulx $xpos
set TPgroupuly $ypos
}


# Procedure: TP_DTgroup_stop
proc TP_DTgroup_stop { window xpos ypos} {
global TPgroupulx
global TPgroupuly
global TPgrouplist
global TPgrouplrx
global TPgrouplry

set TPgrouplist [$window find enclosed $TPgroupulx $TPgroupuly $xpos $ypos]
if {$TPgrouplist != ""} {
    set cmd "$window bbox $TPgrouplist"
    set bbox [eval $cmd]
   } else { set bbox "" }
if {$bbox != ""} {
    set TPgroupulx [lindex $bbox 0]
    set TPgroupuly [lindex $bbox 1]
    set TPgrouplrx [lindex $bbox 2]
    set TPgrouplry [lindex $bbox 3]
    $window coords groupbox $TPgroupulx $TPgroupuly $TPgrouplrx $TPgrouplry
   }
lappend TPgrouplist groupbox
}

# Procedure: TP_DTidentify
proc TP_DTidentify { cname xpos ypos} {
global TPiditem
global TPcanvasID
global TPcurCanvas

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
         set size [llength $itemlist]
         set idx 0
         while {$idx < $size} {
	    set itemval [lindex $itemlist $idx]
	    set pos [string length $itemval]
	    incr pos $slen
	    if {[string range $itemval $pos end] == $searchstr} {
	        $wname selection set $idx
	        set idx $size
	        event generate $wname <<ListboxSelect>>
	       }
	    incr idx
	  }
       }
    }
}

# Procedure: TP_DTldelete
proc TP_DTldelete { vname item} {
set pos [lsearch $vname $item]
if {$pos > -1} {
	set rtnval [lreplace $vname $pos $pos]
   } {	set rtnval $vname }
return $rtnval
}


# Procedure: TP_DTobj_add
proc TP_DTobj_add { cname} {
# This procedure associates a canvas item with the current object
#
global TP_DTobjcur

set curid [$cname find withtag current]
if {$curid == ""} {return}
set taglist ""
foreach tag [$cname gettags $curid] {
	if {[string range $tag 0 3] != "obj_"} {
		lappend taglist $tag
	   }
      }
lappend taglist $TP_DTobjcur
$cname itemconfigure $curid -tags $taglist
}


# Procedure: TP_DTobj_bind
proc TP_DTobj_bind { cname} {
global TPB1_press_list
global TPB1_motion_list

if {[lsearch $TPB1_press_list objmove] == -1} {lappend TPB1_press_list objmove}
if {[lsearch $TPB1_motion_list objmove] == -1} {lappend TPB1_motion_list objmove}
}


# Procedure: TP_DTobj_delete
proc TP_DTobj_delete { cname} {
# This procedure disassociates an item from any objects
#
global TP_DTobjcur

set curid [$cname find withtag current]
if {$curid == ""} {return}
set taglist ""
foreach tag [$cname gettags $curid] {
	if {[string range $tag 0 3] != "obj_"} {
		lappend taglist $tag
	   }
      }
$cname itemconfigure $curid -tags $taglist
}


# Procedure: TP_DTobj_getobj
proc TP_DTobj_getobj { cname id} {
# return object ID number of a canvas item
foreach tag [$cname gettags $id] {
	if {[string range $tag 0 3] == "obj_"} {
		return [string range $tag 4 end]
	   }
      }
return ""
}


# Procedure: TP_DTobj_move
proc TP_DTobj_move { window xpos ypos} {
global TPxposlast
global TPyposlast
global TP_DTobjcur

if {$TP_DTobjcur == ""} {return}
set xmove [expr $xpos - $TPxposlast]
set TPxposlast $xpos
set ymove [expr $ypos - $TPyposlast]
set TPyposlast $ypos
$window move $TP_DTobjcur $xmove $ymove
}


# Procedure: TP_DTobj_next
proc TP_DTobj_next { cname} {
# find all object ID numbers
set objnumbers ""
set objlist [$cname find all]
foreach curid $objlist {
	foreach tag [$cname gettags $curid] {
		if {[string range $tag 0 3] == "obj_"} {
			lappend objnumbers [string range $tag 4 end]
		   }
	      }
      }

# select an object ID number not currently used
set rtnval ""
for {set ctr 0} {$ctr < 10000} {incr ctr} {
	if {[lsearch $objnumbers $ctr] == -1} {
		set rtnval obj_$ctr
		break
	   }
    }
return $rtnval
}


# Procedure: TP_DTobj_select
proc TP_DTobj_select { cname} {
global TP_DTobjcur

set TP_DTobjcur ""
foreach tag [$cname gettags current] {
	if {[string range $tag 0 3] == "obj_"} {
		set TP_DTobjcur $tag
		break
	   }
      }
if {$TP_DTobjcur == ""} {
    set TP_DTobjcur [TP_DTobj_next $cname]
   }
}


# Procedure: TP_DTobj_start
proc TP_DTobj_start { window xpos ypos} {
global TPxposlast
global TPyposlast
global TP_DTobjcur

set curid [$window find withtag current]
set TP_DTobjcur {}
foreach item [$window gettags $curid] {
	if {[string range $item 0 3] == {obj_}} {
		set TP_DTobjcur $item
		break
	   }
          }
set TPxposlast $xpos
set TPyposlast $ypos
}


# Procedure: TP_DTone_start
proc TP_DTone_start { cname xpos ypos} {
    global TPgroupulx
    global TPgroupuly
    global TP_DTcolor_stretch
    global TPgrouplist
    global TPgroupulx
    global TPgroupuly
    global TPgrouplrx
    global TPgrouplry
#LISSI
    global TPMove

    set TPgrouplist [$cname find withtag current]
    if {$TPgrouplist != ""} {
	set bbox [eval "$cname bbox $TPgrouplist"]
	set TPgroupulx [lindex $bbox 0]
	incr TPgroupulx -1
	set TPgroupuly [lindex $bbox 1]
	incr TPgroupuly -1
	set TPgrouplrx [lindex $bbox 2]
	incr TPgrouplrx
	set TPgrouplry [lindex $bbox 3]
	incr TPgrouplry
	$cname create rectangle $TPgroupulx $TPgroupuly $TPgrouplrx $TPgrouplry -tags groupbox -outline $TP_DTcolor_stretch
	lappend TPgrouplist groupbox
#LISSI
        set TPMove(firstX) $xpos
        set TPMove(firstY) $ypos
        set TPMove(lastX) $xpos
        set TPMove(lastY) $ypos
   }
}


# Procedure: TP_DTonemove_bind
proc TP_DTonemove_bind { cname} {
global TPB1_press_list
global TPB1_motion_list
global TPB1_release_list

if {[lsearch $TPB1_press_list group] == -1} {lappend TPB1_press_list onemove}
if {[lsearch $TPB1_motion_list group] == -1} {lappend TPB1_motion_list move}
if {[lsearch $TPB1_release_list move] == -1} {lappend TPB1_release_list endonemove}
}


# Procedure: TP_DTpipe_getnew
proc TP_DTpipe_getnew { cname} {
# find all pipe ID numbers
set pipenumbers ""
set objlist [$cname find all]
foreach curid $objlist {
	foreach tag [$cname gettags $curid] {
		if {[string range $tag 0 4] == "pipe_"} {
			lappend pipenumbers [string range $tag 5 end]
		   }
	      }
      }

# select a pipe ID number not currently used
for {set ctr 0} {$ctr < 10000} {incr ctr} {
	if {[lsearch $pipenumbers $ctr] == -1} {
		return $ctr
	   }
    }
return -1
}


# Procedure: TP_DTpop
proc TP_DTpop { cname xpos ypos} {
global TPiditem
global TPcanvasID

set TPidItem [$cname find withtag current]
if {$TPidItem != {}} {
     $cname raise $TPidItem
    }
}


# Procedure: TP_DTpush
proc TP_DTpush { cname xpos ypos} {
global TPiditem
global TPcanvasID

set TPidItem [$cname find withtag current]
if {$TPidItem != {}} {
     $cname lower $TPidItem
    }
}


# Procedure: TP_DTundelete
proc TP_DTundelete { window} {
global TPgrouplist
global TPundelcmd
global TPcurCanvas

if {$TPundelcmd == ""} {return}
set newtsgrouplist ""
foreach cmd $TPundelcmd {
	set newtag [eval $cmd]
	if {$newtag != ""} {
	    lappend newtsgrouplist $newtag
	   }
      }
set TPgrouplist $newtsgrouplist
set TPundelcmd ""
}


# Procedure: TP_EvalSafe
proc TP_EvalSafe { cmd} {
# Evaluate a command with error trapping.
if {[catch $cmd result]} {
    TP_ShowMsg $result
  }
}


# Procedure: TP_ExcludeNamespaceAdd
proc TP_ExcludeNamespaceAdd { name} {
# Place the specified namespace on the exclusion list
global TPexclusions
global TPcurExcludedNamespace

if {[lsearch $TPexclusions(namespace) $name] < 0} {
    lappend TPexclusions(namespace) $name
  }
set TPcurExcludedNamespace $name
if {[winfo exists .tpexclusions.frame.listbox1]} {
   .tpexclusions.frame.listbox1 delete 0 end
   set nslist [lsort $TPexclusions(namespace)]
   set idx 0
   foreach ns $nslist {
	 .tpexclusions.frame.listbox1 insert end $ns
	 if {[lsearch $TPexclusions(cantsave_namespace) $ns] < 0} {
	     .tpexclusions.frame.listbox1 itemconfigure $idx -foreground black
	    } {
	        .tpexclusions.frame.listbox1 itemconfigure $idx -foreground grey60
	      }
	 incr idx
            }
  }
}


# Procedure: TP_ExcludeNamespaceDel
proc TP_ExcludeNamespaceDel { name} {
# Remove the specified namespace from the exclusion list
global TPexclusions

if {[lsearch $TPexclusions(cantsave_namespace) $name] < 0} {
    set pos [lsearch $TPexclusions(namespace) $name]
    if {$pos >= 0} {
        set TPexclusions(namespace) [lreplace $TPexclusions(namespace) $pos $pos]
       }

    if {[winfo exists .tpexclusions.frame.listbox1]} {
       .tpexclusions.frame.listbox1 delete 0 end
       set nslist [lsort $TPexclusions(namespace)]
       set idx 0
       foreach ns $nslist {
	     .tpexclusions.frame.listbox1 insert end $ns
	     if {[lsearch $TPexclusions(cantsave_namespace) $ns] < 0} {
	         .tpexclusions.frame.listbox1 itemconfigure $idx -foreground black
	       } {
	           .tpexclusions.frame.listbox1 itemconfigure $idx -foreground grey60
	         }
	     incr idx
	  }
      }
  } {
      # Namespace automatically excluded from saving. User is not allowed to delete from the list.
    }
}


# Procedure: TP_ExcludeNamespaceGet
proc TP_ExcludeNamespaceGet {} {
# Return a list of locally-added namespaces on the exclusion list
global TPexclusions

set rtnval {}
foreach nspace $TPexclusions(namespace) {
	if {[lsearch $TPexclusions(cantsave_namespace) $nspace] < 0} { lappend rtnval $nspace }
           }
return $rtnval
}


# Procedure: TP_ExpandToplevel
proc TP_ExpandToplevel { winlist} {
# Expand the height of the specified toplevel window.
set extraheight 0
foreach wname $winlist {
             if {[winfo exists $wname]} {
	 set parent [winfo parent $wname]
	 if {[lsearch [pack slaves $parent] $wname] != -1} {
	     incr extraheight [winfo height $wname]
	   }
	}
        }

set wname .tpproperties
set curHeight [winfo height $wname]
foreach {width minHeight} [wm minsize $wname] {}
set newHeight $minHeight
incr newHeight $extraheight
if {$curHeight < $newHeight} {
    # Actual height is less than the desired height.
    set bottom [winfo rooty $wname]
    incr bottom $newHeight
    set screenHeight [winfo screenheight $wname]
    if {$bottom > $screenHeight} {
        # Don't expand the window below the bottom of the screen.
        incr newHeight $screenHeight
        incr newHeight -$bottom
        incr newHeight -1
        if {$newHeight < $minHeight} {
            # Ensure we don't set the height less than the minimum.
            set newHeight $minHeight
          }
      }
    wm geometry $wname ${width}x$newHeight
   }
}


# Procedure: TP_FileNew
proc TP_FileNew {} {
# Clear the current TCL/TK application.

set progname [TP_GetConfig progname]
set title "New $progname project"
set msg "Clear out existing project!\n\nDo you really want want to do this?"
set ans [tk_messageBox -default no -icon question -message $msg -parent . -title $title -type yesno]
if {$ans == {yes}} {
    TP_Clear_app
    TP_TitlebarUpdate
  }
}


# Procedure: TP_FileOpen
proc TP_FileOpen {} {
# Open a TCL/TK application specified by the user.
global TPbuild
global TPgetfile
global tcl_platform
global TPprogFile

set progname [TP_GetConfig progname]
set title "Open $progname project"
set TPgetfile(chgdir) 1
set types {
	{{TCL Scripts}      {.tcl}        }
	{{All Files}        {*.*}         }
}
#LISSI
#set filename [tk_getOpenFile -title $title -filetypes $types -initialdir [pwd] -parent .]
set filename [tk_getOpenFile -title $title -filetypes $types -initialdir [pwd] -parent .tpmain]
   
if {[string length $filename] > 0} {
    TP_Clear_app
     if {$TPgetfile(chgdir)} {
         cd [file dirname $filename]
       }
     TP_Source $filename
     set TPprogFile $filename
     set TPbuild(MainSrc) $TPprogFile
     TP_TitlebarUpdate
  }
set TPgetfile(chgdir) 2
}


# Procedure: TP_FileQuit
proc TP_FileQuit {} {
# Clean up and exit
global TPcutBuffer

set title "Exit [TP_GetConfig progname]"
set msg "About to exit [TP_GetConfig progname].\n\nDo you really want want to do this?"
set ans [tk_messageBox -default no -icon question -message $msg -parent . -title $title -type yesno]
if {$ans == {yes}} {
   set TPcutBuffer {}
   rename exit {}
   rename TP_RealExit exit
   exit
  }
}


# Procedure: TP_FileSave
proc TP_FileSave { filename} {
# Save the current application to the specified file name.
global TPstatusLine

if {[string length $filename] == 0} {
    TP_ShowMsg "Project file name not yet specified.\n\nUse \"Save As\" option instead."
  } {
      set TPstatusLine "Saving application to $filename"
      update
      set outstr [TP_Clone_app]
      if {[string length $outstr] > 0} {
          if {[catch {open $filename w} fout]} {
              TP_ShowMsg $fout
              set fout {}
              set TPstatusLine {File save failed}
            } {
                puts -nonewline $fout $outstr
                close $fout
                set TPstatusLine "Program saved to $filename"
		TP_TitlebarUpdate
              }
         } { set TPstatusLine {Unable to save application} }
    }
}


# Procedure: TP_FileSaveAs
proc TP_FileSaveAs {} {
# Save the current application to a file name specified by the user.
global TPbuild
global TPstatusLine
global TPprogFile
global TPgetfile
global tcl_platform

set TPgetfile(chgdir) 2
set title "[TP_GetConfig progname]: Save current project as..."
set types {
	{{TCL Scripts}      {.tcl}        }
	{{All Files}        {*.*}         }
}
set filename [tk_getSaveFile -title $title -filetypes $types -initialfile $TPprogFile -initialdir [pwd] -parent .]

if {[string length $filename] > 0} {
    set TPprogFile $filename
    set TPbuild(MainSrc) $TPprogFile
    TP_FileSave $TPprogFile
   }
}


# Procedure: TP_FileSaveNspace
proc TP_FileSaveNspace { {nspace "::"}} {
# Save the current application to the specified file name.
global TPstatusLine
global TPnspaceFile

if {$TPnspaceFile == {}} { return {} }

if {$nspace == {::}} {
    set msg {Sorry. This program will only save the global namespace as part of the user application.}
    tk_messageBox -icon info -message $msg -parent . -title {TKproE message} -type ok
  }  {
       set TPstatusLine "Saving namespace $nspace to $TPnspaceFile"
       update
       set outstr [TP_Clone_variables $nspace]
       append outstr [TP_Clone_images $nspace]
       append outstr [TP_Clone_procs $nspace]
       if {[string length $outstr] > 0} {
           if {[catch {open $TPnspaceFile w} fout]} {
               TP_ShowMsg $fout
               set fout {}
               set TPstatusLine {Namespace file save failed}
             } {
                 puts -nonewline $fout $outstr
                 close $fout
                 set TPstatusLine "Namespace $nspace saved to $TPnspaceFile"
               }
          } { set TPstatusLine {Unable to save namespace} }
     }
}


# Procedure: TP_FileSource
proc TP_FileSource {} {
# Source a TCL/TK file specified by the user.
global TPstatusLine
global TPgetfile

set TPgetfile(chgdir) 0
set title "[TP_GetConfig progname] : Select file to source..."
set filename [tk_getOpenFile -title $title -initialdir [pwd] -filetypes {{{TCL source code files} .tcl} {{All files} .*}}]
if {[string length $filename] > 0} {
     if {$TPgetfile(chgdir)} { cd [file dirname $filename] }
     TP_Source $filename
    }
set TPgetfile(chgdir) 2
}


# Procedure: TP_FontCreate
proc TP_FontCreate { fontName} {
# Create the specified named font from the currently selected font attributes.
global TPfontFamily
global TPfontSize
global TPfontStyle
global TPfontStrikeout
global TPfontUnderline
global TPcurWidget
global TPfontCmd

set fontWeight normal
set fontSlant roman
switch $TPfontStyle {
	Bold		{
			  set fontWeight bold
			}
	Italic		{
			  set fontSlant italic
			}
	{Bold Italic}	{
			  set fontWeight bold
			  set fontSlant italic
			}
         }

if {$TPfontStrikeout} { set fontOverstrike 1 } { set fontOverstrike 0 }
if {$TPfontUnderline} { set fontUnderline 1 } { set fontUnderline 0 }

if {[lsearch [font names] $fontName] == -1} { font create $fontName }
font configure $fontName -family $TPfontFamily -size $TPfontSize -weight $fontWeight -slant $fontSlant -underline $fontUnderline -overstrike $fontOverstrike

return {}
}


# Procedure: TP_FontGetSelected
proc TP_FontGetSelected {} {
# Return the -font configuration string for the currently selected font.
global TPfontFamily
global TPfontSize
global TPfontStyle
global TPfontStrikeout
global TPfontUnderline
global TPcurWidget
global TPfontCmd

if {$TPfontStyle == {Regular}} {
   set fontStyle {}
  } { set fontStyle [string tolower $TPfontStyle]}

if {$TPfontStrikeout} {
   set fontOverstrike overstrike
  } { set fontOverstrike {} }

if {$TPfontUnderline} {
    set fontUnderline underline
  } { set fontUnderline {} }

set rtnval "\{$TPfontFamily\} $TPfontSize $fontStyle $fontOverstrike $fontUnderline"

return $rtnval
}


# Procedure: TP_FontNameFill
proc TP_FontNameFill { lbox} {
# Fill the specified listbox with the list of all named fonts.
global TPfontFamily
global TPfontSize
global TPfontStyle
global TPfontStrikeout
global TPfontUnderline
global TPcurWidget
global TPfontCmd

if {[winfo exists $lbox]} {
    if {[TP_ClassGet $lbox] == {Listbox}} {
        $lbox delete 0 end
        foreach fname [lsort -dictionary [font names]] {
		$lbox insert end $fname
	    }
       }
   }
}


# Procedure: TP_FontSelect
proc TP_FontSelect { namedFont} {
# Set the currently selected font attributes to those of the named font.
global TPfontFamily
global TPfontSize
global TPfontStyle
global TPfontStrikeout
global TPfontUnderline
global TPcurWidget
global TPfontCmd

# Verify named font exists
if {[lsearch [font names] $namedFont] != -1} {
    # Get font attributes
    set TPfontFamily [font configure $namedFont -family]
    set TPfontSize [font configure $namedFont -size]
    set TPfontUnderline [font configure $namedFont -underline]
    set TPfontStrikeout [font configure $namedFont -overstrike]
    set fontWeight [font configure $namedFont -weight]
    set fontSlant [font configure $namedFont -slant]

    # Convert attributes parameter values
   }

if {$fontWeight == {normal}} {
       if {$fontSlant == {roman}} { set TPfontStyle Regular } { set TPfontStyle Italic }
   } {
       if {$fontSlant == {roman}} { set TPfontStyle Bold } { set TPfontStyle {Bold Italic} }
     }

# Display a sample of the font.
if {[winfo exists .tpfontselect]} {
    .tpfontselect.frame1.frame5.canvas0 itemconfigure sample -font [TP_FontGetSelected]
#LISSI
    .tpfontselect.frameSample.canvas0 itemconfigure sample -font [TP_FontGetSelected]

    if {[string length $TPfontCmd] > 0} {
        catch $TPfontCmd
       }
   }

return {}
}

proc TP_buildExec {} {
# Build/wrap the application.
global tcl_platform
global TPbuild
global TPprogFile
#LISSI
global macos
set typesys [tk windowingsystem]

set rtnval {}
if {[info exists ::freewrap::patchLevel]} {
    # Save the current program

#LISSI
    if {$TPbuild(buildType) != "buildEXT"} {
    
    TP_FileSave $TPprogFile

    }
    # Create the user-specified binary distributions.
    if {$tcl_platform(os) eq {Linux}} {
        set OS Linux
      } { set OS Win }
    if {$tcl_platform(pointerSize) == 8} {
        set bits 64
      } { set bits 32 }
    set curOS $OS$bits

    # Create a temporary directory for performing the build.
    set curDir [pwd]
    set secs [clock seconds]
    set fout [file tempfile fpath]
    close $fout
    set tempDir [file join [file dirname $fpath] tkproeBuild$secs]
    if {[catch {file mkdir $tempDir} rtnval]} {
        return $rtnval
       }

    set OutFile [file join $TPbuild(destDir) tkproeBuild${secs}.bin]
    if {$TPbuild(buildType) == "buildEXT"} {
	set TPmainSrc $TPbuild(EXTfile)
    } else {
	set TPmainSrc $TPbuild(MainSrc)
    }
    set srcFile [file tail $TPmainSrc]
#LISSI
#puts "TPmainSRC=$srcFile"
    if {$TPbuild(wrapper) == 1 } {
#Используем tclexecomp
	set dirsrc [file dirname $TPmainSrc]
	set listDir [split $dirsrc "/"]
	if {$typesys == "win32"} {
	    set listDir [string map {":" ""} $listDir]
	}
	set tdir $tempDir
	foreach dir $listDir {
	    if {$dir == ""} { continue}
	    set tdir "$tdir/$dir"
	    file mkdir $tdir
	}
    # Copy the main application script file.
	if {[catch {file copy $TPmainSrc [file join $tdir $srcFile]} rtnval]} {
    	    return $rtnval
        }
    } else {

    # Copy the main application script file.
    if {[catch {file copy $TPmainSrc [file join $tempDir $srcFile]} rtnval]} {
        return $rtnval
       }
#LISSI
}

    # Add the include files.
    foreach filename $TPbuild(IncludeFiles) {
            if {[file isfile $filename]} {
#LISSI 
    if {$TPbuild(wrapper) == 1 } {
#Используем tclexecomp
	set dirsrc [file dirname $filename]
	set listDir [split $dirsrc "/"]
	if {$typesys == "win32"} {
	    set listDir [string map {":" ""} $listDir]
	}
	set tdir $tempDir
	foreach dir $listDir {
	    if {$dir == ""} { continue}
	    set tdir "$tdir/$dir"
	    file mkdir $tdir
	}
    # Copy the include files.
	if {[catch {file copy $filename $tdir} rtnval]} {
    	    return $rtnval
        }
    } else {


                if {[catch {file copy $filename $tempDir} rtnval]} { return $rtnval }
#LISSI
}
            } { return "Failure adding file $filename." }

        }

    # Add the include directory
    set includeDirs [string trim $TPbuild(IncludeDir)]
    if {$includeDirs ne {}} {
#LISSI dirs
#LISSI
    # Add the include files.
    foreach includeDir $includeDirs {

        if {[file isdirectory $includeDir]} {
#LISSI 
    if {$TPbuild(wrapper) == 1 } {
#Используем tclexecomp
	set dirsrc [file dirname $includeDir]
	set listDir [split $dirsrc "/"]
	if {$typesys == "win32"} {
	    set listDir [string map {":" ""} $listDir]
	}
	set tdir $tempDir
	foreach dir $listDir {
	    if {$dir == ""} { continue}
	    set tdir "$tdir/$dir"
	    file mkdir $tdir
	}
    # Copy the include directory.
	if {[catch {file copy $includeDir $tdir} rtnval]} {
    	    return $rtnval
        }
    } else {


            if {[catch {file copy $includeDir $tempDir} rtnval]} { return $rtnval }
#LISSI
}
        } { return {Unable to access directory $includeDir} }
#LISSI dirs
}

       }

    set compression $TPbuild(compression)
    if {$compression eq {}} { set compression 9 }
    if {$TPbuild(buildType) eq {buildPKG}} {
        # We are creating a program package instead.

        # Update the _FWprogPack_init.txt file to run the user's application.
        set initFile [file join $tempDir _FWprogPack_init.txt]
        if {[catch {open $initFile w} fout]} { return $fout }
        puts $fout [file join /zvfs $srcFile]
        puts $fout $::freewrap::patchLevel
        close $fout

        # Wrap the package.
        cd $tempDir
        set cmd "::freewrap::makeZIP $OutFile -$compression -r ."
        if {[catch $cmd rtnval]} { return $rtnval }

        # Move the file to its final name
        set finalFile [file join $TPbuild(destDir) $TPbuild(appName).fwp]
        if {[catch {file rename -force $OutFile $finalFile} rtnval]} { return $rtnval }

        # Remove the temporary directory
        cd $curDir
        if {[catch {file delete -force $tempDir} rtnval]} { return $rtnval }
       } {
            # We are creating executable programs.
            
            # Wrap the application for each selected operating system.
            foreach {targetOS OSext} {MacOS {} Linux32 {} Linux64 {} Win32 .exe Win64 .exe} {
                    if {$TPbuild($targetOS)} {
                        set SrcFile $TPbuild(Exec_$targetOS)
                        if {[file isfile $SrcFile]} {
                            # Copy the target OS freewrap to the output file name
                            if {[catch {file copy -force $SrcFile $OutFile} result]} {
                                return $result
                                } {
                                    # Mount the OutFile in order to read the freeWrap init file within it.
                                    if {[catch {::zvfs::mount $OutFile /buildCandidate} rtnval]} { return $rtnval }
                                    if {[catch {open /buildCandidate/_freewrap_init.txt r} fin]} { return $fin }
                                    gets $fin scriptPath
                                    gets $fin rev
                                    close $fin
#LISSI 
#puts "_freewrap_init.txt: scriptPath=$scriptPath] \n rev=$rev"

                                    set scriptFile [file tail $scriptPath]
                                    set cmdArgs {}
                                    if {[file tail $scriptPath] in {freewrap.tcl tkproe.tcl}} {
                                        # OutFile is, indeed, a freeWrap program.
                                        if {$scriptFile eq {tkproe.tcl}} {
                                            # OutFile is a freeWrapped version of TKproE.
                                            # Delete the TKproE files from the output file.
                                            set fpath [::zvfs::list /buildCandidate/*/tkproe.tcl]
											if {$fpath ne {}} {
												lappend cmdArgs [string range [file dirname $fpath] 16 end]/*
											   }
                                        }
                                    }
                                    ::zvfs::unmount $OutFile
                                    if {$cmdArgs ne {}} {
                                        set cmd "::freewrap::makeZIP $OutFile  -d $cmdArgs"
                                        if {[catch $cmd rtnval]} { return $rtnval }
                                    }

                                    # Update the _freewrap_init.txt file to run the user's application.
                                    set initFile [file join $tempDir _freewrap_init.txt]
                                    set fout [open $initFile w]
#LISSI 
				    if {$TPbuild(wrapper) == 0 } {

                                	puts $fout [file join /zvfs $srcFile]
				    } else {
					set dirsrc [file dirname $TPmainSrc]
					set listDir [split $dirsrc "/"]
					if {$typesys == "win32"} {
					    set listDir [string map {":" ""} $listDir]
#puts "dirsrc=$dirsrc\nlistDir=$listDir"
					    set dirsrc [eval [subst "file join $listDir"]]
					}
#puts "dirsrc=$dirsrc"
                                	puts $fout [file join $dirsrc $srcFile]
				    }

                                    puts $fout $rev
#puts "_freewrap_init.txt: [file join $dirsrc $srcFile] \n rev=$rev TPbuild(wrapper)=$TPbuild(wrapper)"
#puts "_freewrap_init.txt: [file join /zvfs $srcFile] \n rev=$rev \nTPbuild(wrapper)=$TPbuild(wrapper)"
                                    close $fout

                                    # Perform the wrapping.
                                    cd $tempDir
                                    set cmd "::freewrap::makeZIP $OutFile -$compression -e -r ."
                                    if {[catch $cmd rtnval]} { return $rtnval }

                                    # Move the file to its final name
                                    set finalFile [file join $TPbuild(destDir) $TPbuild(appName)_$targetOS$OSext]
                                    cd $curDir
                                    if {[catch {file rename -force $OutFile $finalFile} rtnval]} { return $rtnval }

                                    # Under Windows, replace the icons in the output file.
                                    set ICOfile [string trim $TPbuild(ICOfile)]
                                    if {$targetOS in {Win32 Win64} && $ICOfile ne {}} {
                                        catch {TP_iconReplace $finalFile $ICOfile [string range $targetOS 0 2]} rtnval]
                                        if {$rtnval ne {}} { return $rtnval }
                                       }
                                    }
                                }
                            }
                    }
         }

    # Remove the temporary directory
    cd $curDir
#puts "tempDir=$tempDir"
    catch {file delete -force $tempDir} rtnval
   } {
       set rtnval "This feature is only available when running a freeWrap based TCL/TK implementation."
     }
return $rtnval
}

proc TP_buildResetOpt {} {
    # Reset the Build options to their default value.
    global tcl_platform
    global TPbuild
    global TPprogFile
    
    set TPbuild(result) {}
    set TPbuild(destDir) [pwd]
    set TPbuild(appName) [file root [file tail $TPprogFile]]
    set TPbuild(buildType) buildEXE
    set TPbuild(IncludeFiles) {}
    set TPbuild(IncludeDir) {}
    set TPbuild(ICOfile) {}
    set TPbuild(compression) 9
    set TPbuild(Win32) 0
    set TPbuild(Win64) 0
    set TPbuild(Linux32) 0
    set TPbuild(Linux64) 0
    set TPbuild(Exec_Win32) {}
    set TPbuild(Exec_Win64) {}
    set TPbuild(Exec_Linux32) {}
    set TPbuild(Exec_Linux64) {}
#LISSI
    set TPbuild(EXTfile) {}
    set TPbuild(MacOS) 0
    set TPbuild(Exec_MacOS) {}
#    set TPbuild(wrapper) 1
    global macos

    switch $tcl_platform(platform) {
	unix	{
		  set bits [expr $tcl_platform(pointerSize) * 8]
#LISSI
		  if {!$macos} {

		  set targetOS Linux$bits
		  set TPbuild($targetOS) 1
		  set TPbuild(Exec_$targetOS) [info nameofexec]

		  } else {
		    set targetOS "MacOS"
		    set TPbuild($targetOS) 1
		    set TPbuild(Exec_$targetOS) [info nameofexec]
		  }

		}
	windows	{
		  set bits [expr $tcl_platform(pointerSize) * 8]
		  set targetOS Win$bits
		  set TPbuild($targetOS) 1
		  set TPbuild(Exec_$targetOS) [info nameofexec]
		}
           }
    set TPbuild(firstTime) 0
}

proc TP_iconReplace {filename newicon targetOS} {
# For MS Windows application files, replace the program icon.
global tcl_platform

set rtnval {}
set nSpaces [namespace children ::]
set OS [string trim $targetOS]
if {$OS eq {}} {
    set OS $tcl_platform(os)
   }
set OS [string range $OS 0 2]
if {$OS eq {Win} } {
     if {[string tolower [file normalize $filename]] == [string tolower [info nameofexec]]} {
         set rtnval "File in use, cannot be: [file normalize $filename]"
        } {
            # The source and destination files must exist.
            if {[file exists $filename] && [file exists $newicon]} {
                if {[catch {package require ico} result]} {
                    set rtnval $result
                    } {
                        set srcIconList [::ico::icons $newicon]
                        set totIcons [llength $srcIconList]
                        if {$totIcons != 1} {
                            set rtnval "Found $totIcons in $newicon. Cannot perform icon replacement."
                            } {
                                set destIconList [::ico::icons $filename]
                                set totIcons [llength $destIconList]
                                if {$totIcons != 1} {
                                    set rtnval "Found $totIcons in $filename. Cannot perform icon replacement."
                                    } {
                                        set srcImgs [::ico::iconMembers $newicon $srcIconList]
                                        set destImgs [::ico::iconMembers $filename $destIconList]
                                        set outstr {}
                                        # Match up the source and destination icon images having the same format.
                                        foreach srcImg $srcImgs {
                                                set lookFor [lrange $srcImg 1 end]
                                                foreach destImg $destImgs {
                                                        set imgType [lrange $destImg 1 end]
                                                        if {$imgType eq $lookFor} {
                                                            set indexFrom [lindex $srcImg 0]
                                                            set indexTo [lindex $destImg 0]
                                                            if {[catch {::ico::copyIcon $newicon $indexFrom $filename $indexTo} result]} {
                                                                append outstr $result\n
                                                                }
                                                            break
                                                        }
                                                    }
                                            }
                                        set rtnval $outstr
                                    }
                            }
                        }
               }
           }
   }
# Remove new namespaces created by this procedure.
set nSpacesNew [namespace children ::]
foreach nSpace $nSpacesNew {
        if {[nSpace ni $nSpaces]} {
            namespace delete $nSpace
           }
      }
return $rtnval
}


proc TP_GetConfig { param} {
# Return a TKproE configuration parameter
global TPinfo
global TPhomeDir

set rtnval {}
switch $param {
            dirTemplates	{
			  set rtnval [file join $TPhomeDir templates]
			  catch {file mkdir $rtnval}
			}
            progname		{
			  set rtnval $TPinfo(progname)
			}
            progrev		{
			  set rtnval $TPinfo(revision)
			}
            progdate		{
			  set rtnval $TPinfo(revdate)
			}
        }
return $rtnval
}


# Procedure: TP_GetFileFill
proc TP_GetFileFill { dirname} {
# Fill the tpgetfile dialog with the files from the specified directory.
global TPgetfile

if {[winfo exists .tpgetfile]} {
    if {[file isdirectory $dirname]} {
        set TPgetfile(dir) $dirname
        if {$TPgetfile(type) == {*.*}} {
              set wildcard {*}
          } { set wildcard $TPgetfile(type) }

        # Fill in list of subdirectories
        set dirlist [lsort -dictionary [glob -nocomplain -directory $dirname -types d *]]
        set wname .tpgetfile.frame2.frame0.listbox1
        $wname delete 0 end
        foreach dir $dirlist {
	     $wname insert end [file tail $dir]
	  }

        # Fill in list of files.
        set filelist [lsort -dictionary [glob -nocomplain -directory $dirname -types f $wildcard]]
        set wname .tpgetfile.frame2.frame.listbox1
        $wname delete 0 end
        foreach filename $filelist {
	     $wname insert end [file tail $filename]
	  }
       
      }
  }
}


# Procedure: TP_GetFileMkdir
proc TP_GetFileMkdir {} {
# Create a new subdirectory
global TPgetfile
global TPinput

set newdir [file join $TPgetfile(dir) $TPinput(value)]
if {[string length $newdir] > 0} {
    if {[catch {file mkdir $newdir} result]} {
           TP_ShowMsg $result
       } { TP_GetFileFill $TPgetfile(dir) } 
  }
}


# Procedure: TP_GridShowSticky
proc TP_GridShowSticky { posList} {
# Update the TPgridder sticky display.
global TPgrid
global TPgridChild

if {[winfo exists .tpgridder]} {
    foreach pos $posList {
        switch $pos {
	    N	{ set wname .tpgridder.frame42.frame1.frame30.frame23.button24 }
	    E	{ set wname .tpgridder.frame42.frame1.frame30.frame32.button29 }
	    W	{ set wname .tpgridder.frame42.frame1.frame30.frame32.button25 }
	    S	{ set wname .tpgridder.frame42.frame1.frame30.frame33.button24 }
                }
        set idx sticky$pos
        if {$TPgrid($idx)} {
            set TPgrid($idx) 0
           } { set TPgrid($idx) 1 }
       }
    set sval {}
    foreach pos {N S E W} {
	  switch $pos {
		N	{ set wname .tpgridder.frame42.frame1.frame30.frame23.button24 }
		E	{ set wname .tpgridder.frame42.frame1.frame30.frame32.button29 }
		W	{ set wname .tpgridder.frame42.frame1.frame30.frame32.button25 }
		S	{ set wname .tpgridder.frame42.frame1.frame30.frame33.button24 }
	          }
	   if {$TPgrid(sticky$pos)} {
	       append sval [string tolower $pos]
	       $wname configure -bg salmon
  	      } { $wname configure -bg #dcdcdc }
	}
    set wname .tpgridder.frame42.frame1.frame30.frame32.frame0
    switch $sval {
	{}	{ pack $wname -fill none -expand 1 -anchor center }
	n -
	e -
	w -
	s -
	ne -
	nw -
	se -
	sw	{ pack $wname -fill none -expand 1 -anchor $sval }
	ns	{ pack $wname -fill y -expand 1 -anchor n }
	ew	{ pack $wname -fill x -expand 1 -anchor w }
	new	{ pack $wname -fill x -expand 1 -anchor n }
	nse	{ pack $wname -fill y -expand 1 -anchor e }
	sew	{ pack $wname -fill x -expand 1 -anchor s }
	nsw	{ pack $wname -fill y -expand 1 -anchor w }
	nsew	{ pack $wname -fill both -expand 1 -anchor n }
            }
     if {[winfo exists $TPgridChild]} {
          grid $TPgridChild -sticky $sval
        }
   }
}

proc TP_helpHide {wname} {
# Hide the help windows.
if {[winfo exists .tppopuphelp]} {
    destroy .tppopuphelp
   }

return {}}

proc TP_helpShow {wname msg} {
# Hide the help windows.
global TPhelpmsg
#LISSI
#after 1500 [list TP_helpShowNow $wname $msg]
after 150 [list TP_helpShowNow $wname $msg]

return {}}

proc TP_helpShowNow {wname msg} {
# Hide the help windows.
    global TPhelpmsg
    global tcl_platform
    
    set Xpos [winfo pointerx $wname]
    set Ypos [winfo pointery $wname]
    set curwin [winfo containing $Xpos $Ypos]
    if {$curwin eq $wname} {
	set TPhelpmsg $msg
      if {![winfo exists .tppopuphelp]} {
#LISSI
    	set Xpos [winfo rootx $wname]
    	set Ypos [winfo rooty $wname]
#puts "wname=$wname Xpos=$Xpos Ypos=$Ypos Xpos=$Xpos Ypos=$Ypos"
#	set Xpos [expr {$Xpos + [winfo width $wname] / 2}]

        toplevel .tppopuphelp
        label .tppopuphelp.msg -font {Helvertica 8} -bg cornsilk -fg black -borderwidth 1 -relief solid -textvariable TPhelpmsg
        pack .tppopuphelp.msg -side top -fill x -anchor w
        incr Xpos 4
#LISSI
#        incr Ypos -8
	set Ypos [expr {$Ypos - ([font metrics {Helvertica 8} -ascent] + [font metrics {Helvertica 8} -descent])}]

        wm geometry .tppopuphelp +$Xpos+$Ypos
        wm overrideredirect .tppopuphelp 1
      }
   }
    return {}
}

proc TP_helpTeach {wname msg} {
#:LISSI
    if {[info exists ::freewrap::patchLevel]} {
	if {$::freewrap::patchLevel == "6.63"} {
	    TP_popupHint $wname $msg
	    return {}
	}
    }

# Create the necessary bindings for pop-up help on the specified widget.
if {[winfo exists $wname]} {
    bind $wname <Enter> [list TP_helpShow %W $msg]
    bind $wname <Leave> [list TP_helpHide %W]
   }

return {}
}

# Procedure: TP_IconLibShow
proc TP_IconLibShow {} {
# Display the currently selected icon library.
global TPselTheme
global TPimglibList
global fin
global TPhomeDir

if {![winfo exists .tpiconlib]} { ShowWindow.tpiconlib }
.tpiconlib.frame0.canvas2 delete all
catch "image delete $TPimglibList"
set fname [file join $TPhomeDir lib icons tkIcons$TPselTheme]
if {[catch {open $fname r} fin]} {
    puts $fin
  } {
       # Read icon information from file
       set imgno 0
       set ypos 0
       set imgname {}
       set TPimglibList {}
       while {![eof $fin]} {
	  gets $fin line
	  set record [split $line {:}]
	  set imgname tplib_[lindex $record 0]

	  # Create image from  data
	  image create photo $imgname -data [lindex $record 4]
	  lappend TPimglibList $imgname

	  # Create icon on the display canvas
	  set xpos [expr ($imgno % 14) * 36 + 8]
	  set ypos [expr ($imgno / 14) * 36 + 4]
	  .tpiconlib.frame0.canvas2 create image $xpos $ypos -image $imgname -anchor nw

	  incr imgno
	  set imgname {}
	}

       close $fin
       incr ypos 25
       .tpiconlib.frame0.canvas2 configure -scrollregion [list 0 0 584 $ypos]
    }
}


# Procedure: TP_IconMake
proc TP_IconMake { imgname} {
# Create a user image from the specified icon library item
global TPimage

if {[string length $imgname] != 0} {
    ShowWindow.tpimages
    set TPimage(name) [string range $imgname 6 end]
    if {[catch {$imgname cget -data} TPimage(data)]} { set TPimage(data) {} }
    set TPimage(type) photo
    set TPimage(embed) 1
   }
}


# Procedure: TP_ImageDecode
proc TP_ImageDecode { encodedString} {
# Code taken from base64.tcl in tcllib 1.3
#
# Encode/Decode base64 for a string
# Stephen Uhler / Brent Welch (c) 1997 Sun Microsystems
# The decoder was done for exmh by Chris Garrigues
#
# Copyright (c) 1998-2000 by Ajuba Solutions.
# See the file "license.terms" for information on usage and redistribution
# of this file, and for a DISCLAIMER OF ALL WARRANTIES.
#

if {[string length $encodedString] == 0} {return {}}

set i 0
foreach char {A B C D E F G H I J K L M N O P Q R S T U V W X Y Z  a b c d e f g h i j k l m n o p q r s t u v w x y z  0 1 2 3 4 5 6 7 8 9 + /} {
    set base64_tmp($char) $i
    incr i
}

#
# Create base64 as list: to code for instance C<->3, specify
# that [lindex $base64 67] be 3 (C is 67 in ascii); non-coded
# ascii chars get a {}. we later use the fact that lindex on a
# non-existing index returns {}, and that [expr {} < 0] is true
#

# the last ascii char is 'z'
scan z %c len
for {set i 0} {$i <= $len} {incr i} {
    set char [format %c $i]
    set val {}
    if {[info exists base64_tmp($char)]} {
	set val $base64_tmp($char)
    } else {
	set val {}
    }
    lappend base64 $val
}

# code the character "=" as -1; used to signal end of message
scan = %c i
set base64 [lreplace $base64 $i $i -1]

binary scan $encodedString c* X
foreach x $X {
    set bits [lindex $base64 $x]
    if {$bits >= 0} {
	if {[llength [lappend nums $bits]] == 4} {
	    foreach {v w z y} $nums break
	    set a [expr {($v << 2) | ($w >> 4)}]
	    set b [expr {(($w & 0xF) << 4) | ($z >> 2)}]
	    set c [expr {(($z & 0x3) << 6) | $y}]
	    append output [binary format ccc $a $b $c]
	    set nums {}
	}
    } elseif {$bits == -1} {
	# = indicates end of data.  Output whatever chars are left.
	# The encoding algorithm dictates that we can only have 1 or 2
	# padding characters.  If x=={}, we have 12 bits of input 
	# (enough for 1 8-bit output).  If x!={}, we have 18 bits of
	# input (enough for 2 8-bit outputs).
		
	foreach {v w z} $nums break
	set a [expr {($v << 2) | (($w & 0x30) >> 4)}]

	if {$z == {}} {
	    append output [binary format c $a ]
	} else {
	    set b [expr {(($w & 0xF) << 4) | (($z & 0x3C) >> 2)}]
	    append output [binary format cc $a $b]
	}
	break
    } else {
	# RFC 2045 says that line breaks and other characters not part
	# of the Base64 alphabet must be ignored, and that the decoder
	# can optionally emit a warning or reject the message.  We opt
	# not to do so, but to just ignore the character.
	continue
    }
}
return $output
}


# Procedure: TP_ImageEncode
proc TP_ImageEncode { args} {
# Code taken from base64.tcl in tcllib 1.3
#
# Encode/Decode base64 for a string
# Stephen Uhler / Brent Welch (c) 1997 Sun Microsystems
# The decoder was done for exmh by Chris Garrigues
#
# Copyright (c) 1998-2000 by Ajuba Solutions.
# See the file "license.terms" for information on usage and redistribution
# of this file, and for a DISCLAIMER OF ALL WARRANTIES.
#

set base64_en {A B C D E F G H I J K L M N O P Q R S T U V W X Y Z a b c d e f g h i j k l m n o p q r s t u v w x y z 0 1 2 3 4 5 6 7 8 9 + /}

# Set the default wrapchar and maximum line length to match the output
# of GNU uuencode 4.2.  Various RFC's allow for different wrapping
# characters and wraplengths, so these may be overridden by command line
# options.
set wrapchar "\n"
set maxlen 60

if { [llength $args] == 0 } {
    error "wrong # args: should be \"[lindex [info level 0] 0] ?-maxlen maxlen? ?-wrapchar wrapchar? string\""
}

set optionStrings [list "-maxlen" "-wrapchar"]
for {set i 0} {$i < [llength $args] - 1} {incr i} {
    set arg [lindex $args $i]
    set index [lsearch -glob $optionStrings "${arg}*"]
    if { $index == -1 } {
	error "unknown option \"$arg\": must be -maxlen or -wrapchar"
    }
    incr i
    if { $i >= [llength $args] - 1 } {
	error "value for \"$arg\" missing"
    }
    set val [lindex $args $i]

    # The name of the variable to assign the value to is extracted
    # from the list of known options, all of which have an
    # associated variable of the same name as the option without
    # a leading "-". The [string range] command is used to strip
    # of the leading "-" from the name of the option.
    #
    # FRINK: nocheck
    set [string range [lindex $optionStrings $index] 1 end] $val
}

# [string is] requires Tcl8.2; this works with 8.0 too
if {[catch {expr {$maxlen % 2}}]} {
    error "expected integer but got \"$maxlen\""
}

set string [lindex $args end]

set result {}
set state 0
set length 0

# Process the input bytes 3-by-3
binary scan $string c* X
foreach {x y z} $X {
    # Do the line length check before appending so that we don't get an
    # extra newline if the output is a multiple of $maxlen chars long.
    if {$maxlen && $length >= $maxlen} {
	append result $wrapchar
	set length 0
    }

    append result [lindex $base64_en [expr {($x >>2) & 0x3F}]]
    if {$y != {}} {
	append result [lindex $base64_en [expr {(($x << 4) & 0x30) | (($y >> 4) & 0xF)}]]
	if {$z != {}} {
	    append result  [lindex $base64_en [expr {(($y << 2) & 0x3C) | (($z >> 6) & 0x3)}]]
	    append result [lindex $base64_en [expr {($z & 0x3F)}]]
	} else {
	    set state 2
	    break
	}
    } else {
	set state 1
	break
    }
    incr length 4
}
if {$state == 1} {
    append result [lindex $base64_en [expr {(($x << 4) & 0x30)}]]== 
} elseif {$state == 2} {
    append result [lindex $base64_en [expr {(($y << 2) & 0x3C)}]]=
}
return $result
}


# Procedure: TP_ImageInsert
proc TP_ImageInsert {} {
# Insert the currently defined image.
global TPimage
global TPimgNamespace

if {[file isfile $TPimage(file)]} {
    # Establish a name for the image
    set name [string trim $TPimage(name)]
    if {[string length $name] == 0} {
        # base name on root name of the image file
        set name [file root [file tail $TPimage(file)]]
       }

    if {$TPimgNamespace != {::}} { set name ${TPimgNamespace}::$name }
    
    switch $TPimage(type) {
	bitmap	{
		  if {$TPimage(embed)} {
		      set fin [open $TPimage(file)]
		      set data [read $fin]
		      close $fin
		      set cmdOpt(data) " -data \{$data\} -file \{\}"
		    } {
		        set cmdOpt(file) " -data \{\} -file \{$TPimage(file)\}"
		      }

		  foreach {opt defval} {background {} foreground black maskdata {} maskfile {}} {
			if {[string length [string trim $TPimage($opt)]] == 0} {
			      set cmdOpt($opt) " -$opt \{$defval\}"
			      set TPimage($opt) [lindex $defval 0]
			  } { set cmdOpt($opt) " -$opt \{$TPimage($opt)\}" }
		           }
		  # Build image creation command
		  set cmd "image create bitmap $name"
		  foreach opt [array names cmdOpt] {
			append cmd $cmdOpt($opt)
		           }
		}
	photo	{
		  if {$TPimage(embed)} {
		      set fin [open $TPimage(file)]
		      fconfigure $fin -translation binary
		      set data [TP_ImageEncode [read $fin]]
		      close $fin
		      set cmdOpt(data) " -data \{\n$data\n\}"
		    } {
		        set cmdOpt(file) " -file \{$TPimage(file)\}"
		      }

		  foreach {opt defval} {format {} gamma 1.0 height 0 palette {} width 0} {
			if {[string length [string trim $TPimage($opt)]] == 0} {
			      set cmdOpt($opt) " -$opt \{$defval\}"
			      set TPimage($opt) [lindex $defval 0]
			  } { set cmdOpt($opt) " -$opt \{$TPimage($opt)\}" }
		           }
		  # Build image creation command
		  set cmd "image create photo $name"
		  foreach opt [array names cmdOpt] {
			append cmd $cmdOpt($opt)
		           }
		}
	default	{ return {} }
            }

    # Execute image creation command
    if {[catch $cmd result]} { puts $result }
  } {
       # To create the image, use the data provided instead of a file.
       set name [string trim $TPimage(name)]
       if {[string length $name] > 0 && [string length $TPimage(data)] > 0} {
           if {$TPimgNamespace != {::}} { set name ${TPimgNamespace}::$name }
           set TPimage(embed) 1

           switch $TPimage(type) {
	       bitmap {
 		    foreach {opt defval} {background {} foreground black maskdata {} maskfile {}} {
			if {[string length [string trim $TPimage($opt)]] == 0} {
			      set cmdOpt($opt) " -$opt \{$defval\}"
			      set TPimage($opt) [lindex $defval 0]
			  } { set cmdOpt($opt) " -$opt \{$TPimage($opt)\}" }
		           }
		    # Build image creation command
		    set cmd "image create bitmap $name -data \$TPimage(data)"
		    foreach opt [array names cmdOpt] {
			append cmd $cmdOpt($opt)
		               }
		    }
 	       photo  {
		    foreach {opt defval} {format {} gamma 1.0 height 0 palette {} width 0} {
			  if {[string length [string trim $TPimage($opt)]] == 0} {
			      set cmdOpt($opt) " -$opt \{$defval\}"
			      set TPimage($opt) [lindex $defval 0]
			     } { set cmdOpt($opt) " -$opt \{$TPimage($opt)\}" }
			}
		    # Build image creation command
		    set cmd "image create photo $name -data \$TPimage(data)"
		    foreach opt [array names cmdOpt] { append cmd $cmdOpt($opt) }
		   }
	       default { return {} }
 	     }
        
           # Execute image creation command
           if {[catch $cmd result]} { puts $result }
#LISSI
	   if {$TPimage(screenshot)} {
		.tpimages.frame5.screenshot configure -state normal
		set TPimage(screenshot) 0
		.tpimages.frame5.screenshot configure -state disabled
		.tpimages.propphoto.frame14.entry13 configure -state normal
		.tpimages.propphoto.frame14.entry13  delete 0 end
	   }

         }
    }
return {}
}


# Procedure: TP_ImageMod
proc TP_ImageMod {} {
# Modify the options for the currently selected image.
global TPimage
global TPimgNamespace

if {[file isfile $TPimage(file)]} {
    # Establish a name for the image
    set name [string trim $TPimage(name)]
    if {[string length $name] == 0} { return {} }

    if {$TPimgNamespace != {::}} { set name ${TPimgNamespace}::$name }
#LISSI
    if {[lsearch [image names] $name] == -1} {
   # The image not exists
	return {}
    }

    if {[image type $name] != $TPimage(type)} {
        TP_ShowMsg "Cannot reconfigure the image to a different type.\n\nInstead, you must delete then re-add the image as the new type."
        return {}
      }

   switch $TPimage(type) {
	bitmap	{
		  if {$TPimage(embed)} {
		      set fin [open $TPimage(file)]
		      set data [read $fin]
		      close $fin
		      set cmdOpt(data) " -data \{$data\} -file \{\}"
		    } {
		        set cmdOpt(file) " -data \{\} -file \{$TPimage(file)\}"
		      }

		  foreach {opt defval} {background {} foreground black maskdata {} maskfile {}} {
			if {[string length [string trim $TPimage($opt)]] == 0} {
			      set cmdOpt($opt) " -$opt \{$defval\}"
			      set TPimage($opt) [lindex $defval 0]
			  } { set cmdOpt($opt) " -$opt \{$TPimage($opt)\}" }
		           }
		  # Build image configure command
		  set cmd "$name configure"
		  foreach opt [array names cmdOpt] {
			append cmd $cmdOpt($opt)
		           }
		}
	photo	{
		  if {$TPimage(embed)} {
		      set fin [open $TPimage(file)]
		      fconfigure $fin -translation binary
		      set data [TP_ImageEncode [read $fin]]
		      close $fin
		      set cmdOpt(data) " -data \{\n$data\n\} -file \{\}"
		    } {
		        set cmdOpt(file) " -data \{\} -file \{$TPimage(file)\}"
		      }

		  foreach {opt defval} {format {} gamma 1.0 height 0 palette {} width 0} {
			if {[string length [string trim $TPimage($opt)]] == 0} {
			      set cmdOpt($opt) " -$opt \{$defval\}"
			      set TPimage($opt) [lindex $defval 0]
			  } { set cmdOpt($opt) " -$opt \{$TPimage($opt)\}" }
		           }
		  # Build image creation command
		  set cmd "$name configure"
		  foreach opt [array names cmdOpt] {
			append cmd $cmdOpt($opt)
		           }
		}
	default	{ return {} }
            }

    # Execute image creation command
    if {[catch $cmd result]} { puts $result }
  }   else {
#LISSI
    # Establish a name for the image
    set name [string trim $TPimage(name)]
    if {[string length $name] == 0} { return {} }

    if {$TPimgNamespace != {::}} { set name ${TPimgNamespace}::$name }
#puts "Modify: name=$name  format=$TPimage(format)"
    if {[lsearch [image names] $name] == -1} {
# The image not exists
	return {}
    }

    if {[image type $name] != $TPimage(type)} {
        TP_ShowMsg "Cannot reconfigure the image to a different type.\n\nInstead, you must delete then re-add the image as the new type."
        return {}
      }
#    if {$TPimage(type) != "photo" && $TPimage(type) != "bitmap"} {}
    if {$TPimage(type) != "photo" } {
	return {}
    }
    set data [$name configure -data]
    set cmdOpt(data) " -data \{\n[lindex $data 4]\n\} "
    foreach {opt defval} {format {} gamma 1.0 height 0 palette {} width 0} {
	if {[string length [string trim $TPimage($opt)]] == 0} {
	    set cmdOpt($opt) " -$opt \{$defval\}"
	    set TPimage($opt) [lindex $defval 0]
	} { set cmdOpt($opt) " -$opt \{$TPimage($opt)\}" }
    }
    # Build image creation command
    set cmd "image create photo $name;$name configure"
    foreach opt [array names cmdOpt] {
	append cmd $cmdOpt($opt)
    }

    # Execute image creation command
    image delete $name
    if {[catch $cmd result]} { puts $result }
  }

return {}
}

# Procedure: TP_ImageSelect
proc TP_ImageSelect { imageName} {
# Select the specified image as the current one.
global TPimage
global TPimgNamespace

if {$TPimgNamespace == {::} } {
    set imgName $imageName
  } { set imgName ${TPimgNamespace}::$imageName }

if {[lsearch [image names] $imgName] >= 0} {
    # We have a valid image name
    set TPimage(type) [image type $imgName]
#LISSI*
#    .tpimages.frame.label5 configure -image $imgName
    .tpimages.frame.label5 configure -image $imgName  -anchor nw

    switch $TPimage(type) {
	bitmap	{
		  if {[winfo exists .tpimages]} {
		       pack forget .tpimages.propphoto
		       pack .tpimages.propbitmap -after .tpimages.frame5 -side top -fill x
		     }
		  set TPimage(name) $imageName
		  foreach optionInfo [$imgName configure] {
			set optname [string range [lindex $optionInfo 0] 1 end]
			set optvalue [lindex $optionInfo 4]
			set TPimage($optname) $optvalue
		           }
		  if {[string length $TPimage(data)] == 0} {
		      set TPimage(embed) 0
		    } { set TPimage(embed) 1 }
		}
	photo	{
		  if {[winfo exists .tpimages]} {
		      pack forget .tpimages.propbitmap
		      pack .tpimages.propphoto -after .tpimages.frame5 -side top -fill x
		     }
		  set TPimage(name) $imageName
		  foreach optionInfo [$imgName configure] {
			set optname [string range [lindex $optionInfo 0] 1 end]
			set optvalue [lindex $optionInfo 4]
			set TPimage($optname) $optvalue
		           }
		  if {[string length $TPimage(data)] == 0} {
		      set TPimage(embed) 0
		    } { set TPimage(embed) 1 }
		}
            }
  }
}


# Procedure: TP_ImageToData
proc TP_ImageToData { imgname} {
# Convert the specified image to use embedded data.

if {[lsearch [image names] $imgname] != -1} {
   # The image exists
   set filename [$imgname cget -file]
   if {[file isfile $filename]} {
       # We found the image file
       set fin [open $filename]
       fconfigure $fin -translation binary
       if {[image type $imgname] == {bitmap}} {
           set data [read $fin]
          } { set data [TP_ImageEncode [read $fin]] }
       close $fin
       set cmd "$imgname configure -data \{$data\} -file \{\}"
       if {[catch $cmd result]} { puts $result }
      }
   }

return {}
}


# Procedure: TP_ImgListFill
proc TP_ImgListFill {} {
#
global TPimgNamespace
global TPimgNamespacePrefix

.tpimages.frame.listbox1 delete 0 end
eval ".tpimages.frame.listbox1 insert end [TP_ImgListGet]"
if {$TPimgNamespace == {::}} {
    set TPimgNamespacePrefix {::}
  } {
      set TPimgNamespacePrefix ${TPimgNamespace}::
    }
}


# Procedure: TP_ImgListFill2
proc TP_ImgListFill2 {} {
#

global TPimgSelNamespace
global TPimgSelNamespacePrefix
global TPimageSel

.tpimagesel.frame.listbox1 delete 0 end
foreach imgName [TP_ImgListGet2] {
	if {[string trim $TPimageSel(findstr)] == {}} {
	    .tpimagesel.frame.listbox1 insert end $imgName
	  } elseif {[string first $TPimageSel(findstr) $imgName] > -1} {
		.tpimagesel.frame.listbox1 insert end $imgName
	            }
         }

if {$TPimgSelNamespace == {::}} {
    set TPimgSelNamespacePrefix {::}
  } {
      set TPimgSelNamespacePrefix ${TPimgSelNamespace}::
    }
}


# Procedure: TP_ImgListGet
proc TP_ImgListGet {} {
# Retrieve a list of all images created by the application.
global auto_index
global TPimgNamespace
global TPexclusions
global TPimglibList

set rtnval {}
if {$TPimgNamespace != {::}} {
      set prefix ${TPimgNamespace}::
      set namestart [string length $TPimgNamespace]
      incr namestart 2
    }
foreach varname [image names] {
	set reason 0

	if {$TPimgNamespace == {::}} {
	    if {[string index $varname 0] != {:}} {
	        # Exclude the TKproE images from the list.
	        if {([lsearch $TPexclusions(images) $varname] == -1) && ([lsearch $TPimglibList $varname] == -1)} {
	            lappend rtnval $varname
	           }
	       }
	  } {
	       set pos [string first $prefix $varname]
	       if {$pos == 0} {
	           if {[regexp -all {:} [string range $varname $namestart end] ] == 0} {
		 lappend rtnval [string range $varname $namestart end]
		}
	         }
	    }
        }
return [lsort $rtnval]
}


# Procedure: TP_ImgListGet2
proc TP_ImgListGet2 {} {
# Retrieve a list of all images created by the application.
global auto_index
global TPimgSelNamespace
global TPexclusions

set rtnval {}
if {$TPimgSelNamespace != {::}} {
      set prefix ${TPimgSelNamespace}::
      set namestart [string length $TPimgSelNamespace]
      incr namestart 2
    }
foreach imgname [image names] {
	set reason 0

	if {$TPimgSelNamespace == {::}} {
	    if {[string index $imgname 0] != {:}} {
	         if {$imgname ni $TPexclusions(images)} { lappend rtnval $imgname }
	       }
	  } {
	       set pos [string first $prefix $imgname]
	       if {$pos == 0} {
	           if {[regexp -all {:} [string range $imgname $namestart end] ] == 0} {
		 lappend rtnval [string range $imgname $namestart end]
		}
	         }
	    }
        }
return [lsort $rtnval]
}


# Procedure: TP_InfoGetHomeDir
proc TP_InfoGetHomeDir {} {
# Locate TKproE home directory.
global argv0

set docfile TKproEdocs.pdf
set orgdir [pwd]

# Check whether we are dealing with a freeWrap version of TKproE.
if {[namespace exists freewrap]} {
    if {$::freewrap::runMode eq {wrappedExec}} {
        set curdir [file dirname [::zvfs::list *tkproe.tcl]]
		return $curdir
	   }
   }

# Check whether TKproE is being run with a wish shell from the command line.
set curdir [file dirname $argv0]
set fpath [file join $curdir $docfile]
if {[file isfile $fpath]} { cd $orgdir; return $curdir }

# Check name of executable.
set curdir [file dirname [info nameofexec]]
set fpath [file join $curdir $docfile]
if {[file isfile $fpath]} { cd $orgdir; return $curdir }

# Check whether TKproE is the currently executing script.
set curdir [file dirname [info script]]
set fpath [file join $curdir $docfile]
if {[file isfile $fpath]} { cd $orgdir; return $curdir }

# Check current directory
set curdir [pwd]
set fpath [file join $curdir $docfile]
if {[file isfile $fpath]} { cd $orgdir; return $curdir }

cd $orgdir
return {}
}


# Procedure: TP_InitGlobals
proc TP_InitGlobals {} {
  global {TPB1_motion_list}
  set {TPB1_motion_list} {}
  global {TPB1_press_list}
  set {TPB1_press_list} {}
  global {TPB1_release_list}
  set {TPB1_release_list} {}
  global {TPCanvasObj}
  set {TPCanvasObj(-activedash)} {}
  set {TPCanvasObj(-activefill)} {}
  set {TPCanvasObj(-activestipple)} {}
  set {TPCanvasObj(-activewidth)} {0.0}
  set {TPCanvasObj(-anchor)} {c}
  set {TPCanvasObj(-arrow)} {none}
  set {TPCanvasObj(-arrowshape)} {8 10 3}
  set {TPCanvasObj(-capstyle)} {butt}
  set {TPCanvasObj(-dash)} {}
  set {TPCanvasObj(-dashoffset)} {0}
  set {TPCanvasObj(-disableddash)} {}
  set {TPCanvasObj(-disabledfill)} {}
  set {TPCanvasObj(-disabledstipple)} {}
  set {TPCanvasObj(-disabledwidth)} {0.0}
  set {TPCanvasObj(-fill)} {black}
  set {TPCanvasObj(-image)} {}
  set {TPCanvasObj(-joinstyle)} {miter}
  set {TPCanvasObj(-justify)} {}
  set {TPCanvasObj(-offset)} {0,0}
  set {TPCanvasObj(-smooth)} {0}
  set {TPCanvasObj(-splinesteps)} {12}
  set {TPCanvasObj(-state)} {}
  set {TPCanvasObj(-stipple)} {}
  set {TPCanvasObj(-style)} {last}
  set {TPCanvasObj(-tags)} {firstline}
  set {TPCanvasObj(-width)} {3.0}
  global {TPTPcurCanvasorg}
  set {TPTPcurCanvasorg} {}
  global {TP_Clone_bindtagslist}
  set {TP_Clone_bindtagslist} {}
  global {TP_DTcolor_stretch}
  set {TP_DTcolor_stretch} {yellow}
  global {TP_DTobjcur}
  set {TP_DTobjcur} {}
  global {TPautosaveDir}
  set {TPautosaveDir} {}
  global {TPautosaveInterval}
  set {TPautosaveInterval} {10}
  global {TPbind}
  set {TPbind(configure)} {<Shift-Button-3>}
  global {TPbindEvent}
  set {TPbindEvent} {}
  global {TPbindKeyMsg}
  set {TPbindKeyMsg} {To insert key symbol, press key while mouse is on this label.}
  global {TPcanvasID}
  set {TPcanvasID} {1}
  global {TPcanvasTool}
  set {TPcanvasTool} {None}
  global {TPcfgCmd}
  set {TPcfgCmd} {.button0 configure -image}
  global {TPcolor}
  set {TPcolor(blue)} {255}
  set {TPcolor(green)} {196}
  set {TPcolor(label)} {.tpcolorsel.top.right.color}
  set {TPcolor(red)} {0}
  set {TPcolor(rgb)} {#00C4FF}
  set {TPcolor(varname)} {TPcvPropsStandard(fill)}
  global {TPcolorCmd}
  set {TPcolorCmd} {}
  global {TPcolorList}
  set {TPcolorList} {{snow 255 250 250} {GhostWhite 248 248 255} {WhiteSmoke 245 245 245} {gainsboro 220 220 220} {FloralWhite 255 250 240} {OldLace 253 245 230} {linen 250 240 230} {AntiqueWhite 250 235 215} {PapayaWhip 255 239 213} {BlanchedAlmond 255 235 205} {bisque 255 228 196} {PeachPuff 255 218 185} {NavajoWhite 255 222 173} {moccasin 255 228 181} {cornsilk 255 248 220} {ivory 255 255 240} {LemonChiffon 255 250 205} {seashell 255 245 238} {honeydew 240 255 240} {MintCream 245 255 250} {azure 240 255 255} {AliceBlue 240 248 255} {lavender 230 230 250} {LavenderBlush 255 240 245} {MistyRose 255 228 225} {white 255 255 255} {black 0 0 0} {DarkSlateGray 47 79 79} {DarkSlateGrey 47 79 79} {DimGray 105 105 105} {DimGrey 105 105 105} {SlateGray 112 128 144} {SlateGrey 112 128 144} {LightSlateGray 119 136 153} {LightSlateGrey 119 136 153} {gray 190 190 190} {grey 190 190 190} {LightGrey 211 211 211} {LightGray 211 211 211} {MidnightBlue 25 25 112} {navy 0 0 128} {NavyBlue 0 0 128} {CornflowerBlue 100 149 237} {DarkSlateBlue 72 61 139} {SlateBlue 106 90 205} {MediumSlateBlue 123 104 238} {LightSlateBlue 132 112 255} {MediumBlue 0 0 205} {RoyalBlue 65 105 225} {blue 0 0 255} {DodgerBlue 30 144 255} {DeepSkyBlue 0 191 255} {SkyBlue 135 206 235} {LightSkyBlue 135 206 250} {SteelBlue 70 130 180} {LightSteelBlue 176 196 222} {LightBlue 173 216 230} {PowderBlue 176 224 230} {PaleTurquoise 175 238 238} {DarkTurquoise 0 206 209} {MediumTurquoise 72 209 204} {turquoise 64 224 208} {cyan 0 255 255} {LightCyan 224 255 255} {CadetBlue 95 158 160} {MediumAquamarine 102 205 170} {aquamarine 127 255 212} {DarkGreen 0 100 0} {DarkOliveGreen 85 107 47} {DarkSeaGreen 143 188 143} {SeaGreen 46 139 87} {MediumSeaGreen 60 179 113} {LightSeaGreen 32 178 170} {PaleGreen 152 251 152} {SpringGreen 0 255 127} {LawnGreen 124 252 0} {green 0 255 0} {chartreuse 127 255 0} {MediumSpringGreen 0 250 154} {GreenYellow 173 255 47} {LimeGreen 50 205 50} {YellowGreen 154 205 50} {ForestGreen 34 139 34} {OliveDrab 107 142 35} {DarkKhaki 189 183 107} {khaki 240 230 140} {PaleGoldenrod 238 232 170} {LightGoldenrodYellow 250 250 210} {LightYellow 255 255 224} {yellow 255 255 0} {gold 255 215 0} {LightGoldenrod 238 221 130} {goldenrod 218 165 32} {DarkGoldenrod 184 134 11} {RosyBrown 188 143 143} {IndianRed 205 92 92} {SaddleBrown 139 69 19} {sienna 160 82 45} {peru 205 133 63} {burlywood 222 184 135} {beige 245 245 220} {wheat 245 222 179} {SandyBrown 244 164 96} {tan 210 180 140} {chocolate 210 105 30} {firebrick 178 34 34} {brown 165 42 42} {DarkSalmon 233 150 122} {salmon 250 128 114} {LightSalmon 255 160 122} {orange 255 165 0} {DarkOrange 255 140 0} {coral 255 127 80} {LightCoral 240 128 128} {tomato 255 99 71} {OrangeRed 255 69 0} {red 255 0 0} {HotPink 255 105 180} {DeepPink 255 20 147} {pink 255 192 203} {LightPink 255 182 193} {PaleVioletRed 219 112 147} {maroon 176 48 96} {MediumVioletRed 199 21 133} {VioletRed 208 32 144} {magenta 255 0 255} {violet 238 130 238} {plum 221 160 221} {orchid 218 112 214} {MediumOrchid 186 85 211} {DarkOrchid 153 50 204} {DarkViolet 148 0 211} {BlueViolet 138 43 226} {purple 160 32 240} {MediumPurple 147 112 219} {thistle 216 191 216} {snow1 255 250 250} {snow2 238 233 233} {snow3 205 201 201} {snow4 139 137 137} {seashell1 255 245 238} {seashell2 238 229 222} {seashell3 205 197 191} {seashell4 139 134 130} {AntiqueWhite1 255 239 219} {AntiqueWhite2 238 223 204} {AntiqueWhite3 205 192 176} {AntiqueWhite4 139 131 120} {bisque1 255 228 196} {bisque2 238 213 183} {bisque3 205 183 158} {bisque4 139 125 107} {PeachPuff1 255 218 185} {PeachPuff2 238 203 173} {PeachPuff3 205 175 149} {PeachPuff4 139 119 101} {NavajoWhite1 255 222 173} {NavajoWhite2 238 207 161} {NavajoWhite3 205 179 139} {NavajoWhite4 139 121 94} {LemonChiffon1 255 250 205} {LemonChiffon2 238 233 191} {LemonChiffon3 205 201 165} {LemonChiffon4 139 137 112} {cornsilk1 255 248 220} {cornsilk2 238 232 205} {cornsilk3 205 200 177} {cornsilk4 139 136 120} {ivory1 255 255 240} {ivory2 238 238 224} {ivory3 205 205 193} {ivory4 139 139 131} {honeydew1 240 255 240} {honeydew2 224 238 224} {honeydew3 193 205 193} {honeydew4 131 139 131} {LavenderBlush1 255 240 245} {LavenderBlush2 238 224 229} {LavenderBlush3 205 193 197} {LavenderBlush4 139 131 134} {MistyRose1 255 228 225} {MistyRose2 238 213 210} {MistyRose3 205 183 181} {MistyRose4 139 125 123} {azure1 240 255 255} {azure2 224 238 238} {azure3 193 205 205} {azure4 131 139 139} {SlateBlue1 131 111 255} {SlateBlue2 122 103 238} {SlateBlue3 105 89 205} {SlateBlue4 71 60 139} {RoyalBlue1 72 118 255} {RoyalBlue2 67 110 238} {RoyalBlue3 58 95 205} {RoyalBlue4 39 64 139} {blue1 0 0 255} {blue2 0 0 238} {blue3 0 0 205} {blue4 0 0 139} {DodgerBlue1 30 144 255} {DodgerBlue2 28 134 238} {DodgerBlue3 24 116 205} {DodgerBlue4 16 78 139} {SteelBlue1 99 184 255} {SteelBlue2 92 172 238} {SteelBlue3 79 148 205} {SteelBlue4 54 100 139} {DeepSkyBlue1 0 191 255} {DeepSkyBlue2 0 178 238} {DeepSkyBlue3 0 154 205} {DeepSkyBlue4 0 104 139} {SkyBlue1 135 206 255} {SkyBlue2 126 192 238} {SkyBlue3 108 166 205} {SkyBlue4 74 112 139} {LightSkyBlue1 176 226 255} {LightSkyBlue2 164 211 238} {LightSkyBlue3 141 182 205} {LightSkyBlue4 96 123 139} {SlateGray1 198 226 255} {SlateGray2 185 211 238} {SlateGray3 159 182 205} {SlateGray4 108 123 139} {LightSteelBlue1 202 225 255} {LightSteelBlue2 188 210 238} {LightSteelBlue3 162 181 205} {LightSteelBlue4 110 123 139} {LightBlue1 191 239 255} {LightBlue2 178 223 238} {LightBlue3 154 192 205} {LightBlue4 104 131 139} {LightCyan1 224 255 255} {LightCyan2 209 238 238} {LightCyan3 180 205 205} {LightCyan4 122 139 139} {PaleTurquoise1 187 255 255} {PaleTurquoise2 174 238 238} {PaleTurquoise3 150 205 205} {PaleTurquoise4 102 139 139} {CadetBlue1 152 245 255} {CadetBlue2 142 229 238} {CadetBlue3 122 197 205} {CadetBlue4 83 134 139} {turquoise1 0 245 255} {turquoise2 0 229 238} {turquoise3 0 197 205} {turquoise4 0 134 139} {cyan1 0 255 255} {cyan2 0 238 238} {cyan3 0 205 205} {cyan4 0 139 139} {DarkSlateGray1 151 255 255} {DarkSlateGray2 141 238 238} {DarkSlateGray3 121 205 205} {DarkSlateGray4 82 139 139} {aquamarine1 127 255 212} {aquamarine2 118 238 198} {aquamarine3 102 205 170} {aquamarine4 69 139 116} {DarkSeaGreen1 193 255 193} {DarkSeaGreen2 180 238 180} {DarkSeaGreen3 155 205 155} {DarkSeaGreen4 105 139 105} {SeaGreen1 84 255 159} {SeaGreen2 78 238 148} {SeaGreen3 67 205 128} {SeaGreen4 46 139 87} {PaleGreen1 154 255 154} {PaleGreen2 144 238 144} {PaleGreen3 124 205 124} {PaleGreen4 84 139 84} {SpringGreen1 0 255 127} {SpringGreen2 0 238 118} {SpringGreen3 0 205 102} {SpringGreen4 0 139 69} {green1 0 255 0} {green2 0 238 0} {green3 0 205 0} {green4 0 139 0} {chartreuse1 127 255 0} {chartreuse2 118 238 0} {chartreuse3 102 205 0} {chartreuse4 69 139 0} {OliveDrab1 192 255 62} {OliveDrab2 179 238 58} {OliveDrab3 154 205 50} {OliveDrab4 105 139 34} {DarkOliveGreen1 202 255 112} {DarkOliveGreen2 188 238 104} {DarkOliveGreen3 162 205 90} {DarkOliveGreen4 110 139 61} {khaki1 255 246 143} {khaki2 238 230 133} {khaki3 205 198 115} {khaki4 139 134 78} {LightGoldenrod1 255 236 139} {LightGoldenrod2 238 220 130} {LightGoldenrod3 205 190 112} {LightGoldenrod4 139 129 76} {LightYellow1 255 255 224} {LightYellow2 238 238 209} {LightYellow3 205 205 180} {LightYellow4 139 139 122} {yellow1 255 255 0} {yellow2 238 238 0} {yellow3 205 205 0} {yellow4 139 139 0} {gold1 255 215 0} {gold2 238 201 0} {gold3 205 173 0} {gold4 139 117 0} {goldenrod1 255 193 37} {goldenrod2 238 180 34} {goldenrod3 205 155 29} {goldenrod4 139 105 20} {DarkGoldenrod1 255 185 15} {DarkGoldenrod2 238 173 14} {DarkGoldenrod3 205 149 12} {DarkGoldenrod4 139 101 8} {RosyBrown1 255 193 193} {RosyBrown2 238 180 180} {RosyBrown3 205 155 155} {RosyBrown4 139 105 105} {IndianRed1 255 106 106} {IndianRed2 238 99 99} {IndianRed3 205 85 85} {IndianRed4 139 58 58} {sienna1 255 130 71} {sienna2 238 121 66} {sienna3 205 104 57} {sienna4 139 71 38} {burlywood1 255 211 155} {burlywood2 238 197 145} {burlywood3 205 170 125} {burlywood4 139 115 85} {wheat1 255 231 186} {wheat2 238 216 174} {wheat3 205 186 150} {wheat4 139 126 102} {tan1 255 165 79} {tan2 238 154 73} {tan3 205 133 63} {tan4 139 90 43} {chocolate1 255 127 36} {chocolate2 238 118 33} {chocolate3 205 102 29} {chocolate4 139 69 19} {firebrick1 255 48 48} {firebrick2 238 44 44} {firebrick3 205 38 38} {firebrick4 139 26 26} {brown1 255 64 64} {brown2 238 59 59} {brown3 205 51 51} {brown4 139 35 35} {salmon1 255 140 105} {salmon2 238 130 98} {salmon3 205 112 84} {salmon4 139 76 57} {LightSalmon1 255 160 122} {LightSalmon2 238 149 114} {LightSalmon3 205 129 98} {LightSalmon4 139 87 66} {orange1 255 165 0} {orange2 238 154 0} {orange3 205 133 0} {orange4 139 90 0} {DarkOrange1 255 127 0} {DarkOrange2 238 118 0} {DarkOrange3 205 102 0} {DarkOrange4 139 69 0} {coral1 255 114 86} {coral2 238 106 80} {coral3 205 91 69} {coral4 139 62 47} {tomato1 255 99 71} {tomato2 238 92 66} {tomato3 205 79 57} {tomato4 139 54 38} {OrangeRed1 255 69 0} {OrangeRed2 238 64 0} {OrangeRed3 205 55 0} {OrangeRed4 139 37 0} {red1 255 0 0} {red2 238 0 0} {red3 205 0 0} {red4 139 0 0} {DeepPink1 255 20 147} {DeepPink2 238 18 137} {DeepPink3 205 16 118} {DeepPink4 139 10 80} {HotPink1 255 110 180} {HotPink2 238 106 167} {HotPink3 205 96 144} {HotPink4 139 58 98} {pink1 255 181 197} {pink2 238 169 184} {pink3 205 145 158} {pink4 139 99 108} {LightPink1 255 174 185} {LightPink2 238 162 173} {LightPink3 205 140 149} {LightPink4 139 95 101} {PaleVioletRed1 255 130 171} {PaleVioletRed2 238 121 159} {PaleVioletRed3 205 104 137} {PaleVioletRed4 139 71 93} {maroon1 255 52 179} {maroon2 238 48 167} {maroon3 205 41 144} {maroon4 139 28 98} {VioletRed1 255 62 150} {VioletRed2 238 58 140} {VioletRed3 205 50 120} {VioletRed4 139 34 82} {magenta1 255 0 255} {magenta2 238 0 238} {magenta3 205 0 205} {magenta4 139 0 139} {orchid1 255 131 250} {orchid2 238 122 233} {orchid3 205 105 201} {orchid4 139 71 137} {plum1 255 187 255} {plum2 238 174 238} {plum3 205 150 205} {plum4 139 102 139} {MediumOrchid1 224 102 255} {MediumOrchid2 209 95 238} {MediumOrchid3 180 82 205} {MediumOrchid4 122 55 139} {DarkOrchid1 191 62 255} {DarkOrchid2 178 58 238} {DarkOrchid3 154 50 205} {DarkOrchid4 104 34 139} {purple1 155 48 255} {purple2 145 44 238} {purple3 125 38 205} {purple4 85 26 139} {MediumPurple1 171 130 255} {MediumPurple2 159 121 238} {MediumPurple3 137 104 205} {MediumPurple4 93 71 139} {thistle1 255 225 255} {thistle2 238 210 238} {thistle3 205 181 205} {thistle4 139 123 139} {gray0 0 0 0} {grey0 0 0 0} {gray1 3 3 3} {grey1 3 3 3} {gray2 5 5 5} {grey2 5 5 5} {gray3 8 8 8} {grey3 8 8 8} {gray4 10 10 10} {grey4 10 10 10} {gray5 13 13 13} {grey5 13 13 13} {gray6 15 15 15} {grey6 15 15 15} {gray7 18 18 18} {grey7 18 18 18} {gray8 20 20 20} {grey8 20 20 20} {gray9 23 23 23} {grey9 23 23 23} {gray10 26 26 26} {grey10 26 26 26} {gray11 28 28 28} {grey11 28 28 28} {gray12 31 31 31} {grey12 31 31 31} {gray13 33 33 33} {grey13 33 33 33} {gray14 36 36 36} {grey14 36 36 36} {gray15 38 38 38} {grey15 38 38 38} {gray16 41 41 41} {grey16 41 41 41} {gray17 43 43 43} {grey17 43 43 43} {gray18 46 46 46} {grey18 46 46 46} {gray19 48 48 48} {grey19 48 48 48} {gray20 51 51 51} {grey20 51 51 51} {gray21 54 54 54} {grey21 54 54 54} {gray22 56 56 56} {grey22 56 56 56} {gray23 59 59 59} {grey23 59 59 59} {gray24 61 61 61} {grey24 61 61 61} {gray25 64 64 64} {grey25 64 64 64} {gray26 66 66 66} {grey26 66 66 66} {gray27 69 69 69} {grey27 69 69 69} {gray28 71 71 71} {grey28 71 71 71} {gray29 74 74 74} {grey29 74 74 74} {gray30 77 77 77} {grey30 77 77 77} {gray31 79 79 79} {grey31 79 79 79} {gray32 82 82 82} {grey32 82 82 82} {gray33 84 84 84} {grey33 84 84 84} {gray34 87 87 87} {grey34 87 87 87} {gray35 89 89 89} {grey35 89 89 89} {gray36 92 92 92} {grey36 92 92 92} {gray37 94 94 94} {grey37 94 94 94} {gray38 97 97 97} {grey38 97 97 97} {gray39 99 99 99} {grey39 99 99 99} {gray40 102 102 102} {grey40 102 102 102} {gray41 105 105 105} {grey41 105 105 105} {gray42 107 107 107} {grey42 107 107 107} {gray43 110 110 110} {grey43 110 110 110} {gray44 112 112 112} {grey44 112 112 112} {gray45 115 115 115} {grey45 115 115 115} {gray46 117 117 117} {grey46 117 117 117} {gray47 120 120 120} {grey47 120 120 120} {gray48 122 122 122} {grey48 122 122 122} {gray49 125 125 125} {grey49 125 125 125} {gray50 127 127 127} {grey50 127 127 127} {gray51 130 130 130} {grey51 130 130 130} {gray52 133 133 133} {grey52 133 133 133} {gray53 135 135 135} {grey53 135 135 135} {gray54 138 138 138} {grey54 138 138 138} {gray55 140 140 140} {grey55 140 140 140} {gray56 143 143 143} {grey56 143 143 143} {gray57 145 145 145} {grey57 145 145 145} {gray58 148 148 148} {grey58 148 148 148} {gray59 150 150 150} {grey59 150 150 150} {gray60 153 153 153} {grey60 153 153 153} {gray61 156 156 156} {grey61 156 156 156} {gray62 158 158 158} {grey62 158 158 158} {gray63 161 161 161} {grey63 161 161 161} {gray64 163 163 163} {grey64 163 163 163} {gray65 166 166 166} {grey65 166 166 166} {gray66 168 168 168} {grey66 168 168 168} {gray67 171 171 171} {grey67 171 171 171} {gray68 173 173 173} {grey68 173 173 173} {gray69 176 176 176} {grey69 176 176 176} {gray70 179 179 179} {grey70 179 179 179} {gray71 181 181 181} {grey71 181 181 181} {gray72 184 184 184} {grey72 184 184 184} {gray73 186 186 186} {grey73 186 186 186} {gray74 189 189 189} {grey74 189 189 189} {gray75 191 191 191} {grey75 191 191 191} {gray76 194 194 194} {grey76 194 194 194} {gray77 196 196 196} {grey77 196 196 196} {gray78 199 199 199} {grey78 199 199 199} {gray79 201 201 201} {grey79 201 201 201} {gray80 204 204 204} {grey80 204 204 204} {gray81 207 207 207} {grey81 207 207 207} {gray82 209 209 209} {grey82 209 209 209} {gray83 212 212 212} {grey83 212 212 212} {gray84 214 214 214} {grey84 214 214 214} {gray85 217 217 217} {grey85 217 217 217} {gray86 219 219 219} {grey86 219 219 219} {gray87 222 222 222} {grey87 222 222 222} {gray88 224 224 224} {grey88 224 224 224} {gray89 227 227 227} {grey89 227 227 227} {gray90 229 229 229} {grey90 229 229 229} {gray91 232 232 232} {grey91 232 232 232} {gray92 235 235 235} {grey92 235 235 235} {gray93 237 237 237} {grey93 237 237 237} {gray94 240 240 240} {grey94 240 240 240} {gray95 242 242 242} {grey95 242 242 242} {gray96 245 245 245} {grey96 245 245 245} {gray97 247 247 247} {grey97 247 247 247} {gray98 250 250 250} {grey98 250 250 250} {gray99 252 252 252} {grey99 252 252 252} {gray100 255 255 255} {grey100 255 255 255}}
  global {TPcount}
  set {TPcount} {1}
  global {TPctr}
  set {TPctr} {1}
  global {TPcurCanvas}
  set {TPcurCanvas} {.toplevel3.frame0.canvas2}
  global {TPcurCanvasObj}
  set {TPcurCanvasObj} {menubutton6}
  global {TPcurCanvasObjAnchor}
  set {TPcurCanvasObjAnchor} {c}
  global {TPcurCanvasObjImg}
  set {TPcurCanvasObjImg} {}
  global {TPcurCanvasObjTags}
  set {TPcurCanvasObjTags} {}
  global {TPcurCanvasObjType}
  set {TPcurCanvasObjType} {Arc}
  global {TPcurCanvasObjXpos}
  set {TPcurCanvasObjXpos} {71.0}
  global {TPcurCanvasObjYpos}
  set {TPcurCanvasObjYpos} {49.0}
  global {TPcurCanvasPoint}
  set {TPcurCanvasPoint} {0}
  global {TPcurCanvasTagSort}
  set {TPcurCanvasTagSort} {ID}
  global {TPcurExcludedNamespace}
  set {TPcurExcludedNamespace} {}
  global {TPcurGeoMgr}
  set {TPcurGeoMgr} {pack}
  global {TPcurMenu}
  set {TPcurMenu} {.top2.menubutton2.m}
  global {TPcurNamespace}
  set {TPcurNamespace} {::}
  global {TPcurNamespacePrefix}
  set {TPcurNamespacePrefix} {::}
  global {TPcurPath}
  set {TPcurPath} {.}
  global {TPcurToplevel}
  set {TPcurToplevel} {.toplevel1}
  global TPcurTree
  set TPcurTree {}
  global {TPcurWidget}
  set {TPcurWidget} {.button0}
  global {TPcursel}
  set {TPcursel} {-1}
  global {TPcutBuffer}
  set {TPcutBuffer} {}
  global {TPcvBindSnapshot}
  set {TPcvBindSnapshot(<Button-1>)} {}
  global {TPcvPropsInfo}
  set {TPcvPropsInfo(activebackground)} {color}
  set {TPcvPropsInfo(activebitmap)} {file}
  set {TPcvPropsInfo(activedash)} {text}
  set {TPcvPropsInfo(activefill)} {color}
  set {TPcvPropsInfo(activeforeground)} {color}
  set {TPcvPropsInfo(activeimage)} {image}
  set {TPcvPropsInfo(activeoutline)} {color}
  set {TPcvPropsInfo(activeoutlinestipple)} {file}
  set {TPcvPropsInfo(activestipple)} {file}
  set {TPcvPropsInfo(activewidth)} {int 0 50}
  set {TPcvPropsInfo(anchor)} {enum center n ne e se s sw w nw}
  set {TPcvPropsInfo(angle)} {text}
  set {TPcvPropsInfo(arrow)} {enum none first last both}
  set {TPcvPropsInfo(arrowshape)} {text}
  set {TPcvPropsInfo(background)} {color}
  set {TPcvPropsInfo(bitmap)} {file}
  set {TPcvPropsInfo(capstyle)} {enum butt projecting round}
  set {TPcvPropsInfo(dash)} {text}
  set {TPcvPropsInfo(dashoffset)} {int 0 50}
  set {TPcvPropsInfo(disabledbackground)} {color}
  set {TPcvPropsInfo(disabledbitmap)} {file}
  set {TPcvPropsInfo(disableddash)} {text}
  set {TPcvPropsInfo(disabledfill)} {color}
  set {TPcvPropsInfo(disabledforeground)} {color}
  set {TPcvPropsInfo(disabledimage)} {image}
  set {TPcvPropsInfo(disabledoutline)} {color}
  set {TPcvPropsInfo(disabledoutlinestipple)} {file}
  set {TPcvPropsInfo(disabledstipple)} {file}
  set {TPcvPropsInfo(disabledwidth)} {int 0 50}
  set {TPcvPropsInfo(extent)} {int -360 360}
  set {TPcvPropsInfo(fill)} {color}
  set {TPcvPropsInfo(font)} {font}
  set {TPcvPropsInfo(foreground)} {color}
  set {TPcvPropsInfo(height)} {int 0 1024}
  set {TPcvPropsInfo(image)} {image}
  set {TPcvPropsInfo(joinstyle)} {enum bevel miter round}
  set {TPcvPropsInfo(justify)} {enum left right center}
  set {TPcvPropsInfo(offset)} {enum center n ne e se s sw w nw}
  set {TPcvPropsInfo(outline)} {color}
  set {TPcvPropsInfo(outlineoffset)} {text}
  set {TPcvPropsInfo(outlinestipple)} {file}
  set {TPcvPropsInfo(propname)} {font}
  set {TPcvPropsInfo(propval)} {{helvetica} 12 italic  }
#LISSI
#  set {TPcvPropsInfo(smooth)} {bool 0 1}
  set {TPcvPropsInfo(smooth)} {int 0 1}

  set {TPcvPropsInfo(splinesteps)} {int 0 50}
  set {TPcvPropsInfo(start)} {int -360 360}
  set {TPcvPropsInfo(state)} {enum normal disabled hidden}
  set {TPcvPropsInfo(stipple)} {file}
  set {TPcvPropsInfo(style)} {enum pieslice chord arc}
  set {TPcvPropsInfo(text)} {textedit}
  set {TPcvPropsInfo(width)} {int 0 400}
  set {TPcvPropsInfo(window)} {text}
  global {TPcvPropsStandardList}
  set {TPcvPropsStandardList} {dash
activedash
disableddash
dashoffset
fill
activefill
disabledfill
outline
activeoutline
disabledoutline
offset
outlinestipple
activeoutlinestipple
disabledoutlinestipple
stipple
activestipple
disabledstipple
state
width
activewidth
disabledwidth}
  global {TPcvbindEvent}
  set {TPcvbindEvent} {}
  global {TPcvbindID}
  set {TPcvbindID} {1}
  global {TPdel}
  set {TPdel} {4}
  global {TPdoit}
  set {TPdoit} {1}
  global {TPeditProcFindString}
  set {TPeditProcFindString} {}
  global {TPeditProcName}
  set {TPeditProcName} {}
  global {TPeditProcParameters}
  set {TPeditProcParameters} {}
  global {TPeditor}
  set {TPeditor} {}
  global {TPelement}
  set {TPelement} {1}
  global {TPelements}
  set {TPelements} {1}
  global {TPelemlist}
  set {TPelemlist} {}
  global {TPexclusions}
  set {TPexclusions(cantsave_namespace)} {::auto_mkindex_parser ::freewrap ::msgcat ::pkg ::tcl ::tk ::tk::dialog ::tk::dialog::error ::tk::msgcat ::tk::panedwindow ::tk::spinbox ::zvfs ::tk::dialog::file}
  set {TPexclusions(globalvar)} {argc argv argv0 auto_index auto_path auto_oldpath env errorCode errorInfo internalAliasList moduleList preloadList symbolicName tcl_* tk_* TP*}
  set {TPexclusions(images)} {tpbomb tpprevdir tpfilesave tpfolder tpfoldernew tparrow_up tparrow_down tparrow_left tparrow_right tpblank tpbutton tpbuttonT tpcanvas tpcheckbutton tpcomboT tpentry tpentryT tpframe tpframeT tplabel tplabelT tplabelframe tplabelframeT tplistbox tpmenu tpmenubutton tpmenubuttonT tpmessage tpnavdown tpnavup tpnotebookT tppanedwin_h tppanedwin_hT tppanedwin_v tppanedwin_vT tpprogressbarT tpradiobutton tpradiobuttonT tpscale_h tpscale_v tpscrollbar_v tpscrollbar_vT tpscrollbar_h tpscrollbar_hT tpseparator_hT tpseparator_vT tpsizegripT tpspinbox tptext tptoplevel tptreeviewT tparrowcombo tpbind tpcopy tpcut tpgrid tppack tppaste tpplace tpprocs tpproperties tptoolbar tptrash tptree tpvars tplogo16 tplogo128}
  set {TPexclusions(namespace)} {::auto_mkindex_parser ::freewrap ::msgcat ::pkg ::tk ::tk::dialog ::tk::dialog::error ::tk::msgcat ::tk::panedwindow ::tk::spinbox ::zvfs ::tcl}
  set {TPexclusions(reconfig)} {class colormap container screen use visual}
  set {TPexclusions(user_namespace)} {}
  set {TPexclusions(windows)} {.tpbuild .tpStdTemplates .tppane .tptpane .tpiconlib .tpwatchwin .tpTree .tpinputbox .tpGetObjName .tpplacer .tpabout .tpgetfile .tpimages .tpmsgbox .tpfontselect .tpnspacesave .tpnewspace .tpgridder .tpprocs .tpToplevels . .tpautosave .tpmain .tpcolorsel .tpexclusions .tppacker .tpwm .tpcanvas .tpgenopts .tpcmdedit .tpbindcv .tpproperties .tptkwidgets .tpmenu .tpimagesel .tpbinding .tpvars .tptabs .tpTreeview}
  global {TPfin}
  set {TPfin} {file6}
  global {TPfname}
  set {TPfname} {}
  global {TPfontCmd}
  set {TPfontCmd} {}
  global {TPfontFamily}
  set {TPfontFamily} {arial}
  global {TPfontSample}
  set {TPfontSample} {Place anythin here :-) one two three four}
  global {TPfontSize}
  set {TPfontSize} {12}
  global {TPfontStrikeout}
  set {TPfontStrikeout} {0}
  global {TPfontStyle}
  set {TPfontStyle} {Regular}
  global {TPfontUnderline}
  set {TPfontUnderline} {0}
  global {TPgeoMgr}
  set {TPgeoMgr} {pack}
  global {TPprojType}
  set TPprojType TCL_TK
  global {TPgetfile}
  set {TPgetfile(chgdir)} {2}
  set {TPgetfile(dir)} {/mnt/shares/pdisk1/tkproe}
  set {TPgetfile(done)} {1}
  set {TPgetfile(name)} {}
  set {TPgetfile(state)} {Save}
  set {TPgetfile(type)} {*.tcl}
  global {TPglobalVar}
  set {TPglobalVar} {}
  global {TPglobalVarNew}
  set {TPglobalVarNew} {::infomsg2}
  global {TPgrid}
  set {TPgrid(-column)} {0}
  set {TPgrid(-columnconfigure)} {0}
  set {TPgrid(-columnspan)} {1}
  set {TPgrid(-in)} {}
  set {TPgrid(-ipadx)} {0}
  set {TPgrid(-ipady)} {0}
  set {TPgrid(-minsize)} {0}
  set {TPgrid(-minsizeR)} {0}
  set {TPgrid(-pad)} {0}
  set {TPgrid(-padR)} {0}
  set {TPgrid(-padx)} {0}
  set {TPgrid(-pady)} {0}
  set {TPgrid(-row)} {1}
  set {TPgrid(-rowconfigure)} {0}
  set {TPgrid(-rowspan)} {1}
  set {TPgrid(-side)} {top}
  set {TPgrid(-sticky)} {}
  set {TPgrid(-uniform)} {}
  set {TPgrid(-uniformR)} {}
  set {TPgrid(-weight)} {1}
  set {TPgrid(-weightR)} {1}
  set {TPgrid(stickyE)} {0}
  set {TPgrid(stickyN)} {0}
  set {TPgrid(stickyS)} {0}
  set {TPgrid(stickyW)} {0}
  global {TPgrid(-columnconfigure}
  set {TPgrid(-columnconfigure} {3}
  global {TPgrid(-rowconfigure}
  set {TPgrid(-rowconfigure} {1}
  global {TPgridChild}
  set {TPgridChild} {}
  global {TPgridOrder}
  set {TPgridOrder} {}
  global {TPgridParent}
  set {TPgridParent} {}
  global {TPgroupboxid}
  set {TPgroupboxid} {132}
  global {TPgrouplist}
  set {TPgrouplist} {1 groupbox}
  global {TPgrouplrx}
  set {TPgrouplrx} {99}
  global {TPgrouplry}
  set {TPgrouplry} {61}
  global {TPgroupuly}
  set {TPgroupuly} {5}
  global {TPhomeDir}
  set {TPhomeDir} {}
  global {TPiditem}
  set {TPiditem} {3}
  global {TPidx}
  set {TPidx} {0}
  global {TPidx1}
  set {TPidx1} {2}
  global {TPidx2}
  set {TPidx2} {0}
  global {TPimage}
  set {TPimage(background)} {}
  set {TPimage(data)} {}
  set {TPimage(embed)} {1}
  set {TPimage(file)} {}
  set {TPimage(findstr)} {}
  set {TPimage(foreground)} {#000000}
  set {TPimage(format)} {}
  set {TPimage(gamma)} {1.0}
  set {TPimage(height)} {0}
  set {TPimage(maskdata)} {}
  set {TPimage(maskfile)} {}
#LISSI
#  set {TPimage(name)} {image1}
  set {TPimage(name)} {imageN1}

  set {TPimage(palette)} {}
#LISSI
#  set {TPimage(type)} {bitmap}
  set {TPimage(type)} {photo}

  set {TPimage(width)} {0}
  global {TPimageSel}
  set {TPimageSel(findstr)} {}
  global {TPimgCmd}
  set {TPimgCmd} {set TPpropsStandard(image)}
  global {TPimgNamespace}
  set {TPimgNamespace} {::}
  global {TPimgNamespacePrefix}
  set {TPimgNamespacePrefix} {::}
  global {TPimgSelNamespace}
  set {TPimgSelNamespace} {::}
  global {TPimgSelNamespacePrefix}
  set {TPimgSelNamespacePrefix} {::auto_mkindex_parser::}
  global {TPimglibList}
  set {TPimglibList} {}
  global {TPinfo}
  set {TPinfo(credits)} {by Dennis R. LaBelle}
  set {TPinfo(progname)} {TKproE}
  set {TPinfo(revdate)} {04/21/2021}
  set {TPinfo(revision)} {2.30}
  global {TPinput}
  set {TPinput(cmd)} {}
  set {TPinput(label)} {Name:}
  set {TPinput(msg)} {Enter name for new subdirectory}
  set {TPinput(value)} {}
  global {TPins}
  set {TPins} {2}
  global {TPitem}
  set {TPitem} {-barmode}
  global {TPkeytime}
  set {TPkeytime} {}
  global {TPmenuBuf}
  set {TPmenuBuf(accelerator)} {}
  set {TPmenuBuf(activebackground)} {}
  set {TPmenuBuf(activeforeground)} {}
  set {TPmenuBuf(background)} {}
  set {TPmenuBuf(bitmap)} {}
  set {TPmenuBuf(columnbreak)} {0}
  set {TPmenuBuf(command)} {
}
  set {TPmenuBuf(compound)} {none}
  set {TPmenuBuf(font)} {}
  set {TPmenuBuf(foreground)} {}
  set {TPmenuBuf(hidemargin)} {0}
  set {TPmenuBuf(image)} {}
  set {TPmenuBuf(indicatoron)} {}
  set {TPmenuBuf(label)} {Level 1}
  set {TPmenuBuf(menu)} {.menubutton0.m.m1}
  set {TPmenuBuf(offvalue)} {}
  set {TPmenuBuf(onvalue)} {}
  set {TPmenuBuf(selectcolor)} {}
  set {TPmenuBuf(selectimage)} {}
  set {TPmenuBuf(state)} {normal}
  set {TPmenuBuf(underline)} {0}
  set {TPmenuBuf(value)} {}
  set {TPmenuBuf(variable)} {}
  global {TPmenuEntry}
  set {TPmenuEntry(0)} {command {-activebackground {} -activeforeground {} -accelerator {} -background #FFFFFF -bitmap {} -columnbreak 0 -command {puts Hi!
} -compound none -font {} -foreground {} -hidemargin 0 -image {} -label {Say Hi} -state normal -underline 0}}
  set {TPmenuEntry(1)} {cascade {-menu .menubutton0.m.m2 -activebackground {} -activeforeground {} -accelerator {} -background #FFFFFF -bitmap {} -columnbreak 0 -command {} -compound none -font {} -foreground {} -hidemargin 0 -image {} -label {Level 1} -state normal -underline 0}}
  set {TPmenuEntry(2)} {cascade {-menu .menubutton0.m.m1 -activebackground {} -activeforeground {} -accelerator {} -background {} -bitmap {} -columnbreak 0 -command {} -compound none -font {} -foreground {} -hidemargin 0 -image {} -label {Level 2} -state active -underline 0}}
  set {TPmenuEntry(path)} {.top2.menubutton2.m}
  global {TPmenuItem}
  set {TPmenuItem(accelerator)} {}
  set {TPmenuItem(activebackground)} {}
  set {TPmenuItem(activeforeground)} {}
  set {TPmenuItem(background)} {#FFFFFF}
  set {TPmenuItem(bitmap)} {}
  set {TPmenuItem(columnbreak)} {0}
  set {TPmenuItem(command)} {}
  set {TPmenuItem(compound)} {}
  set {TPmenuItem(font)} {}
  set {TPmenuItem(foreground)} {}
  set {TPmenuItem(hidemargin)} {}
  set {TPmenuItem(image)} {}
  set {TPmenuItem(indicatoron)} {}
  set {TPmenuItem(label)} {}
  set {TPmenuItem(menu)} {}
  set {TPmenuItem(offvalue)} {}
  set {TPmenuItem(onvalue)} {}
  set {TPmenuItem(selectcolor)} {}
  set {TPmenuItem(selectimage)} {}
  set {TPmenuItem(state)} {normal}
  set {TPmenuItem(underline)} {0}
  set {TPmenuItem(value)} {}
  set {TPmenuItem(variable)} {}
  global {TPmenuItemState}
  set {TPmenuItemState} {}
  global {TPmenuItemType}
  set {TPmenuItemType} {command}
  global {TPmenuState}
  set {TPmenuState} {}
  global {TPmessage}
  set {TPmessage} {}
  global {TPmove}
  set {TPmove} {2}
  global {TPmsgButtons}
  set {TPmsgButtons} {}
  global {TPmsgCmd}
  set {TPmsgCmd(Accept)} {}
  set {TPmsgCmd(Cancel)} {}
  set {TPmsgCmd(No)} {}
  set {TPmsgCmd(Yes)} {}
  global {TPnamedFont}
  set {TPnamedFont} {}
  global {TPnewObjNameAsk}
  set {TPnewObjNameAsk} {1}
  global {TPnewVector}
  set {TPnewVector} {}
  global {TPnewspace}
  set {TPnewspace} {}
  global {TPnewval}
  set {TPnewval} {}
  global {TPnextObj}
  set {TPnextObj} {0}
  global {TPnextObjName}
  set {TPnextObjName} {}
  global {TPnextObjType}
  set {TPnextObjType} {button}
  array set {::TPnotebook} {stickyE 0 stickyN 0 stickyW 0 stickyS 0}
  global {TPnspaceFile}
  set {TPnspaceFile} {}
  global {TPnspaceSave}
  set {TPnspaceSave} {entry2}
  global {TPobjaddfirst}
  set {TPobjaddfirst} {0}
  global {TPobjdelfirst}
  set {TPobjdelfirst} {0}
  global {TPobjmovefirst}
  set {TPobjmovefirst} {1}
  global {TPoptionStandard}
  set {TPoptionStandard} {activebackground activeforeground anchor background bitmap borderwidth cursor disabledforeground font foreground highlightbackground highlightcolor higlightthickness image justify padx pady relief repeatdelay repeatinterval takefocus text textvariable underline wraplength}
  global {TPoptionsPack}
  set {TPoptionsPack(.toplevel0.label0)} {-anchor center -expand 0 -fill none -ipadx 7 -ipady 0 -padx 0 -pady 0 -side bottom}
  set {TPoptionsPack(.toplevel0.label1)} {-anchor center -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top}
  global {TPpack}
  set {TPpack(-anchor)} {center}
  set {TPpack(-expand)} {0}
  set {TPpack(-fill)} {none}
  set {TPpack(-in)} {.toplevel0}
  set {TPpack(-ipadx)} {0}
  set {TPpack(-ipady)} {0}
  set {TPpack(-padx)} {0}
  set {TPpack(-pady)} {0}
  set {TPpack(-side)} {bottom}
  global {TPpackChild}
  set {TPpackChild} {}
  global {TPpackOrder}
  set {TPpackOrder} {.toplevel0.label1 .toplevel0.label0}
  global {TPpackParent}
  set {TPpackParent} {}
  global {TPpdfViewer}
  set {TPpdfViewer} {}
  global {TPpginRev}
  set {TPpginRev} {0}
  global {TPplace}
  set {TPplace(-anchor)} {nw}
  set {TPplace(-bordermode)} {inside}
  set {TPplace(-height)} {}
  set {TPplace(-in)} {.frame1}
  set {TPplace(-relheight)} {}
  set {TPplace(-relwidth)} {}
  set {TPplace(-relx)} {0}
  set {TPplace(-rely)} {0}
  set {TPplace(-width)} {}
  set {TPplace(-x)} {0}
  set {TPplace(-y)} {0}
  global {TPplaceChild}
  set {TPplaceChild} {}
  global {TPplaceChilde}
  set {TPplaceChilde} {}
  global {TPplaceParent}
  set {TPplaceParent} {}
  global {TPprefix}
  set {TPprefix} {}
  global {TPprocEdit}
  set {TPprocEdit} {}
  global {TPprogFile}
  set {TPprogFile} {}
  global {TPpropsAtCreation}
  set {TPpropsAtCreation(class)} {}
  set {TPpropsAtCreation(colormap)} {}
  set {TPpropsAtCreation(container)} {}
  set {TPpropsAtCreation(screen)} {}
  set {TPpropsAtCreation(use)} {}
  set {TPpropsAtCreation(visual)} {}
  global {TPpropsInfo}
  set {TPpropsInfo(activebackground)} {color}
  set {TPpropsInfo(activeborderwidth)} {int 0 50}
  set {TPpropsInfo(activeforeground)} {color}
  set {TPpropsInfo(activerelief)} {enum flat groove raised ridge solid sunken}
  set {TPpropsInfo(activestyle)} {enum dotbox none underline}
  set {TPpropsInfo(anchor)} {enum center n ne e se s sw w nw }
  set {TPpropsInfo(aspect)} {text}
  set {TPpropsInfo(autoclear)} {bool 0 1}
  set {TPpropsInfo(autoseparators)} {bool 0 1}
  set {TPpropsInfo(background)} {color}
  set {TPpropsInfo(barmode)} {enum infront stacked aligned overlap}
  set {TPpropsInfo(barwidth)} {float 0.0 10.0}
  set {TPpropsInfo(baseline)} {float}
  set {TPpropsInfo(bigincrement)} {int 0 10000}
  set {TPpropsInfo(bitmap)} {file}
  set {TPpropsInfo(bordercursor)} {text}
  set {TPpropsInfo(bordermode)} {enum inside outside ignore}
  set {TPpropsInfo(borderwidth)} {int 0 50}
  set {TPpropsInfo(bottommargin)} {int 0 100}
  set {TPpropsInfo(browsercommand)} {textedit}
  set {TPpropsInfo(buttonbackground)} {color}
  set {TPpropsInfo(buttoncursor)} {cursor}
  set {TPpropsInfo(buttondownrelief)} {enum flat groove raised ridge solid sunken}
  set {TPpropsInfo(buttonuprelief)} {enum flat groove raised ridge solid sunken}
  set {TPpropsInfo(cache)} {bool 0 1}
  set {TPpropsInfo(class)} {text}
  set {TPpropsInfo(client)} {text}
  set {TPpropsInfo(closeenough)} {int 0 100}
  set {TPpropsInfo(colorigin)} {int -100 100}
  set {TPpropsInfo(colormap)} {text}
  set {TPpropsInfo(cols)} {int 0 50}
  set {TPpropsInfo(columns)} {text}
  set {TPpropsInfo(colseparator)} {text}
  set {TPpropsInfo(colstretchmode)} {enum none unset all last fill}
  set {TPpropsInfo(coltagcommand)} {text}
  set {TPpropsInfo(column)} {int 0 25}
  set {TPpropsInfo(columnspan)} {int 0 25}
  set {TPpropsInfo(colwidth)} {int -100 100}
  set {TPpropsInfo(command)} {textedit}
  set {TPpropsInfo(compound)} {enum bottom center image left none right text top}
  set {TPpropsInfo(confine)} {enum 0 1}
  set {TPpropsInfo(container)} {bool 0 1}
  set {TPpropsInfo(cursor)} {text}
  set {TPpropsInfo(datacommand)} {textedit}
  set {TPpropsInfo(default)} {enum normal active disabled}
  set {TPpropsInfo(digits)} {int 0 20}
  set {TPpropsInfo(direction)} {enum above below left right flush}
  set {TPpropsInfo(disabledbackground)} {color}
  set {TPpropsInfo(disabledforeground)} {color}
  set TPpropsInfo(displaycolumns) {text}
  set {TPpropsInfo(drawmode)} {enum slow compatible fast single}
  set {TPpropsInfo(elementborderwidth)} {int 0 50}
  set {TPpropsInfo(expand)} {enum 0 1}
  set {TPpropsInfo(exportselection)} {bool 0 1}
  set {TPpropsInfo(fill)} {enum none x y both}
  set {TPpropsInfo(flashmode)} {bool 0 1}
  set {TPpropsInfo(flashtime)} {int 0 100}
  set {TPpropsInfo(focusmodel)} {enum active passive}
  set {TPpropsInfo(font)} {font}
  set {TPpropsInfo(foreground)} {color}
  set {TPpropsInfo(format)} {text}
  set {TPpropsInfo(from)} {float}
  set {TPpropsInfo(geometry)} {text}
  set {TPpropsInfo(grid)} {text}
  set {TPpropsInfo(group)} {text}
  set {TPpropsInfo(halo)} {int 0 50}
  set {TPpropsInfo(handlepad)} {int 0 50}
  set {TPpropsInfo(handlesize)} {int 0 50}
  set {TPpropsInfo(height)} {int 0 10000}
  set {TPpropsInfo(hide)} {bool 0 1}
  set {TPpropsInfo(highlightbackground)} {color}
  set {TPpropsInfo(highlightcolor)} {color}
  set {TPpropsInfo(highlightthickness)} {int 0 25}
  set {TPpropsInfo(iconbitmap)} {file}
  set {TPpropsInfo(iconmask)} {file}
  set {TPpropsInfo(iconname)} {text}
  set {TPpropsInfo(iconposition)} {text}
  set {TPpropsInfo(iconwindow)} {text}
  set {TPpropsInfo(image)} {image}
  set {TPpropsInfo(in)} {text}
  set {TPpropsInfo(increment)} {float 0.0 1000.0}
  set {TPpropsInfo(indicatoron)} {bool 0 1}
  set {TPpropsInfo(insertbackground)} {color}
  set {TPpropsInfo(insertborderwidth)} {int 0 10}
  set {TPpropsInfo(insertofftime)} {int 0 2000}
  set {TPpropsInfo(insertontime)} {int 0 2000}
  set {TPpropsInfo(insertwidth)} {int 0 25}
  set {TPpropsInfo(invalidcommand)} {textedit}
  set {TPpropsInfo(invertselected)} {bool 0 1}
  set {TPpropsInfo(invertxy)} {bool 0 1}
  set {TPpropsInfo(ipadx)} {int 0 100}
  set {TPpropsInfo(ipady)} {int 0 100}
  set {TPpropsInfo(jump)} {bool 0 1}
  set {TPpropsInfo(justify)} {enum left center right}
  set {TPpropsInfo(label)} {text}
  set {TPpropsInfo(labelanchor)} {enum center nw n ne e se s sw w }
  set {TPpropsInfo(labelwidget)} {text}
  set {TPpropsInfo(leftmargin)} {int 0 200}
  set {TPpropsInfo(length)} {int 0 10000}
  set {TPpropsInfo(listvariable)} {text}
  set {TPpropsInfo(maxheight)} {int 1 10000}
  set {TPpropsInfo(maximum_height)} {int 1 10000}
  set {TPpropsInfo(maximum_width)} {int 1 10000}
  set {TPpropsInfo(maxundo)} {int 0 10000}
  set {TPpropsInfo(maxwidth)} {int 1 10000}
  set {TPpropsInfo(menu)} {menu}
  set {TPpropsInfo(minimum_height)} {int 1 10000}
  set {TPpropsInfo(minimum_width)} {int 1 10000}
  set {TPpropsInfo(minsize)} {int 1 10000}
  set TPpropsInfo(mode) {enum determinate indeterminate}
  set {TPpropsInfo(multiline)} {bool 0 1}
  set {TPpropsInfo(offrelief)} {enum flat groove raised ridge solid sunken}
  set {TPpropsInfo(offvalue)} {text}
  set {TPpropsInfo(onvalue)} {text}
  set {TPpropsInfo(opaqueresize)} {bool 0 1}
  set {TPpropsInfo(orient)} {enum horizontal vertical}
  set {TPpropsInfo(overrelief)} {enum flat groove raised ridge solid sunken}
  set {TPpropsInfo(overrideredirect)} {bool 0 1}
  set TPpropsInfo(padding) {int 0 100}
  set {TPpropsInfo(padx)} {int 0 100}
  set {TPpropsInfo(pady)} {int 0 100}
  set {TPpropsInfo(plotbackground)} {color}
  set {TPpropsInfo(plotborderwidth)} {int 0 50}
  set {TPpropsInfo(plotrelief)} {enum flat groove raised ridge solid sunken}
  set {TPpropsInfo(positionfrom)} {enum user program}
  set {TPpropsInfo(postcommand)} {textedit}
  set {TPpropsInfo(propname)} {image}
  set {TPpropsInfo(propval)} {}
  set {TPpropsInfo(readonlybackground)} {color}
  set {TPpropsInfo(relheight)} {float 0.0 1.0}
  set {TPpropsInfo(relief)} {enum flat groove raised ridge solid sunken}
  set {TPpropsInfo(relwidth)} {float 0.0 1.0}
  set {TPpropsInfo(relx)} {float 0.0 1.0}
  set {TPpropsInfo(rely)} {float 0.0 1.0}
  set {TPpropsInfo(repeatdelay)} {int 0 10000}
  set {TPpropsInfo(repeatinterval)} {int 0 2000}
  set {TPpropsInfo(resizable_height)} {bool 0 1}
  set {TPpropsInfo(resizable_width)} {bool 0 1}
  set {TPpropsInfo(resizeborders)} {enum row col both none}
  set {TPpropsInfo(resolution)} {float 0.0 1000.0}
  set {TPpropsInfo(rightmargin)} {int 0 200}
  set {TPpropsInfo(row)} {int 0 25}
  set {TPpropsInfo(rowheight)} {int -100 100}
  set {TPpropsInfo(roworigin)} {int -100 100}
  set {TPpropsInfo(rows)} {int 0 50}
  set {TPpropsInfo(rowseparator)} {text}
  set {TPpropsInfo(rowspan)} {int 0 25}
  set {TPpropsInfo(rowstretchmode)} {enum none unset all last fill}
  set {TPpropsInfo(rowtagcommand)} {text}
  set {TPpropsInfo(sashcursor)} {cursor}
  set {TPpropsInfo(sashpad)} {int 0 50}
  set {TPpropsInfo(sashrelief)} {enum flat groove raised ridge solid sunken}
  set {TPpropsInfo(sashwidth)} {int 0 50}
  set {TPpropsInfo(screen)} {text}
  set {TPpropsInfo(scrollregion)} {text}
  set {TPpropsInfo(selcmd)} {text}
  set {TPpropsInfo(selectbackground)} {color}
  set {TPpropsInfo(selectborderwidth)} {int 0 10}
  set {TPpropsInfo(selectcolor)} {color}
  set {TPpropsInfo(selectforeground)} {color}
  set {TPpropsInfo(selectimage)} {image}
  set {TPpropsInfo(selectioncommand)} {text}
  set {TPpropsInfo(selectmode)} {enum single browse multiple extended none}
  set {TPpropsInfo(selecttype)} {enum row col cell both}
  set {TPpropsInfo(setgrid)} {enum yes no}
  set {TPpropsInfo(show)} {enum headings tree {tree headings}}
  set {TPpropsInfo(showhandle)} {bool 0 1}
  set {TPpropsInfo(showvalue)} {bool 0 1}
  set {TPpropsInfo(side)} {enum left right top bottom}
  set {TPpropsInfo(sizefrom)} {enum user program}
  set {TPpropsInfo(sliderlength)} {int 0 100}
  set {TPpropsInfo(sliderrelief)} {enum flat groove raised ridge solid sunken}
  set {TPpropsInfo(spacing1)} {int 0 100}
  set {TPpropsInfo(spacing2)} {int 0 100}
  set {TPpropsInfo(spacing3)} {int 0 100}
  set {TPpropsInfo(sparsearray)} {bool 0 1}
  set {TPpropsInfo(state)} {enum active alternate background disabled focus iconic invalid normal pressed readonly selected withdrawn zoomed}
  set {TPpropsInfo(sticky)} {text}
  set {TPpropsInfo(stretch)} {enum always first last middle never}
  set {TPpropsInfo(tabs)} {text}
  set {TPpropsInfo(takefocus)} {bool 0 1}
  set {TPpropsInfo(tearoff)} {bool 0 1}
  set {TPpropsInfo(tearoffcommand)} {textedit}
  set {TPpropsInfo(text)} {textedit}
  set {TPpropsInfo(textvariable)} {text}
  set {TPpropsInfo(tickinterval)} {float 0.0 1000.0}
  set {TPpropsInfo(title)} {text}
  set {TPpropsInfo(titlecols)} {int 0 10}
  set {TPpropsInfo(titlerows)} {int 0 10}
  set {TPpropsInfo(to)} {float}
  set {TPpropsInfo(topmargin)} {int 0 200}
  set {TPpropsInfo(transient)} {text}
  set {TPpropsInfo(troughcolor)} {color}
  set {TPpropsInfo(underline)} {int -1 100}
  set {TPpropsInfo(undo)} {bool 0 1}
  set {TPpropsInfo(use)} {text}
  set {TPpropsInfo(usecommand)} {bool 0 1}
  set {TPpropsInfo(validate)} {enum none focus focusin focusout key all 0 1}
  set {TPpropsInfo(validatecommand)} {textedit}
  set {TPpropsInfo(value)} {text}
  set {TPpropsInfo(values)} {text}
  set {TPpropsInfo(variable)} {text}
  set {TPpropsInfo(visual)} {text}
  set {TPpropsInfo(width)} {int 0 10000}
  set {TPpropsInfo(wm_command)} {text}
  set {TPpropsInfo(wrap)} {enum none char word}
  set {TPpropsInfo(wraplength)} {int 0 2000}
  set {TPpropsInfo(x)} {int 0 10000}
  set {TPpropsInfo(xscrollcommand)} {text}
  set {TPpropsInfo(xscrollincrement)} {int 0 100}
  set {TPpropsInfo(y)} {int 0 10000}
  set {TPpropsInfo(yscrollcommand)} {text}
  set {TPpropsInfo(yscrollincrement)} {int 0 100}
  global {TPpropsStandardList}
  set {TPpropsStandardList} {activebackground activeborderwidth activeforeground anchor background bitmap borderwidth cursor compound disabledforeground exportselection font foreground highlightbackground highlightcolor highlightthickness image insertbackground insertborderwidth insertofftime insertontime insertwidth jump justify orient padx pady relief repeatdelay repeatinterval selectbackground selectborderwidth selectforeground setgrid takefocus text textvariable troughcolor underline wraplength xscrollcommand yscrollcommand}
  global {TPpropsToplevel}
  set {TPpropsToplevel(client)} {}
  set {TPpropsToplevel(focusmodel)} {}
  set {TPpropsToplevel(group)} {}
  set {TPpropsToplevel(iconbitmap)} {}
  set {TPpropsToplevel(iconmask)} {}
  set {TPpropsToplevel(iconname)} {}
  set {TPpropsToplevel(iconposition)} {}
  set {TPpropsToplevel(iconwindow)} {}
  set {TPpropsToplevel(title)} {}
  set {TPpropsToplevel(transient)} {}
  set {TPpropsToplevel(wm_command)} {}
  global {TPpropsWidget}
  set {TPpropsWidget(class)} {Label}
  set {TPpropsWidget(name)} {.label1}
  set {TPpropsWidget(parent)} {.}
  global {TPrealClass}
  set {TPrealClass(Tablelist)} {Frame}
  global {TPresult}
  set {TPresult} {}
  global {TPsaveDir}
  set {TPsaveDir} {}
  global {TPsaveValues}
  set {TPsaveValues} 1
  global {TPsaveInterval}
  set {TPsaveInterval} {600000}
  global {TPselBoundProc}
  set {TPselBoundProc} {TPendSrc}
  global {TPselProc}
  set {TPselProc} {proc1}
  global {TPselTheme}
  set {TPselTheme} {.kde}
  global {TPselWidget}
  set {TPselWidget(.tpfontselect)} {.tpnothing}
  global {TPshowFonts}
  set {TPshowFonts} {0}
  global {TPshowGlobals}
  set {TPshowGlobals} {0}
  global {TPshowIcons}
  set {TPshowIcons} {0}
  global {TPshowImages}
  set {TPshowImages} {0}
  global {TPshowProcs}
  set {TPshowProcs} {0}
  global {TPshowToplevels}
  set {TPshowToplevels} {0}
  global {TPshowVectors}
  set {TPshowVectors} {0}
  global {TPshowWatch}
  set {TPshowWatch} {0}
  global {TPshowWidgetTree}
  set {TPshowWidgetTree} {0}
  global {TPshowWidgets}
  set {TPshowWidgets} {0}
  global {TPshowconsole}
  set {TPshowconsole} {1}
  global {TPsnapshot}
  set {TPsnapshot(-activebackground)} {gray75}
  set {TPsnapshot(-activeforeground)} {Black}
  set {TPsnapshot(-anchor)} {center}
  set {TPsnapshot(-background)} {#d9d9d9}
  set {TPsnapshot(-bitmap)} {}
  set {TPsnapshot(-borderwidth)} {2}
  set {TPsnapshot(-command)} {}
  set {TPsnapshot(-compound)} {none}
  set {TPsnapshot(-cursor)} {}
  set {TPsnapshot(-default)} {disabled}
  set {TPsnapshot(-disabledforeground)} {#a3a3a3}
  set {TPsnapshot(-font)} {Helvetica 10}
  set {TPsnapshot(-foreground)} {Black}
  set {TPsnapshot(-height)} {0}
  set {TPsnapshot(-highlightbackground)} {#d9d9d9}
  set {TPsnapshot(-highlightcolor)} {Black}
  set {TPsnapshot(-highlightthickness)} {1}
  set {TPsnapshot(-image)} {}
  set {TPsnapshot(-justify)} {center}
  set {TPsnapshot(-overrelief)} {}
  set {TPsnapshot(-padx)} {3m}
  set {TPsnapshot(-pady)} {1m}
  set {TPsnapshot(-relief)} {raised}
  set {TPsnapshot(-repeatdelay)} {0}
  set {TPsnapshot(-repeatinterval)} {0}
  set {TPsnapshot(-state)} {active}
  set {TPsnapshot(-takefocus)} {}
  set {TPsnapshot(-text)} {button0}
  set {TPsnapshot(-textvariable)} {}
  set {TPsnapshot(-width)} {0}
  set {TPsnapshot(-wraplength)} {0}
  set {TPsnapshot(widget)} {.button0}
  global {TPsnapshotToplevel}
  set {TPsnapshotToplevel(WM_DELETE_WINDOW)} {TPcloseWindow.toplevel0}
  set {TPsnapshotToplevel(WM_SAVE_YOURSELF)} {}
  set {TPsnapshotToplevel(WM_TAKE_FOCUS)} {}
  set {TPsnapshotToplevel(client)} {}
  set {TPsnapshotToplevel(command)} {}
  set {TPsnapshotToplevel(end)} {}
  set {TPsnapshotToplevel(focusmodel)} {passive}
  set {TPsnapshotToplevel(group)} {}
  set {TPsnapshotToplevel(iconbitmap)} {}
  set {TPsnapshotToplevel(iconmask)} {}
  set {TPsnapshotToplevel(iconname)} {}
  set {TPsnapshotToplevel(iconposition)} {}
  set {TPsnapshotToplevel(iconwindow)} {}
  set {TPsnapshotToplevel(title)} {Tick Tock}
  set {TPsnapshotToplevel(transient)} {}
  set {TPsnapshotToplevel(widget)} {.toplevel1}
  global {TPstatusLine}
  set {TPstatusLine} {}
  global {TPstretchhalo}
  set {TPstretchhalo} {-1.0}
  global {TPstretchobj}
  set {TPstretchobj} {1}
  global {TPtearoff}
  set {TPtearoff} {0}
  global {TPtemp}
  set {TPtemp} {ShowWindow.tpvars}
  global {TPtemp1}
  set {TPtemp1} {-weight}
  global {TPtemp2}
  set {TPtemp2} {0}
  global {TPtemplateAction}
  set {TPtemplateAction} {Load}
  global {TPtemplateDir}
  set {TPtemplateDir} {}
  global {TPtitle}
  set {TPtitle} {TKproE: Save namespace as...}
  global {TPtoolMove}
  set {TPtoolMove} {0}
  global {TPtoolX}
  set {TPtoolX} {34}
  global {TPtoolY}
  set {TPtoolY} {10}
  global {TPtoolcur}
  set {TPtoolcur} {cancel}
  global {TPtoolpath}
  set {TPtoolpath} {.toplevel3.frame0.canvas2}
  global {TPtoolstat}
  set {TPtoolstat(.canvas1)} {cancel}
  set {TPtoolstat(.canvas2)} {cancel}
  set {TPtoolstat(.canvas23)} {cancel}
  set {TPtoolstat(.canvas24)} {cancel}
  set {TPtoolstat(.frame0.canvas2)} {cancel}
  set {TPtoolstat(.toplevel0.frame3.canvas2)} {cancel}
  set {TPtoolstat(.toplevel10.canvas1)} {cancel}
  set {TPtoolstat(.toplevel11.canvas1)} {cancel}
  set {TPtoolstat(.toplevel11.vpanedwindow18.canvas22)} {cancel}
  set {TPtoolstat(.toplevel3.frame0.canvas2)} {cancel}
  set {TPtoolstat(.toplevel4.canvas1)} {cancel}
  set {TPtoolstat(.toplevel4.canvas5)} {cancel}
  global {TPtopMsg}
  set {TPtopMsg} {End: code executed after toplevel window is drawn}
  global {TPtoplevels}
  set {TPtoplevels(0)} {1}
  global {TPtxtCmd}
  set {TPtxtCmd} {.button0 configure -text}
  global {TPtypes}
  set {TPtypes} {
          {{TCL Scripts}      {.tcl} }
          {{Text Files}       {.txt}   }
          {{All Files}        *          }
          }
  global {TPundelcmd}
  set {TPundelcmd} {}
  global {TPval}
  set {TPval} {infront}
  global {TPvalue}
  set {TPvalue} {bottom}
  global {TPvarCmd}
  set {TPvarCmd} {set TPpropsStandard(text)}
  global {TPvarNamespace}
  set {TPvarNamespace} {::}
  global {TPvarNamespacePrefix}
  set {TPvarNamespacePrefix} {::}
  global {TPwatchList}
  set {TPwatchList} {}
  global {TPxposlast}
  set {TPxposlast} {64.0}
  global {TPyposlast}
  set {TPyposlast} {40.0}
  global {tcl_nonwordchars}
  set {tcl_nonwordchars} {\W}
  global {tcl_wordchars}
  set {tcl_wordchars} {\w}

  global TPstandardFonts
  set TPstandardFonts [font names]
}


# Procedure: TP_MenuCopy_Item
proc TP_MenuCopy_Item { wname orgPos moveto} {
# Copy the specified item in the specified menu widget to another position.

if {$orgPos != $moveto} {
    set proplist [$wname entryconfigure $orgPos]
    set newPos $moveto
    if {$orgPos > $moveto} {
        set cmd "$wname insert $newPos [$wname type $orgPos]"
       } {
           incr newPos
           if {$newPos <= [$wname index end]} {
	  set cmd "$wname insert $newPos [$wname type $orgPos]"
	} { set cmd "$wname add [$wname type $orgPos]" }
         }
   foreach propinfo $proplist {
	  lappend cmd [lindex $propinfo 0] [lindex $propinfo 4]
	}
    catch $cmd result
   }

return {}
}


# Procedure: TP_MenuEnum
proc TP_MenuEnum { wname Xpos Ypos propname varname itemList} {
# Fill and display the general menu using the items in the specified list.
global TPcurWidget

set menuName .tpmenugeneral
if {[winfo exists $menuName]} {
    set wclass [TP_ClassGet $menuName]
    switch $wclass {
	   Menu		{
			  $menuName delete 0 end
			  foreach item $itemList {
				  $menuName add command -label $item -command "set $varname [list $item]; focus -force $wname;update; focus -force [winfo parent $wname]"
				}
			  tk_popup $menuName $Xpos $Ypos
			}
	 }
   }
}


# Procedure: TP_MenuForm_Config
proc TP_MenuForm_Config { action} {
# Configure the menu properties form based on the specified action parameter.

set reframe .tpmenu.frame2.frame7.frame1
set f1 .tpmenu.frame2.frame7.frame8
set f2 .tpmenu.frame2.frame7.frame13
set f3 .tpmenu.frame2.frame7.frame11
set f4 .tpmenu.frame2.frame7.frame12
set f5 .tpmenu.frame2.frame7.frame14
set f6 .tpmenu.frame2.frame7.frame15
set f7 .tpmenu.frame2.frame7.frame16
set f8 .tpmenu.frame2.frame7.frame17
set f9 .tpmenu.frame2.frame7.frame18
set f10 .tpmenu.frame2.frame7.frame19
set f11 .tpmenu.frame2.frame7.frame21
set f12 .tpmenu.frame2.frame7.frame20
set f13 .tpmenu.frame2.frame7.frame22
set f14 .tpmenu.frame2.frame7.frame0
set f15 .tpmenu.frame2.frame7.frame
pack $f1 $f2 $f3 $f4 $f5 $f6 $f7 $f8 $f9 $f10 $f11 $f12 $f13 $f14 $f15 -after $reframe -side top -fill x
pack $f15 -fill both -expand 1

.tpmenu.frame2.frame7.frame1.menubutton3 configure -text $action

switch $action {
	cascade		{
			  pack forget $f9 $f10 $f11 $f12
			}
	checkbutton	{
			  pack forget $f8 $f11
			}
	command		{
			  pack forget $f8 $f9 $f10 $f11 $f12
			}
	radiobutton	{
			  pack forget $f8 $f9 $f10
			}
	separator		{
			  pack forget $f1 $f2 $f3 $f4 $f5 $f6 $f7 $f8 $f9 $f10 $f11 $f12 $f13 $f14 $f15
			}
        }
}


# Procedure: TP_MenuFromList
proc TP_MenuFromList { menuName itemList} {
# Fill a specified menu using the items in the specified list.

if {[winfo exists $menuName]} {
    if {[TP_ClassGet $menuName] == {Menu}} {
        $menuName delete 0 end
        foreach item $itemList {
	      $menuName add command -label $item -command "set TPcurNamespace $item; TP_ProcListFill"
	   }
      }
  }
}


# Procedure: TP_MenuFromList2
proc TP_MenuFromList2 { menuName itemList} {
# Fill a specified menu using the items in the specified list.
global TPexclusions

if {[winfo exists $menuName]} {
    if {[TP_ClassGet $menuName] == {Menu}} {
        $menuName delete 0 end
        foreach item $itemList {
	      $menuName add command -label $item -command "TP_ExcludeNamespaceAdd $item"
	   }
      }
  }
}


# Procedure: TP_MenuFromList3
proc TP_MenuFromList3 { menuName itemList} {
# Fill a specified menu using the items in the specified list.

if {[winfo exists $menuName]} {
    if {[TP_ClassGet $menuName] == {Menu}} {
        $menuName delete 0 end
        foreach item $itemList {
	      $menuName add command -label $item -command "set TPvarNamespace $item; TP_ProcListFill3"
	   }
      }
  }
}


# Procedure: TP_MenuFromList4
proc TP_MenuFromList4 { menuName itemList} {
# Fill a specified menu using the items in the specified list.

if {[winfo exists $menuName]} {
    if {[TP_ClassGet $menuName] == {Menu}} {
        $menuName delete 0 end
        foreach item $itemList {
	      $menuName add command -label $item -command "set TPimgNamespace $item; TP_ImgListFill"
	   }
      }
  }
}


# Procedure: TP_MenuFromList5
proc TP_MenuFromList5 { menuName itemList} {
# Fill a specified menu using the items in the specified list.

if {[winfo exists $menuName]} {
    if {[TP_ClassGet $menuName] == {Menu}} {
        $menuName delete 0 end
        foreach item $itemList {
	      $menuName add command -label $item -command "set TPimgSelNamespace $item; TP_ImgListFill2"
	   }
      }
  }
}


# Procedure: TP_MenuTree
proc TP_MenuTree { wname} {
# Recursively find all children of the specificed menu widget.
global TPtearoff

set rtnval {}
if {[winfo exists $wname]} {
    if {[TP_ClassGet $wname] == {Menu}} {
        if {[lsearch {.tp .xf} [string range $wname 0 2]] == -1} {
	set rtnval {}
	set TPtearoff 0
	set idx 0
	set more 1
	set lastitem {}
	while {$more} {
	         update
	         set proplist [$wname entryconfigure $idx]
	         if {$proplist == $lastitem} {
		set more 0
	           } {
		 set lastitem $proplist
		 set entryType [$wname type $idx]
		 switch $entryType {
		           cascade	{
				  set entryLabel [$wname entrycget $idx -label]
				  lappend rtnval $wname.$entryLabel
				  set result {}
				  #set result [TP_MenuTree [$wname entrycget $idx -menu]]
				  if {[string length $result] > 0} {
				      append rtnval " " $result
				     }
				}
		           separator	{
				  set entryLabel {<separator>}
				  lappend rtnval $wname.$entryLabel
				}
		           tearoff	{
				  set TPtearoff 1
				}
		           default	{
				  set entryLabel [$wname entrycget $idx -label]
				  lappend rtnval $wname.$entryLabel
				}
		         }
		 incr idx
		 if {$idx > 100} { set more 0 }
	             }
	      }
           }
       }
  }
return $rtnval
}


# Procedure: TP_MenuTreeFill
proc TP_MenuTreeFill { lbox menuList} {
# Fill the specified listbox with the menu tree provided.

if {[winfo exists $lbox]} {
    if {[TP_ClassGet $lbox] == {Listbox}} {
        $lbox delete 0 end
        set item [lindex $menuList 0]
        set basedots [regexp -all {***=.} $item]
        foreach item $menuList {
	      set isMenu 0
	      if {[winfo exists $item]} {
	          if {[TP_ClassGet $item] == {Menu}} {
		set isMenu 1
	            }
	         }
	      if {$isMenu} {
	          set line $item
	         } {
		# Remove menu path and replace with indenting spaces.
		set totdots [regexp -all {***=.} $item]
		set itemLabel [file extension $item]
		set tabs [expr {$totdots - $basedots}]
		if {$tabs < 0} { set tabs 0 }
		set line [string repeat {   } $tabs][string range $itemLabel 1 end]
	           }
	      $lbox insert end $line
	   }
      }
  }
return {}
}


# Procedure: TP_MenuTreeFillAll
proc TP_MenuTreeFillAll { lbox} {
# Fill the specified listbox with the menu tree for all application menus.

if {[winfo exists $lbox]} {
    if {[TP_ClassGet $lbox]  == {Listbox}} {
        set rtnval {}
        foreach child [TP_TreeSearch .] {
	      if {[TP_ClassGet $child] == {Menu}} {
	          lappend rtnval $child
	          set result [TP_MenuTree $child]
	          if {[string length $result] > 0} {
		append rtnval " $result"
	            }
	        }
	   }
        TP_MenuTreeFill $lbox $rtnval
      }
   }
return {}
}


# Procedure: TP_NamespaceList
proc TP_NamespaceList { curNamespace} {
# Recursively return all children of the specified namespace

set nslist [lsort [namespace children $curNamespace]]
set rtnval {}
foreach ns $nslist {
            set rtnval [concat $rtnval $ns [TP_NamespaceList $ns]]
         }
return $rtnval
}

proc ::TP_NotebookSelect {wname} {
global TPnotebookChild
global TPnotebook
global TPtabprop
global TPnewtab

set TPtemp [$wname curselection]
if {[llength $TPtemp]} {
     pack .tptabs.frame5 -after .tptabs.frame0 -fill x
     set TPnotebookChild [$wname get $TPtemp]
     if {[winfo exists $TPnotebookChild]} {
         set TPwin [winfo parent $TPnotebookChild]
         set TPtabs [$TPwin tabs]
         if {$TPnotebookChild in $TPtabs} {
              pack .tptabs.frame19 .tptabs.frame17 .tptabs.frame21 .tptabs.frame1 .tptabs.frame2 -after .tptabs.frame5 -fill x
              pack .tptabs.frame30 -after .tptabs.frame2 -fill none -anchor w
              set TPtabprop(state) [$TPwin tab $TPnotebookChild -state]
              set TPtabprop(padding) [$TPwin tab $TPnotebookChild -padding]
              set TPnewtab [$TPwin tab $TPnotebookChild -text]
              set TPtabprop(image) [$TPwin tab $TPnotebookChild -image]
              set TPtabprop(compound) [$TPwin tab $TPnotebookChild -compound]
              set TPtabprop(underline) [$TPwin tab $TPnotebookChild -underline]
              set TPtabprop(Managed) 1
              set TPtemp [string toupper [$TPwin tab $TPnotebookChild -sticky]]
              foreach TPpos {N E W S} {
	          switch $TPpos {
			    N	{ set TPwin .tptabs.frame30.frame23.button24 }
			    E	{ set TPwin .tptabs.frame30.frame32.button29 }
			    W	{ set TPwin .tptabs.frame30.frame32.button25 }
			    S	{ set TPwin .tptabs.frame30.frame33.button24 }
 		       }
	          if {[string first $TPpos $TPtemp] == -1} {
	              set TPnotebook(sticky$TPpos) 0
	              $TPwin configure -bg grey85
	             } {
			set TPnotebook(sticky$TPpos) 1
			$TPwin configure -bg salmon
	               }
	       }

              set TPwin .tptabs.frame30.frame32.frame0
              switch $TPtemp {
	        {}	{ pack $TPwin -fill none -expand 1 -anchor center }
	        n -
	        e -
	        w -
	        s -
	        ne -
	        nw -
	        se -
	        sw	{ pack $TPwin -fill none -expand 1 -anchor $TPtemp }
	        ns	{ pack $TPwin -fill y -expand 1 -anchor n }
	        ew	{ pack $TPwin -fill x -expand 1 -anchor w }
	        new	{ pack $TPwin -fill x -expand 1 -anchor n }
	        nse	{ pack $TPwin -fill y -expand 1 -anchor e }
	        sew	{ pack $TPwin -fill x -expand 1 -anchor s }
	        nsw	{ pack $TPwin -fill y -expand 1 -anchor w }
	        nsew	{ pack $TPwin -fill both -expand 1 -anchor n }
	    }
            } {
                set TPtabprop(Managed) 0
                pack forget .tptabs.frame1 .tptabs.frame2 .tptabs.frame17 .tptabs.frame19 .tptabs.frame21 .tptabs.frame30
              }
        }
   } { pack forget .tptabs.frame5 .tptabs.frame1 .tptabs.frame2 .tptabs.frame17 .tptabs.frame19 .tptabs.frame21 .tptabs.frame30 }
}

proc ::TP_NotebookShowSticky {posList} {
# Update the TPgridder sticky display.
global TPnotebook
global TPnotebookChild

if {[winfo exists .tptabs]} {
    foreach pos $posList {
        set idx sticky$pos
        if {$TPnotebook($idx)} {
            set TPnotebook($idx) 0
           } { set TPnotebook($idx) 1 }
       }
    set sval {}
    foreach pos {N S E W} {
	  switch $pos {
		N	{ set wname .tptabs.frame30.frame23.button24 }
		E	{ set wname .tptabs.frame30.frame32.button29 }
		W	{ set wname .tptabs.frame30.frame32.button25 }
		S	{ set wname .tptabs.frame30.frame33.button24 }
	          }
	   if {$TPnotebook(sticky$pos)} {
	       append sval [string tolower $pos]
	       $wname configure -bg salmon
  	      } { $wname configure -bg #dcdcdc }
	}
    set wname .tptabs.frame30.frame32.frame0
    switch $sval {
	{}	{ pack $wname -fill none -expand 1 -anchor center }
	n -
	e -
	w -
	s -
	ne -
	nw -
	se -
	sw	{ pack $wname -fill none -expand 1 -anchor $sval }
	ns	{ pack $wname -fill y -expand 1 -anchor n }
	ew	{ pack $wname -fill x -expand 1 -anchor w }
	new	{ pack $wname -fill x -expand 1 -anchor n }
	nse	{ pack $wname -fill y -expand 1 -anchor e }
	sew	{ pack $wname -fill x -expand 1 -anchor s }
	nsw	{ pack $wname -fill y -expand 1 -anchor w }
	nsew	{ pack $wname -fill both -expand 1 -anchor n }
            }
     set wname [winfo parent $TPnotebookChild]
     if {[winfo exists $wname]} {
          $wname tab $TPnotebookChild -sticky $sval
        }
   }
}


# Procedure: TP_OptionsRead
proc TP_OptionsRead {} {
# Read the general options from file.
global TPhomeDir
global TPsaveInterval
global TPsaveDir
global TPnewObjNameAsk
global TPgeoMgr
global TPeditor
global TPinfo
global TPpginRev
global TPpdfViewer
global TPtemplateDir
global tcl_platform

set rtnval 0
set fpath [file join $TPhomeDir TPconfig.txt]
if {[catch {open $fpath r} fin]} {
     ;
   } {
       while {![eof $fin]} {
	   gets $fin line0
	   set line [string trim $line0]
	   if {[string index $line 0] != {#}} {
	        set pos [string first {=} $line]
	        if {$pos != -1} {
		set endpos $pos
		incr endpos -2
		if {$endpos > 0} {
		    set varname [string range $line 0 $endpos]
		    incr pos 2
		    set varval [string range $line $pos end]
		    switch $varname {
			 TPsaveInterval		{ set TPsaveInterval $varval }
			 TPsaveDir			{ set TPsaveDir [string trim $varval] }
			 TPtemplateDir		{ set TPtemplateDir [string trim $varval] }
			 TPnewObjNameAsk	{ set TPnewObjNameAsk $varval }
			 TPgeoMgr			{ set TPgeoMgr $varval }
			 TPpginRev			{ set TPpginRev $varval }
			 TPeditor			{ set TPeditor $varval }
			 TPpdfViewer		{ set TPpdfViewer $varval }
		            }
		   }
	           }
	      }
	  }
       close $fin
       set rtnval 1
     }
	 
if {$TPsaveDir == {}} {
    # No autosave directory defined. Use a default value.
    set TPsaveDir [file join [pwd] autosave]
   }

if {[file isdir $TPsaveDir] == 0} {
   # The auto save directory doesn't yet exist.
   if {[file exists $TPsaveDir] == 0} {
	# No ordinary file exists by the same name.
	# Create the autosave directory.
	if {[catch {file mkdir $TPsaveDir} result]} {
	    # We were unable to create the directory.
	    set TPsaveDir {}
	   }
      }
   }

if {$TPtemplateDir == {}} {
    # No default template directory defined. Use a default value.
    if {[namespace exists freewrap]} {
        if {$::freewrap::runMode eq {wrappedExec}} {
		    set TPtemplateDir [file join [file dirname [info nameofexec]] templates]
           } { set TPtemplateDir [file join [file dirname $::argv0] templates] }
       }
   }

if {[file isdir $TPtemplateDir] == 0} {
   # The template directory doesn't yet exist.
   if {[file exists $TPtemplateDir]} {
       # An ordinary file already exists wit the same name as our desired directory.
       set TPtemplateDir {}
      } {
          # No ordinary file exists by the same name.
          # Create the template directory.
          if { [catch {file mkdir $TPtemplateDir } result] } {
              # We were unable to create the directory.
              set TPtemplateDir {}
             }
        }
   }

if {$TPpdfViewer == {}} {
     # No PDF file viewer defined. Try to find one.
     switch $tcl_platform(platform) {
	unix	{
		  set TPpdfViewer [auto_execok acroread]
		  if {[string length $TPpdfViewer] == 0} { set TPpdfViewer [auto_execok kghostview] }
		}
	windows	{
		  set TPpdfViewer [auto_execok acrdr.exe]
		}
              }
    }

return $rtnval
}


# Procedure: TP_OptionsSave
proc TP_OptionsSave {} {
# Save the general options to file.
global TPhomeDir
global TPautosaveInterval
global TPsaveInterval
global TPautosaveDir
global TPsaveDir
global TPnewObjNameAsk
global TPgeoMgr
global TPeditor
global TPinfo
global TPpginRev
global TPpdfViewer
global TPtemplateDir

# Adjust auto save interval
set TPautosaveInterval [string trim $TPautosaveInterval]
if {[string is double -strict $TPautosaveInterval]} {
     if {$TPautosaveInterval < 0.0} { set TPautosaveInterval 0 }
     if {$TPautosaveInterval > 480.0} { set TPautosaveInterval 480 }
   } {
       set TPautosaveInterval 15
     }
set newInterval [expr int($TPautosaveInterval * 60000.0)]
if {$newInterval != $TPsaveInterval} {
     after cancel TP_AutoSave
     set TPsaveInterval $newInterval
     if {$TPsaveInterval != 0} { after $TPsaveInterval TP_AutoSave }
   }

# Adjust auto-save directory
set TPsaveDir [string trim $TPautosaveDir]
if {[string length $TPsaveDir] > 0} {
    catch {file mkdir $TPsaveDir}
   }

# Adjust default template directory
set TPtemplateDir [string trim $TPtemplateDir]
if {[string length $TPtemplateDir] > 0} {
    catch {file mkdir $TPtemplateDir}
   }

set fpath [file join $TPhomeDir TPconfig.txt]
if {[catch {open $fpath w} fout]} {
     TP_ShowMsg $fout
   } {
       puts $fout "# TKproE $TPinfo(revision) general options"
       puts $fout "# Saved [clock format [clock seconds] -format {%D  %T}]"
       puts $fout "TPsaveInterval = $TPsaveInterval"
       puts $fout "TPsaveDir = $TPsaveDir"
	   puts $fout "TPtemplateDir = $TPtemplateDir"
       puts $fout "TPnewObjNameAsk = $TPnewObjNameAsk"
       puts $fout "TPgeoMgr = $TPgeoMgr"
       puts $fout "TPpginRev = $TPpginRev"
       puts $fout "TPeditor = $TPeditor"
       puts $fout "TPpdfViewer = $TPpdfViewer"
       close $fout
     }

return {}
}


# Procedure: TP_PackSetOrder
proc TP_PackSetOrder { newpos} {
# Adjust the pack order the current packing child.
global TPpackParent
global TPpackChild

if {[winfo exists $TPpackParent]} {
    set slaves [pack slaves $TPpackParent]
    set curpos [lsearch $slaves $TPpackChild]
     if {$curpos > -1} {
         if {$newpos != $curpos} {
	if {$newpos < [llength $slaves]} {
	    if {$newpos < $curpos} {
	          pack configure $TPpackChild -before [lindex $slaves $newpos]
	      } { pack configure $TPpackChild -after [lindex $slaves $newpos] }
	      .tppacker.frame28.frame30.listbox1 delete 0 end
	      eval ".tppacker.frame28.frame30.listbox1 insert end [pack slaves $TPpackParent]"
	      .tppacker.frame28.frame30.listbox1 select set $newpos
	      .tppacker.frame28.frame30.listbox1 yview $newpos
	   }
           } 
       }
  }
}


proc ::TP_PanedwindowSel {wname} {
global TPpaneconfig
global TPpanecancel

set TPtemp2 {}
foreach TPtemp [$wname cget -values] {
	if {$TPtemp ne $TPpaneconfig(window)} {
	    lappend TPtemp2 $TPtemp
	   }
	.tppane.frame0.combobox10 configure -values $TPtemp2
	.tppane.frame2.combobox10 configure -values $TPtemp2
            }
foreach TPtemp {after before height hide minsize padx pady sticky stretch width} {
	set TPtemp2 [winfo parent $TPpaneconfig(window)]
	set TPpaneconfig($TPtemp) [$TPtemp2 panecget $TPpaneconfig(window) -$TPtemp]
	set TPpanecancel($TPtemp) $TPpaneconfig($TPtemp)
            }}

proc ::TP_PanewindowSet {} {
global TPpaneconfig
global TPpaneWidget

if {[winfo exists $TPpaneconfig(window)]} {
    foreach TPtemp {after before height hide minsize padx pady sticky stretch width} {
	$TPpaneWidget paneconfigure $TPpaneconfig(window) -$TPtemp $TPpaneconfig($TPtemp)
                }
   }
}


# Procedure: TP_PathMenuCreate
proc TP_PathMenuCreate { newpath} {
# Create the current widget path menu.
global TPcurPath

if {[winfo exists $newpath]} {
   set TPcurPath $newpath

   set wname .tpmain.pathbar.menubar
   if {[winfo exists $wname]} {
       TP_WindowDestroy $wname
     }

   set bgcolor PapayaWhip

   # Create frame to hold widget path menu items
   frame $wname -borderwidth 2 -bg $bgcolor -relief flat
   pack $wname -after .tpmain.pathbar.label34 -side left

   # Create root path menu item.
   set dotroot $wname.dotroot
   set cmd "TP_PathMenuPopup  {.} \[winfo rootx $dotroot\] \[winfo rooty $dotroot\]"
   button $dotroot -text {.} -command $cmd -bg $bgcolor -padx 0 -pady 0 -relief flat -borderwidth 0 -highlightthickness 0
   pack $dotroot -side left -fill x
   bind $dotroot <ButtonPress-3> {TP_PathMenuCopy %W}
   # Add path menu items.
   set parent $TPcurPath
   set ctr 0
   while {$parent != {.}} {
	set newwidget $wname.dotmenu$ctr
	set cmd "TP_PathMenuPopup $parent \[winfo rootx $newwidget\] \[winfo rooty $newwidget\]"
	button $newwidget -text {.} -command $cmd -padx 0 -pady 0 -bg $bgcolor -relief flat -borderwidth 0 -highlightthickness 0
	pack $newwidget -after $dotroot -side left
      bind $newwidget <ButtonPress-3> {TP_PathMenuCopy %W}
	set newwidget $wname.dotbtn$ctr
	set cmd "TP_PathMenuCreate $parent"
	button $newwidget -text [winfo name $parent] -command $cmd -bg $bgcolor -padx 0 -pady 0 -relief flat -borderwidth 0 -highlightthickness 0
	pack $newwidget -after $dotroot -side left
	set parent [winfo parent $parent]
	incr ctr
      bind $newwidget <ButtonPress-3> {TP_PathMenuCopy %W}
         }
  }
  bind $wname <Enter> {set TPstatusLine {Press mouse button 3 to copy \
    the entire current path.}}
  bind $wname <Leave> {set TPstatusLine {}}
  bind $wname <ButtonPress-3> {TP_PathMenuCopy %W}
}

proc TP_PathMenuCopy {wnm} {
    global TPcurPath
    global TPstatusLine
    clipboard clear
    clipboard append $TPcurPath
    set TPstatusLine ""
    set TPstatusLine "Captured: [clipboard get]"
    update
    after 200
    set TPstatusLine ""
    set TPstatusLine {Press mouse button 3 to copy the entire current path.}
    update
}

# Procedure: TP_PathMenuPopup
proc TP_PathMenuPopup { wname Xpos Ypos} {
# Fill and display the general menu with the children of the specified window.
global TPcurWidget

if {[winfo exists $wname]} {
    set menuName .tpmenugeneral
    if {[winfo exists $menuName]} {
        if {[TP_ClassGet $menuName] == {Menu}} {
            $menuName delete 0 end
            set childlist {}
            set children [lsort [winfo children $wname]]
            foreach child $children {
                         if {$child != $menuName} {
			     # Ignore XF or TP windows
			     set prefix [string range $child 1 2]
			     set nlist tp
			     if {[lsearch $nlist $prefix] == -1} {
				 lappend childlist $child
				}
			     }
	       }
            if {$wname == {.}} { $menuName add command -label . -command "TP_PathMenuCreate ." }
            foreach child $childlist {
	         set cname [winfo name $child]
	         $menuName add command -label $cname -command "TP_PathMenuCreate $child"
	       }
            tk_popup $menuName $Xpos $Ypos
          }
      }
  }
}


# Procedure: TP_ProcEditFill
proc TP_ProcEditFill { procname} {
global TPeditProcName
global TPeditProcParameters

set TPeditProcName $procname
set TPeditProcParameters {}
set wname .tpprocs.frame2.proctext
if {[winfo exists $wname]} {
    $wname delete 1.0 end
    set TPtemp [$wname cget -state]
    $wname configure -state normal
    set TPeditProcParameters {}
    if {[info proc $procname] ne {}} {
	$wname insert 1.0 [string trimleft [info body $procname] \n]
	$wname configure -state $TPtemp
	set TPeditProcParameters {}
	foreach argname [info args $procname] {
		if {[info default $procname $argname defval]} {
		    lappend TPeditProcParameters "$argname \{$defval\}"
		   } { lappend TPeditProcParameters $argname }
	      }
       }
   }
}


# Procedure: TP_ProcListFill
proc TP_ProcListFill {} {
#
global TPcurNamespace
global TPcurNamespacePrefix
global TPexclusions
global TPeditProcName
global TPeditProcParameters

.tpprocs.frame.proclist delete 0 end

if {$TPcurNamespace == {::}} {
    set TPcurNamespacePrefix {::}
  } {
      set TPcurNamespacePrefix ${TPcurNamespace}::
    }

set curProcName $TPcurNamespacePrefix$TPeditProcName
if {[info proc $curProcName] == {}} {
    set wname .tpprocs.frame2.proctext
    set TPeditProcName {}
    set TPeditProcParameters {}
    set origstate [$wname cget -state]
    $wname configure -state normal
    $wname delete 1.0 end
    $wname configure -state $origstate
  }

eval ".tpprocs.frame.proclist insert end [TP_ProcListGet $TPcurNamespace]"

if {[lsearch $TPexclusions(namespace) $TPcurNamespace] < 0} {
    # Namespace procedures may be altered.
    .tpprocs.frame19.button20 configure -state normal
    .tpprocs.frame19.button22 configure -state normal
    .tpprocs.frame19.button23 configure -state normal
    .tpprocs.frame19.button25 configure -state normal
    .tpprocs.frame19.button1 configure -state normal
    .tpprocs.frame2.proctext configure -state normal
  } {
      # Current namespace is on exclusion list.
      # Do not allow user to alter variables.
    .tpprocs.frame19.button20 configure -state disabled
    .tpprocs.frame19.button22 configure -state disabled
    .tpprocs.frame19.button23 configure -state disabled
    .tpprocs.frame19.button25 configure -state disabled
    .tpprocs.frame19.button1 configure -state disabled
    .tpprocs.frame2.proctext configure -state disabled
     }
}


# Procedure: TP_ProcListFill3
proc TP_ProcListFill3 {} {
#
global TPvarNamespace
global TPvarNamespacePrefix
global TPexclusions
global TPglobalVar

.tpvars.frame1.varlist delete 0 end
eval ".tpvars.frame1.varlist insert end [TP_VarListGet $TPvarNamespace]"
if {$TPvarNamespace == {::}} {
  set TPvarNamespacePrefix {::}
  } {
      set TPvarNamespacePrefix ${TPvarNamespace}::
    }

set TPglobalVar {}
.tpvars.frame8.varvalue configure -state normal
.tpvars.frame8.varvalue delete 1.0 end

if {[lsearch $TPexclusions(namespace) $TPvarNamespace] < 0} {
      # Namespace variables may be altered.
      .tpvars.frame11.button12 configure -state normal
      .tpvars.frame11.button13 configure -state normal
      .tpvars.frame11.button14 configure -state normal
      .tpvars.frame8.varvalue configure -state normal
  } {
      # Current namespace is on exclusion list.
      # Do not allow user to alter variables.
      .tpvars.frame11.button12 configure -state disabled
      .tpvars.frame11.button13 configure -state disabled
      .tpvars.frame11.button14 configure -state disabled
      .tpvars.frame8.varvalue configure -state disabled
    }
}


# Procedure: TP_ProcListGet
proc TP_ProcListGet { {nnspace ""}} {
# Retrieve a list of all procedures created by the application.
global auto_index
global TPcurNamespace
global TPexclusions

set rtnval {}
if {$nnspace == {}} {
     set nspace $TPcurNamespace
  } { set nspace $nnspace }

if {$nspace == {::}} {
    set globalspace 1
    set pattern ::*
    set namestart 2
  } {
      set globalspace 0
      set pattern ${nspace}::*
      set namestart [string length $nspace]
      incr namestart 2
    }
foreach procname [info procs $pattern] {
	set reason 0
	set pname [string range $procname $namestart end]

	if {$globalspace} {
	    # Skip certain procedures in the global namespace.

	    # Skip procedures with TCL reserved names
	    foreach item {tkerror exit destroy unknown} {
		  if {$item == $pname} { set reason 1}
	             }

	    # Skip procedures related to the display of windows used by TKproE
	    foreach wname $TPexclusions(windows) {
		 foreach prefix {ShowWindow DestroyWindow StartupSrc EndSrc} {
			if {$pname == "$prefix$wname"} { set reason 6 }
		            }
	              }

	    # Skip procedure names that start with certain strings
	    set nlist {auto_ tcl tk_ TP InitGlobals}
	    foreach item $nlist {
		  if {[string first $item $pname] == 0} { set reason 2 }
	               }

	    # Skip procedures that are auto_loaded
	    if {[info exists auto_index($pname)]} { set reason 3 }
	   }

	    # Skip procedures that were imported from some other namespace.
	    set oname [namespace origin $procname]
	    if {$oname != $procname} { set reason 4 }

	    if {$reason == 0} { lappend rtnval $pname }
         }
return [lsort -dictionary $rtnval]
}


# Procedure: TP_ProcessClick
proc TP_ProcessClick { wname Xpos Ypos xpos ypos} {
global TPcurCanvas
global TPcurCanvasPoint
global TPcurCanvasObjXpos
global TPcurCanvasObjYpos

if {$wname == $TPcurCanvas && $TPcurCanvasPoint} {
    set TPcurCanvasObjXpos $xpos
    set TPcurCanvasObjYpos $ypos
    .tpcanvas.frame2.frame21.frame.text2 insert insert " $xpos $ypos "
    TP_CVcoordAdjust accept .tpcanvas.frame2.frame21.frame.text2
  }
}


# Procedure: TP_PropsForCanvas
proc TP_PropsForCanvas { wname} {
# Display configuration window for Canvas widget
global TPcurPath

if {[winfo exists $wname]} {
    if {[TP_ClassGet $wname] == {Canvas}} {
        TP_CanvasSelect $wname
        if {[winfo exists .tpcanvas]} {
	EndSrc.tpcanvas
           } { ShowWindow.tpcanvas }
     }
  }
}

# Procedure: TP_PropsForMenu
proc TP_PropsForMenu { wname} {
# Display configuration window for Canvas widget
global TPcurMenu

if {[winfo exists $wname]} {
    if {[TP_ClassGet $wname] == {Menu}} {
        set TPcurMenu $wname
        TP_SnapshotMenu $wname
        if {[winfo exists .tpmenu]} {
	.tpmenu.frame2.frame30.listbox1 delete 0 end
	TP_MenuTreeFill .tpmenu.frame2.frame30.listbox1 [TP_MenuTree $wname]
           } { ShowWindow.tpmenu }
     }
  }
}


proc TP_PropsForTNotebook { wname} {
# Display configuration window for ttk:Notebook widget
global TPcurNotebook

if {[winfo exists $wname]} {
    if {[TP_ClassGet $wname] == {TNotebook}} {
        set TPcurNotebook $wname
        if {[winfo exists .tptabs]} {
	EndSrc.tptabs
           } { ShowWindow.tptabs }
     }
  }
}


proc TP_PropsForTreeview {wname} {
# Display configuration window for ttk:Treeview widget
global TPcurTree

if {[winfo exists $wname]} {
    if {[TP_ClassGet $wname] eq {Treeview}} {
        set TPcurTree $wname
        if {[winfo exists .tpTreeview]} {
	TPendSrc.tpTreeview
           } {ShowWindow.tpTreeview }
     }
  }
}


# Procedure: TP_PropsGeometrySet
proc TP_PropsGeometrySet { wname propname Arrayvar} {
# Configure specified property of current widget
global TPpropsInfo
global TPcolor
global TPpropsGeometry
global TPpropsSpecific
global TPpropsStandard
global TPfontCmd
global TPcurWidget
global TPpropsInfo
global TPcurGeoMgr

if {[winfo exists $TPcurWidget]} {
    if {[info exists TPpropsInfo($propname)]} {
        set action [lindex $TPpropsInfo($propname) 0]
        set vname "$Arrayvar\($propname\)"
        if {[TP_ClassGet $TPcurWidget] == {Toplevel}} {
	set geoMgr wm
           } { set geoMgr $TPcurGeoMgr }
        switch $geoMgr {
	     grid -
	     pack -
	     place	{
		  catch {$geoMgr configure $TPcurWidget -$propname [set $vname]} result
		}
	     panedwindow {
		  set wname [winfo parent $TPcurWidget]
		  catch {$wname paneconfig $TPcurWidget -$propname [set $vname]} result
		}
	     wm	{
		  switch $propname {
			aspect -
			geometry -
			grid -
			maxsize -
			minsize -
			overrideredirect -
			positionfrom -
			sizefrom -
			state	{
				  catch "wm $propname $TPcurWidget [set $vname]"
				}
			maximum_width {
				  foreach {Rwidth Rheight} [wm maxsize $TPcurWidget] {}
				  catch "wm maxsize $TPcurWidget [set $vname] $Rheight" result
				}
			maximum_height {
				  foreach {Rwidth Rheight} [wm maxsize $TPcurWidget] {}
				  catch "wm maxsize $TPcurWidget $Rwidth [set $vname]"
				}
			minimum_width {
				  foreach {Rwidth Rheight} [wm minsize $TPcurWidget] {}
				  catch "wm minsize $TPcurWidget [set $vname] $Rheight"
				}
			minimum_height {
				  foreach {Rwidth Rheight} [wm minsize $TPcurWidget] {}
				  catch "wm minsize $TPcurWidget $Rwidth [set $vname]"
				}
			resizable_height {
				  foreach {Rwidth Rheight} [wm resizable $TPcurWidget] {}
				  catch "wm resizable $TPcurWidget $Rwidth [set $vname]"
				}
			resizable_width {
				  foreach {Rwidth Rheight} [wm resizable $TPcurWidget] {}
				  catch "wm resizable $TPcurWidget [set $vname] $Rheight"
				}
		          }
		}
	  }
       }
   }
}


# Procedure: TP_PropsGetList
proc TP_PropsGetList { wname {listType "standard"}} {
# This proc returns a list of the standard properties associated with the specified widget
global TPpropsStandardList

set standardList {}
set specificList {}
set exclusionList {class}
if {[winfo exists $wname]} {
    set proplist [$wname configure]
    foreach propinfo $proplist {
	  if {[llength $propinfo] == 5} {
	      set propname [string range [lindex $propinfo 0] 1 end]
	      if {[lsearch $TPpropsStandardList $propname] < 0} {
	          if {[lsearch $exclusionList $propname] < 0} {
		      if {[lsearch $specificList $propname] == -1} { lappend specificList $propname }
		     }
	         } {
		      if {[lsearch $standardList $propname] == -1} { lappend standardList $propname }
	           }
	     }
	}
   }
switch $listType {
	standard	{ set rtnval $standardList }
	specific	{ set rtnval $specificList }
	default		{ set rtnval $standardList }
        }

return $rtnval
}


# Procedure: TP_PropsSelWidget
proc TP_PropsSelWidget { wname} {
# This is the main procedure that determines which widget configuration window to display.
global TPcurWidget

if {[winfo exists $wname]} {
    set prefix [string range $wname 0 2]
    if {$prefix != {.tp}} {
    set wclass [TP_ClassGet $wname]
    set procName TP_PropsFor$wclass
    if {[info proc $procName] == {}} {
         TP_Snapshot $wname
         set TPcurWidget $wname
         if {[winfo exists .tpproperties]} {
	EndSrc.tpproperties
            } { ShowWindow.tpproperties }
       } {
           $procName $wname
         }
       }
  }
}


# Procedure: TP_PropsShowHide
proc TP_PropsShowHide { wname} {
# Expand or shrink the properties display of the specified section
global TPcurWidget
global TPcurGeoMgr
global TPpropsWidget
global TPpropsGeometry
global TPpropsStandard
global TPpropsSpecific
global TPpropsInfo
global TPexclusions
global TPstate

if {[winfo exists $TPcurWidget] == 0} { return }

set ebox [focus -lastfor .tpproperties]
if {[TP_ClassGet $ebox] == {Entry}} {
    event generate $ebox <Key-Return>
  }

set winlist {}
lappend winlist .tpproperties.frame6.canvas2.frame5.propswidget
lappend winlist .tpproperties.frame6.canvas2.frame5.propsgeometry
lappend winlist .tpproperties.frame6.canvas2.frame5.propsstandard
lappend winlist .tpproperties.frame6.canvas2.frame5.propsspecific
lappend winlist .tpproperties.frame6.canvas2.frame5.propsstates
set labeltext [$wname cget -text]
set Usection [lindex $labeltext 0]
set section [string tolower $Usection]
set parent [winfo parent $wname]
switch $section {
	widget	{
		  set action [string index $labeltext 8]
		  set fname $parent.props$section
		  if {$action == {+}} {
		        # Expand property display
		        pack $fname -after $wname -side top -anchor w
		        $wname configure -text {Widget (-)}
		        set TPpropsWidget(name) $TPcurWidget
		        set TPpropsWidget(class) [TP_ClassGet $TPcurWidget]
		        set TPpropsWidget(parent) [winfo parent $TPcurWidget]
		        after 100 "TP_ExpandToplevel \{$winlist\}"
		    } {
		        # Contract property display
		        pack forget $fname
		        $wname configure -text {Widget (+)}
		      }
		}
	geometry	{
		  set action [string index $labeltext 10]
		  set fname $parent.props$section
		  if {$action == {+}} {
		       frame $fname -background gray85
		       pack $fname -after $wname -side top -anchor w
		       set TPcurGeoMgr [winfo manager $TPcurWidget]
		       switch $TPcurGeoMgr {
			  pack	{
				  set proplist [pack info $TPcurWidget]
				  set gname packer
				}
			  place	{
				  set proplist [place info $TPcurWidget]
				  set gname placer
				}
			  grid	{
				  set proplist [grid info $TPcurWidget]
				  set gname gridder
				}
			  wm	{
				  set proplist {}
				  set optList {aspect geometry grid iconbitmap iconmask iconname}
				  foreach option $optList {
					lappend proplist -$option
					lappend proplist [wm $option $TPcurWidget]
				           }
				  foreach {rwidth rheight} [wm maxsize $TPcurWidget] {}
				  lappend proplist {-maximum_width} $rwidth {-maximum_height} $rheight
				  foreach {rwidth rheight} [wm minsize $TPcurWidget] {}
				  lappend proplist {-minimum_width} $rwidth {-minimum_height} $rheight
				  set optList {overrideredirect positionfrom}
				  foreach option $optList {
					lappend proplist -$option
					lappend proplist [wm $option $TPcurWidget]
				           }
				  foreach {rwidth rheight} [wm resizable $TPcurWidget] {}
				  lappend proplist {-resizable_width} $rwidth {-resizable_height} $rheight
				  set optList {sizefrom state}
				  foreach option $optList {
					lappend proplist -$option
					lappend proplist [wm $option $TPcurWidget]
				           }
				  set gname wm
				}
			  panedwindow	{
				  set proplist {}
				  set optList [[winfo parent $TPcurWidget] paneconfig $TPcurWidget]
				  foreach optInfo $optList {
					    set option [lindex $optInfo 0]
					    if {[lsearch {-after -before} $option] == -1} { 
						 lappend proplist $option [lindex $optInfo end]
						}
					  }
				  set gname panedwindow
				}
			  default	{ set proplist {}}
			}
		       if {$proplist != {}} {
		           if {[lsearch {wm panedwindow} $TPcurGeoMgr] == -1} { DestroyWindow.tp$gname }
		           set titleframe $fname.tframe
		           frame $titleframe -background gray85
		           pack $titleframe -side top -anchor w
		           set titlename $titleframe.title
		           label $titlename -text "Manager:" -font {Helvetica 12 bold} -foreground red -background grey85
		           pack $titlename -side left
		           if {[lsearch {wm panedwindow} $TPcurGeoMgr] != -1} {
		               label $titleframe.mgrbtn -text $gname -highlightthickness 0 -padx 4 -pady 2 -font {Helvetica 10} -foreground black -background grey85 -relief flat -borderwidth 0
			} { button $titleframe.mgrbtn -text $gname -highlightthickness 0 -padx 4 -pady 2 -font {Helvetica 10} -foreground black -background grey85 -command "ShowWindow.tp$gname; TP_PropsShowHide $wname" }
		           pack $titleframe.mgrbtn -side left
		           set ctr 0
		           foreach {propname propval} $proplist {
			         incr ctr
			         set rowname $fname.frame$ctr
			         frame $rowname -background grey85
			         pack $rowname -side top
			         set proplabel $rowname.propname
			         set propname [string range $propname 1 end]
			         label $proplabel -text [regsub _ $propname { }] -relief flat -anchor w -width 16 -font {Helvetica 12} -background grey85 -foreground black
			         pack $proplabel -side left
			         set propentry $rowname.propentry
			         set action [lindex $TPpropsInfo($propname) 0]
			         if {$action == {int}} {
				foreach {action fromvalue tovalue} $TPpropsInfo($propname) {}
				spinbox $propentry -textvariable TPpropsGeometry($propname) -command "TP_PropsGeometrySet $propentry \{$propname\} TPprops$Usection" -to $tovalue -from $fromvalue -relief sunken -width 19 -font {Helvetica 10} -background white -foreground black
				pack $propentry -side left -fill x -ipadx 3
			            } {
				  entry $propentry -textvariable TPpropsGeometry($propname) -relief sunken -width 21 -font {Helvetica 10} -background white -foreground black
				  pack $propentry -side left -fill x -padx 1
				}
			         set TPpropsGeometry($propname) $propval
			         bind $propentry <Button-3> "TP_PropsValueSel %W %X %Y \{$propname\} TPprops$Usection"
			         bind $propentry <FocusOut> "TP_PropsGeometrySet %W \{$propname\} TPprops$Usection"
			         bind $propentry <Key-Return> "TP_PropsGeometrySet %W \{$propname\} TPprops$Usection"
			         bind $propentry <Key-KP_Enter> "TP_PropsGeometrySet %W \{$propname\} TPprops$Usection"
			      }
		          }
		       $wname configure -text {Geometry (-)}
		       after 100 "TP_ExpandToplevel \{$winlist\}"
		    } {
		       # Contract Geometry attributes display
		       TP_WindowDestroy $fname
		       catch {unset TPpropsGeometry}
		       $wname configure -text {Geometry (+)}
		      }
		}
	standard	{
		  set action [string index $labeltext 18]
		  set fname $parent.props$section
		  if {$action == {+}} {
		        frame $fname -borderwidth 0 -background grey85
		        pack $fname -after $wname -side top -anchor w
		        set proplist [lsort [TP_PropsGetList $TPcurWidget]]
		        set ctr 0
		        if {$proplist != {}} {
			foreach propname $proplist {
				incr ctr
				set rowname $fname.stdframe$ctr
				frame $rowname -background grey85
				pack $rowname -side top -anchor w
				set proplabel $rowname.propname
				label $proplabel -text $propname -relief flat -anchor w -width 16 -font {Helvetica 12} -background grey85 -foreground black
				pack $proplabel -side left
				set propentry $rowname.propentry
				set action [lindex $TPpropsInfo($propname) 0]
				if {$action == {int}} {
				       foreach {action fromvalue tovalue} $TPpropsInfo($propname) {}
				       spinbox $propentry -textvariable TPpropsStandard($propname) -command "TP_PropsValueSet $propentry $propname TPprops$Usection" -to $tovalue -from $fromvalue -relief sunken -width 19 -font {Helvetica 10} -background white -foreground black
				       pack $propentry -side left -fill x -ipadx 3
				   } {
				       entry $propentry -textvariable TPpropsStandard($propname) -relief sunken -width 21 -font {Helvetica 10} -background white -foreground black
				       pack $propentry -side left -fill x -padx 1
				     }
				set TPpropsStandard($propname) [$TPcurWidget cget -$propname]
				bind $propentry <Button-3> "TP_PropsValueSel %W %X %Y $propname TPprops$Usection"
				bind $propentry <FocusOut> "TP_PropsValueSet %W $propname TPprops$Usection"
				bind $propentry <Key-Return> "TP_PropsValueSet %W $propname TPprops$Usection"
				bind $propentry <Key-KP_Enter> "TP_PropsValueSet %W $propname TPprops$Usection"
			         }
		           }
		        $wname configure -text {Standard Options (-)}
		        after 100 "TP_ExpandToplevel \{$winlist\}"
		    } {
		        # Contract the Standard Options display
		        TP_WindowDestroy $fname
		        unset TPpropsStandard
		        $wname configure -text {Standard Options (+)}
		      }
		}
	states	{
		  set action [string index $labeltext 8]
		  set fname $parent.props$section
		  if {$action == {+}} {
			# Create the checkboxes for each state.
		        frame $fname -borderwidth 0 -background #dcdcdc
		        pack $fname -after $wname -side top -anchor w
			foreach chkbox {active alternate background disabled focus invalid pressed readonly selected} {
				set Chkbox [string toupper [string index $chkbox 0]][string range $chkbox 1 end]
				set cmd "if {\$TPstate($chkbox)} { \$TPcurWidget state $chkbox } { \$TPcurWidget state !$chkbox }"
				checkbutton $fname.cb$chkbox -anchor {w} -bg #dcdcdc -borderwidth {0} -command $cmd -font {Helvetica 12} -highlightthickness {0} -padx {0} -pady {0} -text $Chkbox -variable TPstate($chkbox)
				pack $fname.cb$chkbox -anchor w -expand 0 -fill none -ipadx 0 -ipady 0 -padx 0 -pady 0 -side top
			      }

			# Set the checkbox values based on the current widget.
			set curstates [$TPcurWidget state]
			foreach statename {active alternate background disabled focus invalid pressed readonly selected} {
				if {$statename in $curstates} {
				    set TPstate($statename) 1
				   } { set TPstate($statename) 0 }
			      }

		        $wname configure -text {States (-)}
		        after 100 "TP_ExpandToplevel \{$winlist\}"
		    } {
		        # Contract the Specific Options display
		        TP_WindowDestroy $fname
		        $wname configure -text {States (+)}
		      }		 
		}
	specific	{
		  set action [string index $labeltext 18]
		  set fname $parent.props$section
		  if {$action == {+}} {
		        frame $fname -borderwidth 0 -background grey85
		        pack $fname -after $wname -side top -anchor w
		        set proplist [lsort [TP_PropsGetList $TPcurWidget specific]]
		        set ctr 0
		        if {$proplist != {}} {
			foreach propname $proplist {
				# Some properties cannot be configured after widget creation.
				if {[lsearch $TPexclusions(reconfig) $propname] != -1} { continue }

				incr ctr
				set rowname $fname.specframe$ctr
				frame $rowname -background grey85
				pack $rowname -side top -anchor w
				set proplabel $rowname.propname
				label $proplabel -text $propname -relief flat -anchor w -width 16 -font {Helvetica 12} -background grey85 -foreground black
				pack $proplabel -side left
				set propentry $rowname.propentry
				if {[catch {lindex $TPpropsInfo($propname) 0} action]} { set action {} }
				if {$action == {int}} {
				       foreach {action fromvalue tovalue} $TPpropsInfo($propname) {}
				       spinbox $propentry -textvariable TPpropsSpecific($propname) -command "TP_PropsValueSet $propentry $propname TPprops$Usection" -to $tovalue -from $fromvalue -relief sunken -width 19 -font {Helvetica 10} -background white -foreground black
				       pack $propentry -side left -fill x -ipadx 3
				   } {
				       entry $propentry -textvariable TPpropsSpecific($propname) -relief sunken -width 21 -font {Helvetica 10} -background white -foreground black
				       pack $propentry -side left -fill x -padx 1
				     }
				set TPpropsSpecific($propname) [$TPcurWidget cget -$propname]
				bind $propentry <Button-3> "TP_PropsValueSel %W %X %Y $propname TPprops$Usection"
				bind $propentry <FocusOut> "TP_PropsValueSet %W $propname TPprops$Usection"
				bind $propentry <Key-Return> "TP_PropsValueSet %W $propname TPprops$Usection"
				bind $propentry <Key-KP_Enter> "TP_PropsValueSet %W $propname TPprops$Usection"
			         }
		           }
		        $wname configure -text {Specific Options (-)}
		        after 100 "TP_ExpandToplevel \{$winlist\}"
		    } {
		        # Contract the Specific Options display
		        TP_WindowDestroy $fname
		        unset TPpropsSpecific
		        $wname configure -text {Specific Options (+)}
		      }
		}
        }
}


# Procedure: TP_PropsToplevelSet
proc TP_PropsToplevelSet { wname propname Arrayvar} {
# Configure specified property of current widget
global TPpropsInfo
global TPcolor
global TPpropsGeometry
global TPpropsSpecific
global TPpropsStandard
global TPfontCmd
global TPcurToplevel
global TPpropsInfo
global TPcurGeoMgr
global TPpropsToplevel

if {[TP_ClassGet $TPcurToplevel] == {Toplevel}} {
    if {[info exists TPpropsInfo($propname)]} {
        set action [lindex $TPpropsInfo($propname) 0]
        set vname "$Arrayvar\($propname\)"
        switch $propname {
	    client -
	    focusmodel -
	    group -
	    iconbitmap -
	    iconmask -
	    iconname -
	    iconwindow -
	    title -
	    transient -
	    wm_command	{
			  if {$propname == {wm_command}} { set propname command }
			  set curVal [wm $propname $TPcurToplevel]
			  set newVal [set $vname]
			  if {$newVal != $curVal} {
			      if {[catch "wm $propname $TPcurToplevel \{[set $vname]\}" result]} {
				set msg "The following error occurred while setting the $propname property:\n\n$result"
				TP_ShowMsg $msg
			         }
			     }
			}
	    iconposition	{
			  set curVal [wm $propname $TPcurToplevel]
			  set newVal [set $vname]
			  if {$newVal != $curVal} {
			      if {[catch "wm $propname $TPcurToplevel [set $vname]" result]} {
			           set msg "The following error occurred while setting the $propname property:\n\n$result"
			           TP_ShowMsg $msg
			         }
			     }
			}
	  }
       }
   }
return {}
}


# Procedure: TP_PropsValueSel
proc TP_PropsValueSel { wname xpos ypos apropname Arrayvar} {
# Display the necessary menu or form to select a new value for the specified property.
global TPpropsInfo
global TPcolor
global TPpropsStandard
global TPpropsSpecific
global TPpropsToplevel
global TPfontCmd
global TPcurWidget
global TPpropsInfo
global TPimgCmd
global TPcolorCmd
global TPcurMenu
global TPcfgCmd
global TPmenuItem
global TPtxtCmd
global TPvarCmd
global TPcurToplevel
global TPtabprop
global TPnotebookChild

if {[winfo exists $wname]} { focus $wname }
set TPcfgCmd {$TPcurWidget configure}
set TPcolorCmd {}
if {[string index $apropname 0] == {-}} {
    set propname [string range $apropname 1 end]
  } { set propname $apropname }
if {[info exists TPpropsInfo($propname)]} {
    set action [lindex $TPpropsInfo($propname) 0]
    switch $action {
	color	{
		  set TPcolor(varname) "$Arrayvar\($apropname\)"
		  ShowWindow.tpcolorsel
		  set TPcolorCmd "$TPcurWidget configure -$propname"
		  upvar #0 $TPcolor(varname) colorval
		  catch "TP_ColorSetSample $colorval"
		}
	bool -
	enum	{
		  TP_MenuEnum $wname $xpos $ypos $propname "$Arrayvar\($apropname\)" [lrange $TPpropsInfo($propname) 1 end]
		}
	file	{
		  set filename [tk_getOpenFile -title "Select file for $propname property" -initialdir [pwd] {{{All files} .*}}]
		  if {$filename != {}} {
		      set vname "$Arrayvar\($apropname\)"
		      switch $propname {
			  bitmap	{
				  set $vname "@$filename"
				  $TPcurWidget configure -$propname "@$filename"
				}
			  iconbitmap -
			  iconmask {
				  set $vname "@$filename"
				  if {[catch "wm $propname $TPcurToplevel \{@$filename\}" result]} {
				      TP_ShowMsg $result
				     }
				}
			}
		    }
		}
	font	{
		  set TPpropsInfo(propname) $propname
		  set vname "$Arrayvar\($apropname\)"
		  set TPpropsInfo(propval) [set $vname]
		  set TPfontCmd "set $Arrayvar\($apropname\) \[TP_FontGetSelected\]; $TPcurWidget configure -$propname \[TP_FontGetSelected\]"
		  ShowWindow.tpfontselect
		}
	image	{
		  set TPpropsInfo(propname) $propname
		  set vname "$Arrayvar\($apropname\)"
		  set TPpropsInfo(propval) [set $vname]
		  set TPimgCmd "set $Arrayvar\($apropname\)"
		  if {[TP_ClassGet $TPcurWidget] eq {TNotebook}} {
		      set TPcfgCmd "$TPcurWidget tab $TPnotebookChild -$propname"
		     } { set TPcfgCmd "$TPcurWidget configure -$propname" }
		  ShowWindow.tpimagesel
		}
	int	{
		}
	menu	{
		  TP_PropsValueSet $wname $apropname $Arrayvar
		  set vname "$Arrayvar\($apropname\)"
		  set TPcurMenu [$TPcurWidget cget -menu]
		  TP_SnapshotMenu $TPcurMenu
		  if {[winfo exists .tpmenu]} {
		        EndSrc.tpmenu
		     } { ShowWindow.tpmenu }
		}
	cursor -
	text	{
		}
	textedit	{
		   if {[winfo exists $TPcurWidget]} {
		       if {![catch {$TPcurWidget cget -$propname} cmd]} {
		           set TPpropsInfo(propname) $propname
		           set TPvarCmd "set $Arrayvar\($apropname\)"
		           set TPtxtCmd "$TPcurWidget configure -$propname"
		           ShowWindow.tpcmdedit
		           after 60
		           update
		           wm title .tpcmdedit "TKproE: Edit $propname property"
		           .tpcmdedit.frame.text2 delete 1.0 end
		           .tpcmdedit.frame.text2 insert end $cmd
		         }
		     }
		}
           }
  }
}


# Procedure: TP_PropsValueSet
proc TP_PropsValueSet { wname propname Arrayvar} {
# Configure specified property of current widget
global TPpropsInfo
global TPcolor
global TPpropsGeometry
global TPpropsSpecific
global TPpropsStandard
global TPfontCmd
global TPcurWidget
global TPpropsInfo
global TPmessage
global TPmsgButtons
global TPnotebookChild
global TPtabprop

if {[info exists TPpropsInfo($propname)]} {
    set action [lindex $TPpropsInfo($propname) 0]
    set vname "$Arrayvar\($propname\)"
    switch $action {
	color	{
		  catch {$TPcurWidget configure -$propname [set $vname]}
		}
	bool -
	enum -
	image	{
		  if {[TP_ClassGet $TPcurWidget] eq {TNotebook}} {
		      if {[catch {$TPcurWidget tab $TPnotebookChild -$propname [set $vname]} TPresult]} { puts $TPresult }
		     } { catch {$TPcurWidget configure -$propname [set $vname]} }
		}
	file	{
		  switch $propname {
			bitmap	{
				  catch {$TPcurWidget configure -$propname "[set $vname]"}
				}
		         }
		}
	float	{
		  catch {$TPcurWidget configure -$propname [set $vname]}
		}
	font	{
		  catch {$TPcurWidget configure -$propname [set $vname]}
		}
	int	{
		  catch {$TPcurWidget configure -$propname [set $vname]}
		}
	menu	{
		  set badval 1
		  set menuName [set $vname]
		  if {[winfo exists $menuName]} {
		      if {[TP_ClassGet $menuName] == {Menu}} {
		          # The specified name belongs to an existing menu.
		          if {[lsearch [winfo children $TPcurWidget] $menuName] != -1} {
			# The menu is a proper child of the menu button.
			$TPcurWidget configure -$propname [set $vname]
			set badval 0
		             }
		         }
		     }
		  if {$badval} { catch {set $vname [$TPcurWidget cget -menu]} }
		}
	text	{
		  catch {$TPcurWidget configure -$propname [set $vname]}
		}
	textedit	{
		   if {[catch "$TPcurWidget configure -$propname \{[set $vname]\}" result]} {
		        set TPmessage $result
		        set TPmsgButtons OK
		        if {[winfo exists .tpmsgbox]} {
			EndSrc.tpmsgbox
		           } { ShowWindow.tpmsgbox }
		      }
		}
           }
  }
}


# Procedure: TP_RenameProcAsk
proc TP_RenameProcAsk {} {
# Rename a procedure
global TPmessage
global TPcurNamespace
global TPeditProcName
global TPglobalVarNew
global TPmsgButtons
global TPmsgCmd

set oldname $TPcurNamespace$TPeditProcName
if {[info proc $oldname] != {}} {
    set TPmessage "Enter new name for procedure\n$oldname"
    set TPglobalVarNew $oldname
    set TPmsgButtons {Accept Cancel Input}
    set TPmsgCmd(Accept) "rename $oldname \$TPglobalVarNew; TP_ProcListFill; set TPmsgCmd(Accept) {}; set TPmsgCmd(Cancel) {}; set TPmsgButtons {}"
    set TPmsgCmd(Cancel) "set TPmsgCmd(Accept) {}; set TPmsgCmd(Cancel) {}; set TPmsgButtons {}"
    ShowWindow.tpmsgbox
  }
}


# Procedure: TP_RenameVar
proc TP_RenameVar { basename idx newname} {
# Rename a variable

if {[string length $idx] > 0} {
    # We are working with an array item.
    set newvar $basename\($newname\)
    if {[info exists $newvar] == 0} {
        # The array item doesn't yet exist.
        set oldvar $basename\($idx\)
        set $newvar [set $oldvar]
        unset $oldvar
      }
  } {
       set $newname [set $basename]
       unset $basename
    }
}


# Procedure: TP_RenameVarAsk
proc TP_RenameVarAsk {} {
# Rename a variable
global TPmessage
global TPvarNamespace
global TPglobalVar
global TPglobalVarNew
global TPmsgButtons
global TPmsgCmd

if {$TPvarNamespace == {::}} {
    set TPprefix {}
  } { set TPprefix $TPvarNamespace }
set oldname ${TPprefix}::$TPglobalVar
if {[info exists $oldname]} {
   set basename [lindex [split $oldname \(] 0]
   if {$oldname != $basename} {
         # We are dealing with an array item.
         set pos [string length $basename]
         incr pos
         set idx [string range $oldname $pos end-1]
         set TPmessage "Enter new index name for variable\n$oldname"
         set TPglobalVarNew $idx
    } {
         set idx {}
         set TPmessage "Enter new name for variable\n$oldname"
         set TPglobalVarNew $oldname
        }
   set TPmsgButtons {Accept Cancel Input}
   set TPmsgCmd(Accept) "TP_RenameVar $basename \{$idx\} \$TPglobalVarNew; TP_ProcListFill3; set TPmsgCmd(Accept) {}; set TPmsgCmd(Cancel) {}; set TPmsgButtons {}"
   set TPmsgCmd(Cancel) "set TPmsgCmd(Accept) {}; set TPmsgCmd(Cancel) {}; set TPmsgButtons {}"
   ShowWindow.tpmsgbox
 }
}


proc TP_ShowHelp { fname} {
global env
global tcl_platform
global TPhomeDir
global TPpdfViewer

set fpath {}
if {[namespace exists ::zvfs]} {
    set docPath [::zvfs::list */$fname]
    if {$docPath ne {}} {
        if {[catch {file tempfile fpath} fout]} {
            set fpath {}
           } {
              close $fout
              file delete $fpath
              set fpath [file join [file dirname $fpath] $fname]
              file delete $fpath
              if {[catch {file copy -force $docPath $fpath}]} { set fpath {} }
             }
       }
   }
if {$fpath eq {}} {
    set fpath [file join $TPhomeDir $fname]
    if {![file isfile $fpath]} { set fpath {} }
   }

if {$fpath ne {}} {
    switch $tcl_platform(platform) {
        unix	{
            # Search for a program to display the documentation.
            set tryAgain 0
            if {[auto_execok $TPpdfViewer] ne {}} {
                if {[catch {exec $TPpdfViewer $fpath &} emsg]} {
                set tryAgain 1
                    }
                } { set tryAgain 1 }
            if {$tryAgain} {
                if {[catch {exec okular $fpath &} emsg]} {
                    set msg "You still need to specify the path to your PDF viewer\napplication in the TKproE general options dialog box."
                    tk_messageBox -icon error -message $msg -parent . -title {TKproE configuration error} -type ok
                    }
                }
            }
        windows	{
            if {[string length $TPpdfViewer] > 0} {
                if {[catch {exec $TPpdfViewer $fpath &} emsg]} {
                set msg "Unable to view $fname using $TPpdfViewer\n$emsg"
                    tk_messageBox -icon error -message $msg -parent . -title {TKproE configuration error} -type ok
                    }
                } {
                if {[catch "exec [file join $env(COMSPEC)] /c $fpath &" emsg]} {
                    set msg "You still need to specify the path to your PDF viewer\napplication in the TKproE general options dialog box."
                        tk_messageBox -icon error -message $msg -parent . -title {TKproE configuration error} -type ok
                    }
                }
            }
        }
   }
}


# Procedure: TP_ShowMsg
proc TP_ShowMsg { msg} {
# Display the message provided in a generic message box
global TPmsgButtons
global TPmessage

set TPmessage $msg
set TPmsgButtons OK
if {[winfo exists .tpmsgbox]} {
    EndSrc.tpmsgbox
   } { ShowWindow.tpmsgbox }
}


# Procedure: TP_ShowToplevels
proc TP_ShowToplevels {} {
global TPshowToplevels

if {[winfo exists .tpToplevels]} {
    DestroyWindow.tpToplevels
    set TPshowToplevels 0
  } {
      ShowWindow.tpToplevels
      set TPshowToplevels 1
    }
}


# Procedure: TP_ShowWidgetTree
proc TP_ShowWidgetTree {} {
global TPshowWidgetTree

if {[winfo exists .tpTree]} {
    DestroyWindow.tpTree
    set TPshowWidgetTree 0
  } {
      ShowWindow.tpTree
      set TPshowWidgetTree 1
    }
}


# Procedure: TP_ShowWidgets
proc TP_ShowWidgets {} {
global TPshowWidgets

if {$TPshowWidgets == "1"} {
    set TPshowWidgets 0
    DestroyWindow.tptkwidgets
    pack .tpmain.objbar -after .tpmain.cmdbar -side top -anchor w
  } {
      set TPshowWidgets 1
      pack forget .tpmain.objbar
      ShowWindow.tptkwidgets
    }
}


# Procedure: TP_Snapshot
proc TP_Snapshot { wname} {
# Take a snapshot of the properties assigned to the specified widget.
global TPsnapshot

if {[winfo exists $wname]} {
    if {[info exists TPsnapshot]} { unset TPsnapshot }
    set TPsnapshot(widget) $wname
    set optlist [$wname configure]
    foreach optInfo $optlist {
	  set optname [lindex $optInfo 0]
	  set optval [lindex $optInfo end]
	  if {[string index $optval 0] != {-}} {
	      # We are not looking at an option alias. We are looking at the actual value.
	      set TPsnapshot($optname) $optval
	     }
	}
   }
return {}
}


# Procedure: TP_SnapshotChildren
proc TP_SnapshotChildren { wname varname geomgr} {
# Take a snapshot of the configuration for all children of wname managed by the specified geometry manager.
global TPpackOrder
global TPpackParent
global TPpackChild
global TPplaceParent
global TPplaceChild
global TPgridOrder
global TPgridParent
global TPgridChild
global TPmenuEntry

if {[winfo exists $wname]} {
   upvar #0 $varname vname
   array unset vname
   set wlist [$geomgr slaves $wname]
   switch $geomgr {
	grid	{
		   upvar #0 ${varname}Row vnameRow
		   upvar #0 ${varname}Col vnameCol
		   array unset vnameRow
		   array unset vnameCol
		   foreach widget $wlist {
			 set vname($widget) [lrange [$geomgr info $widget] 2 end]
 		            }
		  set TPgridOrder $wlist
		  foreach {col row} [grid size $wname] {}
		  for {set ctr 0} {$ctr < $col} {incr ctr} {
		        set vnameCol($ctr) [grid columnconfigure $wname $ctr]
		     }
		  for {set ctr 0} {$ctr < $row} {incr ctr} {
		        set vnameRow($ctr) [grid rowconfigure $wname $ctr]
		     }

		  set TPgridParent $wname
		  set TPgridChild {}
		}
	pack	{
		   foreach widget $wlist {
			 set vname($widget) [lrange [$geomgr info $widget] 2 end]
 		            }
		  set TPpackOrder $wlist
		  set TPpackParent $wname
		  set TPpackChild {}
		}
	place	{
		   foreach widget $wlist {
			 set vname($widget) [$geomgr info $widget]
			 lappend vname($widget) {-bordermode}
			 lappend vname($widget) [lindex [place configure $widget -bordermode] 4]
 		            }
		  set TPplaceParent $wname
		  set TPplaceChild {}
		}
	menu	{
		  array unset TPmenuEntry
		  
		}
          }
  }
}


# Procedure: TP_SnapshotMenu
proc TP_SnapshotMenu { wname} {
# Take a snapshot of the configuration for the specified menu widget.
global TPmenuEntry

if {[winfo exists $wname]} {
    if {[TP_ClassGet $wname] == {Menu}} {
        if {[lsearch {.tp .xf} [string range $wname 0 2]] == -1} {
	array unset TPmenuEntry
	set TPmenuEntry(path) $wname
	set idx 0
	set more 1
	set lastitem {}
	while {$more} {
	         set proplist [$wname entryconfigure $idx]
	         if {$proplist == $lastitem} {
		set more 0
	           } {
		 set lastitem $proplist
		 set propvals {}
		 foreach propinfo $proplist {
			lappend propvals [lindex $propinfo 0] [lindex $propinfo 4]
		          }
		 set entryType [$wname type $idx]
		 set TPmenuEntry($idx) [list $entryType $propvals]
		 incr idx
		 if {$idx > 100} { set more 0 }
	             }
	      }
           }
       }
  }
}


# Procedure: TP_SnapshotRestore
proc TP_SnapshotRestore { wname} {
# Restore the specified widget to the last snapshot taken.
global TPsnapshot

if {[winfo exists $wname]} {
    if {[info exists TPsnapshot(widget)]} {
        if {$TPsnapshot(widget) == $wname} {
            unset TPsnapshot(widget)
            foreach idx [array names TPsnapshot] {
	          catch "$wname configure $idx [list $TPsnapshot($idx)]" result
	       }
           }
       }
   }
return {}
}


# Procedure: TP_SnapshotRestoreChildren
proc TP_SnapshotRestoreChildren { varname snaptype} {
# Restore from snapshot the configuration for all children of wname
global TPpackOrder
global TPgridOrder
global TPoptionsGridCol
global TPoptionsGridRow
global TPgridParent

upvar #0 $varname vname
if {[info exists vname]} {
    switch $snaptype {
	grid	{
		  if {![winfo exists $TPgridParent]} { return {} }
		  # Reset the grid configuration for each widget
		  foreach widget $TPgridOrder {
			if {[winfo exists $widget]} {
			   catch "grid configure $widget $vname($widget)"
			  }
 		           }
		  # Reset the column configuration for the grid
		  foreach col [array names TPoptionsGridCol] {
			catch "grid columnconfigure $TPgridParent $col $TPoptionsGridCol($col)"
		            }
		  # Reset the row configuration for the grid
		  foreach row [array names TPoptionsGridRow] {
			catch "grid rowconfigure $TPgridParent $row $TPoptionsGridRow($row)"
		            }
		}
	pack	{
		  set lastwidget {}
		  foreach widget $TPpackOrder {
			if {[winfo exists $widget]} {
			   if {$lastwidget == {}} {
			         catch "pack configure $widget $vname($widget)"
			     } { catch "pack configure $widget $vname($widget) -after $lastwidget" }
			   set lastwidget $widget
			  }
 		           }
		}
	place	{
		  foreach widget [array names vname] {
			if {[winfo exists $widget]} {
			    catch "place configure $widget $vname($widget)"
			  }
 		           }
		}
	menu	{
		}
           }
  }
}


# Procedure: TP_SnapshotRestoreMenu
proc TP_SnapshotRestoreMenu { wname} {
# Restore the specified menu from a previous snapshot.
global TPmenuEntry

if {[winfo exists $wname]} {
    if {[TP_ClassGet $wname] == {Menu}} {
        if {[lsearch {.tp .xf} [string range $wname 0 2]] == -1} {
	if {[info exists TPmenuEntry(path)]} {
	    if {$TPmenuEntry(path) == $wname} {
	        # The snapshot information pertains to the specified menu. Good!
	        unset TPmenuEntry(path)
	        set entryList [lsort -integer [array names TPmenuEntry]]
	        set TPmenuEntry(path) $wname
	        $wname configure -tearoff 0
	        $wname delete 0 end
	        foreach idx $entryList {
		      set entryType [lindex $TPmenuEntry($idx) 0]
		      switch $entryType {
			   tearoff	{
				   $wname configure -tearoff 1
				}
			   default	{
				   catch "$wname add $entryType [lindex $TPmenuEntry($idx) 1]"
				}
			}
		   }
	       }
	   }
           }
       }
  }
}


# Procedure: TP_SnapshotRestoreToplevel
proc TP_SnapshotRestoreToplevel { wname} {
# Restore the properties of the specified toplevel window to those taken at the last snapshot.
global TPsnapshotToplevel

if {[TP_ClassGet $wname] == {Toplevel}} {
    if {[info exists TPsnapshotToplevel(widget)]} {
        if {$TPsnapshotToplevel(widget) == $wname} {
	# We are trying to restore the same Toplevel we took a snapshot of. Good.
	foreach propname {focusmodel client group transient iconwindow} {
	      catch "wm $propname $wname $TPsnapshotToplevel($propname)"
	    }
 	foreach propname {title command iconbitmap iconmask iconname iconposition} {
	      catch "wm $propname $wname \{$TPsnapshotToplevel($propname)\}"
	    }
	set procname TPstartupSrc$wname
	if {[string length $TPsnapshotToplevel(startup)] > 0} {
	    proc $procname {} $TPsnapshotToplevel(startup)
	   }
	set procname TPendSrc$wname
	if {[string length $TPsnapshotToplevel(end)] > 0} {
	    proc $procname {} $TPsnapshotToplevel(end)
	   }
	foreach cmd {WM_DELETE_WINDOW WM_SAVE_YOURSELF WM_TAKE_FOCUS} {
		wm protocol $wname $cmd $TPsnapshotToplevel($cmd)
	         }
          }
       }
   }
return {}
}


# Procedure: TP_SnapshotToplevel
proc TP_SnapshotToplevel { wname} {
# Take a snapshot of the properties assigned to the specified toplevel window.
global TPsnapshotToplevel

if {[TP_ClassGet $wname] == {Toplevel}} {
    if {[info exists TPsnapshotToplevel]} { unset TPsnapshotToplevel }
    set TPsnapshotToplevel(widget) $wname
    foreach propname {title focusmodel client command group transient iconbitmap iconmask iconname iconposition iconwindow} {
	  set TPsnapshotToplevel($propname) [wm $propname $wname]
	}
    set procname TPstartupSrc$wname
    if {[info proc $procname] != {}} {
        set TPsnapshotToplevel(startup) [string trimleft [info body $procname] \n]
      } { set TPsnapshotToplevel(startup) {} }
    set procname TPendSrc$wname
    if {[info proc $procname] != {}} {
        set TPsnapshotToplevel(end) [string trimleft [info body $procname] \n]
      } { set TPsnapshotToplevel(end) {} }
    foreach cmd {WM_DELETE_WINDOW WM_SAVE_YOURSELF WM_TAKE_FOCUS} {
	  set TPsnapshotToplevel($cmd) [wm protocol $wname $cmd]
	}
   }
return {}
}


# Procedure: TP_Source
proc TP_Source {fname} {
global TPexclusions

if {[catch {uplevel #0 source \{$fname\}} result]} {
     TP_ShowMsg $result
    }
if {[info exists TPexclusions(user_namespace)]} {
     foreach nspace $TPexclusions(user_namespace) { lappend TPexclusions(namespace) $nspace }
     unset TPexclusions(user_namespace)
    }
}


# Procedure: TP_Startup
proc TP_Startup {} {
global TPstatusLine
global TPnextObj
global TPhomeDir
global argv
global TPexclusions
global TPtemplate
global TPtemplateList

catch {console show}

# Redefine exit procedure to trap attempts to exit the program.
if {[info command TP_RealExit] == {} } {
    rename exit TP_RealExit
    proc exit {args} {tk_messageBox -message {Application requested EXIT}}
  }
if {[info command TP_RealChooseDir] == {} } {
    rename tk_chooseDirectory TP_RealChooseDir
    rename TP_chooseDirectory tk_chooseDirectory
   }
if {[info command TP_RealOpenFile] == {} } {
    rename tk_getOpenFile TP_RealOpenFile
    rename TP_getOpenFile tk_getOpenFile
   }
if {[info command TP_RealSaveFile] == {} } {
    rename tk_getSaveFile TP_RealSaveFile
    rename TP_getSaveFile tk_getSaveFile
   }

set TPstatusLine {}
set TPnextObj 0
TP_TitlebarUpdate

# Create a few necessary bindings for TKproE
bind all <ButtonRelease-1> {catch {TP_ProcessClick %W %X %Y %x %y}}
bind all <Shift-Button-3> {catch {TP_PropsSelWidget %W}}

TP_PathMenuCreate .
set TPhomeDir [TP_InfoGetHomeDir]
TP_OptionsRead
set TPexclusions(cantsave_namespace) [TP_NamespaceList ::]
set TPexclusions(namespace) $TPexclusions(cantsave_namespace)
set TPexclusions(globalvar) [info globals]
set TPexclusions(images) [image names]
set TPexclusions(fonts) [font names]
after 3000 TP_AutoSave

# Load the standard templates.
set templateDir [TP_GetConfig dirTemplates]
set filelist [glob -nocomplain -directory $templateDir *]
foreach filename $filelist {
        if {![catch {open $filename r} fin]} {
			gets $fin line
			set templateSign {# ClonePath = .}
			set slen [string length $templateSign]
			incr slen -1
			set fileSign [string range $line 0 $slen]
			if {$fileSign eq $templateSign} {
                # The file is a valid TKproE template.
                seek $fin 0 start
				set tailName [file tail $filename]
				set TPtemplate($tailName) [read $fin]
               }
			close $fin
		   }
      }
set TPtemplateList [lsort -dictionary [array names TPtemplate]]

# Read command line arguments
if {[string length $argv] > 0} {
    if {[catch {lindex $argv 0} fname]} {
      } {
           set fname [file join $fname]
           if {[file isfile $fname]} {
               # Remove file name from command line argument list.
			   set argv [lrange $argv 1 end]

               # Load the specified file.
               TP_Clear_app
               after idle "TP_Source \{$fname\}; set TPprogFile \{$fname\}; TP_TitlebarUpdate"
               set TPexclusions(namespace) $TPexclusions(cantsave_namespace)
             } {
                  # Specified file was not found. Clear command line argument list.
                  set argv {}
               }
        }
  }
}


# Procedure: TP_Template_TPbind
proc TP_Template_TPbind { wname} {
if {"[info procs TP_CreateNewObj]" != {}} {
     bind TOPLEVEL <ButtonRelease-1> {catch {TP_ProcessClick %W %X %Y %x %y}}
     bind TOPLEVEL <Shift-Button-3> {catch {TP_PropsSelWidget %W}}
   }
}


# Procedure: TP_Template_ToplevelClose
proc TP_Template_ToplevelClose { wname} {
# Auto-generated by TKproE
if {"[info procs TP_ToplevelCreateProcs]" != {}} {
       catch {TP_ToplevelCreateProcs TOPLEVEL}
       catch {destroy TOPLEVEL}
   } {
       catch {destroy TOPLEVEL}
     }
return {}
}


# Procedure: TP_TitlebarUpdate
proc TP_TitlebarUpdate {} {
global TPprogFile

set progname [TP_GetConfig progname]
if {[string length $TPprogFile]} {
     wm title .tpmain "$progname - [file tail $TPprogFile]"
    } { wm title .tpmain $progname }
wm iconphoto .tpmain tplogo16
}


# Procedure: TP_ToolChoose
proc TP_ToolChoose { position} {
global TPtoolpath
global TPtoolstat
global TPtoolcur
global TPB1_press_list
global TPB1_motion_list
global TPB1_release_list
global TPobjaddfirst
global TPobjdelfirst
global TPobjmovefirst
global TPcurCanvasPoint

set TPcurCanvasPoint 0
set TPtoolstat($TPtoolpath) $position
set highcolor red
set normalcolor #dcdcdc
#LISSI
if {$position == "saveimage" || $position == "savefile"} {
    global TPbboxL
    set TPbboxL [$TPtoolpath bbox Selected]
    puts "bboxl=$TPbboxL";
    if {$TPbboxL == ""} {
	set TPbboxL [$TPtoolpath bbox groupbox]
	puts "bboxl (groupbox)=$TPbboxL";
    }
}

TP_cancel_bind $TPtoolpath
#LISSI
TPdelUtagGrp
TPdelUtagReshape
#reshape and grpresize

switch $position {
	cancel	{TP_cancel_bind $TPtoolpath; set TPtoolcur cancel}
	conpipe	{TP_DTconpipe_bind $TPtoolpath}
	copy	{TP_copy_bind $TPtoolpath}
	delete	{TP_delete_bind $TPtoolpath}
	ID	{ if {[lsearch $TPB1_press_list ID] == -1} {lappend TPB1_press_list ID} }
	move	{TP_move_bind $TPtoolpath}
	onemove {TP_DTonemove_bind $TPtoolpath}
	objmove	{
		  TP_DTobj_bind $TPtoolpath
		  set TPobjmovefirst 1
		}
	objadd	{
		  if {[lsearch $TPB1_press_list objadd] == -1} {lappend TPB1_press_list objadd}
		  set TPobjaddfirst 1
		}
	objdel	{
		  if {[lsearch $TPB1_press_list objdel] == -1} {lappend TPB1_press_list objdel}
		  set TPobjdelfirst 1
		}
	pop	{ if {[lsearch $TPB1_press_list pop] == -1} {lappend TPB1_press_list pop} }
	push	{ if {[lsearch $TPB1_press_list push] == -1} {lappend TPB1_press_list push} }
	stretch	{TP_stretch_bind $TPtoolpath}
	reshape {TP_cancel_bind $TPtoolpath; TP_reshapeMode}
	savefile 	{TP_saveGroupToFileOrImage 0}
	saveimage 	{TP_saveGroupToFileOrImage 1}
	grpresize {TP_cancel_bind $TPtoolpath;TP_SelectGroupMode}
	saveoneimage {TP_DTsaveoneimage_bind $TPtoolpath }
	saveonefile {TP_DTsaveonefile_bind $TPtoolpath }
   }
}


# Procedure: TP_ToplevelCreateProcs
proc TP_ToplevelCreateProcs { wname} {
# Create Open and Close procedures for the specified toplevel window

if {[TP_ClassGet $wname] == {Toplevel}} {
    # Don't save TKproE widgets and toplevels
    set checkstr [string tolower [string range $wname 1 2]]
    set nlist tp
    if {[lsearch $nlist $checkstr] == -1} {
         # The toplevel belongs to the application we are developing.

         # Check for existence of TPstartupSrc and TPendSrc procedures
         foreach prefix {TPstartupSrc TPendSrc} {
	       set procname $prefix$wname
	       if {[info proc $procname] == {}} {
	           set procexists($prefix) 0
	          } {
		if {[string length [info body $procname]] == 0} {
		    # Remove the empty procedure
		    rename $procname {}
		    set procexists($prefix) 0
		   } { set procexists($prefix) 1 }
	             }
	    }

         set body {}
         if {$procexists(TPstartupSrc)} { append body "TPstartupSrc$wname\n" }
         append body [TP_Clone_TKwidget $wname]
         if {$procexists(TPendSrc)} { append body "TPendSrc$wname\n" }
         proc TPopenWindow$wname {} $body
         if {$wname == {.}} {
                proc TPcloseWindow. {} {wm state . withdrawn}
            } {
                proc TPcloseWindow$wname {} [regsub -all {TOPLEVEL} [string trimleft [info body TP_Template_ToplevelClose] \n] $wname]
              }
       }
   }
return {}
}


# Procedure: TP_ToplevelSearch
proc TP_ToplevelSearch {} {
# Return the list of all toplevel windows.
# The root window is returned as the name ROOT

# Make sure the proper TKproE procedures are up to date for all existing toplevels
set winlist [winfo children .]
lappend winlist .
foreach wname $winlist {
	if {[TP_ClassGet $wname] == {Toplevel}} {
	    TP_ToplevelCreateProcs $wname
	   }
          }
TP_ToplevelCreateProcs .

set plist [info proc TPopenWindow.*]
set rtnval ROOT
foreach pname [lsort -dictionary $plist] {
	set wname [string range $pname 13 end]
	if {[string length $wname] != 0} { lappend rtnval $wname }
         }

return $rtnval
}


proc ::TP_TpanedwindowSel {wname} {
global TPtpaneconfig
global TPtpanecancel

foreach TPtemp weight {
	set TPtemp2 [winfo parent $TPtpaneconfig(window)]
	set TPtpaneconfig($TPtemp) [$TPtemp2 pane $TPtpaneconfig(window) -$TPtemp]
	set TPtpanecancel($TPtemp) $TPtpaneconfig($TPtemp)
            }
}


proc ::TP_TpanedwindowSet {} {
global TPtpaneconfig
global TPtpaneWidget

if {[winfo exists $TPtpaneconfig(window)]} {
    foreach TPtemp weight {
	$TPtpaneWidget pane $TPtpaneconfig(window) -$TPtemp $TPtpaneconfig($TPtemp)
                }
   }
}


# Procedure: TP_TreeSearch
proc TP_TreeSearch { wname} {
# Recursively find all children of the specified widget path.

set rtnval {}
if {[winfo exists $wname]} {
    if {$wname ni {.__tk_filedialog .__tk_choosedir}} {
        if {[lsearch {.tp .xf} [string range $wname 0 2]] == -1} {
            set rtnval $wname
            set childlist [lsort [winfo children $wname]]
            foreach child $childlist {
					 set result [TP_TreeSearch $child]
					  if {[string length $result] > 0} {
						  append rtnval " " $result
						 }
	       }
           }
      }
  }
return $rtnval
}


# Procedure: TP_VarListGet
proc TP_VarListGet { {varNamespace "::"} {expandArrays "1"}} {
# Retrieve a list of all variables created by the application.
global TPexclusions

set rtnval {}
if {$varNamespace == {::}} {
   set namestart 2
   set exclVars {}
   set plist $TPexclusions(globalvar)
   lappend plist TP*
   foreach vname $plist {
	     eval "lappend exclVars [info vars ::$vname]"
           }
   set pattern ::*
  } {
      set pattern ${varNamespace}::*
      set namestart [string length $varNamespace]
      incr namestart 2
    }

foreach varname [info vars $pattern] {
	set reason 0
	set vname [string range $varname $namestart end]

	if {$varNamespace == {::}} {
	    # Skip variables on the exclusion list
	    if {[lsearch $exclVars $varname] > -1} { set reason 1 }
	   }

	if {$reason == 0} {
	    if {$expandArrays && [array exists $varname]} {
	        foreach idx [array names $varname] {
		     lappend rtnval "${vname}\($idx\)"
		   }
	      } { lappend rtnval $vname }
	   }
        }
return [lsort -dictionary $rtnval]
}


# Procedure: TP_WatchList
proc TP_WatchList { action varname} {
# Add a parameter to the alphabetically sorted parameter watch list.
global TPwatchList

if {[string index $varname 0] == {:}} {
    set vname $varname
  } { set vname ::$varname }
switch $action {
           add             {
		if {[info exists $vname]} {
		    # The variable exists.
		    if {![array exists $vname]} {
		       # Only add the item if is not an array name.
		       if {[lsearch $TPwatchList $vname] == -1} {
		           # The parameter is not yet on the list. Add it.
		           set TPwatchList [lsort -dictionary [concat $TPwatchList $vname]]
		          }
		      }
		  }
		set rtnval $TPwatchList
	              }
          clear            {
		set TPwatchList {}
		set rtnval $TPwatchList
	              }
          delete          {
		set pos [lsearch $TPwatchList $vname]
		if {$pos != -1} {
		    set TPwatchList [lreplace $TPwatchList  $pos $pos]
		  }
		set rtnval $TPwatchList
	              }
          position       {
		set rtnval [lsearch $TPwatchList $vname]
	             }
          get	             {	set rtnval $TPwatchList }
          default        {	set rtnval {} }
        }

return $rtnval
}


# Procedure: TP_WatchListFill
proc TP_WatchListFill { wname} {
# Fill the specified text widget with the parameter watches
global TPwatchList

if {[winfo exists $wname]} {
    if {[TP_ClassGet $wname] == {Text}} {
        # Remove any existing watch items.
        foreach widget [$wname window names] {
	      if {[TP_ClassGet $widget] == {Frame}} { TP_WindowDestroy $widget }
	   }
        $wname delete 1.0 end

        # Find maximum length of the parameter names.
        set maxlen 9
        foreach varname $TPwatchList {
	      set slen [string length $varname]
	      if {$slen > $maxlen} { set maxlen $slen }
	   }

        # Insert the parameter watches.
        set ctr 0
        foreach varname $TPwatchList {
	     incr ctr
	     set frname $wname.frame$ctr
	     frame $frname -relief ridge -bg white -borderwidth 2
	     $wname window create end -window $frname
	     $wname insert end "\n"

	     set widget $frname.del
	     button $widget -image tpbomb -command "TP_WatchList delete $varname; TP_WatchListFill $wname"
	     pack $widget -side left -fill y

	     set widget $frname.varname
	     label $widget -font {Helvetica 10} -width $maxlen -text $varname -anchor w -relief flat -bg #eeeec8 -fg black
	     pack $widget -side left -fill y

	     set widget $frname.value
 	     label $widget -font {Helvetica 10} -textvariable $varname -anchor w -relief flat -bg white -fg black -justify left -width 50 -wraplength 10c
	     pack $widget -side left
	   }

        # Reset the column width to the size of the biggest parameter name.
        .tpwatchwin.frame1.label2 configure -width $maxlen
      }
  }
}


# Procedure: TP_WindowDestroy
proc TP_WindowDestroy { wname} {
# Destroy the specified window
set wclass [TP_ClassGet $wname]
catch "destroy $wname"
if {$wclass == {Toplevel}} {
    # Remove the procedures associated with the Toplevel window.
    catch {rename TPopenWindow$wname {}}
    catch {rename TPcloseWindow$wname {}}
    catch {rename TPstartupSrc$wname {}}
    catch {rename TPendSrc$wname {}}
   }
}


# Procedure: TP_WinfoChildren
proc TP_WinfoChildren { geomgr wname} {
# Return the children of wname that are managed by the geomgr geometry manager.

set rtnval {}
if {[winfo exists $wname]} {
    switch $geomgr {
        grid -
	pack -
	place	{
		  pack slaves $wname
		}
	}
  }
}


# Procedure: TP_cancel_bind
proc TP_cancel_bind { cname} {
# Re-initialize the DrawTools binding for the specified canvas.
global TPB1_press_list
global TPB1_motion_list
global TPB1_release_list

if {[winfo exists $cname]} {
     if {[TP_ClassGet $cname] == {Canvas}} {
#LISSI
          $cname delete graybox
	  $cname delete reshapeHandle
#LISSI 
	  global TPtoolpath
	  global TPcanvasTool
	  catch {bind $TPtoolpath <B1-ButtonRelease> ""}
	  catch {bind $TPtoolpath <Button-1> ""}
	  catch {bind $TPtoolpath <B1-Motion> ""}
#	set TPcanvasTool "None"

         # Remove the grouping box, if present.
          $cname delete groupbox
          # Re-initialize the DrawTools variables
          set TPB1_press_list {}
          set TPB1_motion_list {}
          set TPB1_release_list {}
          bind DrawTools <ButtonPress-1> {TP_B1_press %W [%W canvasx %x] [%W canvasy %y]}
          bind DrawTools <B1-Motion> {TP_B1_motion %W [%W canvasx %x] [%W canvasy %y]}
          bind DrawTools <ButtonRelease-1> {TP_B1_release %W [%W canvasx %x] [%W canvasy %y]}

          # Ensure the DrawTools tag is bound to the specified canvas
          set blist [bindtags $cname]
          set pos [lsearch $blist DrawTools]
          if {$pos == -1} {
               lappend blist DrawTools
               bindtags $cname $blist
            }
         }
   }
}


proc TP_checkybd {} {
global TPkeytime
global TPtoolpath
global TPTPcurCanvasorg

set curtime [clock clicks]
set timeout [expr $TPkeytime + 1000]
if {$curtime > $timeout} {
    if {[winfo exists $TPtoolpath] && [TP_ClassGet $TPtoolpath] == "Canvas"} {
	TP_cancel_bind $TPTPcurCanvasorg
	TP_ToolChoose cancel
	TP_DTcolor_stretch_set $TPtoolpath
       } { set TPtoolpath $TPTPcurCanvasorg }
    set TPkeytime ""
   } {
    after 500 TP_checkybd
   }
}

proc TP_chooseDirectory {args} {
	 global TPexclusions
	 
     # Replace tk_chooseDirectory with procedure that doesn't add images to the user application.
     set imgNames [image names]
     set rtnval [TP_RealChooseDir {*}$args]
     set imgNamesNew [image names]
     foreach img $imgNamesNew {
             if {$img ni $imgNames} { lappend TPexclusions(images) $img }
           }
     return $rtnval
   }

proc TP_getOpenFile {args} {
     # Replace tk_getOpenFile with procedure that doesn't add images to the user application.
	 global TPexclusions
	 
     set imgNames [image names]
     set rtnval [TP_RealOpenFile {*}$args]
     set imgNamesNew [image names]
     update
     foreach img $imgNamesNew {
             if {$img ni $imgNames} { lappend TPexclusions(images) $img }
           }
     return $rtnval
   }

proc TP_getSaveFile {args} {
     # Replace tk_getSaveFile with procedure that doesn't add images to the user application.
	 global TPexclusions
	 
     set imgNames [image names]
     set rtnval [TP_RealSaveFile {*}$args]
     set imgNamesNew [image names]
     foreach img $imgNamesNew {
             if {$img ni $imgNames} { lappend TPexclusions(images) $img }
           }
     return $rtnval
   }

# Procedure: TP_copy_bind
proc TP_copy_bind { cname} {
global TPB1_press_list
global TPB1_motion_list
global TPB1_release_list

if {[lsearch $TPB1_press_list group] == -1} {lappend TPB1_press_list group}
if {[lsearch $TPB1_motion_list group] == -1} {lappend TPB1_motion_list group}
if {[lsearch $TPB1_release_list copy] == -1} {lappend TPB1_release_list copy}
}


# Procedure: TP_copy_group
proc TP_copy_group { window xpos ypos} {
global TPgrouplist
global TPcurCanvas

if {$TPgrouplist == ""} {return}
set newtsgrouplist ""
foreach item $TPgrouplist {
	set optlist [$window itemconfigure $item]
	if {$optlist != ""} {
	    set cmd "$window create [$window type $item] [$window coords $item]"
	    foreach option $optlist {
		    lappend cmd [lindex $option 0]
		    lappend cmd [lindex $option 4]
		  }
	    set newtag [eval $cmd]
	    lappend newtsgrouplist $newtag
	   }
      }
set TPgrouplist $newtsgrouplist
TP_move_group $window $xpos $ypos
}


# Procedure: TP_delete_bind
proc TP_delete_bind { cname} {
global TPB1_press_list
global TPB1_motion_list
global TPB1_release_list

if {[lsearch $TPB1_press_list group] == -1} {lappend TPB1_press_list group}
if {[lsearch $TPB1_motion_list group] == -1} {lappend TPB1_motion_list group}
if {[lsearch $TPB1_release_list delete] == -1} {lappend TPB1_release_list delete}
}


# Procedure: TP_delete_group
proc TP_delete_group { window} {
global TPgrouplist
global TPundelcmd

$window delete groupbox
if {$TPgrouplist == "groupbox"} {
    set TPgrouplist ""
    return
   }
set TPundelcmd ""
foreach item $TPgrouplist {
	set optlist [$window itemconfigure $item]
	if {$optlist != ""} {
	    set cmd "TPcurCanvas create [$window type $item] [$window coords $item]"
	    foreach option $optlist {
		    lappend cmd [lindex $option 0]
		    lappend cmd [lindex $option 4]
		  }
	    lappend TPundelcmd \$$cmd
	   }
      }
eval "$window delete $TPgrouplist"
}

# Procedure: TP_move_bind
proc TP_move_bind { cname} {
global TPB1_press_list
global TPB1_motion_list
global TPB1_release_list

if {[lsearch $TPB1_press_list group] == -1} {lappend TPB1_press_list group}
if {[lsearch $TPB1_motion_list group] == -1} {lappend TPB1_motion_list group}
if {[lsearch $TPB1_release_list move] == -1} {lappend TPB1_release_list move}
#LISSI
    global TPtoolpath
    bind $cname <Button-3> {
	global TPtoolpath
	$TPtoolpath delete groupbox
	set TPB1_press_list [TP_DTldelete $TPB1_press_list move]
	set TPB1_motion_list [TP_DTldelete $TPB1_motion_list move]
	set TPB1_release_list [TP_DTldelete $TPB1_release_list endmove]
	set TPcanvasTool "None"
    }

}


# Procedure: TP_move_group
proc TP_move_group { window xpos ypos} {
global TPgroupulx
global TPgroupuly
global TPgrouplrx
global TPgrouplry
global TPgrouplist
#LISSI
global TPMove

if {$TPgrouplist == ""} {return}
if {0} {
set xcenter [expr ($TPgroupulx + $TPgrouplrx) / 2]
set xmove [expr $xpos - $xcenter]
set ycenter [expr ($TPgroupuly + $TPgrouplry) / 2]
set ymove [expr $ypos - $ycenter]
}
#LISSI
set xmove [expr $xpos - $TPMove(lastX)]
set ymove [expr $ypos - $TPMove(lastY)]
    set TPMove(lastX) $xpos
    set TPMove(lastY) $ypos

foreach item $TPgrouplist {
	$window move $item $xmove $ymove
      }
set cmd "$window bbox $TPgrouplist"
set newbox [eval $cmd]
set TPgroupulx [lindex $newbox 0]
set TPgroupuly [lindex $newbox 1]
set TPgrouplrx [lindex $newbox 2]
set TPgrouplry [lindex $newbox 3]
}


# Procedure: TP_stretch_bind
proc TP_stretch_bind { cname} {
global TPB1_press_list
global TPB1_motion_list
global TPB1_release_list

if {[lsearch $TPB1_press_list stretch] == -1} {lappend TPB1_press_list stretch}
if {[lsearch $TPB1_motion_list stretch] == -1} {lappend TPB1_motion_list stretch}
if {[lsearch $TPB1_release_list stretch] == -1} {lappend TPB1_release_list stretch}
}


# Procedure: TP_stretch_move
proc TP_stretch_move { cname xpos ypos} {
# This procedure modifies the closest vertice to the mouse
#
global TPstretchhalo
global TPstretchobj

set object $TPstretchobj
if {$object != ""} {
    set coords [$cname coords $object]
    set totlen [llength $coords]
    set smallest $TPstretchhalo
    set closest -1
    set curidx 0
    for {set ctr 0} {$ctr < $totlen} {incr ctr 2} {
	 set curx [lindex $coords $ctr]
	 set cury [lindex $coords [expr $ctr + 1] ]
	 set xsquare  [expr ($curx - $xpos) * ($curx - $xpos)]
	 set ysquare  [expr ($cury - $ypos) * ($cury - $ypos)]
	 set sumsquare [expr $xsquare + $ysquare]
	 set distance [expr sqrt($sumsquare)]
	 if {$distance < $smallest} {
		set smallest $distance
		set closest  $ctr
	    }
	 incr curidx
	}
    if {$closest != -1} {
	set coords [lreplace $coords $closest [expr $closest + 1] $xpos $ypos]
	set cmd "$cname coords $object $coords"
	eval $cmd
       }
}
}


# Procedure: TP_stretch_start
proc TP_stretch_start { cname xpos ypos} {
# This procedure modifies the closest vertice to the mouse
#
global TPstretchhalo
global TPstretchobj

set TPstretchhalo 5.0
set object [lindex [$cname find closest $xpos $ypos] 0]
if {$object != ""} {
    set TPstretchobj $object
    set coords [$cname coords $object]
    set totlen [llength $coords]
    set smallest $TPstretchhalo
    set closest -1
    set curidx 0
    for {set ctr 0} {$ctr < $totlen} {incr ctr 2} {
	 set curx [lindex $coords $ctr]
	 set cury [lindex $coords [expr $ctr + 1] ]
	 set xsquare  [expr ($curx - $xpos) * ($curx - $xpos)]
	 set ysquare  [expr ($cury - $ypos) * ($cury - $ypos)]
	 set sumsquare [expr $xsquare + $ysquare]
	 set distance [expr sqrt($sumsquare)]
	 if {$distance < $smallest} {
		set smallest $distance
		set closest  $ctr
	    }
	 incr curidx
	}
    if {$closest != -1} {
	set coords [lreplace $coords $closest [expr $closest + 1] $xpos $ypos]
	set cmd "$cname coords $object $coords"
	eval $cmd
	set TPstretchhalo 1000000.0
       } else { set TPstretchhalo -1.0 }
}
}


# Procedure: TP_stretch_stop
proc TP_stretch_stop {} {
# This procedure terminates stretching
#
global TPstretchhalo

set TPstretchhalo -1.0
}


# Procedure: TPcloseWindow.
proc TPcloseWindow. {} {
wm state . withdrawn
}

image create photo tplogo16 -data {
iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAAACXBIWXMAAAsT
AAALEwEAmpwYAAAC40lEQVQokQXB228UVRwA4PM7vzMz3Z3dzpZuN9u6LrAU
aGptbaHQEPVNiUmVhKsSL6C8+Df4F5j45Asx6YOXmOgDIaIv1QdJwUTF8tKK
oW1ol+5OC9vubWZn5syci98Hy3fvhL0AEcIg1FpZpoGIAFTJpLN4N9yu9185
Z2dtzmMEkFoxd+mv0s2F54xVai7T+t+jlb0L8+W5WbdeK379o5MktakJOXbk
6Rc322dOVqZewo8++XAXSPPSOXL/T0zE8pnZEc6TzIHc8NDO5mbDMHB6orjw
/eDWtrW+2Z55meXLpfR7F4YPja53o/Xffj1+9TyiUShVso7zhKpqq/PGlwvV
q+eduRN9Wud5RCli4HVVHIa1mvBDO3dAE20yygzz2OSpk4l4MH48NzdDtLJM
kwClWsokCvef7Xgrq1HdLRwcNe1+wSOlFDNMzvDg6n+dZ3uIqKRQUlACQCk2
3JrNOQMwTOvoK6dTxUocy+aOW8ra3o13ja++abZaQiSEECqllFIQQnaVTBMN
REmZWKl0/UmtvHQv50dhux0cKrHPPm/9cIdozbRSAACEqtLwo443TYgSMSDY
xeKjD66Lhpsbq8Sm5SYy/9ppFnP4+/dfnterSikAIAQGR8rDlVEApllGEVRB
d3XpJyVCZIZppYKez5KEB4Ev4oQxBKBP11a9bnN08hTSEGjGyAwUPW0+WI4H
coFBdouDrNtuep5H9hpCCG31MSDNjbXm2lphYvLFbAEPjw/lR8KNrY2zrxsr
K900w09vXJNx/Op3t1N2/8zikjOQH7v/j9PuFn5e7MUBvX3L2N7qtfaynh9d
vqgEp4wxgxm434onxnqOk6u71fk39995S3PO69v1oJN5+LBx6e1sJjMUinQm
hx+/f4U+fmxWayLn7M6fDfusZHoy9UK5ISJhp+XsTBMUcs6J9sePBYEPi7e+
1ff+EBHvnZhSUiitkBmEkNjvAiIi04QA0YjIQ19o+B86NYI60KQPegAAAABJ
RU5ErkJggg==
} -gamma 1.0 -height 0 -width 0
image create photo tplogo128 -data {
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
bmfFspOoTUNRVm1NQJC5lLIFqry1TB46RJZlmKZi0IT0sMgL1qzdSDdLec4Rxt+6
eCGPs46NO/ewYtlJvOJ5z+SsM1ZRFyXeWoqqQkhJ0ukhpWAwOUknS7HWIZVCSIlQ
Ep1lKaYo8C0EKTlcYPl/ccx6cB0vB16+Zy83XHgO39h3kG/s2M07P/DXnHTiAl74
nKdx2QVnI5WiaQzWWGrR0BubyQnzT+DgI3vYsO5+xkZ6RHEnnBIVYFnbfod3HoNj
5owx7h7pct0R3z9v3SZed8FjeP8d97JECJIspbhrNaeuWMYbJgfHzPfD1z6Wv//x
z/jI838XKSRJm6qpNqcXUqAjTWNq0k5neGq1UmitEUJw291r+O3REWjdPMDbjWHj
zj08+2lP4OUveHaAlU3D6OgozhoSwFhD3H7f7NmzQvGtrjGmIdIB0dUAUkkiHWG1
oYnjAEq0QND/y+Pxv7ibxwMfWryQ78wc50Npyns+8nec95jTeO1LnscJ8+ailaY0
hhOXrUDrlPGZ8zg0sY+pA3vJi1DY6Yz0UEIOq5FN0xBlCY+77CJefMfd3DBnFqfu
PRwM/sUd93Lp2Wew+oGHwTmWrVx2DBAE8NZzz+TDN9zMG//opZx91plY05BIGdJX
JbHeo0TWGjzUHaqqIpKOuglIaGMtN916J59bOG/4e3cvX8rXNm8lTROe94ynIBHD
dLwoCpxz3HrXfdx13wNcetF5XHL+Y9i/fz9JElLoqq6pmoa6rtDGOuqyxljLoOiT
lyXdbsaOWQvh4Q3/f9vw/8oY37qD5wPPB35y6QW8wzpe/db38vqXPY/HP/YyTjpx
UYimnacxlose91REnDC5Zyf/+dXPYJuZJGkIzOIkI44jlJD8wTOfyuoHH+bKiUl+
PHMGZxw4OPzOp9yzhqdM/+VRxl83fy7PmTOL1fc+wBtf/Ydcd+UlbUWvwTQNkY5p
ihrnw2tagNARUklMXVPZUJc4eGiSj3zuK3jgkupw1vHQnJmY9ZsYHx0hTiKqqkK0
JeeDE5N8+NP/yF2rH2Sk2+FHt9zBtz73USIdUQymkErTWENTN4BAJkkS6v1CEMUx
aZoye9ZMVs8Y/40Lv33pYj4zfw7XPe4KTl6yiFnjY8yeMc7JJ53IdY+7nG+fddr/
1LbDsXv5Ul60+EQWzp/LnJkzeOmSRfz08ouOed9VP7+Dm2+/ky8vW8xXvvVdPvPl
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
XgAAAABJRU5ErkJggg==} -gamma 1.0 -height 0 -width 0
#LISSI
image create photo tpfileopen16 -data R0lGODlhEAAQAIUAAPwCBAQCBOSmZPzSnPzChPzGhPyuZEwyHExOTFROTFxaVFRSTMSGTPT29Ozu7Nze3NTS1MzKzMTGxLy6vLS2tLSytDQyNOTm5OTi5Ly+vKyqrKSmpIyOjLR+RNTW1MzOzJyenGxqZBweHKSinJSWlExKTMTCxKyurGxubBQSFAwKDJyanERCRERGRAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAAAALAAAAAAQABAAAAaRQIBwGCgGhkhkEWA8HpNPojFJFU6ryitTiw0IBgRBkxsYFAiGtDodDZwPCERCEV8sEk0CI9FoOB4BEBESExQVFgEEBw8PFxcYEBIZGhscCEwdCxAPGA8eHxkUGyAhIkwHEREQqxEZExUjJCVWCBAZJhEmGRUnoygpQioZGxsnxsQrHByzQiJxz3EsLSwWpkJ+QQAh/mhDcmVhdGVkIGJ5IEJNUFRvR0lGIFBybyB2ZXJzaW9uIDIuNQ0KqSBEZXZlbENvciAxOTk3LDE5OTguIEFsbCByaWdodHMgcmVzZXJ2ZWQuDQpodHRwOi8vd3d3LmRldmVsY29yLmNvbQA7 -gamma 1.0 -height 0 -width 0
image create photo tpfileopen22 -data R0lGODlhFgAWAIYAAPwCBAQCBCQWDCwaDDwmFPSubPzGhPzCfPy2dOSmZPzKlPzSnPzOlPzKjBQODPzChPzWnPy2bPSmXPyuZOyeXIRSLEQuFEwyHEQqFDQiFCweDKRuPFRSTPT29PTy9Ozq7OTi3Nze3NTW1MzOzMTGxMTCxLy6tLSytKyurDQyNMzKxOTm5OTi5Nza1NTS1MTCvLS2tLSyrKSmpJyenJSWlIyKjHx+fFxeXBwaHKxuPMzKzLy6vIyOjHx6fDw6NPy6dGxubLy+vISChCQmJNza3KyqrBQSFLR2RKSinJyanGxqZAwGBJSSlCwqLAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAAAALAAAAAAWABYAAAf/gACCg4SFhoeDAYqKiIeLj4wBjQCMhY+NkoiLk5qbhQIDoJyGBAUGBwgEo4MECQoLDA2pDrS1tKQPEAwHERITE77AvxKqhAQNDA8UFRYXFs8YBAQZGqGPxw0RGxwdHR4eHyAhIiMkJSYnKCgpBAYPEhcqHyssLS4kLzAxMjM0NTY3cBA4UCAHBw8gVnhgEcKFjhc7UPDj0cMHAAI/KFgY4YLFio/jRpTYsW8GDyCSCEQw2DChOHIqgsCQSEPIEEEEJFhAoUNECCJEyOk4d6KIyRtGcB7hIJKjixEjHu4oimSGEIs4d8IIUoKECnNB0ElMwkNJJgBLlJBAcQKGiR07KGAURVGViY0mhIwwSTKjr99+THjUoIg0r48hTRIrRtxkiOMhDgrZCQQAIf5oQ3JlYXRlZCBieSBCTVBUb0dJRiBQcm8gdmVyc2lvbiAyLjUNCqkgRGV2ZWxDb3IgMTk5NywxOTk4LiBBbGwgcmlnaHRzIHJlc2VydmVkLg0KaHR0cDovL3d3dy5kZXZlbGNvci5jb20AOw== -gamma 1.0 -height 0 -width 0

image create photo tpfilesave -data R0lGODlhFgAWAIUAAPwCBBweHERCRISChPz+/Pz69Pz27Pzy7PTu5Pzu5PTq3HR2dIyKjKy6tGympPTq5GxqbISGhPz6/PTm3GxubPTi1Hx+fOTi5FxeXGRmZHRydGRiZNze3NTW1MzKzMTGxIyOjFxaXMTCxLy6vFRSVLS2tFRWVLy+vKyurKyqrAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAAAALAAAAAAWABYAAAbkQIBwSCwaj8ikMMAUOJ9QZqAYGAwEhELBYDgcEAmFYLGYDqsMQaHhaLsbDwGkTAxErpKC14tAPCZjEGZLVgIHbG5tDYAUgnUDC2p7DwqUExVyjmcLFoaIiQ2YEJpLFpFfD5QKExcVohiDAAFkkVC2GBkZsbMaZBSNGRC5wxuwdRAaowujo7nFxcZnvcu2UBjXu8wCFxwdHh8NAiBpISHZFBkCHE4eIiMCdwIYJNm5Ah0CGSINJQIDnSRM7NKVDl+GEyNQjIlEgl6dDcUEfNuHIsUYDQIaxpIlpZoUKUpCihwJQEYQACH+aENyZWF0ZWQgYnkgQk1QVG9HSUYgUHJvIHZlcnNpb24gMi41DQqpIERldmVsQ29yIDE5OTcsMTk5OC4gQWxsIHJpZ2h0cyByZXNlcnZlZC4NCmh0dHA6Ly93d3cuZGV2ZWxjb3IuY29tADs= -gamma 1.0 -height 0 -width 0

image create photo tpscale_h \
  -data {R0lGODdhFAAUAPcAAICAgNjY2Pj8+L8AZW/IL7WgcwEUdEAIZcjMd6DyYRT/
cgi/dBA1L6+ycBQBcghAb8RgaqepZRQUYwgIdMhMLzLydgj/dEC/Lw4EdsAA
dAEALUAAMVDILgEyMAAIOABALzjIBKigABQUAAgIABDIyK+goBQUFAgICHgk
BPOvAP8UAL8IADEbyP22oAIAFEAACDYE9KgA8RQA/wgAv2jINbSgsgwUAQgI
QMH8/IryqA3/FEC/CIwEdFoA8UAAvwDIBACgAAAUAAQIADAIyNbzMhD/CAy/
QDA1yNayoBABFAhACOgEyMkAoBEAFFDIJKigrzgEG6gAthQAAAgAAMjIBDKg
AAgUAEAIAJQgyPPzoP//FL+/CJQ1JLWy8gQB/0BAvwTQBACnAAAIAAigyKfy
oBT/FAi/CEwEMAIA8gAA/wAAv8jINTIysggIAUBAQLDIKPOgqf8UFL8ICMTI
sL+g8QQU/0AIv4AkBKavAAgbyKe2MhQACAgAQEwEyAIAoAAAFAAACMjIyDKg
oAgUFEAICPxQJPPzr701AHmyAAgBAAhAAGwEAMKoAAwUAADQAADyAAD/AAC/
AHAE9PQA8v8A/78AvyDI/Cky2hcIEMjI+DKg8ggU/2zI/PSg2v8UEHAkAPSv
ACAAyCkAMhcACCzI7PSg8f8U/78Iv6AQlKyvtQcUBABUBACpAAHICAAypwAI
FABACBQOAADACAABAABAABRSyAABMgAAQADYDACp8gAU/wAIvwAQbwGvtQAU
AQAIQHQkFPTz8v///7+/v3Axb/T9tf8CAb9AQCzOyPSpoNyUEKzzrwf/FCAK
8CkAqBcAFAgACBTsyAAAMhRuDgAAwADAAQADQACfUgDzARwKdPcAqf8AFL8A
CAA4BADzAABvyAC1oAABFAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAACwAAAAAFAAUAAAIYgADCBxIsKDBgwgTKlzIcCCA
hxAjSoQocKLFiAIqAhDAUcDGjgAIctSYsWLJACEHjkS50eHJlAJXPnz5UmTJ
mS4d2iSZs+JOljR1qrx5keJQkx2TKk0ac6lTpg2jSp1KtWBAADs=} \
  -gamma {1.0} \
  -height {0} \
  -width {0}

image create photo tplabel \
  -data {R0lGODdhFAAUAPAAAAAAANjY2CwAAAAAFAAUAAACL4yPqcsKD6MEiLaK77GG
aw824SZmXUmmy3gybOAl72zCUh2jrQbXFzgJPnjE4qEAADs=} \
  -gamma {1.0} \
  -height {0} \
  -width {0}

image create bitmap ::tk::dialog::q \
  -data {#define q_width 32
#define q_height 32
static unsigned char q_bits = {
   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xe0, 0x07, 0x00,
   0x00, 0x10, 0x0f, 0x00, 0x00, 0x18, 0x1e, 0x00, 0x00, 0x38, 0x1e, 0x00,
   0x00, 0x38, 0x1e, 0x00, 0x00, 0x10, 0x0f, 0x00, 0x00, 0x80, 0x07, 0x00,
   0x00, 0xc0, 0x01, 0x00, 0x00, 0xc0, 0x00, 0x00, 0x00, 0xc0, 0x00, 0x00,
   0x00, 0x00, 0x00, 0x00, 0x00, 0xc0, 0x00, 0x00, 0x00, 0xe0, 0x01, 0x00,
   0x00, 0xe0, 0x01, 0x00, 0x00, 0xc0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};} \
  -foreground {blue}

image create photo tpmenubutton \
  -data {R0lGODdhFAAUAPcAAAAAAICAgNjY2Pj8+G/IL7WgcwEUdEAIZcjMd6DyYRT/
cgi/dBA1L6+ycBQBcghAb8RgaqepZRQUYwgIdMhMLzLydgj/dEC/Lw4EdsAA
dAEALUAAMVDILgEyMAAIOABALzjIBKigABQUAAgIABDIyK+goBQUFAgICHgk
BPOvAP8UAL8IADEbyP22oAIAFEAACDYE9KgA8RQA/wgAv2jINbSgsgwUAQgI
QMH8/IryqA3/FEC/CIwEdFoA8UAAvwDIBACgAAAUAAQIADAIyNbzMhD/CAy/
QDA1yNayoBABFAhACOgEyMkAoBEAFFDIJKigrzgEG6gAthQAAAgAAMjIBDKg
AAgUAEAIAJQgyPPzoP//FL+/CJQ1JLWy8gQB/0BAvwTQBACnAAAIAAigyKfy
oBT/FAi/CEwEMAIA8gAA/wAAv8jINTIysggIAUBAQLDIKPOgqf8UFL8ICMTI
sL+g8QQU/0AIv4AkBKavAAgbyKe2MhQACAgAQEwEyAIAoAAAFAAACMjIyDKg
oAgUFEAICPxQJPPzr701AHmyAAgBAAhAAGwEAMKoAAwUAADQAADyAAD/AAC/
AHAE9PQAtf8ABL8AQAjIBCEyABcIAMjILDKg8ggU/2zIAvSgAHAkyPSvMv8U
CL8IQAgAyCEAMhcACCzI7PSg8f8U/78Iv6AQlKyvtQcUBABUBACpAAHICAAy
pwAIFABACBQOAADACAABAABAABRSyAABMgAAQADYDACp8gAU/wAIvwAQbwGv
tQAUAQAIQHQkFPTz8v///7+/v3Axb/T9tf8CAb9AQCzOyPSpoNyUEKzzrwf/
FAgK8CEAqBcAFAgACBTsyAAAMhRuDgAAwADAAQADQACfUgDzARwKdPcAqf8A
FL8ACAA4BADzAABvyAC1oAABFAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAACwAAAAAFAAUAAAIYwAFCBxIsKDBgwgNDljIsKHD
AQQhJiQYIOJEihYvCqw4UKIAAAZBbsz4UaRAACY5CvQIUmTLgSoFsDzpEiZJ
kwNT3gxps2NOniN9ngQqIKbHi0Y1Bl2ptGjEAFCjSp3atKrSgAA7} \
  -gamma {1.0} \
  -height {0} \
  -width {0}

image create photo tparrowcombo \
  -data {R0lGODlhDAAMAIAAAAAAAP///yH5BAEAAAEALAAAAAAMAAwAAAIOjI+py+0M
YoSzgYezRgUAOw==} \
  -gamma {1.0} \
  -height {0} \
  -width {0}

image create photo tppack \
  -data {R0lGODlhFAAUAPcAAAAAAAD8+NjY2Pj8APj8+LWgcAEUckAIb8i4aqDyZRT/
Ywi/dBA1L6+ydhQBdAhAL8RcdqepdBQULQgIMcg4LjLyMAj/OEC/Lw4EacAA
bQEAYUAAZ1DIZQEycwAILwBAbzjIBKigABQUAAgIABDIyK+goBQUFAgICGQk
BPOvAP8UAL8IADEbyP22oAIAFEAACDYE4KgA8RQA/wgAv2jINbSgsgwUAQgI
QMHo7Irypw3/FEC/CIwEYFoA8UAAvwDIBACgAAAUAAQIADD0yNbyMhD/CAy/
QDA1yNayoBABFAhACOgEyMkAoBEAFFDIJKigrzgEG6gAthQAAAgAAMjIBDKg
AAgUAEAIAIAMyPPzoP//FL+/CJQ1ELWy8gQB/0BAvwTQBACnAAAIAAiMyKfy
oBT/FAi/CEwEHAIA8gAA/wAAv8jINTIysggIAUBAQJzIGPOgqP8UFL8ICMTI
nL+g8QQU/0AIv4AkBKavAAgbyKe2MhQACAgAQEwEyAIAoAAAFAAACMjIyDKg
oAgUFEAICOg8JPPzr701AHmyAAgBAAhAAGwEuMKo8QwU/wgIvwC8lADytQD/
BAC/QFwEBPQAAP8AAL8AAEjICCMypxUIFMjI9DKgB1jIyPSgMv8UCL8IQFwk
1PSv8f8U/78Iv0gABCMAABUAABjIyPSgoKAQBKyvAAcUAABQyACpoAAUFAAI
CAHIcAAy8gAI/wBAvxQONQDAsgABAQBAQBRSRAABqQDU8ACp8QAU/wAIvwAQ
BAGvAGAQyPTzMv//CL+/QFwxyPT9oP8CFL9ACBjKyPSpoNyAJKzzrwf/FEgK
GyMAthTsBBRuyAAAoADAFAADCACLoADz8gD//wC/vwgKBPcAAAAkBADzAAD/
AAC/AABvyAC1oAABFABACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAACH5BAEAAAIALAAAAAAUABQAAAh0AAUIHEiwoEEA
CBMqXJhQIIABECNKnDgAgEOKGCNaFPAwI8aNHT1OBCmSIkiGKBU6DMCSJQAC
MAkAaOlyJc2XMWfetNkSJ0ydPXm6jCmTZgCQRn0W3ckxKVGUQo8+HRlVaUiI
SG9OlZi151aNDlOKNUi2bEAAOw==} \
  -gamma {1.0} \
  -height {0} \
  -width {0}

image create bitmap ::tk::dialog::w1 \
  -data {#define w1_width 32
#define w1_height 32
static unsigned char w1_bits = {
   0x00, 0x80, 0x01, 0x00, 0x00, 0x40, 0x02, 0x00, 0x00, 0x20, 0x04, 0x00,
   0x00, 0x10, 0x04, 0x00, 0x00, 0x10, 0x08, 0x00, 0x00, 0x08, 0x08, 0x00,
   0x00, 0x08, 0x10, 0x00, 0x00, 0x04, 0x10, 0x00, 0x00, 0x04, 0x20, 0x00,
   0x00, 0x02, 0x20, 0x00, 0x00, 0x02, 0x40, 0x00, 0x00, 0x01, 0x40, 0x00,
   0x00, 0x01, 0x80, 0x00, 0x80, 0x00, 0x80, 0x00, 0x80, 0x00, 0x00, 0x01,
   0x40, 0x00, 0x00, 0x01, 0x40, 0x00, 0x00, 0x02, 0x20, 0x00, 0x00, 0x02,
   0x20, 0x00, 0x00, 0x04, 0x10, 0x00, 0x00, 0x04, 0x10, 0x00, 0x00, 0x08,
   0x08, 0x00, 0x00, 0x08, 0x08, 0x00, 0x00, 0x10, 0x04, 0x00, 0x00, 0x10,
   0x04, 0x00, 0x00, 0x20, 0x02, 0x00, 0x00, 0x20, 0x01, 0x00, 0x00, 0x40,
   0x01, 0x00, 0x00, 0x40, 0x01, 0x00, 0x00, 0x40, 0x02, 0x00, 0x00, 0x20,
   0xfc, 0xff, 0xff, 0x1f, 0x00, 0x00, 0x00, 0x00};} \
  -foreground {black}

image create photo tpblank \
  -data {R0lGODlhFAAUAIAAAAAAAP///yH5BAkAAAAALAAAAAAUABQAAAIRhI+py+0P
o5y02ouz3rz7rxUAOw==} \
  -gamma {1.0} \
  -height {0} \
  -width {0}

image create bitmap ::tk::dialog::w2 \
  -data {#define w2_width 32
#define w2_height 32
static unsigned char w2_bits = {
   0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x01, 0x00, 0x00, 0xc0, 0x03, 0x00,
   0x00, 0xe0, 0x03, 0x00, 0x00, 0xe0, 0x07, 0x00, 0x00, 0xf0, 0x07, 0x00,
   0x00, 0xf0, 0x0f, 0x00, 0x00, 0xf8, 0x0f, 0x00, 0x00, 0xf8, 0x1f, 0x00,
   0x00, 0xfc, 0x1f, 0x00, 0x00, 0xfc, 0x3f, 0x00, 0x00, 0xfe, 0x3f, 0x00,
   0x00, 0xfe, 0x7f, 0x00, 0x00, 0xff, 0x7f, 0x00, 0x00, 0xff, 0xff, 0x00,
   0x80, 0xff, 0xff, 0x00, 0x80, 0xff, 0xff, 0x01, 0xc0, 0xff, 0xff, 0x01,
   0xc0, 0xff, 0xff, 0x03, 0xe0, 0xff, 0xff, 0x03, 0xe0, 0xff, 0xff, 0x07,
   0xf0, 0xff, 0xff, 0x07, 0xf0, 0xff, 0xff, 0x0f, 0xf8, 0xff, 0xff, 0x0f,
   0xf8, 0xff, 0xff, 0x1f, 0xfc, 0xff, 0xff, 0x1f, 0xfe, 0xff, 0xff, 0x3f,
   0xfe, 0xff, 0xff, 0x3f, 0xfe, 0xff, 0xff, 0x3f, 0xfc, 0xff, 0xff, 0x1f,
   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};} \
  -foreground {yellow}

image create bitmap ::tk::dialog::w3 \
  -data {#define w3_width 32
#define w3_height 32
static unsigned char w3_bits = {
   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   0x00, 0xc0, 0x03, 0x00, 0x00, 0xe0, 0x07, 0x00, 0x00, 0xe0, 0x07, 0x00,
   0x00, 0xe0, 0x07, 0x00, 0x00, 0xe0, 0x07, 0x00, 0x00, 0xe0, 0x07, 0x00,
   0x00, 0xc0, 0x03, 0x00, 0x00, 0xc0, 0x03, 0x00, 0x00, 0xc0, 0x03, 0x00,
   0x00, 0x80, 0x01, 0x00, 0x00, 0x80, 0x01, 0x00, 0x00, 0x80, 0x01, 0x00,
   0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x01, 0x00, 0x00, 0xc0, 0x03, 0x00,
   0x00, 0xc0, 0x03, 0x00, 0x00, 0x80, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00,
   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};} \
  -foreground {black}

image create bitmap ::tk::dialog::b1 \
  -data {#define b1_width 32
#define b1_height 32
static unsigned char q1_bits = {
   0x00, 0xf8, 0x1f, 0x00, 0x00, 0x07, 0xe0, 0x00, 0xc0, 0x00, 0x00, 0x03,
   0x20, 0x00, 0x00, 0x04, 0x10, 0x00, 0x00, 0x08, 0x08, 0x00, 0x00, 0x10,
   0x04, 0x00, 0x00, 0x20, 0x02, 0x00, 0x00, 0x40, 0x02, 0x00, 0x00, 0x40,
   0x01, 0x00, 0x00, 0x80, 0x01, 0x00, 0x00, 0x80, 0x01, 0x00, 0x00, 0x80,
   0x01, 0x00, 0x00, 0x80, 0x01, 0x00, 0x00, 0x80, 0x01, 0x00, 0x00, 0x80,
   0x01, 0x00, 0x00, 0x80, 0x02, 0x00, 0x00, 0x40, 0x02, 0x00, 0x00, 0x40,
   0x04, 0x00, 0x00, 0x20, 0x08, 0x00, 0x00, 0x10, 0x10, 0x00, 0x00, 0x08,
   0x60, 0x00, 0x00, 0x04, 0x80, 0x03, 0x80, 0x03, 0x00, 0x0c, 0x78, 0x00,
   0x00, 0x30, 0x04, 0x00, 0x00, 0x40, 0x04, 0x00, 0x00, 0x40, 0x04, 0x00,
   0x00, 0x80, 0x04, 0x00, 0x00, 0x00, 0x05, 0x00, 0x00, 0x00, 0x06, 0x00,
   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};} \
  -foreground {black}

image create bitmap tparrow_down \
  -data {#define down_width 19
#define down_height 19
static unsigned char down_bits[] = {
   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x0f, 0x00,
   0x80, 0x0f, 0x00, 0x80, 0x0f, 0x00, 0x80, 0x0f, 0x00, 0x80, 0x0f, 0x00,
   0x80, 0x0f, 0x00, 0xfc, 0xff, 0x01, 0xf8, 0xff, 0x00, 0xf0, 0x7f, 0x00,
   0xe0, 0x3f, 0x00, 0xc0, 0x1f, 0x00, 0x80, 0x0f, 0x00, 0x00, 0x07, 0x00,
   0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
} \
  -foreground {#000000}

image create bitmap ::tk::dialog::b2 \
  -data {#define b2_width 32
#define b2_height 32
static unsigned char b2_bits = {
   0x00, 0x00, 0x00, 0x00, 0x00, 0xf8, 0x1f, 0x00, 0x00, 0xff, 0xff, 0x00,
   0xc0, 0xff, 0xff, 0x03, 0xe0, 0xff, 0xff, 0x07, 0xf0, 0xff, 0xff, 0x0f,
   0xf8, 0xff, 0xff, 0x1f, 0xfc, 0xff, 0xff, 0x3f, 0xfc, 0xff, 0xff, 0x3f,
   0xfe, 0xff, 0xff, 0x7f, 0xfe, 0xff, 0xff, 0x7f, 0xfe, 0xff, 0xff, 0x7f,
   0xfe, 0xff, 0xff, 0x7f, 0xfe, 0xff, 0xff, 0x7f, 0xfe, 0xff, 0xff, 0x7f,
   0xfe, 0xff, 0xff, 0x7f, 0xfc, 0xff, 0xff, 0x3f, 0xfc, 0xff, 0xff, 0x3f,
   0xf8, 0xff, 0xff, 0x1f, 0xf0, 0xff, 0xff, 0x0f, 0xe0, 0xff, 0xff, 0x07,
   0x80, 0xff, 0xff, 0x03, 0x00, 0xfc, 0x7f, 0x00, 0x00, 0xf0, 0x07, 0x00,
   0x00, 0xc0, 0x03, 0x00, 0x00, 0x80, 0x03, 0x00, 0x00, 0x80, 0x03, 0x00,
   0x00, 0x00, 0x03, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00,
   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};} \
  -foreground {white}

image create photo tpscrollbar_h \
  -data {R0lGODdhFAAUAPcAAICAgNjY2Pj8+L8AZW/IL7WgcwEUdEAIZcjMd6DyYRT/
cgi/dBA1L6+ycBQBcghAb8RgaqepZRQUYwgIdMhMLzLydgj/dEC/Lw4EdsAA
dAEALUAAMVDILgEyMAAIOABALzjIBKigABQUAAgIABDIyK+goBQUFAgICHgk
BPOvAP8UAL8IADEbyP22oAIAFEAACDYE9KgA8RQA/wgAv2jINbSgsgwUAQgI
QMH8/IryqA3/FEC/CIwEdFoA8UAAvwDIBACgAAAUAAQIADAIyNbzMhD/CAy/
QDA1yNayoBABFAhACOgEyMkAoBEAFFDIJKigrzgEG6gAthQAAAgAAMjIBDKg
AAgUAEAIAJQgyPPzoP//FL+/CJQ1JLWy8gQB/0BAvwTQBACnAAAIAAigyKfy
oBT/FAi/CEwEMAIA8gAA/wAAv8jINTIysggIAUBAQLDIKPOgqf8UFL8ICMTI
sL+g8QQU/0AIv4AkBKavAAgbyKe2MhQACAgAQEwEyAIAoAAAFAAACMjIyDKg
oAgUFEAICPxQJPPzr701AHmyAAgBAAhAAGwEAMKoAAwUAADQAADyAAD/AAC/
AHAE9PQAtf8ABL8AQCDIBCkyABcIAMjILDKg8ggU/2zIAvSgAHAkyPSvMv8U
CL8IQCAAyCkAMhcACCzI7PSg8f8U/78Iv6AQlKyvtQcUBABUBACpAAHICAAy
pwAIFABACBQOAADACAABAABAABRSyAABMgAAQADYDACp8gAU/wAIvwAQbwGv
tQAUAQAIQHQkFPTz8v///7+/v3Axb/T9tf8CAb9AQCzOyPSpoNyUEKzzrwf/
FCAK8CkAqBcAFAgACBTsyAAAMhRuDgAAwADAAQADQACfUgDzARwKdPcAqf8A
FL8ACAA4BADzAABvyAC1oAABFAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAACwAAAAAFAAUAAAIbgADCBxIsKDBgwgTKlzIcCCA
hxAjSoQocKLFiAIqAhgoAICAjx4zCvyocWRHkSFFkgzwMABJjxUzklz5kCZK
lR9RUmR5UyPNjS1h8mS58adGoR5butTpMGnNjSZj5pxKdarJqlhzNtzKtatX
gwEBADs=} \
  -gamma {1.0} \
  -height {0} \
  -width {0}

image create photo tpcanvas \
  -data {R0lGODlhFAAUAMIAAAAAANjY2PgUQPj8APj8+P///////////yH5BAEKAAcA
LAAAAAAUABQAAANFeLrc/vCBSWt1gOjNNcBdSHxNFgqoB26oMLxqqaEvvJFM
Rg8ivug80WgljOUsyEkER/JJcr/IIUlZYqLPElYrnXa/4EcCADs=} \
  -gamma {1.0} \
  -height {0} \
  -width {0}

image create photo tpscale_v \
  -data {R0lGODdhFAAUAPcAAICAgNjY2Pj8+L8AZW/IL7WgcwEUdEAIZcjMd6DyYRT/
cgi/dBA1L6+ycBQBcghAb8RgaqepZRQUYwgIdMhMLzLydgj/dEC/Lw4EdsAA
dAEALUAAMVDILgEyMAAIOABALzjIBKigABQUAAgIABDIyK+goBQUFAgICHgk
BPOvAP8UAL8IADEbyP22oAIAFEAACDYE9KgA8RQA/wgAv2jINbSgsgwUAQgI
QMH8/IryqA3/FEC/CIwEdFoA8UAAvwDIBACgAAAUAAQIADAIyNbzMhD/CAy/
QDA1yNayoBABFAhACOgEyMkAoBEAFFDIJKigrzgEG6gAthQAAAgAAMjIBDKg
AAgUAEAIAJQgyPPzoP//FL+/CJQ1JLWy8gQB/0BAvwTQBACnAAAIAAigyKfy
oBT/FAi/CEwEMAIA8gAA/wAAv8jINTIysggIAUBAQLDIKPOgqf8UFL8ICMTI
sL+g8QQU/0AIv4AkBKavAAgbyKe2MhQACAgAQEwEyAIAoAAAFAAACMjIyDKg
oAgUFEAICPxQJPPzr701AHmyAAgBAAhAAGwEAMKoAAwUAADQAADyAAD/AAC/
AHAE9PQAtf8ABL8AQOjIBCAyABcIAMjILDKg8ggU/2zIAvSgAHAkyPSvMv8U
CL8IQOgAyCAAMhcACCzI7PSg8f8U/78Iv6AQlKyvtQcUBABUBACpAAHICAAy
pwAIFABACBQOAADACAABAABAABRSyAABMgAAQADYDACp8gAU/wAIvwAQbwGv
tQAUAQAIQHQkFPTz8v///7+/v3Axb/T9tf8CAb9AQCzOyPSpoNyUEKzzrwf/
FOgK8CAAqBcAFAgACBTsyAAAMhRuDgAAwADAAQADQACfUgDzARwKdPcAqf8A
FL8ACAA4BADzAABvyAC1oAABFAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAACwAAAAAFAAUAAAIYQADCBxIsKDBgQASKlyY8GAA
hhAFOEwooKJFAQAqTsxoMKPEgxQ7agTJsaDHjRgjfuzo8SLGkSxXIoRpsiTB
kyRlCsQZEyLPmg5p3gQQVCdCogeFHi2K0uXFiU5dOpx6MCAAOw==} \
  -gamma {1.0} \
  -height {0} \
  -width {0}

image create photo tppanedwin_h \
  -data {R0lGODlhFAAUAOcAAAAAAIAAAACAAICAAAAAgIAAgACAgMDAwMDcwKbK8AAA
AAAAKgAAVQAAfwAAqgAA1AAqAAAqKgAqVQAqfwAqqgAq1ABVAABVKgBVVQBV
fwBVqgBV1AB/AAB/KgB/VQB/fwB/qgB/1ACqAACqKgCqVQCqfwCqqgCq1ADU
AADUKgDUVQDUfwDUqgDU1CoAACoAKioAVSoAfyoAqioA1CoqACoqKioqVSoq
fyoqqioq1CpVACpVKipVVSpVfypVqipV1Cp/ACp/Kip/VSp/fyp/qip/1Cqq
ACqqKiqqVSqqfyqqqiqq1CrUACrUKirUVSrUfyrUqirU1FUAAFUAKlUAVVUA
f1UAqlUA1FUqAFUqKlUqVVUqf1UqqlUq1FVVAFVVKlVVVVVVf1VVqlVV1FV/
AFV/KlV/VVV/f1V/qlV/1FWqAFWqKlWqVVWqf1WqqlWq1FXUAFXUKlXUVVXU
f1XUqlXU1H8AAH8AKn8AVX8Af38Aqn8A1H8qAH8qKn8qVX8qf38qqn8q1H9V
AH9VKn9VVX9Vf39Vqn9V1H9/AH9/Kn9/VX9/f39/qn9/1H+qAH+qKn+qVX+q
f3+qqn+q1H/UAH/UKn/UVX/Uf3/Uqn/U1KoAAKoAKqoAVaoAf6oAqqoA1Koq
AKoqKqoqVaoqf6oqqqoq1KpVAKpVKqpVVapVf6pVqqpV1Kp/AKp/Kqp/Vap/
f6p/qqp/1KqqAKqqKqqqVaqqf6qqqqqq1KrUAKrUKqrUVarUf6rUqqrU1NQA
ANQAKtQAVdQAf9QAqtQA1NQqANQqKtQqVdQqf9QqqtQq1NRVANRVKtRVVdRV
f9RVqtRV1NR/ANR/KtR/VdR/f9R/qtR/1NSqANSqKtSqVdSqf9SqqtSq1NTU
ANTUKtTUVdTUf9TUqtTU1AAAAAwMDBkZGSYmJjMzMz8/P0xMTFlZWWZmZnJy
cn9/f4yMjJmZmaWlpbKysr+/v8zMzNjY2OXl5fLy8v/78KCgpICAgP8AAAD/
AP//AAAA//8A/wD//////yH5BAEAAP4ALAAAAAAUABQAAAhXAP0JHOgPgL9/
BBMqFGgQ4cKF/yJKdPhwIL6JESsSxIdvYEaNAjl6pKhRpMCPIDmqRFlSJUeS
IBuCVChzJsGaNhkezDkQZ06fNoHOFBpzJ8+CRnkSHRgQADs=} \
  -gamma {1.0} \
  -height {0} \
  -width {0}

image create photo tpentry \
  -data {R0lGODdhFAAUAPcAAAAAAICAgNjY2Pj8+G/IarWgZQEUY0AIdMi4L6DydhT/
dAi/LxA1dq+ydBQBLQhAMcSQLqepMBQUOAgIL8g4aTLybQj/YUC/Zw4EPMAA
FgEAEEAAQFDIjAEyWgAIFABAQDjIBKigABQUAAgIABDIyK+goBQUFAgICGQk
BPOvAP8UAL8IADEbyP22oAIAFEAACDYE4KgA8RQA/wgAv2jINbSgsgwUAQgI
QMHo1Irypw3/FEC/CIwEYFoA8UAAvwDIBACgAAAUAAQIADD0yNbyMhD/CAy/
QDA1yNayoBABFAhACOgEyMkAoBEAFFDIJKigrzgEG6gAthQAAAgAAMjIBDKg
AAgUAEAIAIAMyPPzoP//FL+/CJQ1ELWy8gQB/0BAvwTQBACnAAAIAAiMyKfy
oBT/FAi/CEwEHAIA8gAA/wAAv8jINTIysggIAUBAQJzIAPOgqP8UFL8ICMTI
nL+g8QQU/0AIv4AkBKavAAgbyKe2MhQACAgAQEwEyAIAoAAAFAAACMjIyDKg
oAgUFEAICOg8JPPzr701AHmyAAgBAAhAAGwEAMKoAAwUAAC8AADyAAD/AAC/
AFwEwPQA8v8A/78AvwDICAwyABUIAMjIjDKgWkAIQFjIwPSg8v8U/78Iv1wk
yPSvMv8UCL8IQAAA1AwA8RUA/xjIlPSgtf8UBKAQBKyvAAcUAACECACppwAU
FAAICAHI+AAyBwBAABQOyADAMgABCBRS8AAB8QAI+ACq8QAU/wAIvwAQbwGv
tQAUAQAIQGAQAPTz8v///7+/v1wxb/T9tf8CAb9AQBj+yPSpoNyAEKzzrwf/
FAAKyAwApxUAFAgACBTsyAAAMgAAQBRuDgAAwADAAQADQACLUgDzAQgKTPcA
qP8AFL8ACAAkBADzAABvyAC1oAABFABACAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAACwAAAAAFAAUAAAIcAAFCBxIsKDBAAgTKlyYUCDD
hwoHOAxgsKKAARIFILRoEONEjgIADPSokSJHkQJJbhwIoCXLkRlXhnw5M2VM
kzVrorx4k2VLlzlV4txJk+dHgTtR7hRK8GdRpidhHgVpcypVoRizat2qkqtX
rVRBBgQAOw==} \
  -gamma {1.0} \
  -height {0} \
  -width {0}

image create photo tptoolbar \
  -data {R0lGODlhFgAWAKEAAP///wAAAP///////yH5BAEAAAAALAAAAAAWABYAAAI5
hB2pq+cIQYjznYqpvazXnUnaJpbhZ3kdaY7oc46gurD2DeJko6d9/nPwghFi
kObxtZYvpiuFZBwKADs=} \
  -gamma {1.0} \
  -height {0} \
  -width {0}

image create photo tplabelframe \
  -data {R0lGODlhFAAUAOcAAAAAAIAAAACAAICAAAAAgIAAgACAgMDAwMDcwKbK8AAA
AAAAKgAAVQAAfwAAqgAA1AAqAAAqKgAqVQAqfwAqqgAq1ABVAABVKgBVVQBV
fwBVqgBV1AB/AAB/KgB/VQB/fwB/qgB/1ACqAACqKgCqVQCqfwCqqgCq1ADU
AADUKgDUVQDUfwDUqgDU1CoAACoAKioAVSoAfyoAqioA1CoqACoqKioqVSoq
fyoqqioq1CpVACpVKipVVSpVfypVqipV1Cp/ACp/Kip/VSp/fyp/qip/1Cqq
ACqqKiqqVSqqfyqqqiqq1CrUACrUKirUVSrUfyrUqirU1FUAAFUAKlUAVVUA
f1UAqlUA1FUqAFUqKlUqVVUqf1UqqlUq1FVVAFVVKlVVVVVVf1VVqlVV1FV/
AFV/KlV/VVV/f1V/qlV/1FWqAFWqKlWqVVWqf1WqqlWq1FXUAFXUKlXUVVXU
f1XUqlXU1H8AAH8AKn8AVX8Af38Aqn8A1H8qAH8qKn8qVX8qf38qqn8q1H9V
AH9VKn9VVX9Vf39Vqn9V1H9/AH9/Kn9/VX9/f39/qn9/1H+qAH+qKn+qVX+q
f3+qqn+q1H/UAH/UKn/UVX/Uf3/Uqn/U1KoAAKoAKqoAVaoAf6oAqqoA1Koq
AKoqKqoqVaoqf6oqqqoq1KpVAKpVKqpVVapVf6pVqqpV1Kp/AKp/Kqp/Vap/
f6p/qqp/1KqqAKqqKqqqVaqqf6qqqqqq1KrUAKrUKqrUVarUf6rUqqrU1NQA
ANQAKtQAVdQAf9QAqtQA1NQqANQqKtQqVdQqf9QqqtQq1NRVANRVKtRVVdRV
f9RVqtRV1NR/ANR/KtR/VdR/f9R/qtR/1NSqANSqKtSqVdSqf9SqqtSq1NTU
ANTUKtTUVdTUf9TUqtTU1AAAAAwMDBkZGSYmJjMzMz8/P0xMTFlZWWZmZnJy
cn9/f4yMjJmZmaWlpbKysr+/v8zMzNjY2OXl5fLy8v/78KCgpICAgP8AAAD/
AP//AAAA//8A/wD//////yH5BAEAAP4ALAAAAAAUABQAAAhcAP0JHEiwoMGD
CBMC8LewYUKGCxlKjAigYkWCAP5N3Piv47+MA0E+FCiSocaRJkOeHFmy5MOW
K1+udKlwZsyaKlGmJHkTIUydP1EGZTnTotGjFmN6XMp0qU6EAQEAOw==} \
  -gamma {1.0} \
  -height {0} \
  -width {0}

image create photo tpframe \
  -data {R0lGODlhFAAUAPcAAAAAAICAgNjY2Pj8+G/IL7WgcwEUdEAIZcjMd6DyYRT/
cgi/dBA1L6+ycBQBcghAb8RgaqepZRQUYwgIdMhMLzLydgj/dEC/Lw4EdsAA
dAEALUAAMVDILgEyMAAIOABALzjIBKigABQUAAgIABDIyK+goBQUFAgICHgk
BPOvAP8UAL8IADEbyP22oAIAFEAACDYE9KgA8RQA/wgAv2jINbSgsgwUAQgI
QMH8/IryqA3/FEC/CIwEdFoA8UAAvwDIBACgAAAUAAQIADAIyNbzMhD/CAy/
QDA1yNayoBABFAhACOgEyMkAoBEAFFDIJKigrzgEG6gAthQAAAgAAMjIBDKg
AAgUAEAIAJQgyPPzoP//FL+/CJQ1JLWy8gQB/0BAvwTQBACnAAAIAAigyKfy
oBT/FAi/CEwEMAIA8gAA/wAAv8jINTIysggIAUBAQLDIKPOgqf8UFL8ICMTI
sL+g8QQU/0AIv4AkBKavAAgbyKe2MhQACAgAQEwEyAIAoAAAFAAACMjIyDKg
oAgUFEAICPxQJPPzr701AHmyAAgBAAhAAGwEAMKoAAwUAADQAADyAAD/AAC/
AHAE5PQA2v8AEL8ACCjIARkyABcIAMjIAWzI6PSg2v8UEHAkpvSvFr8IQCgA
yBkAMhcACCzI7PSg8f8U/78Iv6AQlKyvtQcUBABUBACpAAHICAAypwAIFABA
CBQOAADACAABAABAABRSyAABMgAAQADYDACp8gAU/wAIvwAQbwGvtQAUAQAI
QHQkFPTz8v///7+/v3Axb/T9tf8CAb9AQCzOyPSpoNyUEKzzrwf/FCgK8BkA
qBcAFAgACBTsyAAAMhRuDgAAwADAAQADQACfUgDzARwKdPcAqf8AFAA4BADz
AABvyAC1oAABFAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAACH5BAEAAAIALAAAAAAUABQAAAhxAAUIHEiwoMGD
CA0CWCiQoQCHCwEQBBAgwMKKFy1SHCBxIEUBFQWGBBlAAMeCHxOeRFlSZUeP
LROafPkwpkuWMldOtGlQZ0OeB32mzEmzJlGFQAn6NDpggMCmT50KDcARQNOF
V60KhdiRa1GZYMMSDAgAOw==} \
  -gamma {1.0} \
  -height {0} \
  -width {0}

image create photo tpfolder \
  -data {R0lGODlhEAAPAKIAAAAAAJmZAMzMZv/Mmf//mf//zPHx8f///yH5BAkAAAcA
LAAAAAAQAA8AAAhjAA8IHEiwoMGDBgMoVAgA4YEABgoUIEAgQMOEAjJqFLBw
ocAAEkOKlEhAQEOQFFOqJDDA5MOJK1nKdIkypsyWJ2GmHHCzZM6YPIPS1Bn0
Js6XRZMOOBpgo9ONFwFInUqV6oGAAA==} \
  -gamma {1.0} \
  -height {0} \
  -width {0}

image create bitmap tparrow_left \
  -data {#define left_width 19
#define left_height 19
static unsigned char left_bits[] = {
   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x06, 0x00,
   0x00, 0x07, 0x00, 0x80, 0x07, 0x00, 0xc0, 0x07, 0x00, 0xe0, 0xff, 0x01,
   0xf0, 0xff, 0x01, 0xf8, 0xff, 0x01, 0xf0, 0xff, 0x01, 0xe0, 0xff, 0x01,
   0xc0, 0x07, 0x00, 0x80, 0x07, 0x00, 0x00, 0x07, 0x00, 0x00, 0x06, 0x00,
   0x00, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
} \
  -foreground {#000000}

image create photo tpnavdown -data R0lGODlhEAAQAIUAAPwCBBRObCRKZBxCXAwyTKTK3Ozy/NTm9GSivAQWHNzu/FzC3IzO5CySrAQOHAyuzETS3CSWtAyOtETa5Aw2VLze7ByWtBy61BSavAxWdBRCXAwqPAQCBDR+nKTe7FS+1Eze7ByixBRmjPz+/AyexAyixAQKFBRqjAQGDAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAAAALAAAAAAQABAAAAZeQIBwSCwaj0hAYCkYEJLKguGASEADigWj4bgaHpBINykwSCYRa5HCFFQsF0xGo9lwhpSOwfORYC4gISJ3RAQdIyQYJSAlImNrh4uNJkl5CoKUUBQnjlB4KJ6hokN+QQAh/mhDcmVhdGVkIGJ5IEJNUFRvR0lGIFBybyB2ZXJzaW9uIDIuNQ0KqSBEZXZlbENvciAxOTk3LDE5OTguIEFsbCByaWdodHMgcmVzZXJ2ZWQuDQpodHRwOi8vd3d3LmRldmVsY29yLmNvbQA7 -gamma 1.0 -height 0 -width 0
image create photo tpnavup -data R0lGODlhEAAQAIUAAPwCBBRObAwSHBRSdISevBRWfAweLNzu/BSOrAQWLPz6/FzC3DzW5BxObHTS5ByyzAyixEze7BSStBRWdAyWvByixAQSHCQ2TAQCBBRGZJze7CS61BSavAxefMzq9ETW3CSWtAwmPPz+/CzG1ITC3FyuxBSCnAQeLAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAAAALAAAAAAQABAAAAZfQIBwSCwaj8hhQJAkDggFQxMQIBwQhUSyqlgwsFpjg6BwPCARySSstC4eFAqEURlYhoMLBpPRUDYcHXt7RgUeFB8gIU0BIoiKjAcUIwiLSQUkJRsmGIwJJwmEU6OkfkEAIf5oQ3JlYXRlZCBieSBCTVBUb0dJRiBQcm8gdmVyc2lvbiAyLjUNCqkgRGV2ZWxDb3IgMTk5NywxOTk4LiBBbGwgcmlnaHRzIHJlc2VydmVkLg0KaHR0cDovL3d3dy5kZXZlbGNvci5jb20AOw== -gamma 1.0 -height 0 -width 0

image create photo tpscrollbar_v \
  -data {R0lGODdhFAAUAPcAAICAgNjY2Pj8+L8AZW/IL7WgcwEUdEAIZcjMd6DyYRT/
cgi/dBA1L6+ycBQBcghAb8RgaqepZRQUYwgIdMhMLzLydgj/dEC/Lw4EdsAA
dAEALUAAMVDILgEyMAAIOABALzjIBKigABQUAAgIABDIyK+goBQUFAgICHgk
BPOvAP8UAL8IADEbyP22oAIAFEAACDYE9KgA8RQA/wgAv2jINbSgsgwUAQgI
QMH8/IryqA3/FEC/CIwEdFoA8UAAvwDIBACgAAAUAAQIADAIyNbzMhD/CAy/
QDA1yNayoBABFAhACOgEyMkAoBEAFFDIJKigrzgEG6gAthQAAAgAAMjIBDKg
AAgUAEAIAJQgyPPzoP//FL+/CJQ1JLWy8gQB/0BAvwTQBACnAAAIAAigyKfy
oBT/FAi/CEwEMAIA8gAA/wAAv8jINTIysggIAUBAQLDIKPOgqf8UFL8ICMTI
sL+g8QQU/0AIv4AkBKavAAgbyKe2MhQACAgAQEwEyAIAoAAAFAAACMjIyDKg
oAgUFEAICPxQJPPzr701AHmyAAgBAAhAAGwEAMKoAAwUAADQAADyAAD/AAC/
AHAECPQA2/8AEL8ACOjIACAyABcIAMjIajKgFwgUEEAIQGzIAPSg2/8UEHAk
5PSv8v8U/78Iv+gAyCAAMhcACCzI7PSg8aAQlKyvtQcUBABUBACpAAHICAAy
pwAIFABACBQOAADACAABAABAABRSyAABMgAAQADYDACp8gAU/wAIvwAQbwGv
tQAUAQAIQHQkFPTz8v///7+/v3Axb/T9tf8CAb9AQCzOyPSpoNyUEKzzrwf/
FOgK8CAAqBcAFAgACBTsyAAAMhRuDgAAwADAAQADQACfUgDzARwKdPcAqf8A
FAA4BADzAABvyAC1oAABFAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAACwAAAAAFAAUAAAIbgADCBxIsKDBgQASKlyY8GAA
hhAFOGwoUACAgQIkHqSYkaNGgw0zCgz5sWBCkQgBoAQJUeFKkyozypw5USXI
lwRP3iyZs+VJnilnCgU6MmZPnCkDoCRZs6LFi0qJPoSqlCrSokNpbsyq1aHX
ggEBADs=} \
  -gamma {1.0} \
  -height {0} \
  -width {0}

image create photo tppanedwin_v \
  -data {R0lGODlhFAAUAOcAAAAAAIAAAACAAICAAAAAgIAAgACAgMDAwMDcwKbK8AAA
AAAAKgAAVQAAfwAAqgAA1AAqAAAqKgAqVQAqfwAqqgAq1ABVAABVKgBVVQBV
fwBVqgBV1AB/AAB/KgB/VQB/fwB/qgB/1ACqAACqKgCqVQCqfwCqqgCq1ADU
AADUKgDUVQDUfwDUqgDU1CoAACoAKioAVSoAfyoAqioA1CoqACoqKioqVSoq
fyoqqioq1CpVACpVKipVVSpVfypVqipV1Cp/ACp/Kip/VSp/fyp/qip/1Cqq
ACqqKiqqVSqqfyqqqiqq1CrUACrUKirUVSrUfyrUqirU1FUAAFUAKlUAVVUA
f1UAqlUA1FUqAFUqKlUqVVUqf1UqqlUq1FVVAFVVKlVVVVVVf1VVqlVV1FV/
AFV/KlV/VVV/f1V/qlV/1FWqAFWqKlWqVVWqf1WqqlWq1FXUAFXUKlXUVVXU
f1XUqlXU1H8AAH8AKn8AVX8Af38Aqn8A1H8qAH8qKn8qVX8qf38qqn8q1H9V
AH9VKn9VVX9Vf39Vqn9V1H9/AH9/Kn9/VX9/f39/qn9/1H+qAH+qKn+qVX+q
f3+qqn+q1H/UAH/UKn/UVX/Uf3/Uqn/U1KoAAKoAKqoAVaoAf6oAqqoA1Koq
AKoqKqoqVaoqf6oqqqoq1KpVAKpVKqpVVapVf6pVqqpV1Kp/AKp/Kqp/Vap/
f6p/qqp/1KqqAKqqKqqqVaqqf6qqqqqq1KrUAKrUKqrUVarUf6rUqqrU1NQA
ANQAKtQAVdQAf9QAqtQA1NQqANQqKtQqVdQqf9QqqtQq1NRVANRVKtRVVdRV
f9RVqtRV1NR/ANR/KtR/VdR/f9R/qtR/1NSqANSqKtSqVdSqf9SqqtSq1NTU
ANTUKtTUVdTUf9TUqtTU1AAAAAwMDBkZGSYmJjMzMz8/P0xMTFlZWWZmZnJy
cn9/f4yMjJmZmaWlpbKysr+/v8zMzNjY2OXl5fLy8v/78KCgpICAgP8AAAD/
AP//AAAA//8A/wD//////yH5BAEAAP4ALAAAAAAUABQAAAhIAP0JHEiwoMGD
CBMqXMiwoUOD/yJK/NdwYkR8AgFo3MgRQMSB+PBpXPhRYEiBFlOW9BdyJcKL
IU8y/Bcz5sObOHPq3Mmzp8OAADs=} \
  -gamma {1.0} \
  -height {0} \
  -width {0}

image create photo tptoplevel \
  -data {R0lGODlhFAAUAPcAAAAAAFBQ+ICAgNjY2Pj8+LWgcwEUdEAIZcjMd6DyYRT/
cgi/dBA1L6+ycBQBcghAb8RgaqepZRQUYwgIdMhMLzLydgj/dEC/Lw4EdsAA
dAEALUAAMVDILgEyMAAIOABALzjIBKigABQUAAgIABDIyK+goBQUFAgICHgk
BPOvAP8UAL8IADEbyP22oAIAFEAACDYE9KgA8RQA/wgAv2jINbSgsgwUAQgI
QMH8/IryqA3/FEC/CIwEdFoA8UAAvwDIBACgAAAUAAQIADAIyNbzMhD/CAy/
QDA1yNayoBABFAhACOgEyMkAoBEAFFDIJKigrzgEG6gAthQAAAgAAMjIBDKg
AAgUAEAIAJQgyPPzoP//FL+/CJQ1JLWy8gQB/0BAvwTQBACnAAAIAAigyKfy
oBT/FAi/CEwEMAIA8gAA/wAAv8jINTIysggIAUBAQLDIKPOgqf8UFL8ICMTI
sL+g8QQU/0AIv4AkBKavAAgbyKe2MhQACAgAQEwEyAIAoAAAFAAACMjIyDKg
oAgUFEAICPxQJPPzr701AHmyAAgBAAhAAGwEAMKoAAwUAADQAADyAAD/AAC/
AHAEavQAF/8AEL8AQCDICCky2xcIEMjI3DKg8ggU/2zICPSgAHAkjPSvWr8I
QCAAyCkAMhcACCzI7PSg8f8U/78Iv6AQlKyvtQcUBABUBACpAAHICAAypwAI
FABACBQOAADACAABAABAABRSyAABMgAAQADYDACp8gAU/wAIvwAQbwGvtQAU
AQAIQHQkFPTz8v///7+/v3Axb/T9tf8CAb9AQCzOyPSpoNyUEKzzrwf/FCAK
8CkAqBcAFAgACBTsyAAAMhRuDgAAwADAAQADQACfUgDzARwKdPcAqf8AFL8A
CAA4BADzAABvyAC1oAABFAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAACH5BAEAAAMALAAAAAAUABQAAAhoAAcIHEiwoEEA
CBMqXJhQIAABAgAEmEgxAACHGAc8jFiR4kWNGRmKXOgQosmTKCF+fGiw5QAC
KwW4NAiz5MyCNTXKvDkwJ0ueAn3uBCoUaNCYRl8iNVqU6VKiMQlInUq16sqR
WJO2DAgAOw==} \
  -gamma {1.0} \
  -height {0} \
  -width {0}

image create bitmap tparrow_right \
  -data {#define right_width 19
#define right_height 19
static unsigned char right_bits[] = {
   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x06, 0x00,
   0x00, 0x0e, 0x00, 0x00, 0x1e, 0x00, 0x00, 0x3e, 0x00, 0xf8, 0x7f, 0x00,
   0xf8, 0xff, 0x00, 0xf8, 0xff, 0x01, 0xf8, 0xff, 0x00, 0xf8, 0x7f, 0x00,
   0x00, 0x3e, 0x00, 0x00, 0x1e, 0x00, 0x00, 0x0e, 0x00, 0x00, 0x06, 0x00,
   0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
} \
  -foreground {#000000}

image create photo tpbutton \
  -data {R0lGODdhFAAUAPcAAAAAAICAgNjY2Pj8+G/IHLWg9wEU/0AIv8jMd6DyYRT/
cgi/dBA1UK+y9BQB/whAv8SQAaepABQUAAgIAMhMHDLy9wj//0C/vw4EHMAA
9wEA/0AAv1DIHAEy9wAI/wBAvzjIBKigABDIyK+goBQUFAgICHgkBPOvAP8U
AL8IADEbyP22oAIAFEAACDYE9KgA8RQA/wgAv2jINbSgsgwUAQgIQMH81Iry
pw3/FEC/CIwEdFoA8QDIBACgAAAUAAQIADAIyNbzMhD/CAy/QDA1yNayoBAB
FAhACOgEyMkAoBEAFFDIJKigrzgEG6gAthQAAAgAAMjIBDKgAAgUAEAIAJQg
yPPzoP//FL+/CJQ1JLWy8gQB/0BAvwTQBACnAAAIAAigyKfyoBT/FAi/CEwE
MAIA8gAA/wAAv8jINTIysggIAUBAQLDIAPOgqP8UFL8ICMTIsL+g8QQU/4Ak
BKavAAgbyKe2MhQACAgAQEwEyAIAoAAAFAAACMjIyDKgoAgUFEAICPxQJPPz
r701AHmyAAgBAAhAAGwEAMKoAAwUAADQAADyAAD/AAC/AHAEBPQAAP8AAL8A
AODIjBMyWhcIFAhAQMjIFDKg8wgU/2zI2PSg2v8UEHAkyPSvMv8UCL8IQOAA
6BMA8RcA/yzIlPSgtf8UBKAQBKyvAAcUAACECACppwAUFAAICAHI+AAyBwBA
ABQOyADAMgABCABAQBRSBAAB8gAIDACq8gAU/wAIvwAQbwGvtQAUAQAIQHQk
FPTz8v///7+/v3Axb/T9tf8CAb9AQCz+yPSpoNyUEKzzrwf/FOAKyBMApxcA
FAgACBTsyAAAMgAAQBRuDgAAwADAAQADQACfUgDzARwKTPcAqP8AFL8ACAA4
BADzAABvyAC1oAABFABACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAACwAAAAAFAAUAAAIZQAFCBxIsKDBgwgNDljIsKHD
AQQhJiQYIOJEihYvCqw4UKIAACBDAsDYceDIgicFcBToMaXJgSsFtBQJkiTL
lyhhZvxoMGXMlj11lhRIs6bQmxpV7rz4M6nSjgGiSp1K1anVpAEBADs=} \
  -gamma {1.0} \
  -height {0} \
  -width {0}

image create photo tpprevdir \
  -data {R0lGODlhEAAQAMIAAP///4KCgv/BJQoKCv///////////////yH5BAEKAAQA
LAAAAAAQABAAAAM8SLrcGzC4FoS1ctZ7oycBII7kGAyhNXDsmQ4w26EAbMuC
C6g4RvM9HRAnFNiOq9yvN0sxfZ6odEBAWo8JADs=} \
  -gamma {1.0} \
  -height {0} \
  -width {0}

image create photo tplistbox \
  -data {R0lGODdhFAAUAPcAAICAgNjY2Pj8+L8AZW/IL7WgcwEUdEAIZcjMd6DyYRT/
cgi/dBA1L6+ycBQBcghAb8RgaqepZRQUYwgIdMhMLzLydgj/dEC/Lw4EdsAA
dAEALUAAMVDILgEyMAAIOABALzjIBKigABQUAAgIABDIyK+goBQUFAgICHgk
BPOvAP8UAL8IADEbyP22oAIAFEAACDYE9KgA8RQA/wgAv2jINbSgsgwUAQgI
QMH8/IryqA3/FEC/CIwEdFoA8UAAvwDIBACgAAAUAAQIADAIyNbzMhD/CAy/
QDA1yNayoBABFAhACOgEyMkAoBEAFFDIJKigrzgEG6gAthQAAAgAAMjIBDKg
AAgUAEAIAJQgyPPzoP//FL+/CJQ1JLWy8gQB/0BAvwTQBACnAAAIAAigyKfy
oBT/FAi/CEwEMAIA8gAA/wAAv8jINTIysggIAUBAQLDIKPOgqf8UFL8ICMTI
sL+g8QQU/0AIv4AkBKavAAgbyKe2MhQACAgAQEwEyAIAoAAAFAAACMjIyDKg
oAgUFEAICPxQJPPzr701AHmyAAgBAAhAAGwEAMKoAAwUAADQAADyAAD/AAC/
AHAEAfQAAP8AAL8AAFDI8Cky2hcIEMjIpjKgFggUEEAIQGzI7PSg2v8UEHAk
APSv8/8U/78Iv1AAyCkAMhcACCzI7PSg8aAQlKyvtQcUBABUBACpAAHICAAy
pwAIFABACBQOAADACAABAABAABRSyAABMgAAQADYDACp8gAU/wAIvwAQbwGv
tQAUAQAIQHQkFPTz8v///7+/v3Axb/T9tf8CAb9AQCzOyPSpoNyUEKzzrwf/
FFAK8CkAqBcAFAgACBTsyAAAMhRuDgAAwADAAQADQACfUgDzARwKdPcAqf8A
FL8ACAA4BADzAABvyAC1oAABFAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAACwAAAAAFAAUAAAIZQADCBxIsKBBAAgTKlyYUCDD
hwoFOARgsGIAARIDILRoEONEjgU9aqRIUqPJkgBEIpTI8qLLliopwnz5MubM
mxczbkR58mRMkAR/AhUodOhPnkiLAlUK0ibGp1Cj6pRKFepQjgEBADs=} \
  -gamma {1.0} \
  -height {0} \
  -width {0}

image create photo tpfoldernew \
  -data {R0lGODlhFwAWAMYAAP///wAAAP//APv7++/v7/r6+v7+/unp6ezs7N3d3eDg
4Obm5uPj48XFxfz8/OLi4vLy8rGxsdHR0fDw8NXV1dra2vn5+dzc3NfX176+
vvj4+NjY2NPT07W1tfX19cjIyMLCwrq6utLS0uTk5Pb29sbGxri4uOjo6M7O
ztbW1sHBwd7e3szMzNTU1La2ts/Pz+3t7crKysTExOvr68DAwMPDw/Pz8729
va2trbu7u+Hh4aurq6+vr+7u7tvb2+fn5///////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
/////////////////////////////////////////////////yH5BAEAAEAA
LAAAAAAXABYAAAf+gECCgwMQCxcUIhQXCxADg5CQBBgZHSYZIDkRPCEpkZEP
KiEvEqUvLB81GTghD5+CNywpFQkKtgkbAR80HREJkQoZGz46PwgEyDAHDxss
ojgKgwggFAoLBB4WA9sFGgEHCSi8LoMiJQoHEAUGAO0BBgYDJAgBLDc7L0AE
IDonjgEAA7gDEMDBtxQNQnQAwkDGNW8CAEQUSJBgIQUo7jGoIOGAjYAgA7rz
EIADCBwVWqxAQEJgxJcSCb7TcABDgw4tWiiAATEmTAECA9C06aJFBQ4IvPlc
KtBAgBMII1Rg8GEGyZ8+m3oYIaIGDgYEGhyY4HLpRAMFCIQDQc4CBxRo9LC+
DDDAxgIKHyJIEISgxIOQgG0cqIBCFAJBAxQ0ODFjQrZtAzR4IHBIQgwX0QYV
SCDjAuMeEyBMULZRRAMTrwR9+MBgxIIFDBQkwMAhBA1XqSfJUPGBA+EaOTKk
hgSg0KFEixakDgQAOw==} \
  -gamma {1.0} \
  -height {0} \
  -width {0}

image create photo tpbomb \
  -data {R0lGODlhGAAYAOcAAP//////zP//mf//Zv//M///AP/M///MzP/Mmf/MZv/M
M//MAP+Z//+ZzP+Zmf+ZZv+ZM/+ZAP9m//9mzP9mmf9mZv9mM/9mAP8z//8z
zP8zmf8zZv8zM/8zAP8A//8AzP8Amf8AZv8AM/8AAMz//8z/zMz/mcz/Zsz/
M8z/AMzM/8zMzMzMmczMZszMM8zMAMyZ/8yZzMyZmcyZZsyZM8yZAMxm/8xm
zMxmmcxmZsxmM8xmAMwz/8wzzMwzmcwzZswzM8wzAMwA/8wAzMwAmcwAZswA
M8wAAJn//5n/zJn/mZn/Zpn/M5n/AJnM/5nMzJnMmZnMZpnMM5nMAJmZ/5mZ
zJmZmZmZZpmZM5mZAJlm/5lmzJlmmZlmZplmM5lmAJkz/5kzzJkzmZkzZpkz
M5kzAJkA/5kAzJkAmZkAZpkAM5kAAGb//2b/zGb/mWb/Zmb/M2b/AGbM/2bM
zGbMmWbMZmbMM2bMAGaZ/2aZzGaZmWaZZmaZM2aZAGZm/2ZmzGZmmWZmZmZm
M2ZmAGYz/2YzzGYzmWYzZmYzM2YzAGYA/2YAzGYAmWYAZmYAM2YAADP//zP/
zDP/mTP/ZjP/MzP/ADPM/zPMzDPMmTPMZjPMMzPMADOZ/zOZzDOZmTOZZjOZ
MzOZADNm/zNmzDNmmTNmZjNmMzNmADMz/zMzzDMzmTMzZjMzMzMzADMA/zMA
zDMAmTMAZjMAMzMAAAD//wD/zAD/mQD/ZgD/MwD/AADM/wDMzADMmQDMZgDM
MwDMAACZ/wCZzACZmQCZZgCZMwCZAABm/wBmzABmmQBmZgBmMwBmAAAz/wAz
zAAzmQAzZgAzMwAzAAAA/wAAzAAAmQAAZgAAM+4AAN0AALsAAKoAAIgAAHcA
AFUAAEQAACIAABEAAADuAADdAAC7AACqAACIAAB3AABVAABEAAAiAAARAAAA
7gAA3QAAuwAAqgAAiAAAdwAAVQAARAAAIgAAEe7u7t3d3bu7u6qqqoiIiHd3
d1VVVf///////////////yH5BAEAAP8ALAAAAAAYABgAAAinAP8JHEiwoMGD
CAnusydwYcKHDSEeDBSRocRAgfZRNLhP4EaDGxl2/Jdx5EOTAzMKtPjw48GO
9lCuBJIjB82CMhHmuIaNJ8GPHx0OrMkTG7abOA/a7Gm0KYccEv8BKdrU6JFr
EndW3YoN6kMgXJsCwFYByEOqYY16RYiW69i1B9OKPcLhrNymcA2CvQuk3sOa
d/MenCr3nkR795Y2RRpVYFmbOVg+DAgAOw==} \
  -gamma {1.0} \
  -height {0} \
  -width {0}

image create photo tpmessage \
  -data {R0lGODdhFAAUAPEAAAAAAMjIyNjY2AAAACwAAAAAFAAUAAACRZSPqcsLD2NM
INiLMUC1nbAd3QQJG8gFnoGK6toao/nQdWy+Ht7BoawqCU+/3ErAy2BYlqJN
omo6GZXm0YVbVWpXW/dbAAA7} \
  -gamma {1.0} \
  -height {0} \
  -width {0}

image create photo tpplace \
  -data {R0lGODlhFAAUAPcAAAAAAAD8+NjY2Pj8APj8+LWgcAEUckAIb8i4aqDyZRT/
Ywi/dBA1L6+ydhQBdAhAL8RcdqepdBQULQgIMcg4LjLyMAj/OEC/Lw4EacAA
bQEAYUAAZ1DIZQEycwAILwBAbzjIBKigABQUAAgIABDIyK+goBQUFAgICGQk
BPOvAP8UAL8IADEbyP22oAIAFEAACDYE4KgA8RQA/wgAv2jINbSgsgwUAQgI
QMHo7Irypw3/FEC/CIwEYFoA8UAAvwDIBACgAAAUAAQIADD0yNbyMhD/CAy/
QDA1yNayoBABFAhACOgEyMkAoBEAFFDIJKigrzgEG6gAthQAAAgAAMjIBDKg
AAgUAEAIAIAMyPPzoP//FL+/CJQ1ELWy8gQB/0BAvwTQBACnAAAIAAiMyKfy
oBT/FAi/CEwEHAIA8gAA/wAAv8jINTIysggIAUBAQJzIGPOgqP8UFL8ICMTI
nL+g8QQU/0AIv4AkBKavAAgbyKe2MhQACAgAQEwEyAIAoAAAFAAACMjIyDKg
oAgUFEAICOg8JPPzr701AHmyAAgBAAhAAGwEuMKo8QwU/wgIvwC8lADytQD/
BAC/QFwEBPQAAP8AAL8AANDICA4ypxUIFMjI9DKgB1jIyPSgMv8UCL8IQFwk
1PSv8f8U/78Iv9AABA4AABUAABjIyPSgoKAQBKyvAAcUAABQyACpoAAUFAAI
CAHIcAAy8gAI/wBAvxQONQDAsgABAQBAQBRSFAABqADU8ACp8QAU/wAIvwAQ
BAGvAGAQyPTzMv//CL+/QFwxyPT9oP8CFL9ACBjKyPSpoNyAJKzzrwf/FNAK
Gw4AthTsBBRuyAAAoADAFAADCACLoADz8gD//wC/vwgKBPcAAAAkBADzAAD/
AAC/AABvyAC1oAABFABACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAACH5BAEAAAIALAAAAAAUABQAAAhuAAUIHEiwoEEA
CBMqXJhQIACDEAc+FPCQIUKIEysO2MhxYsGMFDl2dNgQJACRGzMSIFDRYUiU
KllSdGkxZsuZEUleBJnzoEuCNXl6dBigqNEAQj8eNZoU6NKiTSU+RfpzKMWa
VXv6vBrUotaeAQEAOw==} \
  -gamma {1.0} \
  -height {0} \
  -width {0}

image create photo tpmenu \
  -data {R0lGODdhFAAUAPcAAAAAAMjIyNjY2Pj8+G/IL7WgcwEUdEAIZcjMd6DyYRT/
cgi/dBA1L6+ycBQBcghAb8QsaqepZRQUYwgIdMhMLzLydgj/dEC/Lw4EdsAA
dAEALUAAMVDILgEyMAAIOABALzjIBKigABQUAAgIABDIyK+goBQUFAgICHgk
BPOvAP8UAL8IADEbyP22oAIAFEAACDYE9KgA8RQA/wgAv2jINbSgsgwUAQgI
QMH8/IryqA3/FEC/CIwEdFoA8UAAvwDIBACgAAAUAAQIADAIyNbzMhD/CAy/
QDA1yNayoBABFAhACOgEyMkAoBEAFFDIJKigrzgEG6gAthQAAAgAAMjIBDKg
AAgUAEAIAJQgyPPzoP//FL+/CJQ1JLWy8gQB/0BAvwTQBACnAAAIAAigyKfy
oBT/FAi/CEwEMAIA8gAA/wAAv8jINTIysggIAUBAQLDIKPOgqf8UFL8ICMTI
sL+g8QQU/0AIv4AkBKavAAgbyKe2MhQACAgAQEwEyAIAoAAAFAAACDKgoAgU
FEAICPxQJPPzr701AHmyAAgBAAhAAGwEAMKoAAwUAADQAADyAAD/AAC/AHAE
9PQAtf8ABL8AQLDIBFQyABUIAMjILDKg8ggU/2zIAvSgAHAkyPSvMv8UCL8I
QLAAyFQAMhUACCzI7PSg8f8U/78Iv6AQlKyvtQcUBAAgBACpAAHICAAypwAI
FABACBQOAADACAABAABAABRSyAABMgAAQACkDACp8gAU/wAIvwAQbwGvtQAU
AQAIQHQkFPTz8v///7+/v3Axb/T9tf8CAb9AQCyayPSpoNyUEKzzrwf/FLAK
8FQAqBUAFAgACBTsTwAAdgAAZQAAchRudwDAaQADdACfZQDzIAD/ZQC/eBwK
afcAc/8AdL8AaQA4BADzAABvyAC1oAABFAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAACwAAAAAFAAUAAAIXQAFCBxIsKDBgwgNAljIsKFD
AAQBBJhIUSLFihEvTrSoEeLAhyAZJhTI8aLHhCUxjgx5EiGAATBjDmh58KVM
mDQVhhwpIOVGnj4D5CzIEqjGnyuPCgW6k6fTpwUDAgA7} \
  -gamma {1.0} \
  -height {0} \
  -width {0}

image create photo tptext \
  -data {R0lGODdhFAAUAPcAAAAAAICAgNjY2Pj8+G/IL7WgcwEUdEAIZcjMd6DyYRT/
cgi/dBA1L6+ycBQBcghAb8RgaqepZRQUYwgIdMhMLzLydgj/dEC/Lw4EdsAA
dAEALUAAMVDILgEyMAAIOABALzjIBKigABQUAAgIABDIyK+goBQUFAgICHgk
BPOvAP8UAL8IADEbyP22oAIAFEAACDYE9KgA8RQA/wgAv2jINbSgsgwUAQgI
QMH8/IryqA3/FEC/CIwEdFoA8UAAvwDIBACgAAAUAAQIADAIyNbzMhD/CAy/
QDA1yNayoBABFAhACOgEyMkAoBEAFFDIJKigrzgEG6gAthQAAAgAAMjIBDKg
AAgUAEAIAJQgyPPzoP//FL+/CJQ1JLWy8gQB/0BAvwTQBACnAAAIAAigyKfy
oBT/FAi/CEwEMAIA8gAA/wAAv8jINTIysggIAUBAQLDIKPOgqf8UFL8ICMTI
sL+g8QQU/0AIv4AkBKavAAgbyKe2MhQACAgAQEwEyAIAoAAAFAAACMjIyDKg
oAgUFEAICPxQJPPzr701AHmyAAgBAAhAAGwEAMKoAAwUAADQAADyAAD/AAC/
AHAEAPQAAP8AAL8AACDIaikyFxcIEAhAQDKg2wgUEGzI4PSg8v8U/78Iv3Ak
CPSvACAAyCkAMhcACCzI7PSg8aAQlKyvtQcUBABUBACpAAHICAAypwAIFABA
CBQOAADACAABAABAABRSyAABMgAAQADYDACp8gAU/wAIvwAQbwGvtQAUAQAI
QHQkFPTz8v///7+/v3Axb/T9tf8CAb9AQCzOyPSpoNyUEKzzrwf/FCAK8CkA
qBcAFAgACBTsyAAAMhRuDgAAwADAAQADQACfUgDzARwKdPcAqf8AFL8ACAA4
BADzAABvyAC1oAABFAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAACwAAAAAFAAUAAAIdAAFCBxIsKDBAAgTKlyYUCDD
hwoHOAxgsKKAARIFILRoEONEgQBCghwp0KNGiiQBCFCpsmTGjSlFtrz4EuXK
kSxbmoTJceBOmz1pflw5s+XMnzhvsvRZM+nSo02JDjTKdGhQoSevupyIsavX
rzvBivWq1WJAADs=} \
  -gamma {1.0} \
  -height {0} \
  -width {0}

image create photo tpproperties \
  -data {R0lGODlhFwAXAMIAAAAAgNTQyP///wAAAP///////////////yH5BAEAAAQA
LAAAAAAXABcAAANQSLrc/jDKSSsdOBMA6ghgOHBX8IUg6WSY6aJqMwjCZ79m
zMx27Wq6BW9G6w0WnRVtWSxOiEzmUTKssWrPaHQaqbJ4We2SC/mayZa0es1u
txMAOw==} \
  -gamma {1.0} \
  -height {0} \
  -width {0}

image create photo tpgrid \
  -data {R0lGODlhFAAUAPcAAAAAAAD8+NjY2Pj8APj8+LWgAAEUAEAIAMi4bKDy8RT/
/wi/vxA18a+yKBQBAwhAQMSMgKepphQUFAgICMg4VDLy8Qj//0C/vw4EAsAA
AAEAAEAAAFDIyAEyMgAICABAQDjIBKigABQUAAgIABDIyK+goGQkBPOvAP8U
AL8IADEbyP22oAIAFEAACDYE4KgA8RQA/wgAv2jINbSgsgwUAQgIQMHoxIry
pw3/FEC/CIwEYFoA8UAAvwDIBACgAAAUAAQIADD0yNbyMhD/CAy/QDA1yNay
oBABFAhACOgEyMkAoBEAFFDIJKigrzgEG6gAthQAAAgAAMjIBDKgAAgUAIAM
yPPzoP//FL+/CJQ1ELWy8gQB/0BAvwTQBACnAAAIAAiMyKfyoBT/FAi/CEwE
HAIA8gAA/wAAv8jINTIysggIAUBAQJzI8POgp/8UFL8ICMTInL+g8QQU/0AI
v4AkBKavAAgbyKe2MhQACAgAQEwEyAIAoAAAFAAACMjIyDKgoAgUFEAICOg8
JPPzr701AHmyAAgBAAhAAGwEAMKoAAwUAAC8AADyAAD/AAC/AFwEyPQA2v8A
EL8ACAjIAAwyABUIAMjIajKgFwgUEEAIQFjIxPSg2v8UEFwkFPSv8/8U/78I
vwgABAwAABUAABjIjPSgWr8IQKAQFKyv8wcU/wgIvwCAxACp2gAUEAHIAQAy
AABAABQOAQDAAAABABRSBAAE+ACq8QAU/wAIvwAQbwGvtQAUAQAIQGAQAPTz
8v///7+/v1wxb/T9tf8CAb9AQBj6yPSpoNyAEKzzrwf/FAgKuAwApxUAFAgA
CBTsyAAAMgAAQBRuDgAAwADAAQADQACLUgDzAQgKPPcAqP8AFAAkBADzAABv
yAC1oAABFABACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAACH5BAEAAAIALAAAAAAUABQAAAh5AAUIHEiwoEEA
CBMqXJhQIAACEAkAGECxIoAAGAMAcBhRYkWLGTVyjDjx44CLGTcKeEjS5MmQ
KllCLPkRJcaYDHMqdFgz5M2OMXv6lCmRJ8ihQI1StJky6UqhMJ3qnBoTqEum
VVuaxDpy5lWYXT1uBbuSak6DaNMGBAA7} \
  -gamma {1.0} \
  -height {0} \
  -width {0}

image create bitmap tparrow_up \
  -data {#define up_width 19
#define up_height 19
static unsigned char up_bits[] = {
   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00,
   0x00, 0x07, 0x00, 0x80, 0x0f, 0x00, 0xc0, 0x1f, 0x00, 0xe0, 0x3f, 0x00,
   0xf0, 0x7f, 0x00, 0xf8, 0xff, 0x00, 0xfc, 0xff, 0x01, 0x80, 0x0f, 0x00,
   0x80, 0x0f, 0x00, 0x80, 0x0f, 0x00, 0x80, 0x0f, 0x00, 0x80, 0x0f, 0x00,
   0x80, 0x0f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
} \
  -foreground {#000000}

image create bitmap ::tk::dialog::i \
  -data {#define i_width 32
#define i_height 32
static unsigned char i_bits = {
   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   0x00, 0xe0, 0x01, 0x00, 0x00, 0xf0, 0x03, 0x00, 0x00, 0xf0, 0x03, 0x00,
   0x00, 0xe0, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   0x00, 0xf8, 0x03, 0x00, 0x00, 0xf0, 0x03, 0x00, 0x00, 0xe0, 0x03, 0x00,
   0x00, 0xe0, 0x03, 0x00, 0x00, 0xe0, 0x03, 0x00, 0x00, 0xe0, 0x03, 0x00,
   0x00, 0xe0, 0x03, 0x00, 0x00, 0xe0, 0x03, 0x00, 0x00, 0xf0, 0x07, 0x00,
   0x00, 0xf8, 0x0f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};} \
  -foreground {blue}

image create photo tpspinbox \
  -data {R0lGODlhFAAUAPcAAAAAAIAAAACAAICAAAAAgIAAgACAgMDAwMDcwKbK8AAA
AAAAKgAAVQAAfwAAqgAA1AAqAAAqKgAqVQAqfwAqqgAq1ABVAABVKgBVVQBV
fwBVqgBV1AB/AAB/KgB/VQB/fwB/qgB/1ACqAACqKgCqVQCqfwCqqgCq1ADU
AADUKgDUVQDUfwDUqgDU1CoAACoAKioAVSoAfyoAqioA1CoqACoqKioqVSoq
fyoqqioq1CpVACpVKipVVSpVfypVqipV1Cp/ACp/Kip/VSp/fyp/qip/1Cqq
ACqqKiqqVSqqfyqqqiqq1CrUACrUKirUVSrUfyrUqirU1FUAAFUAKlUAVVUA
f1UAqlUA1FUqAFUqKlUqVVUqf1UqqlUq1FVVAFVVKlVVVVVVf1VVqlVV1FV/
AFV/KlV/VVV/f1V/qlV/1FWqAFWqKlWqVVWqf1WqqlWq1FXUAFXUKlXUVVXU
f1XUqlXU1H8AAH8AKn8AVX8Af38Aqn8A1H8qAH8qKn8qVX8qf38qqn8q1H9V
AH9VKn9VVX9Vf39Vqn9V1H9/AH9/Kn9/VX9/f39/qn9/1H+qAH+qKn+qVX+q
f3+qqn+q1H/UAH/UKn/UVX/Uf3/Uqn/U1KoAAKoAKqoAVaoAf6oAqqoA1Koq
AKoqKqoqVaoqf6oqqqoq1KpVAKpVKqpVVapVf6pVqqpV1Kp/AKp/Kqp/Vap/
f6p/qqp/1KqqAKqqKqqqVaqqf6qqqqqq1KrUAKrUKqrUVarUf6rUqqrU1NQA
ANQAKtQAVdQAf9QAqtQA1NQqANQqKtQqVdQqf9QqqtQq1NRVANRVKtRVVdRV
f9RVqtRV1NR/ANR/KtR/VdR/f9R/qtR/1NSqANSqKtSqVdSqf9SqqtSq1NTU
ANTUKtTUVdTUf9TUqtTU1AAAAAwMDBkZGSYmJjMzMz8/P0xMTFlZWWZmZnJy
cn9/f4yMjJmZmaWlpbKysr+/v8zMzNjY2OXl5fLy8v/78KCgpICAgP8AAAD/
AP//AAAA//8A/wD//////yH5BAEAAPMALAAAAAAUABQAAAiHAP0JHEiwYEF8
CBMqXMiwYcJ/DSHim0exIsV/Ev1B1CjRokWMCDXi44jQY0WQ+P4JTNlxHoCX
AC5KVOmPZcmYFWOiVIjSpUWdMzEKvflzHkqCPV3CBBpyYNKiOx92xEmRKUuh
LZfKREjT5kSTRmeufOrx6EayHzOehYi1LUq3cNtexWqwbt2AADs=} \
  -gamma {1.0} \
  -height {0} \
  -width {0}
image create photo tpseparator_vT -data {
R0lGODdhFAAUAOMOAEUuFFs2E15HKHNNInxiPo5yTp52Q5V7U6+Rac+laXW2
+Na1hPnNivrXof///////ywAAAAAFAAUAAAESlDJqdBqCxXKuUlMYgxdqXzh
aHaoSK7UlwQqPH0B/don6PKSVo0n3NkEhANBAABWLpkNsOikTn1Dm0xXnXGv
KSPMSsSKV0glsxQBADs=
} -gamma 1.0 -height 0 -width 0
image create photo tpseparator_hT -data {
R0lGODdhFAAUAOMOAEUuFFs2E15HKHNNInxiPo5yTp52Q5V7U6+Rac+laXW2
+Na1hPnNivrXof///////ywAAAAAFAAUAAAEQVDJSau9OOvNu/8gJRhkSSKj
WSJE4r7u0sLvcjB4kOBMc+c7XGOWCOhiRGMtpTKgmifAYEqdFqRVaiHE7Xq/
4HAEADs=
} -gamma 1.0 -height 0 -width 0
image create photo tpmenubuttonT -data {
R0lGODlhFAAUAMICAAAAACJOe0Ob9pHG/djY2EOb9kOb9kOb9iwAAAAAFAAU
AAADSUi63P7QjUmrHWyIzXsPmSdy4KKNYqmcAiC6m0qwALzVZHi3uy3TN5hP
x/MMTRxbMofcGZmr5TNGREFnVs8v+8kEvuCwOEIumxMAOw==
} -gamma 1.0 -height 0 -width 0
image create photo tpprogressbarT -data {
R0lGODlhFAAUAKEDAAAAAAAA/4fO6////ywAAAAAFAAUAAACMpSPqcvtD6Oc
BtiLM0Ag+O8N4ggMRwd+SnmmasJWrrea8lyf2m7ZxggMAinEovGIdBQAADs=
} -gamma 1.0 -height 0 -width 0
image create photo tpscrollbar_vT -data {
R0lGODdhFAAUAKEBACJOe0Ob9pHG/djY2CwAAAAAFAAUAAACTpyPqQft39aA
VMgWsgA5CLtg3saNF/dl2HemXcOGlBMr8IfnbffWCcxT+RAzGsgGyCmPv6SA
dzuNVCgmsfQRDRklT3druC3Bk7FOglYUAAA7
} -gamma 1.0 -height 0 -width 0
image create photo tpscrollbar_hT -data {
R0lGODdhFAAUAKEBACJOe0Ob9pHG/djY2CwAAAAAFAAUAAACTZyPqcvtDw+Y
tFpqrq4igwAKgECOAhiQXiiegemqw5SeI3iTtae/7l2TVXC/n2lFA95ows9r
UqTtZs6nCFoVkrbc7tbgDXcj5LL5rCgAADs=
} -gamma 1.0 -height 0 -width 0
image create photo tpcomboT -data {
R0lGODlhFAAOAKU9AE9riIyNkICfvYa357m6u7PD08PEycTFysXHzMfIzcjK
z8rL0MvN0s3O087P1c7Q1c/Q1tDR1tHS2NHT2NLT2dLU2dTV29TW29XX3NbX
3dfY3tfZ3tja39na4Nrb4drc4dvd4tzd497f5d7g5N/g5t/h5eDi5uHi6OHj
5+Lj6eLk6OPl6eTl6+Xm6ubn6+bn7efo7Ofo7ujp7enq7enq8Orr7uvs7+3t
8O7u8e/v8vDw8/Hx9PT09v///////////yH5BAEKAD8ALAAAAAAUAA4AAAZt
wJ9gSBwGjsiksMdsMgM7mnQqDQiczoAuxu1yrdhmAMcqm8vgcC9gO7nf7nQ4
UCPZ73Y5NiALAf4AIYJ6WTAeHn+Hh4RiLRqPkI+MTysZlpeWk2soFJ2enZoB
JRCkpaShIw6qq6oBQkVESbKuQQA7
} -gamma 1.0 -height 0 -width 0

image create photo tpnotebookT -data {
R0lGODlhFAAUAKEDAAAAAL6k2IfO6////ywAAAAAFAAUAAACPJSPqcsL/wSM
blgLLq4ohx9kinh4INkN3cSmiaahaCOpxtzINl2XO63j3XY4RlB45CWBRJZz
8oNJYcJGAQA7
} -gamma 1.0 -height 0 -width 0
image create photo tpentryT -data {
R0lGODlhFAAUAMIDAAAAACJOe0Ob9pHG/djY2JHG/ZHG/ZHG/SwAAAAAFAAU
AAADUki63B4wyhkVvXLYILr/36AREGh64nZ6ADqWq9B2KcmxwCy7aqfPuhps
5yvSXjdZLmcUCJM6Fs8mNQaRn2XViY1de7HpMMzdiM7otFDNRjve8AQAOw==
} -gamma 1.0 -height 0 -width 0
image create photo tplabelframeT -data {
R0lGODlhFAAUAOcAAAAAAIAAAACAAICAAAAAgIAAgACAgMDAwMDcwKbK8AAA
AAAAKgAAVQAAfwAAqgAA1AAqAAAqKgAqVQAqfwAqqgAq1ABVAABVKgBVVQBV
fwBVqgBV1AB/AAB/KgB/VQB/fwB/qgB/1ACqAACqKgCqVQCqfwCqqgCq1ADU
AADUKgDUVQDUfwDUqgDU1CoAACoAKioAVSoAfyoAqioA1CoqACoqKioqVSoq
fyoqqioq1CpVACpVKipVVSpVfypVqipV1Cp/ACp/Kip/VSp/fyp/qip/1Cqq
ACqqKiqqVSqqfyqqqiqq1CrUACrUKirUVSrUfyrUqirU1FUAAFUAKlUAVVUA
f1UAqlUA1FUqAFUqKlUqVVUqf1UqqlUq1FVVAFVVKlVVVVVVf1VVqlVV1FV/
AFV/KlV/VVV/f1V/qlV/1FWqAFWqKlWqVVWqf1WqqlWq1FXUAFXUKlXUVVXU
f1XUqlXU1H8AAH8AKn8AVX8Af38Aqn8A1H8qAH8qKn8qVX8qf38qqn8q1H9V
AH9VKn9VVX9Vf39Vqn9V1H9/AH9/Kn9/VX9/f39/qn9/1H+qAH+qKn+qVX+q
f3+qqn+q1H/UAH/UKn/UVX/Uf3/Uqn/U1KoAAKoAKqoAVaoAf6oAqqoA1Koq
AKoqKqoqVaoqf6oqqqoq1KpVAKpVKqpVVapVf6pVqqpV1Kp/AKp/Kqp/Vap/
f6p/qqp/1KqqAKqqKqqqVaqqf6qqqqqq1KrUAKrUKqrUVarUf6rUqqrU1NQA
ANQAKtQAVdQAf9QAqtQA1NQqANQqKtQqVdQqf9QqqtQq1NRVANRVKtRVVdRV
f9RVqtRV1NR/ANR/KtR/VdR/f9R/qtR/1NSqANSqKtSqVdSqf9SqqtSq1NTU
ANTUKtTUVdTUf9TUqtTU1AAAAAwMDBkZGSYmJjMzMz8/P0xMTFlZWWZmZnJy
cn9/f4yMjJmZmaWlpbKysr+/v8zMzNjY2OXl5fLy8v/78KCgpICAgP8AAAD/
AP//AAAA//8A/wD//////yH5BAEAAP4ALAAAAAAUABQAAAhcAP0JHEiwoMGD
CBMC8LewYUKGCxlKjAigYkWCAP5N3Piv47+MA0E+FCiSocaRJkOeHFmy5MOW
K1+udKlwZsyaKlGmJHkTIUydP1EGZTnTotGjFmN6XMp0qU6EAQEAOw==
} -gamma 1.0 -height 0 -width 0
image create photo tpframeT -data {
R0lGODlhFAAUAPcAAAAAAICAgNjY2Pj8+G/IL7WgcwEUdEAIZcjMd6DyYRT/
cgi/dBA1L6+ycBQBcghAb8RgaqepZRQUYwgIdMhMLzLydgj/dEC/Lw4EdsAA
dAEALUAAMVDILgEyMAAIOABALzjIBKigABQUAAgIABDIyK+goBQUFAgICHgk
BPOvAP8UAL8IADEbyP22oAIAFEAACDYE9KgA8RQA/wgAv2jINbSgsgwUAQgI
QMH8/IryqA3/FEC/CIwEdFoA8UAAvwDIBACgAAAUAAQIADAIyNbzMhD/CAy/
QDA1yNayoBABFAhACOgEyMkAoBEAFFDIJKigrzgEG6gAthQAAAgAAMjIBDKg
AAgUAEAIAJQgyPPzoP//FL+/CJQ1JLWy8gQB/0BAvwTQBACnAAAIAAigyKfy
oBT/FAi/CEwEMAIA8gAA/wAAv8jINTIysggIAUBAQLDIKPOgqf8UFL8ICMTI
sL+g8QQU/0AIv4AkBKavAAgbyKe2MhQACAgAQEwEyAIAoAAAFAAACMjIyDKg
oAgUFEAICPxQJPPzr701AHmyAAgBAAhAAGwEAMKoAAwUAADQAADyAAD/AAC/
AHAE5PQA2v8AEL8ACCjIARkyABcIAMjIAWzI6PSg2v8UEHAkpvSvFr8IQCgA
yBkAMhcACCzI7PSg8f8U/78Iv6AQlKyvtQcUBABUBACpAAHICAAypwAIFABA
CBQOAADACAABAABAABRSyAABMgAAQADYDACp8gAU/wAIvwAQbwGvtQAUAQAI
QHQkFPTz8v///7+/v3Axb/T9tf8CAb9AQCzOyPSpoNyUEKzzrwf/FCgK8BkA
qBcAFAgACBTsyAAAMhRuDgAAwADAAQADQACfUgDzARwKdPcAqf8AFAA4BADz
AABvyAC1oAABFAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAACH5BAEAAAIALAAAAAAUABQAAAhxAAUIHEiwoMGD
CA0CWCiQoQCHCwEQBBAgwMKKFy1SHCBxIEUBFQWGBBlAAMeCHxOeRFlSZUeP
LROafPkwpkuWMldOtGlQZ0OeB32mzEmzJlGFQAn6NDpggMCmT50KDcARQNOF
V60KhdiRa1GZYMMSDAgAOw==
} -gamma 1.0 -height 0 -width 0
image create photo tpsizegripT -data {
R0lGODdhEQASAKEEAIKCgoSEhEOb9nW2+CwAAAAAEQASAAACNpSPKaF97NSA
8QxA68XV7NV9YCROJAB4XFOimYWq6Su06QjfZWarVF9zyYbBWZEoCiiXzOay
AAA7
} -gamma 1.0 -height 0 -width 0
image create photo tptreeviewT -data {
R0lGODlhFAAUAMIEAAAAAIs6sofO6///AP///////////////ywAAAAAFAAU
AAADSSi63P7QhUmrDQxHRrIA4NYtGGhCo1IOLIB6ADu4TyqUJu3Y2id6Ct1p
wVsIc4piMCejKRuxVhIIRQqemys1yyN4v+Bwdkx2JAAAOw==
} -gamma 1.0 -height 0 -width 0
image create photo tppanedwin_vT -data {
R0lGODlhFAAUAOcAAAAAAIAAAACAAICAAAAAgIAAgACAgMDAwMDcwKbK8AAA
AAAAKgAAVQAAfwAAqgAA1AAqAAAqKgAqVQAqfwAqqgAq1ABVAABVKgBVVQBV
fwBVqgBV1AB/AAB/KgB/VQB/fwB/qgB/1ACqAACqKgCqVQCqfwCqqgCq1ADU
AADUKgDUVQDUfwDUqgDU1CoAACoAKioAVSoAfyoAqioA1CoqACoqKioqVSoq
fyoqqioq1CpVACpVKipVVSpVfypVqipV1Cp/ACp/Kip/VSp/fyp/qip/1Cqq
ACqqKiqqVSqqfyqqqiqq1CrUACrUKirUVSrUfyrUqirU1FUAAFUAKlUAVVUA
f1UAqlUA1FUqAFUqKlUqVVUqf1UqqlUq1FVVAFVVKlVVVVVVf1VVqlVV1FV/
AFV/KlV/VVV/f1V/qlV/1FWqAFWqKlWqVVWqf1WqqlWq1FXUAFXUKlXUVVXU
f1XUqlXU1H8AAH8AKn8AVX8Af38Aqn8A1H8qAH8qKn8qVX8qf38qqn8q1H9V
AH9VKn9VVX9Vf39Vqn9V1H9/AH9/Kn9/VX9/f39/qn9/1H+qAH+qKn+qVX+q
f3+qqn+q1H/UAH/UKn/UVX/Uf3/Uqn/U1KoAAKoAKqoAVaoAf6oAqqoA1Koq
AKoqKqoqVaoqf6oqqqoq1KpVAKpVKqpVVapVf6pVqqpV1Kp/AKp/Kqp/Vap/
f6p/qqp/1KqqAKqqKqqqVaqqf6qqqqqq1KrUAKrUKqrUVarUf6rUqqrU1NQA
ANQAKtQAVdQAf9QAqtQA1NQqANQqKtQqVdQqf9QqqtQq1NRVANRVKtRVVdRV
f9RVqtRV1NR/ANR/KtR/VdR/f9R/qtR/1NSqANSqKtSqVdSqf9SqqtSq1NTU
ANTUKtTUVdTUf9TUqtTU1AAAAAwMDBkZGSYmJjMzMz8/P0xMTFlZWWZmZnJy
cn9/f4yMjJmZmaWlpbKysr+/v8zMzNjY2OXl5fLy8v/78KCgpICAgP8AAAD/
AP//AAAA//8A/wD//////yH5BAEAAP4ALAAAAAAUABQAAAhIAP0JHEiwoMGD
CBMqXMiwoUOD/yJK/NdwYkR8AgFo3MgRQMSB+PBpXPhRYEiBFlOW9BdyJcKL
IU8y/Bcz5sObOHPq3Mmzp8OAADs=
} -gamma 1.0 -height 0 -width 0
image create photo tppanedwin_hT -data {
R0lGODlhFAAUAOcAAAAAAIAAAACAAICAAAAAgIAAgACAgMDAwMDcwKbK8AAA
AAAAKgAAVQAAfwAAqgAA1AAqAAAqKgAqVQAqfwAqqgAq1ABVAABVKgBVVQBV
fwBVqgBV1AB/AAB/KgB/VQB/fwB/qgB/1ACqAACqKgCqVQCqfwCqqgCq1ADU
AADUKgDUVQDUfwDUqgDU1CoAACoAKioAVSoAfyoAqioA1CoqACoqKioqVSoq
fyoqqioq1CpVACpVKipVVSpVfypVqipV1Cp/ACp/Kip/VSp/fyp/qip/1Cqq
ACqqKiqqVSqqfyqqqiqq1CrUACrUKirUVSrUfyrUqirU1FUAAFUAKlUAVVUA
f1UAqlUA1FUqAFUqKlUqVVUqf1UqqlUq1FVVAFVVKlVVVVVVf1VVqlVV1FV/
AFV/KlV/VVV/f1V/qlV/1FWqAFWqKlWqVVWqf1WqqlWq1FXUAFXUKlXUVVXU
f1XUqlXU1H8AAH8AKn8AVX8Af38Aqn8A1H8qAH8qKn8qVX8qf38qqn8q1H9V
AH9VKn9VVX9Vf39Vqn9V1H9/AH9/Kn9/VX9/f39/qn9/1H+qAH+qKn+qVX+q
f3+qqn+q1H/UAH/UKn/UVX/Uf3/Uqn/U1KoAAKoAKqoAVaoAf6oAqqoA1Koq
AKoqKqoqVaoqf6oqqqoq1KpVAKpVKqpVVapVf6pVqqpV1Kp/AKp/Kqp/Vap/
f6p/qqp/1KqqAKqqKqqqVaqqf6qqqqqq1KrUAKrUKqrUVarUf6rUqqrU1NQA
ANQAKtQAVdQAf9QAqtQA1NQqANQqKtQqVdQqf9QqqtQq1NRVANRVKtRVVdRV
f9RVqtRV1NR/ANR/KtR/VdR/f9R/qtR/1NSqANSqKtSqVdSqf9SqqtSq1NTU
ANTUKtTUVdTUf9TUqtTU1AAAAAwMDBkZGSYmJjMzMz8/P0xMTFlZWWZmZnJy
cn9/f4yMjJmZmaWlpbKysr+/v8zMzNjY2OXl5fLy8v/78KCgpICAgP8AAAD/
AP//AAAA//8A/wD//////yH5BAEAAP4ALAAAAAAUABQAAAhXAP0JHOgPgL9/
BBMqFGgQ4cKF/yJKdPhwIL6JESsSxIdvYEaNAjl6pKhRpMCPIDmqRFlSJUeS
IBuCVChzJsGaNhkezDkQZ06fNoHOFBpzJ8+CRnkSHRgQADs=
} -gamma 1.0 -height 0 -width 0
image create photo tplabelT -data {
R0lGODlhFAAUAIACAAAAAIfO6ywAAAAAFAAUAAACL4yPqcsKD6MEiLaK77GG
aw824SZmXUmmy3gybOAl72zCUh2jrQbXFzgJPnjE4qEAADs=
} -gamma 1.0 -height 0 -width 0
image create photo tpbuttonT -data {
R0lGODlhFAAUAMIDAAAAACJOe0Ob9pHG/djY2JHG/ZHG/ZHG/SH+FUNyZWF0
ZWQgd2l0aCBUaGUgR0lNUAAsAAAAABQAFAAAA0lIutz+0I1Jqx1siM17D5kn
cuCijWKpnALgvsAXbrFXCyrB3tyd7zCXzNQT+WYtIwnJoy2JtCDvh0ohqxsq
9rkKeL/gcGRMLicAADs=
} -gamma 1.0 -height 0 -width 0

image create photo tpvars -data {
R0lGODdhFgAWAOe8ABlssxBzvhBzvxBzwBFzvhBzwhFzwBB0vRJzwhF0vBJz
wxF0vRNzwhF0vhNzwxJ0vRN0vRRzxBF1uxF2uBdzxRN1vRJ2uhN2uBZ0xRN3
uRJ4tBV2wBZ2wBN5sxR5sxJ6sBl2xhl2xxN7rhp3xxp3yBx3xxZ7shN9qBN9
qRV8rht4yRR+pxV+pxN/pRt5yRV/pxmAqR98wyB8wxSEmRWEnCF9wx99zRiE
nTJ6uBWHkh2DrRSKihiIlRWKjRWLiRWLjBeLjRaMiBaNhRWOgyCGsxaOhBeO
gyWC0haPgBiOhRqOiBeRfS6ExxeTeBaUcyiG1jCGxxaXbxuTiRmWdBaaZhea
aR+UkhuZbxubaBybby+M3BmgWyqSujCN3RmiViiZhCacehimSxmoSRipRBip
RSWhcDWS4hmrQhyqRxqsPRqsQDaU5BqvOBiwNCCrTjuV4hqxNBiyMCOsUhmz
LBmzLhm0KzuY6DyZ6Bu2Kxq3KBm4Ixi5IBq5Ihm6Hhi8GRm8GRm8Gh24ORq8
Gxy7IBm9Fhm9Fxi+ERi+Exi/Ehi/ExjAExnCGxjDFhjEFyfCIijDIl2owTbB
Plyusmmn1zfIMm2p11Ku+m6q12C4nXKt2Fq2/lu3/mi9nlPLWHyy3FLPTl66
/3S+sHu6xYS23oW33oa43mvKhWHTYHHKjWnRbnrHp2vTb4DJqYfZkaPJ5aTR
1Jvasa3R4ZzdqbjV7LvX7b3Y7a/hv77lztzc3Nnf4tXh6r/tvf//////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
/////////////////////ywAAAAAFgAWAAAI/gBxCRxIsKDBgwJtiTqFKZMr
hAZZyUnyYcYCDR2yoIIoMFKfNFMEiBQgQgmfR7sQOsoT5QUDBANGGmFzxc0t
g5T8+MBQAkCICDEFsEBD5saXgq2cAMFw5A2OJyAUCICABRGiP3RSEQTjAYYK
O6A2rXERQUAKQlatDho4y8sKE0TuaLLUhYSDChcEpbUqS2ApDUWWSOFiRosN
CgUaWICzF9EqgZcE0EjUKJCVERSkimyh5oyYQ4g+CaxEoAciRYwW8TAwsnUA
PYg6CSQl4EfjNk0WtBYQYAwiUwJnCZBQp3EV3a7DGII1UIaAE3HSAnqwW0CG
QngIjhJJxeqcIAGqQKM4xKkgFAE7EBlCUl1kjjIGc8WYsGdLg/YCONA6qIvJ
ECEHtFdDLRx5okMCErS2wSQcERSLKpBIEsorDVZ4UEAAOw==
} -gamma 1.0 -height 0 -width 0
image create photo tptrash -data R0lGODlhFgAWAIUAAPwCBAQCBERGRExOTDQyNISChBQSFCQiJCwuLPT29Nze3GxqbDw6PGxubHR2dJyanLSytJSWlJSSlOzq7Pz6/Nza3Ly6vFRWVBQWFIyKjMTCxHx6fIyOjLS2tOTi5PTy9OTm5Hx+fNTW1KyurKSmpJyenExKTMzKzKSipFxeXCwqLMzOzKyqrMTGxLy+vHRydBwaHNTS1DQ2NAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAAAALAAAAAAWABYAAAb8QIBwSCwaj8KAMoA8LgUDQsFwQByay4RiwWg4GA9IRGk0SCYJSsUCsVwwGQ1EsmESD5xOp+L5gDwhBRIZDhcDdkMGDgEiIxAkJQ8Ok5MmAohDAQ1xJxUlKCUlEg0pKpiZJRoLCxmtCw1eURhOcR4rbQ8cGRwLAwgGtBYTDywtGRKjvQTARgEZLhMcKC0OrQMvAirMRc7CHCTU1g2+20TO0NIn1RwDCya/wdHT1Rnt5LToKOq79trx0tR02YPX7Jm8fRxMOIhSLhOJE/LCJSTlr5kFEBQsWDiR4UGGBgsuHDg1BEYAfTE6oEBR4AIBAiS5yWBAAAGBAyaPGAgCACH+aENyZWF0ZWQgYnkgQk1QVG9HSUYgUHJvIHZlcnNpb24gMi41DQqpIERldmVsQ29yIDE5OTcsMTk5OC4gQWxsIHJpZ2h0cyByZXNlcnZlZC4NCmh0dHA6Ly93d3cuZGV2ZWxjb3IuY29tADs= -gamma 1.0 -height 0 -width 0
image create photo tptree -data {
R0lGODdhGgAYAOf/AC4fDUIeDycyGTwrKEorIx46GQxBFx08IEIzJRtAHVcw
Jk8zJUwzLkY2JBhFITo7KVkyKEI7IUU5NSdEIlQ3IyhHKjZDLidJIBVPHU88
NBtOI0s+OiFNKF07Ll86OCZNLhVTJlNBLyNQKipOKltANkNJMFtBPBpXKjFR
MyRXKy9ULylWMDZTMFZIP2hEMmxDOCRaMzVVNmlGODBXOC1ZM1hMNzBaLh1g
LC1cKjVYPiNfMStdMC1dPDBdNihhLTReMlpRRmVPQk5WQSxhOjxcPUdZPTle
OWFQUllUQjBiNTFhP0NcPj1fNCFnOEdbRDJiQTFkNj9fQDZjPDBlPUJgPExc
SztiQndPTkZfQR9tNjVnOjZmRDRqQT1oOztoQT9nRkhkSzlrPUdnR1VjTUJs
P39ZS3dcRUNrSiR1Q0BtRT1vQU5qUUhtRjR1P0ltUkNwSDV0SnlgTlBsU0Fx
T0twSlZsU05vT19pWUF0RUhzRW1oVkV1UoBjXVRxV3JnaFJzUkV4SXJrU012
VEB7S1B2T21sZEd6S1d2UF5zW096TFN5UoJqXVp3XU58U153WF52Y1Z6X1B8
X4BuX2J2anpwZX9vZU2AUEuBV1V+XGZ4Zl57YFh+VlCBXlaBUlyAU2N9XlyA
ZHN6ZWx9a4V3YFGHXWSBZnN+bVyHWGWEXW6BY4F7aYZ6aWeEaWuDcGKIYFyK
YWWHZXaDd2uIbXSFc26JaI99f4CDdHKIb12QYGSNamSPYIqEcXuKcpaFe2OX
ZZ2GfXWUbIKPg4WPfnyTeXiUhYKTgYyTiJCThIKZf4mYgKWRgquRlq2ThZyX
lZ6XkIafi5Gek4uih5GhiKqblrSclLedoaWip5yqnrGsqp6zpaG0oKK4qr2z
psWzqKy6rq+9sbi6t8O3t8u+rLrIvNXBw8LIvs/FuMXIuMjHvsvIucrOvdbL
vsjPxNHMysjRzMXVu8vUu9HUxMvWxNTTysnXy87Y09rZ0M7exM7d0Njcy9vd
2tbg29ng1ezl0Pnw6fb0+CwAAAAAGgAYAAAI/gD1CRxIsKDBgwTZeQsGLZY3
fPzG1XPnjd43hALZ8WIlC8sSTXJkRQGVI4abPsPUYTQVQwodKa5eibBhY4iI
HzSpIDo3z2C8eyrw4EiixlKYHYBwnfKkSFcXI6VaGeSFIs0lX1qSJNHwo1On
C5uYnAI0ZUWkbQSj0aLTg1OaFFyM2FHBogAKL2lEGJLCAVO2gfL+KEqTZguH
N0SIIEJWJxmsFTR2kOlCSMysgdqAnfLR5gaGFLL0hRsABN6BFVzUvNqUaw+x
gbMO5fGB58SgD3fs6avmod87Go1SkBoxgsekgcVieHHAhkWCOawkLCPHQFmJ
CjBOGEg04dO1gfsYvM34NEbalzNV0Jm4IgNAKCtcmmQh4wqVMILbHlk4lg/S
BycPVMLHAoEUAYkOaGCggyCOZFJQOfoUUkgma4CBBAmS6BGBAEpMAQIcM/Tx
DELgGCOMLavsEsILAaiSih1K8LCGKMZgJJA95nCzSBkKUDCKENHcYiNG3QSR
gR9DDmkOAi20k6SN6zRQQzpPYiSOGXGYUyVCzLggwy9bGlQLAQp0YMI0YQqE
jTXNUBNEL0dsQIkzaQ5kjj//DBkQADs=
} -gamma 1.0 -height 0 -width 0
image create photo tpcut -data R0lGODlhGAAYAIMAAPwCBAQCBAwCBDw+PPz+/OTi5JyanOzq7FRSVGxqbAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAAAALAAAAAAYABgAAARnEMhJq704651DEAF3eaGnDWhlSqs1EIUxUC1QS+8hW3VI5buRqQacaUiroshGUi4lhgBBZ3zaCIjgE0kYJKobpOcVAwtLPgBZy0vbfjD2pOdWx83MeR13V/lucGV+gBUoeFaIiYl2EQAh/mhDcmVhdGVkIGJ5IEJNUFRvR0lGIFBybyB2ZXJzaW9uIDIuNQ0KqSBEZXZlbENvciAxOTk3LDE5OTguIEFsbCByaWdodHMgcmVzZXJ2ZWQuDQpodHRwOi8vd3d3LmRldmVsY29yLmNvbQA7 -gamma 1.0 -height 0 -width 0
image create photo tpcopy -data R0lGODlhFgAWAIUAAPwCBBQSFPz+/DQyNISChDw6PMzKzMTGxERGRIyKjFxaXMTCvKSmpHR2dPz6/Pz29PTq3MS2rPz69MTCxFxWVHx6dJyWjNzSzPz27Pzy7Pzu5PTm3NTKvIR+fJyGfHxuZHxqXNTCtPTq5PTi1PTezNS+rExOTFRORMyylPTaxOzWxOzSvNze3NTOxMy2nMyulMyqjAQCBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAAAALAAAAAAWABYAAAbYQIBwSCwahYGkUnk0BgTQ6IAQaBKfUWhBYKhaAU+CgXAQIAyChLeJzSIQhcH6GFaM0QtGY5kstqEODw8QEQELAhJTc08KBBMEFBUWDRcBE1pca20SGBkaEBscAY5maFRIAgoLHRQRHh8gIQFlZnByqA8ZGSIQIyQjJQEmYgJ5p2ACrK4gJx4gKIZZAgdeAQ4ZI9kjKSor0AwEjeAs1S0cHAslLi4vMDDRWeRIfEsxMeET4ATyVoYLC5fizXEiAR84BeMG+pEm8EsAFhAjSlR4hR6fLxiF0AkCACH+aENyZWF0ZWQgYnkgQk1QVG9HSUYgUHJvIHZlcnNpb24gMi41DQqpIERldmVsQ29yIDE5OTcsMTk5OC4gQWxsIHJpZ2h0cyByZXNlcnZlZC4NCmh0dHA6Ly93d3cuZGV2ZWxjb3IuY29tADs= -gamma 1.0 -height 0 -width 0
image create photo tpbind -data {
R0lGODlhFgAWAOf4ABQCACQYFkMbBDAiGGYZCC4tE0QyOVUwHTk4Mks2KDQ9
KF40G0lCDUNCMFFGD1BKPmFGN1VJQFRKQFVKP1RLPl5JNU5NPlNMO1NMPVxO
O01TPFRUNVhYOnJVGVVaUmdeI49WCGpgE2RhKYlbAJZaAGRgWGxhQJJbGm5g
WJlXM5pcAIFiHZJcKJ1aHo1iAI9eImppKohjFnJqGWFsO41iI45iImxrLo9i
JJJiIJJiIZ9fHHJsIYJqBotlJJVjIXFtKYpnHnBvJntvDXJxIIFrP4hqOpBq
I3NyMYd0BJFwD4dyIZxsIoJxS4J3GXB5QYp2FIl4BHh1Voh2H35zY415BIB6
KoR6NJh2I4V5QphzUHiCHZ11VomAKY97VIF8dad8EnyDTH6HJImCOn2ILYKF
R46GGoSCZYuDSn+FZIuCaZCDYn+HcZ2HO6CEU6WCWYmHeoSQMpKMPa2FM5iN
KqWGUImMb4CUO42LbquFWqKJZKiLS5aQUpeLga6QJ4uUcZOXVa2VHq+PWJGe
KbOVLa+TVrmbHrOdI7eaPKGhPMKWSbOdPqyjLbOiMsGjJbKmR7ymLL2nIram
Q6Wobr6rKcyjVMKnT8imTNijR8mnTMiqNMmnT8ioScmnUMCsP8GvH8ipSM+o
SrWpl8WwJ8CvSL+zNb2vY8G1JcyvU8C3K6SzrMS1QMuzUau3msG8ML24ZLS2
l8iyi6m5pcW7UMO7X9m+H8O5mN67PsTEN9jCEdC2r9TBONPCSs/ETLvEocDC
sbzFpNzNIcvIwtHGz93SN9rQV9DKu+TUJN/VLOPSS9/VQMnPx97YPcnQzcjR
yODZQ+DeLejbOe3dGNXUvtPVwfDaQt3U0/fdSurebdvay+DpMOnhZ+/kPdzd
u+nkYNzc3PToJ9zd3ffpLOHf2ePjvvDsR+/tR+Ti3fbvQeTl3uXl3fDxSP/t
Uufl8PryOe/2NOro4Pv4IffzYf32Se7u3vbuzu313fD12fjz2v//////////
/////////////////////yH5BAEKAP8ALAAAAAAWABYAAAj+AL0JHAjOAyk2
oYINXMiQIQIqhpiIKLEwXcOB3KKogTKpUrJFJqpdZIhmVhskjXo8kieEz8iB
zcY4W6BE1IlSnlqlaThvITMtxvBUyKQDFqRnDMQ1RDdQWRhobiCAapFLUTkb
2F56m0aGmJ4DlFh4Q9HtiCSt3u64iiTg0otaA7T9QMRB2st3G9QVWlJkzodr
VlDFE1Ps5StB5650aNdkFCMewJZN0crqD691MQIRQfZlBLU4vrTOCKHLmpwt
WRK52Abnl1YNqlZIOZWCAAhc7uz00mqhE5BhSUiooAUvG5hxWh+sMnIs3Ldo
5G7t6EJPqwRLOM5weVIGRgFHfehTmHsZgdMNb8ISYLnwpoqpQXnujYygiYbA
AAAMeKszRNYhQiNNgEkNAjWwRwbe2LNGELvYMhIFm+QgkAJOeDGQHzIAMhIG
n/ggUCypsDNQPWY4EBAAOw==
} -gamma 1.0 -height 0 -width 0
image create photo tpprocs -data R0lGODlhFgAWAIYAAAT+BIxSLPyuXFRShPzqrPz+/PT6/PT2/Oz2/Ozy/MzK/OSaVPyWNPz6/OTu/IxeNPzavPyKBNzq/PyCBPyGBOTq/JxmNPzOpLx6PNRqBMSCRNySTPyCDPSGBMxiBKROBOTy/PS2lOyydMxmBJxKBAwODPzevPzm1OyabNzm/Pzy5PTGrOyOXPR+DJxGBPzmzNxuPORqLMReFNTm/Pzq1PSylMyCXKxiNIRKHPzixJRaPFxONMTW/MyCZCwqJDQyLLzW9NTi/HRmTLSKbHROPFxKPMTa/LzW/LTO9MyuhEQuJFRSVLzS9DQyNFRGNLTS9AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAAAALAAAAAAWABYAAAf/gACCg4SFhQEChAOLjI2Lg4gEigUGlQcICAkJAwoDAAELBAyTDQ0GBwcJCA4DDgoPCxAMEYqWl5oJrBKwshMUtaiZmg4VAxYLFwy+tIMDmLgO0RIYyAwU1xmKqbnRDhIaG8kcFB0eH4ogCSDRFRIhIsnXFCMkJYoJFezuJico4+X1CrUiJkFCigsqVrBowWGEC3sCCaZIEeIFBBQwYsh46ElghRkFZ1ygUcPGjQA4SnQyNODjxxo5SuoIsKMEj5UCZ+gUuaKHjh0+fvAAglORziBChtggUuSHER5HkBRtZmRGEiE+lCwxYgQIECZHpgoaMMMI1iZDnn6NKrWjIq5OHtIaYQIEyZEnSNqyVMC3r1+/bps5GtzIkOHDgwwEAgAh/mhDcmVhdGVkIGJ5IEJNUFRvR0lGIFBybyB2ZXJzaW9uIDIuNQ0KqSBEZXZlbENvciAxOTk3LDE5OTguIEFsbCByaWdodHMgcmVzZXJ2ZWQuDQpodHRwOi8vd3d3LmRldmVsY29yLmNvbQA7 -gamma 1.0 -height 0 -width 0
image create photo tpradiobuttonT -data {
R0lGODdhCgAKAKEDAAAAAIKCgofO6////ywAAAAACgAKAAACGpSDYRfjg86b
ojkApsX4be493VNNpGCeBmUUADs=
} -gamma 1.0 -height 0 -width 0
image create photo tpradiobutton -data {
R0lGODdhCgAKAKEDAAAAAIKCgtzc3P///ywAAAAACgAKAAACGpSDYRfjg86b
ojkApsX4be493VNNpGCeBmUUADs=
} -gamma 1.0 -height 0 -width 0
image create photo tppaste -data R0lGODlhFgAWAIYAAPwCBBQWFDw6FHRuFGRaBFxSBAQCBAQKBCQiBIx6HPz6/NTOfKyiXDQuFOTm5Pz+/Ozu7PTq5Pz63PTyxNTOjKSeRExGLMTGxMzKzNTS1NTW1Dw2NKSmpKyqrKSipJyanNzWlLy6ZLSuVIx6FISChIyKhJSSlCQiJLS2tDw6NDQyNCQiFCQmHBQSDGRiZHRydGxubHx6dGxqbFxeXGRmZFxaXCwuLOzq7KyurHx+fDwmFEQuFCweFCQWDBQODBwaHBweHKSinJSWlOTi5JyepHR2dDw6PBQSFNze3ERGRIyKjIyOjISGhPz29Pzy7MS2rMzOzFRWVHx2dHxybDQiFPz27Pzu5PTq3PTm1NTCtJyGdHxuZHxqXPzq3PTaxNS6pFxWVFRKRNS2nPTi1PTStNSulNzOxNSynMymhAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAAAALAAAAAAWABYAAAf/gACCgwABAgMEBYSLggaOjgcICQoLDA2Pj4MGDg8QEZ4FDxITFBUWFxcYGRobjQ8cHR4fCQ8gCyEiFSMWJCUkJieNEB4dKB4pKissK8wrLS4vMDHBAAYQHx8dFx0fJDIzNDU0M+IyHzaNNyg43Ng5Ojs7Ojw9Pj9AMkCNDiZB/h9CSOx4QLCgihItqBkYgqIDESElitAYWJCgkQcXjjRCgi1Ihw4BB5LAQOLCgyQYHihpUU3DBw5ElpAgAYNixSRJjKjQaECDCRPZPDB5IbIGSQwKLnh4wbInLA4kmJB4oaPiAwVNnER40hRK1BIAaVatUZJEFCkmpmjgCeWDCalFe4q4oFKwSRUrEa5gycLzwq8lUnPQ4PEgSpYcUZ5o2cIlS1O/JHLEDdfjQZMIVrpgweLFy5e+M6WSmBGlxYMYYBRzCaOFi5imHWBIfOEiShLTVjaP6eyFTBmN1TA5OvLDjJksWb58OVMGDRqWjAYdmU79SIvpjqJr104nEAAh/mhDcmVhdGVkIGJ5IEJNUFRvR0lGIFBybyB2ZXJzaW9uIDIuNQ0KqSBEZXZlbENvciAxOTk3LDE5OTguIEFsbCByaWdodHMgcmVzZXJ2ZWQuDQpodHRwOi8vd3d3LmRldmVsY29yLmNvbQA7 -gamma 1.0 -height 0 -width 0
image create photo tpcheckbutton -data {
R0lGODdhCwALAKECAAAAAI6Ojv///////ywAAAAACwALAAACG4yPEsLt6xhg
0IGpBNaXcr4t1/hIXSlFmcqyBQA7
} -gamma 1.0 -height 0 -width 0

image create photo checked -data R0lGODlhEAAQAIMAALS2tPwCBLy6vGxubPz+/Ozq7OTm5Nze3AQCBNza3NTW1MzOzMzKzMTCxLy+vAAAACH5BAEAAAEALAAAAAAQABAAAARiEMhJaxAj670DGEQojgTmgUWqrt9JGAdywIZstBgRI/Iutx9CIsErIhQJIEjBNDIVpuCCsTAyrjjQ1cjDDlyNoiPMaygJDgcinV47zgIBIC6vZ+UVSf374fgzAYGCg4SBfhEAIf5oQ3JlYXRlZCBieSBCTVBUb0dJRiBQcm8gdmVyc2lvbiAyLjUNCqkgRGV2ZWxDb3IgMTk5NywxOTk4LiBBbGwgcmlnaHRzIHJlc2VydmVkLg0KaHR0cDovL3d3dy5kZXZlbGNvci5jb20AOw== -gamma 1.0 -height 0 -width 0
image create photo unchecked -data R0lGODlhEAAQAIQAAPwCBIyKjHR2dNza3OTe5Nze3NTW1NTO1MzOzDQyNPz2/PT29PTu9Ozu7Ozm7OTm5MzGzPz+/Pz6/PTy9AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAAAALAAAAAAQABAAAAV3ICCOZCkGaKqmwjkMREG8xnEgSOIqC68wjIbjAdEBAoRFRBJR/BoPR9ElYUp4Qej0mFw2fwyH1BgYOK9gIZE8YPgmCwd0fTIA7/LHo7ANHBqAQWIOBAR9CINRD4WFh4p6jIU5JxCVEAiXlpVGAgmen6CfJqMkfiEAIf5oQ3JlYXRlZCBieSBCTVBUb0dJRiBQcm8gdmVyc2lvbiAyLjUNCqkgRGV2ZWxDb3IgMTk5NywxOTk4LiBBbGwgcmlnaHRzIHJlc2VydmVkLg0KaHR0cDovL3d3dy5kZXZlbGNvci5jb20AOw== -gamma 1.0 -height 0 -width 0


# display main TkproE toplevel window
ShowWindow.tpmain

# eof
#

