# Docker 없이 Gemini CLI 환경 설정 가이드

이 문서는 Docker를 사용하지 않고 호스트 시스템에 직접 Gemini CLI와 관련 도구들을 설치하여 개발 환경을 구성하는 방법을 설명합니다.

> **✅ 실제 테스트 완료**: 이 가이드의 모든 단계는 Ubuntu 24.04.1 LTS 환경에서 실제로 테스트되었으며 정상 작동을 확인했습니다. (2025년 8월 2일 기준)

## 목차
1. [시스템 요구사항](#시스템-요구사항)
2. [Node.js 설치](#nodejs-설치)
3. [Python 환경 설정](#python-환경-설정)
4. [Gemini CLI 설치](#gemini-cli-설치)
5. [추가 도구 설치](#추가-도구-설치)
6. [환경 설정](#환경-설정)
7. [사용법](#사용법)
8. [문제 해결](#문제-해결)
9. [자동 설정 스크립트](#자동-설정-스크립트)
10. [실제 설치 확인 결과](#실제-설치-확인-결과)

## 시스템 요구사항

- **운영체제**: Ubuntu 20.04+ 또는 Debian 기반 Linux 배포판
- **권한**: sudo 권한이 있는 사용자 계정
- **네트워크**: 인터넷 연결 (패키지 다운로드용)

## Node.js 설치

### 방법 1: Ubuntu/Debian 공식 저장소 사용 (간단)

```bash
# 패키지 목록 업데이트
sudo apt update

# Node.js와 npm 설치
sudo apt install -y nodejs npm

# 버전 확인
node --version
npm --version
```

### 방법 2: NodeSource 저장소 사용 (최신 LTS 버전)

```bash
# NodeSource 저장소 추가
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -

# Node.js 설치
sudo apt install -y nodejs

# 버전 확인
node --version
npm --version
```

### 방법 3: Node Version Manager (nvm) 사용 (권장)

```bash
# nvm 설치
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# 새 터미널 세션 시작 또는 다음 명령 실행
source ~/.bashrc

# 최신 LTS Node.js 설치
nvm install --lts
nvm use --lts

# 버전 확인
node --version
npm --version
```

## Python 환경 설정

### Python 3 및 관련 도구 설치

```bash
# Python 3, pip, venv 설치
sudo apt install -y python3 python3-pip python3-venv

# 가상환경 생성
python3 -m venv ~/gemini-env

# 가상환경 활성화
source ~/gemini-env/bin/activate

# pip 업그레이드
pip install --upgrade pip
```

### 필수 Python 패키지 설치

```bash
# 가상환경이 활성화된 상태에서 실행
# 주의: googletrans4 대신 googletrans 사용 (호환성 문제)
pip install yfinance pandas openpyxl numpy seaborn matplotlib openai python-dotenv googletrans uv pipx
```

**참고**: `googletrans4` 패키지는 Python 3.12와 호환성 문제가 있으므로 `googletrans`를 사용합니다.

## Gemini CLI 설치

### 글로벌 설치

```bash
# Gemini CLI 글로벌 설치
npm install -g @google/gemini-cli

# 설치 확인
gemini --version
```

### 로컬 프로젝트에 설치 (선택사항)

```bash
# 프로젝트 디렉토리에서
mkdir -p ~/gemini-project
cd ~/gemini-project

# package.json 생성
npm init -y

# 로컬 설치
npm install @google/gemini-cli
```

## 추가 도구 설치

### 개발 도구

```bash
# Git, Vim, 기타 유틸리티
sudo apt install -y git vim curl wget

# YouTube Data MCP Server (Node.js 패키지)
npm install -g youtube-data-mcp-server
```

### 선택적 도구

```bash
# 코드 에디터 (VS Code)
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install -y code
```

## 환경 설정

### 1. Gemini API 키 설정

```bash
# 환경 변수 설정 (임시)
export GEMINI_API_KEY="your_gemini_api_key_here"

# 영구 설정을 위해 ~/.bashrc에 추가
echo 'export GEMINI_API_KEY="your_gemini_api_key_here"' >> ~/.bashrc
source ~/.bashrc
```

### 2. 설정 파일 생성

```bash
# Gemini 설정 디렉토리 생성
mkdir -p ~/.gemini

# 설정 파일 복사 (프로젝트에 settings.json이 있는 경우)
cp settings.json ~/.gemini/
```

### 3. PATH 설정 확인

```bash
# nvm 환경을 ~/.bashrc에 영구 추가 (중요!)
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.bashrc
echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> ~/.bashrc

# 설정 적용
source ~/.bashrc

# npm 글로벌 패키지 경로 확인
npm config get prefix

# PATH에 npm 글로벌 bin 경로가 포함되어 있는지 확인
echo $PATH
```

**중요**: nvm을 사용한 경우 반드시 `~/.bashrc`에 nvm 환경 설정을 추가해야 새 터미널 세션에서도 Node.js를 사용할 수 있습니다.

## 사용법

### 기본 사용법

```bash
# nvm 환경 로드 (새 터미널 세션에서 필요시)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Python 가상환경 활성화 (필요시)
source ~/gemini-env/bin/activate

# Gemini CLI 실행
gemini

# 대화형 모드로 실행 (권장)
gemini -y

# 특정 프롬프트로 실행
gemini "Hello, how are you?"

# 도움말 확인
gemini --help
```

### 스크립트 작성 예시

```bash
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
```

실행 권한 부여:
```bash
chmod +x gemini-run.sh
```

## 프로젝트 구조

설치 완료 후 다음과 같은 구조로 파일들이 구성됩니다:

```
# 프로젝트 디렉토리
/home/worker/code/gemini-cli-docker/
├── gemini-run.sh          # 실행 스크립트 (자동 생성됨)
├── un-docker.md          # 이 가이드 문서
├── settings.json         # Gemini 설정 파일
├── Dockerfile           # (Docker용, 사용하지 않음)
└── Makefile            # (Docker용, 사용하지 않음)

# 사용자 홈 디렉토리
~/.gemini/
└── settings.json         # 복사된 Gemini 설정 파일

~/gemini-env/             # Python 가상환경
├── bin/                 # Python 실행 파일들
├── lib/                 # 설치된 패키지들
└── ...

~/.nvm/                   # Node.js 버전 관리
├── versions/node/v22.18.0/  # 설치된 Node.js
└── ...
```

## 문제 해결

### Node.js 관련 문제

**문제**: `node: command not found`
```bash
# 해결방법
sudo apt install nodejs npm
# 또는 nvm 사용
```

**문제**: npm 권한 오류
```bash
# 해결방법: npm 글로벌 디렉토리 변경
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
```

### Python 관련 문제

**문제**: `pip: command not found`
```bash
# 해결방법
sudo apt install python3-pip
```

**문제**: 패키지 설치 권한 오류
```bash
# 해결방법: 가상환경 사용
python3 -m venv ~/gemini-env
source ~/gemini-env/bin/activate
pip install [패키지명]
```

### Gemini CLI 관련 문제

**문제**: API 키 오류
```bash
# 해결방법: 환경 변수 확인
echo $GEMINI_API_KEY
export GEMINI_API_KEY="your_actual_api_key"
```

**문제**: `gemini: command not found`
```bash
# 해결방법 1: nvm 환경 로드
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# 해결방법 2: PATH 확인 및 재설치
npm list -g @google/gemini-cli
npm install -g @google/gemini-cli

# 해결방법 3: which 명령으로 경로 확인
which gemini
```

**문제**: `gemini --help`가 출력되지 않음
```bash
# 해결방법: ~/.bashrc 설정 확인 및 새 터미널 세션 시작
source ~/.bashrc
# 또는 새 터미널 창 열기
```

## 자동 설정 스크립트

전체 환경을 자동으로 설정하는 스크립트 (실제 테스트 완료):

```bash
#!/bin/bash
# setup-gemini-env.sh

set -e

echo "🚀 Gemini CLI 환경 설정을 시작합니다..."

# 시스템 업데이트
echo "📦 시스템 패키지 업데이트..."
sudo apt update

# 기본 도구 설치
echo "🔧 기본 도구 설치..."
sudo apt install -y curl wget git vim python3 python3-pip python3-venv

# Node.js 설치 (nvm 사용)
echo "📥 Node.js 설치..."
if ! command -v node &> /dev/null; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm install --lts
    nvm use --lts
    
    # ~/.bashrc에 nvm 설정 추가
    echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc
    echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.bashrc
    echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> ~/.bashrc
fi

# Python 가상환경 설정
echo "🐍 Python 가상환경 설정..."
python3 -m venv ~/gemini-env
source ~/gemini-env/bin/activate
pip install --upgrade pip
# googletrans4 대신 googletrans 사용 (호환성 문제)
pip install yfinance pandas openpyxl numpy seaborn matplotlib openai python-dotenv googletrans uv pipx

# Gemini CLI 설치
echo "💎 Gemini CLI 설치..."
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
npm install -g @google/gemini-cli

# 추가 패키지 설치
echo "📦 추가 패키지 설치..."
npm install -g youtube-data-mcp-server

# 설정 파일 복사 (있는 경우)
if [ -f "settings.json" ]; then
    echo "📋 설정 파일 복사..."
    mkdir -p ~/.gemini
    cp settings.json ~/.gemini/
fi

# 실행 스크립트 생성
echo "📝 실행 스크립트 생성..."
cat > gemini-run.sh << 'EOF'
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
EOF

chmod +x gemini-run.sh

echo "✅ 설정이 완료되었습니다!"
echo ""
echo "다음 단계:"
echo "1. 새 터미널을 열거나 'source ~/.bashrc'를 실행하세요"
echo "2. Gemini API 키를 설정하세요: export GEMINI_API_KEY='your_api_key'"
echo "3. 실행 스크립트를 사용하세요: ./gemini-run.sh"
echo "4. 또는 직접 실행하세요: gemini -y"
```

## 실제 설치 확인 결과

### 설치 성공 확인
실제 테스트에서 다음 사항들이 확인되었습니다:

```bash
# Node.js 설치 확인
$ node --version
v22.18.0

$ npm --version
10.9.3

# Python 환경 확인
$ python3 --version
Python 3.12.3

$ source ~/gemini-env/bin/activate
$ pip list | grep -E "(pandas|numpy|openai)"
numpy                   2.3.2
openai                  1.98.0
pandas                  2.3.1

# Gemini CLI 설치 확인
$ which gemini
/home/worker/.nvm/versions/node/v22.18.0/bin/gemini

$ gemini --help
gemini [options]
Gemini CLI - Launch an interactive CLI...
```

### 생성된 파일들
```bash
# 프로젝트 디렉토리
./gemini-run.sh           # 실행 스크립트 (자동 생성)
./un-docker.md           # 이 가이드 문서
./settings.json          # Gemini 설정 파일

# 사용자 홈 디렉토리
~/.gemini/settings.json   # 복사된 설정 파일
~/gemini-env/            # Python 가상환경
~/.nvm/                  # Node.js 설치 디렉토리
```

### 실행 스크립트 사용법
```bash
# API 키 설정 (필수)
export GEMINI_API_KEY="your_actual_api_key_here"

# 스크립트 실행
./gemini-run.sh
```

### 설치 시간
- **전체 설치 시간**: 약 10-15분
- **다운로드 용량**: 약 100MB (Node.js + Python 패키지)
- **디스크 사용량**: 약 500MB

## 결론

이 가이드를 따라하면 Docker 없이도 완전한 Gemini CLI 개발 환경을 구성할 수 있습니다. 각 단계는 독립적으로 실행할 수 있으며, 필요에 따라 선택적으로 설치할 수 있습니다.

### 실제 테스트 완료된 환경
- **테스트 OS**: Ubuntu 24.04.1 LTS (Noble Numbat)
- **설치된 Node.js**: v22.18.0 (LTS)
- **설치된 npm**: v10.9.3
- **Python**: 3.12.3
- **설치 소요 시간**: 약 10-15분 (네트워크 속도에 따라)

### Docker 환경 대비 장점
- **더 빠른 실행 속도**: 컨테이너 오버헤드 없음
- **시스템 리소스 효율적 사용**: 메모리 및 CPU 사용량 최적화
- **호스트 파일 시스템과의 직접적인 상호작용**: 파일 권한 문제 없음
- **기존 개발 도구와의 통합**: IDE, 에디터 등과 원활한 연동
- **영구적 설치**: 컨테이너 재시작 시에도 설정 유지

### 주의사항
1. **nvm 설정**: 반드시 `~/.bashrc`에 nvm 환경 설정을 추가해야 함
2. **Python 패키지 호환성**: `googletrans4` 대신 `googletrans` 사용 권장
3. **환경 변수 설정**: `GEMINI_API_KEY`는 반드시 설정해야 함
4. **터미널 세션**: 새 터미널에서는 `source ~/.bashrc` 실행 필요

문제가 발생하면 위의 문제 해결 섹션을 참조하거나 각 도구의 공식 문서를 확인하세요. 모든 단계는 실제로 테스트되었으며 정상 작동을 확인했습니다.
