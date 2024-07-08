skgrf
=====

``skgrf`` provides `scikit-learn <https://scikit-learn.org/stable/index.html>`__ compatible Python bindings to the C++ random forest implementation, `grf <https://github.com/grf-labs/grf>`__, using `Cython <https://cython.readthedocs.io/en/latest/>`__.

The latest release of ``skgrf`` uses version `2.1.0 <https://github.com/grf-labs/grf/releases/tag/v2.1.0>`__ of ``grf``.


Installation
------------

[Pypi version does not work (tested on Linux 22.04), hence the fork]

.. code-block:: bash

    uv venv # optional - create a virtual environment in the current directory
    source venv/bin/activate # activate the virtual environment
    make setup # setup the project - sets up git submodule and clones it to current directory
    make build # build the package - Cythonizes the .pyx files
    uv pip install -e . # install the package

Estimators
----------

* GRFForestCausalRegressor
* GRFForestInstrumentalRegressor
* GRFForestLocalLinearRegressor
* GRFForestQuantileRegressor
* GRFForestRegressor
* GRFBoostedForestRegressor
* GRFForestSurvival

Usage
-----

Minimal example in `test.ipynb`.  `load_boston` no longer works, so the data is loaded from a csv file. Fragments below still work (mutatis mutandis).

GRFForestRegressor
~~~~~~~~~~~~~~~~~~

The ``GRFForestRegressor`` predictor uses ``grf``'s RegressionPredictionStrategy class.

.. code-block:: python

    from sklearn.datasets import load_boston
    from sklearn.model_selection import train_test_split
    from skgrf.ensemble import GRFForestRegressor

    X, y = load_boston(return_X_y=True)
    X_train, X_test, y_train, y_test = train_test_split(X, y)

    forest = GRFForestRegressor()
    forest.fit(X_train, y_train)

    predictions = forest.predict(X_test)
    print(predictions)
    # [31.81349144 32.2734354  16.51560285 11.90284392 39.69744341 21.30367911
    #  19.52732937 15.82126562 26.49528961 11.27220097 16.02447197 20.01224404
    #  ...
    #  20.70674263 17.09041289 12.89671205 20.79787926 21.18317924 25.45553279
    #  20.82455595]


GRFForestQuantileRegressor
~~~~~~~~~~~~~~~~~~~~~~~~~~

The ``GRFForestQuantileRegressor`` predictor uses ``grf``'s QuantilePredictionStrategy class.

.. code-block:: python

    from sklearn.datasets import load_boston
    from sklearn.model_selection import train_test_split
    from skgrf.ensemble import GRFForestQuantileRegressor

    X, y = load_boston(return_X_y=True)
    X_train, X_test, y_train, y_test = train_test_split(X, y)

    forest = GRFForestQuantileRegressor(quantiles=[0.1, 0.9])
    forest.fit(X_train, y_train)

    predictions = forest.predict(X_test)
    print(predictions)
    # [[21.9 50. ]
    # [ 8.5 24.5]
    # ...
    # [ 8.4 18.6]
    # [ 8.1 20. ]]


