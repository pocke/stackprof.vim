command! Stackprof call stackprof#stackprof()

nmap <Plug>(stackprof-method-open) :<C-u>call stackprof#method()<CR>
