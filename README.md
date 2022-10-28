# Optimization methods collection

Contains various minimization methods in 7 Wolfram Mathematica packages:

* Package 1 (variations of 1-dimensional dichotomy)
    1) Dichotomy method
    2) Golden-section search

* Package 2 (variations of gradient descent)
    1. Steepest descent
    2. Gradient descent with geometric step reduction

* Package 3 (variations of nonlinear conjugate gradient method)
    1. Nonlinear conjugate gradient method
    2. Fletcher-Reeves method
    3. Polak-Ribière method
    4. Nonlinear conjugate gradient method with Hessian matrix

* Package 4 (variations of Newton's method)
    1. Newton's method
    2. Modified Newton's method with step reduction

* Package 5 (Quasi-Newton methods)
    1. Davidon-Fletcher-Powell method
    2. Broyden-Fletcher-Goldfarb - Shanno method
    3. Powell method
    4. McCormick method

* Package 6
* Package 7
* Package 8

## Package 1 examples
Minimization of a single argument function on a given interval. Both methods have exponential convergence.

<img src="images/package1_functionPlot.png" width=40% height=40%>

<img src="images/package1_dichotomy.png" width=40% height=40%>

## Package 2 examples
Minimization of a 2-argument function from a given initial point. Rosenbrock function is used for testing, minization process can be dynamically tracked. All consequent plots support dynamics. Following example showcases steepest descent method.

<img src="images/package2_functionPlot.png" width=40% height=40%>

<img src="images/package2_residual.png" width=40% height=40%>

<img src="images/package2_contours.png" width=40% height=40%>

## Package 3 examples
Minimization of a 2-argument function from a given initial point. Rosenbrock function is used for testing, minization process can be dynamically tracked. All consequent plots support dynamics. Following example showcases nonlinear conjugate gradient method with Hessian matrix.

<img src="images/package3_functionPlot.png" width=40% height=40%>

<img src="images/package3_residual.png" width=40% height=40%>

<img src="images/package3_contours.png" width=40% height=40%>


## Package 4 examples
Minimization of a 2-argument function from a given initial point. Rosenbrock function is used for testing, minization process can be dynamically tracked. All consequent plots support dynamics. Following example showcases modified Newton's method with step reduction.

<img src="images/package4_functionPlot.png" width=40% height=40%>

<img src="images/package4_residual.png" width=40% height=40%>

<img src="images/package4_contours.png" width=40% height=40%>

## Package 5 examples

Minimization of a 2-argument function from a given initial point. Rosenbrock function is used for testing, minization process can be dynamically tracked. All consequent plots support dynamics. Following example showcases Powell method. 

<img src="images/package5_functionPlot.png" width=40% height=40%>

<img src="images/package5_residual.png" width=40% height=40%>

<img src="images/package5_contours.png" width=40% height=40%>

## Package 6 examples
## Package 7 examples
## Package 8 examples



## Usage


## Requirements

To launch Mathematica packages one may need a valid Wolfram Mathematica license. As an alternative packages can be converted to Jypiter notebooks and executed with Wolfram Lang.

## Version History


* 00.04
    * Translated package 5, converted notebook to Mathematica package

* 00.03
    * Translated package 4, converted notebook to Mathematica package

* 00.02
    * Translated package 3, converted notebook to Mathematica package

* 00.01
    * Translated package 1, altered some plotting methods, converted notebook to Mathematica package
    * Translated package 2, altered some plotting methods, converted notebook to Mathematica package

## License

This project is licensed under the MIT License - see the LICENSE.md file for details
