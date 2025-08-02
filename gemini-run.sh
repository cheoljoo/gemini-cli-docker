#!/bin/bash
# gemini-run.sh - Gemini CLI 실행 스크립트

# Python 가상환경 활성화
source ~/gemini-env/bin/activate

# Node.js 환경 설정
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# 환경 변수 설정 확인
if [ -z "$GEMINI_API_KEY" ]; then
    echo "⚠️  GEMINI_API_KEY가 설정되지 않았습니다."
    echo "다음 명령으로 API 키를 설정하세요:"
    echo "export GEMINI_API_KEY='your_gemini_api_key_here'"
    exit 1
fi

echo "🚀 Gemini CLI 환경이 준비되었습니다!"
echo "📦 Python 가상환경: $(python --version)"
echo "📦 Node.js: $(node --version)"
echo "💎 Gemini CLI: 설치됨"
echo ""

# Gemini CLI 실행
gemini -y
