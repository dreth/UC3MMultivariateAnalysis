using Random
using Statistics
using Plots

function simulation(nrows, simulations) 
    covs = zeros(Float64, nrows, simulations)
    corr = zeros(Float64, nrows, simulations)
    for s in 1:simulations
        pvtapps = zeros(Float64, nrows, 2)
        pvtapps[:,2] = rand(1:10,nrows)
        for i in 1:nrows
            pvtapps[:,1] = vcat(zeros(nrows-i,1), ones(i,1))
            covs[i,s] = cov(pvtapps[:,1],pvtapps[:,2])
            corr[i,s] = cor(pvtapps[:,1],pvtapps[:,2])
        end
    end
    covsrowmeans = zeros(Float64, nrows)
    corrrowmeans = zeros(Float64, nrows)
    for i in 1:nrows
        covsrowmeans[i] = sum(covs[i,:])
        corrrowmeans[i] = sum(corr[i,:])
    end
    p1 = plot(covsrowmeans)
    p2 = plot(corrrowmeans)
    plot(p1,p2, layout = (2,1)) 
end

simulation(400,3000)