function claudex --description 'Run Claude Code with Codex through local CLIProxyAPI'
    set -lx ANTHROPIC_BASE_URL http://127.0.0.1:8317
    set -lx ANTHROPIC_AUTH_TOKEN local-claude-code
    set -lx ANTHROPIC_DEFAULT_OPUS_MODEL 'gpt-5.6-sol(xhigh)'
    set -lx ANTHROPIC_DEFAULT_SONNET_MODEL 'gpt-5.6-terra(high)'
    set -lx ANTHROPIC_DEFAULT_HAIKU_MODEL 'gpt-5.6-luna(medium)'
    set -lx CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC 1
    set -lx CLAUDE_CODE_MAX_CONTEXT_TOKENS 1050000

    command claude --model 'gpt-5.6-sol(xhigh)' $argv
end
