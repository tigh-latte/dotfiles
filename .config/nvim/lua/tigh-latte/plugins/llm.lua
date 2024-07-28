return {
	"Robitx/gp.nvim",
	config = function()
		require("gp").setup({
			agents = { {
				name = "ChatGPT4o",
				model = { model = "gpt-4o", temperature = 1.1, top_p = 1 },
				chat = true,
				command = false,
				system_prompt = "You are a general AI assistant.\n\n"
					.. "The user provided the additional info about how they would like you to respond:\n\n"
					.. "- If you're unsure don't guess and say you don't know instead.\n"
					.. "- Ask question if you need clarification to provide better answer.\n"
					.. "- Think deeply and carefully from first principles step by step.\n"
					.. "- Zoom out first to see the big picture and then zoom in to details.\n"
					.. "- Use Socratic method to improve your thinking and coding skills.\n"
					.. "- Don't elide any code from your output if the answer requires coding.\n"
					.. "- Take a deep breath; You've got this!\n",
			}, {
				name = "Interview",
				model = { model = "gpt-4o", temperature = 1.1, top_p = 1 },
				chat = true,
				command = false,
				system_prompt = "You are an assistant for helping a person prep for a software developer interview.\n"
					.. "Your client has provided additonal information on how they want you to respond:\n\n"
					.. "- Ask for clarification if needed.\n"
					.. "- Give scripts of how questions can be answered, instead of telling how to answer them.\n"
					..
					"- Make sure you explaination is clear enough so that someone who isn't familiar with the concept of a question can understand it.",
			} },
		})
		vim.keymap.set("n", "<Leader>llm", ":GpChatToggle vsplit<CR>G")
	end,
}
