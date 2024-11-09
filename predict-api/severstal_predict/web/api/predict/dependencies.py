import json
from hashlib import sha256
from typing import Any, Dict, Literal

from aio_pika.patterns import RPC
from fastapi import Request, status
from fastapi.responses import JSONResponse
from redis.asyncio import ConnectionPool, Redis

from severstal_predict.services.rabbit.dependencies import get_rmq_channel_pool
from severstal_predict.web.api.predict.schema import (
    PredictRequest,
    PredictResponse
)


async def run_task(*,
                   time_point:PredictRequest,
                   request: Request,
                   redis_pool: ConnectionPool,
                   ) -> dict:
    channel_pool = get_rmq_channel_pool(request)

    # TODO: Проверка на aio_pika.exceptions.MessageProcessError
    async with channel_pool.acquire() as channel:
        rpc = await RPC.create(channel)
        # try:
        response = await rpc.proxy.predict_wrapper(
            am_id=time_point.am_id,
            data=time_point.time_point,
        )
        # except:
        #     return {'status': 'wrong request'}
    # response = ClusterizationResponse(status='ok')

    return response
