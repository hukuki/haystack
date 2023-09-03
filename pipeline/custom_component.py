"""
Pipelines allow putting together Components to build a graph.

In addition to the standard Haystack Components, custom user-defined Components
can be used in a Pipeline YAML configuration.

The classes for the Custom Components must be defined in this file.
"""


from haystack.nodes.base import BaseComponent
from typing import Dict, List, Optional, Union, Iterator


class SampleComponent(BaseComponent):
    outgoing_edges: int = 1

    def run(self, **kwargs):
        raise NotImplementedError
    
class QueryPreprocessor(BaseComponent):
    outgoing_edges: int = 1

    def run(self, query: Optional[str], **kwargs):
        import string
        import re
        import unicodedata
        
        # weird_chars_keys = "á×‘ãòŷІ≤ý˂ ≈οà′éȗȋ–—‐а’“š≥É‚êïìŜóú⁄å‒”ô℮è―˃ʺÌ¡„−íäķậēÏ"
        # weird_chars_values = 'ax\'aoyI<y< =oa\'eui---a\'"ş>E,eiiSou/a-"oee->"İi,-iakaeİ'
        
        # query = unicodedata.normalize('NFKC', query) # Normalize unicode 
        # query = re.sub(r'\s+', ' ', query) # Remove extra spaces
        # query = query.translate(str.maketrans('âîûÂÎÛ', 'aiuAİU')) # Normalize Turkish characters by removing circumflex
        # query = query.translate(str.maketrans(weird_chars_keys, weird_chars_values)) # Fix weird characters
        # query = query.strip() # Remove leading and trailing spaces
        return query, "output_1"
    
    def run_batch(self, queries: Optional[List[str]]):
        texts = []

        for query in queries:
            text = self.run(query)
            texts.append(text)

        return texts, "output_1"