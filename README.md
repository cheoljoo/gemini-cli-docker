# gemini-cli-docker
- docker for gemini-cli  and how to run

## first of all , make your gemini api key.
- Google AI Studio API 키를 얻으려면 Google AI Studio 웹사이트(aistudio.google.com)에서 API 키 페이지로 이동하여 API 키를 생성하고 복사해야 합니다.
  - Google AI Studio 접속: Google AI Studio 웹사이트에 접속합니다.
  - API 키 페이지 이동: 왼쪽 탐색 메뉴에서 "Get API Key"를 클릭하거나, API 키 페이지로 직접 이동합니다.
  - API 키 생성: 제공된 지침에 따라 API 키를 생성합니다.
  - API 키 복사: 생성된 API 키를 복사하여 안전한 곳에 보관합니다.

## run
- make build
- edit Makefile
    - change [yourgemini-api-key] into your key
- make

## run for MCP
- edit settings.json
    - change [your-youtube-api-key] and [your-github-token] into your key
    - github token setup : [url](https://sprint.codeit.kr/blog/github%EC%97%90%EC%84%9C-%ED%86%A0%ED%81%B0-%EB%B0%9C%EA%B8%89%ED%95%98%EA%B8%B0)
    - YouTube API Setup
        - Access Google Cloud Console
        - Create a new project or select an existing one
        - Enable YouTube Data API v3
        - Create API credentials (API key)
        - Use the generated API key in your environment configuration
- mkdir -p .gemini
- cp settings.json .gemini
- make





