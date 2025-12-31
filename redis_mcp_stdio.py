import os
import redis
from mcp.server.fastmcp import FastMCP

REDIS_URL ="rediss://default:xi0AKe4X19Amnc710KC8eCGrgaQOUjj5wAzCaB92K8o=@redis-managed.swedencentral.redis.azure.net:10000/0"
# rediss:// => TLS otomatik
r = redis.Redis.from_url(REDIS_URL, decode_responses=True)

mcp = FastMCP("toyota-redis")

@mcp.tool()
def redis_set(key: str, value: str, ttl_seconds: int = 0) -> str:
    if ttl_seconds and ttl_seconds > 0:
        r.setex(key, ttl_seconds, value)
    else:
        r.set(key, value)
    return "OK"

@mcp.tool()
def redis_get(key: str) -> str | None:
    return r.get(key)

if __name__ == "__main__":
    mcp.run()
