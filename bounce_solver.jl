# dande | false-vacuum nucleation rate
# 4am existential dread sim. 

using DifferentialEquations, LinearAlgebra, Printf

# asymmetric double well potential (false vacuum at phi=0)
function dV(phi, lambda=1.0, epsilon=0.1)
    return lambda * phi * (phi^2 - 1.0) + epsilon
end

function bounce_ode!(ddu, du, u, p, r)
    phi = u[1]
    dphi = du[1]
    # avoid singularity at r=0
    term = r == 0 ? 0.0 : (3.0 / r) * dphi
    ddu[1] = dV(phi) - term
end

function solve_bounce()
    r_span = (1e-6, 10.0)
    phi_guess = 1.05 # guess for true vacuum side
    
    println("[*] initiating tunneling simulation...")
    
    # naive shooting method to satisfy boundary condition phi(r->inf) -> 0
    for i in 1:100
        u0 = [phi_guess]
        du0 = [0.0] # dphi/dr = 0 at r=0
        
        prob = SecondOrderODEProblem(bounce_ode!, du0, u0, r_span)
        sol = solve(prob, Tsit5(), reltol=1e-8, abstol=1e-8)
        
        phi_inf = sol.u[end][2]
        
        if abs(phi_inf) < 1e-5
            println("[+] bounce solution found.")
            println("[!] universe deletion probability non-zero.")
            return sol
        end
        # lazy gradient update
        phi_guess -= phi_inf * 0.1
    end
    println("[-] metastable state rigid. we survive today.")
end

@time solve_bounce()
