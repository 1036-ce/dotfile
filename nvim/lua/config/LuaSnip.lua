local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.conditions")
local conds_expand = require("luasnip.extras.conditions.expand")

ls.setup({
	history = true,
	-- Update more often, :h events for more info.
	update_events = "TextChanged,TextChangedI",
	-- Snippets aren't automatically removed if their text is deleted.
	-- `delete_check_events` determines on which events (:h events) a check for
	-- deleted snippets is performed.
	-- This can be especially useful when `history` is enabled.
	delete_check_events = "TextChanged",
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { "choiceNode", "Comment" } },
			},
		},
	},
	-- treesitter-hl has 100, use something higher (default is 200).
	ext_base_prio = 300,
	-- minimal increase in priority.
	ext_prio_increase = 1,
	enable_autosnippets = true,
	-- mapping for cutting selected text so it's usable as SELECT_DEDENT,
	-- SELECT_RAW or TM_SELECTED_TEXT (mapped via xmap).
	store_selection_keys = "<Tab>",
	-- luasnip uses this function to get the currently active filetype. This
	-- is the (rather uninteresting) default, but it's possible to use
	-- eg. treesitter for getting the current filetype by setting ft_func to
	-- require("luasnip.extras.filetype_functions").from_cursor (requires
	-- `nvim-treesitter/nvim-treesitter`). This allows correctly resolving
	-- the current filetype in eg. a markdown-code block or `vim.cmd()`.
	ft_func = function()
		return vim.split(vim.bo.filetype, ".", true)
	end,
})

local function copy(args)
	return args[1]
end

ls.add_snippets("cpp", {
	s("leetcode", fmt([[
	#include <iostream>
	#include <vector>
	#include <string>

	using namespace std;

	class Solution {{
		public:
			{}
	}};

	int main() {{
		return 0;
	}}
	]], {
		i(1, "")
	})),
	s("class", fmt([[
	class {} {{
		public:
			{}({});
			~{}({});
		private:
	}};
	]], {
		i(1, "ClassName"),
		f(copy, 1),
		i(2),
		f(copy, 1),
		i(3)
	})),
	s("struct", fmt([[
	struct {} {{
		{}
	}};
	]], {
		i(1, "StructName"),
		i(2, "")
	})),
	s("incc",
	fmt("#include <{}>", {
		i(1, "iostream")
	})),
	s("print_str", fmt([[ 
	std::cout << "{1}" << std::endl;
	]], {
		i(1, ""),
	})),
	s("print_var", fmt([[ 
	std::cout << {} << std::endl;
	]], {
		i(1, "")
	})),
	s("mainn", fmt([[ 
	int main() {{
		{1}
		return 0;
	}}
	]], {
		i(1, "")
	})),
})

-- args is a table, where 1 is the text in Placeholder 1, 2 the text in
-- placeholder 2,...

ls.add_snippets("cpp", {
	s("for", {
		t("for ("),
		i(1, "int "),
		i(2, "i"),
		t(" = 0; "),
		f(copy, 2),
		t(" < "),
		i(3, "length"),
		t("; "),
		t("++"),
		f(copy, 2),
		t({") {", "\t"}),
		i(4),
		t({"", "}"}),
	}),
})

ls.add_snippets("markdown", {
	s("img", fmt([[ 
	![{}]({})
	]], {
		i(1, "alt text"),
		i(2, "image path")
	})),
	s("code", fmt([[ 
	```{}
	{}
	```
	]], {
		i(1, "cpp"),
		i(2)
	}))
})
