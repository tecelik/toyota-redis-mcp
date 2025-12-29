FROM python:3.11-slim
WORKDIR /app
RUN pip install --no-cache-dir mcp-proxy redis-mcp-server
EXPOSE 8080
CMD ["python" , "-m" , "mcp_proxy" , "--host" , "0.0.0.0" , "--port" , "8080" , "--transport=streamablehttp" , "--stateless" , "--" , "redis-mcp-server" , "--url" , "${REDIS_URL}"]
