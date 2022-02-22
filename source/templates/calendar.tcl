# ClonePath = .frame3.frame18
# The above line makes pasting MUCH easier for me.
# It contains the pathname of the cutted widget.

  # build widget .frame3.frame18
  frame .frame3.frame18 \
    -borderwidth {2} \
    -relief {raised} \
    -background {#dcdcdc} \
    -height {30} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -width {30}

  # build widget .frame3.frame18.frame19
  frame .frame3.frame18.frame19 \
    -background {#dcdcdc} \
    -height {20} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -width {280}

  # build widget .frame3.frame18.frame19.canvas20
  canvas .frame3.frame18.frame19.canvas20 \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -height {16} \
    -highlightbackground {#ffffff} \
    -highlightcolor {#000000} \
    -insertbackground {black} \
    -relief {raised} \
    -selectbackground {black} \
    -selectforeground {#fffff0} \
    -width {16}
  # bindings
  bind .frame3.frame18.frame19.canvas20 <Button-1> {%W configure -relief sunken -background gray90}
  bind .frame3.frame18.frame19.canvas20 <ButtonRelease-1> {if {"[winfo containing %X %Y]" == "%W"} {
    calendar_addmonths -1
  }
%W configure -relief raised -background #dcdcdc}

  # build widget .frame3.frame18.frame19.label21
  label .frame3.frame18.frame19.label21 \
    -activebackground {#dcdcdc} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {0} \
    -font {Helvetica 10 bold} \
    -foreground {#000000} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -text {Jan 2000} \
    -textvariable {calMonth} \
    -width {12}

  # build widget .frame3.frame18.frame19.canvas22
  canvas .frame3.frame18.frame19.canvas22 \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -height {16} \
    -highlightbackground {#ffffff} \
    -highlightcolor {#000000} \
    -insertbackground {black} \
    -relief {raised} \
    -selectbackground {black} \
    -selectforeground {#fffff0} \
    -width {16}
  # bindings
  bind .frame3.frame18.frame19.canvas22 <Button-1> {%W configure -relief sunken -background gray90}
  bind .frame3.frame18.frame19.canvas22 <ButtonRelease-1> {if {"[winfo containing %X %Y]" == "%W"} {
    calendar_addmonths 1
  }
%W configure -relief raised -background #dcdcdc}

  # build widget .frame3.frame18.frame23
  frame .frame3.frame18.frame23 \
    -background {#dcdcdc} \
    -height {27} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -width {165}

  # build widget .frame3.frame18.frame23.button24
  button .frame3.frame18.frame23.button24 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -command {calendar_selDay $cday(1)} \
    -font {Helvetica 10} \
    -foreground {#000000} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -state {disabled} \
    -textvariable {cday(1)} \
    -width {2}

  # build widget .frame3.frame18.frame23.button25
  button .frame3.frame18.frame23.button25 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -command {calendar_selDay $cday(2)} \
    -font {Helvetica 10} \
    -foreground {#000000} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -state {disabled} \
    -textvariable {cday(2)} \
    -width {2}

  # build widget .frame3.frame18.frame23.button26
  button .frame3.frame18.frame23.button26 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -command {calendar_selDay $cday(3)} \
    -font {Helvetica 10} \
    -foreground {#000000} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -state {disabled} \
    -textvariable {cday(3)} \
    -width {2}

  # build widget .frame3.frame18.frame23.button27
  button .frame3.frame18.frame23.button27 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -command {calendar_selDay $cday(4)} \
    -font {Helvetica 10} \
    -foreground {#000000} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -state {disabled} \
    -textvariable {cday(4)} \
    -width {2}

  # build widget .frame3.frame18.frame23.button28
  button .frame3.frame18.frame23.button28 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -command {calendar_selDay $cday(5)} \
    -font {Helvetica 10} \
    -foreground {#000000} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -state {disabled} \
    -textvariable {cday(5)} \
    -width {2}

  # build widget .frame3.frame18.frame23.button29
  button .frame3.frame18.frame23.button29 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -command {calendar_selDay $cday(6)} \
    -font {Helvetica 10} \
    -foreground {#000000} \
    -highlightbackground {red} \
    -highlightcolor {blue} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -state {disabled} \
    -textvariable {cday(6)} \
    -width {2}

  # build widget .frame3.frame18.frame23.button30
  button .frame3.frame18.frame23.button30 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -command {calendar_selDay $cday(7)} \
    -font {Helvetica 10} \
    -foreground {#000000} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -text {1} \
    -textvariable {cday(7)} \
    -width {2}

  # build widget .frame3.frame18.frame31
  frame .frame3.frame18.frame31 \
    -background {#dcdcdc} \
    -height {27} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -width {165}

  # build widget .frame3.frame18.frame31.button24
  button .frame3.frame18.frame31.button24 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -command {calendar_selDay $cday(8)} \
    -font {Helvetica 10} \
    -foreground {#000000} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -text {2} \
    -textvariable {cday(8)} \
    -width {2}

  # build widget .frame3.frame18.frame31.button25
  button .frame3.frame18.frame31.button25 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -command {calendar_selDay $cday(9)} \
    -font {Helvetica 10} \
    -foreground {#000000} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -text {3} \
    -textvariable {cday(9)} \
    -width {2}

  # build widget .frame3.frame18.frame31.button26
  button .frame3.frame18.frame31.button26 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -command {calendar_selDay $cday(10)} \
    -font {Helvetica 10} \
    -foreground {#000000} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -text {4} \
    -textvariable {cday(10)} \
    -width {2}

  # build widget .frame3.frame18.frame31.button27
  button .frame3.frame18.frame31.button27 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -command {calendar_selDay $cday(11)} \
    -font {Helvetica 10} \
    -foreground {#000000} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -text {5} \
    -textvariable {cday(11)} \
    -width {2}

  # build widget .frame3.frame18.frame31.button28
  button .frame3.frame18.frame31.button28 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -command {calendar_selDay $cday(12)} \
    -font {Helvetica 10} \
    -foreground {#000000} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -text {6} \
    -textvariable {cday(12)} \
    -width {2}

  # build widget .frame3.frame18.frame31.button29
  button .frame3.frame18.frame31.button29 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -command {calendar_selDay $cday(13)} \
    -font {Helvetica 10} \
    -foreground {#000000} \
    -highlightbackground {red} \
    -highlightcolor {blue} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -text {7} \
    -textvariable {cday(13)} \
    -width {2}

  # build widget .frame3.frame18.frame31.button30
  button .frame3.frame18.frame31.button30 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -command {calendar_selDay $cday(14)} \
    -font {Helvetica 10} \
    -foreground {#000000} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -text {8} \
    -textvariable {cday(14)} \
    -width {2}

  # build widget .frame3.frame18.frame32
  frame .frame3.frame18.frame32 \
    -background {#dcdcdc} \
    -height {27} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -width {165}

  # build widget .frame3.frame18.frame32.button24
  button .frame3.frame18.frame32.button24 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -command {calendar_selDay $cday(15)} \
    -font {Helvetica 10} \
    -foreground {#000000} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -text {9} \
    -textvariable {cday(15)} \
    -width {2}

  # build widget .frame3.frame18.frame32.button25
  button .frame3.frame18.frame32.button25 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -command {calendar_selDay $cday(16)} \
    -font {Helvetica 10} \
    -foreground {#000000} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -text {10} \
    -textvariable {cday(16)} \
    -width {2}

  # build widget .frame3.frame18.frame32.button26
  button .frame3.frame18.frame32.button26 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -command {calendar_selDay $cday(17)} \
    -font {Helvetica 10} \
    -foreground {#000000} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -text {11} \
    -textvariable {cday(17)} \
    -width {2}

  # build widget .frame3.frame18.frame32.button27
  button .frame3.frame18.frame32.button27 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -command {calendar_selDay $cday(18)} \
    -font {Helvetica 10} \
    -foreground {#000000} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -text {12} \
    -textvariable {cday(18)} \
    -width {2}

  # build widget .frame3.frame18.frame32.button28
  button .frame3.frame18.frame32.button28 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -command {calendar_selDay $cday(19)} \
    -font {Helvetica 10} \
    -foreground {#000000} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -text {13} \
    -textvariable {cday(19)} \
    -width {2}

  # build widget .frame3.frame18.frame32.button29
  button .frame3.frame18.frame32.button29 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -command {calendar_selDay $cday(20)} \
    -font {Helvetica 10} \
    -foreground {#000000} \
    -highlightbackground {red} \
    -highlightcolor {blue} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -text {14} \
    -textvariable {cday(20)} \
    -width {2}

  # build widget .frame3.frame18.frame32.button30
  button .frame3.frame18.frame32.button30 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -command {calendar_selDay $cday(21)} \
    -font {Helvetica 10} \
    -foreground {#000000} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -text {15} \
    -textvariable {cday(21)} \
    -width {2}

  # build widget .frame3.frame18.frame33
  frame .frame3.frame18.frame33 \
    -background {#dcdcdc} \
    -height {27} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -width {165}

  # build widget .frame3.frame18.frame33.button24
  button .frame3.frame18.frame33.button24 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -command {calendar_selDay $cday(22)} \
    -font {Helvetica 10} \
    -foreground {#000000} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -text {16} \
    -textvariable {cday(22)} \
    -width {2}

  # build widget .frame3.frame18.frame33.button25
  button .frame3.frame18.frame33.button25 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -command {calendar_selDay $cday(23)} \
    -font {Helvetica 10} \
    -foreground {#000000} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {solid} \
    -text {17} \
    -textvariable {cday(23)} \
    -width {2}

  # build widget .frame3.frame18.frame33.button26
  button .frame3.frame18.frame33.button26 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -command {calendar_selDay $cday(24)} \
    -font {Helvetica 10} \
    -foreground {#000000} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -text {18} \
    -textvariable {cday(24)} \
    -width {2}

  # build widget .frame3.frame18.frame33.button27
  button .frame3.frame18.frame33.button27 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -command {calendar_selDay $cday(25)} \
    -font {Helvetica 10} \
    -foreground {#000000} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -text {19} \
    -textvariable {cday(25)} \
    -width {2}

  # build widget .frame3.frame18.frame33.button28
  button .frame3.frame18.frame33.button28 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -command {calendar_selDay $cday(26)} \
    -font {Helvetica 10} \
    -foreground {#000000} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -text {20} \
    -textvariable {cday(26)} \
    -width {2}

  # build widget .frame3.frame18.frame33.button29
  button .frame3.frame18.frame33.button29 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -command {calendar_selDay $cday(27)} \
    -font {Helvetica 10} \
    -foreground {#000000} \
    -highlightbackground {red} \
    -highlightcolor {blue} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -text {21} \
    -textvariable {cday(27)} \
    -width {2}

  # build widget .frame3.frame18.frame33.button30
  button .frame3.frame18.frame33.button30 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -command {calendar_selDay $cday(28)} \
    -font {Helvetica 10} \
    -foreground {#000000} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -text {22} \
    -textvariable {cday(28)} \
    -width {2}

  # build widget .frame3.frame18.frame34
  frame .frame3.frame18.frame34 \
    -background {#dcdcdc} \
    -height {27} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -width {165}

  # build widget .frame3.frame18.frame34.button24
  button .frame3.frame18.frame34.button24 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -command {calendar_selDay $cday(29)} \
    -font {Helvetica 10} \
    -foreground {#000000} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -text {23} \
    -textvariable {cday(29)} \
    -width {2}

  # build widget .frame3.frame18.frame34.button25
  button .frame3.frame18.frame34.button25 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -command {calendar_selDay $cday(30)} \
    -font {Helvetica 10} \
    -foreground {#000000} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -text {24} \
    -textvariable {cday(30)} \
    -width {2}

  # build widget .frame3.frame18.frame34.button26
  button .frame3.frame18.frame34.button26 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -command {calendar_selDay $cday(31)} \
    -font {Helvetica 10} \
    -foreground {#000000} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -text {25} \
    -textvariable {cday(31)} \
    -width {2}

  # build widget .frame3.frame18.frame34.button27
  button .frame3.frame18.frame34.button27 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -command {calendar_selDay $cday(32)} \
    -font {Helvetica 10} \
    -foreground {#000000} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -text {26} \
    -textvariable {cday(32)} \
    -width {2}

  # build widget .frame3.frame18.frame34.button28
  button .frame3.frame18.frame34.button28 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -command {calendar_selDay $cday(33)} \
    -font {Helvetica 10} \
    -foreground {#000000} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -text {27} \
    -textvariable {cday(33)} \
    -width {2}

  # build widget .frame3.frame18.frame34.button29
  button .frame3.frame18.frame34.button29 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -command {calendar_selDay $cday(34)} \
    -font {Helvetica 10} \
    -foreground {#000000} \
    -highlightbackground {red} \
    -highlightcolor {blue} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -text {28} \
    -textvariable {cday(34)} \
    -width {2}

  # build widget .frame3.frame18.frame34.button30
  button .frame3.frame18.frame34.button30 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -command {calendar_selDay $cday(35)} \
    -font {Helvetica 10} \
    -foreground {#000000} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -text {29} \
    -textvariable {cday(35)} \
    -width {2}

  # build widget .frame3.frame18.frame43
  frame .frame3.frame18.frame43 \
    -background {#dcdcdc} \
    -height {27} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -width {165}

  # build widget .frame3.frame18.frame43.button24
  button .frame3.frame18.frame43.button24 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -font {Helvetica 10 bold} \
    -foreground {#000000} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -text {Su} \
    -width {2}

  # build widget .frame3.frame18.frame43.button25
  button .frame3.frame18.frame43.button25 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -font {Helvetica 10 bold} \
    -foreground {#000000} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -text {M} \
    -width {2}

  # build widget .frame3.frame18.frame43.button26
  button .frame3.frame18.frame43.button26 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -font {Helvetica 10 bold} \
    -foreground {#000000} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -text {Tu} \
    -width {2}

  # build widget .frame3.frame18.frame43.button27
  button .frame3.frame18.frame43.button27 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -font {Helvetica 10 bold} \
    -foreground {#000000} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -text {W} \
    -width {2}

  # build widget .frame3.frame18.frame43.button28
  button .frame3.frame18.frame43.button28 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -font {Helvetica 10 bold} \
    -foreground {#000000} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -text {Th} \
    -width {2}

  # build widget .frame3.frame18.frame43.button29
  button .frame3.frame18.frame43.button29 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -font {Helvetica 10 bold} \
    -foreground {#000000} \
    -highlightbackground {red} \
    -highlightcolor {blue} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -text {F} \
    -width {2}

  # build widget .frame3.frame18.frame43.button30
  button .frame3.frame18.frame43.button30 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -font {Helvetica 10 bold} \
    -foreground {#000000} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -text {Sa} \
    -width {2}

  # build widget .frame3.frame18.frame44
  frame .frame3.frame18.frame44 \
    -background {#dcdcdc} \
    -height {27} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -width {165}

  # build widget .frame3.frame18.frame44.button24
  button .frame3.frame18.frame44.button24 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -font {Helvetica 10} \
    -foreground {#000000} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -text {30} \
    -textvariable {cday(36)} \
    -width {2}

  # build widget .frame3.frame18.frame44.button25
  button .frame3.frame18.frame44.button25 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -font {Helvetica 10} \
    -foreground {#000000} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -text {31} \
    -textvariable {cday(37)} \
    -width {2}

  # build widget .frame3.frame18.frame44.button26
  button .frame3.frame18.frame44.button26 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -font {Helvetica 10} \
    -foreground {#000000} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -state {disabled} \
    -textvariable {cday(38)} \
    -width {2}

  # build widget .frame3.frame18.frame44.button27
  button .frame3.frame18.frame44.button27 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -font {Helvetica 10} \
    -foreground {#000000} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -state {disabled} \
    -textvariable {cday(39)} \
    -width {2}

  # build widget .frame3.frame18.frame44.button28
  button .frame3.frame18.frame44.button28 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -font {Helvetica 10} \
    -foreground {#000000} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -state {disabled} \
    -textvariable {cday(40)} \
    -width {2}

  # build widget .frame3.frame18.frame44.button29
  button .frame3.frame18.frame44.button29 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -font {Helvetica 10} \
    -foreground {#000000} \
    -highlightbackground {red} \
    -highlightcolor {blue} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -state {disabled} \
    -textvariable {cday(41)} \
    -width {2}

  # build widget .frame3.frame18.frame44.button30
  button .frame3.frame18.frame44.button30 \
    -activebackground {gray75} \
    -activeforeground {#000000} \
    -background {#dcdcdc} \
    -borderwidth {1} \
    -font {Helvetica 10} \
    -foreground {#000000} \
    -highlightbackground {#dcdcdc} \
    -highlightcolor {#000000} \
    -highlightthickness {0} \
    -padx 2 -pady 0 \
    -relief {flat} \
    -state {disabled} \
    -textvariable {cday(42)} \
    -width {2}

  # pack master .frame3.frame18.frame19
  pack configure .frame3.frame18.frame19.canvas20 \
    -side left
  pack configure .frame3.frame18.frame19.label21 \
    -expand 1 \
    -side left
  pack configure .frame3.frame18.frame19.canvas22 \
    -side right

  # pack master .frame3.frame18.frame23
  pack configure .frame3.frame18.frame23.button24 \
    -side left
  pack configure .frame3.frame18.frame23.button25 \
    -side left
  pack configure .frame3.frame18.frame23.button26 \
    -side left
  pack configure .frame3.frame18.frame23.button27 \
    -side left
  pack configure .frame3.frame18.frame23.button28 \
    -side left
  pack configure .frame3.frame18.frame23.button29 \
    -side left
  pack configure .frame3.frame18.frame23.button30 \
    -side left

  # pack master .frame3.frame18.frame31
  pack configure .frame3.frame18.frame31.button24 \
    -side left
  pack configure .frame3.frame18.frame31.button25 \
    -side left
  pack configure .frame3.frame18.frame31.button26 \
    -side left
  pack configure .frame3.frame18.frame31.button27 \
    -side left
  pack configure .frame3.frame18.frame31.button28 \
    -side left
  pack configure .frame3.frame18.frame31.button29 \
    -side left
  pack configure .frame3.frame18.frame31.button30 \
    -side left

  # pack master .frame3.frame18.frame32
  pack configure .frame3.frame18.frame32.button24 \
    -side left
  pack configure .frame3.frame18.frame32.button25 \
    -side left
  pack configure .frame3.frame18.frame32.button26 \
    -side left
  pack configure .frame3.frame18.frame32.button27 \
    -side left
  pack configure .frame3.frame18.frame32.button28 \
    -side left
  pack configure .frame3.frame18.frame32.button29 \
    -side left
  pack configure .frame3.frame18.frame32.button30 \
    -side left

  # pack master .frame3.frame18.frame33
  pack configure .frame3.frame18.frame33.button24 \
    -side left
  pack configure .frame3.frame18.frame33.button25 \
    -side left
  pack configure .frame3.frame18.frame33.button26 \
    -side left
  pack configure .frame3.frame18.frame33.button27 \
    -side left
  pack configure .frame3.frame18.frame33.button28 \
    -side left
  pack configure .frame3.frame18.frame33.button29 \
    -side left
  pack configure .frame3.frame18.frame33.button30 \
    -side left

  # pack master .frame3.frame18.frame34
  pack configure .frame3.frame18.frame34.button24 \
    -side left
  pack configure .frame3.frame18.frame34.button25 \
    -side left
  pack configure .frame3.frame18.frame34.button26 \
    -side left
  pack configure .frame3.frame18.frame34.button27 \
    -side left
  pack configure .frame3.frame18.frame34.button28 \
    -side left
  pack configure .frame3.frame18.frame34.button29 \
    -side left
  pack configure .frame3.frame18.frame34.button30 \
    -side left

  # pack master .frame3.frame18.frame43
  pack configure .frame3.frame18.frame43.button24 \
    -side left
  pack configure .frame3.frame18.frame43.button25 \
    -side left
  pack configure .frame3.frame18.frame43.button26 \
    -side left
  pack configure .frame3.frame18.frame43.button27 \
    -side left
  pack configure .frame3.frame18.frame43.button28 \
    -side left
  pack configure .frame3.frame18.frame43.button29 \
    -side left
  pack configure .frame3.frame18.frame43.button30 \
    -side left

  # pack master .frame3.frame18.frame44
  pack configure .frame3.frame18.frame44.button24 \
    -side left
  pack configure .frame3.frame18.frame44.button25 \
    -side left
  pack configure .frame3.frame18.frame44.button26 \
    -side left
  pack configure .frame3.frame18.frame44.button27 \
    -side left
  pack configure .frame3.frame18.frame44.button28 \
    -side left
  pack configure .frame3.frame18.frame44.button29 \
    -side left
  pack configure .frame3.frame18.frame44.button30 \
    -side left

  # pack master .frame3.frame18
  pack configure .frame3.frame18.frame19 \
    -fill x
  pack configure .frame3.frame18.frame43
  pack configure .frame3.frame18.frame23
  pack configure .frame3.frame18.frame31
  pack configure .frame3.frame18.frame32
  pack configure .frame3.frame18.frame33
  pack configure .frame3.frame18.frame34
  pack configure .frame3.frame18.frame44

  # pack slave .frame3.frame18
  pack configure .frame3.frame18 \
    -fill x

  # build canvas items .frame3.frame18.frame19.canvas20
  set xfTmpTag [.frame3.frame18.frame19.canvas20 create polygon 15.0 5.0 15.0 16.0 6.0 11.0]
  # build canvas items .frame3.frame18.frame19.canvas22
  set xfTmpTag [.frame3.frame18.frame19.canvas22 create polygon 6.0 6.0 6.0 15.0 16.0 10.0]
  .frame3.frame18.frame19.canvas22 itemconfigure $xfTmpTag \
    -outline {black}


# end of widget tree

proc calendar_addmonths { num} {
# This procedure advances the calendar by num months.
#
# The value of num may be either a positive or negative integer.
#
global curmonth
global curyear
global calMonth

if {$num < 0} {
    set suffix "ago"
    set num [expr abs($num)]
   } { set suffix {} }
set datestr "$curmonth/01/$curyear"
foreach {month curmonth curyear} [clock format [clock scan "$datestr $num months $suffix"] -format "%b %m %Y"] {}
set calMonth "$month $curyear"
calendar_fillMonth $curmonth $curyear
}


# Procedure: calendar_fillMonth
proc calendar_fillMonth { newmonth newyear} {
# This procedure configures the calendar display given the month, year
#
global caloffset
global cday
global curDay

set datestr "$newmonth/01/$newyear"
set dayofweek [clock format [clock scan $datestr] -format "%a"]
set offset $caloffset($dayofweek)
for {set ctr 1} {$ctr <= $offset} {incr ctr} {
      set cday($ctr) ""
    }
set dayofmonth 1
while {$ctr < 43} {
	set datestr "$newmonth/$dayofmonth/$newyear"
	if {[catch {clock scan $datestr}]} {
	   set cday($ctr) ""
	  } { set cday($ctr) $dayofmonth }
	incr ctr
	incr dayofmonth
        }
calendar_selDay $curDay
}


# Procedure: calendar_selDay
proc calendar_selDay { idx} {
# This procedure selects and highlights a specific day of the month
#
global cday
global curDay

if {$idx == ""} { return }
set winlist [winfo children .frame3.frame18.frame23]
append winlist " "
append winlist [winfo children .frame3.frame18.frame31]
append winlist " "
append winlist [winfo children .frame3.frame18.frame32]
append winlist " "
append winlist [winfo children .frame3.frame18.frame33]
append winlist " "
append winlist [winfo children .frame3.frame18.frame34]
append winlist " "
append winlist [winfo children .frame3.frame18.frame44]
foreach window $winlist {
	$window configure -state normal
	set varname [$window cget -textvariable]
	set value [set $varname]
	if {$value == $idx} {
	   $window configure -relief solid
	   set curDay $idx
	  } { $window configure -relief flat }
	if {$value == ""} { $window configure -state disabled }
         }
}

  global {calMonth}
  set {calMonth} [clock format [clock seconds] -format {%b %Y}]
  global {caloffset}
  set {caloffset(Fri)} {5}
  set {caloffset(Mon)} {1}
  set {caloffset(Sat)} {6}
  set {caloffset(Sun)} {0}
  set {caloffset(Thu)} {4}
  set {caloffset(Tue)} {2}
  set {caloffset(Wed)} {3}
  global {cday}
  set {cday(1)} {}
  set {cday(10)} {4}
  set {cday(11)} {5}
  set {cday(12)} {6}
  set {cday(13)} {7}
  set {cday(14)} {8}
  set {cday(15)} {9}
  set {cday(16)} {10}
  set {cday(17)} {11}
  set {cday(18)} {12}
  set {cday(19)} {13}
  set {cday(2)} {}
  set {cday(20)} {14}
  set {cday(21)} {15}
  set {cday(22)} {16}
  set {cday(23)} {17}
  set {cday(24)} {18}
  set {cday(25)} {19}
  set {cday(26)} {20}
  set {cday(27)} {21}
  set {cday(28)} {22}
  set {cday(29)} {23}
  set {cday(3)} {}
  set {cday(30)} {24}
  set {cday(31)} {25}
  set {cday(32)} {26}
  set {cday(33)} {27}
  set {cday(34)} {28}
  set {cday(35)} {29}
  set {cday(36)} {30}
  set {cday(37)} {31}
  set {cday(38)} {}
  set {cday(39)} {}
  set {cday(4)} {}
  set {cday(40)} {}
  set {cday(41)} {}
  set {cday(42)} {}
  set {cday(5)} {}
  set {cday(6)} {}
  set {cday(7)} {1}
  set {cday(8)} {2}
  set {cday(9)} {3}
  global {curDay}
  set {curDay} [clock format [clock seconds] -format %e]
  global {curMonth}
  set {curMonth} [clock format [clock seconds] -format %B]
  global {curmonth}
  set {curmonth} [clock format [clock seconds] -format %m]
  global {curyear}
  set {curyear} [clock format [clock seconds] -format %Y]

calendar_fillMonth $curmonth $curyear