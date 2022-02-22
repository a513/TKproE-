# ClonePath = .tableframeA
# The above line is needed in order to adjust the widget path at load time.
# It contains the pathname of the widget within the template.

proc Startup_TkTable {} {
# Ensure that the table library extension is loaded
global tcl_platform

   if {[string compare unix $tcl_platform(platform)]} {
	set table(library) Tktable2.8[info sharedlibextension]
      } {
	  set table(library) libTktable2.8[info sharedlibextension]
	}
   if {
	   [string match {} [info commands table]]
	&& [catch {package require Tktable 2.8} err]
	&& [catch {load [file join [pwd] $table(library)]} err]
	&& [catch {load [file join [pwd] .. unix $table(library)]} err]
	&& [catch {load [file join [pwd] .. win $table(library)]} err]
      } {
	  error $err
	} { puts "Tktable v[package provide Tktable] loaded" }
}

Startup_TkTable

frame .tableframeA

set TPtemp .tableframeA.table
table $TPtemp \
	-rows 5 \
	-cols 5 \
	-titlerows 1 \
	-titlecols 1 \
	-yscrollcommand {.tableframeA.sy set } \
	-xscrollcommand {.tableframeA.sx set } \
	-flashmode on \
	-selectmode extended \
	-colstretch unset \
	-rowstretch unset \
	-width 5 -height 5

$TPtemp clear tags origin bottomright
$TPtemp tag config rowWhite -bg white
$TPtemp tag config rowGrey -bg grey80
$TPtemp tag config title -fg red -relief raised

scrollbar .tableframeA.sy -command [list $TPtemp yview]
scrollbar .tableframeA.sx -command [list $TPtemp xview] -orient horizontal

pack .tableframeA -fill both -expand 1
pack .tableframeA.sy -side right -fill y
pack $TPtemp -side top -fill both -expand 1
pack .tableframeA.sx -side bottom -fill x
