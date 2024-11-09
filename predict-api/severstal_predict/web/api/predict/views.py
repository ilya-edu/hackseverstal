from aio_pika.patterns import RPC
from fastapi import APIRouter, Depends, Request, status
from fastapi.responses import JSONResponse
from redis.asyncio import ConnectionPool, Redis

from severstal_predict.services.rabbit.dependencies import get_rmq_channel_pool
from severstal_predict.services.redis.dependency import get_redis_pool
from severstal_predict.web.api.predict.dependencies import run_task
from severstal_predict.web.api.predict.schema import (
    ErrorMessage,
    Metrics,
    PredictRequest,
    PredictResponse,
)

router = APIRouter()


@router.post(
    "/predict",
    tags=["predict"],
    summary="Прогноз",
    status_code=status.HTTP_200_OK,
    responses={
        status.HTTP_400_BAD_REQUEST: {"model": ErrorMessage},
        status.HTTP_422_UNPROCESSABLE_ENTITY: {"model": ErrorMessage},
    },
)
async def get_predict(
    time_point: PredictRequest,
    request: Request,
    redis_pool: ConnectionPool = Depends(get_redis_pool)
) -> JSONResponse:
    """
    Получение базового прогноза.
    """
    response = await run_task(time_point=time_point,
                              request=request,
                              redis_pool=redis_pool)

    return JSONResponse(
        status_code=status.HTTP_200_OK,
        content=response,
    )


@router.get(
    "/metrics",
    tags=["predict"],
    summary="Получение метрик прогноза",
    status_code=status.HTTP_200_OK,
    response_model=Metrics,
    responses={
        status.HTTP_400_BAD_REQUEST: {"model": ErrorMessage},
        status.HTTP_422_UNPROCESSABLE_ENTITY: {"model": ErrorMessage},
    },
)
async def get_metrics(
    model_id:str,
    request: Request,
    redis_pool: ConnectionPool = Depends(get_redis_pool)
) -> JSONResponse:
    """
    InWork in process..

    - `model_id` - ID модели прогноза. Совпадает с ID эксгаустера🚧🚧
    """
    # response = await run_task(time_point=time_point.file_id,
    #                           cluster_type='regular',
    #                           request=request,
    #                           redis_pool=redis_pool,
    #                           )

    return JSONResponse(
        status_code=status.HTTP_200_OK,
        content={'handler status': 'not implemented yet.'},
        # content=response,
    )
