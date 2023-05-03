# The-Restaurant-Problem
This is a probabilistic simulation I made out of curiosity, it is about 6 equal restaurants and their customers. It is meant to test the effect of  "It is full so it must be good" mentallity. 

## The Premise 
It is simple, there are 6 restuarants in town with equal quality. People are coming to those restuarants and want to eat but don't know anything about them (i.e. they are not returning customers). They base of their decision by how populated the restaurant is. The more populated it is, the higher the probability that they will pick that restaurant. If two restaurants have the same amount of customers then they have equal probability of being chosen by the next group of customers. Customers leave afteer a random period of time. The question is does this cause a snowball effect where some restaurants become full while others are left empty despite having the same quality? The results most certenly show that this is the case, at least in this idealized scenario. The simulation is done by dividing time into small intrvals thus most of the random variables are discrete rather than continous.

## Arriving Customers
Customers arrive at random intervals with random group sizes. The group size $G$ is determined by a binomial random variable, given it's average and maximum possible group number. This has no particular reason except the fact that it always gives a nice positive value within a range, which is not as contrived as uniform distrubition. 

$P[ G=g ] = \binom{g_{max}}{g} p^g (1-p)^{g_{max}-g}$

$p= \frac{g_{avg}}{g_{max}}$

The arrival times of the customers are poisson distrubted. This is often an idealized assumption made to model arrival of indepent events such as the arrival of busses. 

## Restaurant Selection
The model for the selection of the customer group is a simple model. Every restaurant has a point system I call desirability, each restaurant has a base desirability $k_i$, $i$ subscripts represents the $i$th restaurant, these can also encode the initial desirability. An interesting case is when $k_i=k_0$ for all $i$, meaning that all restaurants are equal. The desirability of restaurant increases with customers in a linear fashion as given in the equation below. Here $c_i$ is the number of customers, $\mu_i$ is the proportianlity constant representing how the popularity effects the restuarant (this is mostly taken constant $\mu_i=\mu$) and $d_i$ is the desirability of the $i$th restaurnt. 

$d_i (t) = k_i+\mu_i \cdot c_i (t)$

The probability of a group of customers preffering a certain restaurant ($p_i$) depends on it desirbility. 

$p_i = \frac{d_i}{\sum_j  d_j}$

## Customers leaving
The time period of a customer staying ($t_s$) in the restaurant is a geoemetric random variable. Every time tick there is a probability check if they left or not.

$P\[t_s = k\] =(1-p)^{k-1}p$

$p = t_{avg}^{-1}$


