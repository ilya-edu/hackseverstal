# TODO: contracts and models

from enum import Enum
from typing import List, Union

from pydantic import BaseModel, Field, validator


class TaskType(Enum):
    predict = "predict"

    def __str__(self):
        return f"{self.value}"


class PredictRequest(BaseModel):
    """Модель запроса для прогноза"""
    am_id: int = Field(
        title="am id",
        description="ID эксгаустера")
    time_point: List[float] = Field(
        title="Time point",
        description="Одна строка из таблицы `x_train`")


class PredictResponse(BaseModel):
    """Модель ответа с прогнозом"""
    status: str = Field(
        title="Status",
        description="Статус запроса")


class Metrics(BaseModel):
    """Модель метрик модели прогноза"""
    mae: float = Field(title='MAE',
                       description='Средняя абсолютная ошибка')
    mape: float = Field(title='MAPE',
                        description='Средняя абсолютная ошибка в процентах')
    rmse: int = Field(title="RMSE",
                      description="Среднеквадратичная ошибка")


class ErrorMessage(BaseModel):
    """Модель сообщения об ошибке"""
    message: str = Field(
        title="Error message text",
        description="Текст ошибки запроса"
    )
