# Local SQL Data Analyst Agent (n8n + Ollama + MySQL)

A privacy-first, 100% locally hosted AI Data Analyst Agent built with **n8n**, **Ollama (`llama3.2`)**, and **MySQL**. It translates natural language business questions into read-only SQL queries, executes them against a local relational database, and returns accurate, context-aware insights without sending any sensitive data to external cloud APIs.

---

## Architecture & Data Flow

n8n (Docker container) -> `host.docker.internal:3306` -> XAMPP MySQL (`analytics_demo`)  
n8n (Docker container) -> `host.docker.internal:11434` -> Ollama (`llama3.2:latest`)

### Key Components
* **Orchestration:** `n8n` (running inside Docker) handling chat triggers, tool routing, and execution logs.
* **Local LLM Engine:** `Ollama` running `llama3.2:latest` for natural language understanding, SQL generation, and response synthesis.
* **Database:** `MySQL` (via XAMPP) storing structured sales records in `analytics_demo.sales`.
* **Conversational Context:** `Simple Memory` maintaining session history (`sessionId`) so users can ask follow-up questions naturally (e.g., *"Which one of those two categories is higher?"*).

---

## Security & Engineering Guardrails

1. **Zero Cloud Data Exposure (100% Local):** Both inference (`Ollama`) and data storage (`MySQL`) run locally—making this pattern suitable for confidential financial, inventory, or ERP datasets.
2. **Read-Only SQL Enforcement:** The AI Agent's system prompt restricts query generation strictly to read-only `SELECT` statements, preventing `INSERT`, `UPDATE`, `DELETE`, or `DROP` operations.
3. **SQL-Side Aggregation (Eliminating LLM Math Hallucinations):** Small local models (`3B` parameters) can miscalculate sums when given raw rows. The agent is explicitly instructed to push all math (`SUM`, `COUNT`, `AVG`, `GROUP BY`, `ORDER BY`) into the MySQL query so the database engine computes exact figures.
4. **Docker-to-Host Networking:** Configured n8n's MySQL credentials to connect via `host.docker.internal:3306` to bridge the isolated Docker container network with the host machine's XAMPP MySQL instance.

---

## Setup & Reproduction

### 1. Initialize the Database
1. Start **MySQL** in XAMPP (port `3306`).
2. Open **phpMyAdmin** (or MySQL CLI) and run [`schema.sql`](./schema.sql) to create the `analytics_demo` database and seed the `sales` table.

### 2. Pull the Local LLM
Ensure Ollama is installed and running on your host machine, then pull the model:
```bash
ollama pull llama3.2:latest
