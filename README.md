# false-vacuum

someone on a forum asked what happens if the higgs field is metastable. i couldn't sleep, so i wrote a numerical shooting method to solve the coleman-de luccia bounce action. 

this simulates the nucleation of a true vacuum bubble via quantum tunneling. it solves the euclidean equation of motion: 
$\frac{d^2\phi}{dr^2} + \frac{3}{r}\frac{d\phi}{dr} = \frac{dV}{d\phi}$

if the output rate is high enough, a bubble of true vacuum will expand at $c$ and we all stop existing instantly. 

why did i write this? because the math is elegant and nothing matters anyway. don't run this with low grid resolution, it causes unstable integration.
