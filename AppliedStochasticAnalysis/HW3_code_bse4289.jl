using LinearAlgebra
using Random

# Q1
T = [1 -.5 0 0 0 0 0 0 0 0 0 0 0;
    -.5 1 -.5 0 0 0 0 0 0 0 0 0 0;
    0 -.5 1 -.5 0 0 0 0 0 0 0 0 0;
    0 0 -.5 1 -.5 0 0 0 0 0 0 0 0;
    0 0 0 -.5 1 -.5 0 0 0 0 0 0 0;
    0 0 0 0 -.5 1 -.5 0 0 0 0 0 0;
    0 0 0 0 0 -.5 1 -.5 0 0 0 0 0;
    0 0 0 0 0 0 -.5 1 -.5 0 0 0 0;
    0 0 0 0 0 0 0 -.5 1 -.5 0 0 0;
    0 0 0 0 0 0 0 0 -.5 1 -.5 0 0;
    0 0 0 0 0 0 0 0 0 -.5 1 -.5 0;
    0 0 0 0 0 0 0 0 0 0 -.5 1 -.5;
    0 0 0 0 0 0 0 0 0 0 0 -.5 1]

f = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]

tau = T^-1 * f

#Q2
Ts = [1 0 0 0 -.5 0 -.5 0 0;
      0 1 0 -.5 -.5 0 0 0 0;
      0 0 1 -.5 -.5 0 0 0 0;
      -.5 0 0 1 -.5 0 0 0 0;
      -.5 0 0 0 1 0 -.5 0 0;
      0 0 0 -.5 0 1 -.5 0 0;
      0 0 0 -.5 0 0 1 0 -.5;
      0 0 0 0 0 0 0 1 -.5;
      0 0 0 0 0 0 0 0 1]

fs = [1, 1, 1, 1, 1, 1, 1, 1, 0]

ans = Ts^-1 * fs

Hs = [1 0 0 0 0 0 0 0 0;
      0 1 0 -.5 -.5 0 0 0 0;
      0 0 1 -.5 -.5 0 0 0 0;
      0 0 0 1 -.5 0 0 0 0;
      0 0 0 0 1 0 -.5 0 0;
      0 0 0 -.5 0 1 -.5 0 0;
      0 0 0 -.5 0 0 1 0 -.5;
      0 0 0 0 0 0 0 1 0;
      0 0 0 0 0 0 0 0 1]

ps = [0, 0, 0, 0, 0, 0, 0, 1, 1]

prob = Hs^-1 * ps

function sim_snakesandladders(n, start)
    sum = 0
    for i = 1:n
        s = start
        count = 0
        while s < 9
            r = rand()
            if s == 1
                if r < .5
                    s = 7
                else 
                    s = 5
                end
            elseif s == 2
                if r < .5
                    s = 5
                else
                    s = 4
                end
            elseif s == 3
                if r < .5
                    s = 4
                else 
                    s = 5
                end
            elseif s == 4
                if r < .5
                    s = 5
                else
                    s = 1
                end
            elseif s == 5
                if r < .5
                    s = 1
                else 
                    s = 7
                end
            elseif s == 6
                if r < .5
                    s = 7
                else 
                    s = 4
                end
            elseif s == 7 
                if r < .5
                    s = 4
                else
                    s = 9
                end
            elseif s == 8
                if r < .5
                    s = 9
                else
                    s = 9
                end
            else 
                s = 9
            end
            count += 1
        end
        sum += count
    end
    average = sum/n
    println("The average for n = ", n, " trials starting at ", start, " is ", average, " turns.")
end

#Q3

T3 = [.5 -.5 0 0 0;
      -.5 1 -.5 0 0;
      -.5 0 1 -.5 0;
      -.5 0 0 1 -.5;
      0 0 0 0 1]

f3 = [1,1,1,1,0]

tau3 = T3^-1*f3

function sim_4inarow(n)
    sum = 0
    for i = 1:n
        s = 0
        count = 0
        while s != 4
            if rand() < .5
                s = 0
            else
                s += 1
            end
            count += 1
        end
        sum += count
    end
    average = sum/n
    println("The average for n=", n, " trials is ", average, " coin flips")
end

