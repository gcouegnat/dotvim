" Vim syntax file

if exists("b:current_syntax")
  finish
endif

" zebulon comment lines
syntax match zebulonComment "^#.*$"

" zebulon keyword lines
syn match zebulonKeyword4 "^\s*\*\*\*\*\w\+"
syn match zebulonKeyword3 "^\s*\*\*\*\w\+"
syn match zebulonKeyword2 "^\s*\*\*\w\+" 
syn match zebulonKeyword1 "^\s*\*\w\+"

let b:current_syntax = "zebulon"

hi link zebulonComment  Comment

hi link zebulonKeyword4 Keyword
hi link zebulonKeyword3 Identifier
hi link zebulonKeyword2 Macro
hi link zebulonKeyword1 String
