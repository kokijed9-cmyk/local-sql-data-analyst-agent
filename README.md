# Local SQL Data Analyst Agent (n8n + Ollama + MySQL)

A privacy-first, 100% locally hosted AI Data Analyst Agent built with **n8n**, **Ollama (`llama3.2`)**, and **MySQL**. It translates natural language business questions into read-only SQL queries, executes them against a local relational database, and returns accurate, context-aware insights without sending any sensitive data to external cloud APIs.

---

## Architecture & Data Flow

```text
┌───────────────────┐      Docker Bridge       ┌────────────────────────────┐
│   n8n Container   │ ───────────────────────► │      Windows Host OS       │
│                   │  host.docker.internal    │                            │
│  • Chat Trigger   │         :3306            │  • XAMPP MySQL Server      │
│  • AI Agent       │                          │    (`analytics_demo`)      │
│  • Simple Memory  │ ───────────────────────► │  • Ollama Local Server     │
└───────────────────┘         :11434           │    (`llama3.2:latest`)     │
                                               └────────────────────────────┘
