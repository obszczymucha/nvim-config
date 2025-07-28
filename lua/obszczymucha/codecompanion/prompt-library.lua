local constants = {
  LLM_ROLE = "llm",
  USER_ROLE = "user",
  SYSTEM_ROLE = "system",
}

return {
  [ "Code Workflow" ] = {
    strategy = "workflow",
    description = "Use a workflow to guide an LLM in writing code",
    opts = {
      index = 2,
      is_default = false,
      short_name = "cw",
    },
    prompts = {
      {
        -- We can group prompts together to make a workflow
        -- This is the first prompt in the workflow
        {
          role = constants.SYSTEM_ROLE,
          content = function( context )
            return string.format(
              "You carefully provide accurate, factual, thoughtful, nuanced answers, and are brilliant at reasoning. If you think there might not be a correct answer, you say so. Always spend a few sentences explaining background context, assumptions, and step-by-step thinking BEFORE you try to answer a question. Don't be verbose in your answers, but do provide details and examples where it might help the explanation. You are an expert software engineer for the %s language",
              context.filetype
            )
          end,
        },
        {
          role = constants.USER_ROLE,
          content = "I want you to ",
          opts = {
            auto_submit = false,
          },
        },
      },
      -- This is the second group of prompts
      {
        {
          role = constants.USER_ROLE,
          content =
          "Great. Now let's consider your code. I'd like you to check it carefully for correctness, style, and efficiency, and give constructive criticism for how to improve it.",
          opts = {
            auto_submit = true,
          },
        },
      },
      -- This is the final group of prompts
      {
        {
          role = constants.USER_ROLE,
          content = "Thanks. Now let's revise the code based on the feedback, without additional explanations.",
          opts = {
            auto_submit = true,
          },
        },
      },
    },
  },
  [ "Chat" ] = {
    strategy = "workflow",
    description = "Chat with buffer and file",
    opts = {
      index = 1,
      is_default = false,
      short_name = "c",
    },
    prompts = {
      {
        {
          role = constants.SYSTEM_ROLE,
          content = function( context )
            return string.format(
              "You carefully provide accurate, factual, thoughtful, nuanced answers, and are brilliant at reasoning. If you think there might not be a correct answer, you say so. Always spend a few sentences explaining background context, assumptions, and step-by-step thinking BEFORE you try to answer a question. Don't be verbose in your answers, but do provide details and examples where it might help the explanation. You are an expert software engineer for the %s language",
              context.filetype
            )
          end,
        },
        {
          role = constants.USER_ROLE,
          content = [[#{buffer}
@{files}
 ]],
          opts = {
            auto_submit = false
          },
        },
      },
    }
  },
  [ "Clean Chat" ] = {
    strategy = "chat",
    description = "Create a new chat buffer to converse with an LLM",
    opts = {
      index = 4,
      is_default = false,
      short_name = "dc",
      stop_context_insertion = true,
    },
    prompts = {
      n = function()
        return require( "codecompanion" ).chat()
      end,
      v = {
        {
          role = constants.SYSTEM_ROLE,
          content = function( context )
            return "I want you to act as a senior " ..
                context.filetype ..
                " developer. I will give you specific code examples and ask you questions. I want you to advise me with explanations and code examples."
          end,
        },
        {
          role = constants.USER_ROLE,
          content = function( context )
            local helpers = require( "codecompanion.helpers.actions" )
            local text = helpers.get_code( context.start_line, context.end_line )
            return "I have the following code:\n\n```" .. context.filetype .. "\n" .. text .. "\n```\n\n"
          end,
          opts = {
            contains_code = true,
          },
        },
      },
    },
  },
  [ "Open Chats" ] = {
    strategy = " ",
    description = "Your currently open chats",
    opts = {
      index = 5,
      is_default = false,
      short_name = "oc",
      stop_context_insertion = true,
    },
    condition = function()
      return #require( "codecompanion" ).buf_get_chat() > 0
    end,
    picker = {
      prompt = "Select a chat",
      items = function()
        local codecompanion = require( "codecompanion" )
        local loaded_chats = codecompanion.buf_get_chat()
        local open_chats = {}

        for _, data in ipairs( loaded_chats ) do
          table.insert( open_chats, {
            name = data.name,
            strategy = "chat",
            description = data.description,
            bufnr = data.bufnr,
            callback = function()
              codecompanion.close_last_chat()
              data.chat.ui:open()
            end,
          } )
        end

        return open_chats
      end,
    },
  },
}
