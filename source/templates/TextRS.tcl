# ClonePath = .frame
# The above line makes pasting MUCH easier for me.
# It contains the pathname of the cutted widget.

# The symbolic names.
global symbolicName

  # build widget .frame
  frame .frame \
    -relief {raised}

  # build widget .frame.scrollbar1
  scrollbar .frame.scrollbar1 \
    -command {.frame.text2 yview} \
    -relief {raised}

  # build widget .frame.text2
  text .frame.text2 \
    -relief {ridge} \
    -borderwidth 2 \
    -background white \
    -yscrollcommand {.frame.scrollbar1 set} \
    -wrap {none}

  # pack widget .frame
  pack append .frame \
    .frame.scrollbar1   {right frame center filly} \
    .frame.text2   {top frame center expand fill}

  # pack widgets
  pack .frame

# end of widget tree

