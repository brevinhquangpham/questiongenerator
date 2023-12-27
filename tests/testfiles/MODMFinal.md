# Projection

## What is projection?
- Idea stems from the projection theorem
- **Definition of projection theorem** - is that if you have two vectors in $R^n$ and $a \neq 0$, $u$ can be expressed in exactly one way in the form $u = w_1 + w_2$ where $w_1$ is a scalar multiple of $a$ and $w_2$ is orthogonal to $a$
- So $u = w_1 + w_2$ and $w_1 = ka$
- $w_1$ - orthogonal projection of $u$ on $a$ or vector component of $u$ along $a$
- $w_2$ - component of $u$ orthogonal to $a$
- In this class's projection we are finding $w_1$
- $w_1 = \text{proj}_a u = \frac{u \cdot a}{||a||^2}a$
- $w_2 = u - \text{proj}_a u = u - \frac{u \cdot a}{||a||^2}a$

### I hate orange people
- I really fucking hate them

## How the professor wants us to do it
- To find the projection of $y$ onto $x$, we would do the following steps
    - Find the normalized $x$ as $\hat{x}$
    - Obtain the constant $\alpha = \hat{x}^\top y$
    - $x_\text{proj} = \alpha \hat{x}$
    - $error = ||y-x_\text{proj}||_2$
- Effectively the formula is:
  $x_\text{proj} = ((\frac{x}{||x||})^\top y) \frac{x}{||x||}$
- So basically $w_1$ =  $x_proj$ and $w_2 =$ error

# Pseudo-Inverse
- Sometimes we need to find the inverses of tall matrices, but often finding the inverse of a tall matrix is impossible
- If $A^{-1}$ does not exist, we check to see if $(A^\top A)^{-1}$ exists
- This means $(A^\top A)^{-1}(A^\top A) = I$
- **Pseudo Inverse** = $(A^\top A)^{-1}A^\top$
- This can be dot producted by $Ax$ to get $x$

# The Null Space
- Let's say you have a set of bases $v_1, v_2,...$ and these vectors are the columns of a matrix
- **Null-space** - set of all possible solutions for $x$ s.t. $x_1v_1 + x_2v_2 + ... = 0$ or $Ax = 0$
- To find the null space you create the augmented matrix s.t $[A$ | $0]$
- A trivial solution is when $A0 = 0$ ($x = 0$)
- May get a non trivial solution if infinite solutions are found, then the solution is defined by a space defined by a vector

# Rank
- Rank is the True Dimension spanned by a set of vectors
- Two possible cases for rank:
    - Rank is the same as number of basis - each vector contributes to a new dimension
    - Rank is fewer than the number of basis - redundant vectors that are covering the same space
- In the case that the rank is the same as the number of vectors, the vectors are **linearly independent**
- **Linearly dependent** - rank is fewer than the number of basis
- **Formal Definition of linear independence** - set of vectors is linearly independent iff $c_1 v_1 + c_2 v_2 +...+c_k v_k = 0$ has only the trivial solution, so the null space is trivial this means that no vector in the set can be expressed as a linear combination of the others.

# Probability Notation
- $p(x)$ - the probability of $x$ where $x$ is an event
- $P\{X = x\}$ - out of all possible outcomes $X$, the probability where $x$ happened
- $p(x, y)$ - probability of $x$ and $y$ simultaneously
    - Can also be written as $P(\{X = x \cap Y = y\}$
- Example:
    - $p(x) = 0.25$ -  the probability that $x$ happened is $0.25$
    - $P(X = x) = 0.25$ - the probability out of all possible outcomes $X$, the probability $x$ happened is $0.25$
- **Or Logic** - finding the probability of multiple events unioned:
    - $P\{X = x \cup Y = y\} = p(x) + p(y) - p(x,y)$
    - We subtract the intersection so that it isn't counted twice
- **Conditional Probability** - probability an event occurring happen given another event occurring
    - $p(x|y) = \frac{p(x,y)}{p(y)}$

## Probability vs Mass Function
- **PMF - Probability Mass Function**
    - Measures function of discrete events
    - Can be obtained from data simply by counting
- **PDF - Probability Density Function**
    - Measures function of continuous events
    - Requires integration to find values $p(x) = \int_0^x f(x)dx$


# Expectation
- $\mathbb{E}[X]$ - expected value of a random variable $X$
- Calculated by $\sum_{i = 0}^n x_i p(x_i)$
    - $x_i$ represents the value
    - $p(x_i)$ represents the probability of that value

# Variance
- **Variance** measures the spread of data
- The variance measures on average how far samples are from the center
    - Calculating - $\frac{1}{n} \sum(x_i - \overline{x})^2$ in the case of discrete
    - $\int_{-\infty}^{\infty} (x - \mathbb{E}[X])^2 \cdot p(x) dx$
    - $\overline{x}$ = $\frac{1}{n} \sum_{i=1}^n x_i$
- In the case that there is no sample mean and only a $\mathbb{E}[X]$, we can use this value instead of the sample mean.
- If we only have the samples $Var[x] = \frac{1}{n-1}\sum_i (x_i - \overline{x})^2$
- If we have probability values $Var[x] = \Sigma (x - E|X|)^2 \cdot p(x)$

# Gradient Descent
- Gradient descent is the idea of walking down a gradient
- Formula is $w_{\text{next}} = w_{\text{now}} - \alpha \frac{df}{dw}$

# Eigendecomposition
- **Eigendecomposition** - the act of compressing a matrix $A$ into $V \Sigma V^\top$
- To do this do the following:
- Find eigenvalues
    - Get the determinant of $A$
    - Determinant is a way of understanding how big a matrix is
    - $|A| = \begin{bmatrix} a_{11} - \lambda & a_{12} \\ a_{21} & a_{22} - \lambda \end{bmatrix} = a_{11} a_{22} - a_{12} a_{21}$
    - We do this to get the eigenvalues by finding a value $\lambda$ s.t. the determinant is equal to zero, $A - \lambda I| = 0$
- Find eigenvectors
    - Substitute $\lambda$ with the eigenvalues
    - Solve this $(A - \lambda I)v = 0$ where $v$ is a vector
    - This corresponds to the eigenvectors
    - To the matrix $V$ we order the vectors as so $\begin{bmatrix} v_2 & v_1 \end{bmatrix}$
    - *Note that $v_2$ is the 1st column*
    - We have to normalize $V$
- To cap everything off use $V$ as $V$ and a diagonal matrix of the eigenvalues in descending order as $\Sigma$ and $V^\top$ as $V^\top$

# SVD
- Eigendecomposition is useful, but it only works on symmetric matrices
- SVD is a way of doing this with any ol matrix
- SVD - $A = U \Sigma^{1/2} V^\top$
- To do this we must do eigendecomposition 2 times
- We do it once for $A^\top A$ - this will represent $V^\top$
- Then we do it again for $AA^\top$ - this will represent $U$
- We only have to take the eigenvalues once and the square root of these will represent $\Sigma$, so $\Sigma = \Sigma^{1/2}$

# Closed-Form Regression
- The idea of closed-form regression is to take the x, to create a matrix $A$, where column one is $f_1(x)$ and column two is $f_2(x)$
- Then find the Pseudo-inverse of $A$ by getting $(A^\top A)^{-1} A$

# Covariance
- Covariance is a way of measuring the dependence between 2 variables
- The covariance is calculated like this:
    - $Cov[X,Y] = \frac{1}{n} \sum_{{i}}^n (x_i - \overline{x})(y_i - \overline{y})$
    - Use $\frac{1}{n-1}$ for cases where you are doing this for a sample rather than a population

# Correlation
- To find a measure of how two different values are correlated, we use correlation
- $\frac{Cov[X, Y]}{\sqrt{Var[X] Var[Y]}}$
