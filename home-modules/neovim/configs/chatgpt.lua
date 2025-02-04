local chatgpt = require("chatgpt")

-- Setup
chatgpt.setup({
	openai_params = {
		model = "gpt-4o-mini",
		max_tokens = 4095,
		temperature = 0.2,
	},
	vim.keymap.set("n", "<Space>C", vim.cmd.ChatGPT),
})
