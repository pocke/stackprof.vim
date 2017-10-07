let s:self_path=expand("<sfile>")
execute 'rubyfile ' . s:self_path . '.rb'

function! stackprof#stackprof() abort
  ruby StackprofVim.stackprof
endfunction

function! stackprof#method() abort
  ruby <<RUBY
    StackprofVim.stackprof(method: StackprofVim.line_to_method)
RUBY
endfunction
