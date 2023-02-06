library(bnlearn)

# df = read.csv("data/large/DB_cleaned_discretized.csv") @CM Feb 4 2023
df = read.csv("DB_cleaned_discretized.csv")

## change data type to factor because bnlearn needs that
df[, 1:20] <- lapply(df[,1:20], as.factor)

df2 = df[, -c(1,13)]

# dim(df)
# data(learning.test)

# Tutorials: https://www.bnlearn.com/examples/

## Get a score of bn (learn.net) given the data (learning.test). Other types: aic, bde, etc. (see `score` help)
# score(learn.net, learning.test, type = "bic")

## Whitelists and blacklists in structure learning
"""
* Arcs in the whitelist are always included in the network.
* Arcs in the blacklist are never included in the network.
* Any arc whitelisted and blacklisted at the same time is assumed to be whitelisted, and is thus removed from the blacklist. In other words, the whitelist has precedence over the blacklist.
"""

#wl = read.csv("data/small/node_whitelist.csv") @CM Feb 4 2023
#bl = read.csv("data/small/node_blacklist.csv") @CM Feb 4 2023
#bl2 = read.csv("data/small/node_blacklist_noSurvey.csv") @CM Feb 4 2023

wl = read.csv("node_whitelist.csv")
bl = read.csv("node_blacklist.csv")
bl2 = read.csv("node_blacklist_noSurvey.csv")


## Structure learning with PC algorithm. Does not result in any reasonable network
bn_pc = pc.stable(df, whitelist=wl, blacklist=bl)
plot(bn_pc)
# GS algorithm: Error in if (a <= alpha) { : missing value where TRUE/FALSE needed
bn_gs = gs(df, whitelist=wl, blacklist=bl)
plot(bn_gs)
# IAMB algorithm: Error in if (a <= alpha) { : missing value where TRUE/FALSE needed
bn_iamb = iamb(df, whitelist=wl, blacklist=bl)
plot(bn_iamb)
# inter-IAMB algorithm
bn_interiamb = inter.iamb(df, whitelist=wl, blacklist=bl)
plot(bn_interiamb)
# IAMB-FDR algorithm: Error in if (a <= alpha) { : missing value where TRUE/FALSE needed
# bn_iambfdr = iamb.FDR(df, whitelist=wl, blacklist=bl)
# plot(bn_iambfdr)
# MMPC algorithm
bn_mmpc = mmpc(df, whitelist=wl, blacklist=bl)
plot(bn_mmpc)
# SI.HITON-PC algorithm
bn_sihitonpc = si.hiton.pc(df, whitelist=wl, blacklist=bl)
plot(bn_sihitonpc)
# HC algorithm (score-based): The most reasonable so far
bn_hc = hc(df, whitelist=wl, blacklist=bl)
plot(bn_hc)
bn_hc_fitted = bn.fit(bn_hc, df)
write.net("data/small/bn_hc.net", bn_hc_fitted)

bn_hc2 = hc(df2, whitelist=wl, blacklist=bl2)
plot(bn_hc2)
bn_hc_fitted2 = bn.fit(bn_hc2, df2)
write.net("data/small/bn_hc_noDaySurvey.net", bn_hc_fitted2)

# To read again
bn_hc_fitted2 = read.net("data/small/bn_hc_noDaySurvey.net")
# To plot
# Install with: install.packages("BiocManager"); BiocManager::install("Rgraphviz")
library(Rgraphviz)
pdf("plots/network_structure.pdf")
graphviz.plot(bn_hc_fitted2)
dev.off()

# # HC algorithm (score-based) with restars
# bn_hc_restart = hc(df, whitelist=wl, blacklist=bl, restart=100)
# plot(bn_hc_restart)
# bn_hc_fitted_restart = bn.fit(bn_hc_restart, df)
# write.net("bn_hc_restart.net", bn_hc_fitted_restart)
# MMHC algorithm (hybrid)
bn_mmhc = mmhc(df, whitelist=wl, blacklist=bl)
plot(bn_mmhc)
# RSMAX2 algorithm (hybrid)
bn_rsmax2 = rsmax2(df, whitelist=wl, blacklist=bl)
plot(bn_rsmax2)
# ARACNE (local discovery)
bn_aracne = aracne(df, whitelist=wl, blacklist=bl, mi="mi")
plot(bn_aracne)
# Chow-Liu (local discovery)
bn_chowLiu = chow.liu(df, whitelist=wl, blacklist=bl, mi="mi")
plot(bn_chowLiu)

##-----------------------------------------------
## Species interaction networks NB: none of the networks have any edges
##-----------------------------------------------

# See preprocessing.jl for producing a CSV for a specific country.
df = read.csv("data/large/DEN_species.csv")

## change data type to factor because bnlearn needs that
df[, 1:ncol(df)] <- lapply(df[,1:ncol(df)], as.factor)


# HC algorithm (score-based) with restars
bn_hc_restart = hc(df, restart=100)
plot(bn_hc_restart)
# bn_hc_fitted_restart = bn.fit(bn_hc_restart, df)
# write.net("DEN_bn_hc_restart.net", bn_hc_fitted_restart)

# To plot
# Install with: install.packages("BiocManager"); BiocManager::install("Rgraphviz")
library(Rgraphviz)
pdf("plots/network_structure_DEN.pdf")
graphviz.plot(bn_hc_restart)
dev.off()

## Structure learning with PC algorithm. 
bn_pc = pc.stable(df)
plot(bn_pc)
# GS algorithm
bn_gs = gs(df)
plot(bn_gs)
# IAMB algorithm
bn_iamb = iamb(df)
plot(bn_iamb)
# inter-IAMB algorithm
bn_interiamb = inter.iamb(df)
plot(bn_interiamb)
# IAMB-FDR algorithm
# bn_iambfdr = iamb.fdr(df)
# plot(bn_iambfdr)
# MMPC algorithm
bn_mmpc = mmpc(df)
plot(bn_mmpc)
# SI.HITON-PC algorithm
bn_sihitonpc = si.hiton.pc(df)
plot(bn_sihitonpc)
