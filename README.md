# ![Logo with chat chain links](./elixir-langchain-link-logo_32px.png) Elixir LangChain Demo App

This project is a demonstration example using the [Elixir LangChain](https://github.com/brainlid/langchain) library and [Phoenix LiveView](https://www.phoenixframework.org/).

To start your LangChain Demo project:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4400`](http://localhost:4400) from your browser.

## Conversations

Visit the [Conversations](http://localhost:4004/conversations) page for having a conversation with ChatGPT.

You can cancel a request in flight, delete a message, edit a message, and resubmit the conversation.

Features:
- Conversations are written to a SQLite database in the project directory.
- Conversations are performed using the [Elixir LangChain](https://github.com/brainlid/langchain) library.
- Uses Phoenix LiveView [Async Operations](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html#module-async-operations).
- Use <kbd>ctrl+enter</kbd> to submit a message.

![Example GIF showing usage with editing and resubmitting](./ConversationDemo.gif)

## Personal Fitness AI Agent

An [Agent](https://python.langchain.com/docs/modules/agents/) can be described as:

> **Agent**: a language model is used as a reasoning engine to determine which actions to take and in which order.

Visit the [Personal Fitness Trainer](http://localhost:4004/agent_chat) page to meet with your own Personal AI Fitness Trainer.

Suggestion: Ask "how do we start?" to get started and go from there!

For an overview and to see it in action, check out the video:

![Youtube video of the fitness trainer](https://www.youtube.com/watch?v=AsfQNtoaB1M)

You can schedule a weekly workout to help you reach your goals. Information about you is stored to a local SQLite database. Report on your workouts and your assistant will log them for you. The assistant can access your stored information and historical logs to answer questions and help you on your personal fitness journey! 💪

Features:
- Context around how the AI is configured is hidden from the user.
- Data about the user is written in a structured format by the AI into a local SQLite database.
- Historical fitness log entries are stored and fetched from the local database.
- Provides a simple but powerful working example of how to create an AI agent in Elixir that integrates with your app.
