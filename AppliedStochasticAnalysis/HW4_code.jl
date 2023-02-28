using LinearAlgebra
using Plots
using Distributions

function poisson_sim(n,p)
    i = 0
    sample_metro = Dict()
    sample_poisson = Dict()
    for j = 1:n
        u = rand()
        sample = rand(Poisson(8))
        
        a_plus = min(1, ((8/(i+1))*((1-p)/p)))
        if i == 0
            a_minus = 0
        else 
            a_minus = min(1, (((i+1)/8)*p/(1-p)))
        end
        if u > (1 - (p*a_plus))
            i += 1
        elseif u < (1-p)*a_minus
            i -= 1
        end
        if haskey(sample_metro, i)
            sample_metro[i] += 1
        else
            sample_metro[i] = 1
        end
        if haskey(sample_poisson, sample)
            sample_poisson[sample] += 1
        else
            sample_poisson[sample] = 1
        end
    end

    bar_m = bar(collect(keys(sample_metro)),collect(values(sample_metro)), title = "Metropolis-Hastings Sample")
    bar_p = bar(collect(keys(sample_poisson)),collect(values(sample_poisson)), title = "Poisson Sample")

    total = sum(values(sample_metro))
    mu = 0
    for i in sample_metro
        mu += i[1]*(i[2]/total)
    end
    println("The empirical mean is ", mu)

    plot!(bar_m, bar_p, layout = (2,1), legend = false)
    # uncomment below for the plot of mu vs iterations
    # return mu
end

plot(collect(10:10:10000),map((x)->poisson_sim(x,1/2),10:10:10000),title = "Mean vs. Iterations", legend = false)

function sigma_poi(n,sigma)
    i = 0
    sample_metro = Dict()
    A = Dict()
    for a = 1:sigma
        A[-i] = 0
        A[i] = 0
    end

    for j = 1:n
        u = rand()
        prob_sum = 0

        for a = 1:sigma
            if i - a < 0
                A[-a] = 0
                A[a] = min(1, ((((8^a)factorial(big(i)))/factorial(big(i+a)))))
            else
                A[-a] = min(1, ((factorial(big(i+a))/(factorial(big(i))*(8^a)))))
                A[a] = min(1, ((((8^a)factorial(big(i)))/factorial(big(i+a)))))
            end
        end
        
        for a = 1:sigma
            prob_sum += (1/(2*sigma))*A[-a]
            if u < prob_sum
                i -= a
                break
            end
            prob_sum += (1/(2*sigma))*A[a]
            if u < prob_sum
                i += a 
                break
            end
        end
        
        if haskey(sample_metro, i)
            sample_metro[i] += 1
        else
            sample_metro[i] = 1
        end
    end

    total = sum(values(sample_metro))
    mu = 0
    for i in sample_metro
        mu += i[1]*(i[2]/total)
    end
    # println("The empirical mean is ", mu)
    return mu
end

for i = 1:5
    plot!(collect(10:10:10000),map((x)->sigma_poi(x,i),10:10:10000))
end
plot!(title = "Multiple Steps Mu")

data = [
    (13,16),
    (57,93),
    (62,30),
    (93,24),
    (34,87),
    (33,39),
    (73,96),
    (98,20),
    (26,36),
    (23,64),
    (68,16),
    (61,81),
    (46,26),
    (2,66),
    (63,62),
    (29,21),
    (11,5),
    (32,80),
    (53,47),
    (42,92),
    (61,48),
    (65,60),
    (91,83),
    (4,71),
    (8,5),
    (57,99),
    (13,66),
    (7,75),
    (49,90),
    (33,85)
]

function distance((a,b),(c,d)) 
    return sqrt((a-c)^2 + (b-d)^2)
end

function energy_difference(energy, data, s1, s2)
    m = length(data)
    new = energy
    new -= (distance(data[s1],data[s1 - 1 < 1 ? m : s1 - 1]) 
          + distance(data[s1],data[s1 + 1 > m ? 1 : s1 + 1])
          + distance(data[s2],data[s2 - 1 < 1 ? m : s2 - 1]) 
          + distance(data[s2],data[s2 + 1 > m ? 1 : s2 + 1]))

    dummy = data[s1]
    data[s1] = data[s2]
    data[s2] = dummy

    new += (distance(data[s1],data[s1 - 1 < 1 ? m : s1 - 1]) 
          + distance(data[s1],data[s1 + 1 > m ? 1 : s1 + 1])
          + distance(data[s2],data[s2 - 1 < 1 ? m : s2 - 1]) 
          + distance(data[s2],data[s2 + 1 > m ? 1 : s2 + 1]))
    
    dummy = data[s1]
    data[s1] = data[s2]
    data[s2] = dummy

    return new - energy
end


function salesman_annealing(n, data)
    visits = length(data)
    min_energy = 0
    for i = 1:visits
        min_energy += distance(data[i], data[(i%visits)+1])
    end
    println("Starting distance is ", min_energy)

    A = zeros(visits)
    current = 1
    curr_energy = min_energy
    min_data = copy(data)
    for i = 1:n
        beta = (1.001)^i
        for j = 1:visits
            if j == current
                A[j] = 1
            else
                A[j] = min(1,
                            exp(-beta*(energy_difference(curr_energy,data,current,j))))
            end
        end

        prob_sum = 0
        sample = rand()
        for j = 1:visits
            prob_sum += A[j]/visits
            if sample < prob_sum
                curr_energy += energy_difference(curr_energy,data,current,j)
                dummy = data[current]
                data[current] = data[j]
                data[j] = dummy
                current = j
                if curr_energy < min_energy
                    min_energy = curr_energy
                    min_data = copy(data)
                end
                break
            end
        end
    end

    println("Final minimum distance is ", min_energy)
    scatter(min_data, seriestype=:scatter)
    for i = 1:visits
        temp_path = [min_data[i],min_data[(i%visits)+1]]
        plot!(temp_path)
    end
    plot!(title="Simulated Annealing", legend=false)
end