clear all

*setting the scalars
sca A = 0.25
sca al = 0.8 //alpha
sca b = 0.95 //beta
sca g = 0.67 //gamma
sca d = 0.5 //delta
sca k = 100
sca n = 50

set obs `=k'
gen N = _n-1
gen X = N/100
gen V0 = X
gen M = A*X^(g)+(1-d)*X

sca r = 1

forvalues j=1(1)`=n'{
	sca c = 0
	quietly gen aux = .
	quietly gen V`=r' = .
	
forvalues i=1(1)`=k' {
	quietly replace aux = (M[c+1] - X)^al + b*V`=r-1' if X <= M[c+1]
	quietly sum aux
	quietly sca m = r(max)
	quietly replace V`=r' = m if N == c
	quietly sca c = c + 1
}
	drop aux
	sca r = r + 1
}
gen lV = ln(V`=n')
gen lX = ln(X)

quietly reg lV lX, noconst

matrix list e(b)

tw (li V`=n' X) (li V`=round(9*n/10)' X) (li V`=round(8*n/10)' X) (li V`=round(7*n/10)' X) (li V`=round(6*n/10)' X) (li V`=round(5*n/10)' X) (li V`=round(4*n/10)' X) (li V`=round(3*n/10)' X) (li V`=round(2*n/10)' X) (li V`=round(n/10)' X) (li V0 X), leg(off) xti("initial values") yti("value function") ti("value function for each decile repetition")
