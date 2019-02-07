" Vim syntax file
" filetype: ledger
" by Johann Klähn; Use according to the terms of the GPL>=2.
" by Stefan Karrmann; Use according to the terms of the GPL>=2.
" by Wolfgang Oertl; Use according to the terms of the GPL>=2.
" vim:ts=2:sw=2:sts=2:foldmethod=marker

if version < 600
  syntax clear
elseif exists("b:current_sytax")
  finish
endif

" Force old regex engine (:help two-engines)
let s:oe = v:version < 704 ? '' : '\%#=1'
let s:lb1 = v:version < 704 ? '\@<=' : '\@1<='

" for debugging
syntax clear

" DATE[=EDATE] [*|!] [(CODE)] DESC <-- first line of transaction
"   ACCOUNT AMOUNT [; NOTE]  <-- posting

syn region ledgerTransaction start=/^[[:digit:]~=]/ skip=/^\s/ end=/^/ fold keepend transparent contains=ledgerTransactionDate,ledgerMetadata,ledgerPosting,ledgerTransactionExpression
syn match ledgerTransactionDate /^\d\S\+/ contained
syn match ledgerTransactionExpression /^[=~]\s\+\zs.*/ contained
syn match ledgerPosting /^\s\+[^[:blank:];][^;]*\ze\%($\|;\)/
    \ contained transparent contains=ledgerAccount,ledgerAmount,ledgerMetadata
" every space in an account name shall be surrounded by two non-spaces
" every account name ends with a tab, two spaces or the end of the line
exe 'syn match ledgerAccount '.
  \ '/'.s:oe.'^\s\+\zs\%(\S'.s:lb1.' \S\|\S\)\+\ze\%(  \|\t\|\s*$\)/ contained'
exe 'syn match ledgerAmount '.
  \ '/'.s:oe.'\S'.s:lb1.'\%(  \|\t\)\s*\zs\%([^;[:space:]]\|\s\+[^;[:space:]]\)\+/ contained'

let b:current_syntax = "ledger"
