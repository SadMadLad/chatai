from typing import List, Dict

from g4f.Provider import Bing
from g4f.models import gpt_4_turbo
from g4f import ChatCompletion

class G4fClient:
    def __init__(self, model=gpt_4_turbo, provider=Bing):
        self.model = model
        self.provider = provider

    async def get_response(self, messages: List[Dict], stream: bool = True):
        response = ChatCompletion.create_async(
            model=self.model,
            provider=self.provider,
            messages=messages,
            stream=stream
        )
        if stream is False:
            return response

        full_response = []
        async for message in response:
            full_response.append(message)

        return "".join(full_response)

