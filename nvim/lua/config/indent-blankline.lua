local ibl = require('ibl')

ibl.setup {
	exclude = {
		filetypes = {
			"lspinfo",       
			"packer",        
			"checkhealth",   
			"help",          
			"man",           
			"NvimTree",      
			"lspsagaoutline",
			"text",          
			"conf",          
			"zsh",           
			"obj",           
			"",              
		}
	},
	scope = {
		enabled = true,
		show_start = false,
		show_end = false,
	},
}
