FROM python:3.11-slim

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY redis_mcp_stdio.py .

# Container Apps ingress portu
EXPOSE 8080

# mcp-proxy dışarıya /sse endpointini açar, arkada python MCP server'ını stdio ile konuşturur
CMD ["mcp-proxy", "--host", "0.0.0.0", "--port", "8080", "--transport=streamablehttp", "--stateless", "--", "python", "redis_mcp_stdio.py"]
