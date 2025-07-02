# gemini-cli-docker                                                                                                                                                                                                       │
- A Docker container for gemini-cli and instructions on how to run it.                                                                                                                                                    │
- It's very helpful as an agent. We can instruct it to install packages even if our system doesn't have them yet.                                                                                                         │
- The gemini-cli agent is wonderful.                                                                                                                                                                                      │
                                                                                                                                                                                                                          │
## First, get your Gemini API key.                                                                                                                                                                                        │
- To get a Google AI Studio API key, go to the Google AI Studio website (aistudio.google.com), navigate to the API key page, and then create and copy your API key.                                                       │
  - **Access Google AI Studio:** Go to the Google AI Studio website.                                                                                                                                                      │
  - **Go to the API Key page:** Click "Get API Key" in the left navigation menu or go directly to the API key page.                                                                                                       │
  - **Create API Key:** Follow the instructions to generate an API key.                                                                                                                                                   │
  - **Copy API Key:** Copy the generated API key and store it in a safe place.                                                                                                                                            │
                                                                                                                                                                                                                          │
## Run                                                                                                                                                                                                                    │
- `make build`                                                                                                                                                                                                            │
- Edit the `Makefile`:                                                                                                                                                                                                    │
    - Replace `[your-gemini-api-key]` with your actual key.                                                                                                                                                               │
- `make`                                                                                                                                                                                                                  │
                                                                                                                                                                                                                          │
## Run for MCP                                                                                                                                                                                                            │
- Edit `settings.json`:                                                                                                                                                                                                   │
    - Replace `[your-youtube-api-key]` and `[your-github-token]` with your actual keys.                                                                                                                                   │
    - **GitHub Token Setup Guide:** [How to issue a token on GitHub](https://sprint.codeit.kr/blog/github%EC%97%90%EC%84%9C-%ED%86%A0%ED%81%B0-%EB%B0%9C%EA%B8%89%ED%95%98%EA%B8%B0)                                      │
    - **YouTube API Setup:**                                                                                                                                                                                              │
        - Access the Google Cloud Console.                                                                                                                                                                                │
        - Create a new project or select an existing one.                                                                                                                                                                 │
        - Enable the YouTube Data API v3.                                                                                                                                                                                 │
        - Create API credentials (an API key).                                                                                                                                                                            │
        - Use the generated API key in your environment configuration.                                                                                                                                                    │
- `mkdir -p .gemini`                                                                                                                                                                                                      │
- `cp settings.json .gemini`                                                                                                                                                                                              │
- `make`



