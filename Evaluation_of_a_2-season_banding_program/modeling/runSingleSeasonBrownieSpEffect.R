runSingleSeasonBrownieSpEffect <- function(mergeddata, pooledHybrids = T, jagsmodel, season = "Pre"){
  require(runjags)
  # mergeddata is created beforehand - bandings and encounters
  # species is "MALL", "ABDU" or hybrids
  # pooledHybrids - are all hybrids together or not?
  # JAGS model is defined outside so we don't have to
  # deal with working directory stuff inside the function
  # if(pooledHybrids){
  #   if(species=="MALL"){
  #     sppvec <- "MALL"
  #   } else {
  #     if(species=="ABDU"){
  #       sppvec <- "ABDU"
  #     } else {
  #       sppvec <- c("ABDX", "MALX", "MBDX", "MBDH")
  #     }
  #   }
  # } else { # hybrids are with their dominant species in this case
  #   if(species=="MALL"){
  #     sppvec <- c("MALL", "MALX", "MBDX", "MBDH")
  #   } else {
  #     if(species=="ABDU"){
  #       sppvec <- c("ABDU", "ABDX")
  #     } else { # in this case you wouldn't have a hybrid data set
  #       sppvec <- c("")
  #     }
  #   }
  # }
  
  #### Adult male ####
  if(pooledHybrids){
    mergeddata$Spp2 <- ifelse(mergeddata$Spp=="MALL", "MALL", ifelse(mergeddata$Spp=="ABDU", "ABDU", "HYBR"))
  } else {
    mergeddata$Spp2 <- ifelse(mergeddata$Spp %in% c("MALL", "MBDH", "MBDX", "MALX"), "MALL", ifelse(mergeddata$Spp %in% c("ABDU", "ABDX"), "ABDU", "HYBR"))
  }
  sppvec <- c("MALL", "ABDU", "MBDX", "MBDH", "ABDX", "MALX")
  
  
  if(season=="Pre"){
  ## Pre AM
  #ABDU.AM.Pre<-subset(mergeddata,Spp %in% sppvec & BSeason=="Pre" & cohort=="AM")
  Pre.AM <- subset(mergeddata, Spp %in% sppvec &
                     BSeason == "Pre" & 
                     cohort == "AM" &
                     BYEAR %in% c(2009:2017))
  
  Pre.AM$BYEAR <- factor(Pre.AM$BYEAR, levels=c(2009:2017))
  Pre.AM$Hyear <- factor(Pre.AM$Hyear, levels=c(2009:2017))
  
  bnd.PreAM <- table(Pre.AM$Spp2, Pre.AM$BYEAR)
  rec.PreAM <- table(Pre.AM[c("Spp2","BYEAR", "Hyear")])
  nyrs <- length(unique(Pre.AM$BYEAR))
  not.recov <-matrix(0,nrow=3, ncol=nyrs) # not.recov should now be species by year
  for(s in 1:3){
    for(i in 1:nyrs){
      not.recov[s,i] <- bnd.PreAM[s,i] - sum(rec.PreAM[s,i,1:nyrs])
    }
  }
  
  recovmat.am <- array(0, dim=c(3,nyrs,nyrs+1))
  recovmat.am[,1:nyrs, 1:nyrs] <- rec.PreAM
  recovmat.am[1:3,1:nyrs, (nyrs+1)] <- not.recov
  
  relmat.am<-as.matrix(bnd.PreAM)
  
  #### Adult female ####
  Pre.AF <- subset(mergeddata, Spp %in% sppvec &
                     BSeason == "Pre" & 
                     cohort == "AF" &
                     BYEAR %in% c(2009:2017))
  
  Pre.AF$BYEAR <- factor(Pre.AF$BYEAR, levels=c(2009:2017))
  Pre.AF$Hyear <- factor(Pre.AF$Hyear, levels=c(2009:2017))
  
  bnd.PreAF <- table(Pre.AF$Spp2, Pre.AF$BYEAR)
  rec.PreAF <- table(Pre.AF[c("Spp2","BYEAR", "Hyear")])
  nyrs <- length(unique(Pre.AF$BYEAR))
  not.recov <-matrix(0,nrow=3, ncol=nyrs) # not.recov should now be species by year
  for(s in 1:3){
    for(i in 1:nyrs){
      not.recov[s,i] <- bnd.PreAF[s,i] - sum(rec.PreAF[s,i,1:nyrs])
    }
  }
  
  recovmat.af <- array(0, dim=c(3,nyrs,nyrs+1))
  recovmat.af[,1:nyrs, 1:nyrs] <- rec.PreAF
  recovmat.af[1:3,1:nyrs, (nyrs+1)] <- not.recov
  
  relmat.af<-as.matrix(bnd.PreAF)
  
  #### Juvenile male ####
  Pre.JM <- subset(mergeddata, Spp %in% sppvec &
                     BSeason == "Pre" & 
                     cohort == "JM" &
                     BYEAR %in% c(2009:2017))
  
  Pre.JM$BYEAR <- factor(Pre.JM$BYEAR, levels=c(2009:2017))
  Pre.JM$Hyear <- factor(Pre.JM$Hyear, levels=c(2009:2017))
  
  bnd.PreJM <- table(Pre.JM$Spp2, Pre.JM$BYEAR)
  rec.PreJM <- table(Pre.JM[c("Spp2","BYEAR", "Hyear")])
  nyrs <- length(unique(Pre.JM$BYEAR))
  not.recov <-matrix(0,nrow=3, ncol=nyrs) # not.recov should now be species by year
  for(s in 1:3){
    for(i in 1:nyrs){
      not.recov[s,i] <- bnd.PreJM[s,i] - sum(rec.PreJM[s,i,1:nyrs])
    }
  }
  
  recovmat.jm <- array(0, dim=c(3,nyrs,nyrs+1))
  recovmat.jm[,1:nyrs, 1:nyrs] <- rec.PreJM
  recovmat.jm[1:3,1:nyrs, (nyrs+1)] <- not.recov
  
  relmat.jm<-as.matrix(bnd.PreJM)
  
  #### Juvenile female ####
  Pre.JF <- subset(mergeddata, Spp %in% sppvec &
                     BSeason == "Pre" & 
                     cohort == "JF" &
                     BYEAR %in% c(2009:2017))
  
  Pre.JF$BYEAR <- factor(Pre.JF$BYEAR, levels=c(2009:2017))
  Pre.JF$Hyear <- factor(Pre.JF$Hyear, levels=c(2009:2017))
  
  bnd.PreJF <- table(Pre.JF$Spp2, Pre.JF$BYEAR)
  rec.PreJF <- table(Pre.JF[c("Spp2","BYEAR", "Hyear")])
  nyrs <- length(unique(Pre.JF$BYEAR))
  not.recov <-matrix(0,nrow=3, ncol=nyrs) # not.recov should now be species by year
  for(s in 1:3){
    for(i in 1:nyrs){
      not.recov[s,i] <- bnd.PreJF[s,i] - sum(rec.PreJF[s,i,1:nyrs])
    }
  }
  
  recovmat.jf <- array(0, dim=c(3,nyrs,nyrs+1))
  recovmat.jf[,1:nyrs, 1:nyrs] <- rec.PreJF
  recovmat.jf[1:3,1:nyrs, (nyrs+1)] <- not.recov
  
  relmat.jf<-as.matrix(bnd.PreJF)
  
  #### Set up JAGS data and run species effect model! ####
  nyrs <- 9
  mod.parms <- c('S.am','S.af','S.jm','S.jf',
                 'f.am','f.af','f.jm','f.jf', 'mu')
  jags.data <-list(recovmat.am=recovmat.am, 
                   recovmat.af=recovmat.af,
                   recovmat.jm=recovmat.jm,
                   recovmat.jf=recovmat.jf,
                   relmat.am=relmat.am, 
                   relmat.af=relmat.af, 
                   relmat.jm=relmat.jm, 
                   relmat.jf=relmat.jf,
                   nyrs=nyrs,nspecies=3)
  mod.inits <- function (){list(f.am=matrix(runif(nyrs*3,0.05,0.2),nrow=3, ncol=nyrs),f.af=matrix(runif(nyrs*3,0.05,0.2),nrow=3, ncol=nyrs),f.jm=matrix(runif(nyrs*3,0.05,0.2),nrow=3, ncol=nyrs),f.jf=matrix(runif(nyrs*3,0.05,0.2),nrow=3, ncol=nyrs),
                                mu.am=matrix(rnorm((nyrs-1)*3,0,1.5),nrow=3, ncol=nyrs-1), mu.af=matrix(rnorm((nyrs-1)*3,0,1.5),nrow=3, ncol=nyrs-1),
                                mu.jm=matrix(rnorm((nyrs-1)*3,0,1.5),nrow=3, ncol=nyrs-1), mu.jf=matrix(rnorm((nyrs-1)*3,0,1.5),nrow=3, ncol=nyrs-1)
  )}
  # ^ Change inits - done

} else { # season = post
  ## Post AM  
  #ABDU.AM.Pre<-subset(mergeddata,Spp %in% sppvec & BSeason=="Pre" & cohort=="AM")
  Post.AM <- subset(mergeddata, Spp %in% sppvec &
                      BSeason == "Post" & 
                      cohort == "AM" &
                      BYEAR %in% c(2010:2017))
  
  Post.AM$BYEAR <- factor(Post.AM$BYEAR, levels=c(2010:2017))
  Post.AM$Hyear <- factor(Post.AM$Hyear, levels=c(2010:2017))
  
  bnd.PostAM <- table(Post.AM$Spp2, Post.AM$BYEAR)
  rec.PostAM <- table(Post.AM[c("Spp2","BYEAR", "Hyear")])
  nyrs <- length(unique(Post.AM$BYEAR))
  not.recovP <-matrix(0,nrow=3, ncol=nyrs) # not.recov should now be species by year
  for(s in 1:3){
    for(i in 1:nyrs){
      not.recovP[s,i] <- bnd.PostAM[s,i] - sum(rec.PostAM[s,i,1:nyrs])
    }
  }
  
  recovmatP.am <- array(0, dim=c(3,nyrs,nyrs+1))
  recovmatP.am[,1:nyrs, 1:nyrs] <- rec.PostAM
  recovmatP.am[1:3,1:nyrs, (nyrs+1)] <- not.recovP
  
  relmatP.am<-as.matrix(bnd.PostAM)
  
  #### Adult female ####
  ## Post AF  
  #ABDU.AF.Pre<-subset(mergeddata,Spp %in% sppvec & BSeason=="Pre" & cohort=="AF")
  Post.AF <- subset(mergeddata, Spp %in% sppvec &
                      BSeason == "Post" & 
                      cohort == "AF" &
                      BYEAR %in% c(2010:2017))
  
  Post.AF$BYEAR <- factor(Post.AF$BYEAR, levels=c(2010:2017))
  Post.AF$Hyear <- factor(Post.AF$Hyear, levels=c(2010:2017))
  
  bnd.PostAF <- table(Post.AF$Spp2, Post.AF$BYEAR)
  rec.PostAF <- table(Post.AF[c("Spp2","BYEAR", "Hyear")])
  nyrs <- length(unique(Post.AF$BYEAR))
  not.recovP <-matrix(0,nrow=3, ncol=nyrs) # not.recov should now be species by year
  for(s in 1:3){
    for(i in 1:nyrs){
      not.recovP[s,i] <- bnd.PostAF[s,i] - sum(rec.PostAF[s,i,1:nyrs])
    }
  }
  
  recovmatP.af <- array(0, dim=c(3,nyrs,nyrs+1))
  recovmatP.af[,1:nyrs, 1:nyrs] <- rec.PostAF
  recovmatP.af[1:3,1:nyrs, (nyrs+1)] <- not.recovP
  
  relmatP.af<-as.matrix(bnd.PostAF)
  
  #### Juvenile male ####
  ## Post JM  
  #ABDU.JM.Pre<-subset(mergeddata,Spp %in% sppvec & BSeason=="Pre" & cohort=="JM")
  Post.JM <- subset(mergeddata, Spp %in% sppvec &
                      BSeason == "Post" & 
                      cohort == "SYM" &
                      BYEAR %in% c(2010:2017))
  
  Post.JM$BYEAR <- factor(Post.JM$BYEAR, levels=c(2010:2017))
  Post.JM$Hyear <- factor(Post.JM$Hyear, levels=c(2010:2017))
  
  bnd.PostJM <- table(Post.JM$Spp2, Post.JM$BYEAR)
  rec.PostJM <- table(Post.JM[c("Spp2","BYEAR", "Hyear")])
  nyrs <- length(unique(Post.JM$BYEAR))
  not.recovP <-matrix(0,nrow=3, ncol=nyrs) # not.recov should now be species by year
  for(s in 1:3){
    for(i in 1:nyrs){
      not.recovP[s,i] <- bnd.PostJM[s,i] - sum(rec.PostJM[s,i,1:nyrs])
    }
  }
  
  recovmatP.jm <- array(0, dim=c(3,nyrs,nyrs+1))
  recovmatP.jm[,1:nyrs, 1:nyrs] <- rec.PostJM
  recovmatP.jm[1:3,1:nyrs, (nyrs+1)] <- not.recovP
  
  relmatP.jm<-as.matrix(bnd.PostJM)
  
  #### Juvenile female ####
  ## Post JF  
  #ABDU.JF.Pre<-subset(mergeddata,Spp %in% sppvec & BSeason=="Pre" & cohort=="JF")
  Post.JF <- subset(mergeddata, Spp %in% sppvec &
                      BSeason == "Post" & 
                      cohort == "SYF" &
                      BYEAR %in% c(2010:2017))
  
  Post.JF$BYEAR <- factor(Post.JF$BYEAR, levels=c(2010:2017))
  Post.JF$Hyear <- factor(Post.JF$Hyear, levels=c(2010:2017))
  
  bnd.PostJF <- table(Post.JF$Spp2, Post.JF$BYEAR)
  rec.PostJF <- table(Post.JF[c("Spp2","BYEAR", "Hyear")])
  nyrs <- length(unique(Post.JF$BYEAR))
  not.recovP <-matrix(0,nrow=3, ncol=nyrs) # not.recov should now be species by year
  for(s in 1:3){
    for(i in 1:nyrs){
      not.recovP[s,i] <- bnd.PostJF[s,i] - sum(rec.PostJF[s,i,1:nyrs])
    }
  }
  
  recovmatP.jf <- array(0, dim=c(3,nyrs,nyrs+1))
  recovmatP.jf[,1:nyrs, 1:nyrs] <- rec.PostJF
  recovmatP.jf[1:3,1:nyrs, (nyrs+1)] <- not.recovP
  
  relmatP.jf<-as.matrix(bnd.PostJF)
  
  #### Set up JAGS model ####
  nyrs <- 9
  mod.parms <- c('S.am','S.af','S.jm','S.jf',
                 'f.am','f.af', 'mu')
  jags.data <-list(recovmatP.am=recovmatP.am, 
                   recovmatP.af=recovmatP.af,
                   recovmatP.jm=recovmatP.jm,
                   recovmatP.jf=recovmatP.jf,
                   relmatP.am=relmatP.am, 
                   relmatP.af=relmatP.af, 
                   relmatP.jm=relmatP.jm, 
                   relmatP.jf=relmatP.jf,
                   nyrs=nyrs, nspecies=3)
  
  mod.inits <- function (){list(f.am=matrix(runif((nyrs-1)*3,0.05,0.2),nrow=3, ncol=nyrs-1),f.af=matrix(runif((nyrs-1)*3,0.05,0.2),nrow=3, ncol=nyrs-1),
                                mu.am=matrix(rnorm((nyrs-2)*3,0,1.5),nrow=3, ncol=nyrs-2), mu.af=matrix(rnorm((nyrs-2)*3,0,1.5),nrow=3, ncol=nyrs-2),
                                mu.jm=matrix(rnorm((nyrs-2)*3,0,1.5),nrow=3, ncol=nyrs-2), mu.jf=matrix(rnorm((nyrs-2)*3,0,1.5),nrow=3, ncol=nyrs-2)
  )}
}
  
  runjags.out <- run.jags(model = jagsmodel, monitor = c(mod.parms),
                          data = jags.data, n.chains = 3, inits = mod.inits,burnin = 200000, sample = 5000, 
                          summarise=TRUE,method='rjparallel',keep.jags.files = FALSE)
  sims.obj <- add.summary(runjags.out)
  sim.sum <- data.frame(sims.obj$summaries)
  
  return(list(jagsobj=runjags.out, resultssum=sim.sum))
}
