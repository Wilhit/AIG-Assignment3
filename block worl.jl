
print("Problem 3\n")

function value_iter(prop,reward,gamma,theta)

    a = size(prop,1)
    old = zeros(a,1,1)
    new = zeros(a)
    limit = 2*theta

    while limit > theta
        oyy = reward .+ gamma * permutedims(old,[2,1,3])
        #oyy = reward #.+ gamma * old
        apu = prop.*(oyy)
        #print("apu: \n", apu, "\n")
        summia = sum(apu, dims=2)
        #print(size(summia),"\n")
        #print("summia: ", summia, "\n")
        #new = reshape(maximum(summia,dims=3),s,1)
        new = maximum(summia,dims=3)
        limit = maximum(abs.(old .- new), dims=1)
        limit = limit[1]
        old = new
        print("Tolr: ", limit, "\n")
        print("\n")
    end
    return old
end

function policya(prop,reward,gamma,old)
    summia = sum(prop.*(reward .+ gamma * permutedims(old,[2,1,3])), dims = 2)
    apu_2 = Array{Any,1}(undef,size(summia,1))
    for i = 1:size(summia,1)
        helpp = summia[i,:,:]
        apu, apu_2[i] = findmax(helpp,dims=2)
    end
    #apu, apu_2 = findmax(summia,dims=3)
    return apu_2, summia
end

#i,j,k   state i -> j, action k

println("Please enter the Different Probability distributions (0.0 - 1.0) vvv")
print("Probability P0 from S0 to S0: ")
p00 = parse(Float64, readline())
print("Probability P1 from S0 to S1: ")
p10 = parse(Float64, readline())
println()
print("Probability P01 from S1 to S2: ")
p01 = parse(Float64, readline())
print("Probability P11 from S1 to S4: ")
p11 = parse(Float64, readline())
print("Probability P21 from S1 to S2: ")
p21 = parse(Float64, readline())
println()
print("Probability P02 from S1 to S1: ")
p02 = parse(Float64, readline())
print("Probability P12 from S1 to S2: ")
p12 = parse(Float64, readline())
println()
print("Probability P03 from S2 to S2: ")
p03 = parse(Float64, readline())
print("Probability P13 from S2 to S5: ")
p13 = parse(Float64, readline())
print("Probability P21 from S2 to S3: ")
p23 = parse(Float64, readline())
println()
print("Probability P04 from S2 to S2: ")
p04 = parse(Float64, readline())
print("Probability P14 from S2 to S3: ")
p14 = parse(Float64, readline())
println()
println("Please enter the Different Rewards for each state vvv")
print("Reward S0: ")
r0 = parse(Int64, readline())
print("Reward S1: ")
r1 = parse(Int64, readline())
print("Reward S2: ")
r2 = parse(Int64, readline())



prop = zeros(6,6,3)
p_0_0 = p00
p_1_0 = p10

p_0_1 = p01
p_1_1 = p11
p_2_1 = p21

p_0_2 = p02
p_1_2 = p12

p_0_3 = p03
p_1_3 = p13
p_2_3 = p23

p_0_4 = p04
p_1_4 = p14

#state i -> j, action k
#S0
prop[1,1,1]=1

prop[1,1,2]=p_0_0
prop[1,2,2]=p_1_0

#S1
prop[2,2,1]=1

prop[2,2,2]=p_0_1
prop[2,5,2]=p_1_1
prop[2,3,2]=p_2_1

prop[2,2,3]=p_0_2
prop[2,3,3]=p_1_2

#S2
prop[3,3,1]=1

prop[3,3,2]=p_0_3
prop[3,6,2]=p_1_3
prop[3,4,2]=p_2_3

prop[3,3,3]=p_0_4
prop[3,4,3]=p_1_4

# state i -> j, action k
reward = zeros(6,6,3)
reward[:,1,:] .= r0
reward[:,2,:] .= r1
reward[:,3,:] .= r2
reward[:,4,:] .= 100



tulos = value_iter(prop, reward, 0.3, 0.0001)
print("Values: ", tulos, "\n")

policy, summia = policya(prop, reward, 0.3, tulos)

print("Best policy: ", "\n")
for i = 1:size(policy,1)
    print(policy[i][1][2], "\n")
end

print("Enter 0 to exit: ")
ex = parse(Int64, readline())
