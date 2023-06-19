import json
import xxhash
import redis
from loguru import logger
from datetime import datetime, timedelta


def __calculate_hash(**kwargs):
    kwargs_str = json.dumps(kwargs, sort_keys=True)
    hash = xxhash.xxh64(kwargs_str).hexdigest()
    return hash


def filter_shipment_updates(func, **kwargs):
    def __wrapper():
        hash = __calculate_hash(**kwargs)
        redis_key = f"hash-pool:{hash}"
        with redis.from_url("redis://redis:6379") as r:
            if not r.exists(redis_key):
                func(**kwargs)
                r.set(redis_key, 1, ex=timedelta(days=3))
            else:
                logger.info(f"{redis_key} already exists")

    return __wrapper
