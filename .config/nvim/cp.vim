set splitright
set splitbelow

function! TermWrapper(command) abort
	if !exists('g:split_term_style') | let g:split_term_style = 'vertical' | endif
	if g:split_term_style ==# 'vertical'
		let buffercmd = '80vnew'
	elseif g:split_term_style ==# 'horizontal'
		let buffercmd = '12new'
	else
		echoerr 'ERROR! g:split_term_style is not a valid value (must be ''horizontal'' or ''vertical'' but is currently set to ''' . g:split_term_style . ''')'
		throw 'ERROR! g:split_term_style is not a valid value (must be ''horizontal'' or ''vertical'')'
	endif

	exec buffercmd
	if exists('g:split_term_resize_cmd')
		exec g:split_term_resize_cmd
	endif
	exec 'term ' . a:command
	exec 'setlocal nornu nonu'
	exec 'startinsert'
	autocmd BufEnter <buffer> startinsert
endfunction


command! -nargs=0 CompileAndRun call TermWrapper(printf("g++ -std=c++17 %s && ./a.out", expand('%')))
command! -nargs=0 CompileAndRunC call TermWrapper(printf("gcc -std=c17 %s && ./a.out", expand('%')))
command! -nargs=0 Runpython call TermWrapper(printf("time python %s", expand('%')))

command! -nargs=1 -complete=file CompileAndRunWithFlag call TermWrapper(printf("g++ -std=c++17 %s %s && time ./a.out", expand('%'), <q-args>))
command! -nargs=1 -complete=file CompileAndRunWithFlagC call TermWrapper(printf("gcc -std=c17 %s %s && time ./a.out ", expand('%'), <q-args>))


autocmd FileType cpp nnoremap <F5> :w<CR>:CompileAndRun<CR>
autocmd FileType c nnoremap <F5> :w<CR>:CompileAndRunC<CR>
autocmd FileType c nnoremap <F6> :w<CR>:CompileAndRunWithFlagC 
autocmd FileType python nnoremap <F6> :w<CR>:Runpython<CR>
