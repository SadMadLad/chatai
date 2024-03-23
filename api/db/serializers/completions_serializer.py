from typing import List
from db.models.message import Message

class CompletionsSerializer:
    def __init__(self, messages: List[Message]):
        self.messages = messages
        self.role_map = { 0: 'user', 1: 'assistant', 2: 'message' }

    def serialize(self):
        return list(map(lambda message: {
            'role': self.role_map[message.role],
            'content': message.body
        }, self.messages))
