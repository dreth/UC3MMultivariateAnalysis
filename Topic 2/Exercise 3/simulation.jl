using Random
using Statistics
using Plots
gr()

function simulation_general(nrows, simulations; fixed_value_col=false, reverse=false, sim_binaries=true, mins=[1,100], maxs=[10,10000]) 
    # cov and corr matrixes
    covs = zeros(Float64, nrows, simulations)
    corr = zeros(Float64, nrows, simulations)

    # loop
    for s in 1:simulations
        pvtapps = zeros(Float64, nrows, 3)
        if sim_binaries == false
            pvtapps[:,1] = rand(0:1, nrows)
        end

        # random numbers column (quant variable)
        if fixed_value_col == true
            pvtapps[:,2] = rand(mins[1]:maxs[1],nrows)
        else
            if reverse == false
                pvtapps[:,2] = rand(mins[1]:maxs[1],nrows)
                pvtapps[:,3] = rand(mins[2]:maxs[2],nrows)
            else 
                pvtapps[:,2] = rand(mins[2]:maxs[2],nrows)
                pvtapps[:,3] = rand(mins[1]:maxs[1],nrows)
            end
        end

        # loop for changing values
        for i in 1:nrows

            if sim_binaries == true
                pvtapps[1:i,1] = ones(i)
            end

            pvtapps[1:i,2] = pvtapps[1:i,3]

            # calculate corr and cov
            covs[i,s] = cov(pvtapps[:,1],pvtapps[:,2])
            corr[i,s] = cor(pvtapps[:,1],pvtapps[:,2])
        end
    end

    # results
    covsrows = zeros(Float64, nrows)
    corrrows = zeros(Float64, nrows)
    for i in 1:nrows
        covsrows[i] = mean(covs[i,:])
        corrrows[i] = mean(corr[i,:])
    end

    # plotting
    p1 = plot(covsrows, title="COV: nrows=$nrows, simulations=$simulations")
    p2 = plot(corrrows, title="COR: nrows=$nrows, simulations=$simulations")
    plot(p1,p2, layout = (2,1), legend=false) 
end

simulation_general(500,100, reverse=true, sim_binaries=true)

