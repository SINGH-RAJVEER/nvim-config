return {
	{
		'zbirenbaum/copilot.lua',
		cmd = 'Copilot',
		event = 'InsertEnter',
		config = function()
			require('copilot').setup {
				suggestion = { enabled = true },
				panel = { enabled = false },
			}
		end,
	},
	{
		'giuxtaposition/blink-cmp-copilot',
	},
	{
		'CopilotC-Nvim/CopilotChat.nvim',
		branch = 'main',
		dependencies = {
			{ 'zbirenbaum/copilot.lua' },
			{ 'nvim-lua/plenary.nvim' },
		},
		build = 'make tiktoken',
		opts = {
			token_source = 'github_cli',
			question_header = '## User ',
			answer_header = '## Copilot ',
			error_header = '## Error ',
			prompts = {
				Explain = 'Please explain how the following code works.',
				Review = 'Please review the following code and provide suggestions for improvement.',
				Tests = 'Please help me write unit tests for this code.',
				Refactor = 'Please refactor the following code to improve its clarity and readability.',
				FixCode = 'Please fix the following code to make it work as intended.',
				FixError = 'Please explain the error in the following code and provide a fix.',
				BetterNamings = 'Please provide better names for the following variables and functions.',
				Documentation = 'Please provide documentation for the following code.',
				SwaggerApi = 'Please provide documentation for the following API using Swagger.',
				SwaggerJsDoc = 'Please provide documentation for the following API using Swagger.',
				Summarize = 'Please summarize the following text.',
				Spelling = 'Please correct any spelling errors in the following text.',
				Wording = 'Please improve the wording of the following text.',
				Concise = 'Please make the following text more concise.',
			},
		},
		keys = {
			{ '<leader>cc', ':CopilotChat<CR>', desc = 'CopilotChat - Toggle' },
			{ '<leader>cp', ':CopilotChatPrompt<CR>', desc = 'CopilotChat - Prompt' },
			{ '<leader>cv', ':CopilotChatVisual<CR>', mode = 'x', desc = 'CopilotChat - Open in visual mode' },
			{ '<leader>cx', ':CopilotChatExplain<CR>', mode = 'x', desc = 'CopilotChat - Explain code' },
			{ '<leader>cf', ':CopilotChatFix<CR>', mode = 'x', desc = 'CopilotChat - Fix code' },
			{ '<leader>cr', ':CopilotChatReview<CR>', mode = 'x', desc = 'CopilotChat - Review code' },
		},
	},
}
