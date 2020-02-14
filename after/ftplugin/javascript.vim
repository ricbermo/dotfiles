" prettier formatting tool
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier', 'eslint']
let g:ale_fixers['javascriptreact'] = ['prettier', 'eslint']

call jspc#init()
