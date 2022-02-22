# ClonePath = .text
# The above line makes pasting MUCH easier for me.
# It contains the pathname of the cutted widget.

# The symbolic names.
global symbolicName

  # build widget .text1
  text .text1 \
    -relief {ridge} \
    -borderwidth 2 \
    -background white \
    -wrap {none}
  # bindings
  bind .text1 <Any-Key> {} 

  # pack widgets
  pack .text1

# end of widget tree

