import numpy as np
from sklearn.base import BaseEstimator, TransformerMixin

class RemoveStringColumnsTransformer(BaseEstimator, TransformerMixin):
    def fit(self, X, y=None):
        return self

    def transform(self, X):
        numeric_columns_mask = np.array([np.issubdtype(type(val), np.number) for val in X[0]])
        numeric_data = X[:, numeric_columns_mask]

        return numeric_data
